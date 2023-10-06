Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0D27BB550
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjJFKc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjJFKcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:32:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB91E9;
        Fri,  6 Oct 2023 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696588293; x=1697193093; i=efault@gmx.de;
 bh=nYM4Iq0HIoT8WeZfH9/xZH+fB9khT9UEIePySgCSyeg=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ILmcD1LFgQkhppCIOIFVBLShJ72MfqWbZn7z9nIv01t4QB2EP8NDAT9XrYscSr0MNHRsT3ybuw8
 Fydmoo77GdF3b4/fQvCJEDWEITWtDQXho/SdoS+raTlfUQsmSpP0+RTYzCdpwGaPTdyiR/1srVxwg
 Oiz651dZq/HBZVWcweL1CNUr2NyIwDaTd6DVdYGTDiX7TGSBhkTXJUgKzztDEPQAbUSK68NzaGFpj
 XRG2dpSBypKFyHp4G2aw8seTk/zU/IA8tTz7BWvu4kwM5As/lqQEKhZwkJCgrTDbEVpNhup6WZDt4
 QuTPMI0MkSYed9UkDRhuL0/sdxRne6DJ+I0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.217.82]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf0BG-1rGe5P16AU-00gUAq; Fri, 06
 Oct 2023 12:31:33 +0200
Message-ID: <867f5121d7d010cacf938c293f862b0cea560ec2.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
From:   Mike Galbraith <efault@gmx.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "bsegall@google.com" <bsegall@google.com>,
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
Date:   Fri, 06 Oct 2023 12:31:28 +0200
In-Reply-To: <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
         <20231005150258.GA36277@noisy.programming.kicks-ass.net>
         <CGME20231005150845eucas1p1ed3aae6b90c411b5c26a5dfadf7e0733@eucas1p1.samsung.com>
         <OS0PR01MB592295E06AD01CAEFBA83BF386CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
         <553e2ee4-ab3a-4635-a74f-0ba4cc03f3f9@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bAKhKEv2apxCxL7VofVH1W85qmxPwHmVAjxAfi906U+61WKQVqJ
 PO89+CAEbaeZU451qCBTDESVyNJoT9meXu8r6PbvCRFjc8lbFBOWlx6fY/NiDdMFdCGzn/H
 HSzA93FmnZyURNoK6aJvHqlJqwaJt6/j/9Mi75FRsWVwM3yOhQBFL6t/yea16H5RFUjvaiQ
 Qsa5ZXyMfKImyxVv3FLEQ==
UI-OutboundReport: notjunk:1;M01:P0:xlk3qR3B/Fw=;G734mNj1mFoTEHrlGF/JHUDUn4O
 spN2qdq9ANsASsjAbbFiAZfztxfz2xpqdxqhWTZ3vIEwQw0aZGQpIhqPs6yxgsa5r1axPredO
 t3aCKWDb/NLayDEbjTeEvdE21gUCggSMz+Hr1Ab/NVkwc1gi0R8uPOolSKr8B5mHKLSuWzvn8
 Ckq0+XfIlLa9QB8TuJKL05wbWMdbaYCc6AO+6dN44/a1hP3TBpyyXeWGSehvr8hHmRSuBdz4J
 5ZtS+m/zBg43svNX+QjMT1yrKXV+ITe+Ni/DMFzq0Puwmfb2S2tDqC0b0U2eDYwcYSj9GKuv7
 N5CT+ENK10xhQhO//wts2h1Zp6sjlTuOtk4DgB5zCPa42kuOO6F8NMEux7FxP7AM+0Ty9pnRx
 Osoe7jEpFPvOcYf3KlGN73bcV9i44TS+Yw0BAbU1KnyJU+BkFnH+/byR8w8ALa75UzZQva94w
 FU3biWFM37+0hNlTfOJBb1ZOUS6R99ydvDIZYglQbFwi1d9pJwueL9W7WxXFIXAbnifW4tiwH
 VybGWoS6z3+lagDHLy1Swe+2qoCdcbDvpWgUNs9Mv8VRdeR4aXzHLIlYXdWHDKb8FuP2VLApX
 CYjDgeCwwUlOIz63OjOysyzrPiHHttGKX5X4zhu6ws9zm03p5Qwod7DVVvZa+FBJeLU3Tu4a+
 BtcnVq+OC8F+NR+2RZ49Cz5o9tSUhhvElt8VVHNiyCuuvqZX46ruv8305UH+uFxzHilYPSWoJ
 AzC0kHWFPxdHwJ6wv38EXYA8iOEqWLNpACpe/VRfBviZgiGtOQtAFcCmX6xztHJUNULlZidbP
 L2O34Y4lURvBzrixr+gfaNkih1OavmZ9zFat7haDbVyphbt/emNhmcIUGvU85iNYRvtHpVZqD
 hgy9fsjfT3H6FMjJok2IanYBH1+tPTAdcbfkM+hN+9F3/jYl+hwy6Y8VBI1q1ArV5/73iaTQW
 z6Ih4A==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-06 at 10:35 +0200, Marek Szyprowski wrote:
>
>
> Just to note, I've run into this issue on the QEmu's 'arm64/virt'
> platform, not on the Samsung specific hardware.=C2=A0

It doesn't appear to be arch specific, all I have to do is enable
autogroup, raspberry or x86_64 desktop box, the occasional failure
tripping over task groups, leaving both best and best_left with
identical but not what we're looking for ->min_deadline.

	-Mike
