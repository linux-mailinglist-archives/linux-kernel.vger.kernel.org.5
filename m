Return-Path: <linux-kernel+bounces-157163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AD88B0D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A1228BD38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90015F3F3;
	Wed, 24 Apr 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag8YyFh4"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBE15F321
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971256; cv=none; b=LK91C8TEAj2u6dH6HeDMEZBeFCkwRVawtG4shixL78OrYwpleeUs48AkjOv8ObZ+4x4KFLR2wUO16xzzpE2J6yPVHhJKSB3crMnCB7TCXdBShkHzwIMcHj3rTc78wQCWqnDNqTUuMWnFYdDOslNEZxfcnw+fACoVMBkHyMuKV00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971256; c=relaxed/simple;
	bh=6EFZ8dy6bZfZmhktoDV+jgQNCh0YsL/CgBxHTL3rJfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A57mBMWTkVpwl190YGHlRAl4uZJyUFxkbasmUcIUK8BWhz6MvbtYdGx0ZioYsdkRCRpNt9TAWmUR6SwY+GTVWWDPpvY6lNsofnY0ijkJDTUYH2wztg9MlQnIEjJQS1hVPAXEOvgSnGOplo/hgpTeYUJjirVIfKMYNx0k1jbirg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag8YyFh4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e86d56b3bcso48144625ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713971254; x=1714576054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFCwS+dd80ug/yeLMuHLZKf5f5L8AtiYXNjRk6IaZvk=;
        b=ag8YyFh4Nj7qFhtu/WF1clGQZtHNa7H+4+uUsZsCHZ2PXL9welQUpl0KMbO+Q+uM6D
         N2CDMgmxfnpaH+Yyw4QC3ymyyqSmxJIcmtY0PICi4YJhFgxwm+PcrVJ8vr7xJ+Kcg3HP
         bh6sILMFoJigt9Q7GCt9sDfNDcDuwQgNiWOwF7EbauN71YSQ+hksZrwB4esyVGNuA6mF
         r7thqDTwli30YPM4/HIAoEQaabVSbew0INt6v4R5o5ZEtjeGXVvglbXUvFDXb+sVYf57
         OFSuj5oP1h6tj135VzSyo1pOP+JLuxqVoHsM60Ut9khYTK+qj8M39JPC10HAvpgeoayq
         IN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971254; x=1714576054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFCwS+dd80ug/yeLMuHLZKf5f5L8AtiYXNjRk6IaZvk=;
        b=NTLoM134Fb2j94xjT6M8GPx79nwtcO+9xAff4wW1SBY0cB71DYopl+1lq8xd1YOHl7
         Yprr6Rc7wtJ3vnR+qqoviqBfeXNxCdDp8EvUq5nrAEoLzGcmg4laSK1nPw+kpGndO5ht
         DiqDuAWzyYtm63x00Lfh3dcefqY9zgQUUkXK+K+WqFIDdYMJi3FCfzQ+c/g76x/7SXQF
         e8tvcWC7ZVvU20bvxQAOmvGktFEfdzpUCgavFrpAzdA7xvjH43AVp8Zh/WV77eUqRp0K
         zmWGu/cuJ8lZKEvjBmnErtAq9hc8Zhpkz15xvwSvGCRv//WR/ydKxWFC6bSdYH3jyEVc
         lvFw==
X-Forwarded-Encrypted: i=1; AJvYcCU68ReRCXXZez3rmTCTZOClnQgamaBZz7JS+MHBeMsZsQVddMPs/fPWRmxthSt0M+poRwzOPKhZkYDyFnX8winxR6RbIqsg/W8VYixc
X-Gm-Message-State: AOJu0YyTm1Vb6QcWdJG788FKbGnZskeW2LEoatoQFqYLWMdB4x9XxP1w
	HBdIBynytYlrurkC8e1vIXRjmqqXbuZy9z7xfNv9fkYGaxwaqbv8
X-Google-Smtp-Source: AGHT+IFtkfYdH0o+GqgdSpQhcrFj+BTfT78r4+LvjmauJpWP2Ck4K9u6q/dIUlv+L6bGO6qzP8NQNQ==
X-Received: by 2002:a17:902:b611:b0:1e3:c5d1:2324 with SMTP id b17-20020a170902b61100b001e3c5d12324mr2770606pls.32.1713971254266;
        Wed, 24 Apr 2024 08:07:34 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:820f:5b56:3996:5bb5])
        by smtp.gmail.com with ESMTPSA id w11-20020a1709027b8b00b001e4458831f7sm12003335pll.77.2024.04.24.08.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:07:33 -0700 (PDT)
From: sundar <prosunofficial@gmail.com>
To: yangyingliang@huawei.com,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	sundar <prosunofficial@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH linux-next] macintosh/macio-adb: replace of_node_put() with __free
Date: Wed, 24 Apr 2024 20:37:18 +0530
Message-Id: <20240424150718.5006-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use the new cleanup magic to replace of_node_put() with
__free(device_node) marking to auto release when they get out of scope.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: sundar <prosunofficial@gmail.com>
---
 drivers/macintosh/macio-adb.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/macintosh/macio-adb.c b/drivers/macintosh/macio-adb.c
index 779f1268286e..85d404031cf5 100644
--- a/drivers/macintosh/macio-adb.c
+++ b/drivers/macintosh/macio-adb.c
@@ -83,35 +83,32 @@ struct adb_driver macio_adb_driver = {
 
 int macio_probe(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, "adb", "chrp,adb0");
 
-	np = of_find_compatible_node(NULL, "adb", "chrp,adb0");
-	if (np) {
-		of_node_put(np);
+	if (np)
 		return 0;
-	}
+
 	return -ENODEV;
 }
 
 int macio_init(void)
 {
-	struct device_node *adbs;
+	struct device_node *adbs __free(device_node) =
+		of_find_compatible_node(NULL, "adb", "chrp,adb0");
 	struct resource r;
 	unsigned int irq;
 
-	adbs = of_find_compatible_node(NULL, "adb", "chrp,adb0");
 	if (!adbs)
 		return -ENXIO;
 
-	if (of_address_to_resource(adbs, 0, &r)) {
-		of_node_put(adbs);
+	if (of_address_to_resource(adbs, 0, &r))
 		return -ENXIO;
-	}
+
 	adb = ioremap(r.start, sizeof(struct adb_regs));
-	if (!adb) {
-		of_node_put(adbs);
+	if (!adb)
 		return -ENOMEM;
-	}
+
 
 	out_8(&adb->ctrl.r, 0);
 	out_8(&adb->intr.r, 0);
@@ -121,7 +118,6 @@ int macio_init(void)
 	out_8(&adb->autopoll.r, APE);
 
 	irq = irq_of_parse_and_map(adbs, 0);
-	of_node_put(adbs);
 	if (request_irq(irq, macio_adb_interrupt, 0, "ADB", (void *)0)) {
 		iounmap(adb);
 		printk(KERN_ERR "ADB: can't get irq %d\n", irq);
-- 
2.34.1


