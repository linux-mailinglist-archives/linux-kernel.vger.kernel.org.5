Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A89809AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573110AbjLHENJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHENH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:13:07 -0500
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43B91712
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 20:13:13 -0800 (PST)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d88143b45bso2344893a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 20:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702008793; x=1702613593;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d60eezRWfTN7z7k53kCNyN44qWasOR83dFsRUInfg5U=;
        b=NngE9QzGzHroFYkdR8oQXpb/Jm7XRRynHeOSVXGZ2aZjz7R0FaDGBwjKtRbj4CzQAJ
         sfbV8pPFc2BbWBfOrPjpZ0kPKm9dGnNKBrDkKyGIpaIAo/NS3kwNgDOtHUFDE2IKOB3G
         86BHR+003hzxDSZXVAwOnVYwG5Xnw5YW8yc8lhObE8n83SfApjbNqrNURCO1dGN/fDkk
         je1+LeGEPFkdax0sJLdPfQ5WdZmIUv0iFCXY7lqe0w3jjL8P5YD9hWSZDyGvU17abMD8
         W71MNrh6tIouV9Cb1zAsDCdz6FyfExhLqw8UoNV6A5ETE4AEEYRH2xoohQ+xZMYjFMtX
         DBvA==
X-Gm-Message-State: AOJu0YwwNMYTevdsZkJtfQ1egSQF/L0OOu47k2mdXa0huvIAW+leQ9oc
        NpD4Ru7ZDtDN19HtFx2x6Dv05DJ2GsSWmpmvqc5w6WqALHdkmRE=
X-Google-Smtp-Source: AGHT+IFTnhbuLsa7HW4mayM2HTmiYsvnEsUdcCH5Mi5B8iYsixM3RcIszlAoEliogzwGqcAZjSox2yp/35Qmu3ajF9E5apyHSA+0
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4581:b0:6d9:d4d1:1610 with SMTP id
 az1-20020a056830458100b006d9d4d11610mr1708781otb.2.1702008793251; Thu, 07 Dec
 2023 20:13:13 -0800 (PST)
Date:   Thu, 07 Dec 2023 20:13:13 -0800
In-Reply-To: <000000000000bfba3a060bf4ffcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086c592060bf7cd42@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [arm-msm?] [net?] memory leak in radix_tree_insert
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33cc938e65a9

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b..5c2f9d8f2c3e 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -714,8 +714,10 @@ int radix_tree_insert(struct radix_tree_root *root, unsigned long index,
 		return error;
 
 	error = insert_entries(node, slot, item);
-	if (error < 0)
+	if (error < 0) {
+		__radix_tree_delete(root, node, slot);
 		return error;
+	}
 
 	if (node) {
 		unsigned offset = get_slot_offset(node, slot);
