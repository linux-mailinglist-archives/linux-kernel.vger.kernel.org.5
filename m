Return-Path: <linux-kernel+bounces-126365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504FF8935B5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 22:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4F028379A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F571474DA;
	Sun, 31 Mar 2024 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIytwqb7"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E8C2AE69
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711915558; cv=none; b=oVaJ2vvDTiLHvXUN6ja6oySBangOwneJW5A4h5+00HvvXmesplvh2AgUEcrtkpy3pxBvMnpBvEfL5UL2Q9keoWVWLnFmlahgzxaJe7W1qUP6BkxF6AwQJBhVZJfe0TbeXe5omnmJNsi5d+f2kk2tA9/y12J0HrM7OkMaCAH7KOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711915558; c=relaxed/simple;
	bh=nWo/lVSl7/zax0eJ9e/nA3Zti3zHzW6SCsT0zPwPayA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gbBQV5D8ne91YCB0VjeDoDHRIr+fUKGzqfN7MXyXNNY0naUfMm1/+Bhr2nzb3oonqAWdXhKmhlU/xKzRQmDqNJbdLMZIPrVxGKavzYZ+zhyCJ9IX1gKnYOtP7pw2eO8TLDJhuTLD08EqJh0Xy3tVp2qA9AjbH5TcoDgIvGf0WiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIytwqb7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c583f5381so4173622a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711915555; x=1712520355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8l5oOktQgqv2/DoOXHistMOI/UOO0pdnp/cOZA2XfHg=;
        b=hIytwqb7kEgELf9yJV2cLAYl+7uOwKjWqKFj/kRqzh4FbccKp83z4eHFxUJV5ie4d/
         XWmPbSe8RSRmn3KxtW7V3b3UjAlgpuLEhCmv57g0Rm/ZQEGqDBP1sZ20j+xF9VAkHaVA
         q+sYMda62VgZgQCkop05RVBWcYcjjAC7sTGZdBG8gRqlLg6VlT+IkAx/TxjRLrm035fZ
         QMoALsKev+Gqtxgpy5sgyEhwlUW5O6k8I1lLWR3aNEAHj/M+XDtPMNktXfdQFRLX1f8K
         NnUCj9ECqhO529W4twfeesP+EM/DpI9bNPhl/8D/L0FS7y7YraKvVZudTQWL+q8128Fq
         XOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711915555; x=1712520355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8l5oOktQgqv2/DoOXHistMOI/UOO0pdnp/cOZA2XfHg=;
        b=RGw4F9F9LnHFkRYgxmFHmcByt3trYyrY8ET0dp6cvmIpvOmPJ2efAFg9170WVWvYJ1
         ETrVHWWjUBlrI8LtFl68E/q1RQWV7CUkIh/JYjOMp8365aaRDZTy3oG//XfXan28QiW5
         cBcI0kqq1+lFBC5aM7hLRMyT6HZPfH+QZZcBN/soReBfX0XjLY3z6XGMq/ia2e0L/0VY
         h4VT6BiqW8tx2o3oGwTZAilxW5AfClMxEu8ZSB8za7jDshRYBtY5e+/L4wsn53IcIEbn
         2tJ3aDH3H+gPls5WtDuIXH72471I13VhQIQsHoZMZVUTlG7vpDa4gSq5IaibDmPGVEQ9
         6Cew==
X-Gm-Message-State: AOJu0YxFHAOMZohJHrOtlOWuBm/7VV01vqBxAsIs5IPfU+v6JUdU9pRm
	Qz9Rm+VHRf0XjpxNVmfwXNmeyE3QttdFviy+8m9FUA/kFhwRe6Gl
X-Google-Smtp-Source: AGHT+IEJeSr6EowychzJzCC/ZRe48sQmIk34tTacp1eV0J1A7WRDFkEzd5+vcrxXzbfovP3IfI0Heg==
X-Received: by 2002:a50:9f09:0:b0:56c:195d:b162 with SMTP id b9-20020a509f09000000b0056c195db162mr6328700edf.6.1711915554552;
        Sun, 31 Mar 2024 13:05:54 -0700 (PDT)
Received: from myonaiz-Legion-5-15ACH6H.. ([37.96.23.97])
        by smtp.gmail.com with ESMTPSA id c2-20020a0564021f8200b0056bfca6f1c0sm4636747edc.15.2024.03.31.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 13:05:54 -0700 (PDT)
From: Mahmoud Younes <m.younesbadr@gmail.com>
To: dave.hansen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	luto@kernel.org,
	Mahmoud Younes <m.younesbadr@gmail.com>
Subject: [PATCH] kaslr: x86: fixes log message nokaslr
Date: Sun, 31 Mar 2024 22:05:46 +0200
Message-Id: <20240331200546.869343-1-m.younesbadr@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unknown kernel command line parameters nokaslr message will be printed
to kernel log buffer if nokaslr option exists in boot command line.
nokaslr gets consumed earlier and this message becomes confusing.
impact is that user gets confused whether kaslr is enabled or not.

Signed-off-by: Mahmoud Younes <m.younesbadr@gmail.com>
---
 arch/x86/mm/kaslr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 37db264866b6..a62cb0675e22 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -179,3 +179,9 @@ void __meminit init_trampoline_kaslr(void)
 			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
 	}
 }
+
+static int __init parse_nokaslr(char *_)
+{
+	return 0;
+}
+early_param("nokaslr", parse_nokaslr);
-- 
2.34.1


