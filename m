Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B2380C647
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjLKKWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjLKKWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:22:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8CD91
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:22:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21909C433C8;
        Mon, 11 Dec 2023 10:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702290173;
        bh=YzaJ13323od16h3INhdZ+R72C23XYnelffzcvpy8NM8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gTiwD8kzWVj5v00CPZP0VCg0LRye52bmegegb7ppR/SoNGKLcvGczu2tzkna5ak/J
         GTBthlIuFPHOcHl8sh0hdE5cWRqB5ENjZ5k3GGCsatCDO1Um4IvBDlQIL6e9ZlNF1f
         ivVYLidgfO9hjHFYhGts41TOvOGfrncaSB/8XQTrj1mrv7BqOcW7fvi50as5uGgPGm
         7gpDyXiGKqltrNPKkXmG7h182zMblRJRoEI6Ds2P74TL9ZnPiHZrNKeYU2RTvogwsZ
         WzJF31l9IY343m5fby0OdK41+RcHGdG5BPLQYFd0Eo6qLqQVlKdMG/MK1tZLvgEn3u
         82QNn8ICNoOtw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50c0dbaf2baso3994183e87.3;
        Mon, 11 Dec 2023 02:22:53 -0800 (PST)
X-Gm-Message-State: AOJu0Yz2BjqabmGpcHXfSTPx6kIBNLn4H9saDzHYTbLmWSLBkSG6BSiM
        Ulp+vnIgcQrlboNHOLRGpGop6D6rxFxACa2Iyro=
X-Google-Smtp-Source: AGHT+IEs1N2s8A5HoRvz8mUh0qJF3iU7aald+3uZWI16GdTvv7ccCBK4l8GOqAV6wGdK43ciEb9ZfQTpRBVoQbdGtwo=
X-Received: by 2002:a19:7706:0:b0:50b:f82f:6926 with SMTP id
 s6-20020a197706000000b0050bf82f6926mr900862lfc.17.1702290171272; Mon, 11 Dec
 2023 02:22:51 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003dd70305e722f605@google.com>
In-Reply-To: <0000000000003dd70305e722f605@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 11 Dec 2023 11:22:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGsvR1vAfEe=9v4i=OtLpqTGCB8G8jgAvmo8_Zw3TcFnw@mail.gmail.com>
Message-ID: <CAMj1kXGsvR1vAfEe=9v4i=OtLpqTGCB8G8jgAvmo8_Zw3TcFnw@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
To:     syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 at 13:10, syzbot
<syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    680fb5b009e8 Merge tag 'arm64-upstream' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=126f0865080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4557ad2600fc45f4
> dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10039fc3080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f4ebc3080000
>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
