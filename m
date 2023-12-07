Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CC980810E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377678AbjLGGsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjLGGsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:48:32 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F09010D9;
        Wed,  6 Dec 2023 22:48:33 -0800 (PST)
Received: from dinghao.liu$zju.edu.cn ( [10.190.66.146] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 7 Dec 2023 14:46:15 +0800
 (GMT+08:00)
X-Originating-IP: [10.190.66.146]
Date:   Thu, 7 Dec 2023 14:46:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Suman Ghosh" <sumang@marvell.com>
Cc:     "Ariel Elior" <aelior@marvell.com>,
        "Manish Chopra" <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Yuval Mintz" <Yuval.Mintz@qlogic.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] qed: Fix a potential double-free in
 qed_cxt_tables_alloc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <SJ0PR18MB5216722A40A24102A158A923DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231206064531.6089-1-dinghao.liu@zju.edu.cn>
 <SJ0PR18MB5216D284A0CFEF612721D5FDDB84A@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <7f6e6e60.21d45.18c41ff00b8.Coremail.dinghao.liu@zju.edu.cn>
 <SJ0PR18MB5216722A40A24102A158A923DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <13642c61.22e78.18c4306e6f2.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgB37yo3anFlswBXAA--.18674W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgICBmVwRZQ1PQABsJ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiA+KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2ljL3FlZC9xZWRfY3h0LmMKPiA+
PiA+QEAgLTkzMyw2ICs5MzMsNyBAQCBzdGF0aWMgdm9pZCBxZWRfaWx0X3NoYWRvd19mcmVlKHN0
cnVjdCBxZWRfaHdmbgo+ID4+ID4qcF9od2ZuKQo+ID4+ID4gCQlwX2RtYS0+dmlydF9hZGRyID0g
TlVMTDsKPiA+PiA+IAl9Cj4gPj4gPiAJa2ZyZWUocF9tbmdyLT5pbHRfc2hhZG93KTsKPiA+PiA+
KwlwX2h3Zm4tPnBfY3h0X21uZ3ItPmlsdF9zaGFkb3cgPSBOVUxMOwo+ID4+IFtTdW1hbl0gSGkg
RGluZ2hhbywKPiA+Pgo+ID4+IEkgYW0gbm90IHN1cmUgaG93IHRoaXMgd2lsbCBoZWxwIHByZXZl
bnQgdGhlIGRvdWJsZSBmcmVlIGhlcmU/IElmCj4gPj4gcWVkX2lsdF9zaGFkb3dfYWxsb2MoKSBm
YWlscyB0byBhbGxvY2F0ZSBtZW1vcnksIHRoZW4gc3RpbGwKPiA+cWVkX2N4dF9tbmdyX2ZyZWUo
KSB3aWxsIGJlIGNhbGxlZCBhbmQga2ZyZWUoKSB3aWxsIHRyeSB0byBmcmVlIHRoZSBOVUxMCj4g
PnBvaW50ZXIuIFNob3VsZG4ndCBpdCBiZSBsaWtlIGJlbG93Pwo+ID4+Cj4gPj4gaWYgKHBfbW5n
ci0+aWx0X3NoYWRvdykKPiA+PiAJS2ZyZWUocF9tbmdyLT5pbHRfc2hhZG93KTsKPiA+PiA+IH0K
PiA+PiA+Cj4gPj4gPiBzdGF0aWMgaW50IHFlZF9pbHRfYmxrX2FsbG9jKHN0cnVjdCBxZWRfaHdm
biAqcF9od2ZuLAo+ID4+ID4tLQo+ID4+ID4yLjE3LjEKPiA+PiA+Cj4gPgo+ID5rZnJlZShOVUxM
KSBpcyBzYWZlIGluIGtlcm5lbC4gQnV0IGtmcmVlKCkgd2lsbCBub3Qgc2V0IHRoZSBmcmVlZAo+
ID5wb2ludGVyIHRvIE5VTEwuIFRoZXJlZm9yZSwgY2hlY2tpbmcgcF9tbmdyLT5pbHRfc2hhZG93
IHdpbGwgbm90IHByZXZlbnQKPiA+dGhlIGtmcmVlKCkgZm9yIHRoZSBzZWNvbmQgdGltZS4gTWFu
eSBkb3VibGUtZnJlZSBidWdzIGFyZSBmaXhlZCBieQo+ID5zZXR0aW5nIHRoZSBmcmVlZCBwb2lu
dGVyIHRvIE5VTEwgKGUuZy4sCj4gPjZiMGQwNDc3ZmNlNyAoIm1lZGlhOiBkdmItY29yZTogRml4
IGRvdWJsZSBmcmVlIGluCj4gPmR2Yl9yZWdpc3Rlcl9kZXZpY2UoKSIpKSwgc28gSSBqdXN0IGZp
eCB0aGlzIGJ1ZyBpbiB0aGUgc2FtZSB3YXkuCj4gPgo+ID5SZWdhcmRzLAo+ID5EaW5naGFvCj4g
W1N1bWFuXSBPa2F5LCBJIHVuZGVyc3RhbmQuIEFsb25nIHdpdGggdGhpcyBjaGFuZ2UsIEkgaGF2
ZSBjb3VwbGUgb2Ygc3VnZ2VzdGlvbi4gQnV0IGl0IGlzIHVwIHRvIHlvdSB0byBtYWtlIHRoZW0u
Cj4gMS4gSW4gdGhlIGJlZ2lubmluZyBvZiB0aGUgZnVuY3Rpb24gcWVkX2lsdF9zaGFkb3dfZnJl
ZSgpIHNob3VsZCB3ZSBhZGQgYSBjaGVjayBhbmQgcmV0dXJuIGlmIGlsdF9zaGFkZXcgPT0gTlVM
TD8gU28sIHRoYXQgdGhlIGNvbnRyb2wgZG9lcyBub3QgcmVhY2ggdG8gdGhlIGVuZCBvZiB0aGUg
ZnVuY3Rpb24/IAo+IDIuIEkgc2VlIGluIHFlZF9pbHRfc2hhZG93X2FsbG9jKCkgd2UgYXJlIGNh
bGxpbmcgImdvdG8gaWx0X3NoYWRvd19mYWlsIiBldmVuIGlmIHRoZSBrY2FsbG9jKCkgaXMgZmFp
bGluZy4gSWYga2NhbGxvYygpIGZhaWxzLCB0aGVuIHRoZXJlIGlzIG5vdGhpbmcgdG8gZnJlZSwg
YW5kIHdlIGNhbiBkaXJlY3RseSByZXR1cm4gZnJvbSB0aGVyZSwgcmlnaHQ/CgpUaGFua3MgZm9y
IHlvdXIgc3VnZ2VzdGlvbnMhIEZvciB0aGUgZmlyc3Qgc3VnZ2VzdGlvbiwgaWx0X3NoYWRldyBp
cwpjaGVja2VkIGluIHRoZSBiZWdpbm5pbmcgb2YgdGhlIGZvciBsb29wLCBidXQgaXQgc2VlbXMg
dGhhdCB3ZSBuZWVkCm5vdCB0byBjaGVjayB0aGlzIHBvaW50ZXIgYXQgZWFjaCBpdGVyYXRpb24u
IEkgd2lsbCBtb3ZlIGl0IHRvIHRoZQpiZWdpbm5pbmcgb2YgdGhlIGZ1bmN0aW9uLiBJIGFsc28g
cmVjaGVja2VkIHRoZSBsb29wIGFuZCBmb3VuZCB0aGUgYnVnCmhlcmUgc2hvdWxkIGJlIGEgdXNl
LWFmdGVyLWZyZWUgaW5zdGVhZCBvZiBkb3VibGUtZnJlZS4gVGhlcmUgaXMgYSAKcG9pbnRlciBk
ZXJlZmVyZW5jZSAmcF9tbmdyLT5pbHRfc2hhZG93W2ldLCB3aGljaCB3aWxsIGJlCnRyaWdnZXJl
ZCBiZWZvcmUga2ZyZWUoKS4gSSB3aWxsIHJlc2VuZCBhIG5ldyBwYXRjaCB0byBmaXggdGhpcy4K
CkZvciB0aGUgc2Vjb25kIHN1Z2dlc3Rpb24sIEkgYWdyZWUgdGhhdCBkaXJlY3RseSByZXR1cm5p
bmcgd291bGQgYmUgYmV0dGVyLgpJIHdpbGwgZml4IHRoaXMgaW4gdGhlIG5leHQgcGF0Y2ggdmVy
c2lvbiwgdGhhbmtzIQoKUmVnYXJkcywKRGluZ2hhbwo=
