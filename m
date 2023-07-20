Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A242575A787
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjGTHPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGTHPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:15:48 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E502118
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:15:44 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230720071542epoutp04d7eadafed2446337b9a2084376ebb06e~zghwjdzvs0884708847epoutp04E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:15:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230720071542epoutp04d7eadafed2446337b9a2084376ebb06e~zghwjdzvs0884708847epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689837342;
        bh=3tl7faBvI9QEX5maxzKSbUjRYhYxM6dis+ORKWtEhb0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=FiOp/+XN7DhIX0bCTNA3ch73DLRQKy1MNNhz7rOBdouiF4zVrXndVpjamsQR1GfO7
         vCC+EKQLdFoBhSWfUyhlywJUwnRo5RAxgB++CK+EKc/h+TVDFkG0PlaRX8LTGe8bPB
         bCdCvIRoP6l7b8UmRo2rVUtQG6gNN8E42xOE+wVY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230720071542epcas2p4f0406b7d295e694f18779ea70f7e8fac~zghwVbK1h2982529825epcas2p48;
        Thu, 20 Jul 2023 07:15:42 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R63qy06nWz4x9QD; Thu, 20 Jul
        2023 07:15:42 +0000 (GMT)
X-AuditID: b6c32a4d-637c170000047356-49-64b8df1d58cf
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.8E.29526.D1FD8B46; Thu, 20 Jul 2023 16:15:41 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] md/bitmap: Fix bitmap page writing problem when
 using block integrity
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "song@kernel.org" <song@kernel.org>, "shli@fb.com" <shli@fb.com>,
        "neilb@suse.com" <neilb@suse.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <a658717c-8388-6e56-4d8d-096b0a1aefb9@molgen.mpg.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230720071441epcms2p3af7d4941dd0a9ab8243e873af43791f8@epcms2p3>
Date:   Thu, 20 Jul 2023 16:14:41 +0900
X-CMS-MailID: 20230720071441epcms2p3af7d4941dd0a9ab8243e873af43791f8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTTFf2/o4Ug+W71SxeHtK0uLxrDptF
        +/xdjBafNsZavJyVZrFsZz+LxfHlf9kc2D0mNr9j99i0qpPN48m5CcwefVtWMXqs33KVxePz
        JrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        Q5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkam
        QIUJ2Rmf1vayFTxkrli5aANTA+Nbpi5GTg4JAROJe/t+sXUxcnEICexhlLjzZCFLFyMHB6+A
        oMTfHcIgNcIC8RK7Lr9jBrGFBJQkzq2ZxQgRN5Boud3GAmKzCehJ7Hi+mx3EFhFQl1j1uxss
        zizwnFFi3elaiF28EjPan7JA2NIS25dvBZvDKeAo8XHjczaIuIbEj2W9zBC2qMTN1W/ZYez3
        x+YzQtgiEq33zkLVCEo8+LkbKi4pcejQVzaQ8yUE8iU2HAiECNdItP16D1WuL3GtYyPYCbwC
        vhKPfx4FG88ioCrR92M91GkuEh8vQ5zDLCAvsf3tHGaQkcwCmhLrd+lDTFeWOHIL6kE+iY7D
        f9lhHmzY+Bsre8e8J0wQrWoSi5qMJjAqz0KE8iwkq2YhrFrAyLyKUSq1oDg3PTXZqMBQNy+1
        HB65yfm5mxjBaVLLdwfj6/V/9Q4xMnEwHmKU4GBWEuF9dHlbihBvSmJlVWpRfnxRaU5q8SFG
        U6BHJzJLiSbnAxN1Xkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFIN
        TI1dGv5uN+43HwyoieN0yru7PP/W9DPfXav+V7yckp/IWqHakGDZcv1J4ENGz9CdPVaKTLus
        5oRtrb+lUndgFaPf2dTNbpv28rn0H3qwQI2Ty9Ny6nKBFywMTv2952+JmBf9cyvf+Gp2ZsDG
        vx/0bnJ9iLv82HLefpGSrwsTrPNzbq39Lr75EluTL8fLzjXuiUFRzKs2Jjw5yK2qtEbCVK08
        5fnrKesWhvDO3jLTUP6k8vz46wurt0yMfLIjzuLa9dzbE4s2FGiJJXEfrrp4QHT7/A1NG9XC
        y7vbKjx9FhzcxS/qe8yz8n7PovcGG+yi2KdKzNCvejJzXrdgyhtjkWt9HXrHzWZNjpoxIXVt
        iBJLcUaioRZzUXEiAAmMStwcBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230720061234epcms2p32e02cd528fc834491816b379ae189012
References: <a658717c-8388-6e56-4d8d-096b0a1aefb9@molgen.mpg.de>
        <20230720061234epcms2p32e02cd528fc834491816b379ae189012@epcms2p3>
        <CGME20230720061234epcms2p32e02cd528fc834491816b379ae189012@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Paul,

> Dear Jinyoung,
> 
> 
> Thank you very much for your patch. Some minor comments, you can also 
> ignore.

I will reflect the advice you gave me regarding the commit message and send it again.

> Your From line spells it CHOI. Maybe you can update your git 
> configuration to also use Choi?

It was being set like that in the company mail system. (CHOI)
I will modify it to be seen as "Choi".
Thank you for your comment. :)

Best Regards,
Jinyoung.
