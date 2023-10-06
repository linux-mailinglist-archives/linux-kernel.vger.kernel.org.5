Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC37BC01C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjJFUPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjJFUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:15:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06C9BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:15:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231006201516euoutp0169f02b89b10c15b55e14ad8cb16b59c3~LnervTlek1707617076euoutp01H
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 20:15:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231006201516euoutp0169f02b89b10c15b55e14ad8cb16b59c3~LnervTlek1707617076euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696623317;
        bh=6zBqI2ZSiH14E7wKQqIifsZ8uCMUdIs3KFK3jYCirhw=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=EgLihhjs3Ve/g0CwnL4IfgpbIaGqfoDRL/vpjGvW4DttM/1qVAqBR7ylPSyeYeKF2
         foKNDV84EshsP8dhKkr5Ggji5SNNrrGSv+zjX4IZVB8IuTjMIuezWnNzn+MZfd3Gza
         /386XCB71jW67sV97ZA6Fk7iv1C6Mz98w1pPV4W8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231006201516eucas1p10086c38098d8dd24832c2497e9c34077~LnerO1Pt00416604166eucas1p11;
        Fri,  6 Oct 2023 20:15:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 51.8F.42423.4DA60256; Fri,  6
        Oct 2023 21:15:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231006201515eucas1p1660e31608dcc3be8f3157ded979ecb77~LneqsqR4L0331503315eucas1p1j;
        Fri,  6 Oct 2023 20:15:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231006201515eusmtrp2f3ffcc3628bc5230773a544aec76b285~Lneqrpy-v1887118871eusmtrp2H;
        Fri,  6 Oct 2023 20:15:15 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-c7-65206ad4df32
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 36.6F.10549.3DA60256; Fri,  6
        Oct 2023 21:15:15 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231006201514eusmtip2cb54bd23a8e9e3f92b601c9a14bac23a~LnepYUJT61358713587eusmtip2y;
        Fri,  6 Oct 2023 20:15:14 +0000 (GMT)
Message-ID: <db78e251-acd1-496a-bfcd-202ef1d43f31@samsung.com>
Date:   Fri, 6 Oct 2023 22:15:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct
 se
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "joshdon@google.com" <joshdon@google.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        Pavel Machek <pavel@ucw.cz>, "pjt@google.com" <pjt@google.com>,
        "qperret@google.com" <qperret@google.com>,
        "qyousef@layalina.io" <qyousef@layalina.io>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "timj@gnu.org" <timj@gnu.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "youssefesmat@chromium.org" <youssefesmat@chromium.org>,
        "yu.c.chen@intel.com" <yu.c.chen@intel.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20231006192445.GE743@noisy.programming.kicks-ass.net>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHOffe3pYuNdcC6QmCbA2MQSIFo/MkWxTmHNcMx5ZFkzVR18G1
        vAquhXW6Jdatq7xfTtFSXiGxwHBIRbDIGBK0hWF5KUOGYyIwSniIcwiMxyi3bvz3/X7P5+T7
        +50cHi5sJD15sYnJjDJRliAm+UT93cWuHffjXmWCs6weqPjmPIZ6nzwgUYH9LIHmr+aTaLTl
        HEBjuTdwVD01SKBvy2tIdEXjh+amBOhRzgUCraSFob5GA4lu2GcwdH5mHKAfVjsAMnZcI9Gj
        jjsksmS1YMhcWcFBnaZ6Ak2nLXNQc+ofGLpuuoCj/vwSEnWv1hIotW0eR33aPBzZvwkM9aa/
        610h6eriakBXThRy6UJND0E/nTtG6y6+SWubB7l0qSmFvl4RSJc32TG67NnfHNpUlUbSo/oy
        jB7qbyLpGZuNSxe3f/QhlPLfjmYSYr9glJK9n/JjzOYm4uSk4MucfhumAQWvpANXHqR2Qfvs
        LJ4O+DwhVQFg9aKWZM1zALuK7ARr/gJwaHYAe3klL2PBSRkBvH2lzmnmAGy02QgHJaD2wp7e
        HNyhCcoXPlxrB2y+FbZfHt1gPCgfODx4ievQblQkbNJZN3icEsHB0ZKNNnfqIBwbyXbmlXxY
        9YByaJIKgenT6evFPJ4rtR++KD/CIj6wYdqAs4Pe4cOJpVBWvwur+8e5rHaDk5Y6p/aCa2ZH
        FX9dnwOw9J9hp8kFUPPnIGCpt+CQbWmjDKcCYE2jhI3DYMNMEe6IIbUFDkxvZWfYAvPrC5yx
        AKbqhCz9OtRbfvyv9nZ3L54LxPpNj6LftLx+0zb6/3tLAVEFREyKSiFnVCGJjDpIJVOoUhLl
        QVFJChNY/96/rFqe3QRFk3NBrQDjgVYAebjYXSDXeDFCQbTs1GlGmXRcmZLAqFrBNh4hFgn8
        on0YISWXJTPxDHOSUb48xXiunhpMa807ePnWgrd66diLYFGKmzTgjbvWFX3Uw8+MOwu2X915
        OPNj4z4Xw8qunooz3N3C75/UeNYqDphJZmSfl3/fUWNnWGTX6K/bI0d2hHWfOu1/lFsT+n5X
        1GLsB9JlzuxvGZa45EXq0mtBPzcE6USGzIinXZOSn7DHgZ/He3YWfWI7uyfiQPh9v+y2hZbx
        Q3VJootuh64Z77lMtxwOrpNLs5vvyceV4oH3pKvq6DJ3+9dmC2dIvCbxGytxp9USKqu5NnSP
        IfLICc2t3RNpvl8dn3onPGM5ojnOPybAW6jNjK/RzQCPcA9f43PtsESde+aES1v0yO+F1ob9
        ISVJFsVjzrZgMaGKkYUE4kqV7F+wC53cTQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsVy+t/xe7qXsxRSDVq+6VnM2/GNyeLS46ts
        FtNfNrJYfFs7ic3iyYF2RounE7YyW6x5c4vFonnxejaLZQ2qFh/f8Frc7Z/KYvG309Hi8q45
        bBZbX75jspj87hmjxep/pxgtlp/awGZx99RRNovjvQeYLHauXMFqcWbTNhaLt51/WC32dTxg
        sti8aSqzxbVJ89ksLvzbyGLRceQbs8XllonMFi+btBxkPVov/WXzWDNvDaPHyhez2T1mN1xk
        8fjwMc6jbZqZR8u+W+weCzaVemxeoeWxeM9LJo+Fn76yemxa1cnm8WTWQiaPO9f2sHm8O3eO
        3WPeycAAiSg9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9
        uwS9jJ0797AUvOKt6L92jqmBcTp3FyMnh4SAicTE7h9sXYxcHEICSxklFt+/ywSRkJE4Oa2B
        FcIWlvhzrQuq6D2jxIezZ1lAErwCdhIXL/Uzg9gsAioSN/+fZISIC0qcnPkErEZUQF7i/q0Z
        7CC2sICvxPrWKWD1zALiEreezAdbJiLgKfH0UR8zyAJmga1cEp++97JDbJvGKrFq4VawqWwC
        hhJdb0HO4ODgFHCW+L44DGKQmUTX1i5GCFteYvvbOcwTGIVmIbljFpJ9s5C0zELSsoCRZRWj
        SGppcW56brGhXnFibnFpXrpecn7uJkZgwtp27OfmHYzzXn3UO8TIxMF4iFGCg1lJhDe9QSZV
        iDclsbIqtSg/vqg0J7X4EKMpMDAmMkuJJucDU2ZeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBA
        emJJanZqakFqEUwfEwenVANTsOeudwbH977Ye9f384/KXw9PXX56aYt49dyC8rhI1ycrY2L5
        S/b8+CJQKvn7XN89d9F/V2/53b25TmBSY4VZTuTiDZInE6T3fnr+r+HzxmU95X9VSjpyedul
        jQseFwqcmh0dt7925aw3oYGpOdNOvwmT3Xqd/+rmBVVzZ4fM+LSNy2G9USRn17pv+flWks/3
        Op56rX5G+fL+vhaND73Ld8vwvubeEh34L6bE+9iKP7uT6pzyPpwTjLzHNveCVOvKvs82p0sZ
        mVYISWSXN3x/e/Z//wFjVeV/zVdMZq9o6dthIpx4bqP013+ntL4d0OqPO2kmaOS5Wjd3QmWM
        c7SoTecCdX8+O3uj0klX9EO3KbEUZyQaajEXFScCAMnwWdDhAwAA
X-CMS-MailID: 20231006201515eucas1p1660e31608dcc3be8f3157ded979ecb77
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <20231005150258.GA36277@noisy.programming.kicks-ass.net>
        <CGME20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733@eucas1p1.samsung.com>
        <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
        <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
        <20231006140042.GG36277@noisy.programming.kicks-ass.net>
        <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
        <20231006155501.GH36277@noisy.programming.kicks-ass.net>
        <20231006192445.GE743@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.2023 21:24, Peter Zijlstra wrote:
> On Fri, Oct 06, 2023 at 05:55:01PM +0200, Peter Zijlstra wrote:
>> And yeah, min_deadline is hosed somehow.
>>
>> migration/28-185     [028] d..2.    70.264274: validate_cfs_rq: --- /
>> migration/28-185     [028] d..2.    70.264277: __print_se: ffff88845cf48080 w: 1024 ve: -58857638 lag: 870381 vd: -55861854 vmd: -66302085 E (11372/tr)
>> migration/28-185     [028] d..2.    70.264280: __print_se:   ffff88810d165800 w: 25 ve: -80323686 lag: 22336429 vd: -41496434 vmd: -66302085 E (-1//autogroup-31)
>> migration/28-185     [028] d..2.    70.264282: __print_se:   ffff888108379000 w: 25 ve: 0 lag: -57987257 vd: 114632828 vmd: 114632828 N (-1//autogroup-33)
>> migration/28-185     [028] d..2.    70.264283: validate_cfs_rq: min_deadline: -55861854 avg_vruntime: -62278313462 / 1074 = -57987256
>>
>> I need to go make dinner (kids hungry), but I'll see if I can figure out
>> how this happens...
> *sigh*, does the below help?

It looks that this fixed the issue. At least I was no longer able to 
reproduce it.

Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04fbcbda97d5..6a670f119efa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3632,6 +3747,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   		 */
>   		deadline = div_s64(deadline * old_weight, weight);
>   		se->deadline = se->vruntime + deadline;
> +		min_deadline_cb_propagate(&se->run_node, NULL);
>   	}
>   
>   #ifdef CONFIG_SMP
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

