Return-Path: <linux-kernel+bounces-34873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EE583889E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7561F26F01
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0F356463;
	Tue, 23 Jan 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="A0D1hSU1"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C456450
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997576; cv=none; b=Ic8wevZGSIo/LJSqyBfB1famQOzEVWrA616eIBOL68NW0R+iy406p1bRxeiTbXaLLHC/edNhwggXjjNZT0lC05uaIaRAYIDX6dl1G0glLEGmKPM6q7Y9HK0a/5Phbjz97TAMSvRVlK2QBQJsSKusDGC8XK8ep/esfOTjxVP1HQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997576; c=relaxed/simple;
	bh=R7RQ/PfRCLCtq5n5pcF6Xl5ipxi0QZFoalAKE+tfwB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jfRBncgW1oqtGBid6iNqxKDJLeTJYDgibTqckrZ/zUVAbx0T0Al+ELIJGFGi+PhnwV5aqF8+EGiBugbYEhIRKC54P3/0lQHVr/2oPDSIrYTxsc5Fp9qW8TvjXz4qNjNm3dqGuJa17AeBUWAQSK7pEDXxfbqhRcUAcOusuSXKNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=A0D1hSU1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d75c97ea6aso10618105ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1705997574; x=1706602374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=inxZJymqVSs5ffJSXOVp5zCbMBHlALxa4MBGgugNy3w=;
        b=A0D1hSU1MCduEjtZVDWLL9LU5Tc15v33sxmMMxOfG2aAERztpLuwKI0Iy+MDB1+p4b
         aWCfZqiQrhJEJBqmt7gLewBHqXT/0irvj3kh+LmCG3th4Ret+ZFYereZTmMtLlk9kxlC
         IoQidMYULLOvEwslwfuDuVGfbuFv3HHM14zvJJNHH3L1anHVMS4fB064re7FPIayZIEC
         EbMsDBvs14Ts7t60gkSidSiDLQm0oXmvgZhYbUsjbcy+zUa+QtISh6ZYhOQh2O+fcEWb
         yE1xUjwb/95BOOwloY+7HvwncB4/0Kyaijltj1WznQB6SiErBdvL5yJ3CwyIxq7zVsax
         VhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705997574; x=1706602374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inxZJymqVSs5ffJSXOVp5zCbMBHlALxa4MBGgugNy3w=;
        b=IRv0ohADEUX8qji59zPbNGvGklGUXMqjufMcLHS+pgsShEWeLz/CblogFhE1+xKSMF
         wCWFBQx71BZzTyDrbDkU3Huv6WlmIsEp4q+b111WplWpIjz3hMocw2JyikkQNWLaWEzm
         /uZTnK7XFr6pxuPxfNVDlhq+8V2D35tZh3/mSe6fgwmVCK8wxahRUuTtOy/7KorDMeCb
         0QDLe3ACW/oeKik9ZhBBTmFENgIX+kVmbItSur+20WQv0a+WcSPy2sA3q1VeHfgCAr9+
         LaUezuinknPJlYJO5ZbcsC7cB10rx3PRVX2h37P1q2Uywsf90tA3K8ua4Zzrda9TUKrg
         u+Qg==
X-Gm-Message-State: AOJu0Yxl2ZK1iKuLa2A10Ja38b7QY+C6s2mg7LWdHk9Yk9209YS1lVKB
	27h9arB8B2tcyeJWEzF9nZ0G4c5D66aAg9AFfYh1EeKn/YrZqBwC45HYL+X57lA=
X-Google-Smtp-Source: AGHT+IFm8k6VzAwvXCSNbOrkx9mrdc5qgT4K4r8v61fd8ma+XY3H46IblYtRR1lMGCX/HBClqr/TBw==
X-Received: by 2002:a17:902:cec4:b0:1d7:7583:6d1c with SMTP id d4-20020a170902cec400b001d775836d1cmr88475plg.16.1705997574253;
        Tue, 23 Jan 2024 00:12:54 -0800 (PST)
Received: from ubuntu-yizhou.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902e04900b001d73f1fbdd9sm3911643plx.154.2024.01.23.00.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:12:53 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chunguang.xu@shopee.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH] blk-throttle: Eliminate redundant checks for data direction
Date: Tue, 23 Jan 2024 16:12:48 +0800
Message-Id: <20240123081248.3752878-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

After calling throtl_peek_queued(), the data direction can be determined so
there is no need to call bio_data_dir() to check the direction again.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-throttle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 16f5766620a4..2ad4f6cd465b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1098,7 +1098,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 	while ((bio = throtl_peek_queued(&sq->queued[READ])) &&
 	       tg_may_dispatch(tg, bio, NULL)) {
 
-		tg_dispatch_one_bio(tg, bio_data_dir(bio));
+		tg_dispatch_one_bio(tg, READ);
 		nr_reads++;
 
 		if (nr_reads >= max_nr_reads)
@@ -1108,7 +1108,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 	while ((bio = throtl_peek_queued(&sq->queued[WRITE])) &&
 	       tg_may_dispatch(tg, bio, NULL)) {
 
-		tg_dispatch_one_bio(tg, bio_data_dir(bio));
+		tg_dispatch_one_bio(tg, WRITE);
 		nr_writes++;
 
 		if (nr_writes >= max_nr_writes)
-- 
2.25.1


