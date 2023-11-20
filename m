Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B054A7F0B79
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjKTErQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTErN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:47:13 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC662D7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:47:09 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231120044708epoutp010aca6822bd3003cf1c6a6047f36dacf6~ZO2Jgz8y30065200652epoutp01B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:47:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231120044708epoutp010aca6822bd3003cf1c6a6047f36dacf6~ZO2Jgz8y30065200652epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700455628;
        bh=1Ubo85pbdvTXN6wPClLCAMAFVLHGFNFWy1sBF7ODcUo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ftMXhMqBwvvWXZgIIW+xjZpL+skU2CO3DuUS7wlUho2qMUBtblHyWQRZd3jKwZBL4
         y5OpXbObhz5/fi8qeVeTYoIVxqnZ343qEqehJ3OiwIa+JVcjxHAauXMvluOlmXA6cl
         6ZlIiTU1AbN8Yn2KaRKbHM1cTOpWE0BCGNSTC4Go=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231120044707epcas2p48e30f2ea8d8da56bd273ee83ac704bcf~ZO2JCJA4e2770527705epcas2p4H;
        Mon, 20 Nov 2023 04:47:07 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SYZjk6VLFz4x9Q6; Mon, 20 Nov
        2023 04:47:06 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-1a-655ae4ca8d08
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.B1.18994.AC4EA556; Mon, 20 Nov 2023 13:47:06 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] nfc: virtual_ncidev: Add variable to check if ndev is
 running
Reply-To: bongsu.jeon@samsung.com
Sender: Bongsu Jeon <bongsu.jeon@samsung.com>
From:   Bongsu Jeon <bongsu.jeon@samsung.com>
To:     Nguyen Dinh Phi <phind.uet@gmail.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com" 
        <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20231119164705.1991375-1-phind.uet@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231120044706epcms2p48c4579db14cc4f3274031036caac4718@epcms2p4>
Date:   Mon, 20 Nov 2023 13:47:06 +0900
X-CMS-MailID: 20231120044706epcms2p48c4579db14cc4f3274031036caac4718
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTTPfUk6hUg8MfjC22NE9it9j7eiu7
        xeVdc9gsji0Qs5j34jWTxeY5d5gc2Dx2zrrL7nHn2h42j74tqxg9Zr5V8/i8SS6ANSrbJiM1
        MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdov5JCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2P13D2M
        BR8FK46+3c3awNjI28XIySEhYCLxfMd1FhBbSGAPo8TsHdZdjBwcvAKCEn93CIOEhQVCJGbs
        fwxVoijxv+McG0RcV+LF36NgNpuAtsTao41MILaIwHRGiSPPeLoYuTiYBV4zSpxrOccMsYtX
        Ykb7UxYIW1pi+/KtjCA2p4C1xJ1Txxgh4hoSP5b1QtWLStxc/ZYdxn5/bD5UjYhE672zUDWC
        Eg9+7oaKS0l8eniGFeR+CYFsie99bCA3SAg0MErceXsXaq++xLR7C8BsXgFfiZ1/p4DZLAKq
        ErM/v4aqcZF4cmM32GPMAvIS29/OYQaZySygKbF+lz7EeGWJI7dYICr4JDoO/2WH+XDHvCdM
        ELaqRG/zFyaYbyfPboG60kPi/u3vbBMYFWchAnoWkl2zEHYtYGRexSiVWlCcm56abFRgqJuX
        Wg6P3uT83E2M4MSo5buD8fX6v3qHGJk4GA8xSnAwK4nwfhOKSBXiTUmsrEotyo8vKs1JLT7E
        aAr06URmKdHkfGBqziuJNzSxNDAxMzM0NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1Oq
        gcln1f9z7DrzCi9ffbOv9UfhjUJRkfuLXri/25aSI3dwU6mA7K9zP62FKlhalequvYzJ5Tep
        ia61XTBlv+uiIwtzHx+ayPt92bdqpwtZH5ITX5+umsK+vGtO15vzTdxm70+vMP6/c6OjxMug
        3OW9K9bwmiypmKDO6Gr1P6dj7/xkZdcljR9390XekMkpOZo/74fJwtzSw1MZLc6ckr3jaBVw
        42LZrEj566ezFpn8vn5c50RP+bOX4suXL5tvJ/BOIXK53zvle57WCRc/MCj/nSHvWrVw0bOi
        qNWhO985SXXoG1tlqzWnO0tEvw9S1n0n903+1AEHBrXsa5XPvLNLY1VevJnjJrI5qE+j68iP
        bZxKLMUZiYZazEXFiQAdpeLoFQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231119164714epcas2p2c0480d014abc4f0f780c714a445881ca
References: <20231119164705.1991375-1-phind.uet@gmail.com>
        <CGME20231119164714epcas2p2c0480d014abc4f0f780c714a445881ca@epcms2p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/11/2023 01:47, Nguyen Dinh Phi wrote:

> syzbot reported an memory leak that happens when an skb is add to
> send_buff after virtual nci closed.
> This patch adds a variable to track if the ndev is running before
> handling new skb in send function.
> 
> Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/00000000000075472b06007df4fb@google.com
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>  drivers/nfc/virtual_ncidev.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
> index b027be0b0b6f..ac8226db54e2 100644
> --- a/drivers/nfc/virtual_ncidev.c
> +++ b/drivers/nfc/virtual_ncidev.c
> @@ -20,26 +20,31 @@
>                                   NFC_PROTO_ISO14443_MASK | \
>                                   NFC_PROTO_ISO14443_B_MASK | \
>                                   NFC_PROTO_ISO15693_MASK)
> +#define NCIDEV_RUNNING 0
This define isn't used.

>  
>  struct virtual_nci_dev {
>          struct nci_dev *ndev;
>          struct mutex mtx;
>          struct sk_buff *send_buff;
>          struct wait_queue_head wq;
> +        bool running;
>  };
>  
>  static int virtual_nci_open(struct nci_dev *ndev)
>  {
> +        struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
> +
> +        vdev->running = true;
>          return 0;
>  }
>  
>  static int virtual_nci_close(struct nci_dev *ndev)
>  {
>          struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
> -
>          mutex_lock(&vdev->mtx);
>          kfree_skb(vdev->send_buff);
>          vdev->send_buff = NULL;
> +        vdev->running = false;
>          mutex_unlock(&vdev->mtx);
>  
>          return 0;
> @@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
>          struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
>  
>          mutex_lock(&vdev->mtx);
> -        if (vdev->send_buff) {
> +        if (vdev->send_buff || !vdev->running) {

Dear Krzysztof,

I agree this defensive code.
But i think NFC submodule has to avoid this situation.(calling send function of closed nci_dev)
Could you check this?

Best regards,
Bongsu
