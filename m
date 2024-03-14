Return-Path: <linux-kernel+bounces-102687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE1B87B5F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1927B2832D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A2EB65C;
	Thu, 14 Mar 2024 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="35u0CG1V"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A58F58
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377682; cv=none; b=u4afXvnD5a4cRqs8R+GFqnj80GyTcKte0WKwLDgtT/oJjI9xV4yghS/2ux3udn7pl4LxXuX2/wFqE5idG5gMm9BQPTajTp/m4rlQRJVWLyngGAoYUecF0sYlHD3ISskjsT0sWcEuBGPOS4F3W8IsyETZ5SDc75hWqwJRI90mnuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377682; c=relaxed/simple;
	bh=hEd7yGTTgtoEWtR7Df37a3dG03idlQkuKsP6d6crYbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1jtR9s88XHBHZsjmeNRm+rT7O3hLM+0RcCVmK/p4Sluzlsqom3YNyF1ewyyFkvfY8NWacETHl8y80DUwmWfXbVUcrbQQ+XSj/DI4CYcwYh1wFl9vgCWbaro9yD/kcVq+i/yQm0F9eKg6Qnh+fdg9kfAlAguPB5vQuPs0UE5b+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=35u0CG1V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=V+ZVRZICTWAfdlng4uK3SLZO/6XHiTftuTJ5tPtJc5c=; b=35u0CG1Vu/wTheLe79swQh6gUb
	RBRP7gE0uw5ozHsWFkLpj9pW+P/H28fdcshMKtrYzslZ7Jw1+J915AH73GINTcuhBJn1Qn1q407bN
	tINR5A6o67crJvrkaPLq956p+JaPeVvOIs8jyY+4ypS3SRr7wCQqjRBCsAhoH4SMcmNH7Tjvz3I3g
	wBwjeEcdF/ArYxHRUC9j9zrv9vofHiVUFc66QN/hAlRMmJ2kp0LWEq13pS26omxtvlkGu8ATQhhe0
	foc5DWD6L/ZbM/0nwUs2VDnnzz5AtPYsiiktHaMfH1hWOr8uC6VxMOCD4VHsLJpY4FwLJraOgxutu
	NvKAd1lg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkZMj-0000000CQny-0Oiw;
	Thu, 14 Mar 2024 00:54:37 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	jhubbard@nvidia.com,
	vbabka@suse.cz,
	mgorman@suse.de,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 0/3] mm: random cleanups
Date: Wed, 13 Mar 2024 17:54:32 -0700
Message-ID: <20240314005436.2962962-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Here's a few random minor cleanups I spotted while reviewing a few mm/*.c files.
No functional changes.

Luis Chamberlain (3):
  mm/show_mem: simplify ifdef on si_meminfo_node()
  mm/compaction: add and use for_each_populated_zone_pgdat() helper
  mm/vmstat: simplfy extfrag_show_print with fragmentation_index()

 include/linux/mmzone.h |  8 ++++++++
 mm/compaction.c        |  9 ++-------
 mm/show_mem.c          |  5 +----
 mm/vmstat.c            | 11 +++++------
 4 files changed, 16 insertions(+), 17 deletions(-)

-- 
2.43.0


