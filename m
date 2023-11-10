Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F5E7E7E57
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344314AbjKJRn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345846AbjKJRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:43:32 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5286FAA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:26:25 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc2efd22ccso18388835ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597584; x=1700202384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgSytoNaHHoIE+4ch2mUm+dKOUa7e/jJylB9GJo3kAA=;
        b=vddYGTFAwQ9kZo1hRJv02Oev4Lefz1yn1Y+oqM/AMQTCBNbJNj6y9l1t5Lz30/Pw0q
         SePlslibrOfpsSK1uAHFk16ek76sCwO2Zwrdhy1bHHj6BTK/95l7l41gPsLLMvjr5cpo
         rz28Nf68/rnHa17MvJiDKf+nAzmVJ3y34qbE8d46gjkPLn3eA6VdyLxW3D37QDxaVb8k
         cNp/sCi0e9MrlmSxxi6LDAD9bi6qpMkDTeEt4ZhTNdehwsV507mZCQe0+dMTOWxDVdTd
         2Bf+IItq/EKBKUG9R55lwx7YjH07rHL7bzlrccwG6bKLPviuSjMTvs42TwZHIHO7vbsm
         /wGA==
X-Gm-Message-State: AOJu0YykTIiVNG4vbyMrr7DTfN/8muNt8c95Gvgm3cLBRAeLR8r/8OgL
        IbMY6ZZLE16iojKzj/qScY9H/9NH3uc+llNYrNgwutwtyGT7JmE=
X-Google-Smtp-Source: AGHT+IFQ4bXo+EnnDWLt8FALbzvBvNI1Fq6w7AeVV5p+80x+XwCcgwwWEmV5rIw/rdUjfS4kRN0Kr1kapzQLMLc1s/YnKDfYVNPp
MIME-Version: 1.0
X-Received: by 2002:a17:903:2387:b0:1cc:3c52:1b0e with SMTP id
 v7-20020a170903238700b001cc3c521b0emr949983plh.1.1699597584523; Thu, 09 Nov
 2023 22:26:24 -0800 (PST)
Date:   Thu, 09 Nov 2023 22:26:24 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004968590609c6662f@google.com>
Subject: Re: [syzbot] [PATCH] test 305230142ae0
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
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

Subject: [PATCH] test 305230142ae0
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 305230142ae0

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 752acff2c734..bae6c54e4f87 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3806,6 +3806,10 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 	}
 
 	if (sa->create) {
+		if (sa->qgroupid == BTRFS_FIRST_FREE_OBJECTID) {
+			ret = -EINVAL;
+			goto out;
+		}
 		ret = btrfs_create_qgroup(trans, sa->qgroupid);
 	} else {
 		ret = btrfs_remove_qgroup(trans, sa->qgroupid);
