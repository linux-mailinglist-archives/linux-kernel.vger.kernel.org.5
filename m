Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3697C7E32C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 03:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjKGCFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 21:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjKGCFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 21:05:21 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6751C115
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 18:05:16 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231107020511epoutp02c87cfdc06709a1d378856e08d5359da4~VNQC1zWU-1533915339epoutp02r
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:05:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231107020511epoutp02c87cfdc06709a1d378856e08d5359da4~VNQC1zWU-1533915339epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699322711;
        bh=TBL8+EFA/ZaaK31h63r/ZXqTOOqEdXbFSJSw9cNVIVg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=XbTxIL8NU9n6yj2/wPZ2f6Q+EmSmvA3fKocxJWRiYemY8chJD5oBMa1Jqcp7dU50H
         WIRzauz5Tq5W4ratroBNkBTbvngy8xrh+ybcVS2Lex22/oOXIovWNk5nF7W4cItexH
         Lt+2uaiv8dB1MH9CN5PHEeyFkTrxbsO7F7dnLIHw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231107020511epcas1p129b5e8910b71d15b254780b51500a537~VNQCY-N_L2181021810epcas1p1w;
        Tue,  7 Nov 2023 02:05:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.248]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SPWkt4jHkz4x9QK; Tue,  7 Nov
        2023 02:05:10 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.42.10025.45B99456; Tue,  7 Nov 2023 11:05:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20231107020508epcas1p3e3f47fab18e52248f64bfdde05b1e53b~VNP-96Y7T0586405864epcas1p36;
        Tue,  7 Nov 2023 02:05:08 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231107020508epsmtrp2b7d91d55d9b40193aa0ad8ad85310877~VNP-9Tzs62332523325epsmtrp2L;
        Tue,  7 Nov 2023 02:05:08 +0000 (GMT)
X-AuditID: b6c32a39-c2bf870000002729-40-65499b54bb3c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.53.18939.45B99456; Tue,  7 Nov 2023 11:05:08 +0900 (KST)
Received: from jongeonpark03 (unknown [10.253.101.166]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231107020508epsmtip12401683f6021257597dc66f70e2f7ff1~VNP-zFqrW0626206262epsmtip1G;
        Tue,  7 Nov 2023 02:05:08 +0000 (GMT)
From:   "Jong eon Park" <jongeon.park@samsung.com>
To:     "'Jakub Kicinski'" <kuba@kernel.org>,
        "'Paolo Abeni'" <pabeni@redhat.com>
Cc:     "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Dumazet'" <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Dong ha Kang'" <dongha7.kang@samsung.com>
In-Reply-To: <20231106154812.14c470c2@kernel.org>
Subject: RE: [PATCH] netlink: introduce netlink poll to resolve fast return
 issue
Date:   Tue, 7 Nov 2023 11:05:08 +0900
Message-ID: <25c501da111e$d527b010$7f771030$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJoS8HO+cSy/HZb7h5ntB8MEORIdAHf29cGAkyoXsSvMDrooA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmgW7IbM9Ug961NhZzzrewWEy/OZXZ
        4umxR+wWF7b1sVpc3jWHzeLYAjGLb6ffMDqwe2xZeZPJY8GmUo9NqzrZPN7vu8rm0bdlFaPH
        501yAWxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5
        QJcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMCvSKE3OLS/PS9fJSS6wMDQyM
        TIEKE7IzbizMLlgsXtG1bi9jA+MLoS5GDg4JAROJeVs8uxg5OYQEdjBK7FvL1cXIBWR/YpSY
        eu0AG5xzbdlUVpAqkIbmxztYIBI7GSUWtqxjgWh/wyjxZLs+iM0mYCBx7MdPRpANIgL+Erfv
        eYPUMwscYJRY8OYtWD2ngKHE23dzmEBsYYFgie0/FoLFWQRUJKY/+sMMYvMKWEp8n/WbFcIW
        lDg58wlYDbOAvMT2t3OYIQ5SkPj5dBlYjYiAk8TkBT/ZIWpEJGZ3tjGDLJYQmMoh8fHuQXaI
        BheJ2X+PQdnCEq+Ob4GypSQ+v9vLBmFnS7w4dowVEkQFElePKEGY9hLvL1mAmMwCmhLrd+lD
        FCtK7Pw9lxFiK5/Eu689UI28Eh1tQhAlahIPT76FhqCMxOoVd9kmMCrNQvLXLCR/zUJy/yyE
        ZQsYWVYxiqUWFOempxYbFpjC4zk5P3cTIzh9alnuYJz+9oPeIUYmDsZDjBIczEoivH/tPVKF
        eFMSK6tSi/Lji0pzUosPMZoCQ3ois5Rocj4wgeeVxBuaWBqYmBmZWBhbGpspifOee9ubIiSQ
        nliSmp2aWpBaBNPHxMEp1cBktWZylvJz/qMnBXf2me+tdj9u9aBv2/uNfbtclvXpZDMyCD2d
        MvlCZd4jRhNGuacfNLi8HJacUM4zsiicHLVM3u5L6ORKXm+GdWkV50oW6ctX9PNuN5CWvnD+
        5IEtRtEnEoP9fohP32tUKPuEwfjbEZaCzh/HtvxUaMvwiitsf/5I9leO2NYZv6wZNH4bvv97
        7NfHFZrJJ3LezPL4t/HOm2XiC5MZ2k7yl4mf+/VQvsv72rHEP1bL3u3uM16bVcx0MnNLwkbL
        AjG1nusfW8QO/HG0jjv9Z06mbmWkbRqTx/k0S41aRttZjuI/9wkw5ayueCt6WJbZ6P9LSZ6C
        4MoDbDv8n3FozGK69KLZ6J8SS3FGoqEWc1FxIgBWo/7NKAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTjdktmeqwe/FEhZzzrewWEy/OZXZ
        4umxR+wWF7b1sVpc3jWHzeLYAjGLb6ffMDqwe2xZeZPJY8GmUo9NqzrZPN7vu8rm0bdlFaPH
        501yAWxRXDYpqTmZZalF+nYJXBk3FmYXLBav6Fq3l7GB8YVQFyMnh4SAiUTz4x0sXYxcHEIC
        2xklHk9YzgiRkJG4vmAfUIIDyBaWOHy4GKLmFaPEwzXXWUBq2AQMJI79+AlWLyLgL9E04yMb
        SBGzwBFGicmLnzNDdGxjlJg/ZzcbSBWngKHE23dzmEBsYYFAifcbv4LFWQRUJKY/+sMMYvMK
        WEp8n/WbFcIWlDg58wnYNmYBPYn16+cwQtjyEtvfzmGGuFRB4ufTZawQVzhJTF7wkx2iRkRi
        dmcb8wRG4VlIRs1CMmoWklGzkLQsYGRZxSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iREcTVpB
        OxiXrf+rd4iRiYPxEKMEB7OSCO9fe49UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzKOZ0pQgLp
        iSWp2ampBalFMFkmDk6pBibZ5+nGrUumOMq4SaYdSMub92DtJ2W+8obbfOtv/TJd0zhr1vzP
        M89MYDYtUWCNDvsk/EelYhGDv378md2fSxJPP+DrFHIN7d18jFOvnynXMMMlvccm6E+gtOeG
        rx3tIomrisMaa+y+V+azPDjyR/X9Krm5ccx/t6gXHE76ouRy4pPAoinSM66xWvKLa4p7PNv6
        YXfBEZYdl/comeiVZJ16sT3xe1yuRLJmyYEooboPigk2sY2rTn17+9JMleHbDLOQ4jwG9b+5
        tTWWqW81WOvf7Cm88t6iP/Xqq5J9Bj+tmZdM3XPG0i572oEbK9bd6L8yg4FPY+OlCKaj+dt/
        Kl2Va94iq5AW/y9hkdI3LSWW4oxEQy3mouJEADGTrwAVAwAA
X-CMS-MailID: 20231107020508epcas1p3e3f47fab18e52248f64bfdde05b1e53b
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, November 7, 2023 8:48 AM
> To: Jong eon Park <jongeon.park@samsung.com>; Paolo Abeni
> <pabeni@redhat.com>
> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Dong ha Kang <dongha7.kang@samsung.com>
> Subject: Re: [PATCH] netlink: introduce netlink poll to resolve fast
> return issue
> 
> On Fri,  3 Nov 2023 16:22:09 +0900 Jong eon Park wrote:
> > In very rare cases, there was an issue where a user's poll function
> > waiting for a uevent would continuously return very quickly, causing
> > excessive CPU usage due to the following scenario.
> >
> > Once sk_rcvbuf becomes full netlink_broadcast_deliver returns an error
> > and netlink_overrun is called. However, if netlink_overrun was called
> > in a context just before a another context returns from the poll and
> > recv is invoked, emptying the rcvbuf, sk->sk_err = ENOBUF is written
> > to the netlink socket belatedly and it enters the NETLINK_S_CONGESTED
> state.
> > If the user does not check for POLLERR, they cannot consume and clean
> > sk_err and repeatedly enter the situation where they call poll again
> > but return immediately.
> >
> > To address this issue, I would like to introduce the following netlink
> > poll.
> >
> > After calling the datagram_poll, netlink poll checks the
> > NETLINK_S_CONGESTED status and rcv queue, and this make the user to be
> > readable once more even if the user has already emptied rcv queue.
> > This allows the user to be able to consume sk->sk_err value through
> > netlink_recvmsg, thus the situation described above can be avoided
> 
> The explanation makes sense, but I'm not able to make the jump in
> understanding how this is a netlink problem. datagram_poll() returns
> EPOLLERR because sk_err is set, what makes netlink special?
> The fact that we can have an sk_err with nothing in the recv queue?
> 
> Paolo understands this better, maybe he can weigh in tomorrow...

Perhaps my explanation was not comprehensive enough.

The issue at hand is that once it occurs, users cannot escape from this 
"busy running" situation, and the inadequate handling of EPOLLERR by users 
imposes a heavy burden on the entire system, which seems quite harsh.

The reason for a separate netlink poll is related to the netlink state. 
When it enters the NETLINK_S_CONGESTED state, sk can no longer receive or 
deliver skb, and the receive_queue must be completely emptied to clear the 
state. However, it was found that the NETLINK_S_CONGESTED state was still 
maintained even when the receive_queue was empty, which was incorrect, and 
that's why I implemented the handling in poll.

I don't consider this approach to be the best way, so if you have any 
recommendations for a better solution, I would appreciate it.

Regards.
JE Park.


