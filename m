Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450257FAD74
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjK0W2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjK0W2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:28:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4702681
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:16:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698ABC433C7;
        Mon, 27 Nov 2023 22:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701123367;
        bh=KbzJsoazLxCd2BbBFJe0yrPuXWbbj41CPsXDmVkbnlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7/5u7odSgDcr2BZlmpNy1S21R3etVUBzXNDTaHq4Dk2PTruYFrXj0A2hW1KAk71o
         edP+r0uMmfj1SgZEYaOWDiUoQHgBstwrK6FVcab3oBYGpjIy/4B/STG1uMLLWcxyjl
         evZ24DVTpGyPSivLlskhsN+5QpXLPX80OM60qy+2gW8vWLSDzqiXGVdYh3qBKjxba2
         hnvT4qOGhzErqNg5+8CoK6Z2peD6BkNQM84GsSZBkNfI3hOWfIvsXxmu9DpXiiEvSB
         XshUMntkc0rk4ouzy0J+Z0k99QL3H/0Ly/U6vHXezlIczWrfs9YXRYzrNP88N5b9jZ
         tGS9nsOHBr5xg==
Date:   Mon, 27 Nov 2023 14:16:05 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+9d04b061c581795e18ce@syzkaller.appspotmail.com>
Cc:     jaegeuk@kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [fscrypt?] possible deadlock in
 find_and_lock_process_key
Message-ID: <20231127221605.GB1463@sol.localdomain>
References: <0000000000002aa189060b147268@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002aa189060b147268@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 12:58:22PM -0800, syzbot wrote:
> -> #3 (&type->lock_class#5){++++}-{3:3}:
>        down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
>        find_and_lock_process_key+0x97/0x390 fs/crypto/keysetup_v1.c:112
>        fscrypt_setup_v1_file_key_via_subscribed_keyrings+0x115/0x2d0 fs/crypto/keysetup_v1.c:310
>        setup_file_encryption_key fs/crypto/keysetup.c:485 [inline]
>        fscrypt_setup_encryption_info+0xb69/0x1080 fs/crypto/keysetup.c:590
>        fscrypt_get_encryption_info+0x3d1/0x4b0 fs/crypto/keysetup.c:675
>        fscrypt_setup_filename+0x238/0xd80 fs/crypto/fname.c:458
>        ext4_fname_setup_filename+0xa3/0x250 fs/ext4/crypto.c:28
>        ext4_add_entry+0x32b/0xe40 fs/ext4/namei.c:2403
>        ext4_rename+0x165e/0x2880 fs/ext4/namei.c:3932
>        ext4_rename2+0x1bc/0x270 fs/ext4/namei.c:4212
>        vfs_rename+0x13e0/0x1c30 fs/namei.c:4844
>        do_renameat2+0xc3c/0xdc0 fs/namei.c:4996
>        __do_sys_renameat fs/namei.c:5036 [inline]
>        __se_sys_renameat fs/namei.c:5033 [inline]
>        __x64_sys_renameat+0xc6/0x100 fs/namei.c:5033
>        do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>        do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>        entry_SYSCALL_64_after_hwframe+0x63/0x6b

#syz dup: possible deadlock in start_this_handle (4)

See https://lore.kernel.org/linux-fscrypt/Y%2F6aDmrx8Q9ob+Zi@sol.localdomain/

- Eric
