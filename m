Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1CF7BB34F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjJFIgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjJFIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:36:35 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C899F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:36:32 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231006083631euoutp026e1c6fe5d4aabe5e95cf85a7efd76103~Ld8lYEbs70355603556euoutp02Y
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:36:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231006083631euoutp026e1c6fe5d4aabe5e95cf85a7efd76103~Ld8lYEbs70355603556euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696581391;
        bh=dcfG4wemciT6t0iYHNHA19d9/iViwI8os+brYmKlqrw=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=ZlzoA3Samh5OxhZaUjV8wF8vODgtk6wxiR3xPdhqNvVx37eGBPtJ1QuqJ59MPZtqh
         2w9+JNMC5cS+hYOYRLokMCvas8XSsnz2kdtBJy00VrHGZjoagEiU/IxcgnjHftMvRM
         qSq/NJ4FRDermDLIsySq84IA8aZ81HeFnK+clgao=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231006083630eucas1p108dbbf9e4a6f7677898f90b78046d5f8~Ld8koOQW40583405834eucas1p1Z;
        Fri,  6 Oct 2023 08:36:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 61.8F.42423.E07CF156; Fri,  6
        Oct 2023 09:36:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231006083630eucas1p2c7042b256cf08ff4434f0fafa2def2e9~Ld8kM5t0P1183811838eucas1p2u;
        Fri,  6 Oct 2023 08:36:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231006083629eusmtrp2befcb011a282e84e3d0313164338ab10~Ld8kKBYZV1558415584eusmtrp2b;
        Fri,  6 Oct 2023 08:36:29 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-ba-651fc70eb44d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B1.6F.10549.D07CF156; Fri,  6
        Oct 2023 09:36:29 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231006083628eusmtip23f97733562f5360bac503bc786c3099f~Ld8ijxwaI2789127891eusmtip2F;
        Fri,  6 Oct 2023 08:36:28 +0000 (GMT)
Message-ID: <62ca6115-cf0d-427d-92c5-3539a361b476@samsung.com>
Date:   Fri, 6 Oct 2023 10:36:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct
 se
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "bsegall@google.com" <bsegall@google.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "efault@gmx.de" <efault@gmx.de>,
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
Content-Language: en-US
In-Reply-To: <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxj23Ht7KcWSS9H0RCF1dTSDbTCyZZ6NpU6c8/4Cx5zbEMc6uEEm
        FGnpNonJ2qlAC0wsIliUjxERCqIWKB9Dg6BWPoeQqWv42gCxjFbLBpkKZZTWjX/P87zv877v
        c3LYOO8auYmdKE1jZFJJkpDkEMbbT3953dskYN7QK/mopHkBQ4MTv5Ko0KIi0MIlLYkm2zMB
        msprxFHtrJlAxyouk6hSGYDss1w0crKAQEvqHWio9RyJGi02DOXbHgJU4+gG6GL3FRKNdN8i
        kSm3HUMt1VUs1GswEsiqXmSh61njGKo3FODonraURAOOqwTKurmAo6Hjp3Bk+SHofX/6xOAS
        SdeW1AK6+lGxB12svEvQT+xf0Bln3qaPXzd70GUGBV1fFURXtFkwunxunkUb9GqSntSVY/Tw
        vTaStvX3e9AlXR/tgdGc9+KZpMRvGFmI+EvOwb5jE/jhBe/v7HU/spSgcr0GeLIh9RYcediH
        awCHzaOqALz2eNFN/gawNvt3wkX+ArDo7rDHC4ul0shyFS4CmKcvdhM7gKPFS6Szi0uJ4dmJ
        ZeDEBPUyXCz8Gbh0H9h1dpJw4o2UAI6Zi1anklQo1Fg1q15fKhK2ZdzBnXgDFQVnDJ2rZ+BU
        BQeqlHrMWcApPjRPlq5iT+oAnG9YZrl0AWyynlsNAalbHNiU34657v4AVubPAhf2hTOmBnce
        P7jc4hzkNGQCWPZ8zE3yAFROm92OMDjc/2zlPvbKikB4uTXEJe+ATbbzuFOGlDd8YPVxHeEN
        tcZCt8yFWRk8V7cI6kx1/629MTCI5wGhbs276NZE062Jo/t/bxkg9IDPKOTJCYw8VMp8GyyX
        JMsV0oTguJRkA1j54T0O01wzOD9jD+4AGBt0AMjGhRu4CUo/hseNlxxJZ2QpsTJFEiPvAJvZ
        hJDPDYgXMDwqQZLGHGKYw4zsRRVje25SYtq4+c6hf1obDuUYPw/3ux/zZr41Yrpmd0nHOr8C
        ddeu7UNHNb81VvO3K57yb+954IWuhPH8z8S9Ft2rfrd+38C4yNOvZ79o386opY9f/XCLXKS+
        kDn/uCjNkdSb4et1Oiww4p3RS/HPprUZIGCv8HTuXJtxKQZjYqMEUsHQyakUzaPUjbtUdVtu
        xCt+0telppR/VuUT8mesXD7wtbgy+6u9pq0392tUxhyr5oC5Jz082icmW7ntk7ELIotVG3F1
        8+71jvGWxb4x61iEf8jR5nCzzevJzuQpcU1kpOh+Yv2pUhMUj85tO6L1VA0H2idz1vmmjpx4
        6VOG/X368z867uR2Rr0iJOQHJaFBuEwu+Rc7bhBpUAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsVy+t/xe7q8x+VTDQ7+NbWYt+Mbk8Wlx1fZ
        LKa/bGSx+LZ2EpvFkwPtjBZPJ2xltljz5haLRfPi9WwWyxpULT6+4bW42z+VxeJvp6PF5V1z
        2Cy2vnzHZDH53TNGi9X/TjFaLD+1gc3i7qmjbBbHew8wWexcuYLV4symbSwWbzv/sFrs63jA
        ZLF501Rmi2uT5rNZXPi3kcWi48g3ZovLLROZLV42aTnIerRe+svmsWbeGkaPlS9ms3vMbrjI
        4vHhY5xH2zQzj5Z9t9g9Fmwq9di8Qstj8Z6XTB4LP31l9di0qpPN48mshUwed67tYfN4d+4c
        u8e8k4EBElF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6
        dgl6GWebHzMXfOOr+Liuj7WBcRlPFyMnh4SAicTLZdtYQWwhgaWMEpNnlUHEZSROTmtghbCF
        Jf5c62LrYuQCqnnPKPH9Yw8bSIJXwE5i5uP/jCA2i4CKxJ/puxkh4oISJ2c+YQGxRQXkJe7f
        msEOYrMJGEp0ve0C6xUW8JVY3zqFGcQWEQiSONSxCqyeWWA9l8T9X0kQy/YxSTz5+4wVIiEu
        cevJfCYQm1MgVuLrlv9QcTOJrq1djBC2vMT2t3OYJzAKzUJyxywk7bOQtMxC0rKAkWUVo0hq
        aXFuem6xoV5xYm5xaV66XnJ+7iZGYLraduzn5h2M81591DvEyMTBeIhRgoNZSYQ3vUEmVYg3
        JbGyKrUoP76oNCe1+BCjKTAwJjJLiSbnAxNmXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpi
        SWp2ampBahFMHxMHp1QDk4PBlgncVjFLPYv3MOa4Fyk420z84LXd6G/8k9QOXp7gazdezcyx
        K4n9qbBSuOebUsK+V9uumQjYpmlzr1396BnP18AjK5Zyd0/bHev6Z7PwxaIWjq7q1W8+fuO6
        pGPV/CP3wRMuLt8Nf0M+3+G78ffSY+fOVMe9vX6+oaJLtl9Z/aBtgv/GZOn4BScumjmLbJqv
        cLz/RMF9JYFPYT9ZNn31TomZtOxn6H0tu9o9P5lfH0md9/7mKtcn15UtN9kEH92z0EbwN/sV
        32c13022Nwmvfu2nvOairUY7R8IK71sKoWqTWxT5+SzbjgvfbnaeoVuacvntxOtvmTYXXb68
        T3jpuk+L5Lcuk+pctbB+YaMSS3FGoqEWc1FxIgB4a+EE4AMAAA==
X-CMS-MailID: 20231006083630eucas1p2c7042b256cf08ff4434f0fafa2def2e9
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

On 05.10.2023 17:08, Biju Das wrote:
> Hi Peter Zijlstra,
>
>> Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct
>> se
>>
>> On Thu, Oct 05, 2023 at 07:31:34AM +0000, Biju Das wrote:
>>
>>> [   26.099203] EEVDF scheduling fail, picking leftmost
>> This, that the problem.. the rest is just noise because printk stinks.
>>
>> Weirdly have not seen that trigger, and I've been running with this patch
>> on for a few days now :/
> I agree Original issue is "EEVDF scheduling fail, picking leftmost"
> Which is triggering noisy lock warning messages during boot.
>
> 2 platforms are affected both ARM platforms(Renesas and Samsung)
> Maybe other platforms affected too.


Just to note, I've run into this issue on the QEmu's 'arm64/virt' 
platform, not on the Samsung specific hardware.


You can easily reproduce it with the following steps:

# make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

# ./scripts/config -e PROVE_LOCKING -e DEBUG_ATOMIC_SLEEP -e PM_DEBUG -e 
PM_ADVANCED_DEBUG

# make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- olddefconfig Image.gz

# wget 
https://cloud.debian.org/images/cloud/buster/20230802-1460/debian-10-nocloud-arm64-20230802-1460.tar.xz

# tar xJfv debian-10-nocloud-arm64-20230802-1460.tar.xz


Then run QEmu a few times until you see the lockdep splat:

# qemu-system-aarch64 -serial stdio -kernel arch/arm64/boot/Image 
-append "console=ttyAMA0 root=/dev/vda1 rootwait" -M virt -cpu 
cortex-a57 -smp 2 -m 1024 -netdev user,id=user -device 
virtio-net-device,netdev=user -display none -device 
virtio-blk-device,drive=virtio-blk0 -drive 
file=disk.raw,id=virtio-blk0,if=none,format=raw


I have no idea if this is ARM64-specific anyhow, but this is how I 
reproduced it. I hope this guide helps fixing the bug!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

