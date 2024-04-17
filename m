Return-Path: <linux-kernel+bounces-148210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429B38A7F59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3C52832B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B612DD8C;
	Wed, 17 Apr 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="eeJ+Rzqv"
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2757898;
	Wed, 17 Apr 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345182; cv=none; b=k7D1QUJQGtnmHBXBNoH8Tn+NSfEt0bzCGMIfMQ6inmaxc2dhuwDceMTYd0z+N6aPR7scdegWRaE0EQr8hf/G8n94qkxi8L7hhQgklwIIXk/K1LQlVQgljV4bWD+NDwTjby12TJs6faFSdOAUETvCjMVCjFaGv6LmZFkVynL5WOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345182; c=relaxed/simple;
	bh=9ZnFyt9EnaFn4kkSCLK7jpsiIIqRXRrmN39V9djcWKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DKBzxXMiEziowyITcsljcvjngzPNf6bEzWxgH7xm8qFv0WtYPweo0nd0I77nfK+NXGgQHS7zOgr1jdWXJkYSP4tYP5B6nNZvqEh/n2oyy3EHgmAA6BhU+5md0gEnTY/SUX2BTvB76XDiHvxDohr6z8IMdVII3TkI41R8Y2cBO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=eeJ+Rzqv; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1713345181; x=1744881181;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9ZnFyt9EnaFn4kkSCLK7jpsiIIqRXRrmN39V9djcWKY=;
  b=eeJ+RzqvQzt9P4nHC81stHiXqi/tht/MWRnSUKjSZvaT0G5zRcSaXANR
   BG1Bi5BdPPlkf2ZB3fBp2vrGV20/C35qd8IX0Iu27jEo+T7OLKE71TW7y
   l/dATiGPugEYT5WkXxX1MeZthVWR1iqgJbJFdJY5qmJw4+qWXIY237zsk
   w=;
X-IronPort-AV: E=Sophos;i="6.07,208,1708387200"; 
   d="scan'208";a="339290797"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:12:52 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:24771]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.40:2525] with esmtp (Farcaster)
 id ca7a4c02-a734-4bba-bd1a-9e90b51c919c; Wed, 17 Apr 2024 09:12:50 +0000 (UTC)
X-Farcaster-Flow-ID: ca7a4c02-a734-4bba-bd1a-9e90b51c919c
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 09:12:50 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 17 Apr
 2024 09:12:47 +0000
Message-ID: <5351cd46-7228-48d8-b1a2-8ab91dce24f7@amazon.de>
Date: Wed, 17 Apr 2024 11:12:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] virt: vmgenid: rearrange code to make review
 easier
Content-Language: en-US
To: Babis Chalios <bchalios@amazon.es>, <tytso@mit.edu>, <Jason@zx2c4.com>,
	<olivia@selenic.com>, <herbert@gondor.apana.org.au>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>
References: <20240417081212.99657-1-bchalios@amazon.es>
 <20240417081212.99657-2-bchalios@amazon.es>
 <10d41e7e-87b1-4036-a740-da36270a4325@amazon.de>
 <2838b126-ad87-4642-9223-e24f3fdb2c63@amazon.es>
From: Alexander Graf <graf@amazon.de>
In-Reply-To: <2838b126-ad87-4642-9223-e24f3fdb2c63@amazon.es>
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDE3LjA0LjI0IDExOjA1LCBCYWJpcyBDaGFsaW9zIHdyb3RlOgo+Cj4KPiBPbiAxNy80LzI0
IDEwOjM1LCBBbGV4YW5kZXIgR3JhZiB3cm90ZToKPj4KPj4gT24gMTcuMDQuMjQgMTA6MTIsIEJh
YmlzIENoYWxpb3Mgd3JvdGU6Cj4+PiBGcm9tOiBTdWRhbiBMYW5kZ2UgPHN1ZGFubEBhbWF6b24u
Y29tPgo+Pj4KPj4+IFJlYXJyYWdlIHRoZSBmdW5jdGlvbnMgb2Ygdm1nZW5pZCB0byBtYWtlIHRo
ZSBuZXh0IGNvbW1pdCwKPj4+IHdoaWNoIHJlLWltcGxlbWVudHMgdm1nZW5pZCBhcyBhIHBsYXRm
b3JtIGRyaXZlciwgZWFzaWVyIHRvIHJldmlldy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBTdWRh
biBMYW5kZ2UgPHN1ZGFubEBhbWF6b24uY29tPgo+Pgo+Pgo+PiBZb3UgY2FuJ3Qgc2lnbiBvZmYg
b24gYmVoYWxmIG9mIHNvbWVvbmUgZWxzZS4gVGhlIFNvQiBoZXJlIG5lZWRzIHRvIAo+PiBiZSB5
b3Vycy4gSWYgeW91IGFyZSB0YWtpbmcgb3ZlciB0aGlzIGNvZGUgZnJvbSBTdWRhbiwgSSdkIHN1
Z2dlc3QgdG8gCj4+IHRha2Ugb3ZlciBmdWxsIG93bmVyc2hpcCBvZiBpdCBhbmQgcHV0IHlvdXIg
b3duIG5hbWUgYXMgYXV0aG9yIGFuZCAKPj4gU29CIGluIGFsbCBwYXRjaGVzLgo+Pgo+Cj4gSSB0
aG91Z2h0IGFib3V0IGl0IGFuZCBpdCBzZWVtZWQgd2VpcmQgdG8gbWUgdGhhdCBJIHRha2Ugb3Zl
ciBTb0IgYW5kIAo+IGF1dGhvcnNoaXAgc2luY2UgSSBvbmx5IHRvdWNoZWQgb25lIGxpbmUgaW4g
b25lIG9mCj4gdGhlIHBhdGNoZXMsIGJ1dCBJIHdpbGwgYmUgdGFraW5nIG92ZXIgdGhlIHBhdGNo
ZXMsIHNvIEkgY2FuIGRvIHRoYXQgCj4gaWYgdGhhdCdzIHRoZSB3YXkgd2UgdGhpbmdzIGFyZSBk
b25lLgo+Cj4gRG9lcyBpdCBtYWtlIHNlbnNlIHRvIGF0IGxlYXN0IGFkZCAiQ28tYXV0aG9yZWQt
YnkgU3VkYW4gTGFuZGdlIAo+IDxzdWRhbmxAYW1hem9uLmNvbT4iIGhlcmU/CgoKWW91IGNhbiBj
ZXJ0YWlubHkgZG8gdGhhdCwgeWVzLgoKCkFsZXgKCgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2Vu
dGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1
ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBh
bSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVy
bGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


