Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115507E9CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjKMNFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKMNFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:05:00 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B1171C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:04:54 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231113130452euoutp0176aca27e698fa69144f1676137b0fe37~XMHu4DTAG1785417854euoutp01m
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 13:04:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231113130452euoutp0176aca27e698fa69144f1676137b0fe37~XMHu4DTAG1785417854euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699880692;
        bh=Bt1BH9P48bUtBwbmeLlr/gWc1xJ7xQ8lkQWYHmuD3ek=;
        h=From:To:Cc:Subject:Date:References:From;
        b=eGpjAwacDzZvgoD6wq4KTsX5UVwvBx4jRWEr40i7/Vt5Hea+2irAGZpES1j9suToI
         9e4Z/4dauF0IEGLu9/T35uZUIAyaIt9V21CFGP1JzJycN/ICSHvkZXp9VDD2ue534b
         AtYrOfSuwlXbHmfxuB9kfkoUDIlazGQtx5s1tKPc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231113130451eucas1p1dd5e97f8cf484467a956d38e77de5768~XMHugmbOM3228432284eucas1p1B;
        Mon, 13 Nov 2023 13:04:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 12.30.09814.3FE12556; Mon, 13
        Nov 2023 13:04:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231113130451eucas1p293985c1bee8dc71b9c78a013663ce8e6~XMHuDOCFO1683316833eucas1p23;
        Mon, 13 Nov 2023 13:04:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231113130451eusmtrp2e1b2e14e6dece6bb3c1a120dff35c4ca~XMHuCfQyq0159901599eusmtrp2I;
        Mon, 13 Nov 2023 13:04:51 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-d1-65521ef35b52
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.5D.09146.3FE12556; Mon, 13
        Nov 2023 13:04:51 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231113130450eusmtip2dff6ba245ed1d63e23761ad8a3d190fe~XMHtVhX0V2195521955eusmtip2B;
        Mon, 13 Nov 2023 13:04:50 +0000 (GMT)
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Various Exynos targets never return to no cooling
Date:   Mon, 13 Nov 2023 14:04:34 +0100
Message-ID: <20231113130435.500353-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7qf5YJSDZbOMrT4vuU6k8W8z7IW
        e19vZbe4vGsOm8Xn3iOMFjPO72OyWNjUwm4x8dhkZou1R+6yW8z9MpXZ4snDPjYHbo8189Yw
        euycdZfdY/Gel0wem1Z1snncubaHzaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgy7qy5zlhw
        wqzi5bJPrA2Mz9S7GDk5JARMJL5PO8jaxcjFISSwglHi4dIGZgjnC6PEvgV/oJzPjBKzr91j
        h2n5N/EiVGI5o8SD2RvZIZxWJoljx08xgVSxCRhIPHizDCjBwSEiEC+x/qsVSA2zwGMmiRcd
        15lBaoQFrCROLrrCBmKzCKhKHHn1HSzOK2ArseP0VSaIbfISexZ9Z4KIC0qcnPmEBcRmBoo3
        b50NdoWEwBkOicWPZ7BCNLhILG1eyAhhC0u8Or4F6mwZif8750MNzZeYsfk9C8hxEgIVEncP
        ekGY1hIfzzCDmMwCmhLrd+lDRB0l9m1JhTD5JG68FYTYzycxadt0Zogwr0RHmxDEZFWJ43sm
        MUPY0hJPWm5DbfSQOHvrONhVQgKxEg9aJ7BMYFSYheSrWUi+moVwwgJG5lWM4qmlxbnpqcVG
        eanlesWJucWleel6yfm5mxiB6en0v+NfdjAuf/VR7xAjEwfjIUYJDmYlEd48zYBUId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4ryqKfKpQgLpiSWp2ampBalFMFkmDk6pBqa1Nqnns3MYur3Xqe7X
        ZD30JbtKI7Fkx5ls1csx1/PdmdeeVay0uLaB9a9oSVWs+rutO8RuLfpWd8wi+Pqd1Zdz1poG
        Ljvz53WH1D3vvlf1XkGx30repkhudH4SLPLUOfbdj+i5sh1Xk31MN/+X2HUnbs2dZyvdC+2u
        lb5JP7/6kNn7813sInEnvy993juf749lblib976Vsx8f6eNqUTy2oDf8yZyJrZtXsQtO2nXK
        l2tP1YqwqxPyG+svZK+8nRrIab1k+olwa696+/2rc25+eVF3o4/138PqebPC0ox0jbcdrghf
        JWWiuMS0QrG1L+vDO7Fq7qMKmo2CnmsOFZb9iYi7NpHz15T1Yf/ZtskqsRRnJBpqMRcVJwIA
        vxV3M74DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd3PckGpBo8/8Vt833KdyWLeZ1mL
        va+3sltc3jWHzeJz7xFGixnn9zFZLGxqYbeYeGwys8XaI3fZLeZ+mcps8eRhH5sDt8eaeWsY
        PXbOusvusXjPSyaPTas62TzuXNvD5tG3ZRWjx+dNcgHsUXo2RfmlJakKGfnFJbZK0YYWRnqG
        lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZd9ZcZyw4YVbxctkn1gbGZ+pdjJwcEgIm
        Ev8mXmTuYuTiEBJYyiix7+lxdoiEtMThL1OgbGGJP9e62CCKmpkkvn3ayQiSYBMwkHjwZhlY
        kYhAosSDnufsIEXMAi+ZJNpXHmQCSQgLWEmcXHSFDcRmEVCVOPLqOzOIzStgK7Hj9FUmiA3y
        EnsWfWeCiAtKnJz5hAXEZgaKN2+dzTyBkW8WktQsJKkFjEyrGEVSS4tz03OLDfWKE3OLS/PS
        9ZLzczcxAiNk27Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHePM2AVCHelMTKqtSi/Pii0pzU4kOM
        pkD3TWSWEk3OB8ZoXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QD
        U/kClgTF/S/474tuSIjjP393YeydX5fbCoOTJsxc2fq0+cgzjsDKtpMbfy7fpr6r4ZRE/G3D
        da9/s0tF/K5b26xyPmxG7ENjUSGnOFMxV+trUbOEF6t3SgRl959ylPFyW6sn6xvRUdSwzCdm
        wmvmTzKvFh/Qe/ZY/Yz0rCwun5hmQ4celQzBKp4ipejctFyrbmFeNqlPwZ1vhSRP7vI+Pa3g
        RaxpjOrm6tKbTvHSD/9K+/F8OyByZmnTf8XSfQVey5e+331siYL0i0Jlz1mG2W3RG4QeTHgZ
        bzpbsaDzp8vsleX79wsdM6xSFN3M1zHRMX2Na7YWS3yq9E714hN7mvfsSDjXIX+Qhd//mpsS
        S3FGoqEWc1FxIgCQLAYKGQMAAA==
X-CMS-MailID: 20231113130451eucas1p293985c1bee8dc71b9c78a013663ce8e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231113130451eucas1p293985c1bee8dc71b9c78a013663ce8e6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231113130451eucas1p293985c1bee8dc71b9c78a013663ce8e6
References: <CGME20231113130451eucas1p293985c1bee8dc71b9c78a013663ce8e6@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While working on some fixes on the Exynos thermal driver, I have found that some
of the Exynos-based boards will never return to no cooling. That is, after
heating the board a bit and letting it cool, we see in the sysfs output similar
to this:

root@target:~# cat /sys/class/thermal/thermal_zone*/temp
30000
29000
32000
31000
30000
root@target:~# cat /sys/class/thermal/cooling_device*/cur_state
1
0
0
0

This is on the Odroid XU4 board, where the lowest trip point is 50 deg. C.
Similar behavior happens on some other boards, for example TM2E. The issue
happens when the stepwise governor is being used and I have not tested the
behavior of the other governors.

I have attempted to fix this myself, but the issue seems somewhat complex and
over my level of understanding. I did some debugging, and here is what I think
is happening:

1. Since there is no temperature polling enabled on the mentioned boards, the
   governor will only be called when a trip point is being passed.
2. The board heats up and a couple trip points get passed through. Each time,
   the governor is called for each trip point.
3. For the lowest thermal instance, it will find out that the temperature is
   higher than the lowest trip point (i.e. throttle is true), and that the trend
   is THERMAL_TREND_RAISING. Therefore, it will attempt to increase the target
   state each time and the state will be set to the higher limit.
4. Let's now say that the temperature starts falling, which means that the trip
   points get passed from the other side. Again, the governor will be called for
   each trip point.
5. For the lowest thermal instance, the trend will be THERMAL_TREND_DROPPING. The
   temperature will be higher than the lowest trip point all but one time (i.e.
   throttle will be true). This will mean that in these cases, nothing will
   happen and the state will remain at the higher limit.
6. Finally, when the lowest trip point is passed and the governor is called for
   its thermal instance, the trend will still be THERMAL_TREND_DROPPING and the
   temperature will be lower than the trip point (i.e. throttle will be false).
   Therefore, the governor will reduce the state, but it is unlikely that this
   will result in deactivation of the thermal instance, since the state has been
   at the higher limit up until this point.
7. Now the governor will never be called anymore, and the state will never
   change from this point.

I have found two workarounds, but neither seem satisfactory:

1. The issue doesn't appear when at least two lowest trip points have their
   lower state limit equal to the higher state limit. For instance, for TM2E,
   the following change is enough for the issue to not appear:

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
index 81b72393dd0d..145c4c80893a 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
@@ -55,14 +55,14 @@ cooling-maps {
             map0 {
                 /* Set maximum frequency as 1800MHz  */
                 trip = <&atlas0_alert_0>;
-                cooling-device = <&cpu4 1 2>, <&cpu5 1 2>,
-                         <&cpu6 1 2>, <&cpu7 1 2>;
+                cooling-device = <&cpu4 1 1>, <&cpu5 1 1>,
+                         <&cpu6 1 1>, <&cpu7 1 1>;
             };
             map1 {
                 /* Set maximum frequency as 1700MHz  */
                 trip = <&atlas0_alert_1>;
-                cooling-device = <&cpu4 2 3>, <&cpu5 2 3>,
-                         <&cpu6 2 3>, <&cpu7 2 3>;
+                cooling-device = <&cpu4 2 2>, <&cpu5 2 2>,
+                         <&cpu6 2 2>, <&cpu7 2 2>;
             };
             map2 {
                 /* Set maximum frequency as 1600MHz  */
@@ -229,14 +229,14 @@ cooling-maps {
             map0 {
                 /* Set maximum frequency as 1200MHz  */
                 trip = <&apollo_alert_2>;
-                cooling-device = <&cpu0 1 2>, <&cpu1 1 2>,
-                         <&cpu2 1 2>, <&cpu3 1 2>;
+                cooling-device = <&cpu0 1 1>, <&cpu1 1 1>,
+                         <&cpu2 1 1>, <&cpu3 1 1>;
             };
             map1 {
                 /* Set maximum frequency as 1100MHz  */
                 trip = <&apollo_alert_3>;
-                cooling-device = <&cpu0 2 3>, <&cpu1 2 3>,
-                         <&cpu2 2 3>, <&cpu3 2 3>;
+                cooling-device = <&cpu0 2 2>, <&cpu1 2 2>,
+                         <&cpu2 2 2>, <&cpu3 2 2>;
             };
             map2 {
                 /* Set maximum frequency as 1000MHz  */

   Two trip points need to change and not only one, since the calculation in the
   governor is based on the maximum of all states and not only the state of a
   single instance. It's not clear if that would be enough in all cases, but
   this feels hacky anyway. Though since we only give the governor information
   when the trip point is passed, it does make some limited sense to make it
   simply set the state to a specific value instead of making decisions.
2. The issue also disappears when polling is enabled, since this means that the
   governor is called periodically. However, it would be great to not have to do
   so and keep using only interrupts, since we already have them in our SoC.

It seems that in the past, there has been an attempt to handle this case
differently: https://lore.kernel.org/all/1352348786-24255-1-git-send-email-amit.kachhap@linaro.org/
However it seems that the attempt has never been completed, and the remains
have been removed: https://lore.kernel.org/all/20220629151012.3115773-2-daniel.lezcano@linaro.org/

There also might be a race condition possible here, as it might be the case
that after the interrupt, when the thermal framework calls get_temp, the value
will already change to a value that would not trigger the trip point. This
could be problematic when the temperature is raising, as then the governor will
essentially ignore that trip point (trend will be RAISING, but throttle will be
false, so nothing will happen). It is less problematic when the temperature is
falling, as the temperature will be much lower than the trip point due to
hysteresis. However, for the Exynos 5433 SoC, hysteresis is unfortunately set
to 1 deg. C and the temperature values are also rounded to 1 deg. C. This means
that the race condition might also be possible in this direction on this SoC. I
have once managed to get the state stuck at 2 instead of the usual 1 on TM2E. I
have not investigated that further, but it seems that this race condition is a
good explanation of this behavior.

I feel very incompetent to attempt to resolve these issues, as I have only read
the thermal framework code for a bit. What do you think should be done here?

Thank you! :)
Mateusz
