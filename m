Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C8478F249
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346878AbjHaSHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240921AbjHaSH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:07:28 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA75E5F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:07:26 -0700 (PDT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68a3b41fa66so1202768b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693505245; x=1694110045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njfYBBE85fdBpuB5EzpnYY/diSr1FYw5dCw1nUvq2Vk=;
        b=FVAjuHkUf5c/CrKcH6su2O5GaV0EOa0raghUPEuztEiJnT9ek97sT9emzNGdVwKQtJ
         3qa+Hp6kK2/xKJ49ygstY6i3MIvVdngS4lJu9yMj5WciA029/PtoAXCeszSelxMvlCSC
         1TYaJdR5asKW44U5HlRCrkAQs5jG6qg/ZX4GfDziUYiukKyMdzOtejM517OKdJ07oFdo
         NzbnKlVq/sUBZzg1BKBdt/DCHc4f4NhV9VpVJsOsRlWzMPYqcuoUSrfxq86TxtOwpxZy
         qj9oyHVvYdfxlF8oh12e2R8dTiuADyMnKq1YkV9unzokYgBsEXfPwlVZ4kAsIs/uOf0H
         EEUw==
X-Gm-Message-State: AOJu0Yx+yrg+ZzwoC9vnAG9To01Rgn/XNKNYWCj7/YQo6t6UPPB9c93u
        ooV1yE2mmCBni2oy+FZl5xsxejdvQNxofX9NNkq5XXScQzLX
X-Google-Smtp-Source: AGHT+IH8JEjKbyJOwR1AlsPkocQN5FnvA4GhXUZ7IAxgSPkZ0enwK1JVxfvdTuJyfySOUsuV1deb5dA+CsZkb7VxauvFD9EKxUhZ
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3997:b0:68a:58e1:ebf5 with SMTP id
 fi23-20020a056a00399700b0068a58e1ebf5mr176877pfb.2.1693505245662; Thu, 31 Aug
 2023 11:07:25 -0700 (PDT)
Date:   Thu, 31 Aug 2023 11:07:25 -0700
In-Reply-To: <0000000000005ab984060371583e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097e45506043beaeb@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From:   syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
To:     hdanton@sina.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, pav@iki.fi, syzkaller-bugs@googlegroups.com
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

commit 45c37c4e9c9aab5bb1cf5778d8e5ebd9f9ad820a
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Aug 9 23:49:33 2023 +0000

    Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1042c5ffa80000
start commit:   7271b2a53042 Add linux-next specific files for 20230818
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1242c5ffa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1442c5ffa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13506923a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147569efa80000

Reported-by: syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com
Fixes: 45c37c4e9c9a ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
