Return-Path: <linux-kernel+bounces-72668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2343785B6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566D71C22335
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA9164CD0;
	Tue, 20 Feb 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iietwbf5"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF064AAA;
	Tue, 20 Feb 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420259; cv=none; b=Vzdaub9W05h6D//8RBkqOQ8cYGfp2XSdH28rz9yB25K4ZFD+Fc1DNLYsZ9MxMuLtmlmMQL4o//6n0flTrLjlJv/n9lA1YymCyUuUHsNOMVYnmNI6JLsIglEkko/o2A1s7a5KOBdw/I0FBVA9Tbg1rLoqTqZBJuU9QHKsNFFXeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420259; c=relaxed/simple;
	bh=ByO2dT7JtpPvKkaZeVRsaOzbk+s4KDVPKrxRRc0C6tY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JllFDF4dcYcshK/SI/e96LV3HRcWGcWDYJdb+Hbkf3GtAUYKeCxlYNFbjEjsva82l0Iz7RrRvVP47pRdgBCgAAKmaL+LKcX4ySujsizEldPFmdGwpgezOG+6F6RKG1vczXcQ3xc3JR91xci/5APez5Q9/ybDuvbSagkqZQkqeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iietwbf5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d375993f4so1300825f8f.1;
        Tue, 20 Feb 2024 01:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708420256; x=1709025056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J1QxAfuKOwJo1Q4eMgsPlCE9Pe85TkW/2/2T6KJzfX8=;
        b=Iietwbf5w2+j33i29E8+t5l8eeWswe13ba+NPl1DpLuMas9FyWCyZVuAhqZMGz7DIP
         ozrmcysNqEdiBrmHz9uA0tP0A41QcuqDREKf8yH+rKcJUGsK5vyzmBZwD9P1+tnxicDz
         7oGVZuPeNQWy3ZOWjHnHWFZq0a53SQ9GmSDF3pJsEaBLr/escTO3jkzW9cH/3m/M9mh+
         GylOMLnlRo0wypBkCyUi1gutLYtjjI7rxr9PfQDDgpS1aho4bhIOFEul6MgS0HqjM6A1
         GCuHdeHUiIGoMU9jGlKB2e4ikJCGsE3axr2ke3kjR1TVgXZHAyyVXG74dzkvZXwp/k2D
         xrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420256; x=1709025056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1QxAfuKOwJo1Q4eMgsPlCE9Pe85TkW/2/2T6KJzfX8=;
        b=auMTXxgLNenaeRgvcTdNQnElfSV8JEWnkCw8lSbvTRI8NygJ2195DYfBWUOPbj3MkR
         wBOOIle9VAjU6RNKMZHv/u0nflVDb2WlmIL5x5rEj48PJ5dzcVmcWoqh+bhNCTcrR0Uu
         OeV7APuzEM8z3YVRmWUbiER69LIaFRYA1TdX2e+nEjtvxfRQcp+sawu/SPfW7VVSsRxc
         6nlA7/+5znHTMV2Z1KzIAYvewKb7eUqq56lOsQoNqjrSSLKJL09Dln1AoxA6nEZsOeVk
         SCVLIKgUugsprkpFOGXjY6K8H1sy29ToKwWAZSyPqoQ8hTSC00mGfp2KO/w+GR8rCo6M
         3bXg==
X-Forwarded-Encrypted: i=1; AJvYcCXSwSzUVbAWS4TO0U4K2HPMn/4fkpRRGorosXuP/HHVyY4wDmklGcHwG9ruRrtOj93k1m/qYEYB1SkSUXy5u2PzfLjaB/dPRWsAKH2a
X-Gm-Message-State: AOJu0YyhTzU2lg/kqf4VlM0FbsSv2+ZNhrCCPk3Kh8l9+UGgzSAfUqPA
	W6Ne8FFFvOX+ifUlqPmDJp+FW/m+Fm6bVxm7Y7HPWJk21yV6e31jEu2Cil8G
X-Google-Smtp-Source: AGHT+IGQy/fQwxMahck/FXlqoUkhyK08LtRAagUHScMB3qr+o/gOGhrYsmy58O1bbJ56JDLuowi0gg==
X-Received: by 2002:adf:e6c1:0:b0:33d:581c:5dc7 with SMTP id y1-20020adfe6c1000000b0033d581c5dc7mr3602418wrm.59.1708420256108;
        Tue, 20 Feb 2024 01:10:56 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033b406bc689sm12928535wrn.75.2024.02.20.01.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:10:55 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] freevxfs: Fix spelling mistake "ivalid" -> "invalid"
Date: Tue, 20 Feb 2024 09:10:55 +0000
Message-Id: <20240220091055.2676456-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a kernel message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/freevxfs/vxfs_olt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_olt.c b/fs/freevxfs/vxfs_olt.c
index 23f35187c289..48027a421fa3 100644
--- a/fs/freevxfs/vxfs_olt.c
+++ b/fs/freevxfs/vxfs_olt.c
@@ -63,7 +63,7 @@ vxfs_read_olt(struct super_block *sbp, u_long bsize)
 
 	op = (struct vxfs_olt *)bp->b_data;
 	if (fs32_to_cpu(infp, op->olt_magic) != VXFS_OLT_MAGIC) {
-		printk(KERN_NOTICE "vxfs: ivalid olt magic number\n");
+		printk(KERN_NOTICE "vxfs: invalid olt magic number\n");
 		goto fail;
 	}
 
-- 
2.39.2


