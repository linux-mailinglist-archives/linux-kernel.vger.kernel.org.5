Return-Path: <linux-kernel+bounces-159940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1D58B368A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75681F232CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCCA145335;
	Fri, 26 Apr 2024 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HlTQDeFQ"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0F13F01A;
	Fri, 26 Apr 2024 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131208; cv=none; b=FW3DiN0pwDSSIU59a3zgKweUmohCytMuxVI4LlRBnwRYTm+lnnAcnK9pQuZw2yit+iOMtvA7aO5qAVsaBpqDknuvbMPHmeR2A5jHU9RwB3TFAaVCtjRXlmPFrXiPVkW2babcVw0rSbvjIgJUfJFEUASz6HIfhDivb1nVEAiBEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131208; c=relaxed/simple;
	bh=sKbcDZpO43ATbiiPXnkKdb90G7Igiurm3Zwcm7P1scY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OeZmMe5+xNWhz0ep1KvVqKMYw5BIwjcKZp2dJbeDa0YZu6KjzQT/QDC6rbuoHoR1W9u5Sf+tXHFVneJRmUPqwbMUKI5Gav/G1ttiSBA2Ml4cODE+MqlB0Zd6x5h9t2OWdOQBnHPxt3vLbx/NxXwPbOHNsnczoKhf9mwY7LwyZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HlTQDeFQ; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714131207; x=1745667207;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sKbcDZpO43ATbiiPXnkKdb90G7Igiurm3Zwcm7P1scY=;
  b=HlTQDeFQ2Onym0s7Ld6OJnixFJt8KvyIUX7bZN46U3vwBY4kSiWtUxdq
   aFYoVUs+LEm987iNTiM8XMZkUcd/8ApyjyWX5lVpHDATfGllF0XEfsIiv
   7wCs7d4wfaYqqN0mJtjila2MDvjgeXOxWv4CzxyQi5saCSOUHMWao9Kt3
   g=;
X-IronPort-AV: E=Sophos;i="6.07,232,1708387200"; 
   d="scan'208";a="290945146"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 11:33:26 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:51432]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.217:2525] with esmtp (Farcaster)
 id e7b84c28-150d-4661-b2a4-d7d05a6498ed; Fri, 26 Apr 2024 11:33:25 +0000 (UTC)
X-Farcaster-Flow-ID: e7b84c28-150d-4661-b2a4-d7d05a6498ed
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 26 Apr 2024 11:33:25 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 26 Apr
 2024 11:33:21 +0000
Message-ID: <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>
Date: Fri, 26 Apr 2024 13:33:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when
 VMGENID updates"
To: Lennart Poettering <mzxreary@0pointer.de>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Babis Chalios <bchalios@amazon.es>,
	"Theodore Ts'o" <tytso@mit.edu>, "Cali, Marco" <xmarcalx@amazon.co.uk>, Arnd
 Bergmann <arnd@arndb.de>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"Christian Brauner" <brauner@kernel.org>, <linux@leemhuis.info>,
	<regressions@lists.linux.dev>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
 <ZieoRxn-On0gD-H2@gardel-login>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <ZieoRxn-On0gD-H2@gardel-login>
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDIzLjA0LjI0IDE0OjIzLCBMZW5uYXJ0IFBvZXR0ZXJpbmcgd3JvdGU6Cj4gT24gRGksIDIz
LjA0LjI0IDAzOjIxLCBKYXNvbiBBLiBEb25lbmZlbGQgKEphc29uQHp4MmM0LmNvbSkgd3JvdGU6
Cj4KPiBKYXNvbiEKPgo+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4gdG8gbWUgd2hhdCB0aGUgcHJl
Y2lzZSBwcm9ibGVtIGlzIHdpdGggdGhlCj4gdWV2ZW50PyBJdCBkb2Vzbid0IGxlYWsgYW55IGlu
Zm9ybWF0aW9uIGFib3V0IHRoZSBhY3R1YWwgdm1nZW5pZCwgaXQKPiBqdXN0IGxldHMgdXNlcnNw
YWNlIGtub3cgdGhhdCB0aGUgbWFjaGluZSB3YXMgY2xvbmVkLAo+IGJhc2ljYWxseS4gV2hhdCdz
IHRoZSBwcm9ibGVtIHdpdGggdGhhdD8gSSdkIHJlYWxseSBsaWtlIHRvCj4gdW5kZXJzdGFuZD8K
Pgo+IFRoZXJlIGFyZSBtYW55IHVzZWNhc2VzIGZvciB0aGlzIGluIHRoZSBWTSB3b3JsZCwgZm9y
IGV4YW1wbGUgd2UnZAo+IGxpa2UgdG8gaG9vayB0aGluZ3MgdXAgc28gdGhhdCB2YXJpb3VzIHVz
ZXJzcGFjZSBtYW5hZ2VkIGNvbmNlcHRzLAo+IHN1Y2ggYXMgREhDUCBsZWFzZXMsIE1BQyBhZGRy
ZXNzZXMgYXJlIGF1dG9tYXRpY2FsbHkgcmVmcmVzaGVkLgo+Cj4gVGhpcyBoYXMgbm8gcmVsYXRp
b25zaGlwIHRvIFJOR3Mgb3IgYW55dGhpbmcgbGlrZSB0aGlzLCBpdCdzIGp1c3QgYW4KPiBldmVu
dCB3ZSBjYW4gaGFuZGxlIGluIHVzZXJzcGFjZSB0byB0cmlnZ2VyIGFkZHJlc3MgcmVmcmVzaGVz
IGxpa2UKPiB0aGlzLgo+Cj4gSGVuY2UsIHdoeSBpcyB0aGUgcmV2ZXJ0IG5lY2Vzc2FyeT8gVGhp
cyB3YXMgYWxyZWFkeSBpbiBhIHJlbGVhc2VkCj4ga2VybmVsLCBhbmQgd2UgaGF2ZSBzdGFydGVk
IHdvcmsgb24gbWFraW5nIHVzZSBvZiB0aGlzIGluIHN5c3RlbWQsIGFuZAo+IGFmYWljcyB0aGlz
IGRvZXMgbm90IGNvbXByb21pc2UgdGhlIGtlcm5lbCBSTkcgaW4gZXZlbiB0aGUgcmVtb3Rlc3Qg
b2YKPiB3YXlzLCBoZW5jZSB3aHkgaXMgYSByZXZlcnQgbmVjZXNzYXJ5PyBGcm9tIG15IHVzZXJz
YWNlIHBlcnNwZWN0aXZlCj4gaXQncyBqdXN0IHZlcnkgdmVyeSBzYWQsIHRoYXQgdGhpcyBzaW1w
bGUsIHRyaXZpYWwgaW50ZXJmYWNlIHdlIHdhbnRlZAo+IHRvIHVzZSwgdGhhdCB3YXMgaW4gYSBz
dGFibGUga2VybmVsIGlzIG5vdyBnb25lIGFnYWluLgo+Cj4gQ2FuIHlvdSBleHBsYWluIHdoYXQg
dGhlIHByb2JsZW0gd2l0aCB0aGlzIHNpbmdsZS1saW5lIHRyaXZpYWwKPiBpbnRlcmZhY2UgaXM/
IEkgcmVhbGx5IHdvdWxkIGxpa2UgdG8gdW5kZXJzdGFuZCEKCgpKYXNvbiwgcGluZz8KCklmIEkg
ZG9uJ3Qgc2VlIHRlY2huaWNhbCByZWFzb25pbmcgZnJvbSB5b3UgaGVyZSwgSSB3aWxsIGFzc3Vt
ZSB0aGF0IHlvdSAKYWdyZWUgd2l0aCBMZW5uYXJ0IGFuZCBteSBwb2ludHMgb2Ygdmlld3MgYW5k
IHNlbmQgYSByZXZlcnQgb2YgeW91ciAKcmV2ZXJ0IHNob3J0bHkgdG8gZW5zdXJlIHN5c3RlbWQg
aGFzIGl0cyB1ZXZlbnQgc3RpbGwgaW4gNi45LgoKCkFsZXgKCgoKCkFtYXpvbiBEZXZlbG9wbWVu
dCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFl
ZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJh
Z2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6
OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==


