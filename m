Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF27E95BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjKMDuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjKMDuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:50:20 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3D7111
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:50:14 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231113035010epoutp0408115bc6577ab099a1e1556256f27eef~XEja7fDDB3084930849epoutp04T
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:50:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231113035010epoutp0408115bc6577ab099a1e1556256f27eef~XEja7fDDB3084930849epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699847410;
        bh=K/SRvaHr2etDt+D7s7OyZDI+2nNmv+JzThALR5+aLzA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=UA61zY8Vs+KjLA//ahMa1YGiIuArquNrTIizLv4O/HYVlDTEIqQGYxKbuD+NDCmNk
         MVZhvs2hIsLRzN2Gc23lJZ1odEKRCyJ0MY8Jp+U5rq2DI7/mMqrQ1i0/EASw86Ko2t
         2LJqHmSgnElPcMfs+49TFmYQL4RkPTf+a66ZFs+Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231113035010epcas1p12f30a5492d79468a57bdddd4862bea85~XEjalhdC20099300993epcas1p1u;
        Mon, 13 Nov 2023 03:50:10 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.250]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4STFnF5xZqz4x9Q1; Mon, 13 Nov
        2023 03:50:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.AA.09731.1FC91556; Mon, 13 Nov 2023 12:50:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20231113035009epcas1p31f0e0ce293e8be86de521a8f99b82d3b~XEjZ6RJ941020310203epcas1p3L;
        Mon, 13 Nov 2023 03:50:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231113035009epsmtrp28db343bf25a1835e0be12e55bdcfc81f~XEjZ5oVeW0273602736epsmtrp2P;
        Mon, 13 Nov 2023 03:50:09 +0000 (GMT)
X-AuditID: b6c32a36-a7dff70000002603-e5-65519cf190e9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.DF.07368.1FC91556; Mon, 13 Nov 2023 12:50:09 +0900 (KST)
Received: from jongeonpark03 (unknown [10.253.101.166]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231113035009epsmtip25c31b90c5345f1c0dd516e752adb7878~XEjZv3qh02252222522epsmtip2t;
        Mon, 13 Nov 2023 03:50:09 +0000 (GMT)
From:   "Jong eon Park" <jongeon.park@samsung.com>
To:     "'Jakub Kicinski'" <kuba@kernel.org>
Cc:     "'Paolo Abeni'" <pabeni@redhat.com>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Dumazet'" <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Dong ha Kang'" <dongha7.kang@samsung.com>
In-Reply-To: <20231110110002.7279f895@kernel.org>
Subject: RE: [PATCH] netlink: introduce netlink poll to resolve fast return
 issue
Date:   Mon, 13 Nov 2023 12:50:09 +0900
Message-ID: <000001da15e4$7f5a6bd0$7e0f4370$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJoS8HO+cSy/HZb7h5ntB8MEORIdAHf29cGAkyoXsQBixSniALjIF5OAiFwHxEBTj42xq762NKQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmge7HOYGpBlce61nMOd/CYjH95lRm
        i6fHHrFbXNjWx2pxedccNotjC8Qsvp1+w+jA7rFl5U0mjwWbSj02repk83i/7yqbR9+WVYwe
        nzfJBbBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXm
        AF2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwK9ArTswtLs1L18tLLbEyNDAw
        MgUqTMjOWNz0hangBVNFU3MPYwPjTKYuRk4OCQETiT1H+ti6GLk4hAR2MEo83reFHcL5xCgx
        ceksZgjnG6PE/h9tbDAtK6evgGrZyyhxY85nqJY3jBJ/TvSyg1SxCRhIHPvxkxHEFhHQkNg3
        ax4jSBGzwHNGic0Nk5lBEpwChhI3zzwAaxAWCJbY/mMhC4jNIqAq0X7mIdg6XgFLiZnPnkDZ
        ghInZz4Bq2EWkJfY/nYOM8RJChI/ny5j7WLkAFoWJbFvpQtEiYjE7M42sBckBKZySNybexXq
        BReJA6euQ0NAWOLV8S3sELaUxOd3e6FqsiVeHDsGNlNCoEDi6hElCNNe4v0lCxCTWUBTYv0u
        fYhiRYmdv+cyQmzlk3j3tQeqkVeio00IokRN4uHJt6wQtozE6hV32SYwKs1C8tYsJG/NQnL/
        LIRlCxhZVjGKpRYU56anFhsWGMHjOjk/dxMjOI1qme1gnPT2g94hRiYOxkOMEhzMSiK8eZoB
        qUK8KYmVValF+fFFpTmpxYcYTYEBPZFZSjQ5H5jI80riDU0sDUzMjEwsjC2NzZTEeec87k0R
        EkhPLEnNTk0tSC2C6WPi4JRqYGoxWTHpgYQ3yztez6uu83vF/doWCrQ+UNzgV2e+1LbQem7P
        2urX/KHmh83rg5+cEc9+cCelqtza/+GPXQJXefInPK3sCS3d/avG3yNc9WP9oXuqP/R2eUTN
        Ej0kecxL7/i7efFh08NmBRjKlLlXu/5/utqJ7WjtIoZ3h/3PCAZ/Vb0qIbH3zwzPOV2Kp2vu
        3VnIelZ5w9ykQikZVd48/rbj09qUX+k6r6l02xS4OfOcwylpDsdEx+xGG7vlK793+HGoR266
        WDfzJ0vpEyPlFauut/jnCxyu3PF027zAjmVrF8SlCgqY564RWXjgla585cWi3+HHnrY+XPFS
        /FmKnXul3q6fQiys/jG//rv1KrEUZyQaajEXFScCAEgcRh4sBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXvfjnMBUg313pS3mnG9hsZh+cyqz
        xdNjj9gtLmzrY7W4vGsOm8WxBWIW306/YXRg99iy8iaTx4JNpR6bVnWyebzfd5XNo2/LKkaP
        z5vkAtiiuGxSUnMyy1KL9O0SuDIWN31hKnjBVNHU3MPYwDiTqYuRk0NCwERi5fQVbF2MXBxC
        ArsZJe7MncIMkZCRuL5gH0sXIweQLSxx+HAxRM0rRom9ez6wgdSwCRhIHPvxkxHEFhHQkNg3
        ax6YzSzwmlHi0CcFiIY7TBIXTvSDDeUUMJS4eeYBO4gtLBAo8X7jV7BBLAKqEu1nHoLZvAKW
        EjOfPYGyBSVOznwCdgSzgJ5E20ao+fIS29/OgbpTQeLn02WsICUiAlES+1a6QJSISMzubGOe
        wCg8C8mgWQiDZiEZNAtJxwJGllWMkqkFxbnpucmGBYZ5qeV6xYm5xaV56XrJ+bmbGMHxpKWx
        g/He/H96hxiZOBgPMUpwMCuJ8OZpBqQK8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9
        sSQ1OzW1ILUIJsvEwSnVwCQVe3gab5keS1J7xeTa3bltPAe2NtspO9Qf5+R8/OON30mL2t8H
        9iVVTfCxEFkZW/zHs+j9isC0d5r5/+b3p72t3urlebK6PvgQ9ycb5u+us2f9255Zvoh9QZvX
        sbQ9sfytX6UsOdJcvGq4wr0d355ce0K2lnt1T2KsZzWPTu27y9n/zBMKM+0/PGn9IPu9cKnC
        HYUbK1aZzDw4/TIbg9KOY54Ml12cDjDUFPG+1F/2ufPcAWWX6fFRpRk/jS+7dgQtztoj+O4j
        66EFk9d8udgQNYOhQaW85dm5DsMpAoZe/b/XliWKXjQQkLvxYcUFZebLhRz8tRr3uA8m3LVW
        nMOtrOv50+d3rVG77DZ/JZbijERDLeai4kQARTTVQRYDAAA=
X-CMS-MailID: 20231113035009epcas1p31f0e0ce293e8be86de521a8f99b82d3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231103072245epcas1p4471a31e9f579e38501c8c856d3ca2a77
References: <CGME20231103072245epcas1p4471a31e9f579e38501c8c856d3ca2a77@epcas1p4.samsung.com>
        <20231103072209.1005409-1-jongeon.park@samsung.com>
        <20231106154812.14c470c2@kernel.org>
        <25c501da111e$d527b010$7f771030$@samsung.com>
        <20231107085347.75bc3802@kernel.org>
        <000001da13e5$d9b99e30$8d2cda90$@samsung.com>
        <20231110110002.7279f895@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, November 11, 2023 4:00 AM, Jakub Kicinski wrote:
> 
> I see, please add a comment saying that NETLINK_S_CONGESTED prevents
> new skbs from being queued before the new test in netlink_poll().
> 
> Please repost next week (i.e. after the merge window) with subject
> tagged [PATCH net-next v2].

Got it. Thanks Jakub.

BRs,
JE Park.


