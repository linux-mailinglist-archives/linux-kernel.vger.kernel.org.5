Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BB7E84A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbjKJUvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjKJUvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:51:38 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24BA3A203
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:54:55 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231110145450epoutp033330a1e0b675dcf6af7365c50c5daae8~WSr5Lv-7Y2255422554epoutp03f
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 14:54:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231110145450epoutp033330a1e0b675dcf6af7365c50c5daae8~WSr5Lv-7Y2255422554epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699628090;
        bh=yaxyezZ4yKiM0TbBpnaDlCvTUlDcM3TeSUozhx47FaY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=OqJQvu1fm+c0plV9cgFk42mDT8EadPr6lGmVrWNN3DpZ2IyDMPq0skFuQlt/5iTV9
         prMCn9ihSpQlXJ9+e73UdBDN5ug+/aNk4V80ImUS5JZpnkqc4PUuLfR57ps80lx92x
         YhO+1SwJODgEhYv0+oeWG7sKCeG+CAPAdArZxxW4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231110145449epcas1p175b38df7f1ec00914982e7d9ac9062b8~WSr4DeWui2963529635epcas1p1N;
        Fri, 10 Nov 2023 14:54:49 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.225]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SRhgX6MNcz4x9Pt; Fri, 10 Nov
        2023 14:54:48 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.4F.09739.8344E456; Fri, 10 Nov 2023 23:54:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231110145448epcas1p2284021ecad63293509006be40343f94b~WSr3GwPaD1409414094epcas1p2q;
        Fri, 10 Nov 2023 14:54:48 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231110145448epsmtrp1f60c664cb83ab092cf1dcc8c05c316c2~WSr3GKVpo1915419154epsmtrp1b;
        Fri, 10 Nov 2023 14:54:48 +0000 (GMT)
X-AuditID: b6c32a37-c0bff7000000260b-ca-654e44383cec
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.8C.07368.8344E456; Fri, 10 Nov 2023 23:54:48 +0900 (KST)
Received: from jongeonpark03 (unknown [10.253.101.166]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231110145448epsmtip2ea6de2413869b56a1a9eeff557328541~WSr26GLXP1057810578epsmtip2V;
        Fri, 10 Nov 2023 14:54:48 +0000 (GMT)
From:   "Jong eon Park" <jongeon.park@samsung.com>
To:     "'Jakub Kicinski'" <kuba@kernel.org>
Cc:     "'Paolo Abeni'" <pabeni@redhat.com>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Dumazet'" <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Dong ha Kang'" <dongha7.kang@samsung.com>
In-Reply-To: <20231107085347.75bc3802@kernel.org>
Subject: RE: [PATCH] netlink: introduce netlink poll to resolve fast return
 issue
Date:   Fri, 10 Nov 2023 23:54:48 +0900
Message-ID: <000001da13e5$d9b99e30$8d2cda90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJoS8HO+cSy/HZb7h5ntB8MEORIdAHf29cGAkyoXsQBixSniALjIF5OrxJU4OA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmvq6Fi1+qQfNeXYs551tYLKbfnMps
        8fTYI3aLC9v6WC0u75rDZnFsgZjFt9NvGB3YPbasvMnksWBTqcemVZ1sHu/3XWXz6NuyitHj
        8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wc
        oEuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQVmBXrFibnFpXnpenmpJVaGBgZG
        pkCFCdkZ365PZi54Jl7xYPpixgbGTfxdjBwcEgImEmt/+nUxcnEICexglOg7/IkJwvnEKHFn
        8W1GCOcbo0TriSagDCdYx5QfO9khEnsZJZb8fgTlvGGUePBnGyNIFZuAgcSxHz/BbBEBDYl9
        s+aBjWIWeM4osblhMjNIglPAUOLm6/1gtrBAsMT2HwtZQI5iEVCVOLCpDCTMK2ApsXnPUmYI
        W1Di5MwnLCA2s4C8xPa3c5ghLlKQ+Pl0GSvELj+JR8e6mCFqRCRmd7Yxg+yVEJjLIfF44yk2
        iAYXiZ1/5kPZwhKvjm9hh7ClJF72t0HZ2RIvjh1jhQRSgcTVI0oQpr3E+0sWICazgKbE+l36
        EMWKEjt/z2WE2Mon8e5rD1Qjr0RHmxBEiZrEw5NvWSFsGYnVK+6yTWBUmoXkr1lI/pqF5P5Z
        CMsWMLKsYhRLLSjOTU8tNiwwhkd1cn7uJkZwEtUy38E47e0HvUOMTByMhxglOJiVRHgvmPik
        CvGmJFZWpRblxxeV5qQWH2I0BQb0RGYp0eR8YBrPK4k3NLE0MDEzMrEwtjQ2UxLnvfWsN0VI
        ID2xJDU7NbUgtQimj4mDU6qB6c7kHo1jngmbn73hYQrnaij7r/g5lv9OGIfcrNAfLd9kuATM
        F8916mCIO+DI9YNrFd/BTaX/Ctk4b371ULq64ml3rFz7o4uyMgFrBGrS6rh874rMWzvbS1Ou
        rSv+vugjw1SR81xHi51dP17+8vWy40bNC8e2fDLOO3imrcxGM+jN04dNK6vW7U5Nr/r27tYq
        nQe8Wt4rP5/ceGG1nlJYhGn6sQXTBex+K915ueaCztWoTbe/WD1JVbOe3GcnaML6K6qWb+E1
        0Q3N5uct0g2ORqcXlh29s09Az4KreKcIX9h65WBlm5719scbk3LrFs/eFq9Xutzi1mQ77y/a
        AnbJrn21R/hO3tjdd+QEx1opJZbijERDLeai4kQAO/ddYisEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXtfCxS/V4Nc6Pos551tYLKbfnMps
        8fTYI3aLC9v6WC0u75rDZnFsgZjFt9NvGB3YPbasvMnksWBTqcemVZ1sHu/3XWXz6NuyitHj
        8ya5ALYoLpuU1JzMstQifbsEroxv1yczFzwTr3gwfTFjA+Mm/i5GTg4JAROJKT92sncxcnEI
        CexmlPh1socNIiEjcX3BPpYuRg4gW1ji8OFiiJpXjBIn1+1iBalhEzCQOPbjJyOILSKgIbFv
        1jwwm1ngNaPEoU8KEA2dTBIvL05hAUlwChhK3Hy9nxnEFhYIlHi/8SsbyAIWAVWJA5vKQMK8
        ApYSm/csZYawBSVOznwCdgOzgJ5E20ao8fIS29/OYYY4U0Hi59NlrBAn+Ek8OtbFDFEjIjG7
        s415AqPwLCSTZiFMmoVk0iwkHQsYWVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgTH
        k5bGDsZ78//pHWJk4mA8xCjBwawkwnvBxCdViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkp
        QgLpiSWp2ampBalFMFkmDk6pBqYT/z4Fd099Nzvb3GfjwvgvftO4ypuYV/Fw9zl/nHJ5XfmL
        eNF52xL5Pu3g25giXHDqyF/XZdqJS5tuCAuLSc+ZXeD0K/p5Rc66HYISLTFhb382nzd3uFQf
        L7nZ6rfSDjvxk9xfPjCfTlj9+eW2s7wytbtCNkVqb5260/bqq8bIroxZOVFvZF3Cl21QXay6
        /vl/Xv37ogK8e+s9i/9Oz2L+b5Z+SynlLftdFrWbDByPCnfUTL48QcnIavdj3hPzOhd0vVzN
        sbjE6c/Vycc3/bivsvT1nq51AhsnPH/VbbFIjr3x1gFF0dci3OyzGf8LPvPUrdo5wfCq3pIt
        Kxt9vjxt5F86/1CubM3UP7L3f183VWIpzkg01GIuKk4EAP0MuJ0WAwAA
X-CMS-MailID: 20231110145448epcas1p2284021ecad63293509006be40343f94b
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, Nov 7, 2023 at 08:48 Jakub Kicinski wrote:
> Why does the wake up happen in the first place?
> I don't see anything special in the netlink code, so I'm assuming it's
> because datagram_poll() returns EPOLLERR.
> 
> The man page says:
> 
>        EPOLLERR
>               Error condition happened on the associated file
>               descriptor.  This event is also reported for the write end
>               of a pipe when the read end has been closed.
> 
>               epoll_wait(2) will always report for this event; it is not
>               necessary to set it in events when calling epoll_ctl().
> 
> To me that sounds like EPOLLERR is always implicitly enabled, and should
> be handled by the application. IOW it's an pure application bug.
> 
> Are you aware of any precedent for sockets adding in EPOLLOUT when
> EPOLLERR is set?

In my case, the first wake-up was by POLLIN, not POLLERR.
Please consider the below scenario.

------------CPU1 (kernel)----------  --------------CPU2 (app)--------------
...
a driver delivers uevent.              poll was waiting for schedule.
a driver delivers uevent.
a driver delivers uevent.
...
1) netlink_broadcast_deliver fails.
(sk_rmem_alloc > sk_rcvbuf)
                                            getting schedule and poll
returns,
                                            and the app calls recv.
                                            (rcv queue is empied)
                                            2)

netlink_overrun is called.
(NETLINK_S_CONGESTED flag is set,
ENOBUF is written in sk_err and,
wake up poll.)
                                            finishing its job and call poll
again.
                                            poll returns POLLERR.

                                            (the app doesn't have POLLERR
handler,)
                                            it calls poll, but getting
POLLERR.
                                            it calls poll, but getting
POLLERR.
                                            it calls poll, but getting
POLLERR.
                                            ...
									 

Interestingly, in this issue, even though netlink overrun frequently 
happened and caused POLLERRs, the user was managing it well through 
POLLIN and 'recv' function without a specific POLLERR handler. 
However, in the current situation, rcv queue is already empty and 
NETLINK_S_CONGESTED flag prevents any more incoming packets. This makes 
it impossible for the user to call 'recv'.

This "congested" situation is a bit ambiguous. The queue is empty, yet 
'congested' remains. This means kernel can no longer deliver uevents 
despite the empty queue, and it lead to the persistent 'congested' status.

The reason for the difference in netlink lies in the NETLINK_S_CONGESTED 
flag. If it were UDP, upon seeing the empty queue, it might have kept 
pushing the received packets into the queue (making possible to call 
'recv').

BRs,
JE Park.


