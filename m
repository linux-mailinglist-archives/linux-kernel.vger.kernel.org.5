Return-Path: <linux-kernel+bounces-61478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ACA8512C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342551F23EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCBB3BB24;
	Mon, 12 Feb 2024 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WUR+egWe"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA43A8DB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738936; cv=none; b=kI1U1DmTTjR2/xxd9pEfjZvjOXcKI7yTN78G15OsSJEe0WdTfiUGbW60xzEg2T9lo6qKgw48hlFYJa6UOg3KnArrRGO0Jz94iMq13lfMewYlxGI01Ijis27yF5ipE8yD5TRfyzHMzAa0aiR1AfhySw4srl+ilrArHTXNBRemCU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738936; c=relaxed/simple;
	bh=3EMwRWQVmXFpMULqT0KRcNauX3dUmEoNi+TxEAuDB/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z5Ckzifaqg2nGKlWOXae3hC+y19qYGPE0Yc08GhXu3zwF4arfVEPou2urfstVxGiYl+6pYd3aSKZ7KWKOYKUu7XtDzooJ0RVigggysU7VT8sYhw44VdWANvvBLeVpfyzSR08+lvsSkf7EBwuV8sl+cwAlHfa6EAjT8oJk+jPk9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WUR+egWe; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3ca40db065so76974766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738932; x=1708343732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYWONKEfyypsQx26Swj5H3vXFHTxMGTOOr2K1QsNu0M=;
        b=WUR+egWeUsyUe4XxZWMHNGZx79eFhW/o/6UA/Cz4MID0LftctkEiea7sb3CXK8toBo
         8Y2GAlPxp1hZ0N1VgknaY84ehWDHgShaaFr1U+ku/2uouQv8KecxCCSuqRFvwqj7Nl3+
         fNAiK5YEIEIdwWDgiNGBd54XqHVwhWS08qesc+yj1LaijyEJI/2yVsLdzmWTb1N8pzyp
         +uTuFV/oXDaGTEBLStzRZDaOf39PxRngeURIvJ6xNrYmKFV/EmC6fzMXWeUs4jfQUekK
         vxidH2L06kQkca3w1J22LavnST4ddlfxLo/JQf/gdQaApc0ZCyWpT6+DA/d0xANeDi1e
         hTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738932; x=1708343732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYWONKEfyypsQx26Swj5H3vXFHTxMGTOOr2K1QsNu0M=;
        b=MQosWC1p6Exai8e224orI/7QDX4wNLDvR+hsPtJcQkjRLTM61k1qmsBmfRE/Q0wIX5
         5zTc/k6s/E5aK/RBUUkkx2GiNfjLMJviftHviK+hyQLBv/tIKgfggmMmLM+8ViCwwkya
         lgr2piPkp/0jpteaYXg0Zs4Bqon0CgE6iRfvaAyqQvWaAMeWtBrflxbW0EFzHcaQlqP8
         7XbPWTkQdLSzMCR2lxLDHsrnJIqHEHCJGeVYjM57JYzC0W2WlJAVLhb8ukJsPcu6wYRN
         CyF/oZRn40mXyw83Z1dJkSoOw5tyOh3EyRctQDJu4qkk0jkG8shGhe72EL5LeHX9Q4Cl
         2Z4A==
X-Gm-Message-State: AOJu0YyJjD5UfSzcGhbsEfNMti5a3/fpWJwgiqSYu3sNYK2HnoYjEmJc
	naBdjialz9wj6JYbJ8rowgoAjTr/VoF6HosrY6nmr4a3WGDHUZ7Nyy1ysHIE/7YTHCvFdshKoOI
	Q
X-Google-Smtp-Source: AGHT+IFUKG++8yIi9n/UKrive4UdkNDxSMPhe9li3i6Ur3gn3Wt0VfESSLbzPYHi1ufEK9pfYRm+uQ==
X-Received: by 2002:a17:906:d96f:b0:a3c:ccf7:5fda with SMTP id rp15-20020a170906d96f00b00a3cccf75fdamr687984ejb.46.1707738932239;
        Mon, 12 Feb 2024 03:55:32 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:30 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 18/35] blkdev.h: move blk_op_is_passthrough() to blk_types.h
Date: Mon, 12 Feb 2024 12:54:43 +0100
Message-Id: <20240212115500.2078463-19-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a very low-level function without any additional dependencies,
and moving it will allow certain sources to omit the "blkdev.h"
dependency.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/blk_types.h | 6 ++++++
 include/linux/blkdev.h    | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 96a37f399928..ad48c3f5ddd6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -434,6 +434,12 @@ static inline enum req_op bio_op(const struct bio *bio)
 	return bio->bi_opf & REQ_OP_MASK;
 }
 
+static inline bool blk_op_is_passthrough(blk_opf_t op)
+{
+	op &= REQ_OP_MASK;
+	return op == REQ_OP_DRV_IN || op == REQ_OP_DRV_OUT;
+}
+
 static inline bool op_is_write(blk_opf_t op)
 {
 	return !!(op & (__force blk_opf_t)1);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e67298984913..6bfa4b92bb32 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -260,12 +260,6 @@ static inline int blk_validate_block_size(unsigned long bsize)
 	return 0;
 }
 
-static inline bool blk_op_is_passthrough(blk_opf_t op)
-{
-	op &= REQ_OP_MASK;
-	return op == REQ_OP_DRV_IN || op == REQ_OP_DRV_OUT;
-}
-
 /*
  * BLK_BOUNCE_NONE:	never bounce (default)
  * BLK_BOUNCE_HIGH:	bounce all highmem pages
-- 
2.39.2


