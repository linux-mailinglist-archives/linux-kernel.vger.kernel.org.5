Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB4F7E00B0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjKCIRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbjKCIRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:17:11 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17699123
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:17:05 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b2ef9a0756so2761863b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 01:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698999424; x=1699604224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8jWJs9pse49YOaUCpnKuk2Ebmsgs7b6Roydd3icyZs=;
        b=ICBibMkpt3KyF3QzLhecIs2WMWpFDSgHY411f2lbc58JSPB3lJqCdaCfkiApNE7AN1
         gEZ63CVz2mJVu2+hPFQbaXzP9KTy3K07QkCnIv5lt5+WHPPuihSH3q3jYTrO4NZoiLh5
         TaEzzvvhpgRq/AYj7EavaIFVC2JsAxf66RildWT0OA1o44iYZTguYrJdFYzhYm3Lp0G0
         ELTLViXZk8+4Hlb/BbZXtz7jmzJgo5JmRmZWC+Rjh/2dsehA19XYVW4/j3aOFvwdiHnQ
         6exrbnMnCwSzPNsQ0yy8/xq7iLks5XjeSaURofddVnBTTYBHeM/IsNk06ee52eHjIhf/
         sYwQ==
X-Gm-Message-State: AOJu0Yy2aH8LbP5z+MRwGdFXr3DDvyR/PmSr3WC+/pi+vj+1CPN0nbs6
        ECy6Dz8dfj82vCXbqvK9v0sUm9kw50kQA0ZVyPzGZdiMurzcQtw=
X-Google-Smtp-Source: AGHT+IHnvFMmZnDPJcaf0epU9bSYN1QFnzI/om5jalP23QosLGnMUMw9dzQuKQabreblCoA+HtsPeoj0lK9a7d21impIylXxtpLZ
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2006:b0:3b5:7623:e8d4 with SMTP id
 q6-20020a056808200600b003b57623e8d4mr3094977oiw.11.1698999424480; Fri, 03 Nov
 2023 01:17:04 -0700 (PDT)
Date:   Fri, 03 Nov 2023 01:17:04 -0700
In-Reply-To: <20231103080016.3516726-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b7ef006093b2119@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/bluetooth/sco.c:81:26: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct hci_conn, struct hci_conn *) || __builtin_types_compatible_p(struct hci_conn, void)': pointer type mismatch in container_of()


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=1683f76f1b20b826de67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17489af3680000

