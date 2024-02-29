Return-Path: <linux-kernel+bounces-87494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E899586D51C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8183E285DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5AB160ED8;
	Thu, 29 Feb 2024 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0tah5ck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A156160EC9;
	Thu, 29 Feb 2024 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239259; cv=none; b=VqRi7ZwzOc21ejJbujJIMmpiV+7Dymsy8TUAOl7Whi3ZJQNl3Zp8weI/Ck5X2XuJnOWzAgaEYIFrYuQTCPI9HSETWsaLr5cc/k5L1+vrjL8AVvICQ5Hy7rQ5wLoUmgaYY86FA6/s9PiurdZM1YTimoYdzaMNJaXCHMTJEj1yuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239259; c=relaxed/simple;
	bh=k5TJ/unVkkl2NEEhs0cdRZBa4hmgu0vlMRhP0EoE5UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hH7xyqejn3oQRGMZTtQoza+vRe4LJsEzGzUi7VWFj5zveHNS2wheUp/lx4eutoX/eUF6zyjuZV5EpCzqum1Qnm5T9xdXK9sLfYbj5NOTLhDBmn1fXJKlZlFLwAb93+q5OeYrXQ9xsF0ek0PfozTbxlp8/6bbvO26/W+rbUeH2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0tah5ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E262CC43390;
	Thu, 29 Feb 2024 20:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239258;
	bh=k5TJ/unVkkl2NEEhs0cdRZBa4hmgu0vlMRhP0EoE5UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0tah5ckOS0lTUbFyfYVQSbdqrKhvhFZBb+BXp5XPjHUJNbHNmOPUDe6NMXvNkwg3
	 r7bgDFoLj7fWs2KLXifO7ZbsdDXReLYeLHw36gwUe6w0CNrGTUMrqjo/G+v3TpvLGe
	 1/o3Cbp3+Vzjc6WBx+tJBfVZa/TJSxIYAxPracyS2qdxf0OHvmb08rtIecNtrFBdLZ
	 1YXME0JOj8VIagzo6yTsx2hT8SCfr6QOG3pA2KnWYBZ+WdcO+jv3e6JqT+8i0I+L8a
	 wRuXlOLzFE8dFBM2A9RBZg+boNQZ0V/r7NfzCFmxc1PFpwibcpNGrw19SgNFhokhgQ
	 gnp7JCDQbs3mA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	agk@redhat.com,
	dm-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 11/12] dm-verity, dm-crypt: align "struct bvec_iter" correctly
Date: Thu, 29 Feb 2024 15:40:33 -0500
Message-ID: <20240229204039.2861519-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204039.2861519-1-sashal@kernel.org>
References: <20240229204039.2861519-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 787f1b2800464aa277236a66eb3c279535edd460 ]

"struct bvec_iter" is defined with the __packed attribute, so it is
aligned on a single byte. On X86 (and on other architectures that support
unaligned addresses in hardware), "struct bvec_iter" is accessed using the
8-byte and 4-byte memory instructions, however these instructions are less
efficient if they operate on unaligned addresses.

(on RISC machines that don't have unaligned access in hardware, GCC
generates byte-by-byte accesses that are very inefficient - see [1])

This commit reorders the entries in "struct dm_verity_io" and "struct
convert_context", so that "struct bvec_iter" is aligned on 8 bytes.

[1] https://lore.kernel.org/all/ZcLuWUNRZadJr0tQ@fedora/T/

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-crypt.c  | 4 ++--
 drivers/md/dm-verity.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 0e6068ee783e7..6aaf8416ef56b 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -52,11 +52,11 @@
 struct convert_context {
 	struct completion restart;
 	struct bio *bio_in;
-	struct bio *bio_out;
 	struct bvec_iter iter_in;
+	struct bio *bio_out;
 	struct bvec_iter iter_out;
-	u64 cc_sector;
 	atomic_t cc_pending;
+	u64 cc_sector;
 	union {
 		struct skcipher_request *req;
 		struct aead_request *req_aead;
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index f3f6070084196..5265b0d9ea37c 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -76,12 +76,12 @@ struct dm_verity_io {
 	/* original value of bio->bi_end_io */
 	bio_end_io_t *orig_bi_end_io;
 
+	struct bvec_iter iter;
+
 	sector_t block;
 	unsigned int n_blocks;
 	bool in_tasklet;
 
-	struct bvec_iter iter;
-
 	struct work_struct work;
 
 	/*
-- 
2.43.0


