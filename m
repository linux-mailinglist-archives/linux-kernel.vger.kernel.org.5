Return-Path: <linux-kernel+bounces-84072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6426986A1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC3E286004
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2546014F967;
	Tue, 27 Feb 2024 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po1UXSwa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F7414E2C6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070869; cv=none; b=qAcVPzZrfxO4bEjMAEgt/pG/VJrjqRlGT/IB9YiOwms3jwlKoGuqCJ1n2Yg0/513QrrXfvwMf526xQGNH5gM3CqIsYNq/lhchmP6SbKB1q5SZ49b7HeBOMmaXuwgPTAkqhTa2biLx5uj0/dt7DAqZw5u1ZuzHXzwXmx5tl6Kj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070869; c=relaxed/simple;
	bh=vA8eme6msk4MoPwwuGHqiteV9cKh5xS6+FjpLNNJ9Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huQ3/dE+HmOadlDSxw0Hz8smsQXGHHEfL+LN6ibGB7bctoC/3U1dv4ZlDVXvCW3PD5LzzTEZSii5qfO3mYa827QddndZaBHYTqKvPCdO9iXN9UgzFH2BzoJ+Bmcwe3K41xYdBMdiCyArBcPfZpy+4dJxTmvbFdrmaP0793qe7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po1UXSwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BBAC433F1;
	Tue, 27 Feb 2024 21:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709070868;
	bh=vA8eme6msk4MoPwwuGHqiteV9cKh5xS6+FjpLNNJ9Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Po1UXSwa1+aemKO3GLrb5EI4op47v0Tv5rtx3kig3l4+PoomK+cnfLcEyGpwsnpBA
	 DZGCD2zYaM1Ns9U4FB0/h2E465vBIro05+e1DPCcbUUeTIdNAgRaNQ6gJvMnD6JPeY
	 c3vuR58qW7OBwd++c0a4PGX9APqQ4DOO/6WqzII7gb+ir2/rH5Febkp44tLpLQeqoI
	 NTIZ6Lr2jTcwqeQgdJ4xgnGSG8ClamnaWAZ9etrwlXlmybowZRvAMvTyMMoJobAWok
	 kuBlNAC3tRg//8zE98Cj7XI+jX+5Oz8Y3Hs0IBiKkLpI1y2zlMohdrqz5PQrhNIRhS
	 UXcJH2e1zB6ZA==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@redhat.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>
Subject: Re: [PATCH v2] mm: make folio_pte_batch available outside of mm/memory.c
Date: Tue, 27 Feb 2024 13:54:26 -0800
Message-Id: <20240227215426.153162-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227104201.337988-1-21cnbao@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 27 Feb 2024 23:42:01 +1300 Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <v-songbaohua@oppo.com>
> 
> madvise, mprotect and some others might need folio_pte_batch to check if
> a range of PTEs are completely mapped to a large folio with contiguous
> physical addresses. Let's make it available in mm/internal.h.

Hi Barry,


I found this patch makes some of my build test that not setting CONFIG_MMU
fails with multiple errors including below:

    In file included from .../mm/nommu.c:43:
    .../mm/internal.h: In function '__pte_batch_clear_ignored':
    .../mm/internal.h:98:23: error: implicit declaration of function 'pte_mkclean'; did you mean 'page_mkclean'? [-Werror=implicit-function-declaration]
       98 |                 pte = pte_mkclean(pte);
          |                       ^~~~~~~~~~~
          |                       page_mkclean

Enabling CONFIG_MMU made the build success.  I haven't had a time to look into
the code yet.  May I ask your opinion?


Thanks,
SJ

[...]

