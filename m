Return-Path: <linux-kernel+bounces-167171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02748BA530
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464571F239E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D4B13ACC;
	Fri,  3 May 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNaKxI3r"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC4112B89
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702216; cv=none; b=nIQAUK1ESCQ3N38/0NlXSklWN+m4qSj9Tvu6kjbzP5ppcKBmbbU3e9DrYF2MJa377EIvUNYNLXduIOq3zU/RNsilwucZGsBhD98PsNC2UpXsd0XDGhcfjy2Z4W4bbpes3ubP2ecJBQDwDDKDsBJiuFNCf6xih7vvD5cRlGoL89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702216; c=relaxed/simple;
	bh=BJelPoCu9yUJMhPPfLVsUBnGKjE4JCjTIO3xnPlLTnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQBkFWfIsgKARQX4dq/KcgHFyMYFzZoFovdBOKFWFaMY3F9efUELox3wtiGT5BNYRHs7Eby3H16/62zU7Rz9QZtrgqdlCJfzLDwM3NnHUmvUpBWiaRJof/sn5JGnDq7VwoylfY9jzu7cVto7w/WbInvx9AYr2YsDfaBC8qljk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNaKxI3r; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f25f87e58so1639211e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714702213; x=1715307013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kn6z2hheBNOgJZQfhXfRwe/wxk45Sx5XD6zhVE6LRU=;
        b=rNaKxI3ryjTLmT/v3JxsUJVO/R1ILVe94atx4HeXew+nSKb1pX2WkzukHHCw/nl2lw
         O/NZscLUNjqAvXOUdYFgFhbFUnhyAqCwJALBPp2RAgsV5vsyosXimtZSmsMAxDQOLifP
         p8ajERVVUk82a2hQxdqwh3g9do5cptk/3GimXd2afyg1DJeII1llDIYo1g4oIUGvxmgL
         SmOlxhyziB4Z28k4hv4EWua5X6diAKI9tXmR/+3ROXnQGXsftlHo8EgqW7WYOwPBGOpY
         Y3pEMPGoj6r1/SB3m141iVS0ln2Us4NIYjVFs39Xz4o7x1snMiYaxLyjLF773I+DRBuy
         DKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714702213; x=1715307013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kn6z2hheBNOgJZQfhXfRwe/wxk45Sx5XD6zhVE6LRU=;
        b=Bzzezvbmc1CeBWWZBVzxWtLqJOUV4YQjD2ggLxZztRpwi55J4p9hOSLzFBb1aeP3vC
         tiOTV9gAHWpBTi755l/YsdudaTqp4id/SZOiQgR6mIpgeuGvrHFIRnMrx/ZqpG3aueR5
         rglW8L5Yhka67lxKHoaCI4r8Qnr1Ekli29gFcMatDqUSNSRc/sdp1J9JV1HHKj4C3vPo
         BkK3fQ7siPunGoDh8wfi/5deonRtKTPOUzpdYscsQBlzCUrDQlECRXyYOPfZnDz5sul+
         ikmxQE3S5QgVP2PfX0/8bUcP9H2QC1GnGBsfO0m7pxY6D9khAutMDR/UY6ODC4lQe+lk
         HKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiy+AN3W+wBUXq5Nqy7SIqhpKOsx0qg5UohhjfeMPxAJfvUMA/+dByq5uHpS9fT7urs8ImJGfqCKRlenq5qBClI4f1wnHiG4nDTPOs
X-Gm-Message-State: AOJu0YzaVB84LJ10k99xXjzc0NkFhq23Dbrp5Tpf41k4i7wD7jrbbgR/
	pEIBrCXRDqFQ0C5xfAtiCKKE4kid9njNd+JyLHkYRSqYHu2IJ03FbyGPio0mmd2HuFHHASXCIok
	S28ACdPaDRVIAjYIP2UmEN+dMHdM0BWHWHWTNrNDDsQcostAv6AFeSJg=
X-Google-Smtp-Source: AGHT+IHCyjVZK7ndJ2gDnktGQWiAEiYcFgFgLulDu3kXGkqTRPzB9b3dY5EuwayxIKTYAida9UQwY/KVVQgiDB2qr0U=
X-Received: by 2002:ac2:4959:0:b0:51a:bebb:690c with SMTP id
 o25-20020ac24959000000b0051abebb690cmr906274lfi.12.1714702213013; Thu, 02 May
 2024 19:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502200529.4193651-1-usamaarif642@gmail.com>
In-Reply-To: <20240502200529.4193651-1-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 2 May 2024 19:09:36 -0700
Message-ID: <CAJD7tkYwAQQB_90S8_6YiAq-j3Ew0KKK+a4gnBn2XD+8ocnG4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] cgroup: remove redundant addition of memory controller
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 1:05=E2=80=AFPM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
> Memory controller is already added in main which invokes
> the test, hence this does not need to be done in
> test_no_kmem_bypass.

A cover letter is not required. In cases like this where providing
additional context to the commit log is not needed, it is better to
omit it. This especially applies when there is a single patch in the
series.

If you want to add version diff info or any additional context, you
can add it after "---" in the patch itself. Example:
https://lore.kernel.org/linux-mm/20240430133138.732088-1-ryan.roberts@arm.c=
om/.

>
> v1 -> v2:
> - Add more description to commit message.
>
> Usama Arif (1):
>   selftests: cgroup: remove redundant addition of memory controller
>
>  tools/testing/selftests/cgroup/test_zswap.c | 2 --
>  1 file changed, 2 deletions(-)
>
> --
> 2.43.0
>

