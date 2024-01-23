Return-Path: <linux-kernel+bounces-34496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67C837CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F01B1C2654C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F72F15D5D5;
	Tue, 23 Jan 2024 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E6nP5f4C"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1FA15D5A4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969760; cv=none; b=pw3NYy/8nV5AJYlAHJM73Ia2mjvqZXL1U2DSZaudvRzKKyiUIY00uki1NIkHYXh4YaWmx5NSQM1sbcMoxY+caZYLj3N54cLj0O8L2vSJZMpDnErlgr2/U1GQDPH4ZoBgyMyatEYKO3kr8omRG7qehzNAhC9vrIY18QMvylUVsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969760; c=relaxed/simple;
	bh=NRYAFFjPwwQS7mIFvZnh2t0+iUmsnpaZsL63ZPTCQ6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gNtEZgVxojHrKl4gHJ9Q9dnczm/cF+vCnIBqgk/EwODLe1T/SOFUO1ufvuWu3HYw7BPaXnv/Z9/MZ8o+HjrTtClUHVebILLljWrc1O7T8ifHPm1o/Ne3MQ+vhPUf5SIJDYiT6hCmUgZEw65+oMhJKGWW/vC9D01RKULsUkLY9oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E6nP5f4C; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ddf05b1922so2839076a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969758; x=1706574558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1DxNdRHBflJbmbDYuxIbQcedkbFsBliolzYulMuTN0=;
        b=E6nP5f4CcSoVdM6hp+465wgCFAfEpBoQ80HMEQwtTHIYc/r6ibKBjwJnGK4p7RHv/2
         7R2R7cVRu+XIOczvmdaxykFeyB4cXpwWL+obE00LcR7Y1gi95NeJGqYzNmjNGlMRwSzu
         QX6EJ8TJ8aYaZeFBU92XojjLeZxYDpD7i6aYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969758; x=1706574558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1DxNdRHBflJbmbDYuxIbQcedkbFsBliolzYulMuTN0=;
        b=vPg0WkzIIqo6jiBcUD1cYWPQ0tpjHNCKzNPVnBMWUln3oeuJdl45Ktorae3z5/IxQO
         oDhOySv8g+teD5xU23AxfeGLp91X8lvPvZapzpsIlPFihqWXO417tUetGQVNG5fFzhMJ
         lzq7sdzzPpIktZw9+Yq1pnLmu5qkE5DSSkGE48+qLPJGjVWVO30NvwPBrgezDuXlY93f
         PYlsgIurtWxVItCrh7sqWHDbxeqFmbPmV9U7vKUS2qaIJrH8gbcwD151djC6O0M5E9VF
         crdsa44lsYusB2+fm6hDt3Ay1GHNU6FTTOql4v3h8MW5Cq/7htHDleDIiAXzYa0Mh9/C
         R1FQ==
X-Gm-Message-State: AOJu0YwGs4q9wI923ShYxnJBdq1o3XUcdpqwLU3Sk1xpMTkiodg0t6UV
	KeeroFbkbH128gKjSuxRiIXmDXuJNSduR1gnih2Fb2hu+gHgQTfr7OAQNFiFRA==
X-Google-Smtp-Source: AGHT+IEErLwhFdHhXqFPSHROcPX6dDCZlFhvJYjpwzygJo7X4gRnaoVAA+NbgzqckFw0q8wdbkYqXA==
X-Received: by 2002:a05:6358:2245:b0:175:cb7d:74ef with SMTP id i5-20020a056358224500b00175cb7d74efmr4887240rwc.25.1705969758150;
        Mon, 22 Jan 2024 16:29:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sv13-20020a17090b538d00b0028d8fa0171asm10226441pjb.35.2024.01.22.16.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:12 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jan Kara <jack@suse.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 76/82] udf: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:51 -0800
Message-Id: <20240123002814.1396804-76-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243; i=keescook@chromium.org;
 h=from:subject; bh=NRYAFFjPwwQS7mIFvZnh2t0+iUmsnpaZsL63ZPTCQ6U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgMK3jte18rzddAc5u2oIbz/en8DIzVvj/9f
 tACbF2GE7mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 JltSEACOR1X2f4YzSTUWirLbiPo7iFpAcmKQQuWJudbXBybocaEGktZ91dSkGU1ret9HSOaDFZ5
 ML1P9w6bVsuc8lDdJdgDv2SVGqJRdj+2+xI3rUyDLnwWqbiLeD/s4deHEfwMTW65MWW5HY9X/ue
 zMThSZ0Sy6b4g1lkai1AInfLI+GK6Eo5X+08+mkr2CCh986mej8lVGAb7/5oGG4MYe/n+8JmwtR
 hDiFUnLLkEEcjrsyk7o4jl8BRomBfZ/PWkpLpt2D30aJJ0gW9Miqd1hed492/DJIsX1Z8hYQBoV
 E7q035WbqjiEFbhszJBHtt2UUrv1/2In9MJhAOkU8MK6O+yU/rp6shdMlh01IHq/pc01dIBXEzV
 njNDI2L3U5+bq9jetWc0yaz2qt8B12pZcQ68P8dPxxLQa8x6hjW+exF1ZwE+UAk4fgcgyr0CEc+
 XjQJcleZ2OGG2Z7XtnNz2EShFPtqKrZ5qrPfI48add5Zp7ePE0Wepk3CjYI70dVNia8Y8BgwLWz
 041z1qmkwOtO3nLDGlRFoBWDFluTPvDhRSygJ/u1EkOtEj4EhOPt12zQZcf0nBMORvbHMzYoZIt
 3fkcz/f9xISf7jsy8iEWlxCATRXXc9k4XnIfY3Vn0fKZb2qZ9jSuDILDsDVvsYEsbFC8tB/WVbU gaVCGgqwVJIgmnw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Jan Kara <jack@suse.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/udf/balloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index ab3ffc355949..5c88300c3de7 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -139,7 +139,7 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 
 	mutex_lock(&sbi->s_alloc_mutex);
 	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
+	if (add_would_overflow(count, bloc->logicalBlockNum) ||
 	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
 		udf_debug("%u < %d || %u + %u > %u\n",
 			  bloc->logicalBlockNum, 0,
@@ -390,7 +390,7 @@ static void udf_table_free_blocks(struct super_block *sb,
 
 	mutex_lock(&sbi->s_alloc_mutex);
 	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
+	if (add_would_overflow(count, bloc->logicalBlockNum) ||
 	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
 		udf_debug("%u < %d || %u + %u > %u\n",
 			  bloc->logicalBlockNum, 0,
-- 
2.34.1


