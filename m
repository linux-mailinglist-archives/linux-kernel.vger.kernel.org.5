Return-Path: <linux-kernel+bounces-87525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB86B86D57E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553E9288DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648C16FF4B;
	Thu, 29 Feb 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQkzByet"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D742716FF2F;
	Thu, 29 Feb 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239334; cv=none; b=MFymk+pfHUdgrPLnVkczgM2qxWfd/nIP21F6OXo0QBMQbIuUZRG3J7lFXAvmHNF2QgEn5HcmyU8nbz+3vpFfz4hTwIGaUpe6lf99U/rL6nwXLpnxRfpV+G6IBcGBTTfXu6xJaME0NthQrMqiOCdIDfMbIfZWk1G+lCcEEbvb2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239334; c=relaxed/simple;
	bh=TPoEWdsLsO5MgKxk/CGhcQr3scilYGPhI2nKziaOJO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuc9uJ9OtfLjm7Vshw/0qngaK/xcmwy7M/B7ZvANZiO9AY3/LzQfhBQ1KRGZjqckWy9MWBHQCuzvidGao5wa417SZouwekLDb4/U4+4UZZxnpdR+o8YD2Z1COsrbV+gaFAhpUPBdoe8sfbRbPCqYbi0n0dTm5hDpoXxLAcHsa8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQkzByet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9119C43394;
	Thu, 29 Feb 2024 20:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239334;
	bh=TPoEWdsLsO5MgKxk/CGhcQr3scilYGPhI2nKziaOJO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQkzByetWDnsoa4ofUfqBbGY4lzFaPJpAQe1ixKn8HCJjXaYXgvITzEGBFaUtc3CJ
	 GCil8vEFz9IcSV8WtpQ0hNAuYJpCZtC87dTB/9dXIW0b4Cz7qKfs7h+UeAhEzIdf1i
	 MF3HOcxs9PBvcC+reKZg+7yOs6T50ocUFkEWBOkpJ+5wW7s40Vk1Q5ijFSLgliOpt8
	 gyxfV8+x1Uz/LJR036EwC8DXwvMasPXS2+YDXIIDhkn1oq1GpycqHvTmASofRVZW2c
	 iqpYAzqsRJlH1gmVwl/MWZNZw5rch/wIwQUg0g+g52db4dmUYw6jHVXGSZSbpArLOn
	 IqXizZ1ksRRcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	agk@redhat.com,
	dm-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19 4/4] dm-verity, dm-crypt: align "struct bvec_iter" correctly
Date: Thu, 29 Feb 2024 15:42:04 -0500
Message-ID: <20240229204208.2862333-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204208.2862333-1-sashal@kernel.org>
References: <20240229204208.2862333-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.307
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
index 908bf07688275..d094dd274c461 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -46,11 +46,11 @@
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
index 6e65ec0e627a6..04ef89e318564 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -72,11 +72,11 @@ struct dm_verity_io {
 	/* original value of bio->bi_end_io */
 	bio_end_io_t *orig_bi_end_io;
 
+	struct bvec_iter iter;
+
 	sector_t block;
 	unsigned n_blocks;
 
-	struct bvec_iter iter;
-
 	struct work_struct work;
 
 	/*
-- 
2.43.0


