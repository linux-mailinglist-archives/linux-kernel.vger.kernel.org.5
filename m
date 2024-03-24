Return-Path: <linux-kernel+bounces-112598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 404B3887BCF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC5A1F21ACE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9048D1401B;
	Sun, 24 Mar 2024 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="emp6ULex"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0B3D528
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711259790; cv=none; b=nxfj4/6iwHbS1H+LbTn4/UDJk9f/UzJhA0dYWCnXlzYyKrtsdhHCL+9L+/GsfmaMRUjqyNq4GIlQ5lwJX32vCdJaPb+Eo7BBBcqg2siGoA/HJpHzPCyG89oCw+30lx8YRa+pNxS54FWUcS2EQfvsxPQZZ3hIQC7/eznNV46uXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711259790; c=relaxed/simple;
	bh=cvLm+qbeJbEg6K85hZtSOwYq0zdft7CTVVdr9rBv89o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=kCS0lMwhjODESRmo/qVCApgxHb18SKI21wQquZfIMwsYdbFhxNIupD1loCh28/JKPNlrGXY6Q8EaP7vlOs7IHBhvR3pAc4HiUc/eczrVw4PxhAUY3U3sluJNanuWPnPzwDHDh8gspV1sw/wgWTo6p+sk0gtsVWzC8pAFcJV1juc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=emp6ULex reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=knpKBpX7Qw4Pm0XJApS/WG5pQKfGjw2SAdHKcghDbrY=; b=e
	mp6ULexluDTU3V706vxfyqxMYg7eLmqzF25x7gEA01/GzUl3345E+ACQnMPklKfr
	Kkr7FHmXHnMprvtZMNvFfmoq7IyJnbgcdosvsGd+2Whu1sZircRHrrk8TYSIgGQt
	jf9zXHlO6oAbS+UxlfwwtavDhkihReJ4sGYqh+Bpq4=
Received: from lumingyindetect$163.com ( [106.39.130.76] ) by
 ajax-webmail-wmsvr-40-105 (Coremail) ; Sun, 24 Mar 2024 13:56:06 +0800
 (CST)
Date: Sun, 24 Mar 2024 13:56:06 +0800 (CST)
From: lumingyindetect@163.com
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org
Subject: Re:[PATCH] tools:Fix a memory leak bug related to the cmd
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240323065550.603005-1-lumingyindetect@163.com>
References: <20240323065550.603005-1-lumingyindetect@163.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <17ddf389.9f7.18e6f07cfff.Coremail.lumingyindetect@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3fwF2wP9lVgwQAA--.10734W
X-CM-SenderInfo: poxpx0hj1l0vphwhu3i6rwjhhfrp/1tbiKRar92VOCH1F9QABsM
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

VGhhbmsmbmJzcDt5b3UmbmJzcDtmb3ImbmJzcDt5b3VyJm5ic3A7cHJvbXB0Jm5ic3A7cmVzcG9u
c2UhJm5ic3A7SXQmbmJzcDtpcyZuYnNwO2luZGVlZCZuYnNwO2EmbmJzcDt3aXNlJm5ic3A7ZGVj
aXNpb24mbmJzcDtub3QmbmJzcDt0byZuYnNwO3JlbGVhc2UmbmJzcDtkeW5hbWljJm5ic3A7bWVt
b3J5Jm5ic3A7d2hlbiZuYnNwO3RoZSZuYnNwO3Rvb2wmbmJzcDtydW5zJm5ic3A7YnJpZWZseSZu
YnNwO2FuZCZuYnNwO2VuY291bnRlcnMmbmJzcDtlcnJvcnMuJm5ic3A7SG93ZXZlciwmbmJzcDtJ
Jm5ic3A7YWxzbyZuYnNwO25vdGljZWQmbmJzcDtpbiZuYnNwO3RoZSZuYnNwO2Rpc2FzX2Z1bmNz
Jm5ic3A7ZnVuY3Rpb24mbmJzcDtpbiZuYnNwO3RoZSZuYnNwOy9saW51eC90b29scy9vYmp0b29s
L2NoZWNrLmMmbmJzcDtmaWxlJm5ic3A7KGxpbmUmbmJzcDs0NjE3KSZuYnNwO3RoYXQmbmJzcDth
Jm5ic3A7dmFyaWFibGUmbmJzcDtuYW1lZCZuYnNwO2NtZCZuYnNwO3BvaW50aW5nJm5ic3A7dG8m
bmJzcDthJm5ic3A7ZHluYW1pYyZuYnNwO21lbW9yeSZuYnNwO2FyZWEmbmJzcDtpcyZuYnNwO25v
dCZuYnNwO2JlaW5nJm5ic3A7ZnJlZWQmbmJzcDsocmVnYXJkbGVzcyZuYnNwO29mJm5ic3A7d2hl
dGhlciZuYnNwO2FuJm5ic3A7ZXJyb3ImbmJzcDtvY2N1cnMpLiZuYnNwO0luJm5ic3A7dGhpcyZu
YnNwO2Nhc2UsJm5ic3A7d291bGQmbmJzcDtpdCZuYnNwO2JlJm5ic3A7bmVjZXNzYXJ5Jm5ic3A7
dG8mbmJzcDthZGQmbmJzcDthJm5ic3A7ZnJlZShjbWQpPwrU2iAyMDI0LTAzLTIzIDE0OjU1OjUw
o6xMdU1pbmdZaW4gPGx1bWluZ3lpbmRldGVjdEAxNjMuY29tPiDQtLXAo7oKSW4gdGhlIGZ1bmN0
aW9uICdkaXNhc19mdW5jcycgZGVmaW5lZCBpbiB0aGUgZmlsZSAvbGludXgvdG9vbHMvb2JqdG9v
bC9jaGVjay5jLCBhIHBvaW50ZXIgdmFyaWFibGUgbmFtZWQgJ2NtZCcgaXMgZGVjbGFyZWQgKGxp
bmUgNDU4MyBvZiB0aGUgZmlsZSkuIFRoaXMgcG9pbnRlciB2YXJpYWJsZSBhbGxvY2F0ZXMgYSBi
bG9jayBvZiBkeW5hbWljIG1lbW9yeSB1c2luZyB0aGUgJ21hbGxvYycgZnVuY3Rpb24gYXQgbGlu
ZSA0NjE1LiBIb3dldmVyLCBhZnRlciB1c2luZyB0aGUgbWVtb3J5IGFyZWEgcG9pbnRlZCB0byBi
eSAnY21kJyAobGluZSA0NjE5KSwgaXQgaXMgbm90IGRlYWxsb2NhdGVkLCByZXN1bHRpbmcgaW4g
YSBtZW1vcnkgbGVhayBidWcuIFRoaXMgY29tbWl0IGZpeGVzIHRoZSBidWcuDQoNClNpZ25lZC1v
ZmYtYnk6IEx1TWluZ1lpbiA8bHVtaW5neWluZGV0ZWN0QDE2My5jb20+DQotLS0NCiB0b29scy9v
Ymp0b29sL2NoZWNrLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0K
ZGlmZiAtLWdpdCBhL3Rvb2xzL29ianRvb2wvY2hlY2suYyBiL3Rvb2xzL29ianRvb2wvY2hlY2su
Yw0KaW5kZXggZWI3ZTEyZWJjMWQwLi40ODZhMmE2Mzc0ZjUgMTAwNjQ0DQotLS0gYS90b29scy9v
Ymp0b29sL2NoZWNrLmMNCisrKyBiL3Rvb2xzL29ianRvb2wvY2hlY2suYw0KQEAgLTQ2MTcsNiAr
NDYxNyw3IEBAIHN0YXRpYyBpbnQgZGlzYXNfZnVuY3MoY29uc3QgY2hhciAqZnVuY3MpDQogCS8q
IHJlYWwgc25wcmludGYoKSAqLw0KIAlzbnByaW50ZihjbWQsIHNpemUsIG9iamR1bXBfc3RyLCBj
cm9zc19jb21waWxlLCBvYmpuYW1lLCBmdW5jcyk7DQogCXJldCA9IHN5c3RlbShjbWQpOw0KKwlm
cmVlKGNtZCk7DQogCWlmIChyZXQpIHsNCiAJCVdBUk4oImRpc2Fzc2VtYmx5IGZhaWxlZDogJWQi
LCByZXQpOw0KIAkJcmV0dXJuIC0xOw0KLS0gDQoyLjI1LjENCg==

