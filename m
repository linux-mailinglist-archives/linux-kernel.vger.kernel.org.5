Return-Path: <linux-kernel+bounces-109833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70768885640
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DE4282983
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BE4482C4;
	Thu, 21 Mar 2024 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="VlavWTCC"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2A208C8;
	Thu, 21 Mar 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012384; cv=none; b=J3NBAn31D2HtOQJbFqUBkH3YUpDM38iVmijXOk1+ZjT1agsMlsveV48FhkUF9Q3C2/sxDIwPN2BbcanW6XRzViWF+m4KIDx3PkWtQVGTe6zGZsf8Y1lAG1GKnSZQ7qGZn3QrjM/o/TF7NHKFUJgDgwZxYy1lFv1/WDF8LsV00Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012384; c=relaxed/simple;
	bh=2wY+bMrhSAAxlCEVaRSYx2ODKkeCgDYZXns76CRJxZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RNUPNWVrN+UMRfx99iZl4t9rZDiP9T2IWGQZjr1N77HFFQfYuSrS0LwbuzYi/A00x3MvfL5EzbhK3RXuyxRhc/hZTVNfqhPDFn1dMfkbYQlpKMdCw4gHnKuhDfycaOZwovHbutg2IIz6gTWOoCya9ENwa/MtN/XHRr80mv3x9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=VlavWTCC; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id C09DC10762CC;
	Thu, 21 Mar 2024 12:12:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru C09DC10762CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1711012378; bh=2wY+bMrhSAAxlCEVaRSYx2ODKkeCgDYZXns76CRJxZE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=VlavWTCCJlCA3IZHSKNP4/ya2hCWQ3DrPA4CdKngZMbfBY90VyQEBEAfwuGM6HddN
	 ePFVbTJJCPIXrfQ118qDdWCFXGtkv72+b/1N7KQ56XYgvXbprtYMuJTOYwbMbVnQdO
	 pFjWMwBTU+lqy0qEn72UP4JwsvkxJcl85/ilJ+84=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id BCDA53196647;
	Thu, 21 Mar 2024 12:12:57 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Michal Ostrowski <mostrows@earthlink.net>, Guillaume Nault
	<gnault@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com"
	<syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com>
Subject: [PATCH 5.15/5.10/5.4/4.19 1/1] pppoe: Fix memory leak in
 pppoe_sendmsg()
Thread-Topic: [PATCH 5.15/5.10/5.4/4.19 1/1] pppoe: Fix memory leak in
 pppoe_sendmsg()
Thread-Index: AQHae2/2R+13FIKrokmi6T+8fsvlew==
Date: Thu, 21 Mar 2024 09:12:57 +0000
Message-ID: <20240321091256.467553-2-Ilia.Gavrilov@infotecs.ru>
References: <20240321091256.467553-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20240321091256.467553-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/03/21 07:23:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/21 04:23:00 #24331522
X-KLMS-AntiVirus-Status: Clean, skipped

DQpGcm9tOiBHYXZyaWxvdiBJbGlhIDxJbGlhLkdhdnJpbG92QGluZm90ZWNzLnJ1Pg0KDQpjb21t
aXQgZGMzNGViZDVjMDE4YjBlZGY0N2YzOWQxMTA4M2FkODMxMjczMzAzNCB1cHN0cmVhbS4NCg0K
c3l6Ym90IHJlcG9ydHMgYSBtZW1vcnkgbGVhayBpbiBwcHBvZV9zZW5kbXNnIFsxXS4NCg0KVGhl
IHByb2JsZW0gaXMgaW4gdGhlIHBwcG9lX3JlY3Ztc2coKSBmdW5jdGlvbiB0aGF0IGhhbmRsZXMg
ZXJyb3JzDQppbiB0aGUgd3Jvbmcgb3JkZXIuIEZvciB0aGUgc2tiX3JlY3ZfZGF0YWdyYW0oKSBm
dW5jdGlvbiwgY2hlY2sNCnRoZSBwb2ludGVyIHRvIHNrYiBmb3IgTlVMTCBmaXJzdCwgYW5kIHRo
ZW4gY2hlY2sgdGhlICdlcnJvcicgdmFyaWFibGUsDQpiZWNhdXNlIHRoZSBza2JfcmVjdl9kYXRh
Z3JhbSgpIGZ1bmN0aW9uIGNhbiBzZXQgJ2Vycm9yJw0KdG8gLUVBR0FJTiBpbiBhIGxvb3AgYnV0
IHJldHVybiBhIGNvcnJlY3QgcG9pbnRlciB0byBzb2NrZXQgYnVmZmVyDQphZnRlciBhIG51bWJl
ciBvZiBhdHRlbXB0cywgdGhvdWdoICdlcnJvcicgcmVtYWlucyBzZXQgdG8gLUVBR0FJTi4NCg0K
c2tiX3JlY3ZfZGF0YWdyYW0NCiAgICAgIF9fc2tiX3JlY3ZfZGF0YWdyYW0gICAgICAgICAgLy8g
TG9vcC4gaWYgKGVyciA9PSAtRUFHQUlOKSB0aGVuDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC8vIGdvIHRvIHRoZSBuZXh0IGxvb3AgaXRlcmF0aW9uDQogICAgICAgICAgX19z
a2JfdHJ5X3JlY3ZfZGF0YWdyYW0gIC8vIGlmIChza2IgIT0gTlVMTCkgdGhlbiByZXR1cm4gJ3Nr
YicNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gZWxzZSBpZiBhIHNpZ25h
bCBpcyByZWNlaXZlZCB0aGVuDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8v
IHJldHVybiAtRUFHQUlODQoNCkZvdW5kIGJ5IEluZm9UZUNTIG9uIGJlaGFsZiBvZiBMaW51eCBW
ZXJpZmljYXRpb24gQ2VudGVyDQoobGludXh0ZXN0aW5nLm9yZykgd2l0aCBTeXprYWxsZXIuDQoN
Ckxpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD02YmRmZDE4NGVh
Yzc3MDllNWNjOSBbMV0NCg0KRml4ZXM6IDFkYTE3N2U0YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIi
KQ0KUmVwb3J0ZWQtYnk6IHN5emJvdCs2YmRmZDE4NGVhYzc3MDllNWNjOUBzeXprYWxsZXIuYXBw
c3BvdG1haWwuY29tDQpDbG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9l
eHRpZD02YmRmZDE4NGVhYzc3MDllNWNjOQ0KU2lnbmVkLW9mZi1ieTogR2F2cmlsb3YgSWxpYSA8
SWxpYS5HYXZyaWxvdkBpbmZvdGVjcy5ydT4NClJldmlld2VkLWJ5OiBHdWlsbGF1bWUgTmF1bHQg
PGduYXVsdEByZWRoYXQuY29tPg0KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0
MDIxNDA4NTgxNC4zODk0OTE3LTEtSWxpYS5HYXZyaWxvdkBpbmZvdGVjcy5ydQ0KU2lnbmVkLW9m
Zi1ieTogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4NCi0tLQ0KIGRyaXZlcnMvbmV0
L3BwcC9wcHBvZS5jIHwgMjMgKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgOSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3BwcC9wcHBvZS5jIGIvZHJpdmVycy9uZXQvcHBwL3BwcG9lLmMNCmluZGV4IGQ3ZjUw
YjgzNTA1MC4uNzBlMjllMWFjNGM4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvcHBwL3BwcG9l
LmMNCisrKyBiL2RyaXZlcnMvbmV0L3BwcC9wcHBvZS5jDQpAQCAtOTgzLDI3ICs5ODMsMjIgQEAg
c3RhdGljIGludCBwcHBvZV9yZWN2bXNnKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBtc2do
ZHIgKm0sDQogc3RydWN0IHNrX2J1ZmYgKnNrYjsNCiBpbnQgZXJyb3IgPSAwOw0KDQotaWYgKHNr
LT5za19zdGF0ZSAmIFBQUE9YX0JPVU5EKSB7DQotZXJyb3IgPSAtRUlPOw0KLWdvdG8gZW5kOw0K
LX0NCitpZiAoc2stPnNrX3N0YXRlICYgUFBQT1hfQk9VTkQpDQorcmV0dXJuIC1FSU87DQoNCiBz
a2IgPSBza2JfcmVjdl9kYXRhZ3JhbShzaywgZmxhZ3MgJiB+TVNHX0RPTlRXQUlULA0KIGZsYWdz
ICYgTVNHX0RPTlRXQUlULCAmZXJyb3IpOw0KLWlmIChlcnJvciA8IDApDQotZ290byBlbmQ7DQor
aWYgKCFza2IpDQorcmV0dXJuIGVycm9yOw0KDQotaWYgKHNrYikgew0KLXRvdGFsX2xlbiA9IG1p
bl90KHNpemVfdCwgdG90YWxfbGVuLCBza2ItPmxlbik7DQotZXJyb3IgPSBza2JfY29weV9kYXRh
Z3JhbV9tc2coc2tiLCAwLCBtLCB0b3RhbF9sZW4pOw0KLWlmIChlcnJvciA9PSAwKSB7DQotY29u
c3VtZV9za2Ioc2tiKTsNCi1yZXR1cm4gdG90YWxfbGVuOw0KLX0NCit0b3RhbF9sZW4gPSBtaW5f
dChzaXplX3QsIHRvdGFsX2xlbiwgc2tiLT5sZW4pOw0KK2Vycm9yID0gc2tiX2NvcHlfZGF0YWdy
YW1fbXNnKHNrYiwgMCwgbSwgdG90YWxfbGVuKTsNCitpZiAoZXJyb3IgPT0gMCkgew0KK2NvbnN1
bWVfc2tiKHNrYik7DQorcmV0dXJuIHRvdGFsX2xlbjsNCiB9DQoNCiBrZnJlZV9za2Ioc2tiKTsN
Ci1lbmQ6DQogcmV0dXJuIGVycm9yOw0KIH0NCg0KLS0NCjIuMzkuMg0KDQoNCtChINGD0LLQsNC2
0LXQvdC40LXQvCwNCtCY0LvRjNGPINCT0LDQstGA0LjQu9C+0LINCtCS0LXQtNGD0YnQuNC5INC/
0YDQvtCz0YDQsNC80LzQuNGB0YINCtCe0YLQtNC10Lsg0YDQsNC30YDQsNCx0L7RgtC60LgNCtCQ
0J4gItCY0L3RhNC+0KLQtdCa0KEiINCyINCzLiDQodCw0L3QutGCLdCf0LXRgtC10YDQsdGD0YDQ
sw0KMTI3Mjg3LCDQsy4g0JzQvtGB0LrQstCwLCDQodGC0LDRgNGL0Lkg0J/QtdGC0YDQvtCy0YHQ
utC+LdCg0LDQt9GD0LzQvtCy0YHQutC40Lkg0L/RgNC+0LXQt9C0LCDQtNC+0LwgMS8yMywg0YHR
gtGALiAxDQpUOiArNyA0OTUgNzM3LTYxLTkyICgg0LTQvtCxLiA0OTIxKQ0K0KQ6ICs3IDQ5NSA3
MzctNzItNzgNCg0KDQpJbGlhLkdhdnJpbG92QGluZm90ZWNzLnJ1DQp3d3cuaW5mb3RlY3MucnUN
Cg0KDQo=

