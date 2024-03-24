Return-Path: <linux-kernel+bounces-115766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3DF88978D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C9C29ACEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894A2618D1;
	Mon, 25 Mar 2024 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M54M4HVv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6501448F9;
	Sun, 24 Mar 2024 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321966; cv=none; b=gY6qfk3Da7+i9f5RyqhOB3Ie9nP42G1IF2nXxJZGwRL5tBqownFwBR+KB35O4fF3cOI+RwZrO3UisGdPXt5l+JwxAsbei8dcAwtPOkj+E17SjyWUTaQYDXaUOvMPsTz8eL6YXapgn75q9r4LnUWKkcJtb6uudgioZPyRHB35VNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321966; c=relaxed/simple;
	bh=I8eGADWXPdjdnNTSJAoWWwQMWOP7eoIUp9QQbE5rUWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lx2EAcanUzfzl7EueYe+ik8fZBT4/Kouii7Ywzw1qhlbORlaAYTtCaxxRkspkhLQb/wll/9Wr7fBI0jaKbn820bFztYyuvtdNKLx+O9X2PXOSR0GvI+xhyQSPEViB4GL/uGrNbJB6n28YVWuiOX+rv0/TH4P4mH2LcUedI7QIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M54M4HVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB735C433C7;
	Sun, 24 Mar 2024 23:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321966;
	bh=I8eGADWXPdjdnNTSJAoWWwQMWOP7eoIUp9QQbE5rUWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M54M4HVvGdbg0Poj4jU8CigggmTpTJzTEF3wXBBXHtmXVfN/23uW3bJ7x5DHEfV02
	 S+KI3vDn28J8rKoiRdxgL91Cn0ptqlb9pKBD2JiH7FujlQohAj9ky2F41VzrpCTTEc
	 IDr/ToZbjybNdOKTy/G+3vhzM36RS0manpaxIxlNsTd/Qa6FgMcp8/QgPhG4hTXn8/
	 VRj7Opswj3+MYWd1Z4HuGJOgBpRU/okIds3OEAofnTsP5KXIMACCDmgMABFNZdXKuH
	 mmm43zK8rquD4y02AAcpQsCn1GMlBJa4QK29QUoYF9nVmMo7AwMKJVZxMFdYUwofpQ
	 RIax5WFIv6Twg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 038/451] dm-verity, dm-crypt: align "struct bvec_iter" correctly
Date: Sun, 24 Mar 2024 19:05:14 -0400
Message-ID: <20240324231207.1351418-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 3e215aa85b99a..e8c534b5870ac 100644
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
index 4620a98c99561..db93a91169d5e 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -80,12 +80,12 @@ struct dm_verity_io {
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
 
 	char *recheck_buffer;
-- 
2.43.0


