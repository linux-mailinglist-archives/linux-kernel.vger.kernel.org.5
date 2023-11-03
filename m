Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CF77E0566
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjKCPRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKCPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:16:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417FDD47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:16:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMPQW587bz67SFp;
        Fri,  3 Nov 2023 23:13:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 15:16:52 +0000
Date:   Fri, 3 Nov 2023 15:16:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>
CC:     <minyard@acm.org>, <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <aladyshev22@gmail.com>,
        <jk@codeconstruct.com.au>
Subject: Re: [PATCH 05/10] ipmi: kcs_bmc: Define client actions in terms of
 kcs_bmc_client
Message-ID: <20231103151651.000045ae@Huawei.com>
In-Reply-To: <20231103061522.1268637-6-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
        <20231103061522.1268637-6-andrew@codeconstruct.com.au>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Nov 2023 16:45:17 +1030
Andrew Jeffery <andrew@codeconstruct.com.au> wrote:

> Operations such as reading and writing from hardware and updating the
> events of interest are operations in which the client is interested, but
> are applied to the device. Strengthen the concept of the client in the
> subsystem and clean up some call-sites by translating between the client
> and device types in the core of the KCS subsystem.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  drivers/char/ipmi/kcs_bmc.c           | 67 ++++++++++++++++++---------
>  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 50 ++++++++++----------
>  drivers/char/ipmi/kcs_bmc_client.h    | 15 +++---
>  drivers/char/ipmi/kcs_bmc_serio.c     | 10 ++--
>  4 files changed, 81 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> index 5a3f199241d2..d70e503041bd 100644
> --- a/drivers/char/ipmi/kcs_bmc.c
> +++ b/drivers/char/ipmi/kcs_bmc.c
> @@ -22,33 +22,53 @@ static LIST_HEAD(kcs_bmc_drivers);
>  
>  /* Consumer data access */
>  
> -u8 kcs_bmc_read_data(struct kcs_bmc_device *kcs_bmc)
> +static void kcs_bmc_client_validate(struct kcs_bmc_client *client)
>  {
> -	return kcs_bmc->ops->io_inputb(kcs_bmc, kcs_bmc->ioreg.idr);
> +	WARN_ONCE(client != READ_ONCE(client->dev->client), "KCS client confusion detected");

Is this intended as runtime validation or to catch bugs?
If just catch bugs then fair enough.

With that question answered based on my somewhat vague understanding of the kcs subsystem.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +}

