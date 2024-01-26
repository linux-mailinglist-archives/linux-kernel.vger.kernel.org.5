Return-Path: <linux-kernel+bounces-40770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E737883E57E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179AD1C238B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08FA58AB5;
	Fri, 26 Jan 2024 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="SChfYy17"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FF5576F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308308; cv=none; b=BJrqIE40dZnwzj1SQzqcAWYYrwspaaLT2HNVTc7VIirTfg9b8eWGMcleQJ6/y2wCMEsMjvEWVpLElYFyEKDDOhjtJ61qNZ0tslbXtXvC4BOhtg+THpOPvamhangJ5L3puhn2kAv9MWfxmthPTr+2R74KnCMQB3NLuRNPBVK+spU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308308; c=relaxed/simple;
	bh=uGu0MY687mPL6FpCpdkunrktIKNKvA2DEumpUUqsAt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NWSfbOx5bh8998IE26Se4REI6w9M6rvpLT0f75FWLf0B+7CTH77lRmYj8sOtnsdC2UIsCib6KEQq5nA1o2/R58OoME/SzGchdA/MJO+A4Wh1PjF9iVWt2+vYG2f0u0gxve8+7IZsuZCdxcvNDyd3dO3qHKHrxut9bbITvfbfYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=SChfYy17; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d71c844811so6438275ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308306; x=1706913106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fiiHp/wjzY731Er1W9bbmepeXORaTQMQZdYafThTAc=;
        b=SChfYy17k2UrFusK+9eTRhX6gOi8mtOJudqTreTmzLnQhVl8jKcKFKPEGVj3BLNt4i
         m8tKyvQXqMMXuJgmWLQoPzMOzcYdVmURtLgEGOwB8+8CmOvI8gdn6A6h5HKz5qmBSiAg
         atcDwpGKBm3fawVIut9wxq9BtZmEwO3UcLnhVOe0zf+dinivBBlBMfOgrNlWpRMuLkpd
         N/zwR06CLj0Y98KRDLTGbz1XIjCqkGgEqpYUpztnTLcI3xXrvnM7n11lmuEXACiuq/jY
         WMyGjbjLcrBo2G+tzPB8nqJk9dMFhX+jRFijIUV5QIfAHbNWm/KTnTMozUdj3rYd6VHL
         F7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308306; x=1706913106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fiiHp/wjzY731Er1W9bbmepeXORaTQMQZdYafThTAc=;
        b=V/SuwvHT2EyCKg764I81jERYrfFtbs95aprx87RbifI6q5Rk358BnckbkRi5oNppLv
         9ceYj6+iEEt62bUW6irowCm/xPote4M6mT9CwdYQqYhZANtslg4JxZlz0K107dq5hZ2+
         3TUHxqUsNmIG+dEyDSySY4ACAnjtufItpreEXoJqC+xfs796EwefwrCiL+MpLqR4ikVH
         fLnvZL7O6nICT7r3mPDK48CV9Bdi0VzySWQv26CqnAc85RaM65pdrxMWhUMIr82axepk
         jF0d5fvUbDEBddpoouopErv+ZGefksaeeVabHw5EnWi3mLQ5UjGCpwKeWu/Dm60fKAhv
         COcw==
X-Gm-Message-State: AOJu0YxXJSk99OQD31lrI57edQxKQJT0TpFP7XIaWqa2Ke9WO71+61AT
	jaugdR6PqxRSMx4N7PvAUUXeeVBfKASfJkbcW+EnQblXy6qn0ct7CMWLSD9X7MM=
X-Google-Smtp-Source: AGHT+IFUjv/9MEDcJiw11ddzJUuUL5TjW+5fivqENBdwZhc682giM6qE5BG+rfA7CYmJvpE9n37vLg==
X-Received: by 2002:a17:902:d4cb:b0:1d7:6f5b:e674 with SMTP id o11-20020a170902d4cb00b001d76f5be674mr654018plg.23.1706308306358;
        Fri, 26 Jan 2024 14:31:46 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:46 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 11/18] Staging: rtl8192e: Fix paren alignment for rtllib_disable_net_monitor_mode()
Date: Fri, 26 Jan 2024 14:30:59 -0800
Message-Id: <20240126223106.986093-12-tdavies@darkphysics.net>
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

Join 2 lines to fix Warning: Alignment should match open parenthesis

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No Changes.
 drivers/staging/rtl8192e/rtllib_softmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 60598b41fb9f..538689fb5580 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -361,8 +361,7 @@ void rtllib_enable_net_monitor_mode(struct net_device *dev,
 /* Disables network monitor mode. Only packets destinated to
  * us will be received.
  */
-void rtllib_disable_net_monitor_mode(struct net_device *dev,
-		bool init_state)
+void rtllib_disable_net_monitor_mode(struct net_device *dev, bool init_state)
 {
 	struct rtllib_device *ieee = netdev_priv_rsl(dev);
 
-- 
2.39.2


