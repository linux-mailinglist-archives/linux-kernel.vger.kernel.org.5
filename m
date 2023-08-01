Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555AF76B4EB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjHAMlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjHAMlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:41:01 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD3A8;
        Tue,  1 Aug 2023 05:40:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31AEB1C0006;
        Tue,  1 Aug 2023 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690893657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3Hw1gMaiWhoQKKZK2hbOYHO2XGGZMLV2/iOs78dLbs=;
        b=fCbAQl2f6bVcczNsiSn20w0R4GSWTzdJtsvxoT8oJuXqRxwzubrCHgT+dTC8KuMsN/hXU4
        qjlgxD280xtPjU+jrd2UCTJlV2evSae4wIrOFEyZNn49zO/2T1Hwl9Dq8k6YYf7Qw5pL2f
        2/rgab5/Th6Ca1Sfi6jYkxMHsyMZcRFIubPVoSYgZ+Ondr0OweFT7yzlxUNHpySUpaish4
        6OK5Hl9YRdThPKmAw0gw5QPio3MahcKkEQ50c/34jJ4Z4TVK+xVHa2t91fGe4w2Q8DZfux
        ITpMoDX82JKsI2twWhwnEyjxywVLbcY0ZIz9NXGerqpMn7nOBLqJzhNJKWgDuA==
Date:   Tue, 1 Aug 2023 14:40:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anvesh Jain P <quic_ajainp@quicinc.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>
Subject: Re: [PATCH] rtc: rtc-pm8xxx: control default alarm wake up capability
Message-ID: <20230801124056fc665814@mail.local>
References: <20230801114549.26956-1-quic_ajainp@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801114549.26956-1-quic_ajainp@quicinc.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 17:15:49+0530, Anvesh Jain P wrote:
> Enable & disable rtc alarm wake up capability based on
> default parameter passed from device tree.
> 

I see what you are doing but not why this is necessary, NAK.

> Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index f6b779c12ca7..bed57be602b6 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -523,6 +523,9 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	if (of_property_read_bool(pdev->dev.of_node, "disable-alarm-wakeup"))
> +		device_set_wakeup_capable(&pdev->dev, false);
> +
>  	rc = dev_pm_set_wake_irq(&pdev->dev, rtc_dd->alarm_irq);
>  	if (rc)
>  		return rc;
> 
> base-commit: 0a8db05b571ad5b8d5c8774a004c0424260a90bd
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
