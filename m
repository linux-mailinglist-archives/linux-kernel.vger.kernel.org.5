Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A2D7DFE7C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 04:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKCDyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 23:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCDyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 23:54:10 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEED719F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 20:54:03 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ce27d056ceso1934446a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 20:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698983642; x=1699588442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2AtDMegtX6ePwOYHhlEd52C/cV5WvAnXyuiTbq2Qhc=;
        b=eIPpLpHLGLJ429bxZjteAOyyE5wTw3/a20QlrqcmC5KE5iTO3iavVNQzdvjmVIJ9jx
         FCcsjkrls7UHo8UXdapFD5V10eJZcDJt/OBmRSaiZRIExyZ/3uQFli5eoLiqoo5TXTQr
         7ILLvOrK0sq8MSY5sKTNedQ5x11cFMKttPQlkoQXjWBUGGFLNBfwJRxlogBGdoYELD+F
         WZ5pgFIAERTWukI/e057F6BDB0BGA+5TJcHzViZFlK3ENNwjG3XKdcPgGEWZHnVf4sMo
         Pt9z618eDfHmfWGxG3ywk4nLfeRWQO7q4DfMAeb35TwPIoTerT8hP+tVKDqQUU1tZjUx
         UslQ==
X-Gm-Message-State: AOJu0YxCTam62W87s1vmqn/VWRYd7WSqW7tDoJQATDOgHVffxOqF72nT
        KKzXzBJXR4jM8gjab2y6pG3zI65ZsQCX6kII1T/LPVjTMPmRbwc=
X-Google-Smtp-Source: AGHT+IF91N6/ZJJVBPtM7YcEjJ88C9IuxAWrMz17AowmCoIOy7P2jOjV2EjmfyOBVw7pn0aFA45qF82Ks6ecAVF3bI95FeBUfja5
MIME-Version: 1.0
X-Received: by 2002:a9d:4f03:0:b0:6b9:9bd1:50b8 with SMTP id
 d3-20020a9d4f03000000b006b99bd150b8mr5910911otl.4.1698983642666; Thu, 02 Nov
 2023 20:54:02 -0700 (PDT)
Date:   Thu, 02 Nov 2023 20:54:02 -0700
In-Reply-To: <20231103010143.3182694-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000801ce506093774a4@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/bluetooth/hci_sysfs.c:16:25: error: incomplete definition of type 'struct sco_conn'
net/bluetooth/hci_sysfs.c:16:25: error: offsetof of incomplete type 'struct sco_conn'
net/bluetooth/hci_sysfs.c:16:19: error: initializing 'struct sco_conn *' with an expression of incompatible type 'void'
net/bluetooth/hci_sysfs.c:17:5: error: incomplete definition of type 'struct sco_conn'


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=1683f76f1b20b826de67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103600ef680000

