Return-Path: <linux-kernel+bounces-152907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1D8AC5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A761F21645
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE254D9E7;
	Mon, 22 Apr 2024 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pcucO8P1"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8A4D11D;
	Mon, 22 Apr 2024 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772311; cv=none; b=nnnQpSUGCt9UlQjmwo1mwtVfvhvip9YL55rzcsv4oV0cJewr3SLEc12F4yGsAWaFykH4OUupeUFoVZrqkHu4IbQDtN86BKMa291hAP9LnSg5ygN+xCv4U5gQDf25ghneLiEQ9Q/Sfbnt2PxM9/4SbXIPE7DVC3NrRZfaBXQ5CF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772311; c=relaxed/simple;
	bh=V+hmni4mAKTQ8wXjeiMX0dljZgO3ua+RXHTJ7o7gkok=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NtDN0cuyNvy/wMr5CiBIT+Z+RnCFzqboVXKxV3K2Vkjhh/toiVz0vrT81NeDzA3+K9FTxePRSTySJ7kZPm/bs8TQ8cy4WL3a48oW818MFC0t9JyG+p3Q9VWAK1ZH998WESgQpQeyGCRld6btZP8aJ5HuN1RrpbjJK3bdzKsluR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pcucO8P1; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713772309; x=1745308309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V+hmni4mAKTQ8wXjeiMX0dljZgO3ua+RXHTJ7o7gkok=;
  b=pcucO8P1XhEBArvhEO6TBkbOiEKbc7Bli5l8Wt2Iyb6d9cxagxY5pqkE
   u9khb4jTE0t1zNfzQDYvO8zby8nCyT3/d3uUW0zHjdN0ZCVN2Cwv6x86J
   scDgMSly2lY+Rhms4ibRKYayqJDxr905HUcOvu4paJjfe4zkPlH8PbOqz
   o=;
X-IronPort-AV: E=Sophos;i="6.07,220,1708387200"; 
   d="scan'208";a="413631555"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 07:51:41 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:8532]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.190:2525] with esmtp (Farcaster)
 id 98f6d520-ff55-44d0-a03c-306ba359ccb1; Mon, 22 Apr 2024 07:51:40 +0000 (UTC)
X-Farcaster-Flow-ID: 98f6d520-ff55-44d0-a03c-306ba359ccb1
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 07:51:36 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 22 Apr
 2024 07:51:33 +0000
Message-ID: <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
Date: Mon, 22 Apr 2024 09:51:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when VMGENID
 updates"
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Lennart Poettering
	<mzxreary@0pointer.de>, Babis Chalios <bchalios@amazon.es>, Theodore Ts'o
	<tytso@mit.edu>, "Cali, Marco" <xmarcalx@amazon.co.uk>, Arnd Bergmann
	<arnd@arndb.de>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "Christian
 Brauner" <brauner@kernel.org>, <linux@leemhuis.info>,
	<regressions@lists.linux.dev>
References: <20240418114814.24601-1-Jason@zx2c4.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240418114814.24601-1-Jason@zx2c4.com>
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

W0FkZGluZyBDQyBsaXN0IG9mIG9yaWdpbmFsIHBhdGNoIHBsdXMgcmVncmVzc2lvbiB0cmFja2Vy
XQoKSGkgSmFzb24sCgpPbiAxOC4wNC4yNCAxMzo0OCwgSmFzb24gQS4gRG9uZW5mZWxkIHdyb3Rl
Ogo+IFRoaXMgcmV2ZXJ0cyBjb21taXQgYWQ2YmNkYWQyYjY3MjRlMTEzZjE5MWExMmY4NTlhOWU4
NDU2YjI2ZC4gSSBoYWQKPiBuYWsnZCBpdCwgYW5kIEdyZWcgc2FpZCBvbiB0aGUgdGhyZWFkIHRo
YXQgaXQgbGlua3MgdGhhdCBoZSB3YXNuJ3QgZ29pbmcKPiB0byB0YWtlIGl0IGVpdGhlciwgZXNw
ZWNpYWxseSBzaW5jZSBpdCdzIG5vdCBoaXMgY29kZSBvciBoaXMgdHJlZSwgYnV0Cj4gdGhlbiwg
c2VlbWluZ2x5IGFjY2lkZW50YWxseSwgaXQgZ290IHB1c2hlZCB1cCBzb21lIG1vbnRocyBsYXRl
ciwgaW4KPiB3aGF0IGxvb2tzIGxpa2UgYSBtaXN0YWtlLCB3aXRoIG5vIGZ1cnRoZXIgZGlzY3Vz
c2lvbiBpbiB0aGUgbGlua2VkCj4gdGhyZWFkLiBTbyByZXZlcnQgaXQsIHNpbmNlIGl0J3MgY2xl
YXJseSBub3QgaW50ZW5kZWQuCgpSZXZlcnRpbmcgdGhpcyBwYXRjaCBjcmVhdGVzIGEgdXNlciBz
cGFjZSB2aXNpYmxlIHJlZ3Jlc3Npb24gY29tcGFyZWQgdG8gCnY2LjguIFBsZWFzZSB0cmVhdCBp
dCBhcyBzdWNoLgoKSSdtIHNsaWdodGx5IGNvbmZ1c2VkIHRvIHNlZSB5b3UgcGFzc2lvbmF0ZSBh
Ym91dCB0aGlzIHBhdGNoIGFmdGVyIHlvdSAKZ2hvc3RlZCB0aGUgY29udmVyc2F0aW9uIHlvdSBy
ZWZlcmVuY2VkOgoKIApodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzAwZDYxNzJmLWUyOTEt
NGU5Ni05ZDNlLTYzZWU4ZTYwZDU1NkBhbWF6b24uY29tLwoKVGhlIHB1cnBvc2Ugb2YgdGhpcyB1
ZXZlbnQgaXMgdG8gbm90aWZ5IHN5c3RlbWRbMV1bMl0gKG9yIHNpbWlsYXIpIHRoYXQgCmEgVk0g
Y2xvbmUgZXZlbnQgaGFwcGVuZWQsIHNvIGl0IGNhbiBmb3IgZXhhbXBsZSByZWdlbmVyYXRlIE1B
QyAKYWRkcmVzc2VzIGlmIGl0IGdlbmVyYXRlZCB0aGVtIG9uIGJvb3QsIHJlZ2VuZXJhdGUgaXRz
IHVuaXF1ZSBtYWNoaW5lIGlkIApvciBzaW1wbHkgZm9yY2UgcmVyZXF1ZXN0IGEgbmV3IERIQ1Ag
bGVhc2UuCgpJIGRvbid0IHVuZGVyc3RhbmQgaG93IHRoZXJlJ3MgYW55IGNvcnJlbGF0aW9uIG9y
IGRlcGVuZGVuY3kgdG8gCnZnZXRyYW5kb20oKSBvciBhbnl0aGluZyBSTkcgaW4gdGhpcyBhbmQg
d2h5IGdldHRpbmcgdmdldHJhbmRvbSgpIG1lcmdlZCAKdXBzdHJlYW0gaXMgZXZlbiBzb21ldGhp
bmcgdG8gdGFsayBhYm91dCBpbiB0aGUgc2FtZSBsaW5lIGFzIHRoaXMgcGF0Y2ggWzNdLgoKV2Ug
aGFkIGEgbGVuZ3RoeSwgY29uc3RydWN0aXZlIGNvbnZlcnNhdGlvbiB3aXRoIFRlZCBhdCBMUEMg
bGFzdCB5ZWFyIAphYm91dCB0aGUgIlBSTkcgYW5kIGNsb25lIiB1c2UgY2FzZSBhbmQgY29uY2x1
ZGVkIHRoYXQgaXQncyBiZXN0IGZvciAKZXZlcnlvbmUgdG8gc2ltcGx5IGFzc3VtZSB0aGUgc3lz
dGVtIGNvdWxkIGJlIGNsb25lZCBhdCBhbnkgcG9pbnQsIGhlbmNlIAphbHdheXMgZm9yY2UgaW50
ZXJtaXggb2YgUkRSQU5EIG9yIGNvbXBhcmFibGUgdG8gYW55IFBSTkcgb3V0cHV0LiBXZSAKc2lu
Y2Ugbm8gbG9uZ2VyIG5lZWQgYW4gZXZlbnQgZm9yIHRoYXQgY2FzZS4KCgpBbGV4CgpbMV0gaHR0
cHM6Ly9naXRodWIuY29tL3N5c3RlbWQvc3lzdGVtZC9pc3N1ZXMvMjYzODAKWzJdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvWkpHTlJFTjR0THpRWE9KckBnYXJkZWwtbG9naW4vClszXSAK
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQUhtTUU5cHhjLW5PX3hhPTQrMUNudmJudWVm
YlJUSkh4TTduODE3Y19UUGVveHp1X2dAbWFpbC5nbWFpbC5jb20vCgojcmVnemJvdCBpbnRyb2R1
Y2VkOiAzYWFkZjEwMGY5M2Q4MDgxCgo+IAo+IEZpeGVzOiBhZDZiY2RhZDJiNjcgKCJ2bWdlbmlk
OiBlbWl0IHVldmVudCB3aGVuIFZNR0VOSUQgdXBkYXRlcyIpCj4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcKPiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNTMxMDk1MTE5LjEx
MjAyLTItYmNoYWxpb3NAYW1hem9uLmVzCj4gU2lnbmVkLW9mZi1ieTogSmFzb24gQS4gRG9uZW5m
ZWxkIDxKYXNvbkB6eDJjNC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZpcnQvdm1nZW5pZC5jIHwg
MiAtLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlydC92bWdlbmlkLmMgYi9kcml2ZXJzL3ZpcnQvdm1nZW5pZC5jCj4gaW5kZXgg
YjY3YTI4ZGE0NzAyLi5hMWM0NjdhMGU5ZjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0L3Zt
Z2VuaWQuYwo+ICsrKyBiL2RyaXZlcnMvdmlydC92bWdlbmlkLmMKPiBAQCAtNjgsNyArNjgsNiBA
QCBzdGF0aWMgaW50IHZtZ2VuaWRfYWRkKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlKQo+ICAg
c3RhdGljIHZvaWQgdm1nZW5pZF9ub3RpZnkoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2UsIHUz
MiBldmVudCkKPiAgIHsKPiAgIAlzdHJ1Y3Qgdm1nZW5pZF9zdGF0ZSAqc3RhdGUgPSBhY3BpX2Ry
aXZlcl9kYXRhKGRldmljZSk7Cj4gLQljaGFyICplbnZwW10gPSB7ICJORVdfVk1HRU5JRD0xIiwg
TlVMTCB9Owo+ICAgCXU4IG9sZF9pZFtWTUdFTklEX1NJWkVdOwo+ICAgCj4gICAJbWVtY3B5KG9s
ZF9pZCwgc3RhdGUtPnRoaXNfaWQsIHNpemVvZihvbGRfaWQpKTsKPiBAQCAtNzYsNyArNzUsNiBA
QCBzdGF0aWMgdm9pZCB2bWdlbmlkX25vdGlmeShzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwg
dTMyIGV2ZW50KQo+ICAgCWlmICghbWVtY21wKG9sZF9pZCwgc3RhdGUtPnRoaXNfaWQsIHNpemVv
ZihvbGRfaWQpKSkKPiAgIAkJcmV0dXJuOwo+ICAgCWFkZF92bWZvcmtfcmFuZG9tbmVzcyhzdGF0
ZS0+dGhpc19pZCwgc2l6ZW9mKHN0YXRlLT50aGlzX2lkKSk7Cj4gLQlrb2JqZWN0X3VldmVudF9l
bnYoJmRldmljZS0+ZGV2LmtvYmosIEtPQkpfQ0hBTkdFLCBlbnZwKTsKPiAgIH0KPiAgIAo+ICAg
c3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCB2bWdlbmlkX2lkc1tdID0gewoKCgoK
QW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAx
MTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRo
YW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIg
SFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK


