Return-Path: <linux-kernel+bounces-118378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C965B88B9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31272B237E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9703F12AAF0;
	Tue, 26 Mar 2024 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nx631puE"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA1312A177;
	Tue, 26 Mar 2024 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711431718; cv=none; b=AdN+LgHjPla3FZIhxNFo8BP5JE3XmUjVG5oicwPJpMcBYll5MWkbf815SOMKaKlkxnLUTNsiGMO1v2ppMgEqJtdTrHd8L4cjGgTsKRSB20v/vRS2ODtHag0SJUb9/FcTvKnObQWOiu9UHTkWKWjF/BXHPj+AacteayfvfIuIm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711431718; c=relaxed/simple;
	bh=0A6Nj6ZMYCJQBCcVGj57dvC0/PxX1d6zuOtds8vVvbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/1CxlfbtrYwFgKwnV5rCgRR7r+cZnOgKAxzSLtAJYwd3tyhgEd97lWYYoYUFWiJNGWbNkzN5nqDyrvimOt3IQX3j/VZqjf8lQrA97x5vOG5iDCaUuItXfu+1nqjgwoCtsfa1IRT9wiO0o83etaBdoTESFrKbuMBu8W2CojcKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nx631puE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yu+crYrSVvZEXqYYLFIy3hTWFtBdd9C4RrNy1wO0oUI=; b=nx631puEDrwxoUrsyAbRnrUg4M
	wF+BVloRCTJgXcAcPPznOszwtyYS7ufer0HbzbtWUNvHfslSazZxpbelTV0dvFvssJdQbkWVBsmNL
	RURujdyP2WrjDn5JGoMrkmJQYquRlA3ElhsdbTzKdQaDQSnn/eZ1iowubW+Ad5IA6rIbFwmUiuM59
	HU913Zio0TOXgJ35OqYbIisbk217tp9vfruEToi+YSGIVTjG89P9uQU0/ogqiAz1Ag3jn3oe0FCxx
	/1xwvUu9RG/8AgdLDipDeYUqhS7Acy9ZtcaASZw4GoyKYNN2AgqL7ioNAIj9eLIk2TZeuMSe+W5pB
	7H4FuaBw==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rozZI-00000003AFj-0Do9;
	Tue, 26 Mar 2024 05:41:52 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] scripts/kernel-doc: drop "_noprof" on function prototypes
Date: Mon, 25 Mar 2024 22:41:49 -0700
Message-ID: <20240326054149.2121-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory profiling introduces macros as hooks for function-level
allocation profiling[1]. Memory allocation functions that are profiled
are named like xyz_alloc() for API access to the function. xyz_alloc()
then calls xyz_alloc_noprof() to do the allocation work.

The kernel-doc comments for the memory allocation functions are
introduced with the xyz_alloc() function names but the function
implementations are the xyz_alloc_noprof() names.
This causes kernel-doc warnings for mismatched documentation and
function prototype names.
By dropping the "_noprof" part of the function name, the kernel-doc
function name matches the function prototype name, so the warnings
are resolved.

[1] https://lore.kernel.org/all/20240321163705.3067592-1-surenb@google.com/

Fixes: c64e38ed88d1 ("mm/slab: enable slab allocation tagging for kmalloc and friends")
Fixes: ea7b8933f21b ("mempool: hook up to memory allocation profiling")
Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profiling")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20240325123603.1bdd6588@canb.auug.org.au/
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
---
a. Suren, Kent, feel free to correct my comments on memory profiling.
I haven't read the documentation in a few weeks.

b. There are some instances of the kernel-doc function name including
"_noprof". Suren is correcting those cases so that all _noprof warnings
will be resolved.

 scripts/kernel-doc |    1 +
 1 file changed, 1 insertion(+)

diff -- a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1723,6 +1723,7 @@ sub dump_function($$) {
     $prototype =~ s/__must_check +//;
     $prototype =~ s/__weak +//;
     $prototype =~ s/__sched +//;
+    $prototype =~ s/_noprof//;
     $prototype =~ s/__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +//;
     $prototype =~ s/__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +//;
     $prototype =~ s/__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +//;

