Return-Path: <linux-kernel+bounces-11013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFF181E011
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E301C21932
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC025102C;
	Mon, 25 Dec 2023 11:29:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660585100A;
	Mon, 25 Dec 2023 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [10.190.64.80] ) by
 ajax-webmail-mail-app3 (Coremail) ; Mon, 25 Dec 2023 19:28:44 +0800
 (GMT+08:00)
Date: Mon, 25 Dec 2023 19:28:44 +0800 (GMT+08:00)
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
Subject: Re: Re: [PATCH net] [v2] sfc: fix a double-free bug in
 efx_probe_filters
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20231224155138.GA228041@kernel.org>
References: <20231222154952.3531636-1-alexious@zju.edu.cn>
 <20231224155138.GA228041@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <23192f19.5560e.18ca0bbfed6.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgC3IRhsZ4llh7lxAQ--.46726W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgEPAGWCupcTBgAYsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

IAo+IE9uIEZyaSwgRGVjIDIyLCAyMDIzIGF0IDExOjQ5OjUyUE0gKzA4MDAsIFpoaXBlbmcgTHUg
d3JvdGU6Cj4gPiBJbiBlZnhfcHJvYmVfZmlsdGVycywgdGhlIGNoYW5uZWwtPnJwc19mbG93X2lk
IGlzIGZyZWVkIGluIGEKPiA+IGVmeF9mb3JfZWFjaF9jaGFubmVsIG1hcmNvICB3aGVuIHN1Y2Nl
c3MgZXF1YWxzIHRvIDAuCj4gPiBIb3dldmVyLCBhZnRlciB0aGUgZm9sbG93aW5nIGNhbGwgY2hh
aW46Cj4gPiAKPiA+IGVmMTAwX25ldF9vcGVuCj4gPiAgIHwtPiBlZnhfcHJvYmVfZmlsdGVycwo+
ID4gICB8LT4gZWYxMDBfbmV0X3N0b3AKPiA+ICAgICAgICAgfC0+IGVmeF9yZW1vdmVfZmlsdGVy
cwo+ID4gCj4gPiBUaGUgY2hhbm5lbC0+cnBzX2Zsb3dfaWQgaXMgZnJlZWQgYWdhaW4gaW4gdGhl
IGVmeF9mb3JfZWFjaF9jaGFubmVsIG9mCj4gPiBlZnhfcmVtb3ZlX2ZpbHRlcnMsIHRyaWdnZXJp
bmcgYSBkb3VibGUtZnJlZSBidWcuCj4gPiAtLS0KPiAKPiBFdmVyeXRoaW5nIGJlbG93IHRoZSBs
aW5lIGFib3ZlICgtLS0pIHdpbGwgYmUgb21pdHRlZCBmcm9tIHRoZSBjb21taXQKPiBtZXNzYWdl
IHdoZW4gdGhlIHBhdGNoIGlzIGFwcGxpZWQuCj4gCj4gPiBDaGFuZ2Vsb2c6Cj4gPiAKPiA+IHYy
OiBDb3JyZWN0IHRoZSBjYWxsLWNoYWluIGRlc2NyaXB0aW9uIGluIGNvbW1pdCBtZXNzYWdlIGFu
ZCBjaGFuZ2UKPiA+IHBhdGNoIHN1YmplY3QuCj4gPiAKPiA+IEZpeGVzOiBhOWRjM2Q1NjEyY2Ug
KCJzZmNfZWYxMDA6IFJYIGZpbHRlciB0YWJsZSBtYW5hZ2VtZW50IGFuZCByZWxhdGVkIGd1YmJp
bnMiKQo+ID4gU2lnbmVkLW9mZi1ieTogWmhpcGVuZyBMdSA8YWxleGlvdXNAemp1LmVkdS5jbj4K
PiA+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Cj4gPiBSZXZp
ZXdlZC1ieTogRWR3YXJkIENyZWUgPGVjcmVlLnhpbGlueEBnbWFpbC5jb20+Cj4gCj4gSGkgWmhp
cGVuZyBMdSwKPiAKPiBJIHRoaW5rIHRoYXQgeW91ciBTaWduZWQtb2ZmLWJ5IHNob3VsZCBnbyBs
YXN0IHdoZW4geW91IHBvc3QgYSBwYXRjaC4KPiAKPiBBbmQgdGhlIENoYW5nZWxvZyBzaG91bGQg
Z28gYmVsb3cgdGhlIChmaXJzdCBzZXQgb2YpIHNjaXNzb3JzICgtLS0pLgo+IAo+ID4gLS0tCj4g
PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc2ZjL3J4X2NvbW1vbi5jIHwgNCArKystCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IFdpdGggdGhl
IGFib3ZlIGluIG1pbmQsIEkgdGhpbmsgeW91IHdhbnQgc29tZXRoaW5nIGxpa2U6Cj4gCj4gSW4g
ZWZ4X3Byb2JlX2ZpbHRlcnMsIHRoZSBjaGFubmVsLT5ycHNfZmxvd19pZCBpcyBmcmVlZCBpbiBh
Cj4gZWZ4X2Zvcl9lYWNoX2NoYW5uZWwgbWFyY28gIHdoZW4gc3VjY2VzcyBlcXVhbHMgdG8gMC4K
PiBIb3dldmVyLCBhZnRlciB0aGUgZm9sbG93aW5nIGNhbGwgY2hhaW46Cj4gCj4gZWYxMDBfbmV0
X29wZW4KPiAgIHwtPiBlZnhfcHJvYmVfZmlsdGVycwo+ICAgfC0+IGVmMTAwX25ldF9zdG9wCj4g
ICAgICAgICB8LT4gZWZ4X3JlbW92ZV9maWx0ZXJzCj4gCj4gVGhlIGNoYW5uZWwtPnJwc19mbG93
X2lkIGlzIGZyZWVkIGFnYWluIGluIHRoZSBlZnhfZm9yX2VhY2hfY2hhbm5lbCBvZgo+IGVmeF9y
ZW1vdmVfZmlsdGVycywgdHJpZ2dlcmluZyBhIGRvdWJsZS1mcmVlIGJ1Zy4KPiAKPiBGaXhlczog
YTlkYzNkNTYxMmNlICgic2ZjX2VmMTAwOiBSWCBmaWx0ZXIgdGFibGUgbWFuYWdlbWVudCBhbmQg
cmVsYXRlZCBndWJiaW5zIikKPiBSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJu
ZWwub3JnPgo+IFJldmlld2VkLWJ5OiBFZHdhcmQgQ3JlZSA8ZWNyZWUueGlsaW54QGdtYWlsLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBaaGlwZW5nIEx1IDxhbGV4aW91c0B6anUuZWR1LmNuPgo+IC0t
LQo+IENoYW5nZWxvZzoKPiAKPiB2MjogQ29ycmVjdCB0aGUgY2FsbC1jaGFpbiBkZXNjcmlwdGlv
biBpbiBjb21taXQgbWVzc2FnZSBhbmQgY2hhbmdlCj4gcGF0Y2ggc3ViamVjdC4KPiAtLS0KPiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvc2ZjL3J4X2NvbW1vbi5jIHwgNCArKystCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiAtLSAKPiBwdy1ib3Q6
IGNoYW5nZXMtcmVxdWVzdGVkCgpUaGFuayB5b3UgZm9yIHlvdXIgZGV0YWlsZWQgcmV2aXNpb24g
YW5kIGNvcnJlY3Rpb24hCkknbGwgc2VuZCB0aGlzIHBhdGNoIGFnYWluIHdpdGggeW91ciBjb3Jy
ZWN0aW9uLg==

