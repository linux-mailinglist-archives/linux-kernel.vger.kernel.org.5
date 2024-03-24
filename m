Return-Path: <linux-kernel+bounces-115595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7388943E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531A81F2F6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A6D2519B5;
	Mon, 25 Mar 2024 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmYJNAYD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75C1FB71B;
	Sun, 24 Mar 2024 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321308; cv=none; b=RtBW6lU4J5SB/C9AsG8naKX/1e0cLtKUA/Snp2OeAdiGt0pfmCU7h4NNepMeFhHu2ig0CcB2sxLWzq8QB7p9L+utKsdWf5NFm9a1YDysxJzwh8GosyGvfFdpy9lZluH2jBQAGuMI+Eh1A+2C6jWH/8ZNUiag/fs5PJJ3VJcK8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321308; c=relaxed/simple;
	bh=mxRUa5CthTVInxGr8kKOevfXkarA6jUudOI+9gLETuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OW9/zSm9MTKhXTSdGPCYKa0w6DNaR3q5Aih5GPIqAiA7hxjr/V8V0djzaibvvLxWHabQ77quVnHZf9IzRNEvQ5b74zzboB+9TEj2Jl+u7OOlBifQvtPeNlYSMe+01UFvO1/U/b8h30gxkagHq1XdQpEQNUoZS8ovdoN4DtmNDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmYJNAYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B814AC433F1;
	Sun, 24 Mar 2024 23:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321308;
	bh=mxRUa5CthTVInxGr8kKOevfXkarA6jUudOI+9gLETuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rmYJNAYDnDlu5kxyRiXiYX2k9RmGHwhcWL+GnPAPD9KTKBEnHj5XBfChQ9ycV2Pzv
	 3Bh0Id5BWgThcs+gTxu5xsdr9Un60Pw7Zsxa9tBs3dTOPVCnfyIo3kzvDxrkLFAzZA
	 agk3s9SfHrZjRRT+j7fwql0np9imI/Mc7wWX/wOBDVyq4Kkrzfp0iRlwkyw+EGhPq4
	 pSy+a2GKIBYO52iwVq05fBtOlsRHSVvd6EHJfCijikVKBWuuejDAgtaiVRobJY7Ujw
	 vEfPDZu9uW1iF4xOGhv9XHQbv2xm8RsLEBd5BK8PUu6F57X983EvIgFzwvg7rTcMKN
	 9t9QdtK0GrBJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 031/638] block: sed-opal: handle empty atoms when parsing response
Date: Sun, 24 Mar 2024 18:51:08 -0400
Message-ID: <20240324230116.1348576-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


