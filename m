Return-Path: <linux-kernel+bounces-116247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82481889DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374A91F36C01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4123D3C4234;
	Mon, 25 Mar 2024 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abvjcbrf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F617EB84;
	Sun, 24 Mar 2024 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324011; cv=none; b=oS1UaZr5xy3yFIc9a0sHwM3FciaEPuGcST46DMWJNJJC8sI0ArmziqkRWNpLxSXj+lGIaZ+uwNDJh9k6ivYUtuRcjU6Dj9zT3x/1ruKuKcFKawn0h0vN+xV5LdkXV/vAN/UITXacK+gKGN5mygBwSSrFRMXPgKG2Laq+XDCB3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324011; c=relaxed/simple;
	bh=CoV07kSb/A/ldhgRhAX040faYNYxN/IJ9SXNczYn0wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWRfwEnXp+Nu8y3CxxMJVCPgYjmQ98ZLhXq/hp40/hYxC4WC2VOKg67i5PGFRUWy4YUDiQeSBKT2t8cRiJdXyKtQf/IXnyAG74ck4gdGDZHpYvD50ZMSbJxDn2rbnwtdQSOFbrXq5ylIQuBV5mTR1qAvlbCc4/0IxWVS5OMImVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abvjcbrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE56C433C7;
	Sun, 24 Mar 2024 23:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324010;
	bh=CoV07kSb/A/ldhgRhAX040faYNYxN/IJ9SXNczYn0wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abvjcbrfC3UgM81KbND2tLP/WDYDljgExCssu8S2rPzZlQ7myHfQGZUFXflcS7e4/
	 kHJ4s81a9eYHHD7G4UfTMX2Asv/Az7HpuBLHgbk7ujMA0kNyXARJp0BAb8QRabQN+W
	 vUVvDNkGM9wcRJukPwIDSTrwzW1FsIhl+k/Ru7BE2qsSpYp5LqxqSA8i7TV+Fklerk
	 XywPD2sZrlxdoM5+Z754wwjqXf6EPNEAQCzvhhLavf6H+0uT7oV5Ssq8J5okyd/pa2
	 0JNhcsdMzjRrOOLJ5gKuNMFCUcYw46p1xP0+W8lkn1zYONdEx33JGo/yZ6mP8cCM5m
	 je/nyEnQs4NDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 011/183] block: sed-opal: handle empty atoms when parsing response
Date: Sun, 24 Mar 2024 19:43:44 -0400
Message-ID: <20240324234638.1355609-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 5532412d567c0..354b4e93bf63e 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -65,6 +65,7 @@ enum opal_response_token {
 #define SHORT_ATOM_BYTE  0xBF
 #define MEDIUM_ATOM_BYTE 0xDF
 #define LONG_ATOM_BYTE   0xE3
+#define EMPTY_ATOM_BYTE  0xFF
 
 #define OPAL_INVAL_PARAM 12
 #define OPAL_MANUFACTURED_INACTIVE 0x08
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 401d33ae01580..1a08762515291 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -893,16 +893,20 @@ static int response_parse(const u8 *buf, size_t length,
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
 
 	resp->num = num_entries;
-- 
2.43.0


