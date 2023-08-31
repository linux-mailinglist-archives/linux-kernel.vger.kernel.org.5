Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A513E78E4E3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbjHaDBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHaDBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:01:01 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE0ECC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:00:55 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230831030050epoutp035ed4aada6424e3de8e805938b3e09ace~AWJN1SEq33047730477epoutp03Q
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:00:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230831030050epoutp035ed4aada6424e3de8e805938b3e09ace~AWJN1SEq33047730477epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693450850;
        bh=negB90cgT7fzCzLO1kejSOPU96f/89kJ0HmhiGt5VqE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fG1j4E4WAr8SGZN/8dEch8D/lUMzrXJYv4s3DdzvkJFJnV2NgXJ824WVjIQUviUWR
         35sPNu1vshkAY6ekHp8AnWZ/QQa0b53uZPpaPNU7h5Hvw8K33EGMcMFqUUyr9Yixeg
         Isczc5jCi/WtrvovMl84T/KqsE9Co7p6ssM+95OI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230831030049epcas2p1bffcd26994209e6fcad9018c4e856dbc~AWJNYJ05I0094000940epcas2p1F;
        Thu, 31 Aug 2023 03:00:49 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RbmBT1Qppz4x9Q3; Thu, 31 Aug
        2023 03:00:49 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.78.09765.16200F46; Thu, 31 Aug 2023 12:00:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230831030048epcas2p4de6faba4d56212b06939421feb0bc56d~AWJMPswRV2073520735epcas2p4g;
        Thu, 31 Aug 2023 03:00:48 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230831030048epsmtrp297cb949fe5deff0a2563d47a9f4d5775~AWJMO-At42728227282epsmtrp2k;
        Thu, 31 Aug 2023 03:00:48 +0000 (GMT)
X-AuditID: b6c32a48-66ffa70000002625-ed-64f00261ba17
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.7E.08788.06200F46; Thu, 31 Aug 2023 12:00:48 +0900 (KST)
Received: from KORCO045595.samsungds.net (unknown [10.229.38.76]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230831030048epsmtip2fe38baec4ed4bef8558184a7a7135c03~AWJMDBS-72603126031epsmtip2Z;
        Thu, 31 Aug 2023 03:00:48 +0000 (GMT)
From:   Bongkyu Kim <bongkyu7.kim@samsung.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bongkyu7.kim@samsung.com
Subject: [PATCH v1 0/2] Make reader optimistic spinning optional
Date:   Thu, 31 Aug 2023 12:00:02 +0900
Message-Id: <20230831030004.16576-1-bongkyu7.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmuW4i04cUg627WCxeN75kslizpZHJ
        onnxejaLy7vmsFmcPnaCxeLSgQVMFsd7DzBZtNwxdeDw2DnrLrvH5hVaHptWdbJ57J+7ht3j
        /b6rbB59W1YxenzeJBfAHtXAaJNYlJyRWZaqkJqXnJ+SmZduqxQa4qZroaSQkV9cYqsUbWho
        pGdoYK5nZGSkZ2oUa2VkqqSQl5ibaqtUoQvVq6RQlFwAVJtbWQw0ICdVDyquV5yal+KQlV8K
        8ohecWJucWleul5yfq6SQlliTinQCCX9hG+MGev3T2MvWCVU0X7rBWMDYzNPFyMnh4SAicSL
        b2+Zuhi5OIQEdjBKnFh4mxHC+cQosfrsGqjMN0aJLct2MsO0/G3bwgRiCwnsZZS4vrkSrujr
        7JNgRWwCOhL/V88AKuLgEBFIl1j4Ih8kzCwQITF5VTs7iC0s4CCx9MAuVhCbRUBVovnoczYQ
        m1fAVmLV0/eMELvkJWZe+s4OEReUODnzCQvEHHmJ5q2zmUH2SgjcY5eYuHMlG0SDi8TS2V+h
        moUlXh3fwg5hS0l8frcXqiZb4syd81A1FRIv//6BqjGWmPWsnRHkZmYBTYn1u/RBTAkBZYkj
        t6DW8kl0HP4LVS0ocfpaNzNECa9ER5sQRFhNYvfzVlYIW0bi4Nm1TBAlHhLfvqRCAi1WYu/e
        lSwTGBVmIflrFpK/ZiGcsICReRWjWGpBcW56arFRgQlyBG9iBCdbLY8djLPfftA7xMjEwXiI
        UYKDWUmEN9bsXYoQb0piZVVqUX58UWlOavEhxmRgSE9klhJNzgem+7ySeEMzM0sLSyNTC0tT
        UwvCwiaWBiZmZobmRqYG5krivPda56YICaQnlqRmp6YWpBbBbGHi4JRqYGryzk1ZvbRKKPV1
        0tKmmacMjr812N1xScB/+9IwTSarmv53zQ+EUhdvEnq29Ilmo132Nan2oHm3ZxQ93e2/a8kx
        T/WA+GWVjx+IR6U+mLbz/wrPM4tKS16IbNvy4emKW1KbEg5+Zln7+d2jjpoHWzfOE7zuaLT+
        3nlndms2i1yeCr2txTNlL3Ad3f8sUPu31raVG6/dq4/b/jPj+8dzW87dyrwQ+aP8I//CozYt
        WbpXMovnmu1fXqpy27ZKtPdTzrvN66rVtA/X7jNLcFqwqY353U+TdNvHs59HzTK+4fInNtfp
        YaKuK1fwsdLzXnM2VvtzeM7vrTq4Yu/uN71VnnJ+qnU89o+VVqWf1IvcGPNHiaU4I9FQi7mo
        OBEArVAFo20EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSvG4C04cUg+YLUhavG18yWazZ0shk
        0bx4PZvF5V1z2CxOHzvBYnHpwAImi+O9B5gsWu6YOnB47Jx1l91j8wotj02rOtk89s9dw+7x
        ft9VNo++LasYPT5vkgtgj+KySUnNySxLLdK3S+DKWL9/GnvBKqGK9lsvGBsYm3m6GDk5JARM
        JP62bWECsYUEdjNKnG20gIjLSBz6t5YJwhaWuN9yhLWLkQuo5gujROfqAywgCTYBHYn/q2eA
        FYkI5Eo8/XIJzGYWiJL4PmkpWI2wgIPE0gO7WEFsFgFVieajz9lAbF4BW4lVT98zQiyQl5h5
        6Ts7RFxQ4uTMJywQc+QlmrfOZp7AyDcLSWoWktQCRqZVjJKpBcW56bnFhgVGeanlesWJucWl
        eel6yfm5mxjB4aultYNxz6oPeocYmTgYDzFKcDArifDGmr1LEeJNSaysSi3Kjy8qzUktPsQo
        zcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoFpsa3cn1jDVXtZkgycJpxeVWLJ8uzvVnmT
        f9KTyuJa1wlP01dccc/owWH9nPNzWjtz+lefMJ73PlPPM37f8Wt8hs6inyz7lq1bmPYxSKGz
        1q3zIM8mObnLFxuVPmQGC865LfQtdKJhsswiHtajZ87Iyen0ft2zNebPBE52+faEjKW3fP8k
        XF7z/23p34aNPOvLynd8XbJ1j1mFeGFpuI/Jy/U/wnwyKs4k1NXuvPkqasLzeWsPP1tqzmPx
        7QPj/5s/Xr3LuDBTf8LTCqv1Hk0T/ti4yrZxZEXNa7Iu75jru4pjbuq2l7NSm6L/f2o0OeV1
        e+thrjdrubaFH+31m8+64X6Y9pJg/1X7T/U2G18yVWIpzkg01GIuKk4EAKSZ2kPOAgAA
X-CMS-MailID: 20230831030048epcas2p4de6faba4d56212b06939421feb0bc56d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230831030048epcas2p4de6faba4d56212b06939421feb0bc56d
References: <CGME20230831030048epcas2p4de6faba4d56212b06939421feb0bc56d@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is rework of the following discussed patch.
https://lore.kernel.org/all/20230613043308.GA1027@KORCO045595.samsungds.net/

Changes from the previous patch
- Split to revert and modify patches
- Change according to Waiman Long's review
    More wording to documentation part
    Change module_param to early_param
    Code change by Waiman Long's suggestion

In mobile environment, reader optimistic spinning is still useful
because there're not many readers. In my test result at android device,
it improves application startup time about 3.8%
App startup time is most important factor for android user expriences.
So, re-enable reader optimistic spinning by this commit. And,
make it optional feature by cmdline.

Test result:
This is 15 application startup performance in our exynos soc.
- Cortex A78*2 + Cortex A55*6
- unit: ms (lower is better)

Application             base  opt_rspin  Diff  Diff(%)
--------------------  ------  ---------  ----  -------
* Total(geomean)         343        330   -13    +3.8%
--------------------  ------  ---------  ----  -------
helloworld               110        108    -2    +1.8%
Amazon_Seller            397        388    -9    +2.3%
Whatsapp                 311        304    -7    +2.3%
Simple_PDF_Reader        500        463   -37    +7.4%
FaceApp                  330        317   -13    +3.9%
Timestamp_Camera_Free    451        443    -8    +1.8%
Kindle                   629        597   -32    +5.1%
Coinbase                 243        233   -10    +4.1%
Firefox                  425        399   -26    +6.1%
Candy_Crush_Soda         552        538   -14    +2.5%
Hill_Climb_Racing        245        230   -15    +6.1%
Call_Recorder            437        426   -11    +2.5%
Color_Fill_3D            190        180   -10    +5.3%
eToro                    512        505    -7    +1.4%
GroupMe                  281        266   -15    +5.3%

Bongkyu Kim (2):
  Revert "locking/rwsem: Remove reader optimistic spinning"
  locking/rwsem: Make reader optimistic spinning optional

 .../admin-guide/kernel-parameters.txt         |   9 +
 kernel/locking/lock_events_list.h             |   5 +-
 kernel/locking/rwsem.c                        | 299 +++++++++++++++---
 3 files changed, 265 insertions(+), 48 deletions(-)

-- 
2.36.1

