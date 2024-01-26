Return-Path: <linux-kernel+bounces-40260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5123283DD4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD251C20A67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0AE1CF8D;
	Fri, 26 Jan 2024 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDZD4lLp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5B1DA37;
	Fri, 26 Jan 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282403; cv=none; b=dfX9YXr3+vrZTwVHLJX6NFM7JvMdtDzKw7IMvzJ9EaAYsWMHFT5U97CL5f4/0pRybqIpHJT83Wr/mQe5fW2TDfoO9UwGqVdyJKqAHG7jiA89XHNPtcCCeyoGgGj7NLAJJTiy3a2o2/NHlhpWxPrWzIgj28O8SqxeyVke3iBAduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282403; c=relaxed/simple;
	bh=SC9QwQMbCTIJBA+ynOBg9aULds/BrGb1X+P+U7Xcrr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kh0l3Ky3xDUr633ENjBf/hgkmJ/z0KDte2K+H50EalJ/DH1ZI9Pao2ZflAvm6BMd04WttLJzJACkOponmmba4SALgZwFT1Hlb7SXrXtDeRxpmTVb8Ocxqq1Vzg6+Hup6QQJNpNwhFPhrt1Fc+Iye74P8jV70OIATZH+QM1pMJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDZD4lLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A419C433F1;
	Fri, 26 Jan 2024 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706282403;
	bh=SC9QwQMbCTIJBA+ynOBg9aULds/BrGb1X+P+U7Xcrr8=;
	h=From:To:Cc:Subject:Date:From;
	b=XDZD4lLpST9dO7xQN8icGOSn7s5rAjsEivyUrxvSbP4FFiijQ+ZX++/WjaCjut9/e
	 pB8M+gfX/AuCItmYkloBZW/s2Y/NCKLzCyvAsYRTAmwJjVumpgtaPVeu8jeDPN/SrA
	 yrHrcQTphj73gruYO9EQ+uwEfejq0gb6qCejssjVkiDZN69W67VUncIq4v5NX4R6L2
	 DWNTajyuXJIKHjzzhCcXPFKCOfuelOVF63Mj48Y0Z0qGW+uxn6/doYHXBhKewHjduA
	 2xQ0yMZbZp3C/3biVe3oOCn/fVG93zCOsu4d+pn+5H3x9St4yY6PED3iROSuJTHBMr
	 SFp176CFmhmtQ==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 0/2] Fix double allocation in swiotlb_alloc()
Date: Fri, 26 Jan 2024 15:19:54 +0000
Message-Id: <20240126151956.10014-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

These two patches fix a nasty double allocation problem in swiotlb_alloc()
and add a diagnostic to help catch any similar issues in future. This was
a royal pain to track down and I've had to make a bit of a leap at the
correct alignment semantics (i.e. iotlb_align_mask vs alloc_align_mask).

Without these changes, we've been observing random vsock hangs when
communicating with virtual machines in Android.

Please have a look!

Cheers,

Will

Cc: iommu@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Cc: Dexuan Cui <decui@microsoft.com>

--->8

Will Deacon (2):
  swiotlb: Fix allocation alignment requirement when searching slots
  swiotlb: Enforce page alignment in swiotlb_alloc()

 kernel/dma/swiotlb.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


