Return-Path: <linux-kernel+bounces-114733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABDA88922C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF2C282AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5A1A7758;
	Mon, 25 Mar 2024 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGhC0G1O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A562733D9;
	Sun, 24 Mar 2024 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323320; cv=none; b=IOEXQeMphYTU5GiABRHd8hAJrX1vF+/qF0Xl4V9fej+rce/S+f87rz6lmpJ7R2uWA4+YCEerez24QlCbBArbTFKCpiFQyTGj8ZYTISiFfawpMKdsZ05cTG4DM6CLOzZrjX7byQrERU/rB98nhZcIjyHuiKZ1LktuW+YIwqSOsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323320; c=relaxed/simple;
	bh=/asW2tftmwjIBrAfKoCxa3oRNne3RxOit1L2BaOZ8Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtaVaGm2xH2iDtVtedwmTta1Y0pQ5GCy8W0KH/niy02I7sEoOBW8vtspS90C2NmM7xb16pZyk0ZvK1Ti2eRL59zb5sk7AZcBhNeGMhOEczP+u/lJ7eHfL8iL/xRkGwJKvD59RNibQYO77mdth7slPZy0rn1tPMIzzWWfxUzZavI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGhC0G1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C743C43394;
	Sun, 24 Mar 2024 23:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323319;
	bh=/asW2tftmwjIBrAfKoCxa3oRNne3RxOit1L2BaOZ8Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGhC0G1OtztXd+GQLrsRdWy1dysfG0kF1U6gxSlT/S0ypJUR1tV6gM0gXyqWEzH80
	 fP1da8rW439ChaGWzm8hKKgMwlVh5i5ybRSKwcs3mIg4yryFiRVr3by6jXfM4qpnts
	 EplwHfXFzyF1P8ifK0zagVo48cpBnb3DKQjwJLypa1W3JDtkGHqijvVd87lPz+3hnF
	 UMn4kkxnlh2bJaageWylXI6d7H6r4ogefzKAasg/N0GBVc9+/TPRRCtMJUGFQRJXTx
	 yS1OXAHrrKcobxWFEDZsy3K98tXmWD0ENTK9C4iGyu0UvRxY1RouYqP+S5SG0cQYiI
	 c1g0AYTX/XVlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 019/317] block: sed-opal: handle empty atoms when parsing response
Date: Sun, 24 Mar 2024 19:29:59 -0400
Message-ID: <20240324233458.1352854-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index b486b3ec7dc41..a50191bddbc26 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -66,6 +66,7 @@ enum opal_response_token {
 #define SHORT_ATOM_BYTE  0xBF
 #define MEDIUM_ATOM_BYTE 0xDF
 #define LONG_ATOM_BYTE   0xE3
+#define EMPTY_ATOM_BYTE  0xFF
 
 #define OPAL_INVAL_PARAM 12
 #define OPAL_MANUFACTURED_INACTIVE 0x08
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 0ac5a4f3f2261..00e4d23ac49e7 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -895,16 +895,20 @@ static int response_parse(const u8 *buf, size_t length,
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


