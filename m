Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C07E4E40
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjKHAtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjKHAtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:49:05 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6659C10FE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:49:02 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2AD1F2C02AF;
        Wed,  8 Nov 2023 13:48:58 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1699404538;
        bh=c9kEsRHJ/s1C8bQDoGuyud9dLRswXEwXkU467AUOB80=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AGNS9aOQQvadKoCo0jXLU4MsT8JoA4xfwgwHyu0v506UCjB/CWkzqqtTLxnVIT41i
         bdbHToxrSTDpwzjRjBR6lWm3I036Rg7O0WFxfzN1Yu34M86SyI451G4OtUNyh7IbJZ
         vTkRY3HTX1y8F6QLQItEsUeuLPeK3lAkKIAnT2TBDEDn6eh+92HK1HG587SAe+sU1x
         E5o3agfqBd8qXeX59FXAWIsn4knaTVe5x5XJfmOmVatB7zPBFCwQKjdnW3AUidAe+u
         9OTIdwyLMA+2eaC7c1Tijo01jgOVuV9Sc6YaIpuTyi5f8gtrUbdCXnB07IvNoy0NGs
         4gnY7vLOECBPw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B654adafa0000>; Wed, 08 Nov 2023 13:48:58 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 13:48:57 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 8 Nov 2023 13:48:57 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.039; Wed, 8 Nov 2023 13:48:57 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "jon.grimm@amd.com" <jon.grimm@amd.com>,
        "bharata@amd.com" <bharata@amd.com>,
        "raghavendra.kt@amd.com" <raghavendra.kt@amd.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bristot@kernel.org" <bristot@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "krypton@ulrich-teichert.org" <krypton@ulrich-teichert.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "richard@nod.at" <richard@nod.at>,
        "mjguzik@gmail.com" <mjguzik@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Amit Shah <amit@kernel.org>, Gonglei <arei.gonglei@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Sumit Semwal" <sumit.semwal@linaro.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Jens Wiklander" <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Helge Deller <deller@gmx.de>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH 85/86] treewide: drivers: remove cond_resched()
Thread-Topic: [RFC PATCH 85/86] treewide: drivers: remove cond_resched()
Thread-Index: AQHaEc/B2vp6BRv7CUGqn9A8fU5GHLBuvSQA
Date:   Wed, 8 Nov 2023 00:48:57 +0000
Message-ID: <739dd8ac-cbc9-434d-9726-584ccdf83afb@alliedtelesis.co.nz>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-29-ankur.a.arora@oracle.com>
In-Reply-To: <20231107230822.371443-29-ankur.a.arora@oracle.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD15A0E71CED9E4890B42E8CE5F87FC0@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=L6ZjvNb8 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=W6Mp-hZi8bXipRmhoHAA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA4LzExLzIzIDEyOjA4LCBBbmt1ciBBcm9yYSB3cm90ZToNCj4gVGhlcmUgYXJlIGJyb2Fk
bHkgdGhyZWUgc2V0cyBvZiB1c2VzIG9mIGNvbmRfcmVzY2hlZCgpOg0KPg0KPiAxLiAgQ2FsbHMg
dG8gY29uZF9yZXNjaGVkKCkgb3V0IG9mIHRoZSBnb29kbmVzcyBvZiBvdXIgaGVhcnQsDQo+ICAg
ICAgb3RoZXJ3aXNlIGtub3duIGFzIGF2b2lkaW5nIGxvY2t1cCBzcGxhdHMuDQo+DQo+IDIuICBP
cGVuIGNvZGVkIHZhcmlhbnRzIG9mIGNvbmRfcmVzY2hlZF9sb2NrKCkgd2hpY2ggY2FsbA0KPiAg
ICAgIGNvbmRfcmVzY2hlZCgpLg0KPg0KPiAzLiAgUmV0cnkgb3IgZXJyb3IgaGFuZGxpbmcgbG9v
cHMsIHdoZXJlIGNvbmRfcmVzY2hlZCgpIGlzIHVzZWQgYXMgYQ0KPiAgICAgIHF1aWNrIGFsdGVy
bmF0aXZlIHRvIHNwaW5uaW5nIGluIGEgdGlnaHQtbG9vcC4NCj4NCj4gV2hlbiBydW5uaW5nIHVu
ZGVyIGEgZnVsbCBwcmVlbXB0aW9uIG1vZGVsLCB0aGUgY29uZF9yZXNjaGVkKCkgcmVkdWNlcw0K
PiB0byBhIE5PUCAobm90IGV2ZW4gYSBiYXJyaWVyKSBzbyByZW1vdmluZyBpdCBvYnZpb3VzbHkg
Y2Fubm90IG1hdHRlci4NCj4NCj4gQnV0IGNvbnNpZGVyaW5nIG9ubHkgdm9sdW50YXJ5IHByZWVt
cHRpb24gbW9kZWxzIChmb3Igc2F5IGNvZGUgdGhhdA0KPiBoYXMgYmVlbiBtb3N0bHkgdGVzdGVk
IHVuZGVyIHRob3NlKSwgZm9yIHNldC0xIGFuZCBzZXQtMiB0aGUNCj4gc2NoZWR1bGVyIGNhbiBu
b3cgcHJlZW1wdCBrZXJuZWwgdGFza3MgcnVubmluZyBiZXlvbmQgdGhlaXIgdGltZQ0KPiBxdWFu
dGEgYW55d2hlcmUgdGhleSBhcmUgcHJlZW1wdGlibGUoKSBbMV0uIFdoaWNoIHJlbW92ZXMgYW55
IG5lZWQNCj4gZm9yIHRoZXNlIGV4cGxpY2l0bHkgcGxhY2VkIHNjaGVkdWxpbmcgcG9pbnRzLg0K
Pg0KPiBUaGUgY29uZF9yZXNjaGVkKCkgY2FsbHMgaW4gc2V0LTMgYXJlIGEgbGl0dGxlIG1vcmUg
ZGlmZmljdWx0Lg0KPiBUbyBzdGFydCB3aXRoLCBnaXZlbiBpdCdzIE5PUCBjaGFyYWN0ZXIgdW5k
ZXIgZnVsbCBwcmVlbXB0aW9uLCBpdA0KPiBuZXZlciBhY3R1YWxseSBzYXZlZCB1cyBmcm9tIGEg
dGlnaHQgbG9vcC4NCj4gV2l0aCB2b2x1bnRhcnkgcHJlZW1wdGlvbiwgaXQncyBub3QgYSBOT1As
IGJ1dCBpdCBtaWdodCBhcyB3ZWxsIGJlIC0tDQo+IGZvciBtb3N0IHdvcmtsb2FkcyB0aGUgc2No
ZWR1bGVyIGRvZXMgbm90IGhhdmUgYW4gaW50ZXJtaW5hYmxlIHN1cHBseQ0KPiBvZiBydW5uYWJs
ZSB0YXNrcyBvbiB0aGUgcnVucXVldWUuDQo+DQo+IFNvLCBjb25kX3Jlc2NoZWQoKSBpcyB1c2Vm
dWwgdG8gbm90IGdldCBzb2Z0bG9ja3VwIHNwbGF0cywgYnV0IG5vdA0KPiB0ZXJyaWJseSBnb29k
IGZvciBlcnJvciBoYW5kbGluZy4gSWRlYWxseSwgdGhlc2Ugc2hvdWxkIGJlIHJlcGxhY2VkDQo+
IHdpdGggc29tZSBraW5kIG9mIHRpbWVkIG9yIGV2ZW50IHdhaXQuDQo+IEZvciBub3cgd2UgdXNl
IGNvbmRfcmVzY2hlZF9zdGFsbCgpLCB3aGljaCB0cmllcyB0byBzY2hlZHVsZSBpZg0KPiBwb3Nz
aWJsZSwgYW5kIGV4ZWN1dGVzIGEgY3B1X3JlbGF4KCkgaWYgbm90Lg0KPg0KPiBUaGUgY29uZF9y
ZXNjaGVkKCkgY2FsbHMgaGVyZSBhcmUgYWxsIGtpbmRzLiBUaG9zZSBmcm9tIHNldC0xDQo+IG9y
IHNldC0yIGFyZSBxdWl0ZSBzdHJhaWdodC1mb3J3YXJkIHRvIGhhbmRsZS4NCj4NCj4gVGhlcmUg
YXJlIHF1aXRlIGEgZmV3IGZyb20gc2V0LTMsIHdoZXJlIGFzIG5vdGVkIGFib3ZlLCB3ZQ0KPiB1
c2UgY29uZF9yZXNjaGVkKCkgYXMgaWYgaXQgd2VyZSBhIGFtdWxlbnQuIFdoaWNoIEkgc3VwcHBv
c2UNCj4gaXQgaXMsIGluIHRoYXQgaXQgd2FyZHMgb2ZmIHNvZnRsb2NrdXAgb3IgUkNVIHNwbGF0
cy4NCj4NCj4gVGhvc2UgYXJlIG5vdyBjb25kX3Jlc2NoZWRfc3RhbGwoKSwgYnV0IGluIG1vc3Qg
Y2FzZXMsIGdpdmVuDQo+IHRoYXQgdGhlIHRpbWVvdXRzIGFyZSBpbiBtaWxsaXNlY29uZHMsIHRo
ZXkgY291bGQgYmUgZWFzaWx5DQo+IHRpbWVkIHdhaXRzLg0KDQpGb3IgaTJjLW1wYy5jOg0KDQpJ
dCBsb29rcyBhcyB0aGUgY29kZSBpbiBxdWVzdGlvbiBjb3VsZCBwcm9iYWJseSBiZSBjb252ZXJ0
ZWQgdG8gDQpyZWFkYl9wb2xsX3RpbWVvdXQoKS4gSWYgSSBmaW5kIHN1ZmZpY2llbnQgcm91bmQt
dHVpdHMgSSBtaWdodCBsb29rIGF0IA0KdGhhdC4gUmVnYXJkbGVzcyBpbiB0aGUgY29udGV4dCBv
ZiB0aGUgdHJlZS13aWRlIGNoYW5nZSAuLi4NCg0KUmV2aWV3ZWQtYnk6IENocmlzIFBhY2toYW0g
PGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCg0K
