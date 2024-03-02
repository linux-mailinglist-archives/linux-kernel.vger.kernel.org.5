Return-Path: <linux-kernel+bounces-89465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B8086F0B2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318661F215FD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC4517BB2;
	Sat,  2 Mar 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFEbfMiN"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17423A6
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709391151; cv=none; b=Zjr9eW7R6OxDP/SOvgnowwGuNjhvf23ZuWIMf80tM3FnZQjjpKALtTNtBne8dWoQVyU9+AYQqeZ+s/bGdZf3V5FiaarS86N0GB9A0kKhfv6WBwpDBeSsfthn3OCGWqM1dzl5gMuPiuY6Ba9ddPqgoo98bKGwk34IqJBVYyGV0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709391151; c=relaxed/simple;
	bh=Ef+N4vGlqlUybLHJPcdwa+UvNP8PKIs+Su40x32riHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prTDx2IPuPVyFVU8YhwVVNW8KzOcpxIXZadc/E8ZrUK3i9eW+NGNmxUSFKiEtWBjxlRBBX0y0e758m5kvYuHlCstlXQkCHaTf4rsu4+jZl1T9EAu1WQaVZN54ogV9Gm6agP/q0Lt7FCCIVuJNerBEU1XYFKv4+JjbN6KeRbkQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFEbfMiN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e1878e357so1158343f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 06:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709391148; x=1709995948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/ES2FJW4PaZ/LjH5h1eFhluoaUopAjREsxQYkJ4pLs=;
        b=BFEbfMiNTg06ruIKknCk72Svv74Ra0YjvuZfQa1gpMP1xF7Ssmrli8Wbgo2MA9dtUW
         /KvmhGoEL50BWesqyoI45Rr8rM9UThLvXA8xrMs1DqkU2dqU4S2Op7bFRQ8DP7tYfGJe
         9kUvJGJrtRjjUfUpp7UKY4x1JA8whuXH4rye+6FuHBEQsGKRRjgZYWe2wSw0rYQLHOAC
         Kyqvc8INz2piCQgIWUG/9uOGkRTFZHEDY7LVeZpn11lDAKcH/lWzlWtF77YWl1/cqTOO
         9udKD0czFSD3nUf+jyu8BTs1VdHWkC3RIX4RDTy85lQA5g4R0N5g6aW5CwJosgRrCcHQ
         Q7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709391148; x=1709995948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/ES2FJW4PaZ/LjH5h1eFhluoaUopAjREsxQYkJ4pLs=;
        b=YV9NBrfJjpdxHcFkH9XUk/jOuRghnhsxAPexMCVlvW9RmauLQqy9LjEWHJJXKXxjJn
         crayWAp6WCIkj8jr71cXHY1rqloXRhR3crkBzVfhvvnMiB9zhI3Uc+grSXSUIUcmxI20
         Qe+pp1EkkQoHxPxeMtZCgPHpXBaA8f8klrERitBMPPZc1dIKAfx9z2ZxZMsvl5EqUjeZ
         37i7Wi5msF3huOHIZvgxpAOppnlINNkqDBDYQgXZM/C1+j4u4at/q3dYvkhUL9l6Agyh
         Xob6gYoflGNRDVBTxT74/XAhlP7zHmJHmW6HsC0z7ybXLV8IF0DN/frtd5WBnKnO8GbJ
         OD2w==
X-Forwarded-Encrypted: i=1; AJvYcCUPg3/q4CJiNXcQ03Z0TapfGNLt8h1LKCSBftH34aA4d160M+ZSVhddEpQHlGBodhl1woVfIiDyPzFWLta6/tIQQkOqeKF0Ut71ZHkn
X-Gm-Message-State: AOJu0Yy3IS0nTPkla88Xc/kUk6j5Cx8W4aGmIcOkucK6KD9mwjgxMFt4
	ms0ajrP20sJba4faq2dlaHMf/J0f5s5GBb7vrnmou+1aQXed3ltE
X-Google-Smtp-Source: AGHT+IGxWNMD5uOCujmqbxrHNDAoUpOevGETa2GqEm4G+m57sD9n+m4Qie72K4Nv3xJ1eUz1tMjDHw==
X-Received: by 2002:adf:9d83:0:b0:33d:d7be:3bec with SMTP id p3-20020adf9d83000000b0033dd7be3becmr3254953wre.58.1709391148038;
        Sat, 02 Mar 2024 06:52:28 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id by1-20020a056000098100b0033e22341942sm4085502wrb.78.2024.03.02.06.52.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2024 06:52:27 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	mark.rutland@arm.com,
	ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH] arm64: head: remove unnecessary instructions from __relocate_kernel
Date: Sat,  2 Mar 2024 14:52:10 +0000
Message-Id: <20240302145210.65919-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Formerly, we had to access the RELA and RELR tables via the kernel
mapping that was being relocated, and so deriving the start and end
addresses was done by loading __rela_offset in x9 and then adding the
actual virtual offset of the kernel to it.

d7bea550279d ("arm64: head: use relative references to the RELA and RELR
tables") changed this to load the entries via the ID map as we map the
entire kernel image via the ID map.

The two instructions for finding the actual virtual offset were left by
that commit, so remove them now as they are unnecessary and add runtime
overhead.

Fixes: d7bea550279d ("arm64: head: use relative references to the RELA and RELR tables")
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/kernel/head.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cab7f91949d8..90db196f7c19 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -787,8 +787,6 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
 	 */
 	adr_l	x9, __rela_start
 	adr_l	x10, __rela_end
-	mov_q	x11, KIMAGE_VADDR		// default virtual offset
-	add	x11, x11, x23			// actual virtual offset
 
 0:	cmp	x9, x10
 	b.hs	1f

base-commit: 5ad3cb0ed525b80c7f66c32b49a68c1f3510bec9
-- 
2.42.0


