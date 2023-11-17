Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843EB7EEA96
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjKQBMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQBMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:12:14 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECC2129
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:12:10 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-280152bfd40so1728657a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700183529; x=1700788329;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30uqgZQc0XyXe80zMkkdDdm5IyNQVi7Wk/CSFaj+t8o=;
        b=HqFpWfM4kQyE/kGg6cddsyfecejKCX+RnDKkoSydomjxzckWoNla12jKfDueMq1VqA
         nxht40z4icpr+IjhuavYdj+X8CyesLwGEtOIt5heek6rZC64yWDx9CIYOY4r1Z9YU9T1
         1T7Rpg12u9ORFwxRx6+U1qVE3NwNc+VoePJJfcdU2KhqCQ9yMldZoqdaxmlVRrH+W1B5
         JEq3OXxAX4nbyEC3lL5mQMCh17xPvzvcW7OTym+0fn0GbC1D/sC1LQ4JIGEvf/f3j1r8
         vweziZomYyNCzdeToRa78675/AEAbvfs5ieU20D4FwRTjcznEBDzjMh9BnBUmKxA71tH
         Psww==
X-Gm-Message-State: AOJu0Yzexp2UeIlcxdtB++HlGoJCC1SoML4MB2yIizbVsDuoqG4wl4H4
        taquHCo9e1DHGbw9QkYuevatxkuSEBB5uT1lO5/zQwsEfA8Hlm4=
X-Google-Smtp-Source: AGHT+IGxTLbGeJHTOs/1uXsKSn9d8lQjqransYgI5MvIbVdX1kOdrxpwWtMJF6kONqSDWn3zRxqLnd4tRuTyW7nzuR7mnLeW+tzH
MIME-Version: 1.0
X-Received: by 2002:a17:90b:1493:b0:280:2f5e:c146 with SMTP id
 js19-20020a17090b149300b002802f5ec146mr4714287pjb.5.1700183529663; Thu, 16
 Nov 2023 17:12:09 -0800 (PST)
Date:   Thu, 16 Nov 2023 17:12:09 -0800
In-Reply-To: <20231117010151.3517036-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056b41c060a4ed37a@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From:   syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/bluetooth/sco.c:418:26: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct sock, struct sock *) || __builtin_types_compatible_p(struct sock, void)': pointer type mismatch in container_of()


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1417b23f680000

