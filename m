Return-Path: <linux-kernel+bounces-40773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D39783E581
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E321DB22378
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5045B5CE;
	Fri, 26 Jan 2024 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="N0OAlZYB"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B909759B54
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308311; cv=none; b=KXRM+1GmNmb3KId/6SDqy+VqIIgDq5PPTPcjFf+rM3AOjN4yW4ieib2xc6Z26TIAOzspBskS90NiI5k0cvNqKH4Yx4Z2kOKFCFwzVcHI0xFDChc6aHkBGt8g/fZEjJNpqZ6JPyj4Tc4DxfQ0yeN3zsQpxGHvrbjhmTkU+t0Z6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308311; c=relaxed/simple;
	bh=c/Sh9PRJ8GX+JkwZWgUrdLEBHDSPigEF73skZkz9+Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eyjOBnR3Q/PZkvUUYqIiWBeX4X4DPbgPX7OB80INjpkgsKLDsNI/j2RVJArF6YZQBBaAkTSLt75CcJvyH6DTvUtPPzVNCveLL+2WvaWT3jXinvdzsvU4sks5FAkHqMklJnpBnJjqO5Rw8hnLz1/4bkQmVQ1Xmorx/Aj7kI+2FQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=N0OAlZYB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so680861a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308309; x=1706913109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJnSm+DEHNecy1tYaBiXclaJ5sFH22g6A+EL7JgZ6iI=;
        b=N0OAlZYBo8e7JLJCEPz606NE87BWEdA5MGQgNqQkqZ+Yii5S/an14z24ywo/DDAWPn
         G14B5CWLHoaZ9hzdemEAELVuomkzzC3ANYKWUOTOjcszpph+/zbNPulfDz6i+LeGjxYv
         QjeMk2O+JTAzIU4J2Ihi1ccvK3z5VBKv7uc6H6CFABTOZdMhopSaF2rEUgMUvepL4duc
         RFtdrHgDTOZEwKlsendjiXe5cZrH9BeyTOek0UT8o1s/HwdbZEGDr4SSVjfMY06fEm0z
         MOKu5hGpqOYsygdAtUQJ1ajdRATCTODfqrsGjlJp3CHAN/RHGKJ8mA/5AREEwrfGo2qo
         S5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308309; x=1706913109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJnSm+DEHNecy1tYaBiXclaJ5sFH22g6A+EL7JgZ6iI=;
        b=FElaV46Vshmu/LhSOxH7lWm93ssW2YzSujjIMmletlsy7WP/1G+SW4rYcqrHk1YO5t
         8ndqaz25L5tb9NRrwGLHwtGAWoUqspR4T3Ncz4JaQ+ECMIavjIh374CpDr05awwmtO2U
         PJEw+6V3MZr8ZLw+rKOhsPJIJJqEcGkCe7Mqn6nbHZxgrd4UTWoMA1G4vFpUHbVlYWQC
         736eFTJh8XnUmlxhx6sXt0XlbchO+WGGxZY2QMIpItom0iPDqfwnXETaeGPZSh38V1EE
         zDniwdpbOMxfub0s7RNlvoGV57xWmIEgaSFRSz8qm+l8RfKECo9cA54dURkjOQGYesM1
         cD2w==
X-Gm-Message-State: AOJu0YxLcCdsF5TZ8Wh3036hXLBVWgUIrgNRFBGypRSCtdIv3vKh7qbr
	XE3+DRMeXFLjMhbUp2DOlT89ZTauLsLymukCHqpFfqLaS7KqDYAVe3Lb19INwuB8Gcql/jPy8av
	S
X-Google-Smtp-Source: AGHT+IEYYS8Wepck+t6Q7uC2+EO7+QJsHE6KYqDSu6lWOjJuwRCpezjdFDWTL2euMnocAbGygCeBjw==
X-Received: by 2002:a17:90a:6e45:b0:28d:dd91:fdf5 with SMTP id s5-20020a17090a6e4500b0028ddd91fdf5mr593246pjm.23.1706308309099;
        Fri, 26 Jan 2024 14:31:49 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:48 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 14/18] Staging: rtl8192e: Fix if statement alignment with open parenthesis
Date: Fri, 26 Jan 2024 14:31:02 -0800
Message-Id: <20240126223106.986093-15-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126223106.986093-1-tdavies@darkphysics.net>
References: <20240126223106.986093-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a space in front of statement to fix checkpatch warning:
Alignment should match open parenthesis

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No changes.
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index dc91e59f1bc2..5281138ad468 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1207,7 +1207,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				    ieee->current_network.flags);
 
 			if ((rtllib_act_scanning(ieee, false)) &&
-			   !(ieee->softmac_features & IEEE_SOFTMAC_SCAN))
+			    !(ieee->softmac_features & IEEE_SOFTMAC_SCAN))
 				rtllib_stop_scan_syncro(ieee);
 
 			ht_reset_iot_setting(ieee->ht_info);
-- 
2.39.2


