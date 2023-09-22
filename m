Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600297AB18E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjIVMBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjIVMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:01:35 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8691A2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:01:29 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1dc27f7c838so2747956fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695384088; x=1695988888;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj2QWvmiK+0WWAcmrF4T0yz3RCgK8HWXoA++/rR1IPw=;
        b=PyVqteQDg6+ie7W4oZYQZdvHLx/6URh7Hkbg+ancMzRJ4KqqjgDjPk/m4DhSuzUiBS
         jz98godMujjvcPDljSYfFqImqmPlqla8d8tfEpWW6SXWxYfp8nCxgtX+RlYkkjIQurLh
         XLb8XwP5GIfHdlv4eolG4NiURF5C8ZXRa9K7gro/l/PT1LCT9rVVdZePt3Ln6sqG8YfL
         KZonFQtwPXDiS/wO/7MlBMyx0UYukgP4R6pdW5+QZyZuv1Owj8yoS488pF73HjzDDsP1
         jUy8h5lCdI6gV//+L3/V2DsbMU9LhdKMtoCNkVPeSGBMMkJL1zId2Neqp+qkfVHUclC7
         hRxw==
X-Gm-Message-State: AOJu0YwWFtA3n/HNnxwYhRyM+DreOtQZr4s1Ku3wc0eojk/8RwwvqMC5
        zlvk3uFtyzNzoEh5U0Ys/3sKtqKE/h2AMqVgiXJAvRCIPUDc
X-Google-Smtp-Source: AGHT+IGQtOov5rgUCSHUmJaUiEHw6Xxzi7sjyCjTogbyObjGLfUVrtFsovgvSWXfW6nmE42beN87+I5IFZm0BLhP45xFVBRc0qio
MIME-Version: 1.0
X-Received: by 2002:a05:6870:954d:b0:1d6:41c0:c9bf with SMTP id
 v13-20020a056870954d00b001d641c0c9bfmr3173482oal.5.1695384088583; Fri, 22 Sep
 2023 05:01:28 -0700 (PDT)
Date:   Fri, 22 Sep 2023 05:01:28 -0700
In-Reply-To: <000000000000140b1405fce42c66@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005be6710605f15e50@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_conn_del
From:   syzbot <syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
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

commit 9a8ec9e8ebb5a7c0cfbce2d6b4a6b67b2b78e8f3
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Mar 30 21:15:50 2023 +0000

    Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b66646680000
start commit:   bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b66646680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b66646680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f06d04680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107fdcd0680000

Reported-by: syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com
Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
