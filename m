Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719207D093B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376317AbjJTHKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjJTHKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:10:41 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C497F1A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:10:38 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6ce27d056ceso734189a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697785838; x=1698390638;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWL0rNLl5jF/ivasCRcew47fQzuvd0OIJz60/b6FZdY=;
        b=X25xGjOVWnjcmVgQRjAqhLjUvb3lGxZ2F3bQtuTpeXM56j7IA8Qrb0hob7R0OCQLw4
         bM/v+YZtCQ6pwutYyDpCQhFoVX3/U7DDWwGJORiLp3cN7w9NK+3GLSGDE0JDLlXE/0wJ
         FqbJD3SQU6ApNwkEDBEK0ayu3aUaDL1JaBiSlEyF2YnSsivaJHrKDipaXQkjcEWkvxml
         MpnB8qysqJMUBE6qCPRLRhCz2/UamNzXFlbfb6DVpV/PJRKfaJlK+mYLaQNXD36MQxVw
         HmP9TB4G0/8skuK2plhGjeu+ORVxt46rJqPrEC7VLGmO5BGYj68kaYbYpC2LJW2Gi26w
         JCiA==
X-Gm-Message-State: AOJu0YznFcpTjLrYOnKMgjoAfor/eg5l9OWqP6UVDIcPNjICJDL3biuz
        1wVJak0Xb544rblbX4iyIRlpLfl+X2wi3nIU96wmuQ38it7/
X-Google-Smtp-Source: AGHT+IGTxmGob7Dc/DPgC3p4zZRvObLuhFsv4iCL/svsCC2b2UrLxyCog5rpqjctEWdGkRbOPSHHWA/IV8941w7lnpeNC3TMVIqS
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c18c:b0:1e1:3367:1429 with SMTP id
 h12-20020a056870c18c00b001e133671429mr503641oad.10.1697785838117; Fri, 20 Oct
 2023 00:10:38 -0700 (PDT)
Date:   Fri, 20 Oct 2023 00:10:38 -0700
In-Reply-To: <0000000000000c44b0060760bd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c92c0d06082091ee@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING: suspicious RCU usage in gfs2_permission
From:   syzbot <syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, postmaster@duagon.onmicrosoft.com,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 0abd1557e21c617bd13fc18f7725fc6363c05913
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Oct 2 02:33:44 2023 +0000

    gfs2: fix an oops in gfs2_permission

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b21c33680000
start commit:   2dac75696c6d Add linux-next specific files for 20231018
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b21c33680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b21c33680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
dashboard link: https://syzkaller.appspot.com/bug?extid=3e5130844b0c0e2b4948
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c8d09680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a07475680000

Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com
Fixes: 0abd1557e21c ("gfs2: fix an oops in gfs2_permission")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
