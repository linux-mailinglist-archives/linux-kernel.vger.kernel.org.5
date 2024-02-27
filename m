Return-Path: <linux-kernel+bounces-83148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E88EB868F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871A91F29BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9113A878;
	Tue, 27 Feb 2024 11:54:44 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290F13A255;
	Tue, 27 Feb 2024 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034884; cv=none; b=MkusjPqpQ83Nz22zMAV1QjbNLFU8dsuDozr+cLxif0OH56bOGj3U11mi+KqlPlUX7Xv0cM/Pz6LwtLCMmFKPexd4xYGWh/ARMw+fukCDaHImHXuRqqOjVnYwikFdde/bqCJxbg8ImH5G6LwGnmAtNBWA68s7j1ww+QERH7y5Eoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034884; c=relaxed/simple;
	bh=7XOPgjZ67GCgom1T1coaAyfLK3kXdhZf7Oi8sNkqXoA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ofYloWeRymUIgSeq7k2cdzmwYSf8gIy5PD/wQBfXXiufZHZhcmHJARpRr9S0koYmxo5svybzCrlMSeuqoUIsgl+4YDAowgnNJcHMEUi04CpyfY9Lmr3fWMULE3Eu8XAZHsSGUfnMG5ldtL3VESCcSkZszF+ygFKvlb/VvimMTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [42.120.103.50] ) by
 ajax-webmail-mail-app3 (Coremail) ; Tue, 27 Feb 2024 19:54:16 +0800
 (GMT+08:00)
Date: Tue, 27 Feb 2024 19:54:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Nikolay Aleksandrov" <razor@blackwall.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, idosch@nvidia.com, jiri@resnulli.us,
	lucien.xin@gmail.com, edwin.peer@broadcom.com, amcohen@nvidia.com,
	pctammela@mojatatu.com, liuhangbin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS
 writing back
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <2e8c704f-e6a6-40b8-8d4b-7c3a987c4839@blackwall.org>
References: <20240227110113.573334-1-linma@zju.edu.cn>
 <2e8c704f-e6a6-40b8-8d4b-7c3a987c4839@blackwall.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <302ac4d7.207e.18dea6a6103.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgC3LThpzd1lOlKhAQ--.39703W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUSEmXWRlIBugAQsK
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gTmlrb2xheSwKCj4gCj4gVGhhdCBmaXggaXMgb2J2aW91c2x5IGJyb2tlbiwgSSBkb24n
dCBrbm93IGhvdyBJIG1pc3NlZCBpdCBiYWNrIHRoZW4uCj4gT25lIGNvbW1lbnQgYmVsb3csCgpH
dWVzcyBpcyBiZWNhdXNlIHRoaXMgbG9vcCBpcyBzbyB3ZWlyZCA6KApJIGxvb2tlZCBpbnRvIHRo
ZSBrZXJuZWwgYW5kIGRpZCBub3QgZmluZCBvdGhlciBjb2RlcyB0aGF0IHJlZmVyIHRvIHRoZQpO
TEEgcG9pbnRlciBvdXRzaWRlIHRoZSBgbmxhX2Zvcl9lYWNoX25lc3RlZGAgbG9vcC4KCj4gLi4u
Cj4gPiAgIAlzdHJ1Y3QgbmV0ICpuZXQgPSBzb2NrX25ldChza2ItPnNrKTsKPiA+ICAgCXN0cnVj
dCBpZmluZm9tc2cgKmlmbTsKPiA+ICAgCXN0cnVjdCBuZXRfZGV2aWNlICpkZXY7Cj4gPiAtCXN0
cnVjdCBubGF0dHIgKmJyX3NwZWMsICphdHRyID0gTlVMTDsKPiA+ICsJc3RydWN0IG5sYXR0ciAq
YnJfc3BlYywgKmF0dHIsICpicl9mbGFnID0gTlVMTDsKPiAKPiBQbGVhc2UgbmFtZSB0aGUgdmFy
aWFibGUgdG8gc29tZXRoaW5nIHRoYXQgZGVzY3JpYmVzIGl0IGJldHRlciwgbGlrZQo+IGJyX2Zs
YWdzX2F0dHIuCj4gCgpPSywgSSB3aWxsIHJlbmFtZSB0aGUgdmFyaWFibGUgYW5kIHNlbmQgYW5v
dGhlciB2ZXJzaW9uLgoKPiA+ICAgCWludCByZW0sIGVyciA9IC1FT1BOT1RTVVBQOwo+ID4gICAJ
dTE2IGZsYWdzID0gMDsKPiA+IC0JYm9vbCBoYXZlX2ZsYWdzID0gZmFsc2U7Cj4gPiAgIAo+ID4g
ICAJaWYgKG5sbXNnX2xlbihubGgpIDwgc2l6ZW9mKCppZm0pKQo+ID4gICAJCXJldHVybiAtRUlO
VkFMOwo+ID4gQEAgLTUxOTAsMTEgKzUxODksMTEgQEAgc3RhdGljIGludCBydG5sX2JyaWRnZV9z
ZXRsaW5rKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBubG1zZ2hkciAqbmxoLAo+ID4gICAJ
YnJfc3BlYyA9IG5sbXNnX2ZpbmRfYXR0cihubGgsIHNpemVvZihzdHJ1Y3QgaWZpbmZvbXNnKSwg
SUZMQV9BRl9TUEVDKTsKPiA+ICAgCWlmIChicl9zcGVjKSB7Cg==

