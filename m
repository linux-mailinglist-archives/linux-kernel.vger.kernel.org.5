Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5AA7B4F08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjJBJ16 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 05:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjJBJ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:27:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2A183;
        Mon,  2 Oct 2023 02:27:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzbDT4GGgz6K63t;
        Mon,  2 Oct 2023 17:26:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 10:27:46 +0100
Date:   Mon, 2 Oct 2023 10:27:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device'
 error
Message-ID: <20231002102745.0000540b@Huawei.com>
In-Reply-To: <20231001-ak_magnetometer-v1-1-09bf3b8798a3@apitzsch.eu>
References: <20231001-ak_magnetometer-v1-1-09bf3b8798a3@apitzsch.eu>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2023 18:09:56 +0200
André Apitzsch <git@apitzsch.eu> wrote:

> Explicity specify array indices to fix mapping between
> asahi_compass_chipset and ak_def_array.
> While at it, remove unneeded AKXXXX.
> 
> Fixes: 4f9ea93afde1 ("iio: magnetometer: ak8975: Convert enum->pointer for data in the match tables")
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  drivers/iio/magnetometer/ak8975.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 8cfceb007936..dd466c5fa621 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -204,7 +204,6 @@ static long ak09912_raw_to_gauss(u16 data)
>  
>  /* Compatible Asahi Kasei Compass parts */
>  enum asahi_compass_chipset {
> -	AKXXXX		= 0,

When we see this 'spacer' it is normally there to avoid a
confusion between 'not defined' and set too the first element.

So look at device_get_match_data() implementation and how we tell
if it worked.  That will return 0 if we have an AK8975 which is
then detected as a failure to match. 

https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/iio/magnetometer/ak8975.c#L932

So we need the spacer until someone converts this driver to use
pointers instead for both of and ACPI tables. I also don't like that
the of path here is falling back to the i2c_device_id match.

The data should be set in ak8975_of_match[] as well.

Jonathan

>  	AK8975,
>  	AK8963,
>  	AK09911,
> @@ -248,7 +247,7 @@ struct ak_def {
>  };
>  
>  static const struct ak_def ak_def_array[] = {
> -	{
> +	[AK8975] = {
>  		.type = AK8975,
>  		.raw_to_gauss = ak8975_raw_to_gauss,
>  		.range = 4096,
> @@ -273,7 +272,7 @@ static const struct ak_def ak_def_array[] = {
>  			AK8975_REG_HYL,
>  			AK8975_REG_HZL},
>  	},
> -	{
> +	[AK8963] = {
>  		.type = AK8963,
>  		.raw_to_gauss = ak8963_09911_raw_to_gauss,
>  		.range = 8190,
> @@ -298,7 +297,7 @@ static const struct ak_def ak_def_array[] = {
>  			AK8975_REG_HYL,
>  			AK8975_REG_HZL},
>  	},
> -	{
> +	[AK09911] = {
>  		.type = AK09911,
>  		.raw_to_gauss = ak8963_09911_raw_to_gauss,
>  		.range = 8192,
> @@ -323,7 +322,7 @@ static const struct ak_def ak_def_array[] = {
>  			AK09912_REG_HYL,
>  			AK09912_REG_HZL},
>  	},
> -	{
> +	[AK09912] = {
>  		.type = AK09912,
>  		.raw_to_gauss = ak09912_raw_to_gauss,
>  		.range = 32752,
> @@ -348,7 +347,7 @@ static const struct ak_def ak_def_array[] = {
>  			AK09912_REG_HYL,
>  			AK09912_REG_HZL},
>  	},
> -	{
> +	[AK09916] = {
>  		.type = AK09916,
>  		.raw_to_gauss = ak09912_raw_to_gauss,
>  		.range = 32752,
> 
> ---
> base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
> change-id: 20231001-ak_magnetometer-b063098082dd
> 
> Best regards,

