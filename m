Return-Path: <linux-kernel+bounces-89761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8849986F531
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5ED1C203E0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CDC59B53;
	Sun,  3 Mar 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnzvAxc9"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF543143
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709473510; cv=none; b=Mrj5ay/aGx9V3kD1toPdR0HjSJEhbPAlrPOTdMBCfIbUXqxamDLDUlOPEdPOBD1DsukRSI0MedylacedkUIowaa3PJjFCn/Xd0Ol0YLWhf6RckxWLGpr8E9WR9wgPEyPR4l061saHogNJq0Yz3obPNTk0xWX2yLJK0oaXYi9PFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709473510; c=relaxed/simple;
	bh=HEgCdTvbhWhM9cKHruQw6qkKlH2qIXp7yjM9KSOCWwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bVKGCG2Gwe4Vsi8JSNDoxwxohrhqPwYl+zFVmp3qqUePxGNpb/Xi7pYPeDAUTeV2hnHwZFd5huukPkR3yUUFtk2VTrEFbty8re2p1RIH7//bYPnKmRvz0TTByQAP3KRVIKO6JTVkg9B4TudtSPIB9U4XpoTurKOXbokTFjJVW/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnzvAxc9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dcce5e84bcso29018755ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 05:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709473509; x=1710078309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+XvaSacvZv2FwpCKQI/VZDC6hmI2YHWeRkctoTLloI=;
        b=UnzvAxc9tjvBnVSx8yGbFhELy39UJVu+FyDQytWNlL5T2/tP3ThXYdGu2prjpSPxeA
         ues6tpBbsWL5GhXN3MdwY4JeS81XEKYFtSgJ4YXRzL7wIQUIq5KRNTZq8qzBUwrMxR4U
         WvTBtBU7TuRHqHIs+x6D5R+ATPKcOUNjreMZKJC63DwA5W3d32J6amvzlbY9bwq/9rtz
         3rCDr5shsR4Ke26jqEYib3l6WPDN6hevw0dlYZ2e9wypVTmHnQKqKrGwxZPRHjJ25ygI
         A3BF7zLDKhfxAZwYY5BrdwqMWAWNxsokN3qxUfH8Aga7gxKxJoA3SMmN58K2sG3UiAr3
         YiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709473509; x=1710078309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+XvaSacvZv2FwpCKQI/VZDC6hmI2YHWeRkctoTLloI=;
        b=H5msZmCSvvpGbdC6nhXzHe8CknSy0Y3dZCzngM0QilttWkbxWfZfYL9V8GZ2OyYL/z
         fY5al8T+Plwq3KDaBQVS8qok7i4vqgSOoXT5I8sdJnoIUdDWEfVRV/zIEQ3fj8DVRd9Z
         KJSRWfCl/aS4r9UyLXKtw8WcFdH6lJHr1KCb+Zy/r3EO50LF/jeuPbiisP6YhyGKNP6n
         Z5Lu++tqXCu+kUy7toWEI6I71JL0xVVOhiGu89+DBdtXujtY1tyIhDwXj5uh6BvKAhDU
         vkmw0juj/lWzQAitGBVQVHLgSFlLHpxYhnD26Ffl5ERueJOUx4Q0x1OA8RfqqIPkBrR6
         SK9A==
X-Gm-Message-State: AOJu0YwXztRYKRmBTJ7zasM+rBuA7+eo26Yuna6j2cyMnJ/D658sZm3I
	s/Oj8hlLSFvbQ2yadNeWmUpCP1Zx2arlzhlIc7uJI1gyjpAL5hF1ANwoQ/3T
X-Google-Smtp-Source: AGHT+IHp0+kCn7euvS782F+lC0zGNSOjCiP4/N9VFfmkptpZU9eXdpG/ngz60LloISbZgst1lD4Q5g==
X-Received: by 2002:a17:903:22cb:b0:1db:c6ff:664a with SMTP id y11-20020a17090322cb00b001dbc6ff664amr6965221plg.53.1709473508876;
        Sun, 03 Mar 2024 05:45:08 -0800 (PST)
Received: from kernel.. ([2402:e280:214c:86:98b4:6d91:d5f4:8f27])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001db37fd26bcsm6658041plg.116.2024.03.03.05.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 05:45:08 -0800 (PST)
From: R SUNDAR <prosunofficial@gmail.com>
To: openbmc@lists.ozlabs.org,
	iwona.winiarska@intel.com
Cc: linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>
Subject: [PATCH] Removed controller field description to prevent kernel-doc warnings
Date: Sun,  3 Mar 2024 19:14:53 +0530
Message-Id: <20240303134453.5791-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/include/linux/peci.h:84: warning: Excess struct member 'controller' description in 'peci_device'

Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---
 include/linux/peci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/peci.h b/include/linux/peci.h
index 9b3d36aff431..90e241458ef6 100644
--- a/include/linux/peci.h
+++ b/include/linux/peci.h
@@ -58,7 +58,6 @@ static inline struct peci_controller *to_peci_controller(void *d)
 /**
  * struct peci_device - PECI device
  * @dev: device object to register PECI device to the device model
- * @controller: manages the bus segment hosting this PECI device
  * @info: PECI device characteristics
  * @info.family: device family
  * @info.model: device model
-- 
2.34.1


