Return-Path: <linux-kernel+bounces-7351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B711781A65E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A4EB2335B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018ED482C0;
	Wed, 20 Dec 2023 17:31:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A76747A42;
	Wed, 20 Dec 2023 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [124.90.104.65] ) by
 ajax-webmail-mail-app4 (Coremail) ; Thu, 21 Dec 2023 01:30:59 +0800
 (GMT+08:00)
Date: Thu, 21 Dec 2023 01:30:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Simon Horman" <horms@kernel.org>
Cc: "Edward Cree" <ecree.xilinx@gmail.com>, 
	"Martin Habets" <habetsm.xilinx@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, 
	"Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] sfc: fix a double-free bug in efx_probe_filters
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20231216155145.GN6288@kernel.org>
References: <20231214152247.3482788-1-alexious@zju.edu.cn>
 <20231216155145.GN6288@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <310b8095.47cb8.18c8847dbe3.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgBnbzfUJINlgjTSAA--.11842W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgcPAGWCupcSuwAAsp
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cj4gT24gVGh1LCBEZWMgMTQsIDIwMjMgYXQgMTE6MjI6NDZQTSArMDgwMCwgWmhpcGVuZyBMdSB3
cm90ZToKPiA+IEluIGVmeF9wcm9iZV9maWx0ZXJzLCB0aGUgY2hhbm5lbC0+cnBzX2Zsb3dfaWQg
aXMgZnJlZWQgaW4gYQo+ID4gZWZ4X2Zvcl9lYWNoX2NoYW5uZWwgbWFyY28gIHdoZW4gc3VjY2Vz
cyBlcXVhbHMgdG8gMC4KPiA+IEhvd2V2ZXIsIGFmdGVyIHRoZSBmb2xsb3dpbmcgY2FsbCBjaGFp
bjoKPiA+IAo+ID4gZWZ4X3Byb2JlX2ZpbHRlcnMKPiA+ICAgfC0+IGVmMTAwX25ldF9vcGVuCj4g
PiAgICAgICAgIHwtPiBlZjEwMF9uZXRfc3RvcAo+ID4gICAgICAgICAgICAgICB8LT4gZWZ4X3Jl
bW92ZV9maWx0ZXJzCj4gCj4gSSB0aGluayB0aGUgY2FsbCBjaGFpbiBtYXkgYmUgYSBiaXQgbW9y
ZSBsaWtlOgo+IAo+IGVmMTAwX25ldF9vcGVuCj4gICB8LT4gZWZ4X3Byb2JlX2ZpbHRlcnMKPiAg
IHwtPiBlZjEwMF9uZXRfc3RvcAo+ICAgICAgICAgfC0+IGVmeF9yZW1vdmVfZmlsdGVycwo+IAo+
ID4gCj4gPiBUaGUgY2hhbm5lbC0+cnBzX2Zsb3dfaWQgaXMgZnJlZWQgYWdhaW4gaW4gdGhlIGVm
eF9mb3JfZWFjaF9jaGFubmVsIG9mCj4gPiBlZnhfcmVtb3ZlX2ZpbHRlcnMsIHRyaWdnZXJpbmcg
YSBkb3VibGUtZnJlZSBidWcuCj4gPiAKPiA+IEZpeGVzOiBhOWRjM2Q1NjEyY2UgKCJzZmNfZWYx
MDA6IFJYIGZpbHRlciB0YWJsZSBtYW5hZ2VtZW50IGFuZCByZWxhdGVkIGd1YmJpbnMiKQo+ID4g
U2lnbmVkLW9mZi1ieTogWmhpcGVuZyBMdSA8YWxleGlvdXNAemp1LmVkdS5jbj4KPiAKPiBUaGUg
YWJvdmUgbml0IG5vdCB3aXRoc3RhbmRpbmcsIEkgYWdyZWUgd2l0aCB5b3VyIHJlYXNvbmluZy4K
PiBBbmQgdGhhdCB0aGUgcHJvYmxlbSB3YXMgaW50cm9kdWNlZCBpbiB0aGUgY2l0ZWQgY29tbWl0
Lgo+IAo+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+CgpTb3Jy
eSBmb3IgdGhlIGNhbGwtY2hhaW4ncyBwcm9ibGVtLCBJIHdhcyBub3QgZmFtaWxpYXIgd2l0aCBp
dCBhdCB0aGF0IHRpbWUuClRoYW5rcyBmb3IgU2ltb24ncyBjb3JyZWN0aW9uLiBBcHByZWNpYXRl
IQpJJ2xsIHNvb24gc2VuZCBhIHYyIHBhdGNoIHdpdGggdGhlIGNvcnJlY3RlZCBjYWxsLWNoYWlu
IGFuZCBSQiB0YWdzLg==

