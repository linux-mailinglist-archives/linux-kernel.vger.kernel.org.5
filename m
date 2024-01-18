Return-Path: <linux-kernel+bounces-30242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769F0831C14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128991F240CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2F52575D;
	Thu, 18 Jan 2024 15:11:31 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDDC1E51D;
	Thu, 18 Jan 2024 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590690; cv=none; b=rgknCEJg1gtXfInr8Ij79oeROppnW9pMwFx3f4yRSfrduiHGrjp0BCIQnzx7JMCNkOnpEYTXnLnOcB+3Llt1nWXyuNaE7fmf5qVhdGhx8q9JDfckaHkdtiPq4Gh6wLsldmfVpc7hSdERRaSZiaiSpXIU34k+55vYDx/HrTxxOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590690; c=relaxed/simple;
	bh=65sc4DCCtX31xXELKFiH2rA/add6gA3jTnYbzFDwIKE=;
	h=Received:X-Originating-IP:Date:X-CM-HeaderCharset:From:To:Cc:
	 Subject:X-Priority:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	 X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam; b=dQy7tIV0OIcAFCnvDBphTVmTl+kn2lfqNjkEnnCl8duaPoXos6Jy3yVb65HP4RzLChExZ3yOJArLTjPXkTWTPf2syeKBSN9oEhucvWSi+7dwAAqOBmKrgqlhtyvSyI7u7k2xT6ly9hSBXAriOG6qBdtAezQIWFB95fvU6O3Mvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [10.190.77.201] ) by
 ajax-webmail-mail-app3 (Coremail) ; Thu, 18 Jan 2024 23:10:55 +0800
 (GMT+08:00)
Date: Thu, 18 Jan 2024 23:10:55 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	"Sakari Ailus" <sakari.ailus@linux.intel.com>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Kate Hsuan" <hpa@redhat.com>, "Dan Carpenter" <error27@gmail.com>,
	"Brent Pappas" <bpappas@pappasbrent.com>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: atomisp: ssh_css: Fix a null-pointer dereference
 in load_video_binaries
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <CAHp75Vdz4FRF5=zFiKarOkA6ezOTP=CbwU2-_fpSCpuaZgb+VA@mail.gmail.com>
References: <20240112083421.3728017-1-alexious@zju.edu.cn>
 <5dd12651-232d-41f2-afa4-2a3e5c127969@redhat.com>
 <CAHp75VfKj7sQ3HkNaqNe0CjVrRb0J=X3gPJf-rSLeU8RQ2hjFg@mail.gmail.com>
 <17d22c9e.4900.18d162090d8.Coremail.alexious@zju.edu.cn>
 <CAHp75Vdz4FRF5=zFiKarOkA6ezOTP=CbwU2-_fpSCpuaZgb+VA@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2b56b7f3.66be.18d1d200910.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgA3XzuAP6llg30+AA--.8091W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgUEAGWoH+EnWQAAsO
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBPbiBXZWQsIEphbiAxNywgMjAyNCBhdCA4OjM04oCvQU0gPGFsZXhpb3VzQHpqdS5lZHUuY24+
IHdyb3RlOgo+ID4gPiBPbiBGcmksIEphbiAxMiwgMjAyNCBhdCAxMDo0OeKAr0FNIEhhbnMgZGUg
R29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IE9uIDEvMTIvMjQgMDk6
MzQsIFpoaXBlbmcgTHUgd3JvdGU6Cj4gCj4gPiA+ID4gPiBGaXhlczogYWQ4NTA5NGIyOTNlICgi
UmV2ZXJ0ICJtZWRpYTogc3RhZ2luZzogYXRvbWlzcDogUmVtb3ZlIGRyaXZlciIiKQo+ID4gPiBC
ZXNpZGVzIHRoYXQsIGFyZSB5b3Ugc3VyZSB0aGUgRml4ZXMgcmVmZXJzIHRvIHRoZSBjb3JyZWN0
IGNvbW1pdD8KPiA+Cj4gPiBXZWxsLCBJIHRoaW5rIEkgcmVmZXJyZWQgdG8gdGhlIGNvcnJlY3Qg
Y29tbWl0LCB3aGljaCBpbnRyb2R1Y2UgdGhlIHdob2xlIG1vZHVsZSBhbmQgbGVhdmUgdGhpcyBi
dWcuCj4gPgo+ID4gSWYgSSBkaWQgbWlzcyBzb21ldGhpbmcgcGxlYXNlIGxldCBtZSBrbm93Lgo+
IAo+IFllcywgdGhlIGRyaXZlciB3YXMgYmVmb3JlIHRoYXQgY29tbWl0IGluIHRoZSBrZXJuZWwu
IFdhcyBpdCB3aXRob3V0Cj4gdGhlIGJ1Zz8gTm8sIGJlY2F1c2UgeW91IGFyZSByZWZlcnJpbmcg
dG8gYSBjbGVhciByZXZlcnQuIFNvLCBmaW5kIHRoZQo+IHJlYWwgY29tbWl0IHRoYXQgaGFkIGJy
b3VnaHQgdGhhdCBpbnRvIHRoZSBrZXJuZWwuCgpZb3UgYXJlIGNvcnJlY3QsIEkganVzdCBkaWQg
c29tZSBnaXQgYmxhbWUgb24gdGhlIGxhdGVzdCB2ZXJzaW9uIGJ1dCAKZm9yZ290IGFib3V0IHRo
ZSBjb21taXQgYmxhbWVkIHdhcyBhIHJldmVydCBjb21taXQuCkEgdjIgdmVyc2lvbiBvZiB0aGlz
IHBhdGNoIHdpbGwgYmUgc2VudCBsYXRlciB0byBmaXggdGhpcyBpc3N1ZS4KVGhhbmsgeW91IGZv
ciBwb2ludGluZyBvdXQgbXkgbWlzdGFrZS4KClJlZ2FyZHMsClpoaXBlbmcKCj4gCj4gLS0gCj4g
V2l0aCBCZXN0IFJlZ2FyZHMsCj4gQW5keSBTaGV2Y2hlbmtvCg==

