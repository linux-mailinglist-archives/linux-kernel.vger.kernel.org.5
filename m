Return-Path: <linux-kernel+bounces-160022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177AC8B37E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20422830A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32A5147C7F;
	Fri, 26 Apr 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="ATbyQjYt"
Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.224])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6CC144D3E;
	Fri, 26 Apr 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136568; cv=none; b=ae8ae63wywwaZJqUlndGaSxiPytJcBMy3Fbg7TEqiaSt2d4ZudFiC/fNnqegNkBsYJSmFDRvBKZf3KgT8nTAVrEDYZhrwHHnyZyOb+Qk1rrQX3pc3xf1DPSsy8wQzsMMU3a9w55UzzREWG1BMsspTe5OnES15uciEEULWrxqXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136568; c=relaxed/simple;
	bh=soMmJwW/AsjQhGgdXSQVtTIyLV1ngCkQNd5KJJYDyto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=KbeqZrlYIFyoieSQW5sw2aavTGoovVJqBRd3Q0p/6Nq4JWu2LUYe4gN0vqEE9caUTq8tgbp0g1Ide7gdKeiLxMTgmIoQuxDAsleEREISwdomwdK4rMgIQb6bufohy8iWrvk/iInolIO0quHex73hz+GteeQXas+p2JTd+kz+YOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=fail (1024-bit key) header.d=126.com header.i=@126.com header.b=ATbyQjYt reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=rKagjV8vcCbTWhtyDBQwvd1P1ngXlvGTUhTGAep183E=; b=A
	TbyQjYt5kK4dUsFjkP7HcXnJf//evm7C/vlcafIGWiZ54m7f66R3G4ItvfAZ+tt8
	6KTVX/6/p592zVVqHYYq0l4wNzcmm4d+dPMBV9avKU770nKKmREC3DWWWUOnuEIL
	ifbDP61wRBGMxJGa/b7leQrQugZMMYXgBBVFudtv5c=
Received: from lumingyindetect$126.com ( [223.72.74.31] ) by
 ajax-webmail-wmsvr-41-117 (Coremail) ; Fri, 26 Apr 2024 21:01:52 +0800
 (CST)
Date: Fri, 26 Apr 2024 21:01:52 +0800 (CST)
From: lumingyindetect <lumingyindetect@126.com>
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, 
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Jiri Slaby" <jirislaby@kernel.org>
Subject: Re:Re: [PATCH] serial: 8250_lpss: Fix memory leak in
 lpss8250_probe()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 126com
In-Reply-To: <42c5d1f0-d16a-483b-8bb1-4c5768aa3a8c@web.de>
References: <20240426114716.1275085-1-lumingyindetect@126.com>
 <42c5d1f0-d16a-483b-8bb1-4c5768aa3a8c@web.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4e6966e0.a07e.18f1a7f7863.Coremail.lumingyindetect@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f13BpStmQ4NWAA--.26630W
X-CM-SenderInfo: poxpx0hj1l0vphwhu3a6rslhhfrp/1tbi6BDM9mVLbD4A4AABsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

RGVhciBNYXJrdXMsPGJyLz48YnIvPlRoYW5rIHlvdSBmb3IgeW91ciBwYXRpZW50IGd1aWRhbmNl
IGFuZCBhZHZpY2UhIFRoaXMgaXMgbXkgZmlyc3QgdGltZSBzdWJtaXR0aW5nIGEgcGF0Y2gsIGFu
ZCBJIGhhdmVuJ3QgZnVsbHkgdW5kZXJzdG9vZCB0aGUgbWVhbmluZyBvZiAiYWRkIGEgY29tbWl0
IHN1YmplY3QgZm9yIHRoaXMgdGFnIiB5ZXQuIENvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBzb21l
IGV4YW1wbGVzIG9yIGd1aWRhbmNlIG9uIGhvdyB0byBhZGQgaXQ/IEkgYXBwcmVjaWF0ZSB5b3Vy
IGhlbHAhPGJyLz48YnIvPkJlc3QgcmVnYXJkcyw8YnIvPkx1TWluZ1lpbgpBdCAyMDI0LTA0LTI2
IDIwOjI4OjQzLCAiTWFya3VzIEVsZnJpbmciIDxNYXJrdXMuRWxmcmluZ0B3ZWIuZGU+IHdyb3Rl
Ogo+4oCmDQo+PiBJbiB0aGUgbHBzczgyNTBfcHJvYmUoKSBmdW5jdGlvbiwgSSBhZGRlZCBhIGxh
YmVsIG5hbWVkICJmcmVlX2lycV92ZWN0b3JzIiB0byByZWxlYXNlIHRoZSBkeW5hbWljYWxseSBh
bGxvY2F0ZWQgbWVtb3J5IHJlZ2lvbiBwb2ludGVkIHRvIGJ5IHRoZSB2YXJpYWJsZSBwZGV2LCBh
bmQgcmVwbGFjZWQgdGhlIHR3byByZXR1cm4gc3RhdGVtZW50cyBtZW50aW9uZWQgYWJvdmUgd2l0
aCBnb3RvIHN0YXRlbWVudHMgdG8gdGhpcyBsYWJlbC4NCj4NCj4qIFBsZWFzZSBpbXByb3ZlIHRo
ZSB3b3JkIHdyYXBwaW5nIGFjY29yZGluZyB0byBsaW5lIGxlbmd0aCBwcmVmZXJlbmNlcw0KPiAg
Zm9yIGNoYW5nZSBkZXNjcmlwdGlvbnMuDQo+DQo+KiBQbGVhc2UgY2hvb3NlIGNvcnJlc3BvbmRp
bmcgaW1wZXJhdGl2ZSB3b3JkaW5ncy4NCj4NCj4NCj4+IEZpeGVzOiBlODhjNGNmY2I3Yjg4OGFj
Mzc0OTE2ODA2Zjg2YzE3ZDhlY2FlYjY3DQo+DQo+UGxlYXNlIGFkZCBhIGNvbW1pdCBzdWJqZWN0
IGZvciB0aGlzIHRhZy4NCj4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IEx1TWluZ1lpbiA8MTE1NzAy
OTEreWluLWx1bWluZ0B1c2VyLm5vcmVwbHkuZ2l0ZWUuY29tPg0KPg0KPkkgZmluZCB0aGUgYXV0
aG9yIGVtYWlsIGFkZHJlc3NlcyBzdXNwaWNpb3VzIGFjY29yZGluZyB0byB0aGUgRGV2ZWxvcGVy
J3MgQ2VydGlmaWNhdGUgb2YgT3JpZ2luLg0KPmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24v
cHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0P2g9djYuOS1yYzUjbjM5OA0KPg0KPldvdWxk
IG90aGVyIGVtYWlsIGFkZHJlc3NlcyBiZSBtb3JlIGFwcHJvcHJpYXRlIGZvciBkZXNpcmVkIHBh
dGNoIGNvbW11bmljYXRpb24/DQo+DQo+UmVnYXJkcywNCj5NYXJrdXMNCg==

