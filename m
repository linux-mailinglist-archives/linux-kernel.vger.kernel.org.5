Return-Path: <linux-kernel+bounces-10613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8881981D768
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 01:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AED1F21E14
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 00:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23367EA;
	Sun, 24 Dec 2023 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OBiZeFuR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B4RioCQ6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OBiZeFuR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B4RioCQ6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E719E;
	Sun, 24 Dec 2023 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from suse-arm.lan (unknown [10.149.192.130])
	by smtp-out1.suse.de (Postfix) with ESMTP id B587321C43;
	Sun, 24 Dec 2023 00:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703377709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GRwt3rxs+HdNwBEMSM31p2jJ2iR9ZpXVHm+b/grQRjM=;
	b=OBiZeFuRcCkVYk0dCDw+30EvT2LT4rNwYreEfvzl/G1gvFuBzST8lYkXQwQS8ZsxmsxEac
	4Il0dFEvkaWCXVk28c/FFSv/yBDn4Vu1J8DeV90u2WDfnpWO3ohx+rPXxi3BFStT2Yd5GG
	RrZ+lFlYdylGtDKM+6S+2tQ1pPbRsvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703377709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GRwt3rxs+HdNwBEMSM31p2jJ2iR9ZpXVHm+b/grQRjM=;
	b=B4RioCQ63zFPioBvVUArxH93MhqIL1hDCL5ZF1vbxNCY1K/LjS2WWk8T7RtMtZz2Mi3E0h
	1c7zpVNIFvTj0zDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703377709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GRwt3rxs+HdNwBEMSM31p2jJ2iR9ZpXVHm+b/grQRjM=;
	b=OBiZeFuRcCkVYk0dCDw+30EvT2LT4rNwYreEfvzl/G1gvFuBzST8lYkXQwQS8ZsxmsxEac
	4Il0dFEvkaWCXVk28c/FFSv/yBDn4Vu1J8DeV90u2WDfnpWO3ohx+rPXxi3BFStT2Yd5GG
	RrZ+lFlYdylGtDKM+6S+2tQ1pPbRsvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703377709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GRwt3rxs+HdNwBEMSM31p2jJ2iR9ZpXVHm+b/grQRjM=;
	b=B4RioCQ63zFPioBvVUArxH93MhqIL1hDCL5ZF1vbxNCY1K/LjS2WWk8T7RtMtZz2Mi3E0h
	1c7zpVNIFvTj0zDw==
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Geliang Tang <geliang.tang@suse.com>,
	Hannes Reinecke <hare@suse.de>,
	NeilBrown <neilb@suse.de>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	Xiao Ni <xni@redhat.com>
Subject: [PATCH] badblocks: avoid checking invalid range in badblocks_check()
Date: Sun, 24 Dec 2023 08:28:20 +0800
Message-Id: <20231224002820.20234-1-colyli@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: **********
X-Spam-Score: 10.12
X-Spamd-Result: default: False [10.12 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.86)[0.953];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(2.36)[0.674];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[28.29%]
X-Spam-Flag: NO

If prev_badblocks() returns '-1', it means no valid badblocks record
before the checking range. It doesn't make sense to check whether
the input checking range is overlapped with the non-existed invalid
front range.

This patch checkes whether 'prev >= 0' is true before calling
overlap_front(), to void such invalid operations.

Fixes: 3ea3354cb9f0 ("badblocks: improve badblocks_check() for multiple ranges handling")
Reported-and-tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/nvdimm/3035e75a-9be0-4bc3-8d4a-6e52c207f277@leemhuis.info/
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: NeilBrown <neilb@suse.de>
Cc: Vishal L Verma <vishal.l.verma@intel.com>
Cc: Xiao Ni <xni@redhat.com>
---
 block/badblocks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index fc92d4e18aa3..db4ec8b9b2a8 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1312,12 +1312,14 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	prev = prev_badblocks(bb, &bad, hint);
 
 	/* start after all badblocks */
-	if ((prev + 1) >= bb->count && !overlap_front(bb, prev, &bad)) {
+	if ((prev >= 0) &&
+	    ((prev + 1) >= bb->count) && !overlap_front(bb, prev, &bad)) {
 		len = sectors;
 		goto update_sectors;
 	}
 
-	if (overlap_front(bb, prev, &bad)) {
+	/* Overlapped with front badblocks record */
+	if ((prev >= 0) && overlap_front(bb, prev, &bad)) {
 		if (BB_ACK(p[prev]))
 			acked_badblocks++;
 		else
-- 
2.35.3


