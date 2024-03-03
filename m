Return-Path: <linux-kernel+bounces-89775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A8886F58E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D758DB20ECC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6EF67A12;
	Sun,  3 Mar 2024 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu1QKHX+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570623EA68;
	Sun,  3 Mar 2024 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709476767; cv=none; b=MAH19cZAmFSYGcY/pdl+LqeGM/udmKDHhdqL91mOQuiXy9nBzNI+eSpNqf9PhcRCbhbAVNf9yjN1EDOOoDPgRnXbNmsbNrBXTcoOx5r2GfZb7pQTUVLx6uVIktdc8O684/VatZTklUdehFWjnWsw0507KPal9/gD0pNYkmq1f6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709476767; c=relaxed/simple;
	bh=oCakb96QHj+YOMxqbYWwKD2Ni7U3lWwRqWAP8GUBnP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YsKWKkeWMBsBSieMDR3KiezN1jPAwUg2Mr5DhsWzOxvYo0j2fSNT78vYgPul375usKCaWcbOYljBPV839g7O3jL8mEwxm60LwTFsekjAZTn9/EpaIR6+pWq0T1KOXDR0+20j+TB7dVrewghxf/Tye9AO8MGfj7lILy+k7ufT78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu1QKHX+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc29f1956cso28707655ad.0;
        Sun, 03 Mar 2024 06:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709476765; x=1710081565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oBbfEkG98FnEmlg0aeqk2gdgPye0efTyg1ck9DlRbYM=;
        b=gu1QKHX+PhqEOR2dX5dKd08Qc69410OxyJGS5r95uhxPmMwGo8ZgEL6l4pXr5sz96h
         V5Ngol3oztljF20p6V7Gl85PaHviCJ9FxPJkqCk6dIeYz+ipDPc5H10sXgI0rWKBr9CR
         gabPsiILusn7S9E2lHtgmTWUk4dEoBgVxIGdzxEFrZCMgSCve8zQ9BHax4tA+I+6g8nN
         XHA2P9fx2VIJbKcmXFeKom8/NQ65EGj7FS3EdSWCp5HL5G8W9YpLfDwfnHoo+WsQqzST
         XXvQqjH5B34hARRmmUVlgmOAGnHeNAyz6moeQF+c5acwBmjs793RxXkFpRydFpmBuVK7
         7S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709476765; x=1710081565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBbfEkG98FnEmlg0aeqk2gdgPye0efTyg1ck9DlRbYM=;
        b=lP3n5UrqpHs/k+NZAdl25HaIiSHxcooXi1xEY1Femc97vd/vOdpqCb/7r3bhc/Q6/j
         yzQRsnc+I7Zyern5RbExtoGc57qzrzxYo08cmrBjDRcUIX3xiP8IC9nyp0c30qpR3gf3
         TtZHYAz//wqs8PybpewIvOmQ2e5eH4t6i0Ogf6Up8a63RQpWLj51jn3mrf6UzUSwihL7
         mXxDbTuc8iIyfldaWTLvEYT/C/U5s81d82DAH70D6KoTEAZfO+KxRX/phlGxF9pTfmo0
         YvoUxS+2CoLW8OoklFZmJ27t30FJVFodCkDeG4pOjtxAO1GAE/V7hyjaH/QQ3WpN+Nw/
         3R/A==
X-Forwarded-Encrypted: i=1; AJvYcCXOJlB3J/efqp6TVxrnFNI1zQmgt77HxsLXJy+1cBXDut5AnVX+psaxj11I88v1Upu/T4UOC550/YlGViO0MIRynPfU3V4RTcR+YFZa
X-Gm-Message-State: AOJu0Ywjm17rhG0mD4Ms06dl6oCnZpYJNwXU2ZndjWmUkC6H0bv8iN6T
	Os0zGpkGlsbIni+QVfxI+pjggkeFDegtN9wTZIjtsv2CWrMXtDCa
X-Google-Smtp-Source: AGHT+IGfEPjP0/ggsvDoyE1PN+WfAbSxjgukfMVNrpqaVVd6NoFvNuz4EkxGB5UkwaibmrA7ZRKqCQ==
X-Received: by 2002:a17:903:1104:b0:1dc:e26f:d8f8 with SMTP id n4-20020a170903110400b001dce26fd8f8mr6872023plh.14.1709476765635;
        Sun, 03 Mar 2024 06:39:25 -0800 (PST)
Received: from kernel.. ([2402:e280:214c:86:98b4:6d91:d5f4:8f27])
        by smtp.gmail.com with ESMTPSA id mq12-20020a170902fd4c00b001dc8f1e06eesm6709746plb.291.2024.03.03.06.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 06:39:25 -0800 (PST)
From: R SUNDAR <prosunofficial@gmail.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>
Subject: [PATCH] Removed inputq,namedq field description to prevent kernel doc warnings.
Date: Sun,  3 Mar 2024 20:09:19 +0530
Message-Id: <20240303143919.6903-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/net/tipc/node.c:150: warning: Excess struct member 'inputq' description in 'tipc_node'
/net/tipc/node.c:150: warning: Excess struct member 'namedq' description in 'tipc_node'

Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---
 net/tipc/node.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 3105abe97bb9..c1e890a82434 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -86,8 +86,6 @@ struct tipc_bclink_entry {
  * @lock: rwlock governing access to structure
  * @net: the applicable net namespace
  * @hash: links to adjacent nodes in unsorted hash chain
- * @inputq: pointer to input queue containing messages for msg event
- * @namedq: pointer to name table input queue with name table messages
  * @active_links: bearer ids of active links, used as index into links[] array
  * @links: array containing references to all links to node
  * @bc_entry: broadcast link entry
-- 
2.34.1


