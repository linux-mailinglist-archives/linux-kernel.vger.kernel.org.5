Return-Path: <linux-kernel+bounces-87512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E319E86D558
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941621F27D37
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EACF16B03F;
	Thu, 29 Feb 2024 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7L6hmtP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031716B02B;
	Thu, 29 Feb 2024 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239303; cv=none; b=lN2G3Ig3NZUtxoutr5hhEHqDdFliWziYlQgbXjB4AD7ouxW1eFAznNvRMckGIiBMdmeVF5WmbaRGO6k6Qdi3If6kOvO4WcbuFZIr6L5FFRNlcWwcEGqv/nLd+1dL91k5F/lG2K243Ba3krWvz5uZVD4wdW5Rsr6OaGuZKHFWUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239303; c=relaxed/simple;
	bh=/asW2tftmwjIBrAfKoCxa3oRNne3RxOit1L2BaOZ8Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzX9O+E3CWk1VojrsdyPrYO+JnQaRhbZwKHoDJzcJ3Rb0muc/0yYP6aPj5ZUPRfsRDjmpazvrUeOYqp6W2jbjnShPMysBB4tvkCADhbQeENYSlemdd800lOON2v7YDpe1264ln5nRTv5hqPGrMSI0GuvsH0ZUCJqHXC10uIAO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7L6hmtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20702C43399;
	Thu, 29 Feb 2024 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239303;
	bh=/asW2tftmwjIBrAfKoCxa3oRNne3RxOit1L2BaOZ8Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7L6hmtPrd+9wYd2kIQW4cO950DFl0CaseiY9Bp1dnUD3uoKP9oSTSLJwkwxTN2hy
	 IDzpenFAo5tENfG3QKE1PK26eEsR2YLKcPoztaKmkx6iyS4zNxWhG+UuijGz3nsUIl
	 0mglGloVlt7QH1v88MAOW2OymqYh9Fn59Hwl2TL9KPI3tCjRNAHrZzKt3NP2BUpcY3
	 ky6GCJaLJ9x1EAzyZ7iiDCZQL/yikF8Rzlcl5P933aAV+kLRMrHXcO51mYCX2FmXSY
	 LRDN/d8yTcQRpvx58TGDcEVFtchsFAvOYv81igHbHsULnYp6MHeswhOZ35rLhcmpl/
	 dgIHItFyj6hZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	jonathan.derrick@linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 7/8] block: sed-opal: handle empty atoms when parsing response
Date: Thu, 29 Feb 2024 15:41:24 -0500
Message-ID: <20240229204127.2861980-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204127.2861980-1-sashal@kernel.org>
References: <20240229204127.2861980-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
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


