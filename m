Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4484678AEB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjH1LWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjH1LVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:21:31 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69DCB6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:21:29 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-55c7bb27977so3198115a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693221689; x=1693826489;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjX6h88uKTwKEtaplxD5sCOWp5mD42yhu0drLigsBK8=;
        b=FwPQEVurEijhkfOX9GNaADEfAvU7Ps5/kDJa2w88wj4gtsmMKwDq9QracRsbTqglyw
         GmjDW+aJWYpeU6Kp6WzxlZ1aOpBNs1lJ/6o97Sm1XlqAz2mGawWBxLySyY72GJykmBl4
         NGprd1PrsEs7alZ5OeSR1uukjJQjv2D2KX/CNv4lvG09PyqNYUkDrTWUxzmqVw8rKBet
         h+Njpt+cpcrNKclpzhxZd0yS0BDhhXLkFO7r7Op4JNUyYr2NPoSLeiqHm+4An0uuaxX5
         nPapXMocAeGiwG9FubGMdq5fhdrRx2/XB7V2EzSfJcJROS25kGaZmNXKbf4FZ/g5yhC7
         ktqw==
X-Gm-Message-State: AOJu0YyCngxE/RWy4odMjPIX98kgcpkEjO9mI7hNT1g1FVdQt7+P8fBC
        /SUGIj3JoNqUXlX2oerOYUiCHqzquwPp6mXasF+YNSmH2hHk
X-Google-Smtp-Source: AGHT+IHVCJlLhqpnXNj+UpatIqKL+zkANl7mGpDpoDSBcOBx+ierNiCx/I2bdISh2A9Jq5i53/0zsVDKKVIGW7V61/m8BWOFH3Qd
MIME-Version: 1.0
X-Received: by 2002:a63:3f8b:0:b0:563:dddb:2016 with SMTP id
 m133-20020a633f8b000000b00563dddb2016mr4898696pga.5.1693221689317; Mon, 28
 Aug 2023 04:21:29 -0700 (PDT)
Date:   Mon, 28 Aug 2023 04:21:29 -0700
In-Reply-To: <20230828103619.3855-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005160910603f9e56f@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: slab-use-after-free Read in fuse_test_super
From:   syzbot <syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git on commit 28c736b0e92e: failed to run ["git" "fetch" "--force" "--tags" "fc608f7504e8b3e110eb6e7b798cef357818c5e1"]: exit status 1
error: cannot lock ref 'refs/tags/v6.5': 'refs/tags/v6.5/vfs.fixes' exists; cannot create 'refs/tags/v6.5'
From https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next
 ! [new tag]                   v6.5       -> v6.5  (unable to update local ref)
error: some local refs could not be updated; try running
 'git remote prune fc608f7504e8b3e110eb6e7b798cef357818c5e1' to remove any old, conflicting branches



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 28c736b0e92e
kernel config:  https://syzkaller.appspot.com/x/.config?x=20999f779fa96017
dashboard link: https://syzkaller.appspot.com/bug?extid=5b64180f8d9e39d3f061
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13359beba80000

