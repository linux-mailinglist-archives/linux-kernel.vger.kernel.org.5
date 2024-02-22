Return-Path: <linux-kernel+bounces-76029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A982C85F22B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFFC1C222AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C417BBE;
	Thu, 22 Feb 2024 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWfdRyHy"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2962917BAB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588303; cv=none; b=Zm3zFmxFTrsDgR9TM0Lx80bt5uQjbEQxV0+Plo8q/DgKQ2HGUxtlwDy7W1W2MJKp2s84i69JcRTR9moo/4kATQyciJ2iMRmtSh+gFRBlwz7EiIwOmyQdktQet04a0xKJybjoZDDWrpFwrY/M5MSHuBA1/7aFeS1Lbezq/urrDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588303; c=relaxed/simple;
	bh=OlqRQ1WVt/Iv1KldllbBaXU4TFPW0oaNv+68wcrR2FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tr24NuEyxT8zbbJkDAsbGJEBQ4cVEDmcznygnwai7LQq/Qzgq9W3ztd3fGL23gD+8INnLCLmUb8W41JecaB3HpfYFwvUczCitaqmtDNAKYJuZVwwwDuSwDvY1dgEpswtv3XgzsXAebPiEUBUzXRTqS3WTly4ydjqAZFkMO1BaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWfdRyHy; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so6763623276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708588301; x=1709193101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFDABnEygfXeRc5PDAv8FfUDZZq3dOF4HkErFxOAYbY=;
        b=fWfdRyHyKL/q+L5rNV0FOl5eTVAPr3E9bzT0JlzUmhGEsln7v4654p8EQlho+OwV4J
         0hHIcgHLnVxeoAkR1/YGrgTtwcKEaUoITTCqObyIhsJZhBnT4cPW4EMCzhyWLhIZPF+V
         cbKELrla8mKNEk97rBsszHUCa2uQU4c16zQPnpr3THrdbQTbR+9mMAgJkW3xnYKG9vTY
         BH4aGancBTcN68hQRyeiSahlOc3X10zdlrw2H/ait8MyruyGRZJa9/khXw2Zp57YIz9b
         pqVmbuCQEGi2OHWL1wo7AGgBRzNpr62Yrk9uhBfHx7e1L0z2zArGZ/RIW6HUXS5s11QI
         0RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708588301; x=1709193101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFDABnEygfXeRc5PDAv8FfUDZZq3dOF4HkErFxOAYbY=;
        b=sxSkMbmS0vZDbULAQZcLW5tfdDukl2fzWK0rX3AWQkwZIh9uoPRcSYIBQnT5U1sprr
         2vxfKdJgqPi4b2m9pML4HI7Yl+NBGxqlVN6ChyKQyBF1z0AYFq7z4B0j0Po3USIBkCcu
         rSkBWsVUGz4f2Lwg+SsigXSiasOQO4e6oB0Ac6B6xpmnqFtBKcuQbY4Ys2Hz+DjL1qya
         iKEGbqXERd7JO3E+SnIA8CTqdUFBIZv06I6TyT5C3GThEBZthPcVYEClNIthvYznOWjV
         JBp/ECFmjP/d591V1HsAPcJSEOyi0VRAJm4QrCeR3EImWZRasEITqiQCdGn+Neer7Ek1
         eVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqhhIgT5WIXRXsvTAoalrjSuPN8TsC10nJ904YWc6ms/Bd9AynT7yHpZRJUloPS5+hUTbDZQvKkitwp+GEAUGjeJugqyrDL07qbdPL
X-Gm-Message-State: AOJu0YynN2Lo3jUV/L3zfhaR0Nkl/UX+5B3AE0LzkPZLjSxVAjE1BlZE
	I+eXpl39Rvwg9OoeTnJdY9HnKDH6NylWLAFJKRt7ENzXHSwL+s+qemRmaBuM1MOvzfqbWvWqceT
	kz7K2xTFs8C1I64r1H3XJ8ueKP7A=
X-Google-Smtp-Source: AGHT+IGqLxQ07Uw1LaZQvPg1dVnZIxoaalIFUvNj3VOTbf+Oyd86Wg7GkYDTchJuoO6hxYHMyf6gBKMElHKlJPf1nIA=
X-Received: by 2002:a25:ad92:0:b0:dcd:13ba:cdd6 with SMTP id
 z18-20020a25ad92000000b00dcd13bacdd6mr1598418ybi.47.1708588301154; Wed, 21
 Feb 2024 23:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
In-Reply-To: <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 22 Feb 2024 15:51:29 +0800
Message-ID: <CAK1f24nk19eciysFqvTd=rqpiKePhstDWEEQ_mvT89WCDNrWNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: akpm@linux-foundation.org
Cc: mhocko@suse.com, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

On an Intel Core i5 CPU, the time taken by
khugepaged to scan the address space of
the process, which has been set with the
MMF_DISABLE_THP flag after being added
to the mm_slots list, is as follows (shorter is better):

VMA Count |   Old   |   New   |  Change
---------------------------------------
    50     |   23us  |    9us  |  -60.9%
   100     |   32us  |    9us  |  -71.9%
   200     |   44us  |    9us  |  -79.5%
   400     |   75us  |    9us  |  -88.0%
   800     |   98us  |    9us  |  -90.8%

IIUC, once the count of VMAs for the process
exceeds page_to_scan, khugepaged needs to
wait for scan_sleep_millisecs ms before scanning
the next process. IMO, unnecessary scans could
actually be skipped with a very inexpensive
mm->flags check in this case.

Best,
Lance

On Wed, Jan 31, 2024 at 5:30=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> Updating the change log.
[...]

> On Mon, Jan 29, 2024 at 1:46=E2=80=AFPM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > khugepaged scans the entire address space in the
> > background for each given mm, looking for
> > opportunities to merge sequences of basic pages
> > into huge pages. However, when an mm is inserted
> > to the mm_slots list, and the MMF_DISABLE_THP flag
> > is set later, this scanning process becomes
> > unnecessary for that mm and can be skipped to avoid
> > redundant operations, especially in scenarios with
> > a large address space.
[...]
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>

