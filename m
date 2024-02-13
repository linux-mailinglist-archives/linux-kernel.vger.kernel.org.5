Return-Path: <linux-kernel+bounces-63083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7268852AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA97B1C21A45
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD57224D5;
	Tue, 13 Feb 2024 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="JTDqkXlM"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774622334
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812203; cv=none; b=RCh2K9F1R3jv8bXZxsSzOhJVAyq51f+BZ7DGIlQe/MBc3scvOU1ZAG1wlu20OtITABkPHqY6AjG6cZK120Xift4WjcKbb5darjOwE2Dqk6gKCRCcDTYsh9G9rWPk2Gudk3j5xVdw4po9TLz+JfAcKBSgX7laPpKvUFNgLLnuKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812203; c=relaxed/simple;
	bh=pUSVavZmcjyYbi6RShnaW6jH3HO+mvOqqtpuCzNxeUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgAATqm0+NckT6saCAzOUhvdc9a9JBmVUeS+deTi5HF5j6DM3OcVihk2Re4+Ckm2Be2kCGJH18x/hiw0lSwpAQ1RNFGybzOZ1OooOGJcjltOnwNNK0DeMWSOmeHF++9fdlcDyBcCohg6+goDeFaJon50U+9qpmkAfvpuYmCM7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=JTDqkXlM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d8aadc624dso29902755ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1707812200; x=1708417000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+aOrCJIUWm9gZNxG5N0dygbdBPzUIeW3edWmhaMQB0=;
        b=JTDqkXlMw3oFhGhOQ+xYUcspUqxYWHU+vROYhHI1RV/tvZww1CAalRYRXImLPYCbMU
         b9S24yMYmRMWfo0DUT0kDz2zvhJ3Zwf2Q26tu2nfbdD1xBHahtB9vJDOQOVmucph3Hla
         sIkq6LU1CgouoGHOOD32v1BnW6/MsKeq/P2LJTD2rEnD12OS0hrvCVC7qch7hZj46Xdr
         6AY9zXv+axAXLrYnDGLxqDVY4BFMCqs5NQwDdOcXouGeZgFfAOkzx9/5Qok6jKVl3jIE
         qKW5O6whncjCORccYbwfKlBXBst0tPljWEsG2YeaWWaRve46RYbftEcNzCXXsYctEhkq
         ekQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812200; x=1708417000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+aOrCJIUWm9gZNxG5N0dygbdBPzUIeW3edWmhaMQB0=;
        b=P1zRvwT+bLd3ljh76RXq3MZcG/XwCTMplBboIhlZFWtWMyLSx2j85eFxqPq+qgGu8T
         UTxFkyJrm//AZqf+47nQKSc/m69yavugptRIDisf0h9xS1w0Aq+W7n7DN+gt+EsM5Ufu
         S5F9dhahgpo+7Fy2AKnqPwLxi3h2ShOKgV/YVl2UM5bsP9e5YCOpJPRK53LWQjZUHs5n
         Nycuj3Cm78CZQVsWrpMVK+1O31J5DHCzTUswwAgNYNgS7Jykhw35+Mu/BbeTjp3d9kwX
         n6H+yQadaq6LcXmdbJQf9a6WLdc2TjKddRGRRGEJGVpoJFJVKqhWGGxNpMaVaWsRQ3Vs
         1AeA==
X-Forwarded-Encrypted: i=1; AJvYcCUU9hkxM0EOIunsINhGOfFdvVcu4Qvh6NwVDSbGLmddJ+hWEAwm8joJ9d6M+R/e2aEJLq+MywV/0Dt4kPNCBRGtkrB9dIVOwVaTY/c5
X-Gm-Message-State: AOJu0Yy4LjH8ewelh08RPAXo863x7riaHu2CJvs9zDu7BZP/KtlVSAKP
	SrtVPjjsCeIukvjkPblfsbiMq7hasgM3ZBVowcuKTGLcRN+b9TrcOvQRjuR3euU=
X-Google-Smtp-Source: AGHT+IHN30FOf76CIlJ70s4RXG08RhVc6llnrHToPYD4rI38cBg1UPCeufOMlRlWoRo7BYjOTkacFg==
X-Received: by 2002:a17:902:784e:b0:1d9:bf92:f51e with SMTP id e14-20020a170902784e00b001d9bf92f51emr7463057pln.49.1707812200433;
        Tue, 13 Feb 2024 00:16:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYaiB4sJIlOpc7RRe3eZfg5f90Re+8kea9EJomeq8BGe9OkX8RGdoQT5J50iUT4DchvymvZt2277c1SRur2DQ9jXLBwtcktzhgrlV8inuxHYziucR2B3sGPqnetqihS6EsrH4vMPkRLcDzps4GERHVa7pMGkDlYVF9fe0RjRJEDGeIzxi+CowcX9zmvVf6CbZN9mnquFaARgFq73e3EWur064bF3Vyf4CdaWMcDfkM9NP2V5jTy4dwJuDUoyk2WDbt9ZwEE7n8lmxvTOAypu74vdH4h6mdc8bLm9YECEK4pmm48e0YFKKW2tuS
Received: from localhost ([2620:10d:c091:400::5:b0f])
        by smtp.gmail.com with ESMTPSA id kq5-20020a170903284500b001d8ecf5ff6csm129187plb.147.2024.02.13.00.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:16:39 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jonas=20Sch=C3=A4fer?= <jonas@wielicki.name>,
	Narcis Garcia <debianlists@actiu.net>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH] mm: memcontrol: clarify swapaccount=0 deprecation warning
Date: Tue, 13 Feb 2024 03:16:34 -0500
Message-ID: <20240213081634.3652326-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The swapaccount deprecation warning is throwing false positives. Since
we deprecated the knob and defaulted to enabling, the only reports
we've been getting are from folks that set swapaccount=1. While this
is a nice affirmation that always-enabling was the right choice, we
certainly don't want to warn when users request the supported mode.

Only warn when disabling is requested, and clarify the warning.

Fixes: b25806dcd3d5 ("mm: memcontrol: deprecate swapaccounting=0 mode")
Cc: stable@vger.kernel.org
Reported-by: "Jonas Schäfer" <jonas@wielicki.name>
Reported-by: Narcis Garcia <debianlists@actiu.net>
Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1ed40f9d3a27..107ec5d36819 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7971,9 +7971,13 @@ bool mem_cgroup_swap_full(struct folio *folio)
 
 static int __init setup_swap_account(char *s)
 {
-	pr_warn_once("The swapaccount= commandline option is deprecated. "
-		     "Please report your usecase to linux-mm@kvack.org if you "
-		     "depend on this functionality.\n");
+	bool res;
+
+	if (!kstrtobool(s, &res) && !res)
+		pr_warn_once("The swapaccount=0 commdandline option is deprecated "
+			     "in favor of configuring swap control via cgroupfs. "
+			     "Please report your usecase to linux-mm@kvack.org if you "
+			     "depend on this functionality.\n");
 	return 1;
 }
 __setup("swapaccount=", setup_swap_account);
-- 
2.43.0


