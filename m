Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B336D7710DD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjHERRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjHERR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A7B44B0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 10:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A3C860B58
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 17:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826CCC433C8;
        Sat,  5 Aug 2023 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691255826;
        bh=AOpLCYFW168ND86mxqBnQZPc5+390+3vfxj/HBFuURo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rpCCU5Hgwsc+2UH+IR8bzAzCGvstNbtn0pPpFEePLtrTZ1DSYYjBxu++AdFZ/2+Sf
         mi66iY7YKFb6UUfVcGim68NwGO97aREeP8VT+vDP8hpIBoKiGXZucb6ymgZN1kfK53
         2Bxo0Uqguq6RZG4vm4VS5GZXxV3bMo9aUP/Swidc=
Date:   Sat, 5 Aug 2023 10:17:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     dianders@chromium.org, pmladek@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog/hardlockup: set watchdog_hardlockup_warned to
 true as early as possible
Message-Id: <20230805101705.3a38ce9aacc924f1c9f0842b@linux-foundation.org>
In-Reply-To: <20230805160144.121875-1-liusong@linux.alibaba.com>
References: <20230805160144.121875-1-liusong@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  6 Aug 2023 00:01:44 +0800 Liu Song <liusong@linux.alibaba.com> wrote:

> Since we want to ensure only printing hardlockups once, it is necessary
> to set "watchdog_hardlockup_warned" to true as early as possible.
> 
> ...
>
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -180,6 +180,8 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
>  		/* Only print hardlockups once. */
>  		if (per_cpu(watchdog_hardlockup_warned, cpu))
>  			return;
> +		else
> +			per_cpu(watchdog_hardlockup_warned, cpu) = true;

The "else" is unneeded.
  
>  		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", cpu);
>  		print_modules();
> @@ -206,8 +208,6 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
>  
>  		if (hardlockup_panic)
>  			nmi_panic(regs, "Hard LOCKUP");
> -
> -		per_cpu(watchdog_hardlockup_warned, cpu) = true;
>  	} else {
>  		per_cpu(watchdog_hardlockup_warned, cpu) = false;
>  	}

When resending, please tell us some more about the effects of the
change.  Presumably there are circumstances in which excess output is
produced?  If so, describe these circumstances and the observed
effects.

