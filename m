Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5267378F690
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348010AbjIABHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjIABHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:07:46 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFD4C0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 18:07:40 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230901010736epoutp039886f1cad3e37de37709c8e40b031a65~AoPoxjYpi2087020870epoutp03Z
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:07:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230901010736epoutp039886f1cad3e37de37709c8e40b031a65~AoPoxjYpi2087020870epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693530456;
        bh=TWUihyjImQSBvSzAnLEVBpAHA8hqk5DUUsqb5h6VCgU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mDhqSS/uUWtFqHbBef7sSuVoVc3ow5LMtwRCOwJedELVMNEhpdot+GZAx9fvB9Y7f
         yke1ZN/+CXEbh2a0aCVCIICdMpUAS1tSZ2ev47xeycoIiI0GvUb0S4lvX/gm0Yz6M4
         Ic5Au3LTr92UfDlnxh9WBqh+vghNAc/Lq1vA5dUM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230901010735epcas2p3b0cb03b5243ce310825f6fca61a87706~AoPoT6xQ50273402734epcas2p3T;
        Fri,  1 Sep 2023 01:07:35 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RcKdM28vlz4x9Q0; Fri,  1 Sep
        2023 01:07:35 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.ED.09660.75931F46; Fri,  1 Sep 2023 10:07:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230901010734epcas2p4aadced02d68d3db407fda23de34601d2~AoPnTNrfy1950619506epcas2p4r;
        Fri,  1 Sep 2023 01:07:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230901010734epsmtrp1b3325334f442cb623ae99dec827316b5~AoPnSkWpy2935729357epsmtrp1o;
        Fri,  1 Sep 2023 01:07:34 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-e2-64f13957170b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.CF.08788.65931F46; Fri,  1 Sep 2023 10:07:34 +0900 (KST)
Received: from KORCO045595.samsungds.net (unknown [10.229.38.76]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230901010734epsmtip28240f2b1d54fc586ccbbdeec49855683~AoPnHJwYc2052620526epsmtip2u;
        Fri,  1 Sep 2023 01:07:34 +0000 (GMT)
From:   Bongkyu Kim <bongkyu7.kim@samsung.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bongkyu7.kim@samsung.com
Subject: [PATCH v2 0/2] Make reader optimistic spinning optional
Date:   Fri,  1 Sep 2023 10:07:02 +0900
Message-Id: <20230901010704.18493-1-bongkyu7.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDJsWRmVeSWpSXmKPExsWy7bCmqW645ccUg0cT+C1eN75kslizpZHJ
        onnxejaLy7vmsFmcPnaCxeLSgQVMFsd7DzBZtNwxdeDw2DnrLrvH5hVaHptWdbJ57J+7ht3j
        /b6rbB59W1YxenzeJBfAHtXAaJNYlJyRWZaqkJqXnJ+SmZduqxQa4qZroaSQkV9cYqsUbWho
        pGdoYK5nZGSkZ2oUa2VkqqSQl5ibaqtUoQvVq6RQlFwAVJtbWQw0ICdVDyquV5yal+KQlV8K
        8ohecWJucWleul5yfq6SQlliTinQCCX9hG+MGV/2fmQsOCRcMXf3M7YGxkbeLkZODgkBE4nV
        E/4ydjFycQgJ7GCUWHtvKROE84lR4ticJ1DON0aJab+2M8G0vJx1kRUisZdRYsL0GcxwVV/O
        v2UEqWIT0JH4v3oGUAcHh4hAusTCF/kgYWaBCInJq9rZQWxhAQeJpdu2gA1lEVCV6H5xgBXE
        5hWwlWi+PxFqmbzEzEvf2SHighInZz5hgZgjL9G8dTbYXgmBW+wSRy9NZINocJFYueAXO4Qt
        LPHq+BYoW0riZX8blJ0tcebOeUYIu0Li5d8/UHFjiVnP2hlBbmYW0JRYv0sfxJQQUJY4cgtq
        LZ9Ex+G/UNWCEqevdTNDlPBKdLQJQYTVJHY/b2WFsGUkDp5dC/WJh8S1g5PBbCGBWIkP8z4z
        TWBUmIXksVlIHpuFcMMCRuZVjGKpBcW56anFRgXGyFG8iRGccLXcdzDOePtB7xAjEwfjIUYJ
        DmYlEd5Ys3cpQrwpiZVVqUX58UWlOanFhxiTgUE9kVlKNDkfmPLzSuINzcwsLSyNTC0sTU0t
        CAubWBqYmJkZmhuZGpgrifPea52bIiSQnliSmp2aWpBaBLOFiYNTqoGJo7F5Z/VU6QuP+Pdx
        N19QbKjbHPzIs/XeFtmGu3/e8jGH2fWyZfEsZwtQK1jYLz1/TofZZd3kdzPvSLLJTD77riLv
        Off331Ltds4PuR7+nqsV9t+oJnK1UvZTR9Z5MyL4ZMqYloY8z5WU8DSY1rZo597mxwrCJ52n
        ZXEWPF25PEb33Bw5pQL/Q6enL/Wzb2xpMZ3Ge2c+68s1/A/XsHTf+ZN/4ISFzdVF+p98Nvp/
        /7nBXW3x03DP9a+ehwnf+avS8a6GTyg4nq3/NdfKYiZRgbSg/o3/Ct7l91l6lx72StZetMXB
        MMvf0WXGTqkb2eYP37SU3s2xDhVTNE+Ly5L2eVCltZd5SVtn4O9fVkosxRmJhlrMRcWJAHbB
        idNvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvG6Y5ccUg4+/1S1eN75kslizpZHJ
        onnxejaLy7vmsFmcPnaCxeLSgQVMFsd7DzBZtNwxdeDw2DnrLrvH5hVaHptWdbJ57J+7ht3j
        /b6rbB59W1YxenzeJBfAHsVlk5Kak1mWWqRvl8CV8WXvR8aCQ8IVc3c/Y2tgbOTtYuTkkBAw
        kXg56yJrFyMXh5DAbkaJU1/OsUEkZCQO/VvLBGELS9xvOQJV9IVRYvOCa2AJNgEdif+rZ4DZ
        IgK5Ek+/XAKzmQWiJL5PWsoCYgsLOEgs3bYFLM4ioCrR/eIAK4jNK2Ar0Xx/ItQCeYmZl76z
        Q8QFJU7OfMICMUdeonnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhglJdarlecmFtcmpeu
        l5yfu4kRHMBaWjsY96z6oHeIkYmD8RCjBAezkghvrNm7FCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK83173pggJpCeWpGanphakFsFkmTg4pRqYBP9bHY+ME110ZC7T14Spj0/uW5MVubdl6ct4
        ZiEPbU22DVdWdl5arWg7/3/Mzs5gv2i29pdS/T8eWvyU6PXcH6kczGsQGfrb/qrfrp32R9yV
        TtqoJz/X2rNEcaf3/VSDfwmcc/+lvJI7JOliZ3ih2HGN6Q8+rW+Ob+KFjxeHs7ftCDnwSpmn
        6rR1nWbxv/Pem6YsbjkQfzC4TL9C5ueJsvSKefMqS/nTHt/kXfXxoNGZFScTohV1tjGGVF3y
        33O9yfrCibPmEzZ6FCRMOahcILzNst7oJLe427Hdl55vmJC+MM01tcQx43/v0/kVTbOsO06d
        DCjOT5TwFfPi2Pkj6bBfoWyE4qXsGoYcv99KLMUZiYZazEXFiQCJc6nozwIAAA==
X-CMS-MailID: 20230901010734epcas2p4aadced02d68d3db407fda23de34601d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230901010734epcas2p4aadced02d68d3db407fda23de34601d2
References: <CGME20230901010734epcas2p4aadced02d68d3db407fda23de34601d2@epcas2p4.samsung.com>
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

Changes v1 -> v2:
- Move the rwsem_opt_rspin definition out of the "ifdef
  CONFIG_RWSEM_SPIN_ON_OWNER" and add _ro_after_init to rwsem_opt_rspin.

Bongkyu Kim (2):
  Revert "locking/rwsem: Remove reader optimistic spinning"
  locking/rwsem: Make reader optimistic spinning optional

 .../admin-guide/kernel-parameters.txt         |   9 +
 kernel/locking/lock_events_list.h             |   5 +-
 kernel/locking/rwsem.c                        | 297 +++++++++++++++---
 3 files changed, 263 insertions(+), 48 deletions(-)

-- 
2.36.1

