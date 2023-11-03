Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E678E7DFEE2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 06:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjKCFgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 01:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCFgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 01:36:48 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B95E1A8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 22:36:45 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3f893e38aso2635207b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 22:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698989805; x=1699594605;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IM9r8e2t9fpbX1pA7PHlr1BRlc751tV7qPYdSxcvpwM=;
        b=iJbSucQvD5k5EbLY4AS/8gPXeZ5GWysBfX2/Ku+CJxHHs/U2CtYDg4SZe2FnLGfsmh
         1qHT+NIFuDN7QbcGLfbLSgDfuA00uY8pRhHkU4+c1R6lNPAaAYvexR+CGduMMyg5NbBe
         +8X4cwy150nNFNc8RttoSbXRImTJHJDgLkoHlksaUQQXAVgrO8xMDxq4rfoLVoqCJsOq
         00xTufT9td4k8VrKXtKASs3rIXLGbCFJPOPdkexlUUVALSj3S+g+f+49D7OeIxc1Kbeu
         gNNoT1rDEaj0/n2+W8+oQrRV9Ky47Ke1Ho++po9GXnahwdeS+QIugTyGRIMVaNwCVMk5
         hR3w==
X-Gm-Message-State: AOJu0YxhB04Y7/ZyCNR/DuUZH8pW65Q7XmyW70aV4kM1pSDtX/yiSR9R
        fmAmfXdP4P7B8sAgvSWHKQM6L8d/mPMPqSyHbXLicRMLwsce5KI=
X-Google-Smtp-Source: AGHT+IHnRL2BzNm9GrnGLjArzfQANTUttyoRQZnh3ILMOkOc2Ua/AP/j7fLzI4MSD5QrX/l6Haa13KXscmZ6jghyzc/c9HqKtIZn
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3a92:b0:3af:6406:ade7 with SMTP id
 fb18-20020a0568083a9200b003af6406ade7mr6460374oib.0.1698989805015; Thu, 02
 Nov 2023 22:36:45 -0700 (PDT)
Date:   Thu, 02 Nov 2023 22:36:44 -0700
In-Reply-To: <00000000000055ef9a0609336580@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce1903060938e365@google.com>
Subject: Re: [syzbot] test uaf in iommufd_vfio_ioas
From:   syzbot <syzbot+d31adfb277377ef8fcba@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
index e71523cbd0de..e89c90784536 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -159,7 +159,8 @@ static struct iommufd_object *iommufd_object_remove(struct iommufd_ctx *ictx,
 	}
 
 	xas_store(&xas, NULL);
-	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
+	__xa_erase(&ictx->objects, obj->id);
+	if (ictx->vfio_ioas && &ictx->vfio_ioas->obj == obj)
 		ictx->vfio_ioas = NULL;
 
 out_xa:
