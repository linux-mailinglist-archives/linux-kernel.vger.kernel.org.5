Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE9375AE26
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGTMRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGTMRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:17:18 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975291BC6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:17:16 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230720121714epoutp0429933c813aade1923a3ff72dfc6969eb~zkpCS6XQR1871218712epoutp04M
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:17:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230720121714epoutp0429933c813aade1923a3ff72dfc6969eb~zkpCS6XQR1871218712epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689855434;
        bh=635U/utLjBO9EWggPHp+XOGINrUbNQ65lx44UOJalco=;
        h=From:To:Cc:Subject:Date:References:From;
        b=g8bnBcKkgDhik7ssl0CiZShMo0imCFg+F2aS5K2KlCcW3sNvEHMjo1bK+aXeLhysT
         jiHbeIFTXApAUw81mIkFzpfGOTHaskcQgQlt7PQaoF2ZMbVg13jkhRTLc+bpDDP7bV
         hWtHI1/Ya61+NkSaah3WSz4E55cHRtYcma0FeJm4=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230720121714epcas5p1b4b25281c98835d4352bab360f4d1a88~zkpCDgAKd1458414584epcas5p1l;
        Thu, 20 Jul 2023 12:17:14 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.B2.55522.AC529B46; Thu, 20 Jul 2023 21:17:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b~zkBlSInTU2420324203epcas5p1u;
        Thu, 20 Jul 2023 11:32:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230720113203epsmtrp27d0ca2e3abd9cec37694966e3cdbb1cc~zkBlRg3iR1522915229epsmtrp2N;
        Thu, 20 Jul 2023 11:32:03 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-58-64b925cab824
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.6B.30535.33B19B46; Thu, 20 Jul 2023 20:32:03 +0900 (KST)
Received: from sri-7017.. (unknown [107.108.189.195]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230720113202epsmtip26bcaec5c4a39519b53ac9dc3379832e4~zkBj6WYsD3200232002epsmtip2S;
        Thu, 20 Jul 2023 11:32:01 +0000 (GMT)
From:   Aman Deep <aman.deep@samsung.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        laurent.pinchart@ideasonboard.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aman Deep <aman.deep@samsung.com>,
        Anuj Gupta <anuj01.gupta@samsung.com>
Subject: [PATCH] USB: Fix race condition during UVC webcam disconnect
Date:   Thu, 20 Jul 2023 17:01:42 +0530
Message-Id: <20230720113142.3070583-1-aman.deep@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZdlhTU/eU6s4Ug1+/ZSz2v9/CYnHlpo9F
        8+L1bBadE5ewW1zeNYfNYtGyVmaLCb8vsDmwe8zumMnqsX/uGiDr7g9Gj74tqxg9Pm+SC2CN
        4rJJSc3JLEst0rdL4MpYu/kDc8EtlYrH388xNzB+lu9i5OSQEDCR2LH0HHsXIxeHkMBuRond
        pzYwQjifGCV6D91iB6kSEvjGKHH0ojFMx8tvp5gg4nsZJS63xkA0vGKU2Pu5nQUkwSagLtH6
        +wuYLSIQJ/Hoxn9WkCJmgXZGiQ1bjjKCJIQFXCVOtC0EmsTBwSKgKtF/1AwkzCtgI7F0yglW
        iGXyEvsPnmWGiAtKnJz5BGwmM1C8eetsZpCZEgKn2CW2LFgO1eAicfbjISYIW1ji1fEt7BC2
        lMTnd3vZIOxyiYdPJ7BANLcwSvx6+YgFImEv0XjkEthBzAKaEut36UOEZSWmnlrHBLGYT6L3
        9xOo+bwSO+bB2MoS729+gNolKXHwUg8zhO0h0Xn3FisktGIlZu86yTyBUX4Wkn9mIflnFsLm
        BYzMqxglUwuKc9NTi00LDPNSy/WKE3OLS/PS9ZLzczcxgtOKlucOxrsPPugdYmTiYDzEKMHB
        rCTC++jythQh3pTEyqrUovz4otKc1OJDjNIcLErivK9b56YICaQnlqRmp6YWpBbBZJk4OKUa
        mELbrNbsfLDv/sdvfEqpy87uiKn+GRZx6Hp4latgxrXT0qL/76n7M6ZYbpTtm3B61gthnUaH
        icxVeefEC9f84LEr4pk70UuKfbH8c7k7kyadru9Xm77qu0pUon/R/fNargVZXN3XHon1xyQ3
        mwfvqDmkf59dOanp6mq7N1PKjO5YFHAqPb5x9Fia5aK0jpenXq+eNfUgvzH7jv436uJtBiff
        R9541O+nfaCMRe+lrtXXKO25wldVLyn3Vaq9ZnjpknzF3maN4NqiokDRrVseMdcfvvn6ro51
        /K5NTZYLvhlq7Wdy2u9bIvpT/l21pYGTTPGiZxJPXW0kr2m3rlPXjjxX/TJXtug8W7ZOpQ2/
        EktxRqKhFnNRcSIA5niQMpoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSvK6x9M4Ug4UfZC32v9/CYnHlpo9F
        8+L1bBadE5ewW1zeNYfNYtGyVmaLCb8vsDmwe8zumMnqsX/uGiDr7g9Gj74tqxg9Pm+SC2CN
        4rJJSc3JLEst0rdL4MpYu/kDc8EtlYrH388xNzB+lu9i5OSQEDCRePntFFMXIxeHkMBuRol9
        07axQCQkJSZ2vGSFsIUlVv57zg5R9IJR4uS3B8wgCTYBdYnW31/AGkQEEiSWn73CAlLELNDN
        KHFjySmwhLCAq8SJtoVAKzg4WARUJfqPmoGEeQVsJJZOOQG1QF5i/8GzzBBxQYmTM5+AtTID
        xZu3zmaewMg3C0lqFpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwUGqpbWD
        cc+qD3qHGJk4GA8xSnAwK4nwPrq8LUWINyWxsiq1KD++qDQntfgQozQHi5I477fXvSlCAumJ
        JanZqakFqUUwWSYOTqkGpl3rNrqf2XKx/GWxL6/cR5WNy5T1RI+k2IlsMVhhzxtjKLjJzUmn
        o+DunwO7q5m6Naoln2/smmP8nTn2pNC73JqLh62OyO4QaJz30b9y19Xaxys3xrZ5dJQf5xWv
        qznyZmbY3wkTFPIv1XgeM0jtSUlIqfmrcfbbVp0VNdJq3YkBW9Ltbm5xiH0c/6qNZfOHErmr
        B3z7Nlf9agl85bNpadu6EE0J5nll6SqWlRu+L7/rsV6MOVjCNWMv+3eppcYRFW/K5+p6Spxp
        Y3ott/jIu5j3209OOlfnX/i3e2a99YVbT/ZNz1Rqith+RrU6r1w36NupG14TJ6ZXbJPMmfBp
        7x7VqJ5t7qtO35zep7QkR4mlOCPRUIu5qDgRALGmnLvBAgAA
X-CMS-MailID: 20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b
References: <CGME20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b@epcas5p1.samsung.com>
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

In the bug happened during uvc webcam disconect,there is race
between stopping a video transfer and usb disconnect.This issue is
reproduced in my system running Linux kernel when UVC webcam play is
stopped and UVC webcam is disconnected at the same time. This causes the
below backtrace:

[2-3496.7275]  PC is at 0xbf418000+0x2d8 [usbcore]
[2-3496.7275]  LR is at 0x00000005
[2-3496.7275] pc : [<bf4182d8>]((usb_ifnum_to_if
</drivers/usb/core/usb.c:283
[usbcore.ko]>)) lr : [<00000005>]() psr: 20000013
[2-3496.7275] Function entered at [<bf4182a4>]((usb_ifnum_to_if
</drivers/usb/core/usb.c:275
[usbcore.ko]>)) (0xbf418000+0x2a4 [usbcore]) from
[<bf423974>]((usb_hcd_alloc_bandwidth
</drivers/usb/core/hcd.c:1947
[usbcore.ko]>)) (0xbf418000+0xb974 [usbcore])
[2-3496.7275] Function entered at [<bf423738>]((usb_hcd_alloc_bandwidth
</drivers/usb/core/hcd.c:1876
[usbcore.ko]>)) (0xbf418000+0xb738 [usbcore]) from
[<bf426ca0>]((usb_set_interface
</drivers/usb/core/message.c:1461
[usbcore.ko]>)) (0xbf418000+0xeca0 [usbcore])
[2-3496.7275] Function entered at [<bf426b9c>]((usb_set_interface
</drivers/usb/core/message.c:1385
[usbcore.ko]>)) (0xbf418000+0xeb9c [usbcore]) from
[<bf9c4dd4>]((uvc_video_clock_cleanup
</drivers/media/usb/uvc/uvc_video.c:598
uvc_video_stop_streaming
</drivers/media/usb/uvc/uvc_video.c:2221
[uvcvideo.ko]>)) (0xbf9bd000+0x7dd4 [uvcvideo])
[2-3496.7275] Function entered at [<bf9c4d98>]((uvc_video_stop_streaming
</drivers/media/usb/uvc/uvc_video.c:2200
[uvcvideo.ko]>)) (0xbf9bd000+0x7d98 [uvcvideo]) from
[<bf9bfab8>]((spin_lock_irq
</include/linux/spinlock.h:363
uvc_stop_streaming
</drivers/media/usb/uvc/uvc_queue.c:194
[uvcvideo.ko]>)) (0xbf9bd000+0x2ab8 [uvcvideo])
[2-3496.7276] Function entered at [<bf9bfa94>]((uvc_stop_streaming
</drivers/media/usb/uvc/uvc_queue.c:186
[uvcvideo.ko]>)) (0xbf9bd000+0x2a94 [uvcvideo]) from
[<be307150>]((__read_once_size
</include/linux/compiler.h:290
(discriminator 1) __vb2_queue_cancel
</drivers/media/common/videobuf2/videobuf2-core.c:1893
(discriminator 1) [videobuf2_common.ko]>)) (0xbe306000+0x1150
[videobuf2_common])
[2-3496.7276] Function entered at [<be307120>]((__vb2_queue_cancel
</drivers/media/common/videobuf2/videobuf2-core.c:1877
[videobuf2_common.ko]>)) (0xbe306000+0x1120 [videobuf2_common]) from
[<be308894>]((vb2_core_streamoff
</drivers/media/common/videobuf2/videobuf2-core.c:2053

This below solution patch fixes this race condition at USB core level
occurring during UVC webcam device disconnect.

Signed-off-by: Anuj Gupta <anuj01.gupta@samsung.com>
Signed-off-by: Aman Deep <aman.deep@samsung.com>
---
 drivers/usb/core/hcd.c     | 7 ++++++-
 drivers/usb/core/message.c | 4 ++++
 drivers/usb/core/usb.c     | 9 ++++++---
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 8300baedafd2..a06452cbbaa4 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1931,7 +1931,12 @@ int usb_hcd_alloc_bandwidth(struct usb_device *udev,
 		}
 	}
 	if (cur_alt && new_alt) {
-		struct usb_interface *iface = usb_ifnum_to_if(udev,
+		struct usb_interface *iface;
+
+		if (udev->state == USB_STATE_NOTATTACHED)
+			return -ENODEV;
+
+		iface = usb_ifnum_to_if(udev,
 				cur_alt->desc.bInterfaceNumber);
 
 		if (!iface)
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index b5811620f1de..f31c7287dc01 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1575,7 +1575,11 @@ int usb_set_interface(struct usb_device *dev, int interface, int alternate)
 	for (i = 0; i < iface->cur_altsetting->desc.bNumEndpoints; i++)
 		iface->cur_altsetting->endpoint[i].streams = 0;
 
+	if (dev->state == USB_STATE_NOTATTACHED)
+		return -ENODEV;
+
 	ret = usb_hcd_alloc_bandwidth(dev, NULL, iface->cur_altsetting, alt);
+
 	if (ret < 0) {
 		dev_info(&dev->dev, "Not enough bandwidth for altsetting %d\n",
 				alternate);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 901ec732321c..6fb8b14469ae 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -352,10 +352,13 @@ struct usb_interface *usb_ifnum_to_if(const struct usb_device *dev,
 
 	if (!config)
 		return NULL;
-	for (i = 0; i < config->desc.bNumInterfaces; i++)
-		if (config->interface[i]->altsetting[0]
-				.desc.bInterfaceNumber == ifnum)
+	for (i = 0; i < config->desc.bNumInterfaces; i++) {
+		if (config->interface[i] &&
+				config->interface[i]->altsetting[0]
+				.desc.bInterfaceNumber == ifnum) {
 			return config->interface[i];
+		}
+	}
 
 	return NULL;
 }
-- 
2.34.1

