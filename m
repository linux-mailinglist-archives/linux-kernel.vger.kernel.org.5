Return-Path: <linux-kernel+bounces-42261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BBD83FEA4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95732B222EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A074CDE5;
	Mon, 29 Jan 2024 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="r+AeYvWN"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F34CDF9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706510716; cv=none; b=pLw9i2xV4eCBHmba+XK6yY1bfSAiJI5vhAk6Bku3Pwb2IcHh/LKEEanyOchIDYYeKqEXvRsAtmQCy2iwGm+4exGai3zVN0iYfmoeZYMw2PqXdtxhk9RB1071QaAbeYB6Ko1yjBgMXa3ytr+qTAxRRFDKEkO0fUzt/lf5Ro0zryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706510716; c=relaxed/simple;
	bh=CdvBsoSoCHzWsp34cpiSESmPcI6Lb+0AyCuuanJvfi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ulNtrXXcBxi/Lr2fkLL7rGMqt7kVVhhE+Fn/xPn9zjXUd3963K6TecEivK7e+NKJbsvRmlWRo9Q08Q4ipbP9qI2B5boDuudZ5J8iYljgfv/GedqFXs22/ZqTU6qbhzJ7UiNeak2solR+iXMzsXNWQtiWHhfvc2SkzirDiPoyXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=r+AeYvWN; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1706510701; x=1709102701;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CdvBsoSoCHzWsp34cpiSESmPcI6Lb+0AyCuuanJvfi4=;
	b=r+AeYvWNt8cHIyynPq8reGYyTjMrSlDbnakgJrT66bHk6oanKD2NqPm70Cz/evZM
	Ud+PvkkpvjtP8DkKuv6SPnw/QP6utNJqbco4PuKXm0+4YD5NI0CxkEhSeQaTqQJE
	BzD7GUydxp/5rfE/j3JIbbnB+hyQBouAXIIIfoQKKc8=;
X-AuditID: ac14000a-fbefe7000000290d-4e-65b7496d27ac
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1F.91.10509.D6947B56; Mon, 29 Jan 2024 07:45:01 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 29 Jan
 2024 07:45:01 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 29 Jan 2024 07:45:01 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-imx@nxp.com" <linux-imx@nxp.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "mripard@kernel.org" <mripard@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "will@kernel.org" <will@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "festevam@gmail.com" <festevam@gmail.com>,
	"quic_jesszhan@quicinc.com" <quic_jesszhan@quicinc.com>,
	"primoz.fiser@norik.com" <primoz.fiser@norik.com>, "sam@ravnborg.org"
	<sam@ravnborg.org>
Subject: Re: [PATCH RFC for upstream 1/4] dt-bindings: display: panel-simple:
 add ETML1010G3DRA
Thread-Topic: [PATCH RFC for upstream 1/4] dt-bindings: display: panel-simple:
 add ETML1010G3DRA
Thread-Index: AQHaUDW1vX4f1M9A2kaPejSYk7EXprDsN9gAgAQUVQA=
Date: Mon, 29 Jan 2024 06:45:01 +0000
Message-ID: <dd0954c68bf32cf7a96690af1c78ebb05baf66d4.camel@phytec.de>
References: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-0-8ec5b48eec05@phytec.de>
	 <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-1-8ec5b48eec05@phytec.de>
	 <20240126-briskly-clang-d1e6ad7d40e8@spud>
In-Reply-To: <20240126-briskly-clang-d1e6ad7d40e8@spud>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <33C813F92074E14DB8AA8A451C6EF94B@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUiTURTHu8+bj6Ph05zsqpU0rFDypUy6WFQfIm4EmUVFfqmlDzmntuas
	rKgMFZ2iKfk2TS1Hc2vRnJrOHNUS8gU00ozMtKGIQWkWZRb2sj1Ffvufc/6//zkXLktKntAB
	rDJNy2vSFClyRkRZ/JctD0vd08ZH2hp8UffLWwSavV0IkMXRTyBTmZlBv+6XkKiuq59GQ19m
	GeR6EYvMZXYKFU27SGSbGKaR7ruJRIMdNQy6OddKodz82zSatY8A1K1z0ehqaQWJchxdXmix
	zUahxoVWgKZbZGiho5ZCLe9LaFQwsx5lj0bvDMCWWgvAjq/1FLbr33hhmzmfwaPDnQyu7YnD
	4wVPCdxsuIyLC7JpPP/FSuOmmXYCFy9G4pLOS9hQ/oLBzX0X8Gfb6v1cvGhbIp+iPMNrIrYf
	FyVNtv0i1P3MuZEfzBXQzuiANwu5zXCqogXogIiVcA0ErPww5yUU4wBaTK2kUFgBLKo1UW6E
	4YJhT+Vz4NZSLgQaS2sIt4nkHotgU9mkx+TLKeBgfjUpmE7Ah4UOL0HHwLtXFwi3pri10J41
	QesAy4q53TDPGS8sGwPQ8fGZ5z5vbgvMnSr3sIBbBa3WAU8mycmgbWqeFt7AQUOn0IecH3w3
	8fNvPwh2j5QT7nzyz6H3OiIEFMFcXS8h6DXweoHLEy/mVsCeqknqGpDpl2zQ/6f1S2j9Elq/
	hK4HtBlIUpUJKl6jVIWrkzK1fEJ4Im8D7o8mXSZqB0U12AkIFjgBZEm5VLwQ0spLxImKzPO8
	5tQxTUYKn+4EgSwll4nv5B3kJdxJhZZX8bya1/ybEqx3wBVQFR3tPfspvFTuPOB76JJJPbPV
	HAQbj5ZmaKOK08cS4nzSTvcZAg4/2J+ozul1GpPFa0NxLOCDjc2vzyp8d8j84+Okm9KGVH5h
	L/cdeXRvw92BZGMh6PjYk31j5cW64V12nyjXK1vMlqDXe8O+bX1bbWTX6aZDzJOBcbgvVJbV
	KKfSkxQbQ0lNuuI3M8uzMlYDAAA=

SGkgQ29ub3IsDQoNCk9uIEZyaSwgMjAyNC0wMS0yNiBhdCAxNjoyNyArMDAwMCwgQ29ub3IgRG9v
bGV5IHdyb3RlOg0KPiBIZXksDQo+IA0KPiBPbiBGcmksIEphbiAyNiwgMjAyNCBhdCAwOTo1Nzoy
M0FNICswMTAwLCBZYW5uaWMgTW9vZyB3cm90ZToNCj4gPiBBZGQgRW1lcmdpbmcgRGlzcGxheSBU
ZWNobm9sb2d5IENvcnAuIGV0bWwxMDEwZzNkcmEgMTAuMSIgTENELVRGVCBMVkRTDQo+ID4gcGFu
ZWwgY29tcGF0aWJsZSBzdHJpbmcuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWWFubmljIE1v
b2cgPHkubW9vZ0BwaHl0ZWMuZGU+DQo+IA0KPiA+IFtQQVRDSCBSRkMgZm9yIHVwc3RyZWFtIDEv
NF0NCj4gDQo+IFRoZSAiZm9yIHVwc3RyZWFtIiBoZXJlIGlzIG5vdCByZWFsbHkgcmVsZXZhbnQs
IHdoYXQgZWxzZSB3b3VsZCB0aGUNCj4gcGF0Y2ggYmUgZm9yPw0KDQpJIHNlbnQgdGhpcyBmb3Ig
aW50ZXJuYWwgcmV2aWV3IGZpcnN0IGFuZCBmb3Jnb3QgdG8gcmVtb3ZlIHRoZSB0YWdzLCBzb3Jy
eS4NCg0KWWFubmljDQoNCj4gDQo+IEFja2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xl
eUBtaWNyb2NoaXAuY29tPg0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCj4gDQo=

