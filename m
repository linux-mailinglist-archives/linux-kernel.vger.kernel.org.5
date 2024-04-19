Return-Path: <linux-kernel+bounces-151924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EBF8AB5D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C11D1C21B14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5435213C9A9;
	Fri, 19 Apr 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Jz3Ju2Js"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EC013C9B4;
	Fri, 19 Apr 2024 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713556855; cv=fail; b=jqYipQPr6ZQu9oahi5K17j4srn5PYwjv9u/ahfDjohcl9pkNn9vxgGmUJOHx7iB4GMDvYuvZMpl5RQ6awIG0avpEp8WAYOkiGAjc/qeedTRfVN7bdH+guWdm/dCcbjLCWWn6N/QpF7ny9XB+WQIq9EQtMdYrkV7ZpJf28PbrSTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713556855; c=relaxed/simple;
	bh=egkRR2Nhur6UdCQUz6xte3ioJFO9MpFOstmrff028QE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fSk/K6pNawAwOHXxS5ri9QwF7s7YXQh8KRqvBVLwTiNJAOcRYcapyVpENS9kznMn1zG6ztrr4AUIzTqRJ8mVtFdJrs8J+gpAZyaKit9VqovSiblVdVOJ5uxEjmktINPp98OpSEy7EjhZTf88g2pIjHUFkjLnuc8r/20AlPbqZzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Jz3Ju2Js; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JHX215006992;
	Fri, 19 Apr 2024 20:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=g16rb7tGIqxrQCgM3s1TCoGKQHR+W/Qzz89dFJxHKrQ=;
 b=Jz3Ju2JsBS3G3/cPjFL+Fdu5jfWF4MheCVkkMR/b6PvFX+I/JNZmSl2BBA6Ec2svLFhF
 P+PVMjPCWCL77usjjkrxqsEa7Ad9utHJrydAQKmIthBLwcbX9v8p3ExlIpwyWhhsLyxO
 A9IuOjPFVpLyDAFiYLB/q84BPMWebjWmJfCF31Xfkx1J8trcyNagM1PEM3WyUITyTII/
 GGYj0KWNi3oxSUttSQ5RlB82DEvLwzMo6nTJIvwEfZzTTUxFwGI43oJ8ir6OgOelEOvf
 FgSTNfp58HuzzNuvL+P4XnqUVSYq4pT9CoR8ndq4T5m0RCqybeZgLwL4NmiTInOlcmNH tg== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3xkbkr8h6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 20:00:30 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 2533E1379E;
	Fri, 19 Apr 2024 20:00:29 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 Apr 2024 07:59:52 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 Apr 2024 07:59:51 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 19 Apr 2024 07:59:51 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 Apr 2024 07:59:51 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+M2R8qY4I12Efcb8vwYAP2oq29yIipuyLRcgPmR/wlWUgBvKPc6PcC/eY3ymhtapKqHmGGNXaPX+JWhgufXCvM7SZ6LqEDWjhNrphZ1dCstgAE+ehEPjQTE4E/jp9bJiOkQuC25Opl0xNFA1z6RHfMrk7R7wWOMz+aMt/Q67i4GAYqdyKBvux5QNQTyjBShzsarPaLpkj1v02Old89zdH643cbfGOFJPzKTBOujydGnh7wzPJIfONd939voT7Ey8lw1OTJKet1RxXRD/cSv8tgyauCofxg2KxL4EJggRSzHzb7rnTiD2706hU2gkh9GAdslE//pnSlxKouc/zoZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g16rb7tGIqxrQCgM3s1TCoGKQHR+W/Qzz89dFJxHKrQ=;
 b=mtpnce1KV+B74a7UHEMNHrZwdOgbO6/MXB/St/IlXRwtiHPzjo2Ruyrkw8nJiFzyvsCQKxK0jKnHGRXSSgvKSVG9uMB5HuHsylVlG4i4QM6DqviE71cW7T53hgEpZ/NS2zz7qruHE4m6sEzKPiSct792/kA7WzVgJXTphBmo6vRfkYP9K2AfJrhiXYE3929CxIxFM1zt4pUl2gttfBlJnXn9cLzqlDy+6NahWm2BriTWpSPOH2U0W+cKBNd9O9Ak0Ou6emD3RGsHvIr0kCsN9fEAeHX5vW8wixhMdjGCQOCoPxkHQika7BHbVQOaxiGbUHaxtnKInNqVGKIY7WIwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1928.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 19:59:49 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4da6:9972:feeb:2ad7]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4da6:9972:feeb:2ad7%6]) with mapi id 15.20.7519.015; Fri, 19 Apr 2024
 19:59:48 +0000
From: "Elliott, Robert (Servers)" <elliott@hpe.com>
To: Aapo Vienamo <aapo.vienamo@linux.intel.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Andy
 Shevchenko" <andy@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Mika Westerberg
	<mika.westerberg@linux.intel.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
Thread-Topic: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
Thread-Index: AQHakjC6i7OisBxFg0KE35p6PF3J07FwAqng
Date: Fri, 19 Apr 2024 19:59:48 +0000
Message-ID: <MW5PR84MB1842F4C102CBFA73E861F420AB0D2@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
In-Reply-To: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|DM4PR84MB1928:EE_
x-ms-office365-filtering-correlation-id: 9372aff9-fd77-4a47-c6fd-08dc60ab4494
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?G6s30tN07mOM6cAW4pHD/Nobhgji1UpehAvRUSbsVOlPykW1nbX+/tr9i4tI?=
 =?us-ascii?Q?/mLEbhBlM/Kc7/KhcUZX14jSfO68KijEpLEJOOkBY1/KGg7iDEdQo7H1vC6B?=
 =?us-ascii?Q?acBHLdAoMKVrEZyk72eEmbqj9ht5kXHzGWc004rm+rRAfa65wtlzpOpaIvjY?=
 =?us-ascii?Q?wyoTZ4yRoRUgoZQoqoRkiAZADKYCIfj/we0P6y2wtevzkzB2eC/0ZLB4N2aZ?=
 =?us-ascii?Q?25EuukpfhX/80i1oNzCVLOPoXIZtKo+Ipl34aLNd8wzAJH+YoxF0SbDFYGwS?=
 =?us-ascii?Q?ZtPxBdoXQb9Pr0Aa1lqcqN/NV+GpEpV2zfvI8CGLHKXcJFHytBVtyUNO7ZBx?=
 =?us-ascii?Q?5kwHCI5EiWONYtp5orKY5qfcyaCqn3ldJFMaj2Qc8/y9w+T2dBaj3e/NZIyM?=
 =?us-ascii?Q?oGLNPk0iwYxS9Gr0pqaSLTKnimjuAfdlmMd3fIyG41I1iYZKeFlXd+i0BzcZ?=
 =?us-ascii?Q?3Pji9kdC7q813TjkNraSlYcECYC0/9Q961StTXGGZ+ou0PlBl2mttRu8wBHz?=
 =?us-ascii?Q?ZEWqbbmN9BESATB0SMT+OMgQW8rUdAtZlTgyfo3lGvjy7g/lJA3Ywh/7tB5a?=
 =?us-ascii?Q?fiNFrzJ89NQlCsK3u+R/erAODCCoXKMrXH8EVfoQ7hXxOFB02/qx/GBg+uk7?=
 =?us-ascii?Q?ntg3dnPzF/nH1tRU9sFjM4tcnnXyFVKhvYhrk1BHZ3Jd/0CyEUIB3rg+x1xc?=
 =?us-ascii?Q?45i3W/TxC7jQK7Ce9sIcxKJpTay5FM+7+hxGvxfxLkXGYBAADEjSzuHOuexc?=
 =?us-ascii?Q?f2GniD9yh3FOrLflZVrLfpPlDy5JohYY7Wlxgw12J/0tfzxMkPDgXPgNv1LN?=
 =?us-ascii?Q?9fa10shMQz/7436IxhHiZ7wbbT3VrwutECiZq8fdiZKeW5tZ7DimOrZel68P?=
 =?us-ascii?Q?weiw/bVb9xwW0mV3+mTSOdfM1kbcn08/kH+N65kCKAskdt3KzNml4Uoalb1H?=
 =?us-ascii?Q?watBle9sQHeAwAVjrNtVnnmq5HszGnTp8PAGM8emg+06nJnZT0z0SsiSS+nD?=
 =?us-ascii?Q?e0AGFVbPiGkIyLq4B4MZ+3KZPSbqq+4wHpLUxbytZh3EySFFxkIcocf9Eo7p?=
 =?us-ascii?Q?Y97mcfQM4LFuSF6M9vRGj6QWZhEAKYmqFNkTxtImqv1Z/5qzaVZh/HkKGC9E?=
 =?us-ascii?Q?4QfvYbDgSL72ZI57nO6lVlSwD9VZPw3QCYJughWyCp2iitruNOcUUwBmCJ2v?=
 =?us-ascii?Q?4D4H/iwoa3c5VcOYNZhB59Gs0uIkZHJBP7asDS1eOpTEjXibB9FG4eLIDswe?=
 =?us-ascii?Q?d9woJuS99VeUJrSFaN3JRXG5gRgkkguFB5AUldZgg4F+shNDhNhRnZONm1kQ?=
 =?us-ascii?Q?fA9ZICgqC4kPQNPy/VAuUTOo2TlB6KH/n9VtZVMNto5bMQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zJbj0jYsDLJ8DcSB6bErvaRoq2NfvQc5Bv9LUfPSL2dZCXBH8raXkGSKn3lE?=
 =?us-ascii?Q?GmnB17hTi1vIFy4MDK1zVHhrXqoqcqNunQ+4olAmQzTatoABmSfZPm9w/twQ?=
 =?us-ascii?Q?0qlqpu3F5VQKBGMqW2kifOs1X6gEZto5xWl1XQH7/MHv8iEHY/E0HNaNXi39?=
 =?us-ascii?Q?x77p/RqwqSHMnfgtEJdM6NOm7vxm0L9GeQQ09DxI8SiWkX08EYpGa6st3BcO?=
 =?us-ascii?Q?9x4M0vu/CuxXMcXhZW6PKKchWt92cLYyIlsSRu6r0E6hJ3bwHjOiU3Sp8lD1?=
 =?us-ascii?Q?VYNVGUuPBj9kPtYSWMV5Si/kVnRu37H9zE5B8gN+1fhRLzx2wytPRKH10/ue?=
 =?us-ascii?Q?ClpUVSREN83O9Q/uVr+Dk8YHfFTeOPcXNRqX1M/5EgrSgE2DRYYcd0ItEG/a?=
 =?us-ascii?Q?sIkNnfgvq96/MeOTmDbHjbPx4ZUhxEUP1n3FntWF6MP1RWeKQnrWkcGWc2z4?=
 =?us-ascii?Q?U3qvomio2ubvlGJ8uY9M5IStiBrsXHMQKdilt7OvpZiYzy+SUNEWuw0YYkq7?=
 =?us-ascii?Q?KDw4F1oCiQ7s/Yr6Mk6X06PzHqvyoZjBBmyDzqqg9DMawNXufOJPrl1wcGAP?=
 =?us-ascii?Q?+oRARgn/jB1QGTz1L6apiY9bU9soNSvZTbmgmLb0OHGGSGnvYMpdj8EitTSs?=
 =?us-ascii?Q?XHnLWotAwDz1hfP9RUJ3Z/IcW2FEehHbtkPMPy3h98lMnxhxNqvLKbLMW7Pa?=
 =?us-ascii?Q?HLZd0VfTE9Eic3e/Ux38scwWmLEFIL26gm25KBlsK8tjPpDMKxTq8ep64EcP?=
 =?us-ascii?Q?TiSd+MoK/UDVHj4YKv0EMqfZBZrVdz1lrbI6CXBwTgrGhw3Oq9xr4WHUeK3G?=
 =?us-ascii?Q?LCnUsO1mPsenunSzrY2d9JA6ajkDQxI8ivGi4LoFlJlixHeILqA5v8Yl9Sun?=
 =?us-ascii?Q?N/EY8CTWq04LqUNXyazSaVTHVCEl/iXcpnFpB7sUQZ09S7x5JpvPek9vQkbo?=
 =?us-ascii?Q?6Z3AMIhw8CATNTFBp54oeq1HTGMe5hHLIo4tj1r4P9TTO7FLbjCEo/SC0MOo?=
 =?us-ascii?Q?NCBgYuzcSGL5wAeTHx7xEzgIAtpMokArDuq8D0ZZFfaRixXouXR9KenVzR4I?=
 =?us-ascii?Q?zvdLzLm/wv9gf8L6dgrmFpUocCHRo/tyagLYXp12rCWsG1BLoCW/ktrXaeY7?=
 =?us-ascii?Q?lgWCLvu12LaWoW1qp/PkUC50KlKdGuLvcejCP0OQHJOs+0uxPpHxlGgkRPrI?=
 =?us-ascii?Q?V9iZO6ajW4UOcyoEYnToBB/nDP223KA7nSxEY8XFYssoQ24WlJKbSAItJ4pd?=
 =?us-ascii?Q?fgl0s38LqHk6txcuuA17hxOpq8W/7MkcfBqtBQO/tn+emoga0z44NGrsdSB6?=
 =?us-ascii?Q?LVwwXrsrA5SfNnpHUFH8gHG24XJP81gNeLr6i+lHKlac5eizCdjWYqD3xkUX?=
 =?us-ascii?Q?CnXKD2ot/ljL9+6vkKsWPhij0ZTrP2x/6oAVWbiCAd6VeC/A5L2aoELrV/22?=
 =?us-ascii?Q?fODw53lXy7CzFSQXlZzKS4RXKGMeYyffSUyJHk71Y+KRkRryVW198O79suCB?=
 =?us-ascii?Q?FNvaANGaPRmaJ27bwG0LkUBF2/B2+/L5AGk1+31a55PN1sucuRcEnAW5z+MV?=
 =?us-ascii?Q?m8LozB4709P7IIC+WeA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9372aff9-fd77-4a47-c6fd-08dc60ab4494
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 19:59:48.5763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYkShjx3cTckHcRaqjnOoxn/+0I+BzK4p77yZgGS2Ao2URZygiQpjPkPYFOqyWGf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1928
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: V42NOh3V-zIN77QidtbGP-R8GnO7nXlP
X-Proofpoint-ORIG-GUID: V42NOh3V-zIN77QidtbGP-R8GnO7nXlP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_15,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=946 suspectscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190154



> -----Original Message-----
> From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> Sent: Friday, April 19, 2024 3:06 AM
> Subject: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
>=20
..

> +static int gnr_gpio_probe(struct platform_device *pdev)
> +{
> +	size_t num_backup_pins =3D IS_ENABLED(CONFIG_PM_SLEEP) ? GNR_NUM_PINS
> : 0;
> +	struct device *dev =3D &pdev->dev;
> +	struct gpio_irq_chip *girq;
> +	struct gnr_gpio *priv;
> +	void __iomem *regs;
> +	int irq, ret;
> +
> +	priv =3D devm_kzalloc(dev, struct_size(priv, pad_backup,
> num_backup_pins), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D devm_request_irq(dev, irq, gnr_gpio_irq, IRQF_SHARED |
> IRQF_NO_THREAD,
> +			       dev_name(dev), priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request interrupt\n");

All of these early returns will leave the memory allocated to priv
forever, since priv isn't saved anywhere until:

> +	platform_set_drvdata(pdev, priv);




