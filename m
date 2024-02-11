Return-Path: <linux-kernel+bounces-60951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D91850B7D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0121F21E02
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE325DF09;
	Sun, 11 Feb 2024 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="scP33huc"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848015A8
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684384; cv=none; b=Mi5Gp/3+0f4lcqBCoEmEGIU06Pi9T1XqJtPqVNzm/MAIrr/2qV+30slhUWGwMkrFcFdyqSFQwjI/edP+ttwRR54SVfKYyjoEF5THWyq2/Qa55WAkV0YXe3caZAsLGn8ZVeNLaYjrkRIM6DOwO8uqD0f/1NCgkMK49vO4Ms0wIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684384; c=relaxed/simple;
	bh=yrt4HsNPLGtpXQnvRniFLI526mvUlQD+f43RfvX5ieY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cCTv/FjOrf353YaENMCHvXUCU70U65ccAcr+VxgP9jeSSPVx0l8LVQIxld8lJunvemyu5i8T6AH3FIwwqLQzpi18ETgqg/v9VkG1+D3bMcS6Ko3EEdakdQEjQbjXALAVWnIvtJ0GtTCbDEyFeo/DX/iPAel4T1JmywayIeMcRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=scP33huc; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 18A622C075F;
	Mon, 12 Feb 2024 09:46:13 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1707684373;
	bh=yrt4HsNPLGtpXQnvRniFLI526mvUlQD+f43RfvX5ieY=;
	h=From:To:CC:Subject:Date:From;
	b=scP33hucdPXzIGNqZlE7VHLPIPjZGtEIAjWRl3XRMDJNoOdCsD9Rkc8rnslpXv1x+
	 LvO1XJFdRmZwkOirCbauydZF+T7wF3SNCbXhA28oIXssVmZQZw4WIRTv5KJQPgV6sR
	 rVTcDvDyeEWBl6Bx7qgbfzT8nGwRrXlPPMCR+IgzK2F/ZXhL4YubyKKpH7K9jCnAIh
	 3I3KkdNG+YQMUCLNiWu5LiIdUkk9ex4btyn8p5+CXa0Z2g53W/NYulsROESP6udRpc
	 2qnqNCcamx/UEEvlAC3dQAfG8CLCcAcBDDZv5AdISdOO6dl45J9cBQDTPODjSEwX8e
	 h9+g5cnx8BQOw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65c932140001>; Mon, 12 Feb 2024 09:46:12 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 09:46:12 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Mon, 12 Feb 2024 09:46:12 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Pavel Machek <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>
CC: "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Linux support for a 7 segment LED display
Thread-Topic: Linux support for a 7 segment LED display
Thread-Index: AQHaXStZfYl8Vw6dm0yz1EAjpP4fVQ==
Date: Sun, 11 Feb 2024 20:46:12 +0000
Message-ID: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <89F51A7612CB9947A61785AE69527706@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=DOQ41lCpAAAA:8 a=J_LQV8rniBibxwXAtNQA:9 a=QEXdDO2ut3YA:10 a=7OqYSu99HvpW11Psslug:22
X-SEG-SpamProfiler-Score: 0

SGkgQmxpbmtlbmxpZ2h0IGVudGh1c2lhc3RzLA0KDQpJJ20gbG9va2luZyBmb3Igc29tZXRoaW5n
IHRoYXQgSSBmaWd1cmVkIG11c3QgZXhpc3RzIGJ1dCBtYXliZSBpdCdzIHNvIA0KbmljaGUgdGhh
dCBuby1vbmUgaGFzIGJvdGhlcmVkIHRvIHVwc3RyZWFtIGEgZHJpdmVyIGZvciBpdC4NCg0KSSBo
YXZlIGEgcmVxdWlyZW1lbnQgdG8gc3VwcG9ydCBhIDctc2VnbWVudCBMRUQgZGlzcGxheVsxXSAo
b25lIHRoYXQgY2FuIA0KZGlzcGxheSBhIHNpbmdsZSBkaWdpdCBmcm9tIDAtOSkuIEhhcmR3YXJl
IHdpc2UgaXQncyBqdXN0IGEgYnVuY2ggb2YgDQppbmRpdmlkdWFsIEdQSU9zIGNvbm5lY3RlZCB0
byBlYWNoIHNlZ21lbnQgKHBsdXMgYW4gZXh0cmEgb25lIGZvciBhIA0KZG90KS4gSSBjYW4ndCBz
ZWUgYW55dGhpbmcgb2J2aW91cyBpbiBkcml2ZXJzL2xlZHMgYnV0IG1heWJlIEknbSBsb29raW5n
IA0KaW4gdGhlIHdyb25nIHBsYWNlLiBPciBtYXliZSBpdCdzIHRoZSBraW5kIG9mIHRoaW5nIG9u
IFBDIGhhcmR3YXJlIHRoYXQgDQppcyBqdXN0IGRyaXZlbiBieSB0aGUgQklPUyB3aXRob3V0IHRo
ZSBvcGVyYXRpbmcgc3lzdGVtIGtub3dpbmcgYWJvdXQgaXQuDQoNCklzIHRoZXJlIGFuIGV4aXN0
aW5nIGluLWtlcm5lbCBkcml2ZXIgZm9yIHN1Y2ggYSB0aGluZz8NCg0KVGhhbmtzLA0KQ2hyaXMN
Cg0KLS0NCg0KWzFdIC0gaHR0cHM6Ly93d3cua2luZ2JyaWdodHVzYS5jb20vaW1hZ2VzL2NhdGFs
b2cvU1BFQy9TQTM2LTExR1dBLnBkZg0K

