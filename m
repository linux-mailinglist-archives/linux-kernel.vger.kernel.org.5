Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E4878C496
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjH2M41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjH2M4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:56:16 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76CF9D;
        Tue, 29 Aug 2023 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=9fb4MYRP5fYSklYNqpx8Lj2woGj0yb+xRYXtbbot1Dw=; b=CabpNKtJo88GC2q+1Jpvh+ylAj
        vrgwVo6Mk6S5Do3l92KY84wxZS7mArCCHFup3B7qexnXU+i67NJ24IvYelhdJD+sZlHzZPzhIFU1M
        2OrjYQ/JzsIFttHbnW3su44f98kjPVDuCoJnmO8n51nYNTTZpK5R6H8YVkf6yqI6AMT4zHo0KFvRu
        jBjGjnsdqWHVQt8opvQ/R3OJ+RcyXPAW0NoExa8vhc10cKEZL8BsFrwvHZxtZh5As+Gz54HRhKRfv
        ibfOJLElp32qAPC9ik3TiHJiWe0yswVWR0dqgmKD7GlTK1Q0b86aC1MH0dF8T0NKoBfiCIotd9KQj
        pODPlbmg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qayGN-000Gqj-Rv; Tue, 29 Aug 2023 14:56:08 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qayGN-000PV2-HA; Tue, 29 Aug 2023 14:56:07 +0200
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in
 xsk_diag_dump
To:     syzbot <syzbot+822d1359297e2694f873@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bjorn@kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        hawk@kernel.org, john.fastabend@gmail.com,
        jonathan.lemon@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com,
        magnus.karlsson@intel.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <000000000000af3ba506040b7d0c@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3d8fa470-8ca9-561c-8381-0687f9e69d10@iogearbox.net>
Date:   Tue, 29 Aug 2023 14:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <000000000000af3ba506040b7d0c@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27015/Tue Aug 29 09:39:45 2023)
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Magnus,

On 8/29/23 10:20 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5c905279a1b7 Merge branch 'pds_core-error-handling-fixes'
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16080070680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4a882f77ed77bd
> dashboard link: https://syzkaller.appspot.com/bug?extid=822d1359297e2694f873
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ec63a7a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109926eba80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/98add120b6e5/disk-5c905279.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c9e9009eadbd/vmlinux-5c905279.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b840142cc0c1/bzImage-5c905279.xz
> 
> The issue was bisected to:
> 
> commit 18b1ab7aa76bde181bdb1ab19a87fa9523c32f21
> Author: Magnus Karlsson <magnus.karlsson@intel.com>
> Date:   Mon Feb 28 09:45:52 2022 +0000
> 
>      xsk: Fix race at socket teardown

please take a look when you get a chance.

Thanks a lot,
Daniel
