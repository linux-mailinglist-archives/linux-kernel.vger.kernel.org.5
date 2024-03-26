Return-Path: <linux-kernel+bounces-118223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42EA88B652
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E7F1F3EDB3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEDD1BF58;
	Tue, 26 Mar 2024 00:48:08 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA601BC43;
	Tue, 26 Mar 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711414088; cv=none; b=N1qwebkUft3hYKPrEilhHCMRfgpxn3pbrPs/oNsHjFiKF0lanTvFROiKcZ9xRvIc5LuqEq93RvArnARRrgMQKrajwHV3ttPF0fDCz3dl/QHcD/ex/GH4Wiovyj7HhnDtg+VZLSpjyoS4dRxx3RoUwMMMUtO5Z8/lF85TYHwtQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711414088; c=relaxed/simple;
	bh=QkZ6aHYMcf61HU6Zd5zYZ/ekW8uMmtly18b1BNH24nc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nJRh855DdmidbFGkX3xKgBVzUghje1OGbxd0EuOcnZqw0sERCyxgc5AUBLRFTIbVnKAQICS6P3X4hr1XmDPYYWbffNJErAa+nbH4FmRFSHd5luV4tF7TgTlLoMMKpg44JoC63KvEKY3ooWD+SWE2TeEfrJBjgaOgS8YdoICBMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 42Q0l5q3009474;
	Tue, 26 Mar 2024 08:47:05 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX07-IMDC.srv.huawei-3com.com (unknown [10.62.14.16])
	by mail.maildlp.com (Postfix) with ESMTP id 974262004BBF;
	Tue, 26 Mar 2024 08:48:52 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX07-IMDC.srv.huawei-3com.com (10.62.14.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Tue, 26 Mar 2024 08:47:05 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Tue, 26 Mar 2024 08:47:05 +0800
From: Liuye <liu.yeC@h3c.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "dianders@chromium.org"
	<dianders@chromium.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "jason.wessel@windriver.com"
	<jason.wessel@windriver.com>,
        "kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFY1XSBrZGI6IEZpeCB0aGUgZGVhZGxvY2sgaXNzdWUg?=
 =?gb2312?Q?in_KDB_debugging.?=
Thread-Topic: [PATCH V5] kdb: Fix the deadlock issue in KDB debugging.
Thread-Index: AQHafMNGp110DpezqUCtEXSIKJEqHbFIKpkAgAEGDzA=
Date: Tue, 26 Mar 2024 00:47:05 +0000
Message-ID: <284dbaad75574bbaaab803b471e8ca6c@h3c.com>
References: <20240322155818.GD7342@aspen.lan>
 <20240323014141.3621738-1-liu.yec@h3c.com>
 <20240325165436.GA485978@aspen.lan>
In-Reply-To: <20240325165436.GA485978@aspen.lan>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 42Q0l5q3009474

Pj4gSnVzdCBuZWVkIHRvIHBvc3Rwb25lIHNjaGVkdWxlX3dvcmsgdG8gdGhlIHNsYXZlIENQVSBl
eGl0aW5nIHRoZSBOTUkgY29udGV4dC4NCj4+DQo+PiBpcnFfd29yayB3aWxsIG9ubHkgcmVzcG9u
ZCB0byBoYW5kbGUgc2NoZWR1bGVfd29yayBhZnRlciBleGl0aW5nIHRoZSBjdXJyZW50IGludGVy
cnVwdCBjb250ZXh0Lg0KPj4NCj4+IFdoZW4gdGhlIG1hc3RlciBDUFUgZXhpdHMgdGhlIGludGVy
cnVwdCBjb250ZXh0LCBvdGhlciBDUFVzIHdpbGwgbmF0dXJhbGx5IGV4aXQgdGhlIE5NSSBjb250
ZXh0LCBzbyB0aGVyZSB3aWxsIGJlIG5vIGRlYWRsb2NrLg0KPj4NCj4+IEl0IGlzIHRoZSBjYWxs
IHRvIGlucHV0X3JlZ2lzdGVyX2hhbmRsZXIoKSB0aGF0IGZvcmNlcyB1cyBub3QgdG8gZG8gdGhl
IHdvcmsgZnJvbSBpcnFfd29yaydzIGhhcmRpcnEgY2FsbGJhY2suDQo+Pg0KPj4gVGhlcmVmb3Jl
IHNjaGVkdWxlIGFub3RoZXIgd29yayBpbiB0aGUgaXJxX3dvcmsgYW5kIG5vdCBkbyB0aGUgam9i
IGRpcmVjdGx5Lg0KPg0KPlRoaXMgbG9va3MgbGlrZSBpdCB3YXMgY29weSBhbmQgcGFzdGVkIGZy
b20gdGhlIGUtbWFpbCB0aHJlYWQgd2l0aG91dCBhbnkgZWRpdGluZyB0byBtYWtlIGl0IG1ha2Ug
YW55IHNlbnNlLiBJdCBub3QgZXZlbiBmb3JtYXR0ZWQgY29ycmVjdGx5ICh3aGVyZSBhcmUgdGhl
IGxpbmUgYnJlYWtzPykuDQo+DQo+SG93IGFib3V0Og0KPg0KPldlIGZpeCB0aGUgcHJvYmxlbSBi
eSB1c2luZyBpcnFfd29yayB0byBjYWxsIHNjaGVkdWxlX3dvcmsoKSBpbnN0ZWFkIG9mIGNhbGxp
bmcgaXQgZGlyZWN0bHkuIGlycV93b3JrIGlzIGFuIE5NSS1zYWZlIGRlZmVycmVkIHdvcmsgZnJh
bWV3b3JrIHRoYXQgcGVyZm9ybXMgdGhlIHJlcXVlc3RlZCB3b3JrIGZyb20gYSBoYXJkaXJxIGNv
bnRleHQgKHVzdWFsbHkgYW4gSVBJIGJ1dCBpdCBjYW4gYmUgdGltZXIgaW50ZXJydXB0IG9uIHNv
bWUgYXJjaGl0ZWN0dXJlcykuDQo+DQo+Tm90ZSB0aGF0IHdlIHN0aWxsIG5lZWQgdG8gIGEgd29y
a3F1ZXVlIHNpbmNlIHdlIGNhbm5vdCByZXN5bmMgdGhlIGtleWJvYXJkIHN0YXRlIGZyb20gdGhl
IGhhcmRpcnEgY29udGV4dCBwcm92aWRlZCBieSBpcnFfd29yay4NCj5UaGF0IG11c3QgYmUgZG9u
ZSBmcm9tIHRhc2sgY29udGV4dCBmb3IgdGhlIGNhbGxzIGludG8gdGhlIGlucHV0IHN1YnlzdGVt
LiBIZW5jZSB3ZSBtdXN0IGRlZmVyIHRoZSB3b3JrIHR3aWNlLiBGaXJzdCB0byBzYWZlbHkgc3dp
dGNoIGZyb20gdGhlIGRlYnVnIHRyYXAgKE5NSS1saWtlIGNvbnRleHQpIHRvIGhhcmRpcnEgYW5k
IHRoZW4sIHNlY29uZGx5LCB0byBnZXQgZnJvbSBoYXJkaXJxIHRvIHRoZSBzeXN0ZW0gd29ya3F1
ZXVlLg0KDQpJIGFwb2xvZ2l6ZSBmb3IgbXkgcG9vciB3cml0aW5nIHNraWxscywgeW91ciBhbnN3
ZXIgaXMgbW9yZSBwcm9mZXNzaW9uYWwgYW5kIGFjY3VyYXRlLiBJIHdpbGwgcmVwbGFjZSB0aGlz
IHBhcnQgd2l0aCB5b3VyIGRlc2NyaXB0aW9uIGluIHRoZSBWNi4NCg0KDQo=

