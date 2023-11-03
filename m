Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99A7DFEB3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 06:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjKCFXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 01:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCFXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 01:23:10 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C91A6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 22:23:04 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1ef4f8d294aso2406734fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 22:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698988984; x=1699593784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMj7q99/zQpRi/Ph4km7kclYNfhbMK5EwX8iajLBhjs=;
        b=bAUjID56fO9YZg+mBsZAiiU3YStfDHCHYHxioY9xdfg8rmtis9hUBAfcG2B3apX7Rj
         VO8Oj7asf/pNF/yRj1u08tZeORzJMKgNwDdaKKR2k9tTtxndlRksrUhBGj8eHSNtXXUJ
         I/W6lI0J1K42RYtYJOnoqjAFDLi252oRkUBe23RvRUGLXrTZYP8oFFhVtezHrlXl3pkt
         /18pVTxp5NHsFMA9XxVj648mS+TAPbwUiB1vz6lW3I4CEh/RK4fd1iGC6bkshFyj7M0C
         KE9DQ41SIfse91QldAwE7RrN6aWbxwjXhytX9rHO6L19pA38X+Svdn8TY0KUna5oojzr
         qSyQ==
X-Gm-Message-State: AOJu0YwIbdoe7W8n2stMHi6lx0fK916JfsLaROnR5uESh7eUgZd49TQ9
        V1lQTk9Y5CDbxVuPs7pG780K3L+os/ixmuHl9OPiNlAT5zx7ZdM=
X-Google-Smtp-Source: AGHT+IEv9MaFsmEKVddmmBFFrUMaCY4EUat+kFq0XIbBNDmOj1yXf0KA0hKr3XuVkZhouayl92vWWHh4Nz+PN5pmqCRxAupT3S04
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5489:b0:1ef:516c:4aba with SMTP id
 f9-20020a056870548900b001ef516c4abamr10047782oan.2.1698988984092; Thu, 02 Nov
 2023 22:23:04 -0700 (PDT)
Date:   Thu, 02 Nov 2023 22:23:04 -0700
In-Reply-To: <20231103051306.721321-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dfd1d2060938b275@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/bluetooth/sco.c:81:62: error: no member named 'hci_conn' in 'struct sco_conn'
net/bluetooth/sco.c:81:26: error: no member named 'hci_conn' in 'sco_conn'
net/bluetooth/sco.c:81:20: error: initializing 'struct sco_conn *' with an expression of incompatible type 'void'
net/bluetooth/sco.c:82:7: error: no member named 'hci_conn' in 'struct sco_conn'


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=1683f76f1b20b826de67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ec2687680000

