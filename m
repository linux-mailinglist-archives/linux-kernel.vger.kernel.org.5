Return-Path: <linux-kernel+bounces-100999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEF387A0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C23C1C22B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4659BB660;
	Wed, 13 Mar 2024 01:23:24 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC1AD56;
	Wed, 13 Mar 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293003; cv=none; b=AUKfO0v+yXrBNgFRmom64sWugE8+O3EJZ7kV0dBnk2a8xAo6WO5tTYlHxs4xtAno5PtiW3OANoe+xKFsFG3dASnJrgH+1jJxFyEKgRT1GDwsynobdQK/P22DkVbuz7MBoX6e94/wKbTjT+GZO01NAVppoTXT62zxiqm2xCl96g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293003; c=relaxed/simple;
	bh=zguCaPaRH8CknYHsCoPumQTnq9ZCBUkYQuGxQqp4PhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NvapYbAEDUjNdKLMS6qVzey6EJqU7ArNxcyOJP9Am4KMQ76c+3whWhsKlbdpdHyPRl1jUx/W8+QGjeNzXcQWnI1/EH+zAhUr1nkcS8JrECnFnJtxYu3sfzu0PMBUFr0JuqrE8mUp1Mwm5ERXGGlFcP0xtUs01+xYHg3P+faJLco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 42D1MI6s002888;
	Wed, 13 Mar 2024 09:22:18 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX06-IMDC.srv.huawei-3com.com (unknown [10.62.14.15])
	by mail.maildlp.com (Postfix) with ESMTP id C5B012004BAA;
	Wed, 13 Mar 2024 09:23:46 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX06-IMDC.srv.huawei-3com.com (10.62.14.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 13 Mar 2024 09:22:17 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Wed, 13 Mar 2024 09:22:17 +0800
From: Liuye <liu.yeC@h3c.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
CC: "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBrZGI6IEZpeCB0aGUg?=
 =?gb2312?Q?deadlock_issue_in_KDB_debugging.?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBrZGI6IEZpeCB0aGUgZGVhZGxv?=
 =?gb2312?Q?ck_issue_in_KDB_debugging.?=
Thread-Index: AQHaafG3YC/Li+j42kau1FDQhHr2m7EfIsgAgAMadaD///fWgIAJrHcQgAeL+QCAAIb8YP//gGOAgAGAGvA=
Date: Wed, 13 Mar 2024 01:22:17 +0000
Message-ID: <410a443612e8441cb729c640a0d606c6@h3c.com>
References: <20240228025602.3087748-1-liu.yeC@h3c.com>
 <20240228120516.GA22898@aspen.lan> <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com>
 <20240301105931.GB5795@aspen.lan> <2ea381e7407a49aaa0b08fa7d4ff62d3@h3c.com>
 <20240312095756.GB202685@aspen.lan>
 <06cfa3459ed848cf8f228997b983cf53@h3c.com>
 <20240312102419.GC202685@aspen.lan>
In-Reply-To: <20240312102419.GC202685@aspen.lan>
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
X-MAIL:h3cspam02-ex.h3c.com 42D1MI6s002888

Pk9uIFR1ZSwgTWFyIDEyLCAyMDI0IGF0IDEwOjA0OjU0QU0gKzAwMDAsIExpdXllIHdyb3RlOg0K
Pj4gPk9uIFR1ZSwgTWFyIDEyLCAyMDI0IGF0IDA4OjM3OjExQU0gKzAwMDAsIExpdXllIHdyb3Rl
Og0KPj4gPj4gSSBrbm93IHRoYXQgeW91IHNhaWQgc2NoZWR1bGVfd29yayBpcyBub3QgTk1JIHNh
dmUsIHdoaWNoIGlzIHRoZSANCj4+ID4+IGZpcnN0IGlzc3VlLiBQZXJoYXBzIGl0IGNhbiBiZSBm
aXhlZCB1c2luZyBpcnFfd29ya19xdWV1ZS4gQnV0IGV2ZW4gDQo+PiA+PiBpZiBpcnFfd29ya19x
dWV1ZSBpcyB1c2VkIHRvIGltcGxlbWVudCBpdCwgdGhlcmUgd2lsbCBzdGlsbCBiZSBhIA0KPj4g
Pj4gZGVhZGxvY2sgcHJvYmxlbSBiZWNhdXNlIHNsYXZlIGNwdTEgc3RpbGwgaGFzIG5vdCByZWxl
YXNlZCB0aGUgDQo+PiA+PiBydW5uaW5nIHF1ZXVlIGxvY2sgb2YgbWFzdGVyIENQVTAuDQo+PiA+
DQo+PiA+VGhpcyBkb2Vzbid0IHNvdW5kIHJpZ2h0IHRvIG1lLiBXaHkgZG8geW91IHRoaW5rIENQ
VTEgd29uJ3QgcmVsZWFzZSANCj4+ID50aGUgcnVuIHF1ZXVlIGxvY2s/DQo+Pg0KPj4gSW4gdGhp
cyBleGFtcGxlLCBDUFUxIGlzIHdhaXRpbmcgZm9yIENQVTAgdG8gcmVsZWFzZSBkYmdfc2xhdmVf
bG9jay4NCj4NCj5UaGF0IHNob3VsZG4ndCBiZSBhIHByb2JsZW0uIENQVTAgd2lsbCBoYXZlIHJl
bGVhc2VkIHRoYXQgbG9jayBieSB0aGUgdGltZSB0aGUgaXJxIHdvcmsgaXMgZGlzcGF0Y2hlZC4N
Cg0KUmVsZWFzZSBkYmdfc2xhdmVfbG9jayBpbiBDUFUwLiBCZWZvcmUgdGhhdCwgc2hjZWR1bGVf
d29yayBuZWVkcyB0byBiZSBoYW5kbGVkLCBhbmQgd2UgYXJlIGJhY2sgdG8gdGhlIHByZXZpb3Vz
IGlzc3VlLg0K

