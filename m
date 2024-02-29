Return-Path: <linux-kernel+bounces-87520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B6586D56F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5E21C2237A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A073E16F0A2;
	Thu, 29 Feb 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQFktMAZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B9816D60F;
	Thu, 29 Feb 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239321; cv=none; b=ZB/BWz1dPyhJu2/I+aWbL+RMkbgOENnnRDfECVUAR50cw8b2c5hlxjs5ZOmITOZzgFA6pkKsGwmhAaqtD4rrk2IUSlkopFTvJ9lqBuqhyDneYBtGBFKIwL4UrNQZeYJfG95Iz67ihM2Y3NI8s3V4mz8saDn5vgacQQmpts2KBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239321; c=relaxed/simple;
	bh=CoV07kSb/A/ldhgRhAX040faYNYxN/IJ9SXNczYn0wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjGt1avHWQ5f3l0NRjo2PFzJvi5QtvDPBMvL7jnoTbMWmPF+iExRqrFXU5kA4Stj2mqM9AFWVhKcxxS0YIbziiposWUfZa0NDcwR2f/g4PTihUPFmhwO5Ir39P+mgig559fwWb7Uw9MI0eGYjC7eqvwt/P3TpUVaJ5ImAVcpKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQFktMAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B476C433C7;
	Thu, 29 Feb 2024 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239320;
	bh=CoV07kSb/A/ldhgRhAX040faYNYxN/IJ9SXNczYn0wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQFktMAZo2rMu8nWGmX1ArwpQnVy7Dq4yVMsQHBm3FTqVfn5ZW4nKN2nPcP9R95xH
	 8x4+hXWQEm00z6IGd+MtKpGlDRO86w3tZRrEeQfGeX4lEKNWcoikcu6lclCQFws84P
	 sEJcjTb6146OP60B9KPj5IoZk/D0kvbgAykoKt4CRDMEGe+pSW39l+jEsaPQSvEgSK
	 IBzKqU+SCnjiBQj1Sh3ncD4qO56ZSFrD1mCSIsI0Up3acFfnlITs6eZ2fjo/TafoHx
	 0ZyRJRcDfw4oq9Z1bLggkqQMmmUqPE3xNxatg7fDNJ1l549IhVqRpJPip5XwEVPxNZ
	 NpExOf/sr8Z8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	jonathan.derrick@linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/6] block: sed-opal: handle empty atoms when parsing response
Date: Thu, 29 Feb 2024 15:41:45 -0500
Message-ID: <20240229204150.2862196-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204150.2862196-1-sashal@kernel.org>
References: <20240229204150.2862196-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.269
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


