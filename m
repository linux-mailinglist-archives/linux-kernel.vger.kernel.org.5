Return-Path: <linux-kernel+bounces-128076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFA48955E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1773B304A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4366D85275;
	Tue,  2 Apr 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUg/kpgg"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221F784FC5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065497; cv=none; b=WMOgDYbb337guoxj6HJxVjyjqcg3ed4fOeFIs/9wX8YDNLYwiC4A0y6JynfO4E8hMrE1jwDL+cEt3GKI1c+2P59a8s6QnmrP5HME4Ffs00mcfHqlxvkexQQdkcYGH+FnQ/9WnH66ueaOju2IjELU/IZ+Jovi+gUImrUdJcYNSAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065497; c=relaxed/simple;
	bh=j6HnrewUXXcVCrmagzRk/1sPsI6ZmP64l2r7EUbkgpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QzRmaRg0p0ns6kv2VcPHTF1Dpo3huvIgmcsmWkEDH+YIcW7aQfaEG9Yh529LEGmn1L2P2ZyVHj2NdQLlMxuY2t/sf9bQ8Vs8KiTpDL0JHY2urcCxTqCYnJY7i7c8Cm6/ohS5lLEjrwPCM5f6Cvme+ddl3ji2+HUrMTKqCNC68yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUg/kpgg; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a47cecb98bso3471184eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712065495; x=1712670295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zq1akPhp53NDLWfVI14XtR64kJ44Ez5rZRNB3dsutTI=;
        b=SUg/kpgg5aUzzL5sLOvcgAICzHsvLeIqcX4E/w2+xdSbK9vM3epkVJ87gs7Ic2PGli
         0ksHhsDYYVeru/Zxg8B0/yKhpr/4XCeb1ob6BTV0F06v58Bup55OR2/LUBLI16uLv6Eq
         nRaGDTtf7/Abc+V6XGIN2vrpR5RUO9o7/81kTcf50efkfJzgbCdV5k5RDHg8sL47rzdY
         VNCwPC/43EnKxSyATOrc5osn2cqg8MSd5K57278XRr2Mn242JqV5/mem0ajxmElyPCVf
         2X/FQYvGfuqWFmcRTGvdMzyBGIDdCzujlecbFaAlIUx8OQzOVqXSpYxvk/Z6SORbBXMW
         ZpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065495; x=1712670295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zq1akPhp53NDLWfVI14XtR64kJ44Ez5rZRNB3dsutTI=;
        b=AmsH+RtnVsFUIzTkuYcK/JwQn3NOSOYfum+IQ/pKqwcC6SiML+4C7nQQfE7kQpDqHw
         t5Cdi1ZeDm6zH0EDpys4tPW1/QOLfhGh3glsxTN3V2a+0PE4UCYH2Cb4pmrDUo34GFj+
         YWYZkvdftKmZbHeLvZgfYiyMWpgzA/gml/ZCm/1IHS8mHJbImkVAs2PtBmoWeASr+SsN
         nmJYVJ3LI6swtgIv/XSF/Mg6VAPidHG7+/iow8QplAFnAAZDoBqynIMS9d9hv8E+/RFV
         h6NnvGwpKm+KLQ8iaO5irSxoPxyhobE3y0se5PEa+jxvDEUEv9irfK+uzFal5Ol+EihH
         h7iw==
X-Forwarded-Encrypted: i=1; AJvYcCUr736zExSe0AIdUA21ox/XK/YPhbC6F0o5fUG1jRltLOBrutRI+CDY2/1SHulPFthf93buT/d7yYioRyD0RexTNDYBwi4iAENMpMcN
X-Gm-Message-State: AOJu0Ywu/8JCXtm1FC53EFhpee2qIVsTWRrOvlBOQnaJgdBCxdadRYxF
	EEK6SQylaY29LOe3Em0KEQU5CvEzqc6MZDTyNcU5Z9+5r3m8D/ZQ
X-Google-Smtp-Source: AGHT+IFRuGf1HWoBJxQ/xpQxoFYymCpwGo8HPPrz9dIuAsckTdfswSQlbIStO45l4SMnToWJ0lpafA==
X-Received: by 2002:a05:6358:883:b0:183:6537:8781 with SMTP id m3-20020a056358088300b0018365378781mr16790759rwj.26.1712065495122;
        Tue, 02 Apr 2024 06:44:55 -0700 (PDT)
Received: from lab.. ([140.116.245.168])
        by smtp.gmail.com with ESMTPSA id x8-20020a656aa8000000b005b7dd356f75sm8546349pgu.32.2024.04.02.06.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:44:54 -0700 (PDT)
From: Yu-Cheng Chen <otteryc210@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yu-Cheng Chen <otteryc210@gmail.com>
Subject: [PATCH] mm/ksm: fix missing comma in comment
Date: Tue,  2 Apr 2024 21:44:44 +0800
Message-Id: <20240402134444.77498-1-otteryc210@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit added an omitted comma to separate clauses, to ensure
grammatical correctness.

Signed-off-by: Yu-Cheng Chen <otteryc210@gmail.com>
---
 mm/ksm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8c001819c..b4de5a9ed 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -385,7 +385,7 @@ static unsigned long ewma(unsigned long prev, unsigned long curr)
  *
  *      new_pages_to_scan = pages_to_scan * (scan_time / target_scan_time)
  *
- * To avoid perturbations it calculates a change factor of previous changes.
+ * To avoid perturbations, it calculates a change factor of previous changes.
  * A new change factor is calculated for each iteration and it uses an
  * exponentially weighted moving average. The new pages_to_scan value is
  * multiplied with that change factor:
-- 
2.34.1


