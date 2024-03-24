Return-Path: <linux-kernel+bounces-115339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568ED889AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8827F1C2FEE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0411E5F70;
	Mon, 25 Mar 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAyiLUVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB887F7D7;
	Sun, 24 Mar 2024 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320477; cv=none; b=Z1lqH8AVdSMxBZXfoaTidhgL62W440wDapuykWlEPNMOTHmOCRKj+NX/vRESE2lwEWH79RsSeQbBW30N4uBDnbVepzCFTCdwScdmEx1olSyVlSKVMfl7dMoggo/TzBnA4RXQqNxn0A5PqLqrKtWxNTadJtzhiNji4xFoyi7ZyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320477; c=relaxed/simple;
	bh=q0QfNTy7LCZMzM+Y77fnUYNSiw0FW0Vlv85XEPhFh5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/N6xAImgdfObju5fC5rl7kPBt8FOKk7bjzy3EtqKzl8mh1xJHsbv1Knkhlsw0eDpouw2/SgqyqXMEE/1JuIQFGlysnC0eVZDXf7xJKUXWsDb1c40bBSMsAmWPj58h4uALUrvQdoihUHnHplalW+50r+RZhpwynCnjL8Cd2OAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAyiLUVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721CFC43390;
	Sun, 24 Mar 2024 22:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320477;
	bh=q0QfNTy7LCZMzM+Y77fnUYNSiw0FW0Vlv85XEPhFh5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAyiLUVdcBfxlokGd+GOaiqqO/3yiZKNjNQIXJwWLzsJqAfJZiBnOGUHRrKeIIBoY
	 wiYvlYai/kVUz9akaf4RJT7Y+rSWKBUdJpuG1ywh1iuNErJc3S+R1maqCQr7/yZG0N
	 fHEFjpqf5s3AmQR+bjylqL0k6SnH24CGt9aJlV9z7WOo24nzKN6howNwGwhslzzT+C
	 vM8WBSzs4P/85BxLDVUkfv45IrZHoebbPH9KJNSubGLJ0DUbjpUawhPp4Bthup7kUt
	 xMSV4/U5OOFCdLYK9CoUGhVVGdQR54jiQDAZ5GyhAgHoWofRenT2urT5xS6nFldXxv
	 w9nm20dU6p4ZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 036/713] block: sed-opal: handle empty atoms when parsing response
Date: Sun, 24 Mar 2024 18:36:02 -0400
Message-ID: <20240324224720.1345309-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 3d9e9cd250bd5..fa4dba5d85319 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1056,16 +1056,20 @@ static int response_parse(const u8 *buf, size_t length,
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


