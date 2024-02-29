Return-Path: <linux-kernel+bounces-87470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158A286D4D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52AB284A11
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323315E044;
	Thu, 29 Feb 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWlgZ9uw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6C15E031;
	Thu, 29 Feb 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239198; cv=none; b=fVPlvrKZrWSxrtJ9THDdXZ2SbInm3mGr1xLY7NCmTiXaV/NPhlKFckJN8VbIVUS5yKaglXsupbhzU7aDfO1/eZRzoanxbU8q1ShQ2JViehGHEzv4XLFZ1f3sTkwXdnzvC5sQ69L/FbLkutXnfIOt3RKhkiEgV8o/gAWn7VM5X+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239198; c=relaxed/simple;
	bh=mxRUa5CthTVInxGr8kKOevfXkarA6jUudOI+9gLETuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4U7cBCQUtMHfL8g2CSd05/+7FZN3QS7O9V4D/QCpDO1R0cXnwpudqwfSDqm/EonrZjFOHUUot6f7k7BWxr7HF6VzUuzcBwvTH8S1AdzhvhgNxffPapk6tOBjkPUfdSDPaQXeh3i8U1sgE2l90B/NRKdqeYhRuuLEKTFe1o9uNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWlgZ9uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC78C43399;
	Thu, 29 Feb 2024 20:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239197;
	bh=mxRUa5CthTVInxGr8kKOevfXkarA6jUudOI+9gLETuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWlgZ9uwITK9DReULcdDIrGZnQbvaNXe02VhOV4hyf1eZHKSMTh2zkpKqvsiHmoTK
	 g3FVDN9mdYMlixtCtT5aG2r4Vp8JUdxU0QqPG6WjO4VSnih4VncP8KxvS36NHDAuwK
	 8bXmAFOkDJYIlez7j3zq15r+Q87S8tN1FZZlrpHv85Pas/ISfb/o94t5yMdRH+uhB2
	 s9bOswTgJxlfbwDL1wGfUNkjcMaoILeZJ4R0Bzsxgpt79Lw2VhfusEob5ZB96n285z
	 fqDZcxGEDauB8sUe35VeEOzuqcaPb12DfUxhY/quvf/Hd0J6eg0fGD44dy1+lGowld
	 4ztob6BTaFHZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	jonathan.derrick@linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/22] block: sed-opal: handle empty atoms when parsing response
Date: Thu, 29 Feb 2024 15:39:04 -0500
Message-ID: <20240229203933.2861006-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203933.2861006-1-sashal@kernel.org>
References: <20240229203933.2861006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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
index dec7ce3a3edb7..d247a457bf6e3 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -71,6 +71,7 @@ enum opal_response_token {
 #define SHORT_ATOM_BYTE  0xBF
 #define MEDIUM_ATOM_BYTE 0xDF
 #define LONG_ATOM_BYTE   0xE3
+#define EMPTY_ATOM_BYTE  0xFF
 
 #define OPAL_INVAL_PARAM 12
 #define OPAL_MANUFACTURED_INACTIVE 0x08
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 04f38a3f5d959..e27109be77690 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1055,16 +1055,20 @@ static int response_parse(const u8 *buf, size_t length,
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


