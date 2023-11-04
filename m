Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA37E0D82
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjKDDgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDDgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:36:07 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F2BBF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:36:04 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1ea01dcf2ccso4407559fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 20:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699068964; x=1699673764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4a8kJDXR8Da3W7GAuuVPT/793JcTKW4TgHBmbiBCQWg=;
        b=btAQIJkyJebRRqAO4YRZLfdu70PSx8QhY1q9XKnssKSy8lrHSesvyilS4AOORydrpu
         XFQsu1TSxUEKkN5LpyO/tf8W2RCsWGSbnQOqt6HA74LK3jBTWS3hmh8bs5Qv5j9ZwTkH
         Zd8gNZNCURxYt5ave9RHhEAQReNhKqRfJ7S83EX8KcxF1tOTPexpQy6+OWUI1RVA8oGd
         0R4hQ4isOd+SqohCMndI8MYAOW28oS5y0tFoLNYev/+0ZESMk83DD4LirV0E1JsQo45K
         Cp/VWVvRLDPrUZtirZYpYhRXNTNiGfH3Mg6hzYpqCpv30pllhDwwT6Zp9QnjlccOXvuC
         uj4Q==
X-Gm-Message-State: AOJu0YyEJT8yXPZ7iPhSHxqxDVYGiPuWwF3O6idlXYEQ5SPQMLlm5DRi
        /ibNqlhSQiPU5YHk83SMpR640BdTIelmWWmldoGRlKea9YY2xNo=
X-Google-Smtp-Source: AGHT+IEvWdB/qQK5zGn31Q848Z0GwOmBDgnXYUswi9ptbrC3roSxdsT7t/vwdFO7OYtLKGQR4B/P60M4RegALUh2aHlNfhVNA2kS
MIME-Version: 1.0
X-Received: by 2002:a05:6870:7e12:b0:1dd:69a:665d with SMTP id
 wx18-20020a0568707e1200b001dd069a665dmr1858403oab.3.1699068964203; Fri, 03
 Nov 2023 20:36:04 -0700 (PDT)
Date:   Fri, 03 Nov 2023 20:36:04 -0700
In-Reply-To: <20231104032323.2233372-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f71f106094b52a4@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
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

net/bluetooth/sco.c:81:25: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct hci_conn, struct hci_conn *) || __builtin_types_compatible_p(struct hci_conn, void)': pointer type mismatch in container_of()


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=1683f76f1b20b826de67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14269b87680000

