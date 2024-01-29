Return-Path: <linux-kernel+bounces-42061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9930583FBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F39282A57
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13E4EEDE;
	Mon, 29 Jan 2024 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cKHSSQOV"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05388EED7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706491766; cv=none; b=gkqNLmKkE/TpIIE4SpXIua2NpTldjHpE0sXVIjA0FNI1u6KtoGvVLl0/5pKM8Bm4u3I+TU0fUXygCtDJXSFjharvWrtnuYTh2bQFTL0dDAE8gj04d0wej4s7MgxAaqfzWHviO50ECHo/S3gyHiPwUGxID8hcdRKAjJwSjcjOgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706491766; c=relaxed/simple;
	bh=2dFH18+csQIh0arehY0/drrQNQ3PySdwHK9WAS30SWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATBm+eXIdRQDlXwWfrr7JYHKDFo7ZL6Y0YNGB2BbDuEqsEAIYqsYgz5aSE5O+V4XTltEvDZ27NmBrhz8AeEmW+WqFnNrrwUjeQvZLneFXb0GepQloJ+QmEO5yxPUykQQwXLqpW9gCLZLJT7WTKkfZR2EdaRVTNZ6a/dakoe45U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cKHSSQOV; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2183afd4103so896017fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 17:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706491763; x=1707096563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ADClRzg4AS1tsrl/EnTtXjRsNE1syTriY+hJ47tGK8=;
        b=cKHSSQOVDZNrGm3yR7tx1xuo0ncJE6tVsFRZWffrLQ+tZesGsN+H9Th7CfoN67a6fd
         7J1FQBXX/Nj2img4jamp/1siPCn24gXOXR8FJZ1b+XgBtNE6TbQyJL1yaCXubtCDVqLd
         g0KVE3a9kcbBVY1ctq+OmD9YiKAMm/fixHxYOlnSqN2mHZpdhOnfN1y4sO0Rl5h8o9+8
         G8IiOxcBnuiQgoPF2hGIoHevFYVHrLGya70ThR50kZ/CHWR6ZYV1VOVKnoMRvgHP2r3v
         cfg6Kowe996xw6rzOj8LRV9zNxF20Y5Dc5bkM8fndr0dM8pj/WltWYG+l1LP8iF3FRNt
         9x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706491763; x=1707096563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ADClRzg4AS1tsrl/EnTtXjRsNE1syTriY+hJ47tGK8=;
        b=o27aT079+1HHt85NbmoESAuL1OXC/ZyTLgWmS2C+tX5yp6aujE6TruWWJQlHK/aUAn
         nHam+Lp8ecJ1917W0O4rDzkZJWvj2KD7c9SdlIypyo+N+4DdZWE65YJYdMJXf1k6oGbR
         6CLQ02p6I1ZM9iOEza1CkrHh546wpzEMP/2+aB0ctveOFr0SlpGdtCEHf0aNX8kGQcVV
         YFFAllDmE5WrsEByp8/2bv2FrJsXIGZ0n7l2yS4Mi03dgEpbVH4N2HOAFJ8rZKdZv28e
         ODY+SlvRaV4GmySSUJ0Sbgn+F6C/x05w/oGpMjQfK7anUuvt7xyuec1xs5+J80G+d6zO
         sUmg==
X-Gm-Message-State: AOJu0YykagDQ/agT7RagYWSHoSgsESlg8AjPbsk7RZXnJI6nW49BI6EN
	hxRdSuoq6nnCcl6kQ/IhQZqNdFRo+L6IYhCc50QR2JDPX1bsjfv8C18NrftaPuBu0pNVaesIpwY
	39v15zcfP4F+isq2siXYnpggzCsiX1+57b0k+jg==
X-Google-Smtp-Source: AGHT+IHxOmZo5QvFvZVHbFICSOQ9hCxlC30D35e6G9303kFUISqid3pEYinYw80ReoUbB+cY47+J7zU5l3qDTKldn/I=
X-Received: by 2002:a05:6871:6ac:b0:206:6110:ff59 with SMTP id
 l44-20020a05687106ac00b002066110ff59mr1659533oao.27.1706491763016; Sun, 28
 Jan 2024 17:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125062044.63344-1-cuiyunhui@bytedance.com> <CA+V-a8s4No=U1S-KzLAmOLYa6vXd7repFP4HH1=SraLB2=qHRQ@mail.gmail.com>
In-Reply-To: <CA+V-a8s4No=U1S-KzLAmOLYa6vXd7repFP4HH1=SraLB2=qHRQ@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 29 Jan 2024 09:29:12 +0800
Message-ID: <CAEEQ3wmVT_Lo3Jsoj-yp-3RCEfu=D7QKJq110sN-2a-wV+R59w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: add uniprocessor flush_tlb_range() support
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, ajones@ventanamicro.com, 
	mchitale@ventanamicro.com, dylan@andestech.com, 
	sergey.matyukevich@syntacore.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	jszhang@kernel.org, apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Sat, Jan 27, 2024 at 1:42=E2=80=AFAM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> On Thu, Jan 25, 2024 at 6:23=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Add support for flush_tlb_range() to improve TLB performance for
> > UP systems. In order to avoid the mutual inclusion of tlbflush.h
> > and hugetlb.h, the UP part is also implemented in tlbflush.c.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/include/asm/tlbflush.h |  61 ++++++----
> >  arch/riscv/mm/Makefile            |   2 +-
> >  arch/riscv/mm/tlbflush.c          | 195 ++++++++++++++++++------------
> >  3 files changed, 156 insertions(+), 102 deletions(-)
> >
> Boot tested with defconfig + rz/five enabled, no issues seen on
> RZ/Five SMARC EVK.
>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>

Thank you for testing !

Thanks=EF=BC=8C
Yunhui

