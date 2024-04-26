Return-Path: <linux-kernel+bounces-160656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80D8B40AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02CD1C2098A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2406F2231F;
	Fri, 26 Apr 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T5xq9Y2a"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78822EE8;
	Fri, 26 Apr 2024 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161915; cv=none; b=SOTZ8UzpMqXBX/ihy+NJ18uR41Sg2ifFca97Qd+I8N2tx6MKlT1S/1JLUZV9SM+32Fm5sLE4MZCSuLOZIwV8N2DoV7kkRHDOr3HOWYpJ0sHjAs1sEPxvPf4OcUUSaVbb66kiq0DKVWAPrDILczSOEBWrKaDjNSsAm2Uxceu7r7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161915; c=relaxed/simple;
	bh=cLXIZG7H2f76asWB0E2xX4lGy2A4IEnjWRRZg1b1XLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LK9qDWMkhVZ/YHgNcGW0vJek2+FBPubIpGAm7Qcquv7+U3R799bmVURxakLghcsbTvjgR6VgAmVIIfbk0FpMbPtNdtWO59jQ8eitwuvawNkcJ/WIsVFEZriU1sHdQm+yr7rgu/Y+SLqfyA3OIfqg7Zo1vWeyCbHjr+/haotmI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=T5xq9Y2a; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714161914; x=1745697914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cLXIZG7H2f76asWB0E2xX4lGy2A4IEnjWRRZg1b1XLM=;
  b=T5xq9Y2a0+ipFCem0CuX7BwrAFfd4w77RY5r8nFCLYvtsNZaxagOH9vv
   LrJcY+3jxi2+p2qZtAXSwOQUWxzUtdf+ojWhMnRyed+VKT6tUuqggImyF
   Z2YqhPtv0h2m4dNs3l/1GJKfN041THSnUJb41KyAL72f0OLYLWfbBIROE
   s=;
X-IronPort-AV: E=Sophos;i="6.07,233,1708387200"; 
   d="scan'208";a="415003464"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 20:05:09 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:59231]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.37:2525] with esmtp (Farcaster)
 id 2ca18f87-bbe7-4b9b-914d-d8262036949a; Fri, 26 Apr 2024 20:05:08 +0000 (UTC)
X-Farcaster-Flow-ID: 2ca18f87-bbe7-4b9b-914d-d8262036949a
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 26 Apr 2024 20:05:08 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 26 Apr
 2024 20:05:04 +0000
Message-ID: <d2566ff4-4203-4d12-a987-2a1cf94a484f@amazon.com>
Date: Fri, 26 Apr 2024 22:05:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when
 VMGENID updates"
To: Babis Chalios <bchalios@amazon.es>, "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: Lennart Poettering <mzxreary@0pointer.de>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Theodore Ts'o
	<tytso@mit.edu>, "Cali, Marco" <xmarcalx@amazon.co.uk>, Arnd Bergmann
	<arnd@arndb.de>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "Christian
 Brauner" <brauner@kernel.org>, <linux@leemhuis.info>,
	<regressions@lists.linux.dev>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
 <ZieoRxn-On0gD-H2@gardel-login>
 <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>
 <Ziujox51oPzZmwzA@zx2c4.com> <1f09319c-56e6-44d7-9175-c6307089447b@amazon.es>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <1f09319c-56e6-44d7-9175-c6307089447b@amazon.es>
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDI2LjA0LjI0IDE1OjQzLCBCYWJpcyBDaGFsaW9zIHdyb3RlOgo+IEhpIEphc29uLAo+Cj4g
T24gNC8yNi8yNCAxNDo1MiwgSmFzb24gQS4gRG9uZW5mZWxkIHdyb3RlOgo+PiBJIGRvbid0IHRo
aW5rIGFkZGluZyBVQVBJIHRvIGFuIGluZGl2aWR1YWwgZGV2aWNlIGRyaXZlciBsaWtlIHRoaXMg
aXMgYQo+PiBnb29kIGFwcHJvYWNoIGVzcGVjaWFsbHkgY29uc2lkZXJpbmcgdGhhdCB0aGUgdmly
dGlvIGNoYW5nZXMgd2UKPj4gZGlzY3Vzc2VkIHNvbWUgdGltZSBhZ28gd2lsbCBsaWtlbHkgYXVn
bWVudCB0aGlzIGFuZCBjcmVhdGUgYW5vdGhlcgo+PiBtZWFucyBvZiBhIHNpbWlsYXIgbm90aWZp
Y2F0aW9uLiBBbmQgZ2l2ZW4gdGhhdCB0aGlzIGludGVyc2VjdHMgd2l0aAo+PiBvdGhlciB1c2Vy
c3BhY2Utb3JpZW50ZWQgd29yayBJIGhvcGUgdG8gZ2V0IGJhY2sgdG8gcHJldHR5IHNvb24sIEkg
dGhpbmsKPj4gaW50cm9kdWNpbmcgc29tZSBhZGhvYyBtZWNoYW5pc20gbGlrZSB0aGlzIGFkZHMg
Y2x1dHRlciBhbmQgaXNuJ3QgdGhlCj4+IGlkZWFsIHdheSBmb3J3YXJkLgo+Pgo+Cj4gQ29ycmVj
dCBtZSBpZiBJJ20gd3JvbmcsIGJ1dCB0aGUgdmlydGlvIGNoYW5nZXMgd2VyZSBtZWFudCB0byBt
ZWFuIAo+ICJwbGVhc2UKPiByZXNlZWQgeW91ciBQUk5HcyIuIFRoYXQncyB3aHkgd2Ugd2FudGVk
IHRvIHJvdXRlIHRoZW0gdmlhIHJhbmRvbS5jLiBXZQo+IGRlc2lnbmVkIHRoZW0gc3BlY2lmaWNh
bGx5IHNvIHRoYXQgdmlydGlvLXJuZyB3b3VsZCBiZSBvbmx5IG9uZSBvZiB0aGUgCj4gcG90ZW50
aWFsCj4gc3lzdGVtcyB0aGF0IHdvdWxkIGVtaXQgc3VjaCBub3RpZmljYXRpb25zLCB3aGVyZWFz
IG90aGVyIHN5c3RlbXMgCj4gbWlnaHQgaGF2ZQo+IG5vdGhpbmcgdG8gZG8gd2l0aCBWTSBldmVu
dHMuCj4KPiBXaXRoIHRoYXQgaW4gbWluZCwgY291bGQgeW91IGRlc2NyaWJlIGhvdyB0aGVzZSBl
dmVudHMgd291bGQgYmUgdXNlZnVsIAo+IHRvIHRoZQo+IHVzZSBjYXNlIG9mIExlbm5hcnQ/IHN5
c3RlbWQgZG9lcyBub3QgbmVlZCBhIG5vdGlmaWNhdGlvbiBldmVyeSB0aW1lIAo+IHRoZSBzeXN0
ZW0KPiBiZWxpZXZlcyBQUk5HcyBuZWVkIHRvIGJlIHJlc2VlZGVkLiBJdCBleHBsaWNpdGx5IG5l
ZWRzIGEgbm90aWZpY2F0aW9uIAo+IHdoZW4gYSBWTQo+IHdhcyBjbG9uZWQuIFRoaXMgaGFzIG5v
dGhpbmcgdG8gZG8gd2l0aCBQUk5HcyBhbmQgSSBkb24ndCBiZWxpZXZlIAo+IHJhbmRvbS5jLAo+
IHZpcnRpby1ybmcsIG9yIHZnZXRyYW5kKCkgc2hvdWxkIGJlIHJlc3BvbnNpYmxlIGZvciBkZWxp
dmVyaW5nIHRoaXMuCgoKSSBzZWNvbmQgdGhpcy4gQSBWTSBjbG9uZSBldmVudCBtYXkgYmUgb25l
IG9mIG11bHRpcGxlIGV2ZW50cyB0aGF0IGNhbiAKY2F1c2UgYW4gUk5HIHJlc2VlZCBldmVudC4g
VGhpcyBpcyB3aGF0IEJhYmlzJyBwYXRjaGVzIHRvIHByb3BhZ2F0ZSBzdWNoIAphbiBldmVudFsx
XSBpbXBsZW1lbnRlZDogQSBuZXcgdHlwZSBvZiBtdWx0aXBsZXhlZCBldmVudCB0aGF0IGZlZWRz
IGZyb20gCm11bHRpcGxlIHNvdXJjZXM7IG1vc3Qgbm90YWJseSAqbm90KiBmcm9tIFZNR2VuSUQu
CgpEdWUgeW91ciByZWx1Y3RhbmNlIHRvIGVuYWJsZSB1c2VyIHNwYWNlIFBSTkdzIHRvIGdldCBh
bnkgbm90aW9uIG9mIApyZXNlZWQgZXZlbnRzIFsyXSwgd2UgaGF2ZSBzaW5jZSBhYmFuZG9uZWQg
dGhhdCB3aG9sZSBSTkcgcmVzZWVkIGV2ZW50IAphcHByb2FjaDogR29pbmcgZm9yd2FyZCwgZm9y
IG91ciBlbnZpcm9ubWVudHMsIHdlJ2xsIHNpbXBseSBtYW5kYXRlIHRoYXQgClBSTkdzIGFsd2F5
cyBtaXggaW4gcmFuZG9tbmVzcyB0aGF0IGlzIGd1YXJhbnRlZWQgZGlmZmVyZW50IHBvc3QtY2xv
bmUgCihzdWNoIGFzIFJEUkFORCkuIFlvdSB3YW50IGEgY2xvbmUgc2FmZSBzeXN0ZW0/IFVzZSBv
bmUgdGhhdCBkb2VzIChmYXN0IAphbmQgbm9uLWJyb2tlbikgUkRSQU5ELgoKSG93ZXZlciwgVk0g
Y2xvbmUgZXZlbnRzIGFyZSB1c2VmdWwgZm9yIG90aGVyIHNpdHVhdGlvbnMgYXMgYWxsIG9mIHVz
IApvdXRsaW5lZCBtdWx0aXBsZSB0aW1lcyBpbiB0aGlzIGFuZCBwcmV2aW91cyB0aHJlYWRzLiBX
aGlsZSB5b3UgY2FuIHVzZSAKVk0gY2xvbmUgZXZlbnRzIGFzIGEgc291cmNlIGZvciBSTkcgcmVz
ZWVkIGV2ZW50cywgeW91IGNhbiBub3QgdXNlIFJORyAKcmVzZWVkIGV2ZW50cyAob3IgYSBzbmFw
c2hvdCBzYWZlIFJORyBzb3VyY2UgbGlrZSAvZGV2L3JhbmRvbSkgYXMgCmluZGljYXRvciBmb3Ig
Vk0gY2xvbmVzLCBiZWNhdXNlIHRoZXkgd2lsbCB0cmlnZ2VyIG1vcmUgb2Z0ZW4gYW5kIGhlbmNl
IApjYXVzZSB1bmRlc2lyZWQgc2lkZSBlZmZlY3RzLiBZb3UgbWF5IHdhbnQgYSByZXNlZWQgZXZl
cnkgNjBzLCBidXQgCnN1cmVseSBkb24ndCB3YW50IGEgbmV3IE1BQyBhZGRyZXNzIGV2ZXJ5IDYw
IHNlY29uZHMsIHJpZ2h0PyA6KQoKTm93LCB0aGVvcmV0aWNhbGx5IEkgY2FuIHNlZSBzb21lIG1l
cml0IGZvciBhIHNpbmdsZSwgYWJzdHJhY3RlZCBldmVudCAKc291cmNlIGZvciBWTSBjbG9uZXMg
b3ZlciBhIHBlci1kcml2ZXIgb25lLiBCdXQgcHJhY3RpY2FsbHksIGJldHdlZW4gClZNR2VuSUQg
b24gQUNQSSBhbmQgRGV2aWNlIFRyZWUgc3lzdGVtcywgdGhlcmUgYXJlIHZlcnkgZm9yIHBsYXRm
b3JtcyAKdGhhdCBjYXJlIGFib3V0IHNhZmUgVk0gc25hcHNob3RzIGFuZCB3b3VsZG4ndCAianVz
dCB3b3JrIi4gVGhlIG9ubHkgb25lIApJIGNhbiB0aGluayBvZiBhdG0gaXMgczM5MHguIEkgZG9u
J3Qga25vdyBpZiBhbiBhYnN0cmFjdGlvbiAtIGxpa2UgCmFub3RoZXIgZHJpdmVyIHRoYXQgc2lt
cGx5IHByb3hpZXMgbm90aWZpY2F0aW9ucyAtIHdvdWxkIGJlIHdvcnRoIGl0LiBPciAKaWYgaW4g
dGhhdCBjYXNlIHdlJ2QganVzdCBleHBhbmQgdGhlIHZlcnkgc2FtZSB2bWdlbmlkIGRyaXZlciB0
byB0aGF0IApvdGhlciBvbmUtb2ZmIHBsYXRmb3JtIHRoYXQgaGFwcGVucyB0byBydW4gd2l0aG91
dCBEVCBvciBBQ1BJLgoKU28sIG92ZXJhbGwsIEkgc3RpbGwgZG9uJ3Qgc2VlIGFueSBiZXR0ZXIg
cGF0aCBmb3J3YXJkIHRvIGdldCBhICJWTSAKY2xvbmVkIiBldmVudCBpbnRvIHN5c3RlbWQgdGhh
biB0aGUgdWV2ZW50LgoKSmFzb24sIGNvdWxkIHlvdSBwbGVhc2Ugb3V0bGluZSBob3cgeW91ciAi
b3RoZXIgdXNlcnNwYWNlLW9yaWVudGVkIHdvcmsgCnlvdSBob3BlIHRvIGdldCBiYWNrIHRvIHNv
b24iIHdvdWxkIGhlbHAgd2l0aCB0aGUgc3lzdGVtZCB1c2UgY2FzZT8KCgpBbGV4CgpbMV0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDgyMzA5MDEwNy42NTc0OS0xLWJjaGFsaW9z
QGFtYXpvbi5lcy8KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvWlBYc3VoWEpoTjlR
M2hmSEB6eDJjNC5jb20vCgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21i
SApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3Rp
YW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBD
aGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUg
Mjg5IDIzNyA4NzkKCgo=


