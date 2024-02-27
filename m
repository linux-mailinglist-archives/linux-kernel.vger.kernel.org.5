Return-Path: <linux-kernel+bounces-83710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3704F869D88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63F61F229F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15711509AB;
	Tue, 27 Feb 2024 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nCcUC0pG"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408454F8D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054562; cv=none; b=XZF/PcYoKb2Uz01DHKzi5pbbBj4j/BCY17C477BwgquWgHeHz6ycRvOvu/SxXToV+hIwNkvpSXyf49v074VbsEVBZ+Q1LLhqbYGmwVl3rALyMCzJfAzFe0NFeK4ZvG+ESQry/rnNFGySlJhGrPAhTW2IL90x1lU+H0cqL+nqQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054562; c=relaxed/simple;
	bh=ZdYSOcXMrGX3m2+orVkqUmLPJ7u+bym3zBa/753fpK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObqZcj4oTNEValleed3BNkKyOGZ6IyasezUVNCChvuU5gKPPNkOY3dWO4TZ+d8syg25eHHtiZ2qo9mkM5REoECsBLEZuNYkGtwhjE8+J36AbXJTe1eOPxXI+FWcyC2/+zXJutLjv/MxROzOrmcfe1OIS9i+/QmblOu+UdNXHrLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nCcUC0pG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-299b92948a6so3141661a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709054557; x=1709659357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IUVk9tfv2/TEKzQQvdgVWT/1BpblCVMDABxz0woItG4=;
        b=nCcUC0pGVAHyXX1Lqi0sIdd5eB4yOJHatGI35TAURJ5FJgJxZNViQZkiUevMrcef5w
         8CSu64042KapO/HfA4A6YiV+vdUBT3gXB3697VE2U8GwmGYisAj0p/ULzTYkhpYrKG3T
         bA89zJR5pDXSadakbvnO23D1AWUFWk0+zEBo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054557; x=1709659357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUVk9tfv2/TEKzQQvdgVWT/1BpblCVMDABxz0woItG4=;
        b=LFBpFMXuMTrnr3B7k7Vr7nGU17zdpP6jOzh+oZr+aLc71DQz3AFZG8k9eVXX2UBwls
         jqcyCYWCnWKkzhWo5uTUOnVqpfOtlm6C/jzZT2bhSrxkfSsBss1B/wOdpinP5yBGHYDY
         5zj/jQRCJc2aon2bgz70Xk9rVayy7bUZ0sOmzGX755LTWPpAiD+hCjkdIyDkl8BlaQm2
         1lf2Y7r7qLQa0s8x2qiX9207MSWU99hY+0+XZxvb1pFWbJLiwGKjtJ6jNlF21rbEtjEI
         I7+LHZ3VSPpGkHQAkdQkHfLqHCf1YAzNaBjvbvmVVG0CWLEGpVEoZ7oLJm2qKWF63jy3
         NUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKzyLQ/BJ+KREgAysWNRxWFU2Imj9Bw4GMIWCZRcCXGSwhLVtII7DIObPwtjS3/YE5nDWMUgzgVmje7Y3K+vTEdI0dtoZPbrRhRmTt
X-Gm-Message-State: AOJu0YzSr3T3VBDnpDHOTp+DOF5A2MA5UHrpPY8VNtwlbuU96KbBOiB8
	Ig0ZieHviGsDxvx0lML9aj97kn66p+vQ43MI2XJYGFUYSjtShwtjenVCvv29Dg==
X-Google-Smtp-Source: AGHT+IFJl/Kx/RszupPCRJKfaJbO35UqIx2NyIF5Jao1TcmzBVFuX2aec/PdN2rwgRMAQpvLp7NtlQ==
X-Received: by 2002:a17:90a:8c0b:b0:29a:be15:9c90 with SMTP id a11-20020a17090a8c0b00b0029abe159c90mr6250776pjo.34.1709054557201;
        Tue, 27 Feb 2024 09:22:37 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x92-20020a17090a6c6500b00298d8804ba8sm9585587pjj.46.2024.02.27.09.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:22:36 -0800 (PST)
Date: Tue, 27 Feb 2024 09:22:35 -0800
From: Kees Cook <keescook@chromium.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jan Bujak <j@exia.io>, Pedro Falcato <pedro.falcato@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Message-ID: <202402270911.961702D7D6@keescook>
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <CAKbZUD2=W0Ng=rFVDn3UwSxtGQ5c13tRwkpqm54pPCJO0BraWA@mail.gmail.com>
 <f2ee9602-0a32-4f0c-a69b-274916abe27f@exia.io>
 <202402261821.F2812C9475@keescook>
 <878r35rkc4.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878r35rkc4.fsf@email.froward.int.ebiederm.org>

On Tue, Feb 27, 2024 at 09:35:39AM -0600, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Tue, Jan 23, 2024 at 12:23:27AM +0900, Jan Bujak wrote:
> >> On 1/22/24 23:54, Pedro Falcato wrote:
> >> > Hi!
> >> > 
> >> > Where did you get that linker script?
> >> > 
> >> > FWIW, I catched this possible issue in review, and this was already
> >> > discussed (see my email and Eric's reply):
> >> > https://lore.kernel.org/all/CAKbZUD3E2if8Sncy+M2YKncc_Zh08-86W6U5wR0ZMazShxbHHA@mail.gmail.com/
> >> > 
> >> > This was my original testcase
> >> > (https://github.com/heatd/elf-bug-questionmark), which convinced the
> >> > loader to map .data over a cleared .bss. Your bug seems similar, but
> >> > does the inverse: maps .bss over .data.
> >> > 
> >> 
> >> I wrote the linker script myself from scratch.
> >
> > Do you still need this addressed, or have you been able to adjust the
> > linker script? (I ask to try to assess the priority of needing to fix
> > this behavior change...)
> 
> Kees, I haven't had a chance to test this yet but it occurred to me
> that there is an easy way to handle this.  In our in-memory copy
> of the elf program headers we can just merge the two segments
> together.
> 
> I believe the diff below accomplishes that, and should fix issue.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 5397b552fbeb..01df7dd1f3b4 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -924,6 +926,31 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	elf_ppnt = elf_phdata;
>  	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
>  		switch (elf_ppnt->p_type) {
> +		case PT_LOAD:
> +		{
> +			/*
> +			 * Historically linux ignored all but the
> +			 * final .bss segment.  Now that linux honors
> +			 * all .bss segments, a .bss segment that
> +			 * logically is not overlapping but is
> +			 * overlapping when it's edges are rounded up
> +			 * to page size causes programs to fail.
> +			 *
> +			 * Handle that case by merging .bss segments
> +			 * into the segment they follow.
> +			 */
> +			if (((i + 1) >= elf_ex->e_phnum) ||
> +			    (elf_ppnt[1].p_type != PT_LOAD) ||
> +			    (elf_ppnt[1].p_filesz != 0))
> +				continue;
> +			unsigned long end =
> +				elf_ppnt[0].p_vaddr + elf_ppnt[0].p_memsz;
> +			if (elf_ppnt[1].p_vaddr != end)
> +				continue;
> +			elf_ppnt[0].p_memsz += elf_ppnt[1].p_memsz;
> +			elf_ppnt[1].p_type = PT_NULL;
> +			break;
> +		}
>  		case PT_GNU_STACK:
>  			if (elf_ppnt->p_flags & PF_X)
>  				executable_stack = EXSTACK_ENABLE_X;

I don't think this is safe -- it isn't looking at flags, etc. e.g.,
something like this could break:

  Type  Offset   VirtAddr  PhysAddr  FileSiz  MemSiz   Flg Align
  LOAD  0x003000 0x12000   0x12000   0x001000 0x001000 R E 0x1000
  LOAD  0x004000 0x13000   0x13000   0x000000 0x001000 RW  0x1000

Hmm

-- 
Kees Cook

