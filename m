Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F237CC81C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344250AbjJQPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbjJQPxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:53:30 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE68FF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:53:28 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3af5b5d80d9so8109135b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558008; x=1698162808;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glgWAgU33VhWGbtDvWHGXM3wQUf1xbAKLK5Z5jNf9z4=;
        b=PE93YKBRrdkDwAGaWiGuAYxFU77NVDZST6M2CZCJOFjll6y7UfCcNGF79Nh6LvWnGl
         AoskDBZbSPgeHykeq9ztoSOHp7sW8vTZce3kTXB5THZyIgwVOPSCE699rmuSoIwjsESH
         1wqP/CFb8Z+TAZhCJGkFzv3q1Fq53EtjZNoo9NC1y16U8+5t3s4W4Fj9M9TVw3XOraAj
         EM2pybzceZFQJlY7ZM6466FwVgTOubnHKHRbcoyOAzQW+XITA3UWXEB4AJZCRXjKn1xc
         48t6Huxm0e1EHVYqXWz19zc4JAkUVu7kx/CKVDGtdB9QxQbavHji5cP3onvkUNriZQi1
         iXjg==
X-Gm-Message-State: AOJu0Yz9d1Hbnx0pwqFtqw9LBSwIMa51lI3jm/BWyCzIqIJ9B/vZ8RFj
        0Qb/SDisnAPWfKHwTfSEu3enaHYdXNMVVpDxRxRpY5neRLKJ
X-Google-Smtp-Source: AGHT+IGeuJLVrsgt56YafCFpH2qgc4dYgKqr09SCyCd5ownpBhCHDfIpV676pQMRk9YC2tmwGce/Hdxkgo316TyWuGPD3oAZLjJr
MIME-Version: 1.0
X-Received: by 2002:a05:6808:181a:b0:3ad:eae0:3317 with SMTP id
 bh26-20020a056808181a00b003adeae03317mr1080336oib.5.1697558008047; Tue, 17
 Oct 2023 08:53:28 -0700 (PDT)
Date:   Tue, 17 Oct 2023 08:53:28 -0700
In-Reply-To: <0000000000002683d00604c6bafe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e34f70607eb86f5@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in hci_register_dev
From:   syzbot <syzbot+410a8e33c6a740b40d51@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        ricardo@marliere.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit fd6f7ad2fd4d53fa14f4fd190f9b05d043973892
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Aug 28 14:58:24 2023 +0000

    driver core: return an error when dev_set_name() hasn't happened

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17925039680000
start commit:   92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd57a1ac08277b0
dashboard link: https://syzkaller.appspot.com/bug?extid=410a8e33c6a740b40d51
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14df7104680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125a5357a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: driver core: return an error when dev_set_name() hasn't happened

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
