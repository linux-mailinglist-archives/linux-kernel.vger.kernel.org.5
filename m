Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AA67AF89C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjI0DZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjI0DXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:23:50 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239055277
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 19:49:27 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3ae2a37595dso21453123b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 19:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695782966; x=1696387766;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eni7pjGsCnR02TmbIEYy5GXxjpcD0RnfDvpYlq3rhaM=;
        b=PgZAx5iLQNk6yQS6/H4wzpgT/dhUOaR7DkuSHWHRb3JjK0UFym9zEwZCDiRMSbA5ii
         BCxX37yc65XltLrl4MxOJ1oGTpBjD8N+7OYYfJdVAWF/sVVuzTHMK9KuHAaKMjp4JBaK
         6DY/cU9fDR6yEAY3Qj5LOrgqZGtY85Q1rkZvzW8l5sHuIkOkVman/Q1ZtXrmWhe4gp4l
         u7/L4IWJ0iR3wLXGti2TqxIQ4uRhOvx9+KKFr6hTKj5tiQUA0fXi2ESfli4nTFgc+udq
         PzV1DuNXI0sZyje0JLfh8nQf38x+NiUZyrSAeSnBeu/vh14M6x/vDnSZ8JpTPjcTNV67
         sHlw==
X-Gm-Message-State: AOJu0YwGYWzevafzUDQpLcRV79ff/bleHlv8ZeMvkwFR4PfHy32Cvxmx
        HKLmJEuWKQZNHf5TWOUarvAPJ8sgF7Rbd2duXuCZuFthjtL7
X-Google-Smtp-Source: AGHT+IFdbdFxnvYAoAwEmTvSKD9vV+LpoXdQyVZwGa9sq+8SBaVDHo7TFv5DlnRNou+NS6gE4mptqHru3h/s2UnlArnbPjr31pdR
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b11:b0:3ae:1e08:41e9 with SMTP id
 bx17-20020a0568081b1100b003ae1e0841e9mr404808oib.3.1695782966473; Tue, 26 Sep
 2023 19:49:26 -0700 (PDT)
Date:   Tue, 26 Sep 2023 19:49:26 -0700
In-Reply-To: <0000000000006777d506051db4fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000553a2106064e3d86@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in ntfs_write_bh
From:   syzbot <syzbot+bc79f8d1898960d41073@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
        hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 5f0fb2210bb34ecd3f7bfde0d8f0068b79b2e094
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Aug 9 22:05:44 2023 +0000

    ntfs3: don't call sync_blockdev in ntfs_put_super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1671b51e680000
start commit:   6465e260f487 Linux 6.6-rc3
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1571b51e680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1171b51e680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb54ecdfa197f132
dashboard link: https://syzkaller.appspot.com/bug?extid=bc79f8d1898960d41073
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14aa4e32680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171787b6680000

Reported-by: syzbot+bc79f8d1898960d41073@syzkaller.appspotmail.com
Fixes: 5f0fb2210bb3 ("ntfs3: don't call sync_blockdev in ntfs_put_super")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
