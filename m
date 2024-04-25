Return-Path: <linux-kernel+bounces-158572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 335698B2249
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83B01F2673D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0335149C5E;
	Thu, 25 Apr 2024 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bVlE6mk2"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AC3717F;
	Thu, 25 Apr 2024 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050746; cv=none; b=Vw4TnVRkUnQ3tS1wHyoYYal55e3z757YO/rueFMS8627NZTLRH9UaLSFrhBWI0+To+LvKxRqY2E068dSdyMXSBhNdAMWTMOON0JBJk9JDR1SY+1ROMbGyaQZWxjD8zi6FgQJBzSnpP75pce49Dmmwhqdw7DbWDBTigRhWEnkMlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050746; c=relaxed/simple;
	bh=jwu57ioxDHFHYb2H4BekzE6s7a/+kDgLmSQBk4z/Wck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcrPVJU12Nif/H4byTWezmGIDTwOmY2d6N4lbz6QyPSfmc3Plz1KqYhnUtew++ZNCfXq01Nc9P3To3s2oAJfT3mX+usp6OyJgR88h8laZqOLoCv4uuhULFipwm31SP1+jlxBjU1BtdsGgz6+WbTsTjadJxxKHinhLHOauVvHHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bVlE6mk2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JX9qBQ7VAepgiukLD5OGQzhQEBGgQLKoeCn+uha43Z8=; b=bVlE6mk2ULmgnXAbrNSirOX6s7
	8jWxcb68KZ0Epcq+T/k3psD6jBs6Dp1obTwaN62VEd+b06EQ8LOLdnt90YRpyKZ6U0jbJKG1+u3qd
	06SPJ7dH3hNAumGTwYfWgNkn9uVcU2nLaFspepLaxh6TvotJpyVwvCBehu77jrVAMK7iQRNin+mzJ
	ms6zkzArJ/PaddwRCCmN+TW6lQT+fjMFx405s4d9yGmoBoafHEw5xXTTx/t2tZoKSYFMVcqH7VUWo
	4foZ3ZDHJxOCv628Jqxh/ILFUbLZLKdf3yIInJyUeELPVVWDld/Y7mqp9wsivxbiJpF5NXW/jieS2
	j6FICUxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzytj-00000008QCX-3z5k;
	Thu, 25 Apr 2024 13:12:23 +0000
Date: Thu, 25 Apr 2024 06:12:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	djwong@kernel.org, chandan.babu@oracle.com,
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com,
	Brian Foster <bfoster@redhat.com>
Subject: Re: [Linux kernel bug] KASAN: slab-out-of-bounds Read in xlog_cksum
Message-ID: <ZipWt03PhXs2Yc84@infradead.org>
References: <CAEkJfYO++C-pxyqzfoXFKEvmMQEnrgkQ2QcG6radAWJMqdXQCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkJfYO++C-pxyqzfoXFKEvmMQEnrgkQ2QcG6radAWJMqdXQCQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This triggers the workaround for really old xfsprogs putting in a
bogus h_size:

[   12.101992] XFS (loop0): invalid iclog size (0 bytes), using lsunit (65536 bytes)

but then calculates the log recovery buffer size based on the actual
on-disk h_size value.  The patch below open codes xlog_logrec_hblks and
fixes this particular reproducer.  But I wonder if we should limit the
workaround.  Brian, you don't happpen to remember how old xfsprogs had
to be to require your workaround (commit a70f9fe52daa8)?

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index b445e8ce4a7d21..b3ea546508dc93 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2999,7 +2999,7 @@ xlog_do_recovery_pass(
 	int			error = 0, h_size, h_len;
 	int			error2 = 0;
 	int			bblks, split_bblks;
-	int			hblks, split_hblks, wrapped_hblks;
+	int			hblks = 1, split_hblks, wrapped_hblks;
 	int			i;
 	struct hlist_head	rhash[XLOG_RHASH_SIZE];
 	LIST_HEAD		(buffer_list);
@@ -3055,14 +3055,16 @@ xlog_do_recovery_pass(
 		if (error)
 			goto bread_err1;
 
-		hblks = xlog_logrec_hblks(log, rhead);
-		if (hblks != 1) {
-			kvfree(hbp);
-			hbp = xlog_alloc_buffer(log, hblks);
+		if ((rhead->h_version & cpu_to_be32(XLOG_VERSION_2)) &&
+		    h_size > XLOG_HEADER_CYCLE_SIZE) {
+			hblks = DIV_ROUND_UP(h_size, XLOG_HEADER_CYCLE_SIZE);
+			if (hblks > 1) {
+				kvfree(hbp);
+				hbp = xlog_alloc_buffer(log, hblks);
+			}
 		}
 	} else {
 		ASSERT(log->l_sectBBsize == 1);
-		hblks = 1;
 		hbp = xlog_alloc_buffer(log, 1);
 		h_size = XLOG_BIG_RECORD_BSIZE;
 	}

