Return-Path: <linux-kernel+bounces-99359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEB8878747
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A037BB21577
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6969853E27;
	Mon, 11 Mar 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y/fE0UYs"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1073BB29
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181720; cv=none; b=Th0DSbjjMX0VPaWQ5iTPyonS7by98bjHe/J+4fwSAWefqKkj82KiYMjaLSoE9jYU1Fy2cO7OGGaCxz7f94tUrWMK8euNGN8fPI9sTNyx+BasBm05CK01sr7KiKg1Gwy9Nmx61zJ72TtjFn7RDEQLvNTD8n9kEorrJj1eiK+tW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181720; c=relaxed/simple;
	bh=PWhA/95D0w3WWTr9rPVx2B2b935xKBD2Q4H9+tL8x38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fv7b3Q8vABFSRIHrVNC2IIe3w+gYJwgsqAa7GYZil2YLZQnZCtymkLPTb+lTQONQbpjGyWOhrSpX5himWn0pVLT0GhLEw4gKA6WLQaxrLaz4y1oanI39rVE5jFAJ12L03tEtXa2g64i5l0AAP79DNX1JTPFAHlG1wa0tY2F/8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y/fE0UYs; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51321e71673so5087585e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710181717; x=1710786517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWhA/95D0w3WWTr9rPVx2B2b935xKBD2Q4H9+tL8x38=;
        b=y/fE0UYsdvajN5Je8bGlQ4XiMWhCtFj1X0ksjyUYGa93dxlcbSKMzT8psW18yn3Gbg
         8ZhylTKV6Wi+nQfH9SMkWYDnMkbspniohoze0lJy1F+B4b5L+dq4hA39WWKs80ujL5Ri
         XtcZCjGdS7BdBkTPMAI4HWE11rmo+CzP1bEUPXwegF1AhCBjAWN/76/t/RNPNLUOtVq3
         mkI3NMUSnf/66UbHuMqlKpHz/rUzIdPXspXUR5IoUa+Yquy3nEFbKQaSWbbF+f3m5Ghg
         Nab/iJt+BCkv3YhK2e90XPmJ7fcrT25hUZV0NoWffMQI62EIAurFwU/kylaGwWjPYsIF
         cjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710181717; x=1710786517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWhA/95D0w3WWTr9rPVx2B2b935xKBD2Q4H9+tL8x38=;
        b=im+tCCt3A83SRf1MAz5MWDghoEEoGHWTpihqHrRpeJPi75OYn83JfcRnsrCMza7+3Q
         GC/wJ5deNWfnDccihutr/B1n2SXRD2XlvJVTGmxUea3uEgBTcv/xBsAIp/iZdtxAcgPb
         Pw71tAEzvz4eQd3szCNzSrw79VYTcnVIKDwQgEOWZI+gDS1/1pKIDiA+5jqLzc6m6s+C
         R8m+PCB8wMTAorK0omKuS90+E5b7W8BSgMzt2asXVjzyo4PIM7Jyf2SGHwvp5CZLLAQh
         4pfGAQMJcqvUbIZbHAREI46I2J1cbnjH+TrlKSDmIoACXYSM+w3v8K5lIMK9yxjMdDD4
         ou5w==
X-Forwarded-Encrypted: i=1; AJvYcCXJQtYsg8cWVztFRPa9ZZhVjicE3AZolOI5ZItKRXCH5K/y64whD+dfBSaGj95HUTllKhDeEbG/DaND6RXD5Vn+R7PMlIomSP+YeKII
X-Gm-Message-State: AOJu0Ywi4qAB6vpBwQtJGNR0iX5Z2R1SzN06g4XGBaYYbmaaKKFn0ky4
	r9sfIMCTT3FQlzTys5mH3acQHG9TUmoC+GfrLH25ExNKdyvYPNsF/eeA3AMhdtsTqH+qCZok2KQ
	z/ViRS1dcf2sa6S3pDlRwfehcZOPFXHAy8ciI
X-Google-Smtp-Source: AGHT+IHrLmjzFAJTYl5719GqKvfQGhtCq5ZY6aYr3tOzSCXcxH1gXnPhub/BsTtVRYnXofvsz0JrLVDlNZB9+mS3OBA=
X-Received: by 2002:a19:641e:0:b0:513:4764:2fa5 with SMTP id
 y30-20020a19641e000000b0051347642fa5mr5008706lfb.41.1710181717177; Mon, 11
 Mar 2024 11:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com> <420fcb06-c3c3-4e8f-a82d-be2fb2ef444d@app.fastmail.com>
 <35b670e2-9ef5-4d3a-b6ea-f8016dfa088d@intel.com> <ZevHJ5o3G00_nBha@google.com>
 <o5t3qrrlw37hdkcja2vny3ycpmhb4dowmdj74a2wrq2x4xctqk@5g5jvzen46qe>
 <CAJD7tkZABvm4v87T2WJ593sjZ_Z9iLCcgecghQJHrZDnuisBLg@mail.gmail.com> <e5tjo62yrvmviixily6ramjvnqqmokvayyr6k7c7qzrczcx4yd@yupixsoj53vm>
In-Reply-To: <e5tjo62yrvmviixily6ramjvnqqmokvayyr6k7c7qzrczcx4yd@yupixsoj53vm>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 11 Mar 2024 11:27:58 -0700
Message-ID: <CAJD7tkZ3-RSxSWmskGyqR1j=XHVS8=BpHPcbH1bgxih=Lo9CHw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, "the arch/x86 maintainers" <x86@kernel.org>, linux-mm@kvack.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 5:42=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Sat, Mar 09, 2024 at 01:37:06PM -0800, Yosry Ahmed wrote:
> > On Sat, Mar 9, 2024 at 8:34=E2=80=AFAM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Sat, Mar 09, 2024 at 02:19:19AM +0000, Yosry Ahmed wrote:
> > > > I don't see how skipping set_tlbstate_lam_mode() for kthreads fixes=
 this
> > > > problem. Do you mind elaborating?
> > >
> > > Define what problem is.
> > >
> > > Yes, in this scenario kthread gets more permissive LAM mode than it n=
eeds.
> > > But nothing breaks.
> >
> >
> > The problem here is not how the kthread runs at all. It is the fact
> > that if that kthread context switches into the user process that has
> > enabled LAM, it may not update CR3 because the mm doesn't change.
> > switch_mm_irqs_off() will only update CR3 in this case if there is a
> > pending TLB flush. Otherwise, we just return, even if the LAM for this
> > mm has changed.
> >
> > This can cause the process that has enabled LAM to run with LAM
> > disabled and fault on tagged addresses, right? Did I miss something?
>
> You are right. I think IPI is the way to go.
>
> Will you prepare a patch?

I am working on it.

