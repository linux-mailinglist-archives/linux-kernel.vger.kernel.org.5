Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AB5758024
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjGROwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjGROwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:52:06 -0400
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA4013E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=wWgPiAi3r8Uoj6fgS4VBko5gDpbk+heLZMX3BKMQnlc=;
        b=cYwVBLk6x0dNlQ4TwuImlDXzw18490N+Yox9cRihC1zTZof+5fPoklBQcV6A5UKayINuug7gpms8r
         iSzJsRqixhfuDjC6wGdcQ4fW/PFcxSYQrQSK9sue1TjjdEvRKg1znE+QYnz//NF1Wf7THit/7+Ef+9
         OiitKePAso/MmQrVAIUToMqaNKoEULTFjtFuY/spxBNVFkoOK5QrkBkxQn/Tv+sr6qbYQtrHzn7BoH
         PLmHye7gdsIvBud7I/yKbDI9hILqCVuDPSRvqN5rUlGBi10LivIIAXMT30DHlZ/4XkiuaVF0tt2HTz
         rSHuqrn1NKZsJUHZFbZPDEZVvgU38dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=wWgPiAi3r8Uoj6fgS4VBko5gDpbk+heLZMX3BKMQnlc=;
        b=OknKNSAp+MRCUvmmDY0cbgkV2AP6UmhzWS72S/lediTvmLzNmqyomBbf6fUftbyLJWoYwov23wYrS
         J6qCCFGCQ==
X-HalOne-ID: 827803b1-257a-11ee-b422-55333ba73462
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id 827803b1-257a-11ee-b422-55333ba73462;
        Tue, 18 Jul 2023 14:51:01 +0000 (UTC)
Date:   Tue, 18 Jul 2023 16:51:00 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     sunran001@208suo.com
Cc:     davem@davemloft.net, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] floppy: add missing put_device()
Message-ID: <20230718145100.GA688726@ravnborg.org>
References: <20230718090203.17548-1-xujianghui@cdjrlc.com>
 <8d2649460d95597d2d4de3777b2043f7@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d2649460d95597d2d4de3777b2043f7@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ran Sun,

On Tue, Jul 18, 2023 at 05:02:54PM +0800, sunran001@208suo.com wrote:
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> 
> ./arch/sparc/include/asm/floppy_64.h:562:1-22: WARNING: Function
> "for_each_node_by_name" should have of_node_put() before break around
> line 567.
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  arch/sparc/include/asm/floppy_64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/include/asm/floppy_64.h
> b/arch/sparc/include/asm/floppy_64.h
> index 53e77c0974f9..619255e8c9ac 100644
> --- a/arch/sparc/include/asm/floppy_64.h
> +++ b/arch/sparc/include/asm/floppy_64.h
> @@ -594,7 +594,7 @@ static unsigned long __init sun_floppy_init(void)
>          if (state_prop && !strncmp(state_prop, "disabled", 8)) {
>              put_device(&op->dev);
>              return 0;
> -        }
> +        }
> 
>          FLOPPY_IRQ = op->archdata.irqs[0];

The patch does not include any changes. Please redo.

	Sam

