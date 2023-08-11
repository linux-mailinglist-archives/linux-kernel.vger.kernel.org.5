Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065D6779330
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjHKPdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbjHKPd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:33:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77084E53;
        Fri, 11 Aug 2023 08:33:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RMnqx5rgvz67GC0;
        Fri, 11 Aug 2023 23:33:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 11 Aug
 2023 16:33:25 +0100
Date:   Fri, 11 Aug 2023 16:33:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 1/2] iio: dac: ad5755: mark OF related data as maybe
 unused
Message-ID: <20230811163324.00003b3c@Huawei.com>
In-Reply-To: <20230810111933.205619-1-krzysztof.kozlowski@linaro.org>
References: <20230810111933.205619-1-krzysztof.kozlowski@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 13:19:32 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> When compile tested with W=1 on x86_64 with driver as built-in:
> 
>   ad5755.c:866:34: error: unused variable 'ad5755_of_match' [-Werror,-Wunused-const-variable]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I'd rather see the table used as relying on the fallback path via the spi_match_id table
is fragile as two tables may not have equivalent entries in the long run.
Entry missing in the spi_driver.driver structure.

Bonus points for adding the match data to the of table and making them all pointers
there and in spi_device_id table + using spi_get_device_match_data()

Jonathan


> ---
>  drivers/iio/dac/ad5755.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 404865e35460..823049ce2686 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -863,7 +863,7 @@ static const struct spi_device_id ad5755_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, ad5755_id);
>  
> -static const struct of_device_id ad5755_of_match[] = {
> +static const struct of_device_id ad5755_of_match[] __maybe_unused = {
>  	{ .compatible = "adi,ad5755" },
>  	{ .compatible = "adi,ad5755-1" },
>  	{ .compatible = "adi,ad5757" },

