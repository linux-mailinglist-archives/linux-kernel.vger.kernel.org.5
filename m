Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207AE778099
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjHJSpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbjHJSpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:45:19 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA43270A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:45:18 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40a47e8e38dso52021cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691693118; x=1692297918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf8chGfH4oYWBbdEEeTKLvdbokFUyzQiaSMi4ZBbcz8=;
        b=FIZQoSZwi1+nuXAHJTO/MfzRwR56vT3I5WMOIyJy55ioWLg8kVgXozcbiH4CQTbkb3
         IFbVzdqVM4moMosixCXYrSLkC7IAGqWfZLdoEWSbDkNKF4XyRO+X9QgzlfMUI6I4STUc
         2elVqojL2r3eznBuDIJQeH7RHBJq4RSlywOktJabzlN0SmS9PLHX1tN15sc4p6zEZACR
         yUrbkSX44QCXkOI7ctjqi9TO+GfYyVipX2RGk4o6CDdHvN6xSzICumi4k9qPL4B6e8er
         QLxEL4EUxgNslqE9LHhdrYM/+Sp2Vjlbqt611iXR0s8I4PofmIcBSax/IJQnO8ZmWg6w
         neSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693118; x=1692297918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf8chGfH4oYWBbdEEeTKLvdbokFUyzQiaSMi4ZBbcz8=;
        b=XVEIT85BjunRi2RKBbNj425lY3NCe6xGZRk+blQAwEE9ZBy2vH0H5HpqWUc+AbZyBl
         y4RvC7eEzyx3NJtwFFk6dJqQHUVySzkyoRIUfA6btgxzxEuIzSHEZ2iSlsHH0q+Q0oTD
         MmLigTSGHJiiJR0Ak/96Ew+sMKC4rqPkAUtNKgQvF4GWm5tjRfXlhZddlWhBtWxhWxbO
         lNq6L1T7MMuspWaII7JbHX2MxA7cEm5TOWen9+Av1PRKqieko+ocaoEKyZiyJ7PDGUnX
         cnFdXOA3UJs/vkvZXDZssyBdy48NNzQSR+g9vdn7uDsbf8itHS2lQKhGk6XuW3hmC86t
         fWbQ==
X-Gm-Message-State: AOJu0Yx5eHYG5rFGBuvzKTtAZXAeMuYy1AoHbzS/JDU60ztet10XeJ8y
        tJJUFfAFXpPcSEIsbEnxVk+kN5VwXX13yDcTMstmQw==
X-Google-Smtp-Source: AGHT+IGSqxnhWj1KWhYXsYIacdBkjUKC813mbmtwA/H5mskOYtkloQgY4KnXhR0F/Z6BuVI4N04N1dTfJKI/1qFRJpk=
X-Received: by 2002:ac8:4e55:0:b0:40f:ec54:973 with SMTP id
 e21-20020ac84e55000000b0040fec540973mr52312qtw.22.1691693117898; Thu, 10 Aug
 2023 11:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
In-Reply-To: <20230810095652.3905184-1-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 10 Aug 2023 12:44:41 -0600
Message-ID: <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com>
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to zswap_load
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 3:58=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> With mm-unstable branch, if trigger swap activity and it's possible
> see following warning:
> [  178.093511][  T651] WARNING: CPU: 2 PID: 651 at mm/zswap.c:1387 zswap_=
load+0x67/0x570
> [  178.095155][  T651] Modules linked in:
> [  178.096103][  T651] CPU: 2 PID: 651 Comm: gmain Not tainted 6.5.0-rc4-=
00492-gad3232df3e41 #148
> [  178.098372][  T651] Hardware name: QEMU Standard PC (i440FX + PIIX,199=
6), BIOS 1.14.0-2 04/01/2014
> [  178.101114][  T651] RIP: 0010:zswap_load+0x67/0x570
> [  178.102359][  T651] Code: a0 78 4b 85 e8 ea db ff ff 48 8b 00 a8 01 0f=
 84 84 04 00 00 48 89 df e8 d7 db ff ff 48 8b 00 a9 00 00 08 00 0f 85 c4
> [  178.106376][  T651] RSP: 0018:ffffc900011b3760 EFLAGS: 00010246
> [  178.107675][  T651] RAX: 0017ffffc0080001 RBX: ffffea0004a991c0 RCX:ff=
ffc900011b37dc
> [  178.109242][  T651] RDX: 0000000000000000 RSI: 0000000000000001 RDI:ff=
ffea0004a991c0
> [  178.110916][  T651] RBP: ffffea0004a991c0 R08: 0000000000000243 R09:00=
000000c9a1aafc
> [  178.112377][  T651] R10: 00000000c9657db3 R11: 000000003c9657db R12:00=
00000000014b9c
> [  178.113698][  T651] R13: ffff88813501e710 R14: ffff88810d591000 R15:00=
00000000000000
> [  178.115008][  T651] FS:  00007fb21a9ff700(0000) GS:ffff88813bc80000(00=
00) knlGS:0000000000000000
> [  178.116423][  T651] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  178.117421][  T651] CR2: 00005632cbfc81f6 CR3: 0000000131450002 CR4:00=
00000000370ee0
> [  178.118683][  T651] DR0: 0000000000000000 DR1: 0000000000000000 DR2:00=
00000000000000
> [  178.119894][  T651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:00=
00000000000400
> [  178.121087][  T651] Call Trace:
> [  178.121654][  T651]  <TASK>
> [  178.122109][  T651]  ? zswap_load+0x67/0x570
> [  178.122658][  T651]  ? __warn+0x81/0x170
> [  178.123119][  T651]  ? zswap_load+0x67/0x570
> [  178.123608][  T651]  ? report_bug+0x167/0x190
> [  178.124150][  T651]  ? handle_bug+0x3c/0x70
> [  178.124615][  T651]  ? exc_invalid_op+0x13/0x60
> [  178.125192][  T651]  ? asm_exc_invalid_op+0x16/0x20
> [  178.125753][  T651]  ? zswap_load+0x67/0x570
> [  178.126231][  T651]  ? lock_acquire+0xbb/0x290
> [  178.126745][  T651]  ? folio_add_lru+0x40/0x1c0
> [  178.127261][  T651]  ? find_held_lock+0x2b/0x80
> [  178.127776][  T651]  swap_readpage+0xc7/0x5c0
> [  178.128273][  T651]  do_swap_page+0x86d/0xf50
> [  178.128770][  T651]  ? __pte_offset_map+0x3e/0x290
> [  178.129321][  T651]  ? __pte_offset_map+0x1c4/0x290
> [  178.129883][  T651]  __handle_mm_fault+0x6ad/0xca0
> [  178.130419][  T651]  handle_mm_fault+0x18b/0x410
> [  178.130992][  T651]  do_user_addr_fault+0x1f1/0x820
> [  178.132076][  T651]  exc_page_fault+0x63/0x1a0
> [  178.132599][  T651]  asm_exc_page_fault+0x22/0x30
>
> It's possible that swap_readpage() is called with none swapcache folio
> in do_swap_page() and trigger this warning. So we shouldn't assume
> zswap_load() always takes swapcache folio.

Did you use a bdev with QUEUE_FLAG_SYNCHRONOUS? Otherwise it sounds
like a bug to me.
