Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1477D7BBD54
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjJFQzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJFQzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:55:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF4BF;
        Fri,  6 Oct 2023 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696611274; x=1697216074; i=efault@gmx.de;
 bh=MCAADQhbSkE3KtyWK709uz6mAeBmApXYof1OrAn54Sk=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=kbLAo5rWYcEnQEiu7bJqiOfQYlQUTQppuG8uo5j+dIM6ZxVuBFfSrw62rFE4QHLDYhq0DXcGDtw
 q17773XMh+BZLNZuYtOvCT0tjQjLnk6UBP+jC+wkWHvMvyI309n3gWK6xHoadML4jSEMdxbanGxFQ
 nGuo34ekMPXYbzEsb0jOkt6twetjk0spAfF29I1J6z1mc5aQo1WU5soITSw1M+mFmN6/qsSDMOoCv
 cINhJYW6LE8FggiWTG9dTXvBWn18lFBACFL0b7BVAoCyY5rTAEFyqr6kWYmXrGw2tnwDymAIUb5uM
 xQQU1qu396d7+u7Ql8djlywvbYKEs97pDARg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.217.82]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b2d-1qwl7P18vt-0080sw; Fri, 06
 Oct 2023 18:54:34 +0200
Message-ID: <6d9da2d1ae8bd90a176cf457e42da79db4353fa9.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
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
Date:   Fri, 06 Oct 2023 18:54:30 +0200
In-Reply-To: <20231006155501.GH36277@noisy.programming.kicks-ass.net>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
         <20231005150258.GA36277@noisy.programming.kicks-ass.net>
         <CGME20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733@eucas1p1.samsung.com>
         <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
         <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
         <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
         <20231006140042.GG36277@noisy.programming.kicks-ass.net>
         <e2645a659b6fc1c592e2f2dc45273c361a2d2f47.camel@gmx.de>
         <20231006155501.GH36277@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dXaYts8Tdu0lpth/DZMGohzfPWpV2IYb4OchV8l/56P8m7JTTQa
 WpjD4kPFIX3BnBliClUP+8EaLn9RW+39yuYuIAjWWZItN6XUg6VgLmprE/elJX7mThjADGG
 hTQMyv+ejoRb/BLzQy4iGIpC/TxScxxC+Z5CMNOzNZzNXaU2xn5t6AJCHzVIeXuD0eGFShL
 qCaNscNCT2LVOno3CmKyw==
UI-OutboundReport: notjunk:1;M01:P0:iOVDf4fmlyA=;tRzYy9GU/97AK7WYzHrWeaxQgKT
 FGLmeNorcAx8rpdHc3KuF2Xv659srBQibo9wNP8F2YgFSB8zwcBlZBBFvMGmPtX6AVdW1lCIH
 0k1oCe14LDyGjq1rmesB1gAYq3wbOFj+AAmJgbyGta2e1D6AQWVW80JWPp1kOTbhIXSvTpYky
 9A574woJ7ZFQ53NtDsR+n1NMy/ZALK01FDUpzYVEIcM0zmTR2TUkO3DDe6CmpYo0I+byexuZP
 rpwuAJgi7YsMeWr+1r15xC7VqcCGdsY3SIztZf5tATgCT78lbgHya9DyUWWs7GlIzJaT41BSz
 9io4lHLqsqxJIuCJ9Hna2Xz/+S5MT+lfldqe7Cm2bAWHjsot98qZAVbbbpkkmgqTSWQfD7CPo
 K3JrujLaMxra732TbsuwptSYCxyrLzRMYOks34Uz9v7+HB9ntsB2pUUsH4XbfqSs/FwrrFsL5
 ouKILakUbXFbPsLUPNvYe5/k92PJIqvi84tiLsQCZwp6zCuoub+0ypVhSU1yjNLUN384/UNJF
 u6wMRCD2z/s3UPcn9uw2BDKAWx5LrBNESer+SXle5a1mZMfHufdSAu+59k5h4bgxFPH41a5ST
 YQ+mRrL6b/Lkp7IKEqQB7EJ84ysIiyEBITMXZM9s9Jn8c7Em6FV1ziUVcRz8krYsAt8r6albm
 1erKuBdT0/sPpu71fNMYsy0Hi8FTQn8a4bY9uo1jBKAQxbPQ5NrGewdScJHRX7zSakELDejhX
 hhgaoWBhpkHqeyBs54Qtm4Ry78EoeD34X4VF9qdTr4usOU5Am44noRtbxvJyqyDOLLOwkCOcu
 bsHQNtV+NnzbtczwZq3Q6mVLfXZtW71g7RsOoWtusLI2rIAw1cjNu2ocwbH4xGElFy81SpE3P
 MXATOrFtGlgYGdUv9knNXhqK8zQkZPTbNAcwftbaJw+Taj64hn5HECoFeDLAb2QQeA1z1ZAcx
 kJXb3g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-06 at 17:55 +0200, Peter Zijlstra wrote:


> If I create two groups (or two users with autogroup on) and have them
> both build a kernel I do indeed get splat.

Ah, my desktop setup is two wide konsole instances with 14 tabs each
for old testament /me (dang dinky universe) and internet stuff running
as a mere mortal, so lots of groups.

	-Mike
