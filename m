Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EC87A90CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjIUCOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjIUCOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:14:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9F5AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:13:56 -0700 (PDT)
X-UUID: 8234fde8582411ee8051498923ad61e6-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IbR9eOWj15szJiLhfjytcL1B57Or+K9/1eHVI5IPSpE=;
        b=CGtMc7gM8AW8vCO+NmN6UagD5p0ikbZY2L9jZzrVjFFyFQRr+/PyIOoW+N3DT5qDG9ABhOw/Fi7iCgYMzUw8ItDXfBdJ4l6qFABwbjEMd8oGryOPvZU7cIKC8lUEF+Q28tSYC8BlXjV40iCXbsVtNreHdTJ6RLmaY6kB6aPQk3U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c94fa882-2356-4b9d-98d5-36b7f72f99e3,IP:0,U
        RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:2
X-CID-META: VersionHash:5f78ec9,CLOUDID:77682f14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:4|-5,EDM:-3,I
        P:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
        SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 8234fde8582411ee8051498923ad61e6-20230921
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 574845708; Thu, 21 Sep 2023 10:13:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 10:13:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 10:13:50 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <robin.murphy@arm.com>
CC:     <amit.kachhap@arm.com>, <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux@armlinux.org.uk>,
        <mark-pk.tsai@mediatek.com>, <matthias.bgg@gmail.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] ARM: vfp: Add vudot opcode to VFP undef hook
Date:   Thu, 21 Sep 2023 10:13:50 +0800
Message-ID: <20230921021350.28283-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <170e8577-42c9-b72f-60c7-80141f379ec4@arm.com>
References: <170e8577-42c9-b72f-60c7-80141f379ec4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.333500-8.000000
X-TMASE-MatchedRID: WMT2WRIkHPM4HKI/yaqRm7hzZI/dfrdOjLOy13Cgb4+e9toQ6h6LE7iN
        d7CXjOinM4Cy4e3S8WIIv5CPDrKXd6tL0wBaA/G+GVyS87Wb4lxCs7hdHoFFA/5Ndkm9jGh5em0
        L3kwJxTdCXD2S19glPV3MEuq4MiSC5p1ATFvutT7Dr0AjBcmfRuPmXK6rwg5BIbxYwbCxGTQwhw
        b+RYrZ/zmvMXdRLat6TZGH8K2mj5XWbYh2DUbLpJU7Bltw5qVLoKO8hENbdctaW2Ktn+I8/sXyP
        yHR36DVcNIkKQttpKMyfXR0GRtO+520tDTabQHWA9lly13c/gFU3K6aV1ad7RHfiujuTbed8bf3
        35SL+13N1AcFAIRcfxVG2JHtKFfIFQGROYyu7Jnil2r2x2PwtTuvYa1v2IFhmWqNFutwpEHNRVl
        bRT9HtiWSzsPREMfEH2XXM8w5v7ofE8yM4pjsD1Z0V5tYhzdWxEHRux+uk8hfNjF5BHUO+xGSS7
        iI2Efv6SJbFWcaRn5oohyq6KZ7TE36fdoN3CG+jGfLyJg6bV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.333500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6E76ED6E959298A7BB402BB2CD71B065C8AF0B245F941B52C18D8F67297B97FE2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2023-09-20 09:39, Mark-PK Tsai wrote:
> > Add vudot opcode to the VFP undef hook to fix the
> > potentially undefined instruction error when the
> > user space executes vudot instruction.
> 
> Did the kernel expose a hwcap to say that the dot product extension is 
> supported? I'm pretty sure it didn't, so why would userspace expect this 
> to work? ;)

The hwcap for dotprod has been exported since commit:

62ea0d873af3 ARM: 9269/1: vfp: Add hwcap for FEAT_DotProd

> 
> IIRC Amit was looking at defining the hwcaps to align with arm64 compat, 
> but I believe that series faltered since most of them weren't actually 
> needed (and I think at that point it was still missing the VFP support 
> code parts). It would be nice if someone could pick up and combine both 

Were the mentioned series related to this commit?

62ea0d873af3 ARM: 9269/1: vfp: Add hwcap for FEAT_DotProd

> efforts and get this done properly; fill in *all* the hwcaps and 
> relevant handling for extensions which Cortex-A55 supports (since 
> there's definitely more than just VUDOT), and then hopefully we're done 
> for good.

Agree.

> 
> > Before this commit, kernel didn't handle the undef exception
> > caused by vudot and didn't enable VFP in lazy VFP context
> > switch code like other NEON instructions.
> > This led to the occurrence of the undefined instruction
> > error as following:
> > 
> > [  250.741238 ] 0904 (26902): undefined instruction: pc=004014ec
> > ...
> > [  250.741287 ] PC is at 0x4014ec
> > [  250.741298 ] LR is at 0xb677874f
> > [  250.741303 ] pc : [<004014ec>]    lr : [<b677874f>]    psr: 80070010
> > [  250.741309 ] sp : beffedb0  ip : b67d7864  fp : beffee58
> > [  250.741314 ] r10: 00000000  r9 : 00000000  r8 : 00000000
> > [  250.741319 ] r7 : 00000001  r6 : 00000001  r5 : beffee90  r4 : 00401470
> > [  250.741324 ] r3 : beffee20  r2 : beffee30  r1 : beffee40  r0 : 004003a8
> > [  250.741331 ] Flags: Nzcv  IRQs on  FIQs on  Mode USER_32  ISA ARM Segment user
> > [  250.741339 ] Control: 10c5383d  Table: 32d0406a  DAC: 00000055
> > [  250.741348 ] Code: f4434aef f4610aef f4622aef f4634aef (fc620df4)
> > 
> > Below is the assembly of the user program:
> > 
> > 0x4014dc <+108>: vst1.64 {d20, d21}, [r3:128]
> > 0x4014e0 <+112>: vld1.64 {d16, d17}, [r1:128]
> > 0x4014e4 <+116>: vld1.64 {d18, d19}, [r2:128]
> > 0x4014e8 <+120>: vld1.64 {d20, d21}, [r3:128] --> switch out
> > 0x4014ec <+124>: vudot.u8 q8, q9, q10         <-- switch in, and FPEXC.EN = 0
> >                                                    SIGILL(illegal instruction)
> > 
> > Link: https://services.arm.com/support/s/case/5004L00000XsOjP
> 
> Linking to your private support case is not useful to upstream. Even I 
> can't open that link.

I thought that maybe someone in arm need this.
But it seems a bit noisy so I will remove the link from v2.

> 
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > ---
> >   arch/arm/vfp/vfpmodule.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> > index 7e8773a2d99d..7eab8d1019d2 100644
> > --- a/arch/arm/vfp/vfpmodule.c
> > +++ b/arch/arm/vfp/vfpmodule.c
> > @@ -788,6 +788,12 @@ static struct undef_hook neon_support_hook[] = {{
> >   	.cpsr_mask	= PSR_T_BIT,
> >   	.cpsr_val	= 0,
> >   	.fn		= vfp_support_entry,
> > +}, {
> > +	.instr_mask	= 0xffb00000,
> > +	.instr_val	= 0xfc200000,
> > +	.cpsr_mask	= PSR_T_BIT,
> > +	.cpsr_val	= 0,
> > +	.fn		= vfp_support_entry,
> >   }, {
> >   	.instr_mask	= 0xef000000,
> >   	.instr_val	= 0xef000000,
> > @@ -800,6 +806,12 @@ static struct undef_hook neon_support_hook[] = {{
> >   	.cpsr_mask	= PSR_T_BIT,
> >   	.cpsr_val	= PSR_T_BIT,
> >   	.fn		= vfp_support_entry,
> > +}, {
> > +	.instr_mask	= 0xffb00000,
> > +	.instr_val	= 0xfc200000,
> > +	.cpsr_mask	= PSR_T_BIT,
> > +	.cpsr_val	= PSR_T_BIT,
> > +	.fn		= vfp_support_entry,
> 
> Why have two entries conditional on each possible value of one bit for 
> otherwise identical encodings? Surely it suffices to set both cpsr_mask 
> and cpsr_val to 0?

You're right.
I will set both cpsr_mask and cpsr_val to 0 and use single entry,
as you suggested, in the v2 patch.

Thanks.

> 
> Thanks,
> Robin.
> 
> >   }};
> >   
> >   static struct undef_hook vfp_support_hook = {
