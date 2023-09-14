Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C8E79F873
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjINCtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjINCtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:49:46 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5F10C3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:49:41 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230914024938epoutp017e72ad1dfde24585f5ad9a69a826524a~EpBb0ws-e1331213312epoutp01_
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:49:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230914024938epoutp017e72ad1dfde24585f5ad9a69a826524a~EpBb0ws-e1331213312epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694659778;
        bh=r5jj0lu9AKPQ4dUW3z7RMHoNOH/8E0rIFCiEOm5ipWs=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=VijfJeHHK9y4SaPTM/KGiziiRA855ziCcAFEjKiDGWOk+U7wDxdhfnBCDcbJxlNsj
         Vu4vv1lauoL+iSOSIiYLI2ho9pptyL+Goh70saqlQVm0KoU+0DK8OumTNvHFynKeD3
         KGFUYFPXTU5hzv8racasjEJq71FR/wGziNeXFkd0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230914024937epcas1p4f2a21bad5bfca9e0b18e255b3e05ae86~EpBbWYV1J2101721017epcas1p41;
        Thu, 14 Sep 2023 02:49:37 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.247]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RmMH533hnz4x9Pr; Thu, 14 Sep
        2023 02:49:37 +0000 (GMT)
X-AuditID: b6c32a37-d85fa700000025ae-11-650274c19af9
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.C3.09646.1C472056; Thu, 14 Sep 2023 11:49:37 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] maple_tree: use GFP_KERNEL on mas_node_count
Reply-To: jason.sim@samsung.com
Sender: Jaeseon Sim <jason.sim@samsung.com>
From:   Jaeseon Sim <jason.sim@samsung.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230907144924.272e2f2sckprbvca@revolver>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230914024937epcms1p24be0b59caeefd7966bec81ac11feff8f@epcms1p2>
Date:   Thu, 14 Sep 2023 11:49:37 +0900
X-CMS-MailID: 20230914024937epcms1p24be0b59caeefd7966bec81ac11feff8f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmvu7BEqZUg67lYhbdm2cyWvS+f8Vk
        sb3hAbvF5V1z2CzurfnParFhZQOTxeRLC9gsfv8Aij3985fZgdPj34k1bB47Z91l91iwqdRj
        8wotj02fJrF7bF5S7/Hx6S0Wj74tqxg9Pm+SC+CMyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
        NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpQSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKr
        lFqQklNgVqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcXrFOdaCU5IV/Sc72RoYL0t0MXJySAiY
        SCyZd4Gli5GLQ0hgB6NEY8sR9i5GDg5eAUGJvzuEQWqEBRwlerdPYgOxhQTkJc5uaWCEiGtL
        nFp5kRnEZhPQlOi6sIUdxBYR0Jc4d+8cM8hMZoFuZolT2yCKJAR4JWa0P2WBsKUlti/fCjaI
        U8Bc4tavW+wQcVGJm6vfwtnvj81nhLBFJFrvnYWaIyjx4OduqLiUxJm2JVAziyXWr7nOBGHX
        SBx9sh8qbi7R8HYl2AO8Ar4S6yZeAJvDIqAqsXkezC4XiesbTrCC2MxAjy1b+JoZFA7MQI+t
        36UPUaIosfP3XEaIEj6Jd197WGHe2jHvCdRaZYmP3y4wgrRKCEhKTNhlDmF6SHT8NoGE8kRg
        iNx4xz6BUWEWIqBnIdk7C2HvAkbmVYxiqQXFuempxYYFxvC4Tc7P3cQITqta5jsYp739oHeI
        kYmD8RCjBAezkggvmy1TqhBvSmJlVWpRfnxRaU5q8SFGU6CPJzJLiSbnAxN7Xkm8oYmlgYmZ
        kYmFsaWxmZI4761nvSlCAumJJanZqakFqUUwfUwcnFINTJ6WNlcXFhxe25MgblGX53Ar8xXD
        vvOzZp//ukc2z804vXTtOYe1QYfmPub5Fee0s/Le6eU6V5yC9/YeXmi9/Ip65gSZbA4RmaYP
        77Otv6/Wvnb01both96oZobw/+VZ+ltjreN6vhVTtn7wkNnU9PD23YqEn+/MomS2Ma/QFNy8
        IGf1TGn2xyvYDP/uFHjo73HiLs/MFQKnGn6qvikwdLUKryw/u3OvrHZNJ9utxRoSW3XvrLmV
        02/vXRb7fkd30gFW41+TTzOVn9oXvbr+yjvNd1/8l6RsqJy4dX/spectfTEaJ8uvKNVnppQs
        XckhyMDHL/9C4PYGi8DUxfFcDhNvhyne1GFeXPwwwTfZU1WJpTgj0VCLuag4EQBgeFxSNAQA
        AA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3
References: <20230907144924.272e2f2sckprbvca@revolver>
        <ZPlNPGpAPy+7oQay@casper.infradead.org>
        <20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p6>
        <ZPlIShWJWt+Kxt8x@casper.infradead.org>
        <06a8624e-00bb-a332-4271-860847faf4a3@bytedance.com>
        <20230907044119epcms1p3ff1dd04b02119ff11b77fe40b4842afd@epcms1p3>
        <CGME20230907033914epcms1p61c5eed4d34d5c4212436c201f33292b3@epcms1p2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> * Jaeseon Sim <jason.sim=40samsung.com> =5B230907 00:41=5D:
> > > On Thu, Sep 07, 2023 at 12:02:02PM +0800, Peng Zhang wrote:
> > > >=20
> > > >=20
> > > > =E5=9C=A8=202023/9/7=2011:49,=20Matthew=20Wilcox=20=E5=86=99=E9=81=
=93:=0D=0A>=20>=20>=20>=20>=20On=20Thu,=20Sep=2007,=202023=20at=2012:39:14P=
M=20+0900,=20=EC=8B=AC=EC=9E=AC=EC=84=A0=20wrote:=0D=0A>=20>=20>=20>=20>=20=
>=20Use=20GFP_KERNEL=20on=20mas_node_count=20instead=20of=20GFP_NOWAIT=20=
=7C=20__GFP_NOWARN=0D=0A>=20>=20>=20>=20>=20>=20in=20order=20to=20allow=20m=
emory=20reclaim.=0D=0A>=20>=20>=20>=20There=20are=20many=20paths=20that=20c=
all=20maple=20tree's=20mas_node_count().=20Some=20paths=0D=0A>=20>=20>=20>=
=20cannot=20reclaim=20memory.=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20Right=20..=
.=20but=20we=20should=20be=20handling=20the=20ENOMEM=20inside=20the=20maple=
=20tree=20and=0D=0A>=20>=20>=20allocating=20some=20nodes=20with=20GFP_KERNE=
L=20instead=20of=20failing=20fork().=0D=0A>=20>=20>=20=0D=0A>=20>=20>=20>=
=20>=20What=20testing=20did=20you=20do=20of=20this=20patch?=20=20In=20parti=
cular,=20did=20you=20try=20it=0D=0A>=20>=20>=20>=20>=20with=20lockdep=20ena=
bled?=0D=0A>=20>=20I=20did=20power=20on/off=20test=20with=20this=20patch.=
=0D=0A>=20>=20I=20did=20not=20try=20it=20with=20lockdep=20enabled.=0D=0A>=
=20=0D=0A>=20To=20accomplish=20the=20same=20result,=20but=20with=20a=20much=
=20smaller=20scope=20that=20will=0D=0A>=20work=20with=20lockdep,=20I=20woul=
d=20suggest=20changing=20mas_expected_entries()=20to=0D=0A>=20use=20mas_nod=
e_count_gfp()=20(which=20already=20exists)=20and=20pass=20in=20GFP_KERNEL.=
=0D=0A>=20=0D=0A>=20Since=20fork=20is=20the=20only=20current=20user=20of=20=
mas_expected_entries(),=20this=0D=0A>=20won't=20break=20other=20users=20and=
=20we=20can=20deal=20with=20changing=20it=20for=20others=20if=0D=0A>=20it=
=20is=20needed.=0D=0A>=20=0D=0A>=20If=20we=20do=20go=20this=20route,=20plea=
se=20add=20a=20note=20in=20the=20documentation=20about=0D=0A>=20using=20GFP=
_KERNEL.=0D=0A>=20=0D=0A>=20Willy,=20does=20that=20work=20for=20you?=0D=0A>=
=20=0D=0A>=20Thanks,=0D=0A>=20Liam=0D=0A=0D=0ADear=20Liam,=0D=0ACan=20I=20a=
sk=20you=20the=20reason=20why=20mas_node_count=20is=20using=20GFP_NOWAIT=20=
=7C=20__GFP_NOWARN?=0D=0AI=20wonder=20if=20other=20callers=20for=20mas_node=
_count=20might=20have=20similar=20issue.=0D=0A=0D=0AFrom=20your=20opinion,=
=20I'll=20post=20v2=20patch=20as=20follows=0D=0A=0D=0Adiff=20--git=20a/lib/=
maple_tree.c=20b/lib/maple_tree.c=0D=0Aindex=20ee1ff0c59fd7..b0229271c24e=
=20100644=0D=0A---=20a/lib/maple_tree.c=0D=0A+++=20b/lib/maple_tree.c=0D=0A=
=40=40=20-5574,7=20+5574,7=20=40=40=20int=20mas_expected_entries(struct=20m=
a_state=20*mas,=20unsigned=20long=20nr_entries)=0D=0A=20=09/*=20Internal=20=
nodes=20*/=0D=0A=20=09nr_nodes=20+=3D=20DIV_ROUND_UP(nr_nodes,=20nonleaf_ca=
p);=0D=0A=20=09/*=20Add=20working=20room=20for=20split=20(2=20nodes)=20+=20=
new=20parents=20*/=0D=0A-=09mas_node_count(mas,=20nr_nodes=20+=203);=0D=0A+=
=09mas_node_count_gfp(mas,=20nr_nodes=20+=203,=20GFP_KERNEL);=0D=0A=20=0D=
=0A=20=09/*=20Detect=20if=20allocations=20run=20out=20*/=0D=0A=20=09mas->ma=
s_flags=20=7C=3D=20MA_STATE_PREALLOC;=0D=0A--=20=0D=0A2.17.1=0D=0A=0D=0ATha=
nks=0D=0AJaeseon
