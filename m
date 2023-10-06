Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81757BC2EF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJFX3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjJFX32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:29:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAADB93;
        Fri,  6 Oct 2023 16:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696634881; x=1697239681; i=efault@gmx.de;
 bh=zurZvLXw2cKLOgM37FflAi2IZN5swEQ2g0f9NTyGKkw=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=plr6AxG5WoaBfDf66hj0DG34qtjAHi21fg9wcIdSS4d0qvzV4Axppb4M853YbhgSthM2zX5kAfz
 IFXA6N4Ph5bLQuHWNVqWp9qd4zl+lTwThChuNz5s8GEx8HAf3NKQK47zES9rwPPq/RtEKwgBArktr
 yHACvTql/5sfQQJigTn8zVGYjIdAP1SeMtkSFZRy1AVOcwzH/NEeFBdWPW2Jn4fUkNRHj7YZ+YpQm
 0WNIYRuDXlNm3Yea+h6KiWy9LMEYLvjeKoZ7fptWnH05WCKCqtIrestikT12r6Xz1UMNcs+lmE6hE
 vtCJOtPzIpOx6ohE4Eo+v9FBuDAZ2mNTt9RA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.217.82]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulmF-1rgSlG2NUp-00rrRb; Sat, 07
 Oct 2023 01:28:01 +0200
Message-ID: <4572a0b62c559ade32e54ba01a3a2918ee544291.camel@gmx.de>
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
Date:   Sat, 07 Oct 2023 01:27:56 +0200
In-Reply-To: <20231006192445.GE743@noisy.programming.kicks-ass.net>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:hdhlIatd2p90Zad5R4r+5KsP5arVu9OQFJ6KWJsxTpMx3/ldk+v
 aeq+Ac4ROgNL09SuSNZ3dIUfqDD9ZtkreSNOfn7i9FCM6UzBNEFRV1gER//hL3lmD/Fa2Vq
 Lv3JpynCIE7rAx4o0vaQtYFWKp77XDD++y4JdYRNgdq9LlVjIIorjkfq/RAF+WRvCl9s954
 SzHJBRURguA/e1YZVnSNg==
UI-OutboundReport: notjunk:1;M01:P0:Q+aQ9wPUdcw=;Kj7Et1e5RG99HE1PT90gbCTcWc1
 Rj9FIpHyPL5c6E//UtRHvnyaBtbGoZ7z7c5WNuhBlWi65oiLuIrwgO80R09e0bIEvaNUCH2E5
 vt0x3yCohEtZNyW+Cl/uWpPgGvJ03DZUFd3fQEz2stPPWV1vnsTe2qs8LuXS0NXT7f7saM5jv
 3LWruGqcYsezRIDgFlVp0Vi6cUudebJFRghmrkVynGSVK1LKC+xXUQvPR8VYXOKKVNVMOr/9t
 PeCdXe6yk++XFwGumJohrsWyqjKNWT9R0aETat+ymjRxULyQOLnv+dZ9/eFUlxP86ifkVlF6H
 DlxezByJSiQLq9kP3qr5z4HC9LXYYlJYkbktk+r5gKFGMQ7j04wJQugZP58/BXs4xjabvi70o
 JttiPmN3mqnS+OZuq9pQr9WC5uF1PeHo7zMw1izdfFgP6wESrFaTqY37uRhbyPDP1HRysEHIx
 b1+aww9tLVpfQjyQKRZt+igpXLxK6HjOEIsT3la66p1m3W7jySUbg4NSoNMbRhF0v1tkmMmhv
 VaGs/acdU4I29/4gYh9eH3sfNVVWTW/1BqgX5MliikCEWSxsSP+tuHr71Dgu05jXRpEzLMlYW
 XrlxzXgbIITMsvXJAY0kSF1qzooer0c0rmONS2G3dG0opzXdy6lfly41b/lG5iYIamFrsKUbz
 1qQz5mvaxN9CQw6fKVj6JMI1BcB/FTIKD5qUEGSBCR9RWlq3M4ABtYtHwRtCeonvp+pCKHRZI
 k6+OwL3fKTqNqVoCYoZfsDe84r5fU/mFnSXIREmNM6OEO5Rtx5pFCN+NQTSNoW06Kap0tTEgY
 s3xz/biYc6GcpGqgvH4X7iGkuzo5xewO/I5q7b/bwGf/hfyFh2wTJEwTLu3EWg/ZoHYWUOCMA
 tQO1m9ZmXDJ9+eBGQ5Yh3QRgflMSEFBvRQ6mrtfbGn4rs8CIkvSb78aNM2yTYpPKo38NADxiW
 QuZqhRj1a0CJOa8NCDlCRUXX+6g=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTA2IGF0IDIxOjI0ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gDQo+ICpzaWdoKiwgZG9lcyB0aGUgYmVsb3cgaGVscD8NCg0KPGludmlzaWJsZSBpbmsgZ29n
Z2xlcz4gYWgsIHNvIHRoZXJlIHlvdS4uLiB3ZXJlbid0Lg0KDQpZdXAsIGFsbCBiZXR0ZXIuDQoN
Cj4gLS0tDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvZmFpci5jIGIva2VybmVsL3NjaGVk
L2ZhaXIuYw0KPiBpbmRleCAwNGZiY2JkYTk3ZDUuLjZhNjcwZjExOWVmYSAxMDA2NDQNCj4gLS0t
IGEva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiArKysgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+IEBA
IC0zNjMyLDYgKzM3NDcsNyBAQCBzdGF0aWMgdm9pZCByZXdlaWdodF9lbnRpdHkoc3RydWN0IGNm
c19ycQ0KPiAqY2ZzX3JxLCBzdHJ1Y3Qgc2NoZWRfZW50aXR5ICpzZSwNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkZWFkbGluZSA9IGRpdl9zNjQoZGVhZGxpbmUgKiBvbGRfd2VpZ2h0LCB3ZWlnaHQpOw0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNlLT5kZWFkbGluZSA9IHNlLT52cnVudGlt
ZSArIGRlYWRsaW5lOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWluX2RlYWRs
aW5lX2NiX3Byb3BhZ2F0ZSgmc2UtPnJ1bl9ub2RlLCBOVUxMKTsNCj4gwqDCoMKgwqDCoMKgwqDC
oH0NCj4gwqANCj4gwqAjaWZkZWYgQ09ORklHX1NNUA0KDQo=
