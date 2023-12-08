Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2380A79C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574387AbjLHPkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574379AbjLHPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:40:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D97171E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:40:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6405C433C7;
        Fri,  8 Dec 2023 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702050013;
        bh=ieVNX3t8OHlTPk0YVyjDeXt4NaL02vWfuoHRriWFMQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VY5BGAL3r0QbzWRb5Eszy5EVO0efv6muA+409Qox0aDL07fC+R/tulhSd+NIh0VKW
         B2XXfyGuIG5dYNd7vwskPqfAUJZiWliVfU6wMPGfYnE2r5pFU8IcM1qt9jz3QSpCQh
         0XdY6c+vJ35iWrP5uKh8D0Mg6CxG13byZ8+GMdnleqSCWY3KWVB0wJQ1vPvYceMLYh
         VP7CEGM9CaNcF/J0jIek78BAORDLAYfQin0TZgg4+KYyqnlPPG53Nj5cNWk7+XI5VC
         2RN4LDwp0AW+okMbirlRkvGgFduw+S40rLF9yJ+uo/TD7n/LEs6PnX3ZmDJihMvY+M
         beZTPFdpJ8XZA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ca09601127so27890081fa.1;
        Fri, 08 Dec 2023 07:40:13 -0800 (PST)
X-Gm-Message-State: AOJu0Yxru6R0BD0wFqzQMwtYaSUL+mO4pNus8mNh27Z0YYycXOV++XFx
        MA8G+DUBVxSNZFh6Abk0sXxZR/8kZP6bjQUgB7s=
X-Google-Smtp-Source: AGHT+IHKpsCoFUwtx0uJ5yciTMXMsGyA+ko6Y6KeazE2iy2abDkzUd5ub7GLATGs7gDzfPSbVQPLUjIZU1LSnW71hi0=
X-Received: by 2002:a2e:948c:0:b0:2c9:ffcf:ec98 with SMTP id
 c12-20020a2e948c000000b002c9ffcfec98mr59130ljh.27.1702050012031; Fri, 08 Dec
 2023 07:40:12 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXFrexNBSDGGRaQQh=6_O=nm2NET_unZ4Qy618461H6maw@mail.gmail.com>
 <00000000000010057c060c012e63@google.com> <CANp29Y4bxQzV-=rSQOBPfi2Rxrob_GTHZrsGAgvemvnXgC5a3g@mail.gmail.com>
In-Reply-To: <CANp29Y4bxQzV-=rSQOBPfi2Rxrob_GTHZrsGAgvemvnXgC5a3g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 8 Dec 2023 16:40:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGdLTsDnvqb3pe--eW3p480kbDRfyydMCUOW1m-3Bf9cg@mail.gmail.com>
Message-ID: <CAMj1kXGdLTsDnvqb3pe--eW3p480kbDRfyydMCUOW1m-3Bf9cg@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 16:38, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> If a command spans over two lines, syzbot expects a colon.
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
> efivarfs-list-corruption-fix
>

It is Gmail that is breaking the line here


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git:
efivarfs-list-corruption-fix
