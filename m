Return-Path: <linux-kernel+bounces-87492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C66C586D516
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5D5B267C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF7C15F138;
	Thu, 29 Feb 2024 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8eXuqPW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027BC15F124;
	Thu, 29 Feb 2024 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239256; cv=none; b=gklcxtMzzZeSCkdmpMrbZfKU53vTDonySl+55ozt721uLgt1hp3/mzg9hJhGjUVBjWRRUhtasA2D+k/xxGU4JeNIgXmzyfMhnXTV+DdwZjAdrWpzTO4uWBGeWYFWM/4Qhx8AVZ/7GdaAVKhqzhPj/j4W7ifYNAsbcCJIi1rD7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239256; c=relaxed/simple;
	bh=vIYxEkfgTpOst8IRDB0xL9ewxCjd8NxYDv27uR59C3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OF9iGR3zU9QP3+79YRisb9mkxNAYRAP/hJOkpQO9w+i5cmoIST/7IZmmxLJTiCO9Ajx3ytUnzTdL5L8QVRjBiu+k7C7QGgdgBK5sJYbx6hwPSAgqxjx79RGMVh0GN17RiJelVq8mr0pIJILqAFcxx43YIQTyEyuJviZ+6VSRJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8eXuqPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F255C433C7;
	Thu, 29 Feb 2024 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239255;
	bh=vIYxEkfgTpOst8IRDB0xL9ewxCjd8NxYDv27uR59C3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8eXuqPWU1sOuZYahrBx6hsNHCODbSZx9ZYeh5ly5/vR8dBFc0xSEYSvOCHYo0yKE
	 AW8nHLHSogNx0cAmq2ABJupQfG7Enzi12zy8cTSIyu0VSyUpyroa3dZGgGbsxHGmTr
	 exnNVxvlNOBk/xzeWPvRaLi4cUxaLOG5kQmQ0egxMB0pp32i3Bzj1JRLWcYk9vcnA0
	 MVSAxBt5gO2QvUFSIKf3hiohsyrH8OPWe3q5dPGmnEhYY8nfqwseW1UFLgHkurbZN5
	 etuAVJ8TahrJEGCqeMrGcm2iHXhYRaJgEXY3YduTB4JTnDcYeKPVgn1nph/BNKgUVp
	 WsUODlPa7oG6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	jonathan.derrick@linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/12] block: sed-opal: handle empty atoms when parsing response
Date: Thu, 29 Feb 2024 15:40:31 -0500
Message-ID: <20240229204039.2861519-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204039.2861519-1-sashal@kernel.org>
References: <20240229204039.2861519-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.79
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
index 7152aa1f1a49e..7f306b08a0fe7 100644
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
index 9bdb833e5817d..25e4ce452c1d3 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -935,16 +935,20 @@ static int response_parse(const u8 *buf, size_t length,
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


