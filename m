Return-Path: <linux-kernel+bounces-91163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2AE870A72
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC722812A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D5978B76;
	Mon,  4 Mar 2024 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo6SCB1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864062171
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579612; cv=none; b=lvFxkMHB7a2zaBs5e86xgr9EHKCtZYjZld/kwbndWIv/YcxeUMDq/9fO4nuGLRsk4kvjn4yPqjTFVyHFBp5q1c9XIo+tqkUxcxTY1wvWe5kC5MXwAqBCbRIPNfxk4zbXHct3fmXC6j1Gyt7Y+bOydF/pp26fQ2x2dElvFTA1Arg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579612; c=relaxed/simple;
	bh=0/x7NIFE+8GjjhDfYzBdgxDC6ZAZU3x+lp4u97CB06E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSwsgpvDrgIaDjLmta/TnWCSu2H4NT5iOouuYVHAWXYTWhB3Vlacq/Z5MmXdilTCKxsWbnM6qVsMd9Ie9ra7MQlQjTtcDIhGH7hJpeuDUVTj+eBR1rRmxjEl1r8wa1hyAl0XcVNn7P1fnYY/4qA7BEMGut1fKrbg/4xdu13jeo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo6SCB1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB7DC433C7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709579611;
	bh=0/x7NIFE+8GjjhDfYzBdgxDC6ZAZU3x+lp4u97CB06E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xo6SCB1RufD2pdgJsJkOIjT4MMzNVHTO4+/ccr2e4Pp+R3QkVUNty6VCL6joTcOjI
	 4TxwqTSiExtWnHXrVe0Q+y+6DpyLLkq9P08tRipvDzSMMffnnry4zdVDFPlVTRooYg
	 8bXXl0vC/CONiregcCpj7bJ9bKUuXgg41836rA0EmDwWXeVC28qmM4rEqPW0iWzAxs
	 aVSddO8cZloE9NLiE8xRMP8enPu7WV0AXmSGcq+OyXiJVfGeCzgzT6z1bqm0Z63HI+
	 MrYVECROeN19q2N8hBtW8/6fUuZ3P24SYoMY84CgL7ad7KDH/A/JDix1LaYH+RpL86
	 ep2iSynC+51lA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d24a727f78so59519191fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 11:13:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnG0NFWj5IDV5yFciJLpZxRgCpx9qi4FR/3wylCELqSKzVrhtOG9meI3axq7iUmxgJMAaIeV0WpquUYV0mbiCNlvZ4mjQTiL4vQ0nO
X-Gm-Message-State: AOJu0Yy1d3fYCcpml124ClqMRb2MCOxNFqpT3ki8wi51YZ3vTn85UO36
	FC3arUCIqdamJipSTtbc488oPAwMSqEW425SvovOW6VHhkItVK3ddPq3XMoBw4UJctyG8U/vNfE
	Cu+36PSUkXWOPYeeCycLATU5tWQs=
X-Google-Smtp-Source: AGHT+IEDW/S+00D3+brUThBVVWcdEbNK3BUAE4bc7Fs0Ln5uBbMm7J9Bj1WNwpCDXZbmbA3s5phLEYGtsteClf6PK4Y=
X-Received: by 2002:a05:6512:48c:b0:513:1cb0:174 with SMTP id
 v12-20020a056512048c00b005131cb00174mr6500426lfq.19.1709579609670; Mon, 04
 Mar 2024 11:13:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com> <8b412f69-a08a-51cb-8223-ed1933031d5e@amd.com>
In-Reply-To: <8b412f69-a08a-51cb-8223-ed1933031d5e@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 4 Mar 2024 20:13:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFgUNDusUzVKh=2Mn802+x+0iop7O-aEZH0iuQtdOAFcw@mail.gmail.com>
Message-ID: <CAMj1kXFgUNDusUzVKh=2Mn802+x+0iop7O-aEZH0iuQtdOAFcw@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] x86: Confine early 1:1 mapped startup code
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 18:07, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 2/27/24 09:19, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > This is resend #2 of v5 [0] with some touchups applied.
> >
> > Changes since v6:
> > - Drop flawed patch to move some SME/SEV related calls out of the early
> >    boot path to avoid the potential need for backporting patches #6/#7
> >    to kernels where SEV support may not be crucial. This problem will be
> >    dealt with if/when it arises while doing those backports.
> >
> > Changes since v5:
> > - drop patches that have been merged
> > - rebase onto latest tip/x86/boot
> > - fix comment regarding CR4.PGE wrt flushing of global TLB entries
> > - avoid adding startup code to .noinstr.text as it triggers objtool
> >    warnings
> >
> > [0] https://lore.kernel.org/all/20240221113506.2565718-18-ardb+git@google.com/
> >
> > Cc: Kevin Loughlin <kevinloughlin@google.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Dionna Glaze <dionnaglaze@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Brian Gerst <brgerst@gmail.com>
>
> For the series, tested bare metal boots with mem_encrypt=on /
> mem_encrypt=off and boots of SVM, SEV, SEV-ES and SEV-SNP guests.
>
> Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
>

Thanks a lot! I take it this was a kernel built with GCC?

