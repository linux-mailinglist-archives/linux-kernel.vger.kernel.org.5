Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01780759CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGSRmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGSRmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:42:33 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6866B19B4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:42:28 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56768da274aso3082938eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689788547; x=1692380547;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GdSlJQiKv484CM7UIkrDgwXqQQM0s/UqcfPqk1L/74=;
        b=fJqXWZ4dFi2ry85Cbx4C1YmkEAfXMv+ei9Wd8zfnO3mZcca5M7igJOhsD8JsIXi8Nx
         S4O/h41vB1xirHW5D/1MOGr/u5NvrS+KArcIZMVoeWdhKr3W16/RuqOahiP3ZwaRRUNY
         Vy90HGuh1HkC3q54ST5yTGsf/T4GHPLRnX1udsSFMPOf024yZPKOPceEZHNrmcx43Mqd
         inmh6kpMhePQUtKWajp4SH8gcmQLCDqXQ1/UeeWynhA2dfp2kBBQC1SxCkKRMpJKnxlk
         oZ0qB6VJfU8mo2kGZ5N08bULNmlN/CY9dW8E3rGxkZJlKJTfP+erG5t+gST8YDNXD6rm
         xDWA==
X-Gm-Message-State: ABy/qLYFsrYlnvI6UYJiBhAEcTjFCmrn7U01YNe7Mb5qi52xFgp3S2gL
        scWsrz0i8pA7mVf1505OhN14KDxxL9KlR+zfVGxx7NfMd8jn
X-Google-Smtp-Source: APBJJlGc+FLMHZg6mdALKsMlGrkkyQ9/UibmMwawm8SN0wVBXG3jpPAmimRjmmikWRK5g6vvUtlS7JtRmzwo7B46VeTGBSh53ppP
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3013:b0:38d:ca0a:8e18 with SMTP id
 ay19-20020a056808301300b0038dca0a8e18mr28834819oib.2.1689788547816; Wed, 19
 Jul 2023 10:42:27 -0700 (PDT)
Date:   Wed, 19 Jul 2023 10:42:27 -0700
In-Reply-To: <000000000000ada87505fe7cf809@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002361ee0600da8ec5@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_ahash_update
From:   syzbot <syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com>
To:     Jiadong.Zhu@amd.com, alexander.deucher@amd.com,
        davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, jiadong.zhu@amd.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1dbcf770cc2d15baf8a1e8174d6fd014a68b45ca
Author: Jiadong Zhu <Jiadong.Zhu@amd.com>
Date:   Wed May 24 03:42:19 2023 +0000

    drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1622cafaa80000
start commit:   9a94d764e9bc Merge tag 'mlx5-updates-2023-06-16' of git://..
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a7d74e6a7c3211
dashboard link: https://syzkaller.appspot.com/bug?extid=88f4b1e6cf88da11f5cd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1152c4ff280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1307cbcf280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence signaled

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
