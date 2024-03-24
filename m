Return-Path: <linux-kernel+bounces-116306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8AA88A5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70395B480CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6133D0CDD;
	Mon, 25 Mar 2024 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEnzQu0e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD71836D8;
	Sun, 24 Mar 2024 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324223; cv=none; b=qsaA7cyeiZhcS6gArMj7XztheBdFJDEaqAFV/8AFb/S8wnhT/JWvq+VMP+X4eW1z0oTWbc2Dv1+wb6jKi+G3j6WGXzDKeNwF8RSBk3w9PqnyFcnbjQ0hJzpSXSUEzzL56dH/RfIFS4Yy2LNZ+n7SOqZFIStn9K/rBnsFBqC/RFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324223; c=relaxed/simple;
	bh=pPqTwLB7TLaUTeD8LOWSvUk2b+PMhg//U8wFczNoAVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCHAqgwgYWBTQR7ZH9qaM6gEsUYeMiZzcU1NkymnWbd9fxzJ7GF5EwNrInxhYP+BJA9mpAxlk/QXCC/HaxnDkm05B2VvTcgJX90AvM8hFq0FpL+PLwf1E4Rkq4WD7WjjbWRiP65zuyKcXMznd79nzUCKSlIOT7mWj03D4dHn2YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEnzQu0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D1DC433F1;
	Sun, 24 Mar 2024 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324221;
	bh=pPqTwLB7TLaUTeD8LOWSvUk2b+PMhg//U8wFczNoAVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEnzQu0eDIgMMy8LR43mfGcZPFswBf3Lryc8MB1tXtTxgX9up+RSYT9IcAetIwtNy
	 ruZ7ayw181ByaHBuAPwUDDElcRny7kbdHyXLKVWJUWUM5v2txIrO5/SANm2tLeeDKQ
	 X2p/ayyEp1uhvuWjLDCaoN8DAanbyDCe8maIScJQOY8ATV9pmrZ5Ufbs+LaulUXC4h
	 Ldyv7VEgjR5QlpbEVxMkIfvhivTgxR4ykPcnG22FS7Yxr6RMzaOTeh3gGqZg3sM+S2
	 SNxAXVXDKez61nOhjB5d0iNf46/B/owh+tLVKRCMyp278rkdfXELaeZi/jKHl+A1HC
	 CkTYtRpC5I6mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 005/148] block: sed-opal: handle empty atoms when parsing response
Date: Sun, 24 Mar 2024 19:47:49 -0400
Message-ID: <20240324235012.1356413-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Greg Joyce <gjoyce@linux.ibm.com>

[ Upstream commit 5429c8de56f6b2bd8f537df3a1e04e67b9c04282 ]

The SED Opal response parsing function response_parse() does not
handle the case of an empty atom in the response. This causes
the entry count to be too high and the response fails to be
parsed. Recognizing, but ignoring, empty atoms allows response
handling to succeed.

Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
Link: https://lore.kernel.org/r/20240216210417.3526064-2-gjoyce@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/opal_proto.h | 1 +
 block/sed-opal.c   | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index e20be82588542..2456b8adc4574 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -73,6 +73,7 @@ enum opal_response_token {
 #define SHORT_ATOM_BYTE  0xBF
 #define MEDIUM_ATOM_BYTE 0xDF
 #define LONG_ATOM_BYTE   0xE3
+#define EMPTY_ATOM_BYTE  0xFF
 
 #define OPAL_INVAL_PARAM 12
 #define OPAL_MANUFACTURED_INACTIVE 0x08
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9651c40e093a5..7c7cd27411541 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -844,16 +844,20 @@ static int response_parse(const u8 *buf, size_t length,
 			token_length = response_parse_medium(iter, pos);
 		else if (pos[0] <= LONG_ATOM_BYTE) /* long atom */
 			token_length = response_parse_long(iter, pos);
+		else if (pos[0] == EMPTY_ATOM_BYTE) /* empty atom */
+			token_length = 1;
 		else /* TOKEN */
 			token_length = response_parse_token(iter, pos);
 
 		if (token_length < 0)
 			return token_length;
 
+		if (pos[0] != EMPTY_ATOM_BYTE)
+			num_entries++;
+
 		pos += token_length;
 		total -= token_length;
 		iter++;
-		num_entries++;
 	}
 
 	if (num_entries == 0) {
-- 
2.43.0


