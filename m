Return-Path: <linux-kernel+bounces-76863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF2985FDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4D6B2BABD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D015099F;
	Thu, 22 Feb 2024 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjNKfXRq"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33491482F7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618414; cv=none; b=C5wmqrOWkmyM+b/meCKOMqwg6kUfrx7K4NU+7zS0gY1IjC+RFTRernKF1kxWcMGShA6J6Sd7/M9yr5jNz3K0HeoeANCg7bsEzxISWjgac3gbN8GAi+tW4bWcsznfrDetuNBgCXO8DXokpgkVfb/u+fTDS6kZ23csXoZmM0oi9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618414; c=relaxed/simple;
	bh=OKvobmqgI2U/lDRVq14SHRll5cOTnJ5oYasRI+QQUXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Udxb/nGm/M4goY+6PnFZkzqUmlHKCyd5CFssVfPwnPBci8GUcHR4sOwX8DxhMDtOwk+AQUz0z61lt3SG6UEQQCDD6YKnmD5rdp7nrgwasFwuKdLXgNKugmwBFFTuGY37ooqWZqqmTm3xUyPqxAS5wejCkPMeniVILDzvMSse/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjNKfXRq; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607f94d0b7cso72781247b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708618411; x=1709223211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xP4/RDM5HizqveFeK+DZ+kKMIOhU3CKQ9ee/dhSsQmY=;
        b=WjNKfXRqad2XSdj9/ED2BP59gEe4cXqU7RoqsUIQM9iHsZGxYetTnt5MwzVb1ywjFq
         cfYp9Z984ccxIRZ/c4+WnBXlbcGSwD/4io6N1t6ifzna0RkACF0K+SKoPHe6OKynOuxg
         rkmyWw/tmN+wBvRcq9WAiIXbV+1tH6qUc5ugVSwt6arwK/4mFv8+m5y5FmOXIy/QHv+y
         M/1nUxTFoNsiuDu0ZeKiyy19STekrnXbCOrZ9yYg9v1PGr27h/r2JCfXPtP91sklwoN3
         HXRUGVsUwHMfuE8e+s69fsCGp4opXXdYfPwiWZuB3RkTnqPzPkQZtl0Tae0Typg48V9H
         hu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708618411; x=1709223211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xP4/RDM5HizqveFeK+DZ+kKMIOhU3CKQ9ee/dhSsQmY=;
        b=XoAc1HNARpYC6NJqkQQQk56WV5a4boFDAoCr7R5ro+H1vLEpyRCgahTTriTQa3Sl5g
         8J3jLbg7h8wcB+oVJ0NfgGNzCkNpNC5UUuDxbcdcWc+URQijWHIvdH4AwlZI3S+ZW7Fs
         8CKpNx6MPGOGag3riq8ug3cJVsNSNmp2vgH2BEy+hYt5DSP6qB5RLPQ1xc9db17SIYMN
         Jm6LMMV4VVvF4Fr9JRpUf0mYAQLXOtIi55rBnNRiY15jN2O1haRpyIIeIbUqpMpdoiLz
         2a3ngRKetI7D4DhvpXH7WRt576PSp4+EXkKAZjRYlhkz0TOk3lMbnX5aGLhEJ6ZKxB8L
         JbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZt9vVT/eCIS3druqxmPjy3CHpDfLO+LsLlHPGpZv7DlbWQnvgDxF51wNDwywmeHL80Gr61XtYTwih4q7f+Xztf0pzTod5DMOw6uT6
X-Gm-Message-State: AOJu0Yw0s+XslO1ISQvXmNKRwI7QMPZ3dPScH6LhJ2obDngt+RfbZjuT
	vJlJP65zs/Ra766QyCQRfIcmdLTlYDFQBzEhusz5FdRaesswKqY787X031Shel3Kwr7e6mldWNf
	/BgprozE8CxMRyghNXYDoDphnof++scnb
X-Google-Smtp-Source: AGHT+IH9kIJeyOpOZVfteyq45DpTp18LDeQptwiIY5qfuBiGUDqngg+AVGxfu1g9bVx8zb/FLJr2XlMnhmBvradAvlg=
X-Received: by 2002:a0d:cb15:0:b0:608:b15e:4686 with SMTP id
 n21-20020a0dcb15000000b00608b15e4686mr345799ywd.16.1708618411559; Thu, 22 Feb
 2024 08:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221234732.187629-1-vishal.moola@gmail.com>
 <20240221234732.187629-4-vishal.moola@gmail.com> <ZdbCfLo85Gi_a7OI@casper.infradead.org>
In-Reply-To: <ZdbCfLo85Gi_a7OI@casper.infradead.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 22 Feb 2024 08:13:20 -0800
Message-ID: <CAOzc2py0YtAbE0GmvYROvD=DzYACHAGs0uZzFdRkPO10CATCJQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] hugetlb: Pass struct vm_fault through to hugetlb_handle_userfault()
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 7:41=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Feb 21, 2024 at 03:47:30PM -0800, Vishal Moola (Oracle) wrote:
> > Now that hugetlb_fault() has a struct vm_fault, have
> > hugetlb_handle_userfault() use it instead of creating one of its own.
> >
> > This lets us reduce the number of arguments passed to
> > hugetlb_handle_userfault() from 7 to 3, cleaning up the code and stack.
> >
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  mm/hugetlb.c | 38 +++++++++-----------------------------
> >  1 file changed, 9 insertions(+), 29 deletions(-)
>
> I love the look of this ...
>
> > @@ -6116,7 +6098,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struc=
t *mm,
> >                       struct vm_area_struct *vma,
> >                       struct address_space *mapping, pgoff_t idx,
> >                       unsigned long address, pte_t *ptep,
> > -                     pte_t old_pte, unsigned int flags)
> > +                     pte_t old_pte, unsigned int flags,
> > +                     struct vm_fault *vmf)
>
> Should we remove vma, address, idx and flags?


Yes, I'm going to do that in another patchset, this one is mainly about
enabling hugetlb_fault() to work safely under the VMA lock. It will
make it easier to debug if any substitution goes wrong somewhere as well.

We may also be able to remove one (or more) of the pte_t arguments,
but I have to look into that more.

