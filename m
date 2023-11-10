Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F777E838D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344606AbjKJUOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKJUOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:14:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E771344B3;
        Fri, 10 Nov 2023 12:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699647268; x=1731183268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3tVJsMHXywNdu/lxHtHGdXO/ugKIDxyuytYpSVUfKts=;
  b=yspVliIEvC72nf4ymJFr8xgS/GAWLOuvkFBgoHVOi30hgX1Nt4uysqv5
   Irf6T8MKuOONJvZa96PMFaQ1kw+PyHubwbZgXX9Lt6r6VRS1MBJnCGbHC
   mSgcS3P/fJShA/RoAuXU9FQSGK3obrFFg06TQgwjS5B8wDy2inpiq67V3
   SMQlTkNLkpDk+q4hF4m64s2qFkRTQrzgsyMuJ96crS+19mOnsnNG/2eBE
   X2yNwFJeRbWDEYoL5YpAlNiQQbBq5KfLhrg4k5INjO8WH3APYsZFtKta0
   0oeKnBcRQDOLc7NBdNJtiE2rsYkRj6o8G2OXnHSP2+VKESjJjASdJ7Lub
   Q==;
X-CSE-ConnectionGUID: 0pnlH8zCQBubqT4ZdDxfxw==
X-CSE-MsgGUID: AfSEwpGkSOCGbhn+rfs0fA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="11796744"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2023 13:14:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Nov 2023 13:13:46 -0700
Received: from [10.171.248.20] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 10 Nov 2023 13:13:44 -0700
Message-ID: <4d505dd3-b289-4191-95f2-4a6eaa647e81@microchip.com>
Date:   Fri, 10 Nov 2023 21:13:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: atmel-mci: Use common error handling code in
 atmci_of_init()
Content-Language: en-US, fr
To:     Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
CC:     <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
References: <c70c100a-ebfd-442e-875f-738593faf0dc@web.de>
From:   Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <c70c100a-ebfd-442e-875f-738593faf0dc@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2023 16:50, Markus Elfring wrote:
> Add a jump target so that a bit of exception handling can be better
> reused at the end of this function.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Aubin Constans <aubin.constans@microchip.com>

> ---
>   drivers/mmc/host/atmel-mci.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index dba826db739a..1e83119d1dcb 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -675,10 +675,9 @@ atmci_of_init(struct platform_device *pdev)
>                                                "cd", GPIOD_IN, "cd-gpios");
>                  err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].detect_pin);
>                  if (err) {
> -                       if (err != -ENOENT) {
> -                               of_node_put(cnp);
> -                               return ERR_PTR(err);
> -                       }
> +                       if (err != -ENOENT)
> +                               goto put_node;
> +
>                          pdata->slot[slot_id].detect_pin = NULL;
>                  }
> 
> @@ -690,15 +689,18 @@ atmci_of_init(struct platform_device *pdev)
>                                                "wp", GPIOD_IN, "wp-gpios");
>                  err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].wp_pin);
>                  if (err) {
> -                       if (err != -ENOENT) {
> -                               of_node_put(cnp);
> -                               return ERR_PTR(err);
> -                       }
> +                       if (err != -ENOENT)
> +                               goto put_node;
> +
>                          pdata->slot[slot_id].wp_pin = NULL;
>                  }
>          }
> 
>          return pdata;
> +
> +put_node:
> +       of_node_put(cnp);
> +       return ERR_PTR(err);
>   }
>   #else /* CONFIG_OF */
>   static inline struct mci_platform_data*
> --
> 2.42.0
> 

Best regards,
Aubin
