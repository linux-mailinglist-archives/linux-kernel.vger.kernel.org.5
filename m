Return-Path: <linux-kernel+bounces-163019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10D18B63B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2351B1F2223E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E25317799B;
	Mon, 29 Apr 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRHtzS5D"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6777177981
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422898; cv=none; b=o9SjbAWuuwC0s/6dDfaXpRxlTfPA4uDUC6cXX7hNnnirLHtHEeGifXw4Om1nTVF2hpcINKSI3s944M8gFodYiHZl3tGV2kJioddo+HeG/MwRr+oxJ/nVSqnlkmTDqPpaBq/N4ZREyrJH0qVDK1nYJTJmPgRxbv+nGNZLQBFjVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422898; c=relaxed/simple;
	bh=FJgJcexbKP8Vs2qsQoifsZ/CG9oPAv6wyYJlV8ROmx8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sVsCwHqcV+LDQzaNMUUBy3R3stts1roqagDAfXsfzPtEfZF1/WS76fbgy60dppxbyM+i1kBWLpnioF2Uv3NFUpDzImzRa9DL4LokVsvIifDBwyesLW5lFEBv20zLEOZ2F1H9Rueb5wKdoLqCbmUt9kwjT/kYTPvA+GpvnG8HxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRHtzS5D; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be621bd84so7438407b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714422896; x=1715027696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9mL2eooEb/7s/U1rMU577fBDSrTqCDNk48ffx+zYIGY=;
        b=rRHtzS5DKoAvUBeyaR31mxITXw3nPvaA9s/KkfoY+1nmJxgVjCho2A7gtn054OzBls
         kLVLeDfurj0Sd/csvARq7ngl5VIOZM3uMKMqePHjrfQWPAyyOE4FOmkYZybFvyp2KOHP
         2WqwUblr73UPLq8s1t+TH52Ayves+cfnKK/NEoOFuU8ctzpF8/+cRS+TVYZCSwW7chE+
         tUvO73/RwCtz9qOoquC1hWIND2mgnj6/48KuALuOWZC+yrqbGJZgtyF5i7yM3ZUNjTc3
         9u2dQyQ0z/Cc5oPDzsuw//2kcjGp+lly/OtslHf2bX/7802wQMr8vlr2J8/JFiY71mir
         hL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422896; x=1715027696;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mL2eooEb/7s/U1rMU577fBDSrTqCDNk48ffx+zYIGY=;
        b=KsAOxMe2Q67xpazySXgalW1X4dfNSrvherIjxnjp2U//KVfmAxI5ovzu0P522m8vKT
         nG6o6+hYEL7xFaLfVRTTlDad6uEIqa7dwhgX8fmB+7JOEqZH5RLb/gJHRC/nNvAY15g2
         eZoRX597Td4F4DhL56OHwN9uVIHbqeZSj5BULDCdw9CHOSiyIv8YAhr8ZmrkKAJOELL/
         Cb/xK/5Fxnd/3MjHxpRiAzScq+0OAuFUepNqoOJK7plk5awifKbsokDykx2/fpB8+qfW
         lHRiZc24pBhgdc5bHOiX54Nziqmv+xI4z4+32yd+l25jIx/LKejcEhL5x7/217TU+of0
         wQuw==
X-Gm-Message-State: AOJu0YxMWnUAZaMZLj47aiksZHjuYI7MoEb91rVlA0AyOHB3Ac9r5jaj
	4J7YNUarsDA5Y0WB27m3MXUn38P0NGGXYdMahmj8HzUrljUcHD6NIM2ZNoswtLZswfA/kx+KD69
	CMSEUEmrDljPsk4SBN9FenNzBcb/xnpp6j8t3QjVZTbHzsSQ/G6emOKx6XcP83OoxLZvro80D0i
	gYB8prhSBVGrKfQCXXugCvPiMhHqtmHyYFT4CXr/Ba
X-Google-Smtp-Source: AGHT+IEg/h9s1d+Swx9EJYfMUgBN/ifTzPWb8HrDxhF+oosvBsPlL28UkAI466cJzdn/BGYHBGso4LvRogE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:a142:0:b0:61b:a123:1c53 with SMTP id
 y63-20020a81a142000000b0061ba1231c53mr168083ywg.4.1714422895519; Mon, 29 Apr
 2024 13:34:55 -0700 (PDT)
Date: Mon, 29 Apr 2024 20:34:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429203441.143607-1-edliaw@google.com>
Subject: [PATCH] selftests/vDSO: Fix assignment in condition without parentheses
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"H. Peter Anvin" <hpa@linux.intel.com>, Andy Lutomirski <luto@mit.edu>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fixes clang compiler warnings by adding parentheses:

parse_vdso.c:65:9: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
                if (g = h & 0xf0000000)
                    ~~^~~~~~~~~~~~~~~~
parse_vdso.c:65:9: note: place parentheses around the assignment to silence this warning
                if (g = h & 0xf0000000)
                      ^
                    (                 )
parse_vdso.c:65:9: note: use '==' to turn this assignment into an equality comparison
                if (g = h & 0xf0000000)
                      ^
                      ==

Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..b9cf771006da 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -62,7 +62,7 @@ static unsigned long elf_hash(const unsigned char *name)
 	while (*name)
 	{
 		h = (h << 4) + *name++;
-		if (g = h & 0xf0000000)
+		if ((g = h & 0xf0000000))
 			h ^= g >> 24;
 		h &= ~g;
 	}
-- 
2.44.0.769.g3c40516874-goog


