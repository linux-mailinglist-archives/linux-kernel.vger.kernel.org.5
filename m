Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2A79A18B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjIKC5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjIKC5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:57:39 -0400
Received: from out-211.mta1.migadu.com (out-211.mta1.migadu.com [95.215.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D396B5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:57:34 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694401052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BJ23BKSZ8d0LOPN83ClcZC21pXI2hUitVI920Cs+wWM=;
        b=sFd42ph1SA24QuRQw6httzBuJq+8R+O/LQwhAMWUh2nu5YwYKrb9Aca5SQmwDyHtpqjckZ
        C5/KtGVzkpMX3Xd4BcBgSNWaoW2sqJATxpHRyVUb5OYOjo3wEED07zuOrx6dzIDIVfWEu0
        ODNrpSDnMv2MO3wmy5d7/50ptjz/ONo=
Date:   Mon, 11 Sep 2023 02:57:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <9c1bfbeb50ac0d4fe728c45329c958607f13d88c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm/mm_init.c: remove redundant pr_info when node is
 memoryless
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230910143004.e8191c8ebabbe7ddd0fec6fa@linux-foundation.org>
References: <20230910143004.e8191c8ebabbe7ddd0fec6fa@linux-foundation.org>
 <20230906091113.4029983-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

September 11, 2023 at 5:30 AM, "Andrew Morton" <akpm@linux-foundation.org=
> wrote:


>=20
>=20On Wed, 6 Sep 2023 17:11:13 +0800 Yajun Deng <yajun.deng@linux.dev> w=
rote:
>=20
>=20>=20
>=20> There is a similar pr_info in free_area_init_node(), so remove the
> >  redundant pr_info.
> >=20
>=20
> Please quote the before and after dmesg output so we can better
> understand this proposal, thanks.
>

before:
[    0.006314] Initializing node 0 as memoryless
[    0.006445] Initmem setup node 0 as memoryless
[    0.006450] Initmem setup node 1 [mem 0x0000000000001000-0x000000003ff=
fffff]
[    0.006453] Initmem setup node 2 [mem 0x0000000040000000-0x000000007ff=
d7fff]
[    0.006454] Initializing node 3 as memoryless
[    0.006584] Initmem setup node 3 as memoryless
[    0.006585] Initmem setup node 4 [mem 0x0000000100000000-0x00000001bff=
fffff]
[    0.006586] Initmem setup node 5 [mem 0x00000001c0000000-0x00000001fff=
fffff]
[    0.006587] Initmem setup node 6 [mem 0x0000000200000000-0x000000023ff=
fffff]

after:
[    0.004147] Initmem setup node 0 as memoryless
[    0.004148] Initmem setup node 1 [mem 0x0000000000001000-0x000000003ff=
fffff]
[    0.004150] Initmem setup node 2 [mem 0x0000000040000000-0x000000007ff=
d7fff]
[    0.004154] Initmem setup node 3 as memoryless
[    0.004155] Initmem setup node 4 [mem 0x0000000100000000-0x00000001bff=
fffff]
[    0.004156] Initmem setup node 5 [mem 0x00000001c0000000-0x00000001fff=
fffff]
[    0.004157] Initmem setup node 6 [mem 0x0000000200000000-0x000000023ff=
fffff]
