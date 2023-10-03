Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73BF7B6023
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbjJCE4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 00:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjJCE4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:56:37 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A92E4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 21:56:34 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3ae5ac8de14so779150b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 21:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696308993; x=1696913793;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfrUWOBmU6zzAiZBESX6DIbmzW9eMSUX6mzf04Ler6k=;
        b=VipJK+5ffKyAHXK+Wcf2rB3hOG430CiQpfcCMHuGUQI9NhJz/wpIF0JtVX8uvpEsvl
         zXblEs7uz4o1CwwDpmUWIgrb9jmk1t5/jRvUg8fpkqcUkAqXS+jTHH3DeEPYpjSUVZXH
         JIyHXbm28F6KyqsIphjyC6MaPBNIjRBrCEVW0wNppy+pHrVGM2OcO3QzCSVvrcTqA+Nq
         L2qTyz8P46HJhH7op81Eddx2JkL19O+jbjtZuWzvXc78DSBG0AcaAhVq0k6d9bOMLZ0K
         yZPiyVRZ4BzmMve2gupMicn1epPVA0yOGLJJJWoAT9bB65EmEp07NdnhOBC078mCx5Zj
         lr1g==
X-Gm-Message-State: AOJu0YxSr4QKIX8VR7U4RmWOknbV1/e/iExHRWsa8qEsuUdPW1tp8mDr
        fGZ0llpV91SYxTknGMI/wmD/g5cMP+PNuBC0fHntisag+zzs
X-Google-Smtp-Source: AGHT+IEbktwgravybWHUhcjDg2HPO0fZM9+laAEhvFerNy1UOSXTCbPCj1YqCLbR/KpGxOSSpO2R8d6JaZU/dh4DnHuTyvkCO+Z9
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2219:b0:3ac:ab4f:ef3 with SMTP id
 bd25-20020a056808221900b003acab4f0ef3mr7223567oib.6.1696308993424; Mon, 02
 Oct 2023 21:56:33 -0700 (PDT)
Date:   Mon, 02 Oct 2023 21:56:33 -0700
In-Reply-To: <00000000000056dad80606c447e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb84850606c8b688@google.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_encode_real_fh
From:   syzbot <syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 16aac5ad1fa94894b798dd522c5c3a6a0628d7f0
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Sun Apr 23 16:02:04 2023 +0000

    ovl: support encoding non-decodable file handles

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11972062680000
start commit:   8a749fd1a872 Linux 6.6-rc4
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13972062680000
console output: https://syzkaller.appspot.com/x/log.txt?x=15972062680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57da1ac039c4c78a
dashboard link: https://syzkaller.appspot.com/bug?extid=2208f82282740c1c8915
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14877eb2680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b701f6680000

Reported-by: syzbot+2208f82282740c1c8915@syzkaller.appspotmail.com
Fixes: 16aac5ad1fa9 ("ovl: support encoding non-decodable file handles")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
