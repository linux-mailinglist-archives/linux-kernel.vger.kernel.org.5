Return-Path: <linux-kernel+bounces-111081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A948867A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D476D1C21FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4A113AC0;
	Fri, 22 Mar 2024 07:52:33 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D012E4E;
	Fri, 22 Mar 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093952; cv=none; b=p5j4gDtvbpKID9zGDzb3GxSPrCZZTqG7DCN+Rtpuqc+Yp3l+LQRk5qaa/tbtHBlgfSouUd32C5bhxa2beGvoW7zyJclhQhuEs5gkD1S9ApYH6zSyw02XtoOJ+/52jLKaDtl/bJaeKAxqJppLN4GpazVKBT5Dn9VRtEXQuNBEWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093952; c=relaxed/simple;
	bh=JcawjuQzj2kIp/tXe59hsACPJPeGZetDdjNA++lcYhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FdkRPZ4caReE/rRlZjPzh1cFDt4A9kjiqcJdPd4TxSRqF7BXTrhBqlU0xto1PJjL/pr3QODMIk3XD6oTLLBhxPepc0qi4bXxRi2oIaU8bsn8QPWK3qpEbgU0dtFIYzfeYWymdiNo0P2kvR9zAqBbYVTM1g+RlhvoQBV3oTIJHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 42M7oqLk000733;
	Fri, 22 Mar 2024 15:50:52 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX05-IMDC.srv.huawei-3com.com (unknown [10.62.14.14])
	by mail.maildlp.com (Postfix) with ESMTP id 09A1D2004BB9;
	Fri, 22 Mar 2024 15:52:36 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX05-IMDC.srv.huawei-3com.com (10.62.14.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Fri, 22 Mar 2024 15:50:54 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Fri, 22 Mar 2024 15:50:54 +0800
From: Liuye <liu.yeC@h3c.com>
To: Jiri Slaby <jirislaby@kernel.org>,
        "daniel.thompson@linaro.org"
	<daniel.thompson@linaro.org>
CC: "dianders@chromium.org" <dianders@chromium.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggVjRdIGtkYjogRml4IHRoZSBkZWFkbG9jayBpc3N1?=
 =?utf-8?Q?e_in_KDB_debugging.?=
Thread-Topic: [PATCH V4] kdb: Fix the deadlock issue in KDB debugging.
Thread-Index: AQHae4X3OBfEt+YG5U6iGFBuJcoLGLFCznkAgACVJ+A=
Date: Fri, 22 Mar 2024 07:50:54 +0000
Message-ID: <5649fa8bfbdb43ea914850794afc6cac@h3c.com>
References: <20240321110407.GB7342@aspen.lan>
 <20240321115017.2879691-1-liu.yec@h3c.com>
 <d3b77177-7c00-4459-9515-37afe741e9dd@kernel.org>
In-Reply-To: <d3b77177-7c00-4459-9515-37afe741e9dd@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 42M7oqLk000733

Pk9uIDIxLiAwMy4gMjQsIDEyOjUwLCBsaXUueWVjQGgzYy5jb20gd3JvdGU6DQo+PiBGcm9tOiBM
aXVZZSA8bGl1LnllQ0BoM2MuY29tPg0KPj4gDQo+PiBDdXJyZW50bHksIGlmIENPTkZJR19LREJf
S0VZQk9BUkQgaXMgZW5hYmxlZCwgdGhlbiBrZ2Rib2Mgd2lsbCBhdHRlbXB0IA0KPj4gdG8gdXNl
IHNjaGVkdWxlX3dvcmsoKSB0byBwcm92b2tlIGEga2V5Ym9hcmQgcmVzZXQgd2hlbiB0cmFuc2l0
aW9uaW5nIA0KPj4gb3V0IG9mIHRoZSBkZWJ1Z2dlciBhbmQgYmFjayB0byBub3JtYWwgb3BlcmF0
aW9uLg0KPj4gVGhpcyBjYW4gY2F1c2UgZGVhZGxvY2sgYmVjYXVzZSBzY2hlZHVsZV93b3JrKCkg
aXMgbm90IE5NSS1zYWZlLg0KPj4gDQo+PiBUaGUgc3RhY2sgdHJhY2UgYmVsb3cgc2hvd3MgYW4g
ZXhhbXBsZSBvZiB0aGUgcHJvYmxlbS4gSW4gdGhpcyBjYXNlIA0KPj4gdGhlIG1hc3RlciBjcHUg
aXMgbm90IHJ1bm5pbmcgZnJvbSBOTUkgYnV0IGl0IGhhcyBwYXJrZWQgdGhlIHNsYXZlIA0KPj4g
Q1BVcyB1c2luZyBhbiBOTUkgYW5kIHRoZSBwYXJrZWQgQ1BVcyBpcyBob2xkaW5nIHNwaW5sb2Nr
cyBuZWVkZWQgYnkgDQo+PiBzY2hlZHVsZV93b3JrKCkuDQo+DQo+SSBhbSBtaXNzaW5nIGhlcmUg
YW4gZXhwbGFuYXRpb24gKHBlcmhhcHMgYmVjYXVzZSBJIGNhbm5vdCBmaW5kIGFueSBkb2NzIGZv
ciBpcnFfd29yaykgd2h5IGlycV93b3JrIHdvcmtzIGluIHRoaXMgY2FzZS4NCg0KSnVzdCBuZWVk
IHRvIHBvc3Rwb25lIHNjaGVkdWxlX3dvcmsgdG8gdGhlIHNsYXZlIENQVSBleGl0aW5nIHRoZSBO
TUkgY29udGV4dCwgYW5kIHRoZXJlIHdpbGwgYmUgbm8gZGVhZGxvY2sgcHJvYmxlbS4gDQppcnFf
d29yayB3aWxsIG9ubHkgcmVzcG9uZCB0byBoYW5kbGUgc2NoZWR1bGVfd29yayBhZnRlciBtYXN0
ZXIgY3B1IGV4aXRpbmcgdGhlIGN1cnJlbnQgaW50ZXJydXB0IGNvbnRleHQuIA0KV2hlbiB0aGUg
bWFzdGVyIENQVSBleGl0cyB0aGUgaW50ZXJydXB0IGNvbnRleHQsIG90aGVyIENQVXMgd2lsbCBu
YXR1cmFsbHkgZXhpdCB0aGUgTk1JIGNvbnRleHQsIHNvIHRoZXJlIHdpbGwgYmUgbm8gZGVhZGxv
Y2suDQoNCj5BbmQgd2h5IHlvdSBuZWVkIHRvIHNjaGVkdWxlIGFub3RoZXIgd29yayBpbiB0aGUg
aXJxX3dvcmsgYW5kIG5vdCBkbyB0aGUgam9iIGRpcmVjdGx5Lg0KDQpJbiB0aGUgZnVuY3Rpb24g
a2dkYm9jX3Jlc3RvcmVfaW5wdXRfaGVscGVyICwgdXNlIG11dGV4X2xvY2sgZm9yIHByb3RlY3Rp
b24uIFRoZSBtdXRleCBsb2NrIGNhbm5vdCBiZSB1c2VkIGluIGludGVycnVwdCBjb250ZXh0Lg0K
R3Vlc3MgdGhhdCB0aGUgcHJvY2VzcyBuZWVkcyB0byBydW4gaW4gdGhlIGNvbnRleHQgb2YgdGhl
IHByb2Nlc3MuIFRoZXJlZm9yZSwgY2FsbCBzY2hlZHVsZV93b3JrIGluIGlycV93b3JrLiBLZWVw
IHRoZSBvcmlnaW5hbCBmbG93IHVuY2hhbmdlZC4NCg==

