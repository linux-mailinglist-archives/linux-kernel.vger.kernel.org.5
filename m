Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA8B7A13EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjIOCqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjIOCqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:46:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96E52707
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:46:07 -0700 (PDT)
X-UUID: 0208f7ac537211eea33bb35ae8d461a2-20230915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RK7ek7Jr01ODZjowTcUOfcKbHQxnH1wn+srDfh3q4PM=;
        b=LGetPjaMUK0joxLxCjbDO9u8IWPp7eotdlQVUpeS6d7kStozRklNHH8QXwvWv6+gcKMvfal1nv/F5nAi1Z1SYdeHN4NcIgcFgNZ5yis6es304PvYb0LAYp/2qDQgtle7KnTuFgbNdAraSG+iXvlE9qe4VDm/FjCdoxw8Z8y1kwg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:273d4d59-8a9f-4528-ac37-dc0b424d25af,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:954db8ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:0|-5,EDM:-3,I
        P:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
        SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0208f7ac537211eea33bb35ae8d461a2-20230915
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1408545457; Fri, 15 Sep 2023 10:46:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Sep 2023 10:46:00 +0800
Received: from mszsdtlt101.gcn.mediatek.inc (10.16.4.141) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Sep 2023 10:46:00 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <andreyknvl@gmail.com>
CC:     <akpm@linux-foundation.org>,
        <angelogioacchino.delregno@collabora.com>, <dvyukov@google.com>,
        <glider@google.com>, <haibo.li@mediatek.com>, <jannh@google.com>,
        <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <ryabinin.a.a@gmail.com>, <vincenzo.frascino@arm.com>,
        <xiaoming.yu@mediatek.com>
Subject: Re: [PATCH] kasan:fix access invalid shadow address when input is illegal
Date:   Fri, 15 Sep 2023 10:45:59 +0800
Message-ID: <20230915024559.32806-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <CA+fCnZePgv=V65t4FtJvcyKvhM6yA3amTbPnwc5Ft5YdzpeeRg@mail.gmail.com>
References: <CA+fCnZePgv=V65t4FtJvcyKvhM6yA3amTbPnwc5Ft5YdzpeeRg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--26.184700-8.000000
X-TMASE-MatchedRID: +f/wAVSGjug4HKI/yaqRmya1MaKuob8PfjJOgArMOCaCsBeCv8CM/aaZ
        f1+j//eOkOti/7QqGXUh5AyXWmAqpmu2g5s6p8lPW7gz/Gbgpl6hi9MC6OBOwruqk4cq52pzvb4
        +3z1qe65wj5BBW++UfCbtuknoGANVmGpYaWdk09LhqJ6oLOc8QW3eqxoVjgMEzsQ8iRVyD44DsB
        KNVu8yHSHQK8Uc9fmXaqMgKdVUqQ9sGQsY/Fc7u6XD9CBSVyH8WPJn4UmMuVLJYIv7y0tu9u69j
        M3AtKAfmapKR6Enamd1VhrfJVJ6xDfVJKfK+bRO2x93SnoxhVeeimGtNywjtslk/SMg0CpQo8WM
        kQWv6iVkvICuNJteaI2j49Ftap9EkGUtrowrXLg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--26.184700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 31D8B882395646096EE4B3E748433B78DBB106D4F0ADFA8A05354A6A0A2C39E52000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Sep 14, 2023 at 10:41=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:=0D
> >=0D
> > > Accessing unmapped memory with KASAN always led to a crash when=0D
> > > checking shadow memory. This was reported/discussed before. To improv=
e=0D
> > > crash reporting for this case, Jann added kasan_non_canonical_hook an=
d=0D
> > > Mark integrated it into arm64. But AFAIU, for some reason, it stopped=
=0D
> > > working.=0D
> > >=0D
> > > Instead of this patch, we need to figure out why=0D
> > > kasan_non_canonical_hook stopped working and fix it.=0D
> > >=0D
> > > This approach taken by this patch won't work for shadow checks added=
=0D
> > > by compiler instrumentation. It only covers explicitly checked=0D
> > > accesses, such as via memcpy, etc.=0D
> >=0D
> > FWIW, AFAICS kasan_non_canonical_hook() currently only does anything=0D
> > under CONFIG_KASAN_INLINE;=0D
> =0D
> Ah, right. I was thinking about the inline mode, but the patch refers=0D
> to the issue with the outline mode.=0D
> =0D
> However, I just checked kasan_non_canonical_hook for SW_TAGS with the=0D
> inline mode: it does not work when accessing 0x42ffffb80aaaaaaa, the=0D
> addr < KASAN_SHADOW_OFFSET check fails. It appears there's something=0D
> unusual about how instrumentation calculates the shadow address. I=0D
> didn't investigate further yet.=0D
> =0D
> > I think the idea when I added that was that=0D
> > it assumes that when KASAN checks an access in out-of-line=0D
> > instrumentation or a slowpath, it will do the required checks to avoid=
=0D
> > this kind of fault?=0D
> =0D
> Ah, no, KASAN doesn't do it.=0D
> =0D
> However, I suppose we could add what the original patch proposes for=0D
> the outline mode. For the inline mode, it seems to be pointless, as=0D
> most access checks happen though the compiler inserted code anyway.=0D
> =0D
> I also wonder how much slowdown this patch will introduce.=0D
> =0D
> Haibo, could you check how much slower the kernel becomes with your=0D
> patch? If possible, with all GENERIC/SW_TAGS and INLINE/OUTLINE=0D
> combinations.=0D
> =0D
> If the slowdown is large, we can just make kasan_non_canonical_hook=0D
> work for both modes (and fix it for SW_TAGS).=0D
=0D
Thanks.=0D
The patch checks each shadow address,so it introduces extra overhead.=0D
Now kasan_non_canonical_hook only works for CONFIG_KASAN_INLINE.=0D
And CONFIG_KASAN_OUTLINE is set in my case.=0D
Is it possible to make kasan_non_canonical_hook works for both =0D
INLINE and OUTLINE by simply remove the "#ifdef CONFIG_KASAN_INLINE"?=0D
Since kasan_non_canonical_hook is only used after kernel fault,it =0D
is better if there is no limit.=0D
=0D
