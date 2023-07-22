Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD3575DF55
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGVXia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVXi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:38:28 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8043A10D7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:38:27 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-55e16833517so5570932eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690069107; x=1690673907;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLAUayscsbXaLxBLcuW5V/f0/x5xwSZdUmU/hmWIJ5g=;
        b=QPPie4MnbplyOet8qnJJrhmQH1xm3zXDKj8pJoFgk11ckTOzlEboOjJZuW5PvDTKAW
         2k6MViR2gMeZ4UXR1H+X1NwsbHo3iyQkZaZN6rHESDkGUdE5edVQjarJCGJzrKjam5hD
         wfDj1utD9rVGDLFcrkNSp3cckyRIIBalIvwfwkLuyZVgG7fTc5D0MJXSNnU5sLuZ8+T5
         pxyN4MfK2LBGBTJxnCXAdOhYOwfycLFMLddJOkNxMIDieXgwl8BPJAtx1tHQ4l3W/pWX
         DZxPPSCCAbATGzaK/dEc6+jyDwwwPBjginfFRjMmjNRoFzbpF+kqijMnvxbv0TDqCmA5
         Aoow==
X-Gm-Message-State: ABy/qLYHgITQTQ+LsMQJkNuQnHlS5ski1JPqko0RLUvifj+FBDqBbgcl
        SRfQp1reZ8J91qwxY3vN5J/uCHTU5oJEI+HfVNVKA37Y9ziK
X-Google-Smtp-Source: APBJJlHZG9MQoOcShfLp2ak0B8MvY6lzBUeuOSi0hpp2HypfqltiJZro8mlN7v+lzMnQgs7mhW+5DWQ5rap2MxnjFlea5ZqXTT7O
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1413:b0:3a3:8c81:a86f with SMTP id
 w19-20020a056808141300b003a38c81a86fmr11701666oiv.7.1690069106913; Sat, 22
 Jul 2023 16:38:26 -0700 (PDT)
Date:   Sat, 22 Jul 2023 16:38:26 -0700
In-Reply-To: <20230722231824.905-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3758e06011be0d4@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in drain_vmap_area_work
From:   syzbot <syzbot+fc9127d4bfa8ef129f7d@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-.... } 2688 jiffies s: 3401 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         fdf0eaf1 Linux 6.5-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=173f89baa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=fc9127d4bfa8ef129f7d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e2986ea80000

