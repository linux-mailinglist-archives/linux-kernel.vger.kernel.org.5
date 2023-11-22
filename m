Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34277F4947
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbjKVOsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjKVOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:48:17 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1253A1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:48:13 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc2786a8ebso96957505ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700664493; x=1701269293;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfUef9tj9kWRG/hnj63YvOvnIkXS0rMCQtJAytUlGk8=;
        b=iX9/vSDDPeOeoxjg9my4zBs6adRK+Om1eik7ssk6QyBpUVUl9tB1a8laghb53q+63e
         MiWY22Bv3193vNU8XDUDpcHk8HP/gpmuGQnmyJil9fsPIcyZDvdVQBv8NuLRWB0eSREf
         bd9fWHgPoz6zzzXEv7G+jM9Ns1d+WMIt+HOk5585B6Wu9vA7JwPuxOrudBcuAx7QvXGg
         sju8ODzStPhl+kriZQuo2hbx+ClcpG7THM1tcWmHi+H5Kmh4dhvo/UnkxoDL+JnGNbrf
         TCfM0TbdCn9iWniUFYRXFesB2OSZMqk4OgtQrk1D/npi4W3rn0FRnvJpDWvl/CVGnKFo
         K9dQ==
X-Gm-Message-State: AOJu0Yybsr29zF0hVFWX99FH4zJGAZKoPZoDckqCnFwkujDTis8yT3OI
        4u7yI72vqmhkhhWjuXbRqoNAnrV3uBIWXiWskqhe/zzWd2C8
X-Google-Smtp-Source: AGHT+IGq7r6T25A3qPazOzUj0YDkw7al03zhP0GBv38qY3FOLZ1Idk9W9LaKs0J37RKiQ9EjayKjiAW3KL9Qkt9T7aav4YO9BgNV
MIME-Version: 1.0
X-Received: by 2002:a17:902:dac8:b0:1cc:3147:6937 with SMTP id
 q8-20020a170902dac800b001cc31476937mr655370plx.4.1700664493183; Wed, 22 Nov
 2023 06:48:13 -0800 (PST)
Date:   Wed, 22 Nov 2023 06:48:13 -0800
In-Reply-To: <0000000000009b49ce0606fd665a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff9bd1060abececf@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in attr_data_get_block (3)
From:   syzbot <syzbot+a9850b21d99643eadbb8@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, tintinm2017@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 4ad5c924df6cd6d85708fa23f9d9a2b78a2e428e
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Sep 22 10:07:59 2023 +0000

    fs/ntfs3: Allow repeated call to ntfs3_put_sbi

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17484614e80000
start commit:   e402b08634b3 Merge tag 'soc-fixes-6.6' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=12da82ece7bf46f9
dashboard link: https://syzkaller.appspot.com/bug?extid=a9850b21d99643eadbb8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b684e6680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ede4d6680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Allow repeated call to ntfs3_put_sbi

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
