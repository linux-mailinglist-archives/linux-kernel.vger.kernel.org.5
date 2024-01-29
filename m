Return-Path: <linux-kernel+bounces-42070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C18B83FBE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FDC1F2205D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF86F9EF;
	Mon, 29 Jan 2024 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e8iuOjNa"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93856F9D6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492610; cv=none; b=hQtKXKFan7eHMrYY9v1nm23H93PS1ayBGNWO3ZGoBs8Udf4cuQFvQzlL9mPa/vfCwB2pi1+c1paAosfzpxEiMoL7e8XDXxYux9qAJ6fosRF7Y+hgfkRslUHcqljUtPuXuAAoOIKnv52ZQD6zAhQ9xxTpCPtJ8mpXSkKB0cc4TUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492610; c=relaxed/simple;
	bh=e5l7ZTxBAuhvL8BJjaJ0QXiYojG9CC69RFkwfv0aqgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmLCWPLc5XvY5G0sQdae2Ml0rYi9YZ/KHt7JhpiioAeeAtNBDf9qgOWbl57wWbqCPv9H6doMe6k9rRwiRTsCD7P7DEHlJbRZzS8jhsu5a3g76SX5M2Act3Da5yOsAmTBGuqfcY/IUVm4aaG4LeJqEJ4lzJsAVjYq/NpknCSzO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e8iuOjNa; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-204235d0913so1123449fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 17:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706492606; x=1707097406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdQUmqGdZQkSaRtssstol3Hg+wBOCg5SlEWZbS6wjcc=;
        b=e8iuOjNaGDRqvdu0lj1OW0IbFWeuc6xJO8LgAqznxwJgqTwhHV6LMzUWXj4sSg4esJ
         hcDt4pvEfrr7+ukjOIbv8PyEVRP9i8h3qFr5O/RV70N/7FIvw8ojkP1f4vYroJ0TwwkT
         +sWltJsjBYHd5j47XBdNHLH2ADvYMGCrpa9WZvdBCmEgGEnRu2YDBOalsqYhtQvLGFad
         dCwGF+JJ7dC+ploe34yQQFf5JLasl1kll+7crdxnVE6el2PVCILUYU5D5ABPFsN0VjMp
         eGxJX1khxZmodEn+vHuvXy3cwcXkqF/kkzeAnk+zAiSsacYwWk18BT1bGEW60K8iKiH/
         v24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706492606; x=1707097406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdQUmqGdZQkSaRtssstol3Hg+wBOCg5SlEWZbS6wjcc=;
        b=oBwMi1+ndnrkWZ3snFRexjrcaP4ssmem28xwdlMOfsESukd7oSY8DUjU/PEv1iCzfw
         TlzKzloJY7/vkDvPYICxXxQhH8+fvCdAJBJv2uTEBji73oI9ZjWlWyGiqYgABCTMYZML
         LcbNx5RWFF7hEaFqqoHafm3CNKjF9cVPRJbPMoeUSFhbdFmqcIhM3ar8ehlcrSgsVc9l
         pEidztVCyatmVJfSUflbGQRACRYNVVJPdjzL6TtNdJu3Ve33lIkRPgUI9/Y9GdCQQGM5
         T0ZkFelUuOtyR9z0YIZodWUx/rZVK+SzrQem6AznADG+GTfzTxuyN+Z+kuwVi4CMCl8P
         JY2A==
X-Gm-Message-State: AOJu0Ywrhh28bMUVtMSLxYA6hE6ZQtBrNUjTnGho6xCGC2HdsKk8yd8t
	vqpx/cOrzr6mWrYllKVbtdcc5eayPC23BbLLsMe2ohy5t++WvK+dm99H+10BOeNvcDo/V/x1hEU
	AvR01oeikWm384dqzX5grNKcjKz25/JAgN4XyKwY39VVMn+0QmpmJ4g==
X-Google-Smtp-Source: AGHT+IEh7zJtrT4zoZeDgoIevMP0HldKJUu/niw/hjgIwiABPGc7e8ykKyUMlP3CGRljf3HMKBVGKg9BWeKb6uapTu8=
X-Received: by 2002:a05:6870:5d9a:b0:206:bbc9:be01 with SMTP id
 fu26-20020a0568705d9a00b00206bbc9be01mr2527073oab.41.1706492606614; Sun, 28
 Jan 2024 17:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123132730.2297719-1-alexghiti@rivosinc.com>
 <CAEEQ3wk5edUFTuE3H3KDGkCXj0+=i7Z1BM2M+6X-Tk9_m8X_iQ@mail.gmail.com>
 <ZbDICZkatO3/lGf/@snowbird> <cd68cf4e-7a6b-4875-ae1b-0c28a6eacaad@ghiti.fr> <65bd3d38-dcc0-4e64-b35b-8a2e697768ff@ghiti.fr>
In-Reply-To: <65bd3d38-dcc0-4e64-b35b-8a2e697768ff@ghiti.fr>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 29 Jan 2024 09:43:15 +0800
Message-ID: <CAEEQ3w=+yDpvsjd3NqZjJOCR8WaHyMBArpavvXPDgU5eKczk+g@mail.gmail.com>
Subject: Re: [External] [PATCH] riscv: Fix wrong size passed to local_flush_tlb_range_asid()
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Dennis Zhou <dennis@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Wed, Jan 24, 2024 at 4:41=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> On 24/01/2024 09:38, Alexandre Ghiti wrote:
> > Hi Dennis, Yunhui,
> >
> > On 24/01/2024 09:19, Dennis Zhou wrote:
> >> Hello,
> >>
> >> On Wed, Jan 24, 2024 at 10:44:12AM +0800, yunhui cui wrote:
> >>> Hi Alexandre,
> >>>
> >>> On Tue, Jan 23, 2024 at 9:31=E2=80=AFPM Alexandre Ghiti
> >>> <alexghiti@rivosinc.com> wrote:
> >>>> local_flush_tlb_range_asid() takes the size as argument, not the
> >>>> end of
> >>>> the range to flush, so fix this by computing the size from the end a=
nd
> >>>> the start of the range.
> >>>>
> >>>> Fixes: 7a92fc8b4d20 ("mm: Introduce flush_cache_vmap_early()")
> >>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >>>> ---
> >>>>   arch/riscv/mm/tlbflush.c | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> >>>> index 8d12b26f5ac3..9619965f6501 100644
> >>>> --- a/arch/riscv/mm/tlbflush.c
> >>>> +++ b/arch/riscv/mm/tlbflush.c
> >>>> @@ -68,7 +68,7 @@ static inline void
> >>>> local_flush_tlb_range_asid(unsigned long start,
> >>>>
> >>>>   void local_flush_tlb_kernel_range(unsigned long start, unsigned
> >>>> long end)
> >>>>   {
> >>>> -       local_flush_tlb_range_asid(start, end, PAGE_SIZE,
> >>>> FLUSH_TLB_NO_ASID);
> >>>> +       local_flush_tlb_range_asid(start, end - start, PAGE_SIZE,
> >>>> FLUSH_TLB_NO_ASID);
> >>>>   }
> >> Well this was a miss during code review.. I'm going to take another lo=
ok
> >> tomorrow and then likely pull this into a fixes branch.
> >>
> >>> What makes me curious is that this patch has not been tested?
> >>> BTW, It is best to keep the parameter order of all functions in
> >>> tlbflush.c consistent: cpumask, start, size, stride, asid.
> >>>
> >> I can't speak to the riscv communities testing/regression suites, but
> >> this would only be caught in a performance regression test.
> >>
> >> That being said, Alexandre, can you please lmk what level of testing
> >> this has gone through?
> >
> >
> > All my patches go through the same level of testing:
> >
> > * Build/boot an Ubuntu kernel with and without KASAN + a few simple
> > testsuites (libhugetlbfs, riscv kselftests and other)
> > * Build/boot a simple rootfs on ~40 different rv64 configs
> > * Build/boot a simple rootfs on ~30 different rv32 configs
> >
> > And I run LTP/full kselftests/perf testsuite on a weekly basis on
> > every rc. All this validation is done on qemu.
> >
> > The patch is functional, it "simply" flushes the whole TLB instead of
> > a few entries, so the only way to catch that would have been a
> > performance regression. But given it only runs on qemu, it would have
> > been hard to catch any performance regression since that involves the
> > TLB.
> >
> > @Yunhui: Please let me know how I should validate my patches better.
>
>
> @Yunhui: And BTW, we lack reviewers, so feel free to help ;)

Okay, if you don=E2=80=99t mind, I will also review the RISC-V TLB related
patches later.
BTW, I mailed a patch "RISC-V: add uniprocessor flush_tlb_range()
support", and please help me review it, thank you ~

Thanks,
Yunhui

