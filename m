Return-Path: <linux-kernel+bounces-123020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7431890120
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DE81F23789
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72112CDBF;
	Thu, 28 Mar 2024 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGBrVSKg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E812B17C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634794; cv=none; b=s9yyeTvGF2KmiCO7QB3PYWKo1ZDYXGLFtGRYr1gSOSiecXgELF+gPpp8OyNX2QBZZLrMnAPnzJvnmbaljmFuyqdKrta6Qy2VUPy2AivA8ZsxRquuwb4HtYFDwxnCdTfqI96WvKezgLyZcUi/VOAQolB4Iwx1mhqu9LDiG624sig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634794; c=relaxed/simple;
	bh=/z3penlJXNolNdo44Cwa/toSbF2yR8i4Mak3/kq291A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEGxqkzhcu1ZgeJGSy6cfb15eHg8Kyhulf00vcPTZFqMqInqqJfKRkgkn/h5/SQA8DVDp5S32G7nQ2z+lq0HkoLqZBn3WxSwIPA8TZqM0lk18RoiFUW0xiOtoiHaKBOTXRbx9Of1jVotBPzgk0HhjslpSK5b0F4B6JEyNUGanes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGBrVSKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44CDC433F1;
	Thu, 28 Mar 2024 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634794;
	bh=/z3penlJXNolNdo44Cwa/toSbF2yR8i4Mak3/kq291A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGBrVSKgykDqZ/dQD9dRPlC4fzYpN5MH+e6VEjn5Vn+S8EMrOcW+VR00oxIcEQ4WC
	 OPmWGINlce6iA+Tsxrum92mvIhbquKTD38lqNu/4/hMjeaidIPGOQauXutFGf2OM03
	 JH99OxIHFRTK82X+eCbL4Noh+bK9V2TxuSEbo93wtW3aEJrkw/hGJTlBPMwiUwtsGh
	 yGOQ8nzqXVoY6gFELp1qSs/D76NKaFg8jsEeIDgqyJ+rsuTv473vnhLq/cNSGxFqna
	 MMJmXF1CUDmrA18LLyKd4bG59oRLVJZRHbe/g4sdeF6I0IoxWHmpvvm5IcdTz24fFl
	 LNwgHuQw/ptnA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/11] test_hexdump: avoid string truncation warning
Date: Thu, 28 Mar 2024 15:04:49 +0100
Message-Id: <20240328140512.4148825-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140512.4148825-1-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc can warn when a string is too long to fit into the strncpy()
destination buffer, as it is here depending on the function
arguments:

    inlined from 'test_hexdump_prepare_test.constprop' at /home/arnd/arm-soc/lib/test_hexdump.c:116:3:
include/linux/fortify-string.h:108:33: error: '__builtin_strncpy' output truncated copying between 0 and 32 bytes from a string of length 32 [-Werror=stringop-truncation]
  108 | #define __underlying_strncpy    __builtin_strncpy
      |                                 ^
include/linux/fortify-string.h:187:16: note: in expansion of macro '__underlying_strncpy'
  187 |         return __underlying_strncpy(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~~

As far as I can tell, this is harmless here because the truncation is
intentional, but using strscpy_pad() will avoid the warning since gcc
does not (yet) know about it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_hexdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index b916801f23a8..c9820122af56 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -113,7 +113,7 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 			*p++ = ' ';
 		} while (p < test + rs * 2 + rs / gs + 1);
 
-		strncpy(p, data_a, l);
+		strscpy_pad(p, data_a, l);
 		p += l;
 	}
 
-- 
2.39.2


