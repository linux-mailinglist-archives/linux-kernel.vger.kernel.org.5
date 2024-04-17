Return-Path: <linux-kernel+bounces-148154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0A8A7E65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC4C281855
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE45126F38;
	Wed, 17 Apr 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="v1MAYQBG"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA0F7E799;
	Wed, 17 Apr 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342946; cv=none; b=UgrJxyXS3v09WaDQw/XXX73PulGpRiiGJxnVgDMp5p8w4DpeoDTXJXfoS7SzKwatCcpfAprvyTfqcaqEVZdJZlKU/wRgVHkhq+Fl1Unifn26VYzNFr9LwAOPWDi1IF5cv5ibvj+XfNAJbRo3P7xaowmUyHbBchjhd9iWMAq6b+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342946; c=relaxed/simple;
	bh=17OBlsmVxnMXJBquq78bQRB1wlvVeTZA49R24BCyT2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lDoP7iSpNvlmjiw0EevhPmGNARR82wuNAc42qiH9ghmlbwvaOKOQdiXrKdIlmq9/1rqXlI/YomnjyvoyndZ5LmBckdLzGGaLgcCRu8x/uuW1IF5jg8ZwjareroWSNV1Nwq1tbTHR0sLirLnWbFbb6NqDJfk9X4m7V1Yvl2S/qpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=v1MAYQBG; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1713342945; x=1744878945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=17OBlsmVxnMXJBquq78bQRB1wlvVeTZA49R24BCyT2M=;
  b=v1MAYQBGAoRJVNxzy0uJ6cwoOugG8Kkq8qrZqLq0mp2cQ4fun8IlQYqy
   63E5r1gc70cNjm1KeWGzFD/zhf4bD2Jd2ltRNj5HVSvO7a6RXZ2HZga0V
   x/ssMNQ9fytc67z5Rbxi94uUXFBk1DOy544KNb5qc9jFPNBY2OApiNp4n
   4=;
X-IronPort-AV: E=Sophos;i="6.07,208,1708387200"; 
   d="scan'208";a="199145512"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 08:35:42 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:5397]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.158:2525] with esmtp (Farcaster)
 id 1676a3ad-f3c1-4105-85bf-4096eab9f7d9; Wed, 17 Apr 2024 08:35:40 +0000 (UTC)
X-Farcaster-Flow-ID: 1676a3ad-f3c1-4105-85bf-4096eab9f7d9
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:35:35 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 17 Apr
 2024 08:35:32 +0000
Message-ID: <10d41e7e-87b1-4036-a740-da36270a4325@amazon.de>
Date: Wed, 17 Apr 2024 10:35:29 +0200
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
From: Alexander Graf <graf@amazon.de>
In-Reply-To: <20240417081212.99657-2-bchalios@amazon.es>
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDE3LjA0LjI0IDEwOjEyLCBCYWJpcyBDaGFsaW9zIHdyb3RlOgo+IEZyb206IFN1ZGFuIExh
bmRnZSA8c3VkYW5sQGFtYXpvbi5jb20+Cj4KPiBSZWFycmFnZSB0aGUgZnVuY3Rpb25zIG9mIHZt
Z2VuaWQgdG8gbWFrZSB0aGUgbmV4dCBjb21taXQsCj4gd2hpY2ggcmUtaW1wbGVtZW50cyB2bWdl
bmlkIGFzIGEgcGxhdGZvcm0gZHJpdmVyLCBlYXNpZXIgdG8gcmV2aWV3Lgo+Cj4gU2lnbmVkLW9m
Zi1ieTogU3VkYW4gTGFuZGdlIDxzdWRhbmxAYW1hem9uLmNvbT4KCgpZb3UgY2FuJ3Qgc2lnbiBv
ZmYgb24gYmVoYWxmIG9mIHNvbWVvbmUgZWxzZS4gVGhlIFNvQiBoZXJlIG5lZWRzIHRvIGJlIAp5
b3Vycy4gSWYgeW91IGFyZSB0YWtpbmcgb3ZlciB0aGlzIGNvZGUgZnJvbSBTdWRhbiwgSSdkIHN1
Z2dlc3QgdG8gdGFrZSAKb3ZlciBmdWxsIG93bmVyc2hpcCBvZiBpdCBhbmQgcHV0IHlvdXIgb3du
IG5hbWUgYXMgYXV0aG9yIGFuZCBTb0IgaW4gYWxsIApwYXRjaGVzLgoKCkFsZXgKCgoKCgpBbWF6
b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBC
ZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBX
ZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIg
MTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


