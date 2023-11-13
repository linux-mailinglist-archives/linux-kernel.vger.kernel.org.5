Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955047E9920
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjKMJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjKMJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:38:20 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E038210D0;
        Mon, 13 Nov 2023 01:38:16 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 216AA40E0032;
        Mon, 13 Nov 2023 09:38:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yDn-4aWbgcao; Mon, 13 Nov 2023 09:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699868290; bh=pvZneiKXZP1AFwrVjpjgX9SfPXvcKcXDRiBYzBlWCUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZ7yBNVNpQh+FSzVVPUvU1KiPOgYrTKreyHA8+5W4D1e1NVGVZU6gh4GtZqYjwac5
         7mXHFs8411yRJlwvUxdWXR4tVSMr2V05ppNWa2jneFjQ76RZ8AiWkt0PTe9lQg53x8
         StmLiD/0my+6PMYw1LCK/P7zdWALpzfMYgh1fVSmK/x+RNi+xjdK7e9F4pHZSH9V4N
         //0C5YpGFuES/WJNPnwTymvdqteTiiXiFmAosHN3nDMvoaVE23uyvrUDBPYlXRZ2yC
         zo/XBmjZafaL7zOQg8nuRRUMiWXsD3y/jtAA3OYjU1gzm+jLuEZk790OjLEW6BxlOV
         PXMHE1ijr3rLunuaIe7wPDDckNuNcoWSlSjqaWjx3LQIC2/5bMXHEplkpaONiNXnU+
         QLatLdlOoS0pqZJyyPEbMxm5Wrd5YQgTBx+RitlTVRTngSD/EyTPSPMFfwy30fjvs4
         Ar55249kf9xxyEytyXCGcLBLIEGKahsFxSMl4aZujzNDDFedLNWet7qfiEmBEcMKA7
         KY0o7bJF/2doThAtRXGMIWrb22pt8N88EcVVC99JIy6ziyh+gT7GxewGFeNSQhOJqz
         LjbBfNVJw03e/S7CKwwgYIN6BgSrxS4DQA9buYUX3Z8XPsMTypEr9l2BooGtvGdtxZ
         TSsh+cXS+Iag9abKXKBGqaBU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96E9040E0171;
        Mon, 13 Nov 2023 09:37:48 +0000 (UTC)
Date:   Mon, 13 Nov 2023 10:37:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        pbonzini@redhat.com, seanjc@google.com, peterz@infradead.org,
        jgross@suse.com, ravi.v.shankar@intel.com, mhiramat@kernel.org,
        andrew.cooper3@citrix.com, jiangshanlai@gmail.com,
        nik.borisov@suse.com
Subject: Re: [PATCH v12 19/37] x86/fred: Update MSR_IA32_FRED_RSP0 during
 task switch
Message-ID: <20231113093742.GAZVHuZk9CGTRIfAWb@fat_crate.local>
References: <20231003062458.23552-1-xin3.li@intel.com>
 <20231003062458.23552-20-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003062458.23552-20-xin3.li@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:24:40PM -0700, Xin Li wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> MSR_IA32_FRED_RSP0 is used during ring 3 event delivery, and needs to
> be updated to point to the top of next task stack during task switch.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
>  arch/x86/include/asm/switch_to.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
> index f42dbf17f52b..c3bd0c0758c9 100644
> --- a/arch/x86/include/asm/switch_to.h
> +++ b/arch/x86/include/asm/switch_to.h
> @@ -70,9 +70,13 @@ static inline void update_task_stack(struct task_struct *task)
>  #ifdef CONFIG_X86_32
>  	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
>  #else
> -	/* Xen PV enters the kernel on the thread stack. */
> -	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> +	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
> +		/* WRMSRNS is a baseline feature for FRED. */
> +		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_SIZE);

If this non-serializing write happens now and, AFAICT, the CR3 write
during the task switch has already happened in switch_mm* earlier, what
is the serialization point that's going to make sure that write is
committed before the new task starts executing?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
