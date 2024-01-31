Return-Path: <linux-kernel+bounces-45845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F7C8436FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061AF286B06
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB94C53E25;
	Wed, 31 Jan 2024 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDX0evQ8"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B15102A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684024; cv=none; b=Sv+aFLCoJgPyRRI0ACC1zdD906h5r4vZVZZ3XBeVkFhkNgujB114NyaBxBiyNKbkGYBC54FmKRCViZ4diN6o429fefjt8fOxUv5r7SUMsA81PZBlbkJiuM6wAGrP4SJwED3CrnWHU/TNMIChZhq1SS+P6/9Gs/TVcz+CO1pBWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684024; c=relaxed/simple;
	bh=/V9Rglm98djqCs8KSL/PzgVQzNmWOOniqe3fv5n82uk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dZI9xzpAAiligrCxxWoIiU7DQDmdtXvf3d5uOs1Iq7Pbbo8gpVXbdzATXByWVXS4GDfu4vDwHMdB867w19Q9gp95lAK34YjhgaSKjcvCMU/iNE+Y+k+RVm98nLcNOPimcHvDuQNfPGKLyol1Vs9EndRW4bv9Ac6kwoiyStOX7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDX0evQ8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maskray.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6bad01539so723308276.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706684021; x=1707288821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8dMZ3OwOckg/8nEeQlzzg6EqDAiFIDc7gYYU0A2bM1c=;
        b=tDX0evQ83kB053vtN120fkPeVd6r4wClFnCakaCvMmxq/4Ld3v1MPKauEkC5o8DfYj
         v4DdRSCDpYm08rvxneWApirhgCH00yH+9HWkSPa+KwKx1Dr6MCmnppYO+oI+GUvyU3DB
         bY2y4TppWbIw+HJhjRLiF2ILxBmcm8Zzj3Z8H60no4yLXQ/NwUXEFAIUij1yhjFYSB3o
         i17DSrWVwR6fzTQhB82VFn8hf9ycpCjEiFwkhwHIJYpQ3G853ewWm4HcXRndYQ4nkq52
         7BRy7gDEXy8naGL7wakzxsrsg5T+yGuXY68hliBQined/Fq/sFek31VyTvvEV/h07NZK
         FZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706684021; x=1707288821;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dMZ3OwOckg/8nEeQlzzg6EqDAiFIDc7gYYU0A2bM1c=;
        b=gtuk5GhUV2e4iWZxsR42vqGGFrpcWUo96XLJLACFePw/c/V5yhtpMyQStyrjfRfRAG
         GKCajVkXd49/+2T3hp5yuR8pJjvcS53rvus39D73ckooddiXD6Xpl7vZhCzbQfBQwy0o
         x3XYXoDsKrgv1zw21lblwzfZq0Zm2SwpGj/g2+4w45S25yYCJIRH9qJu/rb34/KaGwLp
         2rIzXtCQC9ZNHGeH0eIp3z2wGmXpzovur+uAAzjyjSO2CKqfFXu3qQw+GJDUMdgl6DB9
         ap1BbwwVuUehMSAjGuehbDkNID/vFQJ3Y5Di8f8umwsaPkJ9KoxhmOUtKCy3ii15B1lo
         RqXg==
X-Gm-Message-State: AOJu0Yy/N/mMGBiAA0lyZnKwR7q5E/D6wJDrnjefeGV7fifRKJONtU3g
	gQ4DEcQcm+eSC0/+ddbKPmV2Bx2IGqS/6TYXDWaw6zVK/6Ant6/eBcIwyEz3lbQzUkBzvfaaCDY
	tgpgMYQ==
X-Google-Smtp-Source: AGHT+IHYBZ61Hkmf065FzDbmISs1w+H1s+kPtfBvIanyUT0Z/nhLrWER1j7n3G0iOTAUij8aXk2uZrIboMe4
X-Received: from maskray.svl.corp.google.com ([2620:15c:2d3:205:bc85:d604:bdab:a3ed])
 (user=maskray job=sendgmr) by 2002:a05:6902:1188:b0:dbe:30cd:8fcb with SMTP
 id m8-20020a056902118800b00dbe30cd8fcbmr35684ybu.0.1706684020985; Tue, 30 Jan
 2024 22:53:40 -0800 (PST)
Date: Tue, 30 Jan 2024 22:53:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <20240131065322.1126831-1-maskray@google.com>
Subject: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
From: Fangrui Song <maskray@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Cc: Jisheng Zhang <jszhang@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"

The constraint "i" seems to be copied from x86 (and with a redundant
modifier "c"). It works with -fno-PIE but not with -fPIE/-fPIC in GCC's
aarch64 port.

The constraint "S", which denotes a symbol reference (e.g. function,
global variable) or label reference, is more appropriate, and has been
available in GCC since 2012 and in Clang since 7.0.

Signed-off-by: Fangrui Song <maskray@google.com>
Link: https://maskray.me/blog/2024-01-30-raw-symbol-names-in-inline-assembly
---
 arch/arm64/include/asm/jump_label.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 48ddc0f45d22..31862b3bb33d 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -23,9 +23,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
 		 "	.pushsection	__jump_table, \"aw\"	\n\t"
 		 "	.align		3			\n\t"
 		 "	.long		1b - ., %l[l_yes] - .	\n\t"
-		 "	.quad		%c0 - .			\n\t"
+		 "	.quad		%0 - .			\n\t"
 		 "	.popsection				\n\t"
-		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+		 :  :  "S"(&((char *)key)[branch]) :  : l_yes);
 
 	return false;
 l_yes:
@@ -40,9 +40,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
 		 "	.pushsection	__jump_table, \"aw\"	\n\t"
 		 "	.align		3			\n\t"
 		 "	.long		1b - ., %l[l_yes] - .	\n\t"
-		 "	.quad		%c0 - .			\n\t"
+		 "	.quad		%0 - .			\n\t"
 		 "	.popsection				\n\t"
-		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
+		 :  :  "S"(&((char *)key)[branch]) :  : l_yes);
 
 	return false;
 l_yes:
-- 
2.43.0.429.g432eaa2c6b-goog


