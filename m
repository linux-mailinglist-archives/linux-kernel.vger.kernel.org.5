Return-Path: <linux-kernel+bounces-125394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEA189254D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C491C217E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B873BBD8;
	Fri, 29 Mar 2024 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cSsDTqZo"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144F3985A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744422; cv=none; b=CpFgSwi4IE/Zx+p42jc9dkt9REHI1fEv2qdJ7Q5XepQeAJF9zTqpztGGI1eGwKvY+qMOG/ht27SWluvLdyxUz4fFXpq8ku3ShCnCKrGbQ60QeOU2qsR77fAIiQc+6bN7+qe0c+Uslnmsn2t0xJCj+qZdqIBWeJ5ES0oVUAr6t0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744422; c=relaxed/simple;
	bh=7fJ4rSAI0GoYiQAMJdDfQgj6t00Kp7TpJETA/wU9wok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2by3vQ+VHPl1E56zBN8NDkdXQJU4vaHbWckrT6sux5y9zIABJCKiCRlz7lMh51MSseoL1kYL8NLoxbXcCzoEtcAsSlkYZNpsnIkWb0syr26hCsOs/nPztcuKoQpVjKbT/DsH4gj8mQA2qJNZ5oC9q6fvhKLMVIhVlnj560eg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cSsDTqZo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so13713a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711744420; x=1712349220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fJ4rSAI0GoYiQAMJdDfQgj6t00Kp7TpJETA/wU9wok=;
        b=cSsDTqZo1Ep7rjLmVP9XoFKW24dAUgmMBqMZz3pMEI0IEW+qPuSCJvEIxP6L1zOeuh
         EMo7uy+lt1caNRVJ97hOF7hcLlMFjhvZ5BUtNHkKhqAlnheWdZ0ZN3UqbYId38N80Kc6
         +4tbFYOu9A9Z6HL93SR5Z3sUhMF+gwFxfex8Q+l3KCXzNzpXgYWq0SPHzXVQOnsk++XR
         LYdV1RzCl5NaaxRk+eKXpLoHSldcQu8tEPHpFn6midUyhfMBM+88xnQjw+F1jGBs4ovz
         zToO298nAAT5OMGm5vt2y8LADs03UOWh4JkLttMrdWmmqYWcGKtx1yuF+fRmv2favE/S
         pKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711744420; x=1712349220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fJ4rSAI0GoYiQAMJdDfQgj6t00Kp7TpJETA/wU9wok=;
        b=baR1fvaT4flKfY3IslyT6R8FCafi/6UCe+LbIHy+euL2ie7FkLJn0vwwwj2tj2lmaQ
         F8I4pdOozdvYJ94v4mr0oHe+BAZZNgHgpdnz+BT4US/4HdTXdddjgCs/ZMSmNb1nTb5D
         kFJA2oOBKc8PhW6CriLUR6EqZOGZVVCf3oHgnpFZVWAwVulWtVOwmDhMehltpkKWldSF
         iUgZ/vVXVDgTJRQ6NvS0uRVJEgOsEy5xqGsTKmSfhV7+9Fk1vAHUlT+MlPJEFi00sze2
         516rO4yQ1Xfaa9Lt/trCQuRRPVWLoijIHz1noS+A0oLxR1TIaRMHSYQDewNL+kYbun4U
         ymdg==
X-Gm-Message-State: AOJu0YyrcUTxFR4dvrhUaudducGwEGl2pXziaQAVJq4xfaz5Ny6xRvBB
	ROpO6ubHw1AhWdVud/8QVNpoMEz+b7M7SsEbuMiU+6vS/GOkWOw3dxVYWfIgu6MTIEMjXtrrpSI
	G4v8bqsIxpm8eW9QqLEj/Hoty9fVnQxrCrG3W
X-Google-Smtp-Source: AGHT+IFMizgS0G5ukFYvjYIGxUljt4fuYwgJVd/7xudG/ccYnF78sLbJwmbgsF7dKolFZvWx8Fq/tlthiyGNWzulF3Q=
X-Received: by 2002:a05:6402:c94:b0:56c:2d40:7430 with SMTP id
 cm20-20020a0564020c9400b0056c2d407430mr138817edb.3.1711744419595; Fri, 29 Mar
 2024 13:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329174236.2278217-1-edliaw@google.com> <909806c1-a9c4-4f51-a807-46075efb8ab9@collabora.com>
In-Reply-To: <909806c1-a9c4-4f51-a807-46075efb8ab9@collabora.com>
From: Edward Liaw <edliaw@google.com>
Date: Fri, 29 Mar 2024 13:33:12 -0700
Message-ID: <CAG4es9UYvT5tRPFtsRUqJnz9obLuAz03b0+61aAagmGjGTMnsA@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: import strings.h for ffsl
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:32=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 3/29/24 10:42 PM, Edward Liaw wrote:
> > Got a compilation error for ffsl after 91b80cc5b39f ("selftests: mm: fi=
x
> > map_hugetlb failure on 64K page size systems") imported vm_util.h.
> >
> > Fixes: af605d26a8f2 ("selftests/mm: merge util.h into vm_util.h")
> Why do you think this Fixes tag is needed? This refers to a patch which i=
s
> just moving code. It doesn't seem to have any thing related to strings.h.
Oops, I guess it should be:

Fixes: 6f6a841fb77d ("selftest/vm: add helpers to detect PAGE_SIZE and
PAGE_SHIFT")

