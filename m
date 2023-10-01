Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19177B4536
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 06:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjJAE3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 00:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAE32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 00:29:28 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08205C6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 21:29:27 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-57b6b3bde6cso22883877eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 21:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696134564; x=1696739364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3TSr7QqetFYrddy0bCP+Xv3JFmbjCIi8bG/cXjlF+4=;
        b=qSFzFF9ot2rjsW0SkZcxrO7s8ShRD7iHGrzaU4AdWuNGv/ytN2MCasixo+5en+Zhfm
         USqurxHVz9ylPDxyb1ne8eh0HnZkpZZproQ/ncrFB1FQQBKFNNzsIbQlLPixqepO8+Tb
         AgtSe1DMalPK8I/pQeDOxZmQfVCjma36SQWiUZQEJq+/GsNHLUPz5JujwQDaF8k+yypz
         69laoDdjltwvoWHTuuroSHs03TOnkcDKfFFaOQLC8NZisxO5tywUm5HauCnr5QPfnlvw
         AeqvcI7wbBsGuR4xx+BSQYdX2G1TfDi3WpzsoVQKvK48XWJRoE6lhc2RQqeJjM616q05
         Ovkg==
X-Gm-Message-State: AOJu0YxZpP9AbkgobJRGpl50ssmlwpkZclb5Lokqvjpq6Al/pHP7HPwF
        DvU6ZRrXcQmJrIEas7usmsAJlomlyFGw3hQ91gtcpcm+svuf
X-Google-Smtp-Source: AGHT+IHVhUA8ZymBFAk8BsF98zbjMMKYoqJFUsnGiF05e3aw9TS378/23ibGl9PBa+BleockCy9LMW1t7jzGzzjuqIwTTpunrdfZ
MIME-Version: 1.0
X-Received: by 2002:a05:6871:4e84:b0:1e1:2ebc:b636 with SMTP id
 uk4-20020a0568714e8400b001e12ebcb636mr2536327oab.4.1696134563838; Sat, 30 Sep
 2023 21:29:23 -0700 (PDT)
Date:   Sat, 30 Sep 2023 21:29:23 -0700
In-Reply-To: <00000000000035aab005ec690a00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b41f10606a01a89@google.com>
Subject: Re: [syzbot] [serial?] KASAN: use-after-free Read in gsm_cleanup_mux
From:   syzbot <syzbot+893c55305230e719a203@syzkaller.appspotmail.com>
To:     daniel.starke@siemens.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yiyang13@huawei.com,
        zhangqiumiao1@huawei.com
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

syzbot suspects this issue was fixed by commit:

commit 3c4f8333b582487a2d1e02171f1465531cde53e3
Author: Yi Yang <yiyang13@huawei.com>
Date:   Fri Aug 11 03:11:21 2023 +0000

    tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121e6a92680000
start commit:   a4412fdd49dc error-injection: Add prompt for function erro..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc4b2e0a8e8a8366
dashboard link: https://syzkaller.appspot.com/bug?extid=893c55305230e719a203
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b1ca83880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1023c5e3880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
