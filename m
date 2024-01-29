Return-Path: <linux-kernel+bounces-43509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536478414F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066F81F25E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24659157E80;
	Mon, 29 Jan 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjsJMQ6s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1076043
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562759; cv=none; b=CryaMmAqVB8sSoaLkS3AVLmu2hZxy52NZhk07iVxmM3uP622I0dieHFe2evbGXrrvm1ildZrZPR+Sl9Vuzz4+xkfhsqTUL8Nlfx0aHvoB+yfk8Szr06FitWkNaAhNIfamGJAL/Qgji89XALLn5nq4JvJtn+4+o2SJxN/Gnt0uQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562759; c=relaxed/simple;
	bh=toozhxA5OaN5MxZfRA9HcxV1TAMOi0VIEPmcKpxZ+qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RY8hMZHLk6r2BYkgqhx2nPrjB6GD6Oy7LNCmPdOUxnvi0QuncaJvHeOPJLeNHDGF45vIaQ+V8oIYeRJGIWELytkq+BLhLjVgnY75PKvAUs4bhNIvLzFOwviqTyhvFFcqhQi4S5EGHofbfwrMTUmOxLxmVZwwC0h5T+PN5hEtJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjsJMQ6s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706562756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJKK+vZkaLSD6C4kLn8D3sT5aXAcPFeyLxtieK2IGfY=;
	b=fjsJMQ6sdV18P0L8XREkbeZF/Z19KZS/bDDDtYtwgsa6Hphei8H1UgoymMeS1CBuvaNjDU
	CSdPtTSMvWqy5ekejjlAkksrrftu0iqV0yi0q8CgNBgAzNQHyPOWH9yTdwcXNpW6FOP0wV
	6KCB4bv3AZ072l9r9I1K9USBQppjjQk=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-MYzh2kQ4OfSqP4RNS3tsQA-1; Mon, 29 Jan 2024 16:12:35 -0500
X-MC-Unique: MYzh2kQ4OfSqP4RNS3tsQA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-46b0b625ee6so783697137.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562754; x=1707167554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJKK+vZkaLSD6C4kLn8D3sT5aXAcPFeyLxtieK2IGfY=;
        b=ux4ypoZ8BCn3+eRbvKjnVm1PFnK994nhGSQXMs+v/nDvs4M7YwbQuQc7yzG0uovgXk
         z8bPVEXdRVRAiU2h9Ibe9qCuiS76Wp750x0pRzl+4hxixJ6Olc79uh4nFDqYQr6nLP85
         MKnHpqX5GOiPTRHE7xPq5Gs6qkATMgKnz/7ywyjxeHIJbvpLAhaYvuxVHPyERwOGHqw1
         9Uay4qgGOkuXxoBA7pSET9cGig5rOhYiB7IYynqyfVisEtNXTZHHq2LfKR23krn5hEm8
         8677q4boBAAfKA+mWtLsFee95d5GdW4b/88e/c9cW4+tJkcmKKVEFk5AH5OPsp2Gf0Rr
         TjGA==
X-Gm-Message-State: AOJu0Yw/TOcMMgST0MVV9kqDROIPI0Ry3qxcRmIM804zX8ZCCpdhaoBg
	AykTdyjsxNMP+saR4UNsR6QoR9r5+HpNl0FDjirEmHZafQ4Tu7OR0ySQXAIyYyBRfvQq2tu/xkV
	q1CgebCm4/8t0wMA0dX9TMPkafuh+qPunsYpYLuQpd/FcVU/Y4dhSnQQNeUpD1mKobJqfXrMVtj
	smyIX2RGM5LDMehesRGuW/y+3i54urNtbKWV+l
X-Received: by 2002:a05:6102:4414:b0:46b:8824:bb88 with SMTP id df20-20020a056102441400b0046b8824bb88mr520679vsb.26.1706562754501;
        Mon, 29 Jan 2024 13:12:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNlEojws8R5wF5QnCXftN0hkfKgSKKeqtHsKEcYfVBtVb4+sL8QrxXrDDCkJEjoW6pFQYLBf/wB+o1BmxlrAI=
X-Received: by 2002:a05:6102:4414:b0:46b:8824:bb88 with SMTP id
 df20-20020a056102441400b0046b8824bb88mr520664vsb.26.1706562754231; Mon, 29
 Jan 2024 13:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129115246.1234253-1-leitao@debian.org>
In-Reply-To: <20240129115246.1234253-1-leitao@debian.org>
From: Joel Savitz <jsavitz@redhat.com>
Date: Mon, 29 Jan 2024 16:12:18 -0500
Message-ID: <CAL1p7m77d7okCJR4YwYVMZvbBmFCcWrcXMpa1p50N=ED6CDWVA@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: add hugetlb test category
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, ryan.roberts@arm.com, 
	usama.anjum@collabora.com, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 6:53=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> The usage of run_vmtests.sh does not include hugetlb, which is a valid
> test category.
>
> Add the 'hugetlb' to the usage of run_vmtests.sh.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
> index 55898d64e2eb..2ee0a1c4740f 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -65,6 +65,8 @@ separated by spaces:
>         test copy-on-write semantics
>  - thp
>         test transparent huge pages
> +- hugetlb
> +       test hugetlbfs huge pages
>  - migration
>         invoke move_pages(2) to exercise the migration entry code
>         paths in the kernel
> --
> 2.39.3
>

Reviewed-by: Joel Savitz <jsavitz@redhat.com>


