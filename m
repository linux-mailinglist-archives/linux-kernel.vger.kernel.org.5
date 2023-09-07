Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEC6796FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 06:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbjIGElj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 00:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbjIGElg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 00:41:36 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2889C1BDF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 21:41:24 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230907044120epoutp0319ef820c7a7da01e9c90a2b937590729~ChB98L0Iv0110601106epoutp03G
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 04:41:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230907044120epoutp0319ef820c7a7da01e9c90a2b937590729~ChB98L0Iv0110601106epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694061680;
        bh=Eq3aD04zH4Q6fDKq/qjMHfmEleavMO89GLo6g1kQJic=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=bPhZ/2ptCo67AB1BUvC4vDWR9E7wEdrFrnl4XJvsD9Np1xxW3OpaZ5zljFcWuJJz5
         fdScJoiTk9JisfLV5RXTmUZpejg/lcdbJ+V0ltTpPhoLwMGsLoVFQz0wFzjrsw/tGv
         K8Iwbm25T57knQDukzl6kWCfbSVkKxIQu3MQtr1E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230907044120epcas1p1f0e5f63fd8af6fbec9d65f8d3d15c132~ChB9Y7cGs1985719857epcas1p1F;
        Thu,  7 Sep 2023 04:41:20 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.225]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rh65C6ZbYz4x9QJ; Thu,  7 Sep
        2023 04:41:19 +0000 (GMT)
X-AuditID: b6c32a37-39cc9a80000025ae-19-64f9546f6dd5
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.4D.09646.F6459F46; Thu,  7 Sep 2023 13:41:19 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] maple_tree: use GFP_KERNEL on mas_node_count
Reply-To: jason.sim@samsung.com
Sender: Jaeseon Sim <jason.sim@samsung.com>
From:   Jaeseon Sim <jason.sim@samsung.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>
CC:     "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZPlNPGpAPy+7oQay@casper.infradead.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230907044119epcms1p3ff1dd04b02119ff11b77fe40b4842afd@epcms1p3>
Date:   Thu, 07 Sep 2023 13:41:19 +0900
X-CMS-MailID: 20230907044119epcms1p3ff1dd04b02119ff11b77fe40b4842afd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmgW5+yM8Ug9/njS26N89ktNje8IDd
        4vKuOWwW99b8Z7XYsLKByWLypQVsFr9/AMWe/vnL7MDh8e/EGjaPnbPusnss2FTqsXmFlsem
        T5PYPTYvqff4+PQWi8fnTXIBHFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZK
        CnmJuam2Si4+AbpumTlAdykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswK9IoT
        c4tL89L18lJLrAwNDIxMgQoTsjM+TL3GUvCAo+Lh2d2sDYzrOboYOTkkBEwkljx/z9bFyMUh
        JLCDUeL0vy9MXYwcHLwCghJ/dwiD1AgLOEr0bp/EBmILCchLnN3SwAgR15Y4tfIiM4jNJqAp
        0XVhCzuILSIQLHFl6mKwmcwCJ5gkbvZdZoFYxisxo/0plC0tsX35VrBBnEBHfLq5lhEiLipx
        c/Vbdhj7/bH5UHERidZ7Z5khbEGJBz93Q8WlJM60LYGaWSyxfs11Jgi7RuLok/1QcXOJhrcr
        wR7gFfCVaG79DTafRUBV4sb3P1AzXSTenXrGCmIzAz22bOFrZlA4MAM9tn6XPkSJosTO33MZ
        IUr4JN597WGFeWvHvCdQa5UlPn67wAjSKiEgKTFhlzmE6SHR8dsEEsoLmCTufetjn8CoMAsR
        0LOQ7J2FsHcBI/MqRrHUguLc9NRiwwJjeNwm5+duYgSnUC3zHYzT3n7QO8TIxMF4iFGCg1lJ
        hPed/LcUId6UxMqq1KL8+KLSnNTiQ4ymQB9PZJYSTc4HJvG8knhDE0sDEzMjEwtjS2MzJXHe
        W896U4QE0hNLUrNTUwtSi2D6mDg4pRqYGJRMJ2b+6j+iIZK7pfImp1WdWerWzf9+Ck3+8cnz
        569c83qJ8n+bnNTEz743U58d1RkXvO7wZMdDZ+QPTej+xlN6w3n51JaJs/R/bjreVxtcZXva
        WvvSDuWSsFz95hX3m4SMe17c1PwhnmQl903n+6G+o65/y8TspNul0hd+eLWowuPCbOUzXb1G
        F/Z9fvGQaf2HcpuCetNnXuIlu0MPtv+buNpowsOA/XKTmSrOee6d8LJRVsNg/u3f8SazpN8r
        MEy+4b5S6WLapoaZ/LdK1Fwy89p1cjb93rlrwoxNjiFshXcVD0Rcm3JjfXh9TvnR+PXT56wL
        WfKt6EC3TNnb6FpXltuT/36fv+xlgFjvKiWW4oxEQy3mouJEAMNN+NIqBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3
References: <ZPlNPGpAPy+7oQay@casper.infradead.org>
        <20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
        <ZPlIShWJWt+Kxt8x@casper.infradead.org>
        <06a8624e-00bb-a332-4271-860847faf4a3@bytedance.com>
        <CGME20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Sep 07, 2023 at 12:02:02PM +0800, Peng Zhang wrote:
> >=20
> >=20
> > =E5=9C=A8=202023/9/7=2011:49,=20Matthew=20Wilcox=20=E5=86=99=E9=81=93:=
=0D=0A>=20>=20>=20On=20Thu,=20Sep=2007,=202023=20at=2012:39:14PM=20+0900,=
=20=EC=8B=AC=EC=9E=AC=EC=84=A0=20wrote:=0D=0A>=20>=20>=20>=20Use=20GFP_KERN=
EL=20on=20mas_node_count=20instead=20of=20GFP_NOWAIT=20=7C=20__GFP_NOWARN=
=0D=0A>=20>=20>=20>=20in=20order=20to=20allow=20memory=20reclaim.=0D=0A>=20=
>=20There=20are=20many=20paths=20that=20call=20maple=20tree's=20mas_node_co=
unt().=20Some=20paths=0D=0A>=20>=20cannot=20reclaim=20memory.=0D=0A>=20=0D=
=0A>=20Right=20...=20but=20we=20should=20be=20handling=20the=20ENOMEM=20ins=
ide=20the=20maple=20tree=20and=0D=0A>=20allocating=20some=20nodes=20with=20=
GFP_KERNEL=20instead=20of=20failing=20fork().=0D=0A>=20=0D=0A>=20>=20>=20Wh=
at=20testing=20did=20you=20do=20of=20this=20patch?=20=20In=20particular,=20=
did=20you=20try=20it=0D=0A>=20>=20>=20with=20lockdep=20enabled?=0D=0AI=20di=
d=20power=20on/off=20test=20with=20this=20patch.=0D=0AI=20did=20not=20try=
=20it=20with=20lockdep=20enabled.
