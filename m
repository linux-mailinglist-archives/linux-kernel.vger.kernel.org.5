Return-Path: <linux-kernel+bounces-115760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5F8889780
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F0129CA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01CE36ACDF;
	Mon, 25 Mar 2024 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaFeqPWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48301448E9;
	Sun, 24 Mar 2024 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321965; cv=none; b=gF6A6ANDvSOh2UFaLAe0ijs0ujoOfQaKjGO/bl5yz7aDRH+pYYhEq0MXTpznWadmY1VWHcmSzHaLeY5R1f6f2Iv2GPNcFhm1TUoaDZA/0nm9AnZ75hGq89tQNbmKgEWoj7iSbKdFQNyt6d1MKGWgQdwVy3Bue+oBySsEcg7UpNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321965; c=relaxed/simple;
	bh=vIYxEkfgTpOst8IRDB0xL9ewxCjd8NxYDv27uR59C3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeGFS0yAzzdo1IVvGpQhUj8MSf4hoFQh2ChdL8SsmzysF0rOJwp/wYivZVkAnLiDuE40VWg9c3kc4ATpRfTB+OJsldCZaK1ZYIW16Ui8664uRYUtnDLVkEoT/7CVCU1d9d0fl60FU3YN73hrgfEJg2BBPigIglREJrE6uDXR0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaFeqPWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F07C433F1;
	Sun, 24 Mar 2024 23:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321965;
	bh=vIYxEkfgTpOst8IRDB0xL9ewxCjd8NxYDv27uR59C3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DaFeqPWKW7sL3cgrFXP0ucMoUef3sO/mpi5RJxPIK/Q6mbjNjY9D3F4adcehrVd5t
	 MX2EH60G0nhMxJfDfAjaGm5jDggQj/d75u75acfpdxgmIjhpjVuHZO94fIuY74Gvhu
	 U7e6yD7AKrAfsUrOEtXkzT2FIPTyHoEIQ/DBZGbIxsqyh2S17s3vU/IVR47xQKcqr4
	 L9EgATCbNoZrViNik9GmMsJNBDGq4xtGyr0WpDFVlEbGjluLJb8m7ag+1HaobaozEi
	 Z55UUPazOKg5PROImMc2j6/4TQ43JG2n01DNHDzUjJfw68Qma9xITEU2khQL5CBeL1
	 M9Vq3FglATD0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 037/451] block: sed-opal: handle empty atoms when parsing response
Date: Sun, 24 Mar 2024 19:05:13 -0400
Message-ID: <20240324231207.1351418-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


