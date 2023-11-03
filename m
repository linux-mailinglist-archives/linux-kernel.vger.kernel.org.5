Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBBE7E0041
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbjKCH6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346272AbjKCH6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:58:07 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CA51A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:58:05 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1efa8a172d5so2336084fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 00:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698998284; x=1699603084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNY2A1VRYM730zo4D6FwWs8ZBTWlnuXaE3Em8+3bjI4=;
        b=FEn0F58etA4IJ1fmgyudzFuNtpvefGuvpXYKrDOfTIp4+bfW7NheHUW1zQJt9nXozT
         W7ZMbHi6kK4FPtWMrKOU9htJjT5Q3pGFzEfwDaci70TlTvXlFh9+TJwbkSR+JdFa8FtN
         6W3DHjjyqEYiVUwtlzd2WFAcpHrtUwTu5XM+9l5binX1gLJehGNG+fRxEnGcgz6JHzJg
         oRy3lELcSzvBP2OGpDHoiWaNgocuP2eyPULLWIKx643TQ4Ok4BEoEhx2PIU8/iyOzA4o
         1Cnzm4fnNX8iXxk9mx4xH7DPc24SZ2r/Na03xibnfjiRQL5LblNZorBqvXQL14T3D7LF
         2l/w==
X-Gm-Message-State: AOJu0Ywik2/1fE0FWs8nEp52WtHfkI4DpLgJDtxIfleogfl7UrxPcog7
        wJcAKPk4G8PVDnYAilb+fYrXyuD9D3AEM3zK9KTWJHuE8PEblK4=
X-Google-Smtp-Source: AGHT+IHo2iAxYAMI4yviGBJZy0mJcXTIIbjzeN7lJ8cqC4rf0R+UQlK9CrYcb8ivp7hGt67AXujz+HF089rAbvFF674hr+kZmMJc
MIME-Version: 1.0
X-Received: by 2002:a05:6871:341c:b0:1ef:9f6c:3de0 with SMTP id
 nh28-20020a056871341c00b001ef9f6c3de0mr8442796oac.7.1698998284417; Fri, 03
 Nov 2023 00:58:04 -0700 (PDT)
Date:   Fri, 03 Nov 2023 00:58:04 -0700
In-Reply-To: <00000000000055ef9a0609336580@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003781d906093adda5@google.com>
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
index e71523cbd0de..8d2dba522baf 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -137,6 +137,7 @@ static struct iommufd_object *iommufd_object_remove(struct iommufd_ctx *ictx,
 						    u32 id, bool extra_put)
 {
 	struct iommufd_object *obj;
+	struct iommufd_ioas *ioas;
 	XA_STATE(xas, &ictx->objects, id);
 
 	xa_lock(&ictx->objects);
@@ -159,7 +160,9 @@ static struct iommufd_object *iommufd_object_remove(struct iommufd_ctx *ictx,
 	}
 
 	xas_store(&xas, NULL);
-	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
+	ioas = container_of(obj, struct iommufd_ioas, obj);
+	ioas->obj = NULL;
+	if (ictx->vfio_ioas == ioas)
 		ictx->vfio_ioas = NULL;
 
 out_xa:
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
