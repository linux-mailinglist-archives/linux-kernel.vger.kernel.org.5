Return-Path: <linux-kernel+bounces-129279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459F896829
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E296E28A6DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9F8286B;
	Wed,  3 Apr 2024 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIwfgNho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D314F81207;
	Wed,  3 Apr 2024 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131675; cv=none; b=ZglCYLtslRlE+2Zg203LJuq7kPaXF7cxxmUdtb3nbsxZWLk8PrwkalJNqlxYktQUKID3fKmKahDZdSLFHMajysd6QyEfFFE07ZDKC1+iLIdwMajJQ3x0VyfIpSvEtRJmfyO23oDMS40CA0T2+WCPn8br6qE5K4xsMrsO0C4/3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131675; c=relaxed/simple;
	bh=i2kwREvJagmflXYpUvDxkKnpylOun/MjosG4Ff0VeyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dsKjkbm8W2L8ag+vIIFvIMZAOpjJxruTd6LLy0ZWn8tjXFTQ0JHv1oQp51XLNWWobrzQPKA5V9sjeKOTyJvWr/PaPwT29GMCvU5j4nKf69gWIEO4kPJpYWE0PbR0g4MzL/XEGbrmJvYSEzZKrLhC9PhgijrBukFizJ0QC539H7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIwfgNho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C107C43330;
	Wed,  3 Apr 2024 08:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131673;
	bh=i2kwREvJagmflXYpUvDxkKnpylOun/MjosG4Ff0VeyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIwfgNhoK4uO99gGZSx/4AtuVr5J0+ILk77OBxquuSiIuRfxua0kwS5ZHLif5eNFK
	 Xiwlt9yeTpBRhXGlXbXwwHy3FGxNmF/kbPC6bpAQPsWi5aLQEkG8jAiciY3TSvcEds
	 2x7mp557Sf6hrfOqNsybrYTk55PdyuFDHv74h9gxE7BH5qNt83P2kSCn6r+/pfGQwu
	 Qz/sLLA3y28X6bUTadkVRMd7GFVGelJrLkmJWcf3N8rAqOfz0Vb+cTIotRUwSh69Rk
	 G+bpOo4zdRzXll2Q7I3jBh8x0oqTjEqUM9/PS9zuRJn01ez5Rg0yvl6X2szE/sSueT
	 jJPzh+CAjCubw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH 02/34] ubsan: fix unused variable warning in test module
Date: Wed,  3 Apr 2024 10:06:20 +0200
Message-Id: <20240403080702.3509288-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This is one of the drivers with an unused variable that is marked 'const'.
Adding a __used annotation here avoids the warning and lets us enable
the option by default:

lib/test_ubsan.c:137:28: error: unused variable 'skip_ubsan_array' [-Werror,-Wunused-const-variable]

Fixes: 4a26f49b7b3d ("ubsan: expand tests and reporting")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_ubsan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 276c12140ee2..c288df9372ed 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -134,7 +134,7 @@ static const test_ubsan_fp test_ubsan_array[] = {
 };
 
 /* Excluded because they Oops the module. */
-static const test_ubsan_fp skip_ubsan_array[] = {
+static __used const test_ubsan_fp skip_ubsan_array[] = {
 	test_ubsan_divrem_overflow,
 };
 
-- 
2.39.2


