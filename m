Return-Path: <linux-kernel+bounces-110918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38988865A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD27EB236D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9957C122;
	Fri, 22 Mar 2024 03:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ftfhA7uM"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494CBBE4B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711079609; cv=none; b=gH2/WJgkTYWGo2eQDpNHmXZdbYqZ92IOGMMK8ebUC/eFFrFgtHYTU/Hb14xJjfGX4hcMhluNQM3mk4EOBJNVHdq4eFpRs2QmAwVk7WEYRCdvliZEMBPQBmGF0EexIQsbVdcC84KMdpobkubTqeO0X7Fw/GjbUk9f+l5X6mU9xR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711079609; c=relaxed/simple;
	bh=khGq0+ZmZFLMVL0aXsjoH0lpg8FPMH55OjBwEzdFfjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOZ+XDHkzr5JvYUMKnGA6f0a1ulfZuEaO6cpkxNOv90nMxpw+6xzglXLF+FYYJOlRZcWX+FdVm9vLhb6GQZ+QTs7d+CR94w1BCdIAVlM6+R9rShyM3PwgR2J/X4xv9/8RYTS9Lokkr7OKOoEhTlrw0SUKwOvsy1rnerhB0q+Tuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ftfhA7uM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so1078052a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711079606; x=1711684406; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mDi7jYxaJ9l+KBr/OHl27LOvhUXGML1wd1U7ONJ3R9g=;
        b=ftfhA7uMDrNsmwHpOXoy2wpmSW0m3dgxtgK5NiOZy2+wnhNtoEUczvj9CRDKdrifuG
         rZ41KY5tgxo6aDGDrcgPRCwCFHU9smYsTOZmu6GZdi8mwoUOHRNIPvsBgtunb9CRWKRo
         AIl8VJ9bNqKUQiBW/RqcFMHgIQFx1WSu4yehg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711079606; x=1711684406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDi7jYxaJ9l+KBr/OHl27LOvhUXGML1wd1U7ONJ3R9g=;
        b=ku9s5gkoySdQP8Cv2q2t5eUtIXpI6/kR80tfqBIFxob1jrkw2p5iwXGiocnkawQBkN
         0/befSk52VmIA9675+NRBB1ksgYlxJuUqlHPdgbvUfqzgNlDwLhwTFyMM8oq3tP5xmbj
         4vVE8r95yrHmxxm3xZrJ//yAENwKmq2lINVeK5ytWlTW5nAXoV9kvF2qQzQFRY/vmU0V
         Tr0F3+n9qK329iOdEY9iiFuD8NimSDX0z6B9/F4KjU3MKZTALTpfkVFVcLXw7n2+fTpC
         z2YJrbRb0CSQxc/HYPxL7Rmjag/BC0lD4+mL3InJlnMPYcyUQ4HCoX/+J3EhtS1guHuS
         NjEA==
X-Gm-Message-State: AOJu0YzElziLsC+WRg1/zAFhvk4F68auenYOCITAGNkJuGUN0I65OIH0
	cus5Et6pEajIQt4cbxC2ZGZBmVbVHshap6ZQL2S2W6t+KVNpCRx/iqcjsXCPyvW7paLr+DBQKlw
	=
X-Google-Smtp-Source: AGHT+IEPtsYWgPg/WZkii4z9qiUUkjOuefnGilZT+nf3dukXjrJpHFNordVwWK4Jzptl7XhBimQxVw==
X-Received: by 2002:a05:6a20:9151:b0:1a3:59ac:a626 with SMTP id x17-20020a056a20915100b001a359aca626mr1814803pzc.41.1711079284701;
        Thu, 21 Mar 2024 20:48:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090ae00200b0029c693a1e6dsm782334pjy.17.2024.03.21.20.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 20:48:04 -0700 (PDT)
Date: Thu, 21 Mar 2024 20:48:03 -0700
From: Kees Cook <keescook@chromium.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Rich Felker <dalias@libc.org>, stable@vger.kernel.org
Subject: Re: [PATCH] exec: fix linux_binprm::exec in transfer_args_to_stack()
Message-ID: <202403212041.AEB471AC@keescook>
References: <20240320182607.1472887-1-jcmvbkbc@gmail.com>
 <202403211004.19F5EE27F@keescook>
 <CAMo8Bf+jbsnok=zy3gT2Z-F8=LCMVVFhAoiJ8sjwaEBSbbJXzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMo8Bf+jbsnok=zy3gT2Z-F8=LCMVVFhAoiJ8sjwaEBSbbJXzw@mail.gmail.com>

On Thu, Mar 21, 2024 at 12:52:16PM -0700, Max Filippov wrote:
> On Thu, Mar 21, 2024 at 10:05 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Mar 20, 2024 at 11:26:07AM -0700, Max Filippov wrote:
> > > In NUMMU kernel the value of linux_binprm::p is the offset inside the
> > > temporary program arguments array maintained in separate pages in the
> > > linux_binprm::page. linux_binprm::exec being a copy of linux_binprm::p
> > > thus must be adjusted when that array is copied to the user stack.
> > > Without that adjustment the value passed by the NOMMU kernel to the ELF
> > > program in the AT_EXECFN entry of the aux array doesn't make any sense
> > > and it may break programs that try to access memory pointed to by that
> > > entry.
> > >
> > > Adjust linux_binprm::exec before the successful return from the
> > > transfer_args_to_stack().
> >
> > What's the best way to test this? (Is there a qemu setup I can use to
> > see the before/after of AT_EXECFN?)
> 
> I put a readme with the steps to build such system here:
>   http://jcmvbkbc.org/~dumb/tmp/202403211236/README
> it uses a prebuilt rootfs image and a 6.8 kernel branch with two
> patches on top of it: one adds a dts and a defconfig and the other
> is this fix. The rootfs boots successfully with this fix, but panics
> if this fix is removed.

Ah, perfect! Thanks for this.

> The easiest way to actually see the AT_EXECFN is, I guess, to
> do something like that:
> ---8<---
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index fefc642541cb..22d34272a570 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -659,6 +659,7 @@ static int create_elf_fdpic_tables(struct
> linux_binprm *bprm,
>        NEW_AUX_ENT(AT_EGID,    (elf_addr_t)
> from_kgid_munged(cred->user_ns, cred->egid));
>        NEW_AUX_ENT(AT_SECURE,  bprm->secureexec);
>        NEW_AUX_ENT(AT_EXECFN,  bprm->exec);
> +       pr_info("%s: AT_EXECFN = %#lx\n", __func__, bprm->exec);
> 
> #ifdef ARCH_DLINFO
>        nr = 0;
> ---8<---

Does musl have something like the LD_SHOW_AUXV env variable. With glibc,
I usually explore auxv like so:

$ LD_SHOW_AUXV=1 uname -a | grep EXECFN
AT_EXECFN:            /usr/bin/uname

> > How did you encounter the problem?
> 
> I'm doing xtensa FDPIC port of musl libc and this issue popped up when
> I began testing it on qemu-system-xtensa with the real linux kernel.
> Related post to the musl ML:
>   https://www.openwall.com/lists/musl/2024/03/20/2

Thanks!

-- 
Kees Cook

