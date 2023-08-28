Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BB678A521
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjH1FS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjH1FST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:18:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9BC10D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 22:18:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so1772250b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 22:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693199897; x=1693804697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nVrl0kwRfWIHx+sVHv84+qMtSVVK7pEdsXcZRB61X88=;
        b=j42PvIU0LosJj1YuVMu4dQ+rTM19D0TWC2wtKaBRZahCKd/Ufrb5W8/qo+A+ctpynl
         yJL74iBtB007bdz3buPdzwEMBgqkr5Sk98te2CpfOBcemXDSrXQD7DJG1d1xBLai25Xp
         kIHOOasBM6mLPk5yQD2gNrxcdt/NjDhim5ElPBpo51ETMKYPXectayNFhWXOdjkMGBq4
         EJQgFstw/N8b6OeoiNNiPyMADwJ76Yfugvy4TzGJmHC0tzXvpIqBY7ISKcMFV7umZGcO
         1SppT2QfbbWtwFdrMz/NQATuiWeZjzsesC+yOwNanKcgHnI15y1wzT12uPYypWiBkXzA
         jXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693199897; x=1693804697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVrl0kwRfWIHx+sVHv84+qMtSVVK7pEdsXcZRB61X88=;
        b=WrxotmIZe3sIsxWE43HzledRqbnTvpUdNZJuSE2CuZ1G0QtgDahy4Wjk07qCIAekrD
         65qCgf5NOi50Qo2Pa7S4o1qn7erTC0tca6tFtIpvg9z6MPa0TIo0zW0YPFGC/eX6cw+2
         T1bhYFQPqEfMrEudw/hIxfRIzHPmb6u3Rw8PAk+9Mftbq7+JyPIH5iXTktTMUQxyyM+5
         AOfpVgbVw4pl1XK0s+pHrYQCTje832l6dCVPeSWWAjGA3XeR9gKrJS5GYsWRCfOeB9fx
         yvOSg8Szms6yTIXloqNLVX6agDnHEEEHafkIN+6UVieWUBzMe93qVFhFw2LtsBrVYCPu
         snUQ==
X-Gm-Message-State: AOJu0YzRasR6SEylIbXubuAoMMwIUCe1YynTFq4lOEU4diSKHhR98Sz9
        5ecb51nbrlDQ4LpZrZ1pnfs=
X-Google-Smtp-Source: AGHT+IHJDLh6ZnUudool1Bu9OGIuqJGJVjytyiThv56LlPeCD/a1AenfCnfmYlrLuYKsz8tQpuJGrQ==
X-Received: by 2002:a05:6a20:6d9d:b0:138:5a28:e8cc with SMTP id gl29-20020a056a206d9d00b001385a28e8ccmr21011737pzb.37.1693199896992;
        Sun, 27 Aug 2023 22:18:16 -0700 (PDT)
Received: from vm.. (cm218-252-211-84.hkcable.com.hk. [218.252.211.84])
        by smtp.gmail.com with ESMTPSA id ji18-20020a170903325200b001b8a00d4f7asm6205581plb.9.2023.08.27.22.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 22:18:16 -0700 (PDT)
From:   Yuanheng Zhang <yuanhengzhang1214@gmail.com>
To:     mark@fasheh.com
Cc:     jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yuanheng Zhang <yuanhengzhang1214@gmail.com>
Subject: [PATCH] ocfs2: correct range->len in ocfs2_trim_fs()
Date:   Mon, 28 Aug 2023 13:17:41 +0800
Message-Id: <20230828051741.204577-1-yuanhengzhang1214@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

global bitmap is a cluster allocator,so after we traverse
the global bitmap and finished the fstrim,the trimmed range
should be 'trimmed * clustersize'.otherwise,the trimmed range
printed by 'fstrim -v' is not as expected.

Signed-off-by: Yuanheng Zhang <yuanhengzhang1214@gmail.com>
---
 fs/ocfs2/alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 51c93929a146..bced551240cf 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7642,7 +7642,7 @@ int ocfs2_trim_mainbm(struct super_block *sb, struct fstrim_range *range)
 		goto next_group;
 	}
 out:
-	range->len = trimmed * sb->s_blocksize;
+	range->len = trimmed * osb->s_clustersize;
 	return ret;
 }
 
-- 
2.34.1

