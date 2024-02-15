Return-Path: <linux-kernel+bounces-66271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB29B85598B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3602E1F2B347
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2C6FD9;
	Thu, 15 Feb 2024 03:45:54 +0000 (UTC)
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31C6FB1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 03:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707968754; cv=none; b=uW6W95CW6a1Y/6HPU5ofOAbt6XfeoyAp/+sM823VAaVWZo41VSp1j39pwVhqp0+ETUcXnhH3rQotlIarrOMo5KZL0OCTu7PR6F+22fuJFHkgDJNDD+ReAAkRYRBeAdrK3/lE943luPeJHrmfOHidrX/t/vQwqs45hOS58JqiGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707968754; c=relaxed/simple;
	bh=Pr7MlXtPo86/mwM5YDwntO9BuKQlpseSIwMVWLpanLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blXlIEKfzTYqY6CNUaRfQqP2wBwNK2tpH7bwYj0AabcTrg9RcB16uuZb9sjMKHnAQN0/L4cNURNDrgR33FqB0/GxrHqQLjN2hqzMLTsUr/KmTnjMmZMsWIQP1nXmX4PqYVV9id4X6KLWtPp0iHguk7YZwa/iccx3aJeah6DURO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.22) with ESMTP
	id 65CD88E200003AAC; Thu, 15 Feb 2024 11:45:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2817766816217
X-SMAIL-UIID: 31BAFFEE8DCD4C388D6388F22D028CF1-20240215-114542-1
From: Hillf Danton <hdanton@sina.com>
To: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sven van Ashbrook <svenva@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
Date: Thu, 15 Feb 2024 11:45:27 +0800
Message-ID: <20240215034528.240-1-hdanton@sina.com>
In-Reply-To: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 14 Feb 2024 17:07:25 -0700 Karthikeyan Ramasubramanian <kramasub@chromium.org>
> Before 9d8e536 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
> the alsa non-contiguous allocator always called the alsa fallback
> allocator in the non-iommu case. This allocated non-contig memory
> consisting of progressively smaller contiguous chunks. Allocation was
> fast due to the OR-ing in of __GFP_NORETRY.
> 
> After 9d8e536 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
> the code tries the dma non-contig allocator first, then falls back to
> the alsa fallback allocator. In the non-iommu case, the former supports
> only a single contiguous chunk.
> 
> We have observed experimentally that under heavy memory fragmentation,
> allocating a large-ish contiguous chunk with __GFP_RETRY_MAYFAIL
> triggers an indefinite hang in the dma non-contig allocator. This has
> high-impact, as an occurrence will trigger a device reboot, resulting in
> loss of user state.
> 
> Fix the non-iommu path by letting dma_alloc_noncontiguous() fail quickly
> so it does not get stuck looking for that elusive large contiguous chunk,
> in which case we will fall back to the alsa fallback allocator.

The faster dma_alloc_noncontiguous() fails the more likely the paperover
in 9d8e536d36e7 fails to work, so this is another case of bandaid instead
of mitigating heavy fragmentation at the first place.

