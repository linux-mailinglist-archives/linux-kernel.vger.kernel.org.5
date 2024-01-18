Return-Path: <linux-kernel+bounces-30121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9198319B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE941F23520
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF71250E6;
	Thu, 18 Jan 2024 12:57:29 +0000 (UTC)
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE4A11CAF;
	Thu, 18 Jan 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.164.42.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582649; cv=none; b=F2uA1ybT/MgH+KqrStFMLjdgR5GXWq+afSIBOa53ZGZwtmC3oGjaylDSm9VbP4VKh3Gil3jRGeLlhxHWDRiSV90+DxwPDaIPdnIeOFN54zaHkk+P8DlUdiJS6hB3rAD6lfIbZk8xlNwNAD3q6dWaBcP7Ggzt8Qm0II2dSMniC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582649; c=relaxed/simple;
	bh=LerU++dxfnwH5p+NP1dk3SyTWIVBqDcwNlclb0BFPZY=;
	h=Received:X-Originating-IP:Date:X-CM-HeaderCharset:From:To:Cc:
	 Subject:X-Priority:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	 X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam; b=LQ4OXhaWmGhJCsA16ciW2QYmYWO7K68IrXGB0Xf8m8MZ3Ar8944RhI6gsxgpv6rPEdzn4xdI7FddpefZRODcSdOCUXtgm3yT5hAvj+qNWAEHkalnOwPvJ+ieg0LE4QXI5gN9l2JCvxM7+iQhay1CTl2rEKGh+OS1SPdZ5/sA78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=61.164.42.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [10.192.34.167] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 18 Jan 2024 20:57:05 +0800
 (GMT+08:00)
Date: Thu, 18 Jan 2024 20:57:05 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Paolo Abeni" <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] vlan: skip nested type that is not
 IFLA_VLAN_QOS_MAPPING
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <1137d26fb5fc1ca7070f8012ec588116a29a1c8a.camel@redhat.com>
References: <20240117153810.1197794-1-linma@zju.edu.cn>
 <1137d26fb5fc1ca7070f8012ec588116a29a1c8a.camel@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <26a27e55.668e.18d1ca5845b.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgAHSaghIKllvoNPAA--.7856W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwMEEmWoIc4RlgAAsz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gUGFvbG8sCgo+IAo+IE9uIFdlZCwgMjAyNC0wMS0xNyBhdCAyMzozOCArMDgwMCwgTGlu
IE1hIHdyb3RlOgo+ID4gSW4gdGhlIHZsYW5fY2hhbmdlbGluayBmdW5jdGlvbiwgYSBsb29wIGlz
IHVzZWQgdG8gcGFyc2UgdGhlIG5lc3RlZAo+ID4gYXR0cmlidXRlcyBJRkxBX1ZMQU5fRUdSRVNT
X1FPUyBhbmQgSUZMQV9WTEFOX0lOR1JFU1NfUU9TIGluIG9yZGVyIHRvCj4gPiBvYnRhaW4gdGhl
IHN0cnVjdCBpZmxhX3ZsYW5fcW9zX21hcHBpbmcuIFRoZXNlIHR3byBuZXN0ZWQgYXR0cmlidXRl
cyBhcmUKPiA+IGNoZWNrZWQgaW4gdGhlIHZsYW5fdmFsaWRhdGVfcW9zX21hcCBmdW5jdGlvbiwg
d2hpY2ggY2FsbHMKPiA+IG5sYV92YWxpZGF0ZV9uZXN0ZWRfZGVwcmVjYXRlZCB3aXRoIHRoZSB2
bGFuX21hcF9wb2xpY3kuCj4gPiAKPiA+IEhvd2V2ZXIsIHRoaXMgZGVwcmVjYXRlZCB2YWxpZGF0
b3IgYXBwbGllcyBhIExJQkVSQUwgc3RyaWN0bmVzcywgYWxsb3dpbmcKPiA+IHRoZSBwcmVzZW5j
ZSBvZiBhbiBhdHRyaWJ1dGUgd2l0aCB0aGUgdHlwZSBJRkxBX1ZMQU5fUU9TX1VOU1BFQy4KPiA+
IENvbnNlcXVlbnRseSwgdGhlIGxvb3AgaW4gdmxhbl9jaGFuZ2VsaW5rIG1heSBwYXJzZSBhbiBh
dHRyaWJ1dGUgb2YgdHlwZQo+ID4gSUZMQV9WTEFOX1FPU19VTlNQRUMgYW5kIGJlbGlldmUgaXQg
Y2FycmllcyBhIHBheWxvYWQgb2YKPiA+IHN0cnVjdCBpZmxhX3ZsYW5fcW9zX21hcHBpbmcsIHdo
aWNoIGlzIG5vdCBuZWNlc3NhcmlseSB0cnVlLgo+ID4gCj4gPiBUbyBhZGRyZXNzIHRoaXMgaXNz
dWUgYW5kIGVuc3VyZSBjb21wYXRpYmlsaXR5LCB0aGlzIHBhdGNoIGludHJvZHVjZXMgdHdvCj4g
PiB0eXBlIGNoZWNrcyB0aGF0IHNraXAgYXR0cmlidXRlcyB3aG9zZSB0eXBlIGlzIG5vdCBJRkxB
X1ZMQU5fUU9TX01BUFBJTkcuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IExpbiBNYSA8bGlubWFA
emp1LmVkdS5jbj4KPiAKPiBXaHkgYXJlIHlvdSB0YXJnZXRpbmcgbmV0LW5leHQ/IHRoaXMgbG9v
a3MgbGlrZSBhIGZpeCBzdWl0YWJsZSBmb3IKPiAnbmV0JyAtIHdpdGggYSBwcm9wZXIgZml4ZXMg
dGFnLgo+IAoKVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb25zLCBzb21ldGltZXMgSSBqdXN0IG1p
c3Rha2VubHkgZG8gdGhlIG9wcG9zaXRlIG9mIHdoYXQgSSBpbnRlbmRlZCB0by4gCgpJIHdpbGwg
c2VuZCB2ZXJzaW9uIHR3byB3aXRoIHRoZSByaWdodCB0YWcuCgo+IENoZWVycywKPiAKPiBQYW9s
bwoKVGhhbmtzCkxpbgo=

