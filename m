Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4267DFDB4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377633AbjKCBSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKCBSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:18:10 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED22134
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:18:08 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b3f4ab1238so2132817b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 18:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698974287; x=1699579087;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Syo/xZNxlT3+iBmwN/KDrUvAObkr3bn44b7dU+FqZfA=;
        b=iKFEfJ0GkHn86hYMGLhCgEfiP8JpKiI11c29pPHoGz20EG8Xerfn9RTcZwZTF8vFPr
         ELSMjCcz7wD+eRNTQN5pfJgPcboX2fQvdLhC84IyQs9YXLD2dkJwjMiLTKEUtgtoSP3D
         pxxvUW6CIYBNhoY2r2pQJooKzyAvVpO2YcdP342nUPjusRuY7uaNfVO1yylbhTfinsgu
         D1Pmw+IB72DglFj9N3+zuhTK6JCz2Cjlwn7traXol9zNhdnga+pPmlQtSXdWqGO9zByX
         9MOxG2Gj2Fa7YGXNOQL0o6qvgyobK8bUOfQ/xJF2rEo81ppcOsmMZfBX7Js5aIpPXYMt
         aQJA==
X-Gm-Message-State: AOJu0Ywzk+kQOk5CjXEnPVYhT7MRCQMVihJUbWhn09cq7CaYX+39/W4x
        aYobAsL2Etirpn4yQcLfVjPiU6fXZpp7qsj4uhVhsV2eIo65IJ4=
X-Google-Smtp-Source: AGHT+IG0dJz0e1N4gfGHyYYJwcU1GJ46CX31TqLEKsyD/WOIHdmFYxjGFOomFvY15Hf3gi9BmyqzpvPiy1C1DPBszxxhhyNq4/yx
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3083:b0:3ad:aeed:7eeb with SMTP id
 bl3-20020a056808308300b003adaeed7eebmr7745270oib.6.1698974287646; Thu, 02 Nov
 2023 18:18:07 -0700 (PDT)
Date:   Thu, 02 Nov 2023 18:18:07 -0700
In-Reply-To: <00000000000055ef9a0609336580@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5d6a906093546db@google.com>
Subject: Re: [syzbot] test uaf in iommufd_vfio_ioas
From:   syzbot <syzbot+d31adfb277377ef8fcba@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
index 6c810bf80f99..85cff4489757 100644
--- a/drivers/iommu/iommufd/vfio_compat.c
+++ b/drivers/iommu/iommufd/vfio_compat.c
@@ -138,6 +138,8 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd)
 
 	case IOMMU_VFIO_IOAS_SET:
 		ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
+		if (!ioas)
+			return -EINVAL;
 		if (IS_ERR(ioas))
 			return PTR_ERR(ioas);
 		xa_lock(&ucmd->ictx->objects);
