Return-Path: <linux-kernel+bounces-66571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D3855E72
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719541F243C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C250265;
	Thu, 15 Feb 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BWc54xww"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEBB4F5F2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990268; cv=none; b=YjtwTXE3dIi9qryOtBPX/VH8fGN7w3TQaqrxzqPJxtEMBhRK3tyVGSJfuDdy2Bw5Iij9YvocIGlMtRGRTcJ2x3ohi/6zwXy4H7oA3Wq++Vm2rTm/WMktMZlrZvVYJuucGzu3FFfrlVFuQoyjTQJ6HDmQZ7wd1nAn5zG8r6AMOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990268; c=relaxed/simple;
	bh=MpAnqmrBzKfhdUol4ez9sNwiJNke4mG+AQYMeOTO+3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NQRmQyANTd7S+mNuve31A4A2CKsBPt0getaa6HQu4j67IJlA/51UtUdvsz4kCe+GqhojPWkbjJfYLXCc9OxlsqoyPjGIulo+qiAjtbrX3JaeGggDWJxuUUBtrr+VCIKXr9HFHGY3S06/4q0xbxHIEFiDv280RM6dVgLneCxTDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BWc54xww; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707990268; x=1739526268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MpAnqmrBzKfhdUol4ez9sNwiJNke4mG+AQYMeOTO+3A=;
  b=BWc54xwws7Pzx1QbGyhA/YOnlTB9msumjGSKKfr1yeMAhq8UxcbhjXEj
   UYhzdFsLcOZ5j20xsUU0bd0aV03VG9GVu7ojgPQ28/f3FWIdGu3O/8Jwq
   6p0TPJjCvfB+GmT+0yj1u43BRZamAgaFcTH8pRNzFL3js1o/av48FWWMU
   k=;
X-IronPort-AV: E=Sophos;i="6.06,161,1705363200"; 
   d="scan'208";a="613229364"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:44:23 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:18611]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.119:2525] with esmtp (Farcaster)
 id 195158db-1473-4e04-93e0-963f8771d726; Thu, 15 Feb 2024 09:44:21 +0000 (UTC)
X-Farcaster-Flow-ID: 195158db-1473-4e04-93e0-963f8771d726
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 09:44:21 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 15 Feb
 2024 09:44:15 +0000
Message-ID: <8a6dabdf-dc11-4989-b6b4-b49871ff9ca6@amazon.com>
Date: Thu, 15 Feb 2024 10:44:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 1/5] swiotlb: Support allocating DMA memory from SWIOTLB
Content-Language: en-US
To: Vishal Annapurve <vannapurve@google.com>, "Kirill A. Shutemov"
	<kirill@shutemov.name>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <pbonzini@redhat.com>,
	<rientjes@google.com>, <seanjc@google.com>, <erdemaktas@google.com>,
	<ackerleytng@google.com>, <jxgao@google.com>, <sagis@google.com>,
	<oupton@google.com>, <peterx@redhat.com>, <vkuznets@redhat.com>,
	<dmatlack@google.com>, <pgonda@google.com>, <michael.roth@amd.com>,
	<thomas.lendacky@amd.com>, <dave.hansen@linux.intel.com>,
	<linux-coco@lists.linux.dev>, <chao.p.peng@linux.intel.com>,
	<isaku.yamahata@gmail.com>, <andrew.jones@linux.dev>, <corbet@lwn.net>,
	<hch@lst.de>, <m.szyprowski@samsung.com>, <rostedt@goodmis.org>,
	<iommu@lists.linux.dev>
References: <20240112055251.36101-1-vannapurve@google.com>
 <20240112055251.36101-2-vannapurve@google.com>
 <etvf2mon464whscbxqktdd7bputnqmmwmoeg7ssixsk4kljfek@4wngbgzbbmck>
 <CAGtprH-95FEUzpc-yxQMo87gpqgMxyz9W8tiWtu_ZHhMW-jjuA@mail.gmail.com>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAGtprH-95FEUzpc-yxQMo87gpqgMxyz9W8tiWtu_ZHhMW-jjuA@mail.gmail.com>
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDE1LjAyLjI0IDA0OjMzLCBWaXNoYWwgQW5uYXB1cnZlIHdyb3RlOgo+IE9uIFdlZCwgRmVi
IDE0LCAyMDI0IGF0IDg6MjDigK9QTSBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbEBzaHV0ZW1v
di5uYW1lPiB3cm90ZToKPj4gT24gRnJpLCBKYW4gMTIsIDIwMjQgYXQgMDU6NTI6NDdBTSArMDAw
MCwgVmlzaGFsIEFubmFwdXJ2ZSB3cm90ZToKPj4+IE1vZGlmeSBTV0lPVExCIGZyYW1ld29yayB0
byBhbGxvY2F0ZSBETUEgbWVtb3J5IGFsd2F5cyBmcm9tIFNXSU9UTEIuCj4+Pgo+Pj4gQ1ZNcyB1
c2UgU1dJT1RMQiBidWZmZXJzIGZvciBib3VuY2luZyBtZW1vcnkgd2hlbiB1c2luZyBkbWFfbWFw
XyogQVBJcwo+Pj4gdG8gc2V0dXAgbWVtb3J5IGZvciBJTyBvcGVyYXRpb25zLiBTV0lPVExCIGJ1
ZmZlcnMgYXJlIG1hcmtlZCBhcyBzaGFyZWQKPj4+IG9uY2UgZHVyaW5nIGVhcmx5IGJvb3QuCj4+
Pgo+Pj4gQnVmZmVycyBhbGxvY2F0ZWQgdXNpbmcgZG1hX2FsbG9jXyogQVBJcyBhcmUgYWxsb2Nh
dGVkIGZyb20ga2VybmVsIG1lbW9yeQo+Pj4gYW5kIHRoZW4gY29udmVydGVkIHRvIHNoYXJlZCBk
dXJpbmcgZWFjaCBBUEkgaW52b2NhdGlvbi4gVGhpcyBwYXRjaCBlbnN1cmVzCj4+PiB0aGF0IHN1
Y2ggYnVmZmVycyBhcmUgYWxzbyBhbGxvY2F0ZWQgZnJvbSBhbHJlYWR5IHNoYXJlZCBTV0lPVExC
Cj4+PiByZWdpb25zLiBUaGlzIGFsbG93cyBlbmZvcmNpbmcgYWxpZ25tZW50IHJlcXVpcmVtZW50
cyBvbiByZWdpb25zIG1hcmtlZAo+Pj4gYXMgc2hhcmVkLgo+PiBCdXQgZG9lcyBpdCB3b3JrIGlu
IHByYWN0aWNlPwo+Pgo+PiBTb21lIGRldmljZXMgKGxpa2UgR1BVcykgcmVxdWlyZSBhIGxvdCBv
ZiBETUEgbWVtb3J5LiBTbyB3aXRoIHRoaXMgYXBwcm9hY2gKPj4gd2Ugd291bGQgbmVlZCB0byBo
YXZlIGh1Z2UgU1dJT1RMQiBidWZmZXIgdGhhdCBpcyB1bnVzZWQgaW4gbW9zdCBWTXMuCj4+Cj4g
Q3VycmVudCBpbXBsZW1lbnRhdGlvbiBsaW1pdHMgdGhlIHNpemUgb2Ygc3RhdGljYWxseSBhbGxv
Y2F0ZWQgU1dJT1RMQgo+IG1lbW9yeSBwb29sIHRvIDFHLiBJIHdhcyBwcm9wb3NpbmcgdG8gZW5h
YmxlIGR5bmFtaWMgU1dJT1RMQiBmb3IgQ1ZNcwo+IGluIGFkZGl0aW9uIHRvIGFsaWduaW5nIHRo
ZSBtZW1vcnkgYWxsb2NhdGlvbnMgdG8gaHVnZXBhZ2Ugc2l6ZXMsIHNvCj4gdGhhdCB0aGUgU1dJ
T1RMQiBwb29sIGNhbiBiZSBzY2FsZWQgdXAgb24gZGVtYW5kLgo+Cj4gVGhlIGlzc3VlIHdpdGgg
YWxpZ25pbmcgdGhlIHBvb2wgYXJlYXMgdG8gaHVnZXBhZ2VzIGlzIHRoYXQgaHVnZXBhZ2UKPiBh
bGxvY2F0aW9uIGF0IHJ1bnRpbWUgaXMgbm90IGd1YXJhbnRlZWQuIEd1YXJhbnRlZWluZyB0aGUg
aHVnZXBhZ2UKPiBhbGxvY2F0aW9uIG1pZ2h0IG5lZWQgY2FsY3VsYXRpbmcgdGhlIHVwcGVyIGJv
dW5kIGluIGFkdmFuY2UsIHdoaWNoCj4gZGVmZWF0cyB0aGUgcHVycG9zZSBvZiBlbmFibGluZyBk
eW5hbWljIFNXSU9UTEIuIEkgYW0gb3BlbiB0bwo+IHN1Z2dlc3Rpb25zIGhlcmUuCgoKWW91IGNv
dWxkIGFsbG9jYXRlIGEgbWF4IGJvdW5kIGF0IGJvb3QgdXNpbmcgQ01BIGFuZCB0aGVuIG9ubHkg
ZmlsbCBpbnRvIAp0aGUgQ01BIGFyZWEgd2hlbiBTV0lPVExCIHNpemUgcmVxdWlyZW1lbnRzIGlu
Y3JlYXNlPyBUaGUgQ01BIHJlZ2lvbiAKd2lsbCBhbGxvdyBtb3ZhYmxlIGFsbG9jYXRpb25zIGFz
IGxvbmcgYXMgeW91IGRvbid0IHJlcXVpcmUgdGhlIENNQSBzcGFjZS4KCgpBbGV4CgoKCgpBbWF6
b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBC
ZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBX
ZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIg
MTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


