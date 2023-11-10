Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5037E80FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjKJSUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345010AbjKJSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:23 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06803482F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:47:05 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b7dfda133dso1847614a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699620425; x=1700225225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8dag5tBV7eFqm3uz/w48v/dFE13Fly9qAPNRz4QSK8=;
        b=ZhbvRTvPbHuNYFIvGDtPGEoGM/zYiVJ4QngsbTbN5GI0R8Dbgb8fR6mg1l+rhy0Unj
         pGr7e4UyXuNoPaZVq9CVtElRAOeSySgC+fyMdUXBih8cNDoyJ78d4b5f/JyMNU/CU94f
         U5BclaoueEqd2DXowWD4nlV0CSejZTPSEund2WAxhptNuXVCHy51Ha4p92XmEUDzscFY
         bGhGb1aDAPdDSvS+71BgN4mDumKH6MUHJyhAjgYzjqRj/jbpv7BqIRSbbnCEkQgUe6Jj
         /8TtEqyFj8cXX3LdS2ovkKiPk/Pp1H/ZHpKd6TzG9zcIy1aFl2lDpRvM+RCuCj2fORzf
         9b8w==
X-Gm-Message-State: AOJu0Yz7Dj+4MMhuhMj+N1VuUKwAnFiirDOwiZiH9+1W+x6pPdxrwVag
        z2LqbkK8b93AxSLToNp0qzAx+ZQ9izCkqRIBvU4NaGm9G5uC
X-Google-Smtp-Source: AGHT+IHTy1MTWKHpIMrkFyDaGcaIzkHe5lpVSlvMunjLPrL8sIYeGaXtc5QE2eCkzrtfNPDKolvb3finXrCK8a1B67fYCqxUAFeB
MIME-Version: 1.0
X-Received: by 2002:a17:90a:7e97:b0:280:2609:6d5d with SMTP id
 j23-20020a17090a7e9700b0028026096d5dmr1209024pjl.4.1699620425246; Fri, 10 Nov
 2023 04:47:05 -0800 (PST)
Date:   Fri, 10 Nov 2023 04:47:05 -0800
In-Reply-To: <tencent_EA64176726C1D373637A296B63AB444FD705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3392d0609cbb70a@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/nfc/llcp_commands.c:757:2: error: no member named 'sk_lock' in 'struct nfc_llcp_sock'
net/nfc/llcp_commands.c:788:2: error: no member named 'sk_lock' in 'struct nfc_llcp_sock'


Tested on:

commit:         aea6bf90 Merge tag 'f2fs-for-6.7-rc1' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cddc70e80000

