Return-Path: <linux-kernel+bounces-109749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CABA885538
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E3EB21778
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DCB5820D;
	Thu, 21 Mar 2024 07:58:36 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49423A1DE;
	Thu, 21 Mar 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007915; cv=none; b=aTIrFcURejD7qSwRDmP2PfqjoyxdLZNR/z8b6q3y/r5rZ9UuxIY1bHKqTo7wLDlQukB8w5zobzM9XMDQ3czA4e1NTV9oehtNKzQOfMKE6rrfKE6B7BmUTedCuINHNqMbGPOHeZ0XHkV1DoM6JvGj1Qm0pi/axM1AOWFMiy6O5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007915; c=relaxed/simple;
	bh=FOxNEXZ9LoI28qYyifvU8qUpUyH83SG5h8zuxJ0WK3w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nFTX3nFobWcYWB9EYzRZ94HI0d69pDBoI/g5D/JnEgeHCowfL64YkPqVDJ1Z2OwHO8x3ln/7z/DJ3YerMBtDKbN+SS79n6uHhA9OWT0o4NcSp2dXgV4h5spDHouoAaumN7hEhwlDO3EFcPdSSxPRda/SocNElDKKFud4KXPA/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 42L7vQPX052728;
	Thu, 21 Mar 2024 15:57:26 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX03-IMDC.srv.huawei-3com.com (unknown [10.62.14.12])
	by mail.maildlp.com (Postfix) with ESMTP id 59DB42004BAA;
	Thu, 21 Mar 2024 15:59:08 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX03-IMDC.srv.huawei-3com.com (10.62.14.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Thu, 21 Mar 2024 15:57:28 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Thu, 21 Mar 2024 15:57:28 +0800
From: Liuye <liu.yeC@h3c.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "jason.wessel@windriver.com"
	<jason.wessel@windriver.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFYzXSBrZGI6IEZpeCB0aGUgZGVhZGxvY2sgaXNzdWUg?=
 =?gb2312?Q?in_KDB_debugging.?=
Thread-Topic: [PATCH V3] kdb: Fix the deadlock issue in KDB debugging.
Thread-Index: AQHaezckCXAchSVaZ0+2QsrTyw6AgbFBSNsAgACKiZA=
Date: Thu, 21 Mar 2024 07:57:28 +0000
Message-ID: <3cb0b32b8b4946efb93ce68729d4c321@h3c.com>
References: <20240320162802.GA22198@aspen.lan>
 <20240321022604.4088438-1-liu.yec@h3c.com>
 <2024032137-parrot-sandbank-ab29@gregkh>
In-Reply-To: <2024032137-parrot-sandbank-ab29@gregkh>
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
X-MAIL:h3cspam02-ex.h3c.com 42L7vQPX052728

DQo+IFRoZSBzdGFjayB0cmFjZSBiZWxvdyBzaG93cyBhbiBleGFtcGxlIG9mIHRoZSBwcm9ibGVt
LiBJbiB0aGlzIGNhc2UgDQo+IHRoZSBtYXN0ZXIgY3B1IGlzIG5vdCBydW5uaW5nIGZyb20gTk1J
IGJ1dCBpdCBoYXMgcGFya2VkIHRoZSBzbGF2ZSANCj4gQ1BVcyB1c2luZyBhbiBOTUkgYW5kIHRo
ZSBwYXJrZWQgQ1BVcyBpcyBob2xkaW5nIHNwaW5sb2NrcyBuZWVkZWQgYnkgDQo+IHNjaGVkdWxl
X3dvcmsoKS4NCg0KQWRkIGRlc2NyaXB0aW9uIGluZm9ybWF0aW9uIA0KDQo+IFNpZ25lZC1vZmYt
Ynk6IExpdVllIDxsaXUueWVDQGgzYy5jb20+DQo+IENvLWF1dGhvcmVkLWJ5OiBEYW5pZWwgVGhv
bXBzb24gPGRhbmllbC50aG9tcHNvbkBsaW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5p
ZWwgVGhvbXBzb24gPGRhbmllbC50aG9tcHNvbkBsaW5hcm8ub3JnPg0KDQpBZGQgDQpDby1hdXRo
b3JlZC1ieTogRGFuaWVsIFRob21wc29uIDxkYW5pZWwudGhvbXBzb25AbGluYXJvLm9yZz4NClNp
Z25lZC1vZmYtYnk6IERhbmllbCBUaG9tcHNvbiA8ZGFuaWVsLnRob21wc29uQGxpbmFyby5vcmc+
DQoNCg==

