Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBFA7AB2DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjIVNmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjIVNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:42:22 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86967195
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:42:16 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BED6F40E01AC;
        Fri, 22 Sep 2023 13:42:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eBn7QlVu5tOr; Fri, 22 Sep 2023 13:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695390132; bh=YP/GpBaY3aJ3tL35B85TIBU2s0KkU0hbtRyFI9Ecda0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFtPNWapK5HnoRZVwOurOhvDdloKFJnED+Y+eAShLa7SJaJapLEXbE0LV3gCgSXkA
         sjQuY9YGxRllFMICUa2mdzWF2FbdcB1lk1X5fq7XnCancG4Ni998bonb84kQmF2iAr
         BVgU64PuGmgo4mB0rQ2hLUYhb8prnLHpMNPzKZM3wnSTjmdHEbqlCQns4h8RRt9bIF
         SJqZiBFj2leOPiB9vLUsmY7lYooSU9AWVidkNh4JEaeEKmBbDPYdzhYLC4VAXGFyjN
         QuAy3Ho8BFyDoWfgb4Tfj34aOTdzV9RnncvbGVrma1BtgOkCPwqUwAu8EVJjj2/HgG
         AXChfsLsqDgsoGGPdPREecrMXBBbODtN0rb+olvFt2cgw+ykcuVkSFjUgNyRzL2p69
         F0Z8d3C1CIjjehzrdkZG2H5MpSbysvS4Gq/FJ5kfwa6F/WOaQr/9Ytpjscfz2zDub+
         2my3XeEp/sbG9oauwMaiRePz7Ti3OoU06Jc+I1dIVKVoA2Y2mnZUxsAvp1kk7UmdNI
         2m0fYSc0Iz5Hk6DTjC2P3w686czElvvXEGpwtXnKS0FKXGVTI3J/5B20Rt44Il8z78
         K5mOdCuVWaKRRQg4Op0oASjKMvAynNaCoyfHlPX0/Ge7MNo/xGnZhVLhRsUVvlTaAi
         Boa31w1iofHvULqUs22zpFDw=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 044C240E01A1;
        Fri, 22 Sep 2023 13:42:05 +0000 (UTC)
Date:   Fri, 22 Sep 2023 15:42:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 18/30] x86/microcode: Handle "nosmt" correctly
Message-ID: <20230922134200.GIZQ2ZqKbKM/bZHbQ4@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.899886649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065501.899886649@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just textual nitpicks. Otherwise looks nice.

On Tue, Sep 12, 2023 at 09:58:12AM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> On CPUs where microcode loading is not NMI safe the SMT sibling which is
> parked in one of the play_dead() variants, these parked CPUs still react
> on NMIs.

s/, these parked CPUs still react/still reacts/.

Simpler.

> So if a NMI hits while the primary thread updates the microcode
> the resulting behaviour is undefined. The default play_dead()
> implementation on modern CPUs is using MWAIT, which is not guaranteed to
> be safe against an microcode update which affects MWAIT.

s/an //

> +/*
> + *  Ensure that all required CPUs which are present and have been booted
> + *  once are online.
> + *
> + *    To pass this check, all primary threads must be online.
> + *
> + *    If the microcode load is not safe against NMI then all SMT threads
> + *    must be online as well because they still react on NMI when they are

s/react on NMI/react to NMIs/

> + *    soft-offlined and parked in one of the play_dead() variants. So if a
> + *    NMI hits while the primary thread updates the microcode the resulting
> + *    behaviour is undefined. The default play_dead() implementation on
> + *    modern CPUs is using MWAIT, which is also not guaranteed to be safe

s/is using/uses/

> --- a/arch/x86/kernel/cpu/microcode/internal.h
> +++ b/arch/x86/kernel/cpu/microcode/internal.h
> @@ -20,18 +20,17 @@ enum ucode_state {
>  
>  struct microcode_ops {
>  	enum ucode_state (*request_microcode_fw)(int cpu, struct device *dev);
> -
>  	void (*microcode_fini_cpu)(int cpu);
>  
>  	/*
> -	 * The generic 'microcode_core' part guarantees that
> -	 * the callbacks below run on a target cpu when they
> -	 * are being called.
> +	 * The generic 'microcode_core' part guarantees that the callbacks
> +	 * below run on a target cpu when they are being called.

s/cpu/CPU/

while at it.

>  	 * See also the "Synchronization" section in microcode_core.c.
>  	 */
> -	enum ucode_state (*apply_microcode)(int cpu);
> -	int (*collect_cpu_info)(int cpu, struct cpu_signature *csig);
> -	void (*finalize_late_load)(int result);
> +	enum ucode_state	(*apply_microcode)(int cpu);
> +	int			(*collect_cpu_info)(int cpu, struct cpu_signature *csig);
> +	void			(*finalize_late_load)(int result);
> +	unsigned int		nmi_safe	: 1;
>  };

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
