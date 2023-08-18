Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22EE780E87
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377957AbjHRPCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377982AbjHRPCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:02:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06E43C3E;
        Fri, 18 Aug 2023 08:02:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3159d5e409dso1420186f8f.0;
        Fri, 18 Aug 2023 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692370933; x=1692975733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJHlyZzft6x6dnuuBVxn9Ii0k2/HjUEQPD+5O6t3C00=;
        b=ClpemFziK9wgtXZmFtabx4yCanw5kv62zUa2AoBVF/sVwNtcp9/gQX/jMsarS/1bwD
         y0laLAq9Xk3Rr+RTy5yb6zhQrdl4NvuapT/NQaU1xfwnLYuDCw/JwvB7yYmzzoNZzROD
         AOote0PLtBPLe6+uVOL9f8EnS7Rr3EhRpc7dPQPpSwDgX7bzXKhiRvbbM3PQc+YQKFRP
         Rsu2em6iiFsKkt5dViXRb9PsSjDqxwSp21DgqbGBBjG5d/Y29k7nUATUeDhmrCLQh+KZ
         yrwLKvvkwnRW7N1IBKpOSxIcx88oL479Mz3tjhCy1UEkiGKRHLeCqGArmdc6BbZflKbC
         lNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692370933; x=1692975733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJHlyZzft6x6dnuuBVxn9Ii0k2/HjUEQPD+5O6t3C00=;
        b=Mr9mSLz4uQr52tcncFHTezn/wIgOZX3SItuJPkEh/g93equ5yF3WtIha7yDmauVTb4
         0mzb16jL7FziReIJS9ney8+gIH46U9WzXmfW80+kCNcrTPDTmW9/kjLDM7FdHxVBdmXh
         dr8S28u46YIrGO6OoONfkblL0Ef9UA9gzcEoKML61mUrjk2HM9mBeueGa9Fjp83nWnts
         r1Lxj8vIeirRed98ph+BNOyFucrjdqbtIYRYCvVzjpaOvbk9ErzHV8OIKO6cjyTI4Tfs
         Ad2VrpgqGvLyHjKLuxBH6E9ec3HjY+HLpfwj5mIhH9OLBBgBGuuSEXdSvJJs376P0bmF
         j+Ew==
X-Gm-Message-State: AOJu0YzUNSONH1rGOjr+EGUi2fmm9cnG7oDHycwyGqekj7cvEyDW12ip
        6n99CUcCBfic0mLYSdpPFXkvBzVVxLw=
X-Google-Smtp-Source: AGHT+IE+MuOg7mP0WA9aTQK/GskX/8rO9PO2TLBbAuMp98i0Ofh2O1gm7nR4FrZBFoOfi+LH5Dh21g==
X-Received: by 2002:a5d:4b8f:0:b0:317:4bde:9e72 with SMTP id b15-20020a5d4b8f000000b003174bde9e72mr1782210wrt.10.1692370932811;
        Fri, 18 Aug 2023 08:02:12 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y17-20020adfe6d1000000b003176eab8868sm3046181wrm.82.2023.08.18.08.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:02:11 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Christian Brauner <brauner@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] jfs: remove redundant initialization to pointer ip
Date:   Fri, 18 Aug 2023 16:02:10 +0100
Message-Id: <20230818150210.1208746-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer ip is being initialized with a value that is never read, it
is being re-assigned later on. The assignment is redundant and can be
removed.  Cleans up clang scan warning:

fs/jfs/namei.c:886:16: warning: Value stored to 'ip' during its
initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: fix commit message "uninitialized" -> "initialized"

---
 fs/jfs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 029d47065600..57d7a4300210 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -883,7 +883,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
 	struct component_name dname;
 	u32 ssize;		/* source pathname size */
 	struct btstack btstack;
-	struct inode *ip = d_inode(dentry);
+	struct inode *ip;
 	s64 xlen = 0;
 	int bmask = 0, xsize;
 	s64 xaddr;
-- 
2.39.2

