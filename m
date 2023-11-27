Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0407FA345
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjK0OoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjK0OoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:44:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC409A3;
        Mon, 27 Nov 2023 06:44:09 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2F22A1FD66;
        Mon, 27 Nov 2023 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701096247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/EIUmcxqSgQwR4h8SpanHMweNQIyGH/GNtp1VB6r9BU=;
        b=Wi/9CQiV+1JjyObULZrfGvMIUo08Fe24MCed3hduQTi9M1+j2YbDl7R/VBbhjm6AOrnDnX
        Pjb3F66pw9WOH5HBSlg1Y70VR+D+atS5eU4h7JRDPQjE/c9DjBHh5C44OvWz07QVHzmGuB
        q1btyyvK0QLgIcK9VEcp3W6nfXLwgvU=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6F0962C16B;
        Mon, 27 Nov 2023 14:44:04 +0000 (UTC)
Date:   Mon, 27 Nov 2023 15:44:03 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        pbonzini@redhat.com, wanpengli@tencent.com, vkuznets@redhat.com,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        akpm@linux-foundation.org, peterz@infradead.org,
        dianders@chromium.org, npiggin@gmail.com,
        rick.p.edgecombe@intel.com, joao.m.martins@oracle.com,
        juerg.haefliger@canonical.com, mic@digikod.net, arnd@arndb.de,
        ankur.a.arora@oracle.com
Subject: Re: [PATCH 1/7] x86: Move ARCH_HAS_CPU_RELAX to arch
Message-ID: <ZWSrMzHEbdynTA8A@alley>
References: <1700488898-12431-1-git-send-email-mihai.carabas@oracle.com>
 <1700488898-12431-2-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700488898-12431-2-git-send-email-mihai.carabas@oracle.com>
X-Spamd-Bar: +++++++++++++++++++++
X-Spam-Score: 21.50
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        spf=fail (smtp-out2.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 2F22A1FD66
X-Spamd-Result: default: False [21.50 / 50.00];
         RDNS_NONE(1.00)[];
         SPAMHAUS_XBL(0.00)[149.44.160.134:from];
         TO_DN_SOME(0.00)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         R_RATELIMIT(0.00)[ip(RLkk1mdgxgu4i4849a6y),rip(RLa6h5sh378tcam5q78u)];
         MX_GOOD(-0.01)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.00)[13.92%];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         VIOLATED_DIRECT_SPF(3.50)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         RCPT_COUNT_TWELVE(0.00)[27];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,arm.com,kernel.org,linutronix.de,redhat.com,alien8.de,zytor.com,tencent.com,linaro.org,linux-foundation.org,infradead.org,chromium.org,gmail.com,intel.com,oracle.com,canonical.com,digikod.net,arndb.de];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-11-20 16:01:32, Mihai Carabas wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> ARM64 is going to use it for haltpoll support (for poll-state)
> so move the definition to be arch-agnostic and allow architectures
> to override it.

This says that the definition is moved.

> diff --git a/arch/Kconfig b/arch/Kconfig
> index 4a85a10b12fd..92af0e9bc35e 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1371,6 +1371,9 @@ config RELR
>  config ARCH_HAS_MEM_ENCRYPT
>  	bool
>  
> +config ARCH_HAS_CPU_RELAX
> +	bool
> +
>  config ARCH_HAS_CC_PLATFORM
>  	bool
>  
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d1c362f479d9..0c77670d020e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -73,6 +73,7 @@ config X86
>  	select ARCH_HAS_CACHE_LINE_SIZE
>  	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>  	select ARCH_HAS_CPU_FINALIZE_INIT
> +	select ARCH_HAS_CPU_RELAX
>  	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE

But the definion is only added here.

I would expect that the patch also removes the original definion.


Best Regards,
Petr
