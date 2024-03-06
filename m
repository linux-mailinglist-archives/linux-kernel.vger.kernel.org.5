Return-Path: <linux-kernel+bounces-93296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B4A872DAA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599111C219AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4977B14A98;
	Wed,  6 Mar 2024 03:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF/QxwQo"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F0171BB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 03:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696895; cv=none; b=DOBjJ6JRV0w3bfDsYcoW666NH9UKVfpOhznC6IGnC+BonvcSZsMSGtcK01TBQsC6Rcvu0L+AH4/3dxY4oQsNny4kTEUE0tYolcPK6/cq5xU/669zh3hXEc2jqCiUX6/NbByWXwG5zLzsxr+becPC/LdG/NegupWNut30a3mSKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696895; c=relaxed/simple;
	bh=St9h/+bWAu6YRwQAQlMD4+fbPy3oF63/fAF6IAwIBV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fXJpiJmFJvZgj0AX6gdPL1FcRH+IAuzh9nAfk0Ey69R5SVNuJ5NdUJkhI5If9o1MXJFul9U/Ag7B4uqGWlADGu4JBtWgXegCaeW7uqccGtTi+fgz+onYy5bzLnWmPyqylGcKBTiUF+TI4yTa5J6F9GR2nI6eVsTDVHSqEv0sE24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF/QxwQo; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c1f55ba3ecso1395683b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 19:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709696893; x=1710301693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3dFueebX921q9ASDQ4GIy98CaSdx6xaQg+PhrFhce1c=;
        b=QF/QxwQo5KLm2ZknHESODLexHLO3J2in+VHk4otuYqy6W2MrA2llmyAXafwOaHYTvQ
         NxBo9eCOGaPbQlY6YJ7U+m7cG/l7zxtZyrjenq2o1wSXhJVo1N30oHi5D+EFDw48pe70
         kBl4bWR4LtQbX5cnpffRGtfusoFs9nyikqg1e9gtLtRY4LTBAjEbXW9yqm49nmEy2/Xz
         hq033oXAztxcEhf5z5Wdgt8+7X273eDwHJNV46VYDT1pMnXjb0lhzMtR/Zy01QI3GgKo
         4+qw5fiUbbLzvEdF1553aEXH4aICskY/Qpoqlovst38s1s3oeyvQUYiCbFe3EXqSTqHp
         alzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709696893; x=1710301693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dFueebX921q9ASDQ4GIy98CaSdx6xaQg+PhrFhce1c=;
        b=Ycy3c+h26Qj9IjyFVh+5ZcBX7xbv66Xr/U4zxMp97gkaUF46DfcE12pPXMtAtDwOZp
         IHyajPenyWiwJz9sfjQaKYQWo5D/5NCCuA022RE/BLpnvhYkLwHo21CYyixm6QjIsUSk
         MzP0GWJ7McmQlAVMK3FgxtkeOP4YG3+a8ug1yLHsDFmlp+2eFf+tzd+cVJnC5QzhN3uj
         e/LRVWZVoQkFkLhzRsPwvKamPdmvv+J1F7DOuBQpMqYLJx7qIy6D8ug08pu4N+KhjsV3
         ooTsoyWJGVJhQif68WwU1qdS5OjxOpWo12slzsmY2j2OgmcThGkossryVZwKVh6o1a6s
         P9MQ==
X-Gm-Message-State: AOJu0Yz/QJzwzbplWSEpzgZ8gkWGGKj6pZIj8+HRC7mBpBHSIec+QaWZ
	a1Xa8hLFgNI0zHVPMWo8AeyZ9aVkNpL1tJexl4muOsD/nnWF3eK9gqcjFQ23rxs=
X-Google-Smtp-Source: AGHT+IHTyN5mI+PUfGcKFCyPziQNB8MoBPoLDjp+YUhxaIAFpIeWxKBYsBFNmQhGvkueYRcfBHqasA==
X-Received: by 2002:a05:6808:1901:b0:3c2:10c9:d930 with SMTP id bf1-20020a056808190100b003c210c9d930mr4073332oib.56.1709696893272;
        Tue, 05 Mar 2024 19:48:13 -0800 (PST)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id bd9-20020a056a00278900b006e60c07f551sm5022921pfb.200.2024.03.05.19.48.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Mar 2024 19:48:12 -0800 (PST)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH]  buildid: use kmap_local_page()
Date: Wed,  6 Mar 2024 11:48:04 +0800
Message-Id: <20240306034804.62087-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Hao <flyingpeng@tencent.com>

From: Peng Hao <flyingpeng@tencent.com>

Use kmap_local_page() instead of kmap_atomic() which has been
deprecated.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 lib/buildid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index e3a7acdeef0e..29fdfb4cccf0 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -140,7 +140,7 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		return -EFAULT;	/* page not mapped */
 
 	ret = -EINVAL;
-	page_addr = kmap_atomic(page);
+	page_addr = kmap_local_page(page);
 	ehdr = (Elf32_Ehdr *)page_addr;
 
 	/* compare magic x7f "ELF" */
@@ -156,7 +156,7 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	else if (ehdr->e_ident[EI_CLASS] == ELFCLASS64)
 		ret = get_build_id_64(page_addr, build_id, size);
 out:
-	kunmap_atomic(page_addr);
+	kunmap_local(page_addr);
 	put_page(page);
 	return ret;
 }
-- 
2.31.1


