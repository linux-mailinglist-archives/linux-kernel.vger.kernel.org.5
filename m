Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6E7A1AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjIOJlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbjIOJlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:41:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21487273E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:40:10 -0700 (PDT)
X-UUID: da8d3ac853ab11eea33bb35ae8d461a2-20230915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1OuoRlRhal85zHHNkvOTaN3Ke5AHVAChxHwJa2fHozc=;
        b=MM3euV1tUKPXUIldHSEbYRgltH5vlWwr9PKwDcZsZ93Y58hIBDgqc8rENDFbkwXO+ceBSA77MybzU3AMAim1adN077HVNbgjNPIh8lQ605HiFQH5brtv68RiPv6ae75O4HIXXjIXvDfVSNnfzoBqMfzOhdzOiTL4mDx0JETFaNE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:22c0bd65-c731-4d9e-bcf0-de69c4a8e593,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:ce0bbdef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:0|-5,EDM:-3,I
        P:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
        SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: da8d3ac853ab11eea33bb35ae8d461a2-20230915
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1770198016; Fri, 15 Sep 2023 17:40:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Sep 2023 17:40:04 +0800
Received: from mszsdtlt101.gcn.mediatek.inc (10.16.4.141) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Sep 2023 17:40:04 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <haibo.li@mediatek.com>
CC:     <akpm@linux-foundation.org>, <andreyknvl@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <dvyukov@google.com>,
        <glider@google.com>, <jannh@google.com>,
        <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <ryabinin.a.a@gmail.com>, <vincenzo.frascino@arm.com>,
        <xiaoming.yu@mediatek.com>
Subject: Re: [PATCH] kasan:fix access invalid shadow address when input is illegal
Date:   Fri, 15 Sep 2023 17:40:04 +0800
Message-ID: <20230915094004.113104-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230915024559.32806-1-haibo.li@mediatek.com>
References: <20230915024559.32806-1-haibo.li@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Thu, Sep 14, 2023 at 10:41=C3=A2=E2=82=AC=C2=AFPM Jann Horn <jannh@g=
oogle.com> wrote:=0D
> > >=0D
> > > > Accessing unmapped memory with KASAN always led to a crash when=0D
> > > > checking shadow memory. This was reported/discussed before. To impr=
ove=0D
> > > > crash reporting for this case, Jann added kasan_non_canonical_hook =
and=0D
> > > > Mark integrated it into arm64. But AFAIU, for some reason, it stopp=
ed=0D
> > > > working.=0D
> > > >=0D
> > > > Instead of this patch, we need to figure out why=0D
> > > > kasan_non_canonical_hook stopped working and fix it.=0D
> > > >=0D
> > > > This approach taken by this patch won't work for shadow checks adde=
d=0D
> > > > by compiler instrumentation. It only covers explicitly checked=0D
> > > > accesses, such as via memcpy, etc.=0D
> > >=0D
> > > FWIW, AFAICS kasan_non_canonical_hook() currently only does anything=
=0D
> > > under CONFIG_KASAN_INLINE;=0D
> > =0D
> > Ah, right. I was thinking about the inline mode, but the patch refers=0D
> > to the issue with the outline mode.=0D
> > =0D
> > However, I just checked kasan_non_canonical_hook for SW_TAGS with the=0D
> > inline mode: it does not work when accessing 0x42ffffb80aaaaaaa, the=0D
> > addr < KASAN_SHADOW_OFFSET check fails. It appears there's something=0D
> > unusual about how instrumentation calculates the shadow address. I=0D
> > didn't investigate further yet.=0D
Sorry to miss this message.=0D
I checked inline mode just now.kasan_non_canonical_hook can print =0D
something like below:=0D
Unable to handle kernel paging request at virtual address ffffffb80aaaaaaa=
=0D
KASAN: maybe wild-memory-access in range [0xffffff80aaaaaaa0-0xffffff80aaaa=
aaaf]=0D
...=0D
[ffffffb80aaaaaaa] pgd=3D000000005d3d6003, p4d=3D000000005d3d6003, pud=3D00=
0000005d3d6003,=0D
pmd=3D0000000000000000=0D
...=0D
pc : __hwasan_check_x20_67043363+0x4/0x34=0D
lr : do_ib_ob+0x108/0x114=0D
...=0D
Call trace:=0D
 __hwasan_check_x20_67043363+0x4/0x34=0D
 die_selftest+0x68/0x80=0D
 param_attr_store+0xec/0x164=0D
 module_attr_store+0x34/0x4c=0D
 sysfs_kf_write+0x78/0x8c=0D
 kernfs_fop_write_iter+0x154/0x214=0D
 vfs_write+0x36c/0x4c4=0D
 ksys_write+0x98/0x110=0D
 __arm64_sys_write+0x3c/0x48=0D
 invoke_syscall+0x58/0x154=0D
 el0_svc_common+0xe8/0x120=0D
 do_el0_svc_compat+0x2c/0x38=0D
 el0_svc_compat+0x34/0x84=0D
 el0t_32_sync_handler+0x78/0xb4=0D
 el0t_32_sync+0x194/0x198=0D
=0D
When addr < KASAN_SHADOW_OFFSET meets,the original addr_has_metadata should=
 return false=0D
and trigger kasan_report in kasan_check_range.=0D
> > =0D
> > > I think the idea when I added that was that=0D
> > > it assumes that when KASAN checks an access in out-of-line=0D
> > > instrumentation or a slowpath, it will do the required checks to avoi=
d=0D
> > > this kind of fault?=0D
> > =0D
> > Ah, no, KASAN doesn't do it.=0D
> > =0D
> > However, I suppose we could add what the original patch proposes for=0D
> > the outline mode. For the inline mode, it seems to be pointless, as=0D
> > most access checks happen though the compiler inserted code anyway.=0D
> > =0D
> > I also wonder how much slowdown this patch will introduce.=0D
> > =0D
> > Haibo, could you check how much slower the kernel becomes with your=0D
> > patch? If possible, with all GENERIC/SW_TAGS and INLINE/OUTLINE=0D
> > combinations.=0D
> > =0D
> > If the slowdown is large, we can just make kasan_non_canonical_hook=0D
> > work for both modes (and fix it for SW_TAGS).=0D
> =0D
> Thanks.=0D
> The patch checks each shadow address,so it introduces extra overhead.=0D
> Now kasan_non_canonical_hook only works for CONFIG_KASAN_INLINE.=0D
> And CONFIG_KASAN_OUTLINE is set in my case.=0D
> Is it possible to make kasan_non_canonical_hook works for both =0D
> INLINE and OUTLINE by simply remove the "#ifdef CONFIG_KASAN_INLINE"?=0D
> Since kasan_non_canonical_hook is only used after kernel fault,it =0D
> is better if there is no limit.=0D
