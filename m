Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D5F7E8F7B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 11:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjKLKbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 05:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLKbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 05:31:07 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30002D61
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 02:31:03 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5bddc607b45so3925666a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 02:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699785063; x=1700389863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRFvCqBk7B1jPYY/iDHRWjt4l8+iwIMoOagmhiaNCsQ=;
        b=nm3fpikC1fQKReI3Vrm8i0iz6cK+IKT6TeqmbgoMB6GkqFYoJ2RtUf3b/Bug1X7CuR
         m0/eZEfW+o3rsdhRol7+rpSVcvj3oN+zx5NgROxRXJbumJaXeDPBN+nhS+z1HxiD8cyY
         C60nnbUIUFWVhDNlRZKQs66AON/w/098/OaHTeI0Tak2/Sxwzu5+6EOnPeiFGyUAr4xo
         S90RHOK9Yy4mrmn0dsgc/FBEswZHDSckeREVYO6+jXjUn7daX6puTuYq60L82WPOFaEY
         BZYlu4GtiF26KWFZW4hsqYRdBmRCqYx7k5Yz5t/U3pQcANV3+kNXoUw5TNSTcLz40ag6
         MO7g==
X-Gm-Message-State: AOJu0YxtJRUQQFzUoKyCRAL+bx3ZrdMC1F5mKK7iQdGDCQ871EqGE5l3
        EPk0BI8zDgnzzUNU7NWWxmelqSoTUPiaf+YK5X/NcwWEuUO2
X-Google-Smtp-Source: AGHT+IFy2JbYwNhqMW6WsLADQMqiPK+ULw/9t6M/zCgorWk9v5AdI2aP7q4R04/lYzy+5ngErsmFP1mITWqFoawHxcVHgZc52nME
MIME-Version: 1.0
X-Received: by 2002:a63:2019:0:b0:5be:1b76:6a87 with SMTP id
 g25-20020a632019000000b005be1b766a87mr987844pgg.12.1699785063354; Sun, 12 Nov
 2023 02:31:03 -0800 (PST)
Date:   Sun, 12 Nov 2023 02:31:03 -0800
In-Reply-To: <441aa0e4-b676-4d0a-a35e-c2f7a912f987@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e55a480609f20c3f@google.com>
Subject: Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From:   syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To:     bragathemanick0908@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/btrfs/ref-verify.c
Hunk #1 FAILED at 791.
patch: **** malformed patch at line 18: @@ -822,6 +824,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,




Tested on:

commit:         1b907d05 Merge tag '6.7-rc-smb3-client-fixes-part2' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
dashboard link: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e11eff680000

