Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F797A36DC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjIQROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbjIQROC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:14:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20A0129
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:13:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-404732a0700so37224915e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694970836; x=1695575636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/90lvMgaQ9dQMDxed/RCqRjWf2cwODbqPb3DFBPgUo=;
        b=JY6FTWtOdol/2Tfy22vN+QkBgbOl/yPNgnVIEZSb6WnU7sL+D5DKCDUZ99nQX4rU/7
         UmwETJQrzAAKkButjyPypwWkMy31ZYezjTy2JuPTtxCxk05dx03zv8dXjxip4JaZ2FJ2
         iNWhidG1YJ6o1JFIbebtw26BQjKo5pZGBfQ88hmt7JvX9K+0KxwvPI7e9IfUBoWwY9Mv
         nArHV2LKIRJW3ymKn6Nf9I7XVWB+ZTT87RltfVGSzGy4deaNDsB1HkPht0s2Eb9qukZj
         TGVPKoJ7zEjjwGrp1VlOI8o9g7DY1POoYXbIL3mBOIREQbb/ZGXNS6XzNXBKmprKoWBQ
         MosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694970836; x=1695575636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/90lvMgaQ9dQMDxed/RCqRjWf2cwODbqPb3DFBPgUo=;
        b=NLEpykr+RuKJrKE557xwaSHJFPsu+uL4rcR49rV5VVjCnwlWEypAAfKbNVzqxxB0qN
         zfMOHfh5Tjdy2NIAADbagrL6GFkGIFxMsL6/wpCe5P7UioQbgvTmWzOv3gHph8MajkSv
         TuD/qcQNM1KTn+3ogeIUeNmp+3UPkeCPKZa+8rELEKoM54+1D2iT2xNOdCeRtOVZYLch
         a+pQwWs+qFeImhBaBjsIMDnTwjsV+a5W7U1PZMVup3J+uM79rdqSK0M1Fu4Fv/dlHcIw
         tGTCbNCzxQJdkLm82eJabWt7aRc+Fa6Yfv4+Aw/t49ngclXIbXiBZ8P3TFJRlspq3evK
         Anog==
X-Gm-Message-State: AOJu0YzSTaEUP4Hhw05kLAjXUDSsVO0VQRxWjBQ+FMKfsN6YiUW//U8V
        YTNqiHqJs/dcvJZfhASAetE=
X-Google-Smtp-Source: AGHT+IEXKLeFyhOSzY6ixguAgEAV8p01yXtDxmjZQ2/2D3kBmOWQONT/sP/jsKYqcou6KDXAeyDESw==
X-Received: by 2002:a7b:cc9a:0:b0:404:2dbb:8943 with SMTP id p26-20020a7bcc9a000000b004042dbb8943mr6519294wma.2.1694970835618;
        Sun, 17 Sep 2023 10:13:55 -0700 (PDT)
Received: from localhost.localdomain ([197.41.90.59])
        by smtp.gmail.com with ESMTPSA id k7-20020adfe3c7000000b0031f8a59dbeasm10101155wrm.62.2023.09.17.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 10:13:55 -0700 (PDT)
From:   mohammed0x00 <mmansour.mm5@gmail.com>
Cc:     mohammed0x00 <mmansour.mm5@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipc: Using unlikely macro is more efficient.
Date:   Sun, 17 Sep 2023 20:12:41 +0300
Message-Id: <20230917171243.72770-1-mmansour.mm5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mohammed Mansour <mmansour.mm5@gmail.com>
---
 ipc/shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 576a543b7..8ce67ae16 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -734,7 +734,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 
 	shp->shm_perm.security = NULL;
 	error = security_shm_alloc(&shp->shm_perm);
-	if (error) {
+	if (unlikely(error)) {
 		kfree(shp);
 		return error;
 	}
-- 
2.34.1

