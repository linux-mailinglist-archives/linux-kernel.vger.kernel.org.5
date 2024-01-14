Return-Path: <linux-kernel+bounces-25407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7AD82CFD7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 06:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE721F21DF9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329AC1852;
	Sun, 14 Jan 2024 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="N8LnvvTb"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913077E;
	Sun, 14 Jan 2024 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=mnX4TlYD1IAE/ynrPPGqCTpsWWnb3+9QkFs/jH0hltg=; b=N
	8LnvvTbUIE1Ra9PG54OVVx8RIlQnXE3ejcgv0KbFpiKQ31SKdPkpGoRH5Jjn7Z6B
	yolLSsfxH8wfSCi29wwnLotRbBmPiuNAy3FZna54Pv3VjubV9u8EvNg6e/wpIodZ
	7TpRJ6laMl7M201agJXjA1ZGoGky5dlY19i19RcUXE=
Received: from 00107082$163.com ( [111.35.185.31] ) by
 ajax-webmail-wmsvr-40-120 (Coremail) ; Sun, 14 Jan 2024 13:30:37 +0800
 (CST)
Date: Sun, 14 Jan 2024 13:30:37 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Jozsef Kadlecsik" <kadlec@blackhole.kfki.hu>, ale.crismani@automattic.com
Cc: linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	"Pablo Neira Ayuso" <pablo@netfilter.org>, xiaolinkui@kylinos.cn
Subject: Re:Performance regression in ip_set_swap on 6.7.0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <d5c24887-b2d4-bcc-f5a4-bd3d2670d16@blackhole.kfki.hu>
References: <b333bc85-83ea-8869-ccf7-374c9456d93c@blackhole.kfki.hu>
 <20240111145330.18474-1-00107082@163.com>
 <d5c24887-b2d4-bcc-f5a4-bd3d2670d16@blackhole.kfki.hu>
X-NTES-SC: AL_Qu2bB/6av0oo4SCcbOkXn0oTju85XMCzuv8j3YJeN500qiTVwCIGRUdABVf16++IFB+wiCCHVgdS1udTd4hbeo9FUoS7lNBbr/tiiWi+//4h
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <41662e12.d59.18d0673507e.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wDXf3F+caNlq7s9AA--.27681W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqAllqmVOBpjcjQADsJ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDEtMTQgMDI6MjQ6MDcsICJKb3pzZWYgS2FkbGVjc2lrIiA8a2FkbGVjQGJsYWNr
aG9sZS5rZmtpLmh1PiB3cm90ZToKPk9uIFRodSwgMTEgSmFuIDIwMjQsIERhdmlkIFdhbmcgd3Jv
dGU6Cj4KPj4gSSB0ZXN0ZWQgdGhlIHBhdGNoIHdpdGggY29kZSBzdHJlc3Npbmcgc3dhcC0+ZGVz
dHJveS0+Y3JlYXRlLT5hZGQgMTAwMDAgCj4+IHRpbWVzLCB0aGUgcGVyZm9ybWFuY2UgcmVncmVz
c2lvbiBzdGlsbCBoYXBwZW5zLCBhbmQgbm93IGl0IGlzIAo+PiBpcF9zZXRfZGVzdHJveS4gKEkg
cGFzdGVkIHRoZSB0ZXN0IGNvZGUgYXQgdGhlIGVuZCBvZiB0aGlzIG1haWwpCgo+PiAKPj4gVGhl
eSBhbGwgY2FsbCB3YWl0X2Zvcl9jb21wbGV0aW9uLCB3aGljaCBtYXkgc2xlZXAgb24gc29tZXRo
aW5nIG9uIAo+PiBwdXJwb3NlLCBJIGd1ZXNzLi4uCj4KPlRoYXQncyBPSyBiZWNhdXNlIGlwX3Nl
dF9kZXN0cm95KCkgY2FsbHMgcmN1X2JhcnJpZXIoKSB3aGljaCBpcyBuZWVkZWQgdG8gCj5oYW5k
bGUgZmx1c2ggaW4gbGlzdCB0eXBlIG9mIHNldHMuCj4KPkhvd2V2ZXIsIHJjdV9iYXJyaWVyKCkg
d2l0aCBjYWxsX3JjdSgpIHRvZ2V0aGVyIG1ha2VzIG11bHRpcGxlIGRlc3Ryb3lzIAo+b25lIGFm
dGVyIGFub3RoZXIgc2xvdy4gQnV0IHJjdV9iYXJyaWVyKCkgaXMgbmVlZGVkIGZvciBsaXN0IHR5
cGUgb2Ygc2V0cyAKPm9ubHkgYW5kIHRoYXQgY2FuIGJlIGhhbmRsZWQgc2VwYXJhdGVseS4gU28g
Y291bGQgeW91IHRlc3QgdGhlIHBhdGNoIAo+YmVsb3c/IEFjY29yZGluZyB0byBteSB0ZXN0cyBp
dCBpcyBldmVuIGEgbGl0dGxlIGJpdCBmYXN0ZXIgdGhhbiB0aGUgCj5vcmlnaW5hbCBjb2RlIGJl
Zm9yZSBzeW5jaHJvbml6ZV9yY3UoKSB3YXMgYWRkZWQgdG8gc3dhcC4KCkNvbmZpcm1lZH4hIFRo
aXMgcGF0Y2ggZG9lcyBmaXggdGhlIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gaW4gbXkgY2FzZS4K
CkhvcGUgaXQgY2FuIGZpeCBhbGUuY3Jpc21hbmlAYXV0b21hdHRpYy5jb20ncyBvcmlnaW5hbCBp
c3N1ZS4KCgoKVGhhbmtzfgpEYXZpZA==

