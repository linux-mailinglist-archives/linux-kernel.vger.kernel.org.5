Return-Path: <linux-kernel+bounces-57760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4B784DD1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA9B26740
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F56BFC2;
	Thu,  8 Feb 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="NVlOusRq"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D86BB2F;
	Thu,  8 Feb 2024 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385045; cv=none; b=e6XCrUQWXCuiiT9cGf3kPdBj54jGhUkcAsIl2VB6n0gRJHpFHliDKGXrU83IlWZr2n/TVqb0zDS4mHiTwbgngL1GecWOVbGj8O28v2uhc9mqV0HpkKwY4awCM5fkkdD/qJDB/7cUUEdmzkxipJOPxXuND3MrWqZv90uKzQRqtAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385045; c=relaxed/simple;
	bh=3Q2iyKC4hyp8AoOZUqz27l11mkhP1r9E0t2phlEb+Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c1YQYn20twW76s7bKXM6rVrVzESYT0O6WTh8uR6zA7KKlndB9dvtKMXRfuWGR94Q3Txl782ZkogDSUZajP6HnCpwXZoIHxvsUlPCbmyAekrAHPxFeB85xCJ9keGdhL69/nKCqgBZXOL5+bPWRg8GoTLV7PEOTR4DJCiPR1UJonU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=NVlOusRq; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id D37D740755CC;
	Thu,  8 Feb 2024 09:37:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D37D740755CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707385031;
	bh=2icsXM4sghF71ROYFCFa6roBWVoViRGL+G2hZIeLN2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=NVlOusRqo/vP1OrfsuqYNRGwY5C9++itFnlj14yUQ6+AwsQ4QEdlh5gLhmU3FDSW5
	 oMk7LvL1rPu3oPs9JkKZWAG3B1byV1SmiPnUNO91WvAl6BqSc0+vR/epcA74l4wAKF
	 Cr+X0r7Gz8m/sOmOzhC/bpSLWGFLTmUsumy1sl0g=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: James Smart <james.smart@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] scsi: elx: efct: adjust error handling inside efct_hw_setup_io
Date: Thu,  8 Feb 2024 12:36:57 +0300
Message-Id: <20240208093657.19617-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IO and WQE buffers are allocated once per HW and can be reused later. If
WQE buffers allocation fails then the whole allocation is marked as failed
but already created IO array internal objects are not freed. hw->io is
freed but not nullified in that specific case - it may become a problem
later as efct_hw_setup_io() is supposed to be reusable for the same HW.

While at it, use kcalloc instead of kmalloc_array/memset-zero combination
and get rid of some needless NULL assignments: nullifying hw->io[i]
elements just before freeing hw->io is not really useful.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/scsi/elx/efct/efct_hw.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
index 5a5525054d71..e5486e6949f9 100644
--- a/drivers/scsi/elx/efct/efct_hw.c
+++ b/drivers/scsi/elx/efct/efct_hw.c
@@ -487,12 +487,10 @@ efct_hw_setup_io(struct efct_hw *hw)
 	struct efct *efct = hw->os;
 
 	if (!hw->io) {
-		hw->io = kmalloc_array(hw->config.n_io, sizeof(io), GFP_KERNEL);
+		hw->io = kcalloc(hw->config.n_io, sizeof(io), GFP_KERNEL);
 		if (!hw->io)
 			return -ENOMEM;
 
-		memset(hw->io, 0, hw->config.n_io * sizeof(io));
-
 		for (i = 0; i < hw->config.n_io; i++) {
 			hw->io[i] = kzalloc(sizeof(*io), GFP_KERNEL);
 			if (!hw->io[i])
@@ -502,10 +500,8 @@ efct_hw_setup_io(struct efct_hw *hw)
 		/* Create WQE buffs for IO */
 		hw->wqe_buffs = kzalloc((hw->config.n_io * hw->sli.wqe_size),
 					GFP_KERNEL);
-		if (!hw->wqe_buffs) {
-			kfree(hw->io);
-			return -ENOMEM;
-		}
+		if (!hw->wqe_buffs)
+			goto error;
 
 	} else {
 		/* re-use existing IOs, including SGLs */
@@ -586,10 +582,8 @@ efct_hw_setup_io(struct efct_hw *hw)
 
 	return 0;
 error:
-	for (i = 0; i < hw->config.n_io && hw->io[i]; i++) {
+	for (i = 0; i < hw->config.n_io && hw->io[i]; i++)
 		kfree(hw->io[i]);
-		hw->io[i] = NULL;
-	}
 
 	kfree(hw->io);
 	hw->io = NULL;
-- 
2.39.2


