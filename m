Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA5775EECB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjGXJNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjGXJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:13:34 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B40133
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:13:33 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a1ec37ccbbso9520578b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190013; x=1690794813;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/68D1NVpjDgOAkUJuDYSp1QYtQNfm/oepylLJakZ8SU=;
        b=ZhhByYlbYZPJZDbrBHzZvTYRbCdbq7XS+f331mvYjuuteL73JUlS9/Yr4bzsYoBdCh
         Cv6Q8wW085BWKwt5HoVBZdiYBoke9ZRqxpZmvG9+tmM3mp00gRUFYKlORJrgWw679nnk
         93wjTQzfAs3sq7T+cV9GlKiS4xnfgMLDvmL7oUD9/86zq10dM+luI4Nr6uHdTVhm2XrA
         mlZFiLnGVZfZfS0DUe0nvxQiHojGYAFX/l6R1BvNPbAaI2VugEVms9mOZf8mKDqbBEPz
         u0JOlHbZpeBh9w34EgGemn8/RYkuaTly1f5R0CPgo6vrew7MCdbqvnaOeZCo/+FylD3G
         S3qw==
X-Gm-Message-State: ABy/qLaJcF6ioRg3oCe5Fa9SAjfHrryTrOibCUrk1bbjqmhQIdGK+YQc
        rxAQ7TIF/JI6N0ol3222REOJS9Eu8Od9iWraY2sKr046CLnO
X-Google-Smtp-Source: APBJJlHhD8j3WMGPNMRwhpIQ5NfH51cbt05RHMwLUgVKLR4yT+Dh2yKRweGEy5zHCaM+S65ljUXdhQZ5Tp4e5akajof/P+lWkeSd
MIME-Version: 1.0
X-Received: by 2002:a05:6808:ecc:b0:3a4:87eb:da2c with SMTP id
 q12-20020a0568080ecc00b003a487ebda2cmr17689590oiv.0.1690190013150; Mon, 24
 Jul 2023 02:13:33 -0700 (PDT)
Date:   Mon, 24 Jul 2023 02:13:33 -0700
In-Reply-To: <000000000000ee69e80600ec7cc7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000563cff06013807a0@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
From:   syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, hdanton@sina.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com
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

syzbot has bisected this issue to:

commit e420bed025071a623d2720a92bc2245c84757ecb
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Wed Jul 19 14:08:52 2023 +0000

    bpf: Add fd-based tcx multi-prog infra with link support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c60c6aa80000
start commit:   03b123debcbc tcp: tcp_enter_quickack_mode() should be static
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c60c6aa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c60c6aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32e3dcc11fd0d297
dashboard link: https://syzkaller.appspot.com/bug?extid=14736e249bce46091c18
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133f36c6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a8e73aa80000

Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
