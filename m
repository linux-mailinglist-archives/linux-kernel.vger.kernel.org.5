Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2417D7E73A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345249AbjKIVd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjKIVdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:33:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0929F3C39
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 13:33:53 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc3216b2a1so11728275ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 13:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699565632; x=1700170432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/unuH/wgOv+LMXS1Iv/n0xTf2dbEARyI1vRnvxRKBR4=;
        b=Uh6kWNv8F0dT/2DjpzMsfBHJQJq0CwmVL2CR2MCG19wC4fhM/YtuPFsWBGAVZqCS4k
         VuvNw2ymwOMqqfCUuoYLWHEkaiuu3/4mb+3e41wfvvBqRI1aJULzQ+NioFZye9E0Bdq7
         fPoAiRqz+IjBDExo6O3gG6Sq5ukKosTIXc3XthFRIyFwJtV6uNN0vnDTZEkuJPmTznAP
         t2z2yglueCBVwgGRCC/jBDZCd/ZAKyDLGL9IHfOj/mTUvom9pFFn07s0Ynpnx1ftqfmA
         WWqo6oxmV5KI+sAt1wurpiDA4dQ/siQSAGg5SDaEOL6QOVgFEYPteV3MHhSBwq812UNZ
         AbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699565632; x=1700170432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/unuH/wgOv+LMXS1Iv/n0xTf2dbEARyI1vRnvxRKBR4=;
        b=kgki2iq3hnICiOy/C5odyR1BdEM/vpn0ko03CwZ1kxI25aCQs1vKNax7GHTyl35W19
         VDS/ktUk+XMD43Iosppmcbloz1raWxKE5umuo8ANgbpuann/tUMk6aWraf+804LJmhEH
         Woro2xgSx8wZZdGjIFyTj/Yw0Rirr2s8p2E7Yj4m8CBhRDxe7objLZUw8+TNTTUodXrH
         IG/Z7uIhzKYRih0ljQMrAMV+2eBavBc9T4o3nYZ7mviS2nI3h26WtfNBHObYPhDXrgXg
         n/r1MDMCTjtpgvT7eFMEXyjZqJ76V/P1txEmuC7o5IBhotp+Jz2LCD9MiyNBloHNTnv7
         5GrA==
X-Gm-Message-State: AOJu0YzvWUrlTypRpLUKVIb7pUQdxzCygHPLkCglTmgSr8IGDQWoCZgd
        icM50inU49oUg//PiUMfGSctkv9T1Ro=
X-Google-Smtp-Source: AGHT+IE9PYWFnJi2XRz1FID1YWfKCOTF0hvn9ln/YjvaPRVQc+6AbSETDQawoHmp/BfL6AQW5zP/ww==
X-Received: by 2002:a17:902:8e89:b0:1cc:636f:f37c with SMTP id bg9-20020a1709028e8900b001cc636ff37cmr5781479plb.13.1699565632137;
        Thu, 09 Nov 2023 13:33:52 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:f97c:cf47:191e:4442])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001cc46240491sm3977722plg.136.2023.11.09.13.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:33:51 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: initialize user cache valid values
Date:   Thu,  9 Nov 2023 13:33:48 -0800
Message-ID: <20231109213348.675704-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Need to initialize user cache valid values to prevent from providing
false cache entries.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 lib/libf2fs_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index 39d3777..d76da83 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -165,7 +165,7 @@ static int dcache_alloc_all(long n)
 		|| (dcache_lastused = (uint64_t *)
 				malloc(sizeof(uint64_t) * n)) == NULL
 		|| (dcache_buf = (char *) malloc (F2FS_BLKSIZE * n)) == NULL
-		|| (dcache_valid = (bool *) malloc(sizeof(bool) * n)) == NULL)
+		|| (dcache_valid = (bool *) calloc(sizeof(bool) * n, 1)) == NULL)
 	{
 		dcache_release();
 		return -1;
-- 
2.42.0.869.gea05f2083d-goog

