Return-Path: <linux-kernel+bounces-87524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C75F86D57B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D16AB289E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAFC16FF28;
	Thu, 29 Feb 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1StvAsp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85816F85B;
	Thu, 29 Feb 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239334; cv=none; b=DcPrkQ3ed9PchWRZFe8LOhPNpAUhJ5wimaseGHlaJgQw09ZBwmP9EZcLxFo8O/XnkLxnjzwyhy8BLuo08huXmgrfFGqaU4oh/OFhpFeczfP8zCLMurr5ykiNP2APY6Erzfh7/f+4GT1CHtG3NtY5t0PBa2szwcqUMJxAB3ZJY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239334; c=relaxed/simple;
	bh=pPqTwLB7TLaUTeD8LOWSvUk2b+PMhg//U8wFczNoAVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MY5nYQs3HDQZCkN2kmnG7b39rS7zfXHRII3WM3MytuSjpGKCNY4OL2SHA0Ml/M30X6gHNf/AcnMO4AcTur4bRk+eJt8y1S5XQZ3m3bjZw1LvFhbOm98LhA26Gj1XGzZqlF+yTTRPH/ofT0JaKNVPMIavTJNkeE7Eb1TET2TvzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1StvAsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F81C433C7;
	Thu, 29 Feb 2024 20:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239333;
	bh=pPqTwLB7TLaUTeD8LOWSvUk2b+PMhg//U8wFczNoAVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1StvAspawWntiCRWLCZbgcBMwlUQ3InNS0UoI3J6DQyi6/PjUnUZNnDo0+IxUp8v
	 EEOHL95ylV1QyBDUmK3F58ImWWCrHMI9kCPAyf8kOS6dBPIgkDxSknq9moK49zTGde
	 Q/VJgCZwmrto79/2000ULXrzdCIGLWL0i46qMzirtz3HKDVhs5A7XiHWRnnCmcml/g
	 c0t+xRjpabzp6F9BUNNND/x1vwlPVX7iHv8dcI2Dad5zze73WPGo/deV2Uq/yoF5Kr
	 S6DffZM1m/kzfu97UeFV90fjGgXpHqYooa8ASbvv86x5Lx/bRG21y2PlsDJ09fmUG6
	 GWB70y6o6IywA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	jonathan.derrick@linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/4] block: sed-opal: handle empty atoms when parsing response
Date: Thu, 29 Feb 2024 15:42:03 -0500
Message-ID: <20240229204208.2862333-3-sashal@kernel.org>
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


