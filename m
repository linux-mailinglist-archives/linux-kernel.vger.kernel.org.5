Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDED275DC68
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGVMOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGVMOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:14:15 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFD09B;
        Sat, 22 Jul 2023 05:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690028033; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=K9sEHU0nSLpZWOtlzt7nIwZkjo+ZUtg78DQ/J4Yvi1oWAF6zUNIVnrePOCeid8205wlTCAvuMFQpdmN9dGgqaRpA7+JtelbeHK5jLr6tdaZIrugwvWBWEJuHxL4B8cY2s4LDPU5w/b09PYsRXwNXEUeY2Qyq3P151V3NyyVznhQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1690028033; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/q5vPysvgwOOLB/JiDSQP3eCYUz8RtczsHjvgeJg1Gk=; 
        b=NqlQ4pNMTfCJryi0iHfTEu26624SDvrEBlEzAgkVxRvRNGyIN2C2M7QyBA5HRMEiAInmnOLXehEd8QYRHWyMCPUwZfgPL+NVU2dbqi2CRFFoEbazHbARx0eCuYorCv86YeKJj2XiaxmFr/mucSGvn5SA06aal3skpuR5BYCwre4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1690028033;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=/q5vPysvgwOOLB/JiDSQP3eCYUz8RtczsHjvgeJg1Gk=;
        b=APWVV1qoE4xWaSouk8cls37oMN6w/9JdpLHTEFaWangCnhDpkFSo1uUGxs/P/F2j
        a0Oh5SgwYVvRcWeHgZvSTCoxeHf/6Bxx/iQnLPO4Ur/JaDP8rOCpXmtjajkNPn9yNre
        djLfjJUmLHWqSrqrFZcPiJ+4O6jkOzMAjyctQHynimWoAsULuj288qDmpjeco4pTlaX
        egrpK2+0KvycN9jDJ1Qf8qWUBfXbea1zw6lwKxqZ1v8/qkPsYk+vLjU9kR9mondBRYl
        O4M3Mf9R6+eELzTC3U0wWneA2hRAyruPPQNNV8PSMCvNWwbvbCXtwL9cCZabWbZj9zY
        qsa7kpGdCA==
Received: from edelgard.fodlan.icenowy.me (120.85.97.227 [120.85.97.227]) by mx.zohomail.com
        with SMTPS id 1690028030544550.8527003226176; Sat, 22 Jul 2023 05:13:50 -0700 (PDT)
Message-ID: <05e6d2d6dd8805c4cded28f85ac873b96bc1467e.camel@icenowy.me>
Subject: Re: [PATCH 0/2] thermal/drivers/mediatek: fix a regression
 affecting other subsystems
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kang Chen <void0red@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Sat, 22 Jul 2023 20:13:45 +0800
In-Reply-To: <40546a57-27ac-8bf9-a2d8-77f7d4ab4aad@linaro.org>
References: <20230529162056.3786301-1-uwu@icenowy.me>
         <40546a57-27ac-8bf9-a2d8-77f7d4ab4aad@linaro.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-06-13=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 10:44 +0200=EF=BC=
=8CDaniel Lezcano=E5=86=99=E9=81=93=EF=BC=9A
> On 29/05/2023 18:20, Icenowy Zheng wrote:
> > In the commit I reverted as the first commit of this patchset, the
> > of_iomap function call, which allows multiple mapping of the same
> > physical memory space, is replaced to calling devm_of_iomap, which
> > registers exclusivity, and on my system (mt8173-elm), preventing
> > display
> > from working.
> >=20
> > So I reverted it, and to really solve the problem that the original
> > commit wants to solve, I read the source of auxadc-thermal and
> > realized
> > that the address of these two memory blocks are not saved after
> > probe,
> > and they're only used when initializing the thermal sensors. This
> > leads
> > to my final fix, which is the second commit here, that adds
> > of_iounmap
> > just to the probe function.
> >=20
> > Icenowy Zheng (2):
> > =C2=A0=C2=A0 Revert "thermal/drivers/mediatek: Use devm_of_iomap to avo=
id
> > resource
> > =C2=A0=C2=A0=C2=A0=C2=A0 leak in mtk_thermal_probe"
> > =C2=A0=C2=A0 thermal/drivers/mediatek: unmap foreign MMIO after probing
> >=20
> > =C2=A0 drivers/thermal/mediatek/auxadc_thermal.c | 46 ++++++++++++-----=
-
> > -----
> > =C2=A0 1 file changed, 24 insertions(+), 22 deletions(-)
>=20
> I'll apply only the revert and let you revisit the patch 2 which
> could=20
> be improved.

Sorry, is the first patch applied? I didn't see it in any kernel
trees...

I have no current idea about how to fix in patch 2.

>=20

