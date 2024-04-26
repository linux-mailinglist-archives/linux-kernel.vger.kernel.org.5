Return-Path: <linux-kernel+bounces-160279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 335768B3B50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EAC1F20FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88B3148FE2;
	Fri, 26 Apr 2024 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwGvDI4P"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733F1494A6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145041; cv=none; b=mHM/zbAAg+p+yO4R2UqcaZ4OehznTS++2TMsrp36KrL68EDl5z8AZi1PT2AiP5CSi9Z5tVATRsrh23Io0JjkUTtU9B6ULlkQ5+2q6KMC9IsVkm7y1DZM0lcYCe0uhg+DIpp1YcWX86E365gBacGY3bKBqXKZlyBW6OspvgzmzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145041; c=relaxed/simple;
	bh=wSnPTnvBkDWveUNl8oR3u4n9qXzCaCyl8sjSvomXPQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7Nl61k0DE0hP1ohiSI4c3J0wb65dqN6pQqekbZJ8hfTIwx+Aj88bQv3wb2FRwXNcAj7HSYmBosgUFt71gZNWCGTq9f7p8thfRp9rBYWvxdrXNwPL15AXMaBIwLDxRDHyRZCae/DBaMcIoeQ4/loAIF2vKYtBSm08+hycupWPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwGvDI4P; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de45f3f092bso2785174276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714145039; x=1714749839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hbJirFZZks6D1peX1ZQV09gxl4EVMTmWrNyCcPglVE=;
        b=AwGvDI4P8hbUjHzLsfcCcwxxib8PIYkyAJ6636vMeImwq14K8LPPzrlxPn1NiuoReF
         mTAG3AzF/pZPhx+ip8fM/n/LM/bi8DtxF9ACjbCERJjKqgmRr4iWwyzUmyKiGkDlMNYk
         Q+ds5id3suSbP52wQy1aCeTzAIeQyD/U3oqvUyUK7f/SfYHwovnZt1JF30Svs+Yl06u5
         qe6SI5FVNQxmxOsjzFWxxF/uFXMhcw13Ngw3RjZuaH/FUfaJGKWVzDdShlXsN7B4Zt7S
         q5WphgKGj0j64T39/pj+7aFodhD9BlMYCMLbJfmrnD4QmR4su+HwfjUhOakXDmceqeKq
         n67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145039; x=1714749839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hbJirFZZks6D1peX1ZQV09gxl4EVMTmWrNyCcPglVE=;
        b=E2nLRw07rSAigU9HAGV6rTFwi3ZdB13OeLHSUw1eJ2YjfPYpgRchJ7eFMkyDzQUuvQ
         XQyXpT3dA9uoPqrWMO4xOP8RL6qwu+iIIz7gfAKZ/aMyObqtqR6h4M5P4wQMiog+GeHY
         dvQ0odrjnKHqZr8GbyTUdmfARHrKT/0Fl44HKju+Oy7bEkNUbzyH4m/AnARQFbj7CHvq
         3J7NbQR1DYzwomgFHmPxB9/jOYzXKU4y3R2WZLu7N9pY3CKyUsqvJZ2gyGDtqUgIxMFq
         8vAfGXhC2DSxGiev9aX+lYMUEtzHM8Wgs3aqXbnwd28z11bmXczIaXp4gcE7izI6XT/r
         jY2g==
X-Forwarded-Encrypted: i=1; AJvYcCVYpW9VyLb+gcr3E/zgFU2k0xHib5nvb0woVACYi25iMqzweBeK/7S0UAI0foCoy5rMKQUDBIJdVoQn46wV/WOjFmlHHja34I7+sqbv
X-Gm-Message-State: AOJu0YzllgkmTAGqAj7XSj1qXn7XBM59qi1wmvaI57ZVVgT0IykvnNLh
	JfmEt/N+blxtUpMhUw4NhrBqnbWNZFrcSfsFWmd4IBiCEvMnQr3ptnPngN8nFiejmJdzMqsgu9z
	wmjc6e6+gwS/IVsp6sCGRsuA4PDs05HRhosmgNLbvAdrCcMSHTFBW
X-Google-Smtp-Source: AGHT+IGo2Tt01/flnCVIP3UkYxgEkPiWuQtGOl0av17cc2y9CCWvB7HgxL/qVSX74Fm6W6kvQ2yBPhxaowjnYufX/Uw=
X-Received: by 2002:a25:818e:0:b0:de5:6073:2ba4 with SMTP id
 p14-20020a25818e000000b00de560732ba4mr16923ybk.40.1714145038633; Fri, 26 Apr
 2024 08:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426144506.1290619-1-willy@infradead.org> <20240426144506.1290619-2-willy@infradead.org>
In-Reply-To: <20240426144506.1290619-2-willy@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Apr 2024 08:23:47 -0700
Message-ID: <CAJuCfpH_kyp6vVU5dSx=WJNpGRThmak53wVjSsBfxtqTrNy8TQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Assert the mmap_lock is held in __anon_vma_prepare()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 7:45=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Convert the comment into an assertion.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/rmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffad..619d4d65d99b 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -182,8 +182,6 @@ static void anon_vma_chain_link(struct vm_area_struct=
 *vma,
>   * for the new allocation. At the same time, we do not want
>   * to do any locking for the common case of already having
>   * an anon_vma.
> - *
> - * This must be called with the mmap_lock held for reading.
>   */
>  int __anon_vma_prepare(struct vm_area_struct *vma)
>  {
> @@ -191,6 +189,7 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
>         struct anon_vma *anon_vma, *allocated;
>         struct anon_vma_chain *avc;
>
> +       mmap_assert_locked(mm);
>         might_sleep();
>
>         avc =3D anon_vma_chain_alloc(GFP_KERNEL);
> --
> 2.43.0
>

