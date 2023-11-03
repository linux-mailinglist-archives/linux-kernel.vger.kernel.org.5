Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62167E00B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjKCHJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjKCHJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:09:45 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96388186
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:09:43 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e9adea7952so2023445fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 00:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698995383; x=1699600183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjSjm833K8pQ/tBVNwZvawYgMwdzkZ3/+2zagrqEt2c=;
        b=Tmn7hYvd5dPW7/5I+jmwHA6kyKnAmhhBu/WzWPaD1XnADLuUfZIMQpwKHkqQ3I/9jO
         udDlxXdvL+g8VcO0Amd3FYZlU4OTPk7YEGZHU1b+kpxz/ANxyLMu3cm2BXQmTQRddCrg
         Tkny2PNcgSc3aRT4/ZBqYe2IaD42XFae8kMlDGMKGfu2N6GEAUjTfkGEHeY+WKujYSlT
         NV/UpPTi6dTSnc6GJHkLiqVY61Av55fOZnAOtda4BmhrvFwKSwWDSUZ4PzAtBLTo0ST9
         uEhDN52qFIX6rkK/XLKv583I9ueLesPBQYNQwEd3Yt48Vv82u9JuacCKowBJQwOjA73Q
         L2pw==
X-Gm-Message-State: AOJu0YwG6WZ4jclKhz8ufvbyxQ+vcNpP1P1SvDqHa/Uj6Y+P3z7X5ODT
        GuSBEbHzYub1E/OMKv160mlFC53qbkTsRWoTHNXjZW03uGyVlII=
X-Google-Smtp-Source: AGHT+IGITsWWYwN8y+p4wAGwxHFgbBLcXVaniHllPxytRRBI4kAq5aLKD5Z00wQkqMWBxjD/BdgpkuppJ1pgFAv3P9esXRk622Ry
MIME-Version: 1.0
X-Received: by 2002:a05:6870:63a1:b0:1ef:b9bc:e2cf with SMTP id
 t33-20020a05687063a100b001efb9bce2cfmr8287236oap.5.1698995382841; Fri, 03 Nov
 2023 00:09:42 -0700 (PDT)
Date:   Fri, 03 Nov 2023 00:09:42 -0700
In-Reply-To: <00000000000055ef9a0609336580@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044f99c06093a30cc@google.com>
Subject: Re: [syzbot] test uaf in iommufd_vfio_ioas
From:   syzbot <syzbot+d31adfb277377ef8fcba@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: test uaf in iommufd_vfio_ioas
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2af9b20dbb39

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index e71523cbd0de..6b75f9fab6ce 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -208,11 +208,14 @@ static int iommufd_destroy(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_destroy *cmd = ucmd->cmd;
 	struct iommufd_object *obj;
+	struct iommufd_ioas *ioas;
 
 	obj = iommufd_object_remove(ucmd->ictx, cmd->id, false);
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
 	iommufd_object_ops[obj->type].destroy(obj);
+	ioas = container_of(obj, struct iommufd_ioas, obj);
+	ioas->obj = NULL;
 	kfree(obj);
 	return 0;
 }
diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
index 6c810bf80f99..06317d0bd95e 100644
--- a/drivers/iommu/iommufd/vfio_compat.c
+++ b/drivers/iommu/iommufd/vfio_compat.c
@@ -140,6 +140,8 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd)
 		ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
 		if (IS_ERR(ioas))
 			return PTR_ERR(ioas);
+		if (!ioas->obj)
+			return -EINVAL;
 		xa_lock(&ucmd->ictx->objects);
 		ucmd->ictx->vfio_ioas = ioas;
 		xa_unlock(&ucmd->ictx->objects);
