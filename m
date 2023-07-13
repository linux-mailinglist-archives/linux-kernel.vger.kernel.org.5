Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4479752A04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjGMRtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjGMRtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:49:33 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55318271F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:49:32 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a3a8ceb0e3so1709382b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689270571; x=1691862571;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpXZu9kLoCoL0GAf9Mkv1VSpnIG+XGAoWicN/hHKyA4=;
        b=DbB2RGAQhmukyKuHhsBmztAhrmFmkaykp0UImERlgVb49CzxRAjkCuUGWXYYWk2Mfd
         MSayDkvI1Bl74fhP3iDuNvrLLa2f92YTOLcnRmh2zx2s3Ef1BnOwLitnvLa/WnDAm/Ju
         8J6iZKXedXIxVpKJMgHtV40VZIagffHDKP0YOlMWJJ20FqXFKIKNDvGUMRoj3vN2GcbA
         M70hkyGvWsxqadooZXYSAIgjXUj/4QT6/CKqyCM5+pZ09iuiOxX2DFwX4atnY4Ew1Cdv
         OsO3ShUrRqk3IxZUF10qQ6GSiJUEnubQSdD+BKDnAFD1MJGWI+CejG+2ruZe7nsxaVQ2
         7MgA==
X-Gm-Message-State: ABy/qLbb8jAFsbhgaNZxJLuOadYmG6V1SJIVlfw2Qxr8jgkfbgdmTy3M
        226AQaz95KlJ6gSU8B45X1EYvH1q2bOyZZkHED8kK7bQ5brz
X-Google-Smtp-Source: APBJJlGN9W5XdNXXehBzjUnB4kBTA2iqNXiDhtVJyC/P38CxxXOcAxcnjlKaW1qshLuWFfQkyWklM43sW3RYct+1AdFj3tYAOsQS
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f8b:b0:3a1:edf0:c79f with SMTP id
 o11-20020a0568080f8b00b003a1edf0c79fmr2890448oiw.3.1689270571679; Thu, 13 Jul
 2023 10:49:31 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:49:31 -0700
In-Reply-To: <000000000000c2dccb05d0cee49a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ac8fc060061f4c5@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_free_ack_frame (2)
From:   syzbot <syzbot+ac648b0525be1feba506@syzkaller.appspotmail.com>
To:     casey@schaufler-ca.com, davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, paul@paul-moore.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 1661372c912d1966e21e0cb5463559984df8249b
Author: Paul Moore <paul@paul-moore.com>
Date:   Tue Feb 7 22:06:51 2023 +0000

    lsm: move the program execution hook comments to security/security.c

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1024a074a80000
start commit:   33189f0a94b9 r8169: fix RTL8168H and RTL8107E rx crc error
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15346b1ec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162e3b89c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: lsm: move the program execution hook comments to security/security.c

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
