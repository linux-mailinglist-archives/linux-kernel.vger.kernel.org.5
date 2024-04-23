Return-Path: <linux-kernel+bounces-154582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0388ADDE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF291C215B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F4029429;
	Tue, 23 Apr 2024 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LpukcurI"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7501CA80;
	Tue, 23 Apr 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713855374; cv=none; b=WQ4EtFnSz/QSGmcZ3OF7scKi92seHUZV7t/6E7phAyeVgLkFuPkPVCKins3e13gPkJPssE3asJNdAbjH7qFEvSlLFW1TNyAdB14KxUeHkA9AfghkcDub4J1KZWl8l6ZIWzerI8SgFUvfgX6dIDvItmGc0or3c/7Yt6dRTyAF+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713855374; c=relaxed/simple;
	bh=msVKNZSZ3SCjlXs5INzdTEgIQ+MbVTJl66c0+wIwGsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XLE2DDgG61MGn/8NL37a8gadoeZz+qMQZ0U7Ci6SmPtKZY3D/ig72+KvZhUn3/WxUsW9VWiUIk1/bjoF+HTZ2bKI/Fa2b7c8NWZ2yvzdhPpIGe95G9+Eo3SY+6hKwPLevTyaoxbBnAs+18sa9YLckNHBKlX579LG6PAcvsg84DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LpukcurI; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713855373; x=1745391373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=msVKNZSZ3SCjlXs5INzdTEgIQ+MbVTJl66c0+wIwGsM=;
  b=LpukcurIu6ijpZWid6FTXDtbxH2VrLrdid0lYkZm10acIfg5fvHTCMkc
   BIyVWZYNkdIMTJ1bqd3kakLfaqmvHVoY45Eq7llQriYoJodxW/Wfh+skg
   M9/Mn1u4MSe3KsIbtAZmgayvsi/+d+DdFTY+rZ9ruD/zOsQXrFRo/TB6E
   o=;
X-IronPort-AV: E=Sophos;i="6.07,222,1708387200"; 
   d="scan'208";a="396670875"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:56:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:62617]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.166:2525] with esmtp (Farcaster)
 id aee83917-a4f4-44f3-8672-33801ff084cd; Tue, 23 Apr 2024 06:56:09 +0000 (UTC)
X-Farcaster-Flow-ID: aee83917-a4f4-44f3-8672-33801ff084cd
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 23 Apr 2024 06:56:08 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 23 Apr
 2024 06:56:05 +0000
Message-ID: <bccdbe9d-c30f-4e52-b4a6-886ac06472f9@amazon.com>
Date: Tue, 23 Apr 2024 08:56:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when
 VMGENID updates"
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Lennart Poettering <mzxreary@0pointer.de>,
	Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>, "Cali,
 Marco" <xmarcalx@amazon.co.uk>, Arnd Bergmann <arnd@arndb.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, Christian Brauner
	<brauner@kernel.org>, <linux@leemhuis.info>, <regressions@lists.linux.dev>,
	"Woodhouse, David" <dwmw@amazon.co.uk>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGV5IEphc29uLAoKT24gMjMuMDQuMjQgMDM6MjEsIEphc29uIEEuIERvbmVuZmVsZCB3cm90ZToK
PiBIaSBBbGV4YW5kZXIsCj4KPiBUaGUgcHJvY2VzcyBoZXJlIHNlZW1zIHdlaXJkbHkgYWdncmVz
c2l2ZSBhbmQgc25lYWt5Lgo+Cj4gT24gMjAyMy0wNi0xOSwgSSB3cm90ZSB0aGF0IEkgZGlkbid0
IHdhbnQgdG8gdGFrZSB0aGlzIHJvdXRlIGZvcgo+IHVzZXJzcGFjZSBub3RpZmljYXRpb25zLgo+
Cj4gVGhlbiBvbiAyMDIzLTA2LTI4LCB5b3Ugd3JvdGUgdG8gR3JlZyBhc2tpbmcgaGltIHRvIHRh
a2UgaXQgaW5zdGVhZCBvZgo+IG1lLiBOaW5lIG1pbnV0ZXMgbGF0ZXIsIEdyZWcgc2FpZCAieWVh
IHN1cmUuIiBUaGVuIGhlIGNhdWdodCB1cCBvbiB0aGUKPiB0aHJlYWQgYW5kIHNvbWUgaG91cnMg
bGF0ZXIgd3JvdGU6Cj4KPj4gV2FpdCwgbm8sIEknbSBub3QgdGhlIG1haW50YWluZXIgb2YgdGhp
cywgSmFzb24gaXMuICBBbmQgaGUgYWxyZWFkeQo+PiByZWplY3RlZCBpdCAoYW5kIGJhc2VkIG9u
IHRoZSBjaGFuZ2Vsb2cgdGV4dCwgSSB3b3VsZCB0b28pLCBzbyB3aHkgYXJlCj4+IHlvdSBhc2tp
bmcgbWUgYSBtb250aCBsYXRlciB0byB0YWtlIHRoaXM/Cj4+Cj4+IFdvcmsgd2l0aCB0aGUgbWFp
bnRhaW5lciBwbGVhc2UsIGRvbid0IHRyeSB0byByb3V0ZSBhcm91bmQgdGhlbSwgeW91Cj4+IGJv
dGgga25vdyBiZXR0ZXIgdGhhbiB0aGlzLgo+IFRoZW4gb24gMjAyMy0xMS0xNCB5b3Ugd3JvdGUg
dG8gbWUgYWdhaW4gYXNraW5nIG1lIHRvIHRha2UgaXQsIGRlc3BpdGUKPiBteSBlYXJsaWVyIHJl
c2VydmF0aW9ucyBub3QgY2hhbmdpbmcgaW4gdGhlIGludGVyaW0uIEkgZGlkbid0IGhhdmUgYQo+
IGNoYW5jZSB0byByZXBseS4KPgo+IFRoZW4gb24gMjAyMy0xMS0zMCwgR3JlZyB3ZWlyZGx5IHRv
b2sgaXQgYW55d2F5LCB3aXRoIHplcm8gZGlzY3Vzc2lvbgo+IG9yIGV2aWRlbmNlIG9uIHRoZSBt
YWlsaW5nIGxpc3QgYXMgdG8gd2hhdCBoYWQgaGFwcGVuZWQuCj4KPiBXaGVuIEkgbm90aWNlZCB3
aGF0IGhhZCBoYXBwZW5lZCAod2hpbGUgd29ya2luZyBvbiBoaXMgZHJpdmVyIGluIHRoZQo+IHBy
b2Nlc3Mgb2YgY2xlYW5pbmcgdXAvcmV3b3JraW5nIHBhdGNoZXMgdGhhdCB5b3VyIEFtYXpvbiBl
bXBsb3llZXMKPiBzZW50IG1lIHRoYXQgbmVlZGVkIHdvcmspLCBzdXNwaWNpb3VzIHRoYXQgeW91
IHRyaWVkIHRvICJyb3V0ZSBhcm91bmQiCj4gdGhlIHByb3BlciB3YXkgb2YgZ2V0dGluZyB0aGlz
IGRvbmUgYW5kIHRyaWNrIEdyZWcgYWdhaW4gaW50byB0YWtpbmcgYQo+IHBhdGNoIHRoYXQncyBu
b3QgaGlzIHB1cnZpZXcsIEkgYXNrZWQgaGltIHd0ZiBoYXBwZW5lZCBvbiBJUkM6Cj4KPiA8Z3Jl
Z2toPiB1Z2gsIHNvcnJ5LCBJIGRvbid0IHJlbWVtYmVyIHRoYXQuICBJIHRoaW5rIEFsZXhhbmRl
ciB0YWxrZWQKPiB0byBtZSBhdCBwbHVtYmVycyBhbmQgc2FpZCwgImhleSwgcGxlYXNlIHRha2Ug
dGhpcyB2aXJ0IHBhdGNoIgo+IDxncmVna2g+IGJ1dCB5b3UgYXJlIHJpZ2h0LCB5b3UgTkFLZWQg
aXQgaW4gdGhhdCB0aHJlYWQsIEkgZm9yZ290Cj4gdGhhdCwgc29ycnkuICBZZXMsIHJldmVydCBp
dCBpZiB0aGF0J3MgbmVlZGVkLgo+Cj4gR3JlZyB0aGVuIEFDSydkIHRoZSByZXZlcnQgY29tbWl0
IHdoaWNoIGNhbWUgd2l0aCBhIHN0YWJsZUAgbWFya2luZwo+IGFuZCBhIEZpeGVzOiB0YWcgKGZv
ciA2LjgsIHdoaWNoIGlzbid0IHZlcnkgb2xkKS4KPgo+IFNvIGl0IGxvb2tzIHRvIG1lIGxpa2Ug
eW91IHR3aWNlIHRyaWVkIHRvIHRyaWNrIEdyZWcgaW50byB0YWtpbmcgdGhpcywKPiBzdWNjZWVk
ZWQgdGhlIHNlY29uZCB0aW1lLCBnb3QgY2F1Z2h0LCBhbmQgbm93IGFyZSB0cnlpbmcgdG8gbWFr
ZSBhCj4gcmVncmVzc2lvbiBhcmd1bWVudCBhcyBhIG1lYW5zIG9mIGtlZXBpbmcgeW91ciBzbmVh
a3kgY29tbWl0IGluIHRoZXJlLgo+IEFsbCBvZiB0aGlzIHJlYWxseSBfcmVhbGx5XyBydWJzIG1l
IHRoZSB3cm9uZyB3YXksIEkgaGF2ZSB0byBzYXkuCj4KPiBJIGRvbid0IGtub3cgd2hhdCBob2xk
cyBtb3JlIHdlaWdodCBoZXJlIC0tIHRoZSBwcmVkaWN0YWJsZSByZWdyZXNzaW9uCj4gYXJndW1l
bnQsIG9yIHRoZSBmYWN0IHRoYXQgeW91IHNudWNrIG5hY2snZCBjaGFuZ2VzIGludG8gYSB2ZXJ5
IHZlcnkKPiByZWNlbnQga2VybmVsIHRoYXQgY2FuIHN0aWxsIGJlIHJlbW92ZWQgd2hpbGUgcHJv
YmFibHkgb25seSBhZmZlY3RpbmcKPiB5b3UuIEJ1dCBJJ20gb2J2aW91c2x5IG5vdCBoYXBweSBh
Ym91dCB0aGlzLgoKCkknbSBwZXJzb25hbGx5IG11Y2ggbW9yZSBjb25jZXJuZWQgYWJvdXQgTGlu
dXgnIGFiaWxpdHkgdG8gZGVhbCB3aXRoIFZNIApDbG9uZSBldmVudHMgdGhhbiAibXkgcGVyc29u
YWwgdXNlIGNhc2UiLiBUaGUgZ3JvdXAgYXQgQW1hem9uIHlvdSBzZWUgCndvcmtpbmcgb24gdGhp
cyBpcyB3b3JraW5nIG9uIEFXUyBMYW1iZGEgd2hpY2ggb3ducyB0aGUgZnVsbCBob3N0IGFuZCAK
Z3Vlc3Qgc3RhY2ssIGluY2x1ZGluZyBMaW51eCBvbiBib3RoIGVuZHMuIFRoZXkgY291bGQgaGFw
cGlseSBwYXRjaCAKdGhlaXIgb3duIExpbnV4IGtlcm5lbC4gSW5zdGVhZCwgSSBoYXZlIG1hbmFn
ZWQgdG8gZ2V0IHRoZW0gdG8gZG8gInRoZSAKcmlnaHQgdGhpbmciIGFuZCB3b3JrIHdpdGggdGhl
IExpbnV4IHVwc3RyZWFtIGNvbW11bml0eSB0byBidWlsZCBhIAp2aWFibGUgc29sdXRpb24gdGhh
dCB3b3JrcyBmb3IgZXZlcnlvbmUuCgpIb3dldmVyLCBldmVyeSB0aW1lIHRoZXkgZG8gdGhhdCwg
YWxsIHRoZXkgZ2V0IGJhY2sgaXMgdmdldHJhbmRvbSgpIAphcmd1bWVudHMgd2hpY2ggYXJlIGNv
bXBsZXRlbHkgaXJyZWxldmFudCB0byB0aGUgY29udmVyc2F0aW9uIGFuZCAKZGV0ZXJpb3JhdGUg
bXkgZWZmb3J0cyB0byBnZXQgQVdTIHRvIHdvcmsgKm1vcmUqIHJhdGhlciB0aGFuIGxlc3MgCnVw
c3RyZWFtLiBDYW4gd2UgcGxlYXNlIG1vdmUgdGhpcyBiYWNrIHRvIGEgdGVjaG5pY2FsIGRpc2N1
c3Npb24gYW5kIApiYXNlZCBvbiB0ZWNobmljYWwgZ3JvdW5kcyBkZXRlcm1pbmUgd2h5IHNlbmRp
bmcgYSBub3RpZmljYXRpb24gdG8gdXNlciAKc3BhY2Ugd2hlbiBhIFZNIHdhcyBjbG9uZWQgdmlh
IHVldmVudHMgaXMgZXZlbiByZW1vdGVseSBhIGJhZCBpZGVhPwoKClRoYW5rcywKCkFsZXgKCgoK
CkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEw
MTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0
aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVy
IEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==


