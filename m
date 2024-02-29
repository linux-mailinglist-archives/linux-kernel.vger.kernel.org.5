Return-Path: <linux-kernel+bounces-87445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B0E86D481
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39E228494C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D0E151CD3;
	Thu, 29 Feb 2024 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwKd+IST"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A395144047;
	Thu, 29 Feb 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239074; cv=none; b=HQ+S3/jawPICR9tRol1rA8JvnIV/R2qDlpG0NpFvYmN2jNpMZ/5TiTR3TcuA9BN+3tFxV8S9HCw5h5ioD5l7JgtdwNSurMl9euyYMw5IigcodKFQzyWns81T1Wt/Vgl9etcXeFZnSJ5kG9f45FM7as9PpUu2hovgwTyhcnEQgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239074; c=relaxed/simple;
	bh=q0QfNTy7LCZMzM+Y77fnUYNSiw0FW0Vlv85XEPhFh5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9+v2dDvUsAv92gEqu9ZREA4r8H9NJ7nS2exS8a7kbWtxKBardDXTJcZl+JshWe8tuHR7gbhQAqTP4wTnJDrO3DCfZN9sxBZthirDLREdS5q5MR59nETSN4USLPzxoGwrmI1mvYgQ85R6hCsPwz4lmWymKbzuYhLCGT8/xLbDuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwKd+IST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9362FC43399;
	Thu, 29 Feb 2024 20:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239073;
	bh=q0QfNTy7LCZMzM+Y77fnUYNSiw0FW0Vlv85XEPhFh5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwKd+ISTcwHq9RQPcBz9CF0GmIO232wv3HO3thLZaPQg+s/KwHxE0/ie5DeP/AZT4
	 WuzDxzWeJwcQg3440VCrmSaaI2OeobsPBi/PTkgvxrqtkPIfsDjHK1RYPGq+4QtXsX
	 4z7geEgiV9D/O4CJ7p6TSFeWVvEWEBzxO9I8Zmnkf38NhZznNNh8RsB4/dvt1kcV+T
	 bRk7olyFx0Npvuo0zVfMGAl7uVpwjTvsaGxdJtoL8LcVdhijqRESJnphkqMrcZeRH+
	 DGzRdkmk3E01DzMZ2DmHMEBdE9GSZ4tQy1cQzguU5MmdrNXoAwLYcP7JRd+olNGkEN
	 masL+A+X4efHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	jonathan.derrick@linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 12/24] block: sed-opal: handle empty atoms when parsing response
Date: Thu, 29 Feb 2024 15:36:52 -0500
Message-ID: <20240229203729.2860356-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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


