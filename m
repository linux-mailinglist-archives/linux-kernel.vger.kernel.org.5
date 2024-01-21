Return-Path: <linux-kernel+bounces-32209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D100835839
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082341F21AD2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B849338F96;
	Sun, 21 Jan 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IcWnR77v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40438F8F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705876331; cv=none; b=oM6mPrDbD/XKnpJmXp0vsleBtSa+mT/3F3oU7Oa/vdtJ+gwNB3st7kYs2pqB+8phMQ1JFsHhJ7r0Q2MGjLWM2psHiMHSGPq9xg4FeiZZ9aev+rtaC3k+c5r7CmfQzkItv3/E1VUeVkvSsCX1hPuNNiouNqAesl+V82H+ZGRdAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705876331; c=relaxed/simple;
	bh=9k4gLXrDoUW9Co+CJ49bJ3hXohkNEukZ+y/yeMXY7Xs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ITyB09PPKd2irTMJrvblGXyhNa54N8CPSwZcFcHv1DGD4zgJySLVV1ZwuWcDR+ZXqzW+ezz5vVYfnrV9A1nmFYghoh2uwN/YQc5TGXcX5OK0YVuo0X/1ERUGVafmNdkyYIU12Dp8J/YzHWI0qclaMkTFab2iOursJ4b1y522Zho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IcWnR77v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B941C433C7;
	Sun, 21 Jan 2024 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705876330;
	bh=9k4gLXrDoUW9Co+CJ49bJ3hXohkNEukZ+y/yeMXY7Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IcWnR77vCDQ5A61TLKtCNAVCZB7jbpvXZ+8G6QaOMzO5QKTWK6akbiQRv3egGutQU
	 /9hyKuUu1s57DZXH+BA+kg/WfrUiOCpQnbYohzuCW7iyfDgLLNrIr620fHGaONIh8a
	 n57yTFoGWM57hiZ3Jq6VmiYQYMTTiZhqWoohDzNg=
Date: Sun, 21 Jan 2024 14:32:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
 mike.kravetz@oracle.com
Subject: Re: [PATCH] Hugetlb pages should not be reserved by shmat() if
 SHM_NORESERVE
Message-Id: <20240121143207.299f0d3df52ac746224dacd8@linux-foundation.org>
In-Reply-To: <1705713472-3537-1-git-send-email-prakash.sangappa@oracle.com>
References: <1705713472-3537-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 17:17:52 -0800 Prakash Sangappa <prakash.sangappa@oracle.com> wrote:

> For shared memory of type SHM_HUGETLB, hugetlb pages are reserved in
> shmget() call. If SHM_NORESERVE flags is specified then the hugetlb
> pages are not reserved. However when the shared memory is attached
> with the shmat() call the hugetlb pages are getting reserved incorrectly
> for SHM_HUGETLB shared memory created with SHM_NORESERVE.
> 
> Ensure that the hugetlb pages are no reserved for SHM_HUGETLB shared
> memory in the shmat() call.

Thanks.

What are the userspace-visible effects of this change?

Based on that, is a -stable backport desirable?

And can we please identify a suitable Fixes: target for this?


