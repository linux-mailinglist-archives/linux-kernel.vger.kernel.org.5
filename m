Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314977AEB02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjIZLCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjIZLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:02:51 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0169AE9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:02:42 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230926110240euoutp0266a37efd33a97d817fcb5ae30c73f30a~IbfVbMupo1018810188euoutp02V
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:02:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230926110240euoutp0266a37efd33a97d817fcb5ae30c73f30a~IbfVbMupo1018810188euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695726160;
        bh=O7tx0lXDWQj5gRzSHsDM5GgUD1m2unsJnLQNdOCKuHg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=YfYNLSoY6+2NlKv+L4B0QeE4joAIAzC94VRNUv0yOMlbX8YGLPYGulp0P9O8lAZ1L
         zWVB5xfiIVrV0RqmMpEAaxWw4lSBKqjCavI825/baXbLXAjsw7xO0/WNwQWDfqn7cw
         eQSTHaqsX+Y+SuU9GV6jw3SZGo+TqOAtIRX13Gds=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230926110239eucas1p1fcb67b3e953b67a6358c63cd99ca0691~IbfVBIQBT2966429664eucas1p1o;
        Tue, 26 Sep 2023 11:02:39 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-bf-6512ba4f1251
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DF.CB.42423.F4AB2156; Tue, 26
        Sep 2023 12:02:39 +0100 (BST)
Mime-Version: 1.0
Subject: Re: [PATCH v2 4/7] thermal: exynos: simplify regulator
 (de)initialization
Reply-To: m.majewski2@samsung.com
Sender: Mateusz Majewski <m.majewski2@samsung.com>
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <bf9a07ff-5628-05ab-2362-a917d3d38313@linaro.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230926110239eucms1p2b539245c5b10591def4cd15f14896ad6@eucms1p2>
Date:   Tue, 26 Sep 2023 13:02:39 +0200
X-CMS-MailID: 20230926110239eucms1p2b539245c5b10591def4cd15f14896ad6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311
X-EPHeader: Mail
X-ConfirmMail: N,general
CMS-TYPE: 201P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djPc7r+u4RSDX4t1rN4MG8bm8Xh+RUW
        Ux8+YbP4vuU6k8W8z7IWe19vZbf4dqWDyWLT42usFpd3zWGz+Nx7hNFixvl9TBZrj9xlt5j7
        ZSqzxZOHfWwOfB47Z91l91i85yWTx6ZVnWwed67tYfPYvKTeo2/LKkaPz5vkAtijuGxSUnMy
        y1KL9O0SuDLOfVnPXvCQvWL9iffsDYzz2boYOTkkBEwkLvevYe5i5OIQEljBKNFx/DmQw8HB
        KyAo8XeHMEiNsECIxKRlc5lBbCEBRYnO7W/YIOJGEode7AKz2QQMJB68WcYOMkdE4AKTxOW7
        DWBDmQXeMEm8PfKNEWIbr8SM9qcsELa0xPblW8HinAJ2EhfuHIOqEZW4ufotO4z9/th8qLiI
        ROu9s8wQtqDEg5+7oeIyEicXLIOyiyVerr0EVVMhcXzJdKg55hKb5q5hhXjMV+Ly4xyQMIuA
        qsTjycdYIUpcJFZ+Pg5mMwvIS2x/OwccDswCmhLrd+lDlDhKbNjwH2qigMSaE3OgNklIbG15
        AtXKJzFp23RmmG93zHvCBGGrShzfM4kZ5vMnLbeZJjAqzUKE9Cwki2chLF7AyLyKUTy1tDg3
        PbXYMC+1XK84Mbe4NC9dLzk/dxMjMG2d/nf80w7Gua8+6h1iZOJgPMQowcGsJML76xlfqhBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6YklqdmpqQWpRTBZJg5OqQam5MM9nNwH9R/Y
        1e5anyZgpXIs/2xSsKzAhKs5/Ku5aoS++HLvOixZ+mbb60yxfyf9PZwETwX57z/rr7bwSBVn
        1z3Rnwu/6ZdOctNUEDiyYaYip2yCcbNZKDfnkj2djaKTuhRnFteeebwx2Ov6korsBRufeyyb
        0um/u/7VxCeH9yt9C3pebeOQ82zvMrG7+7OPyrs+zcpcmvo90bhv3WH7tIaMsIXb7u7Z/TT4
        94JoB/uTX28dfqu1wM15w6OCmRdsw/luqAWdSW4uWh9xc2v1lIlhB0JYGI6e2JGcFquweFpA
        xmszqTjhoNKi0PWBcoaRWe+vtHb4ndGak3pggmXR4+D6W/MPXf74pKOoUv+fEktxRqKhFnNR
        cSIAlAJRCcoDAAA=
X-CMS-RootMailID: 20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311
References: <bf9a07ff-5628-05ab-2362-a917d3d38313@linaro.org>
        <20230911133435.14061-1-m.majewski2@samsung.com>
        <20230911133435.14061-5-m.majewski2@samsung.com>
        <CGME20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311@eucms1p2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> This is not equivalent. If regulator is provided and enable fails, the
> old code is nicely returning error. Now, it will print misleading
> message - failed to get regulator - and continue.
>
> While this simplifies the code, it ignores important running condition -
> having regulator enabled.

Would doing this be correct?

ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
switch (ret) {
case 0:
case -ENODEV:
	break;
case -EPROBE_DEFER:
	return -EPROBE_DEFER;
default:
	dev_err(&pdev->dev, "Failed to get enabled regulator: %d\n",
		ret);
	return ret;
}

I understand that we would get -ENODEV in case of the regulator being
unavailable, which we would ignore (this is the "equivalent" of
devm_regulator_get_optional failing in the original code). And in case
of enable failing, we would get some other error, which we would handle.

Thanks for being patient with me by the way, hopefully I will learn quickly :)

Best regards,
Mateusz
