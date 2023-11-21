Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA2E7F2313
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjKUBb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKUBb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:31:56 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE30A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:31:52 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231121013148epoutp0114b194f19a3f34ef1e7004b401576d53~Zf0402WYL2917729177epoutp013
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:31:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231121013148epoutp0114b194f19a3f34ef1e7004b401576d53~Zf0402WYL2917729177epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700530308;
        bh=r7FUgwAb5MWY8DmPizGyFQBrKuzR2qlvMD2L01WpRUU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=rOdNLa5+qmIMPep1oXJSbiw4L7VJfSwZ2d2Y2DIJhS1qp/B2//B0BMctafTNqp/rx
         iMyk+Q/1tAjmAyiuKAMQQq5HEQCJjkzwcwqC3pleGLYQapJ2Ug1cDUmd2vRTEW3kkk
         XljQMOOcTxw/o520eqX9gCCdlOcD/ZxkkJhDPXqA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231121013147epcas2p4287f4c07f8f51285a02e63583d91304d~Zf04b9Buo1419714197epcas2p4V;
        Tue, 21 Nov 2023 01:31:47 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SZ6Kv1LX2z4x9QH; Tue, 21 Nov
        2023 01:31:47 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-cc-655c08834f57
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.23.09607.3880C556; Tue, 21 Nov 2023 10:31:47 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] nfc: virtual_ncidev: Add variable to check if ndev is
 running
Reply-To: bongsu.jeon@samsung.com
Sender: Bongsu Jeon <bongsu.jeon@samsung.com>
From:   Bongsu Jeon <bongsu.jeon@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nguyen Dinh Phi <phind.uet@gmail.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com" 
        <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <b2bd6689-5161-483a-a05c-811927831082@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231121013146epcms2p1587bebc341f17406625e8b0490b6ab1a@epcms2p1>
Date:   Tue, 21 Nov 2023 10:31:46 +0900
X-CMS-MailID: 20231121013146epcms2p1587bebc341f17406625e8b0490b6ab1a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmhW4zR0yqwdarnBZbmiexW+x9vZXd
        4vKuOWwWxxaIWcx78ZrJYvOcO0wObB47Z91l97hzbQ+bR9+WVYweM9+qeXzeJBfAGpVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
        kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbH/31mm
        gh1sFe+/qjYwzmDtYuTkkBAwkZi5aBJzFyMXh5DADkaJI9+Ws3cxcnDwCghK/N0hDFIjLBAi
        MWP/YxYQW0hAUeJ/xzk2iLiuxIu/R8FsNgFtibVHG5lA5ogIdDBKbNj0DcxhFnjNKHGu5Rwz
        xDZeiRntT1kgbGmJ7cu3MoIs4xSwk7iyTQYirCHxY1kvVLmoxM3Vb9lh7PfH5jNC2CISrffO
        QtUISjz4uRsqLiXx6eEZVpCREgLZEt/72EBOkBBoYJS48/Yu1Fp9iWn3FoDZvAK+Eu82LgOb
        wyKgKjH35gYmiBoXifnvXoLNZBaQl9j+dg4zyExmAU2J9bv0IcYrSxy5xQJRwSfRcfgvO8yD
        O+Y9gZqiKtHb/IUJ5tnJs1ugrvSQWLptAdsERsVZiICehWTXLIRdCxiZVzGKpRYU56anFhsV
        mMCjNjk/dxMjOCFqeexgnP32g94hRiYOxkOMEhzMSiK8W9hjUoV4UxIrq1KL8uOLSnNSiw8x
        mgJ9OZFZSjQ5H5iS80riDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRq
        YAoTb9JIunzx0VkrPq23bzayVjeGG56Xub9A1fzc5et/2JkzGmQC7fMPTlx6JOP5Zw45x1tL
        3WavTbyp65q/2PaR3u2ejckrBJSeVh9q0P06I4/v9Lf3rg81lpskLD8u8O15f/imsOB+04OV
        q/8u+K+wd88O7R7dNZoHfzLdeFooPv2ptX6NxvL4OL4J+6UKrzl3TQgJ0SnUqb6Rdn1+R5Dy
        Pa/LP7/71EhNnuD+3Dme5dO7z/wdscvYgn54393X+lHT6HBe0/1DlUcrmw5ez5WVeDwnzca4
        w0JfM+92m56oON+8NDO3uwXCO19vytrMknFwgX95m3PldF+G896xBuo/Uq69jmjXsXv5Ytms
        eiWW4oxEQy3mouJEALyijjMRBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231120184433epcas2p23e9f5db776d46ad8dd77a16dd326c1bc
References: <b2bd6689-5161-483a-a05c-811927831082@linaro.org>
        <20231119164705.1991375-1-phind.uet@gmail.com>
        <CGME20231120184433epcas2p23e9f5db776d46ad8dd77a16dd326c1bc@epcms2p1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 19:23, Phi Nguyen wrote:

> The issue arises when an skb is added to the send_buff after invoking 
> ndev->ops->close() but before unregistering the device. In such cases, 
> the virtual device will generate a copy of skb, but with no consumer 
> thereafter. Consequently, this object persists indefinitely.
> 
> This problem seems to stem from the existence of time gaps between 
> ops->close() and the destruction of the workqueue. During this interval, 
> incoming requests continue to trigger the send function.

Dear Krzysztof,

Even though i agree on this patch, i think that NFC subsystem could handle this scenario not to trigger the send function after close.
Do you think it would be better that each nci driver has the responsibility to handle this scenario?

Best regards,
Bongsu
