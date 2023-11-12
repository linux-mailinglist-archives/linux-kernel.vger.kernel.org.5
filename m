Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039517E8E71
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 06:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjKLFQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 00:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKLFQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 00:16:15 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945FD30C5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 21:16:12 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc2786a8ebso40379675ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 21:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699766172; x=1700370972;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTPsyMvNtksR7PlV+DcWBhy/e3E2ORzQOQ0CIR35fhU=;
        b=aUTyvkcHS4Uxo1IyBzd7sOPy0YJX8ZQqBm0wSkvFRG7A54pgRO2peoOf8ht6SyIlir
         SZqR7nmbXNBBZBAYQIBZlMG3YSxpKlNYTy8mZuVRwn2iQdyFJ259tRDUB4EesAIQh+YL
         xG4C5tZOaQ5feuSTrNO7VB2Fgz+2BYH0uVsZlcYSHCJd4h5k8PwX1DbIhtnSEtrhoOKy
         02SHDF2H21hCS+TSaECRRBZc73VW/e1puIx63CVWwyMOnIeCImz3ScWOGPcyyhh1Qowo
         c9jtU5CD5KcDKJgAzvHBxMtzqJFaq7sEE3fDgmGdaxE1MgkfiRTq8l9Qv7EUk2exikrA
         Puuw==
X-Gm-Message-State: AOJu0Yx6rXHQxcr3sSXfmuDezjo8THVaKrOx6Reby2mp8kaQlwRAsBdq
        ihS6z1aFzO/W07NZXzQ8/J3nPQL/EYAd/qoT6yasKwIFzI6V7I4=
X-Google-Smtp-Source: AGHT+IFMiTNAf17Pa4tFynwIqLUuwcQSfFhALSuuh5nCrhWU4lMyKhnAGUSIw0cBsvMt2/tVKb8nHSiOUnevgVLPGVDrxzHsVWSK
MIME-Version: 1.0
X-Received: by 2002:a17:902:ef81:b0:1ce:1829:2df8 with SMTP id
 iz1-20020a170902ef8100b001ce18292df8mr661038plb.12.1699766172211; Sat, 11 Nov
 2023 21:16:12 -0800 (PST)
Date:   Sat, 11 Nov 2023 21:16:12 -0800
In-Reply-To: <0000000000003c31650609ecd824@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e560eb0609eda6e5@google.com>
Subject: Re: [syzbot] [PATCH] Test memory leak in ovl_parse_param
From:   syzbot <syzbot+26eedf3631650972f17c@syzkaller.appspotmail.com>
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

Subject: [PATCH] Test memory leak in ovl_parse_param
Author: eadavis@qq.com

please test memory leak in ovl_parse_param

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 13d88ac54ddd

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index ddab9ea267d1..735ae0db404a 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -530,6 +530,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	return 0;
 
 out_put:
+	ctr->nr = nr;
 	ovl_reset_lowerdirs(ctx);
 
 out_err:

