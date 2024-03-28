Return-Path: <linux-kernel+bounces-123071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8758901C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4AE297315
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC57127B56;
	Thu, 28 Mar 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2d9fAo9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E31F956;
	Thu, 28 Mar 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636278; cv=none; b=I/aMZhZKsjWXGMdIEyd+k2KLYzLZrzrENIWLWPyUWIsBn39p74R5+AxdnuzNWRG1mNaeKbNEqQZC8b1g34znxgQA4kcpPPgjJEAiIbtGOjEsxXPWU/LLn60/9qV8De7/LI9qts7riC1uFXIqLwqrl6kANHrCqzJxjanMNLZo4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636278; c=relaxed/simple;
	bh=qLTItqdV1pMOYIR5NzMljZd3lTmzZJ0cmUVlffUJXOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vFkZ4zXWwPcnwdfy0/I7FOCwkHhL9fZmrPfDGDW6A2eccaZrJCSVcU851qr8UsnFBOFFfvNzgAADQa9zxae2q8lvA+2dvfAkXop5TdBgyebbkmsFUWChlAM3/xWs83u5CCAAZhxMEX3r3HWBtQCswvgPEFZ02VpPihHCoQgMvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2d9fAo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51975C433F1;
	Thu, 28 Mar 2024 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636278;
	bh=qLTItqdV1pMOYIR5NzMljZd3lTmzZJ0cmUVlffUJXOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2d9fAo9l+RMifg9C2gpTjTxtlEnbc65SGwqNNTgbuuAzhHYgA0P0b28L4CPW+sr9
	 Fpsi7I9Q/+gpZbbFSciEBbv0/hg1HbU4xm4U+DFd+T4rdxu8ZzYlMTUi2Dw27ecOnC
	 zVy7RasweOpWGuyMmIR5SVzq00iMsmny+OJTVHCQ8817jhQFjP35hr5beC6UDeKt3r
	 pJm5XmRO6l2P0tAugEtHwHbjj3AgZvXxzSL4eREX0TIzGr07M4U3E5BIO7JVbdoXNh
	 ip3KAasRyCAFwARgbJlqvzan/ek5Nd7PRO8gnel3VqSqTvJhCwbKG1BDKVTruPzA/+
	 eOkIYSsAlAO0A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Eric Biggers <ebiggers@google.com>,
	llvm@lists.linux.dev
Subject: [PATCH 1/9] dm integrity: fix out-of-range warning
Date: Thu, 28 Mar 2024 15:30:39 +0100
Message-Id: <20240328143051.1069575-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328143051.1069575-1-arnd@kernel.org>
References: <20240328143051.1069575-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Depending on the value of CONFIG_HZ, clang compares about a pointless
comparison:

drivers/md/dm-integrity.c:4085:12: error: result of comparison of constant 42949672950 with expression of type 'unsigned int' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
                        if (val >= (uint64_t)UINT_MAX * 1000 / HZ) {

As the check remains useful for other configurations, shut up the
warning by adding a second type cast to uint64_t.

Fixes: 468dfca38b1a ("dm integrity: add a bitmap mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 37b9f8f1ae1a..7f3dc8ee6ab8 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4221,7 +4221,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 		} else if (sscanf(opt_string, "sectors_per_bit:%llu%c", &llval, &dummy) == 1) {
 			log2_sectors_per_bitmap_bit = !llval ? 0 : __ilog2_u64(llval);
 		} else if (sscanf(opt_string, "bitmap_flush_interval:%u%c", &val, &dummy) == 1) {
-			if (val >= (uint64_t)UINT_MAX * 1000 / HZ) {
+			if ((uint64_t)val >= (uint64_t)UINT_MAX * 1000 / HZ) {
 				r = -EINVAL;
 				ti->error = "Invalid bitmap_flush_interval argument";
 				goto bad;
-- 
2.39.2


