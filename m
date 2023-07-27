Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF0176458C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjG0FeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjG0FeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:34:04 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8502D61
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:33:39 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6bc56f23c65so1060600a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436008; x=1691040808;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACCQJS1yNDOg9N72wtfvjjkCfEbgk/h272KX1jaBuI8=;
        b=RTNZqen7i2gwkHNP+g6Amq5mJItPZYziKCnJKsgFp44GADZCRPNtUFu3lKU7ZYToCw
         u92DRQbRG2JtzSPBu1S6T2V1BBfjVtTYGrOOi8q6S7v7hW5p4aZrJw2dVy/nY789SzEw
         0cicjdEILqhY73RyoaPxPvxGOCGwFsOsNshL/gQUbCCPLJUBi9GHKirpbXFDFQLdgPh7
         QGdKUa8f8LZlkd6kzpDxKNecy5p1l5UKKzaxTwljX50LuYyGyRRItUaX4dozwh+HVyXW
         b3Fjbtjf38+m9Xe0V8uiDbf3suafbcbLWE6tJNNxmQj0tx5K1BjmAMyS/A7FyOf6q55p
         bHqQ==
X-Gm-Message-State: ABy/qLbKK+3JN+0pjmGAU0XV9uHJjJ6U7PiMh1WgkqsdTVqa3mUlUVTU
        Xv6O3/GirSPVuOEyDmIc4vt/jpWkg+K50tYr90pCnOk6R6vv
X-Google-Smtp-Source: APBJJlERGUD5LQ82IZmIMYfnXRXSirkzOqmaKhkhvfCMNRb7PUbXIrlMigrCCdB5aZywpNhcqkm81YBBEkCGhS8uEJq5ZEnxHL8q
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1043:b0:6ba:169f:f425 with SMTP id
 b3-20020a056830104300b006ba169ff425mr6494875otp.2.1690436008287; Wed, 26 Jul
 2023 22:33:28 -0700 (PDT)
Date:   Wed, 26 Jul 2023 22:33:28 -0700
In-Reply-To: <000000000000a0d7f305eecfcbb9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca24700601714dd2@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in path_openat
From:   syzbot <syzbot+be8872fcb764bf9fea73@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, bp@alien8.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, yazen.ghannam@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 00e4feb8c0476bbde3c8bf4a593e0f82ca9a4df6
Author: Yazen Ghannam <yazen.ghannam@amd.com>
Date:   Fri Jan 27 17:04:03 2023 +0000

    EDAC/amd64: Rename debug_display_dimm_sizes()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=157a6f81a80000
start commit:   c1649ec55708 Merge tag 'nfsd-6.2-4' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=319a3509d25b0f85
dashboard link: https://syzkaller.appspot.com/bug?extid=be8872fcb764bf9fea73
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c604fe480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: EDAC/amd64: Rename debug_display_dimm_sizes()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
