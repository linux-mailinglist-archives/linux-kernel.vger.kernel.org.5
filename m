Return-Path: <linux-kernel+bounces-18813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3029D82635C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3631D1C20F88
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 08:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AFD12B70;
	Sun,  7 Jan 2024 08:25:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7112B69;
	Sun,  7 Jan 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [124.90.105.91] ) by
 ajax-webmail-mail-app3 (Coremail) ; Sun, 7 Jan 2024 16:25:12 +0800
 (GMT+08:00)
Date: Sun, 7 Jan 2024 16:25:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Takashi Iwai" <tiwai@suse.de>
Cc: "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ALSA: hdsp: fix some memleaks in
 snd_hdsp_hwdep_ioctl
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <87o7e9xhyd.wl-tiwai@suse.de>
References: <20231227060322.3556052-1-alexious@zju.edu.cn>
 <87o7e9xhyd.wl-tiwai@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <21989c36.77f56.18ce306a4c1.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgDnXXHpX5plHbgPAg--.3676W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAg0KAGWWgSQE-AASs5
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

IAo+IE9uIFdlZCwgMjcgRGVjIDIwMjMgMDc6MDM6MjAgKzAxMDAsCj4gWmhpcGVuZyBMdSB3cm90
ZToKPiA+IAo+ID4gV2hlbiBzbmRfaGRzcF9sb2FkX2Zpcm13YXJlX2Zyb21fY2FjaGUgYW5kIHNu
ZF9oZHNwX2VuYWJsZV9pbyBmYWlscywKPiA+IHRoZSBoZHNwLT5md191cGxvYWRlZCBuZWVkcyB0
byBiZSBmcmVlLk9yIHRoZXJlIGNvdWxkIGJlIG1lbWxlYWtzIGluCj4gPiBzbmRfaGRzcF9od2Rl
cF9pb2N0bC4KPiA+IAo+ID4gRml4ZXM6IDkwY2FhZWY2YTFjZSAoIkFMU0E6IGhkc3A6IGltcHJv
dmUgZmlybXdhcmUgY2FjaGluZyIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGlwZW5nIEx1IDxhbGV4
aW91c0B6anUuZWR1LmNuPgo+IAo+IFRoYW5rcyBmb3IgdGhlIHBhdGNoLCBidXQgdGhlIHBhdGNo
IGRlc2NyaXB0aW9uIGlzIG1pc2xlYWRpbmcuCj4gVGhlIGFsbG9jYXRlZCBvYmplY3QgaXNuJ3Qg
cmVhbGx5ICJsZWFrZWQiOyBpdCdzIHJlbGVhc2VkIGF0IHRoZQo+IHJlbW92YWwgb2YgdGhlIGRy
aXZlci4KCkl0IGlzIGEgbGl0dGxlIGNvbmZ1c2VkIHRvIG1lIHRoYXQgSSBjYW4ndCBmaW5kIGEg
Y2xlYXIgInJlbW92YWwiIG9wZXJhdGlvbiBmb3IgCmhkc3AtPmZ3X3VwbG9hZGVkLiBDb3VsZCB5
b3UgcGxlYXNlIGdpdmUgYSBtb3JlIGRldGFpbGVkIGV4cGxhaW5hdGlvbiwgCnN1Y2ggYXMgY2Fs
bCBjaGFpbiwgd2h5IGhkc3AtPmZ3X3VwbG9hZGVkIGlzIG5vdCBsZWFrZWQ/CgpUaGFua3MsCgpa
aGlwZW5nCgoKPiBXZSBtYXkgYXBwbHkgc29tZSBvcHRpbWl6YXRpb24gbGlrZSB5b3UgZGlkLCBi
dXQgdGhlbiBpdCBzaG91bGQgaGF2ZSBhCj4gZGlmZmVyZW50IGRlc2NyaXB0aW9uLgo+IAo+IHRo
YW5rcywKPiAKPiBUYWthc2hpCg==

