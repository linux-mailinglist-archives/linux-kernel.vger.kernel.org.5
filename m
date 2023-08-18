Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B17780522
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 06:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357869AbjHREkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 00:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357863AbjHREjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 00:39:37 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2863AA7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:39:36 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bbb97d27d6so7181495ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692333576; x=1692938376;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvFwXjLMYeqdlXwre0HE3uWwxv+R86ki6i68P3Vs0+0=;
        b=G/5ggaXiG3ltYlp1OVhcwdJSPTT0+4qpshwkjeoMVsCAWYKtdzhi6+mQAl9QCfNQ8k
         JS0wBsmacq9Gu76neS2Pnna3NuX0o1QTaXSDIGYtx/y3HJsGr7630/lkG29r4h7HlGI7
         5Ms4KufvIjUFECLSKAOnnV5QQLYiTxVKXYFKlYB5s1MCU+fJKwYRb357yyPlzOfVsUlW
         HIfIUMvtV0QYLnM9VZxiM0231c5uKVe/xxDGbCm8RY9noHcGePXJRc45eFu2gpoERbBf
         hSUPeNSCovcttOWR8AeY6ruS8dAy04NMKLOKUdVV+oh43ygbzkTvicSIfvXXC7hTqFV6
         cz5w==
X-Gm-Message-State: AOJu0YwLNynzUSvuREbZPQ20vYRmiI1gbJ2O19mfYgHaigwJHXcUSTc9
        OskDNiBfZMhR5BmuyRYtS3ITV4JPpns2V2oPl57e0V2d48wo
X-Google-Smtp-Source: AGHT+IEOWZ9TR7uxnnrr5o2vN1zMwhChrSWkI3uvdoJ384ju6Mbmly2riQQtj6/6k2K4DgTVbAMNubudY8qv1xdOJsYBGe16jePd
MIME-Version: 1.0
X-Received: by 2002:a17:902:da92:b0:1b9:e8e5:b0a4 with SMTP id
 j18-20020a170902da9200b001b9e8e5b0a4mr573998plx.8.1692333576338; Thu, 17 Aug
 2023 21:39:36 -0700 (PDT)
Date:   Thu, 17 Aug 2023 21:39:36 -0700
In-Reply-To: <00000000000013b93805fbbadc50@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8c57a06032b1dd2@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_chan_del
From:   syzbot <syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, lrh2000@pku.edu.cn,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        pav@iki.fi, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 45c37c4e9c9aab5bb1cf5778d8e5ebd9f9ad820a
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Aug 9 23:49:33 2023 +0000

    Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1331e265a80000
start commit:   47762f086974 Add linux-next specific files for 20230817
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10b1e265a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1731e265a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed03cf326b3ef94c
dashboard link: https://syzkaller.appspot.com/bug?extid=cf54c1da6574b6c1b049
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1125bc65a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ce8f03a80000

Reported-by: syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com
Fixes: 45c37c4e9c9a ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
