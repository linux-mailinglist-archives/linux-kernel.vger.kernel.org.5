Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC9D7AA7E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjIVEjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIVEjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:39:12 -0400
X-Greylist: delayed 2221 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 21:39:04 PDT
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7B0EF1;
        Thu, 21 Sep 2023 21:39:04 -0700 (PDT)
Received: from dinghao.liu$zju.edu.cn ( [10.181.203.255] ) by
 ajax-webmail-mail-app2 (Coremail) ; Fri, 22 Sep 2023 12:01:59 +0800
 (GMT+08:00)
X-Originating-IP: [10.181.203.255]
Date:   Fri, 22 Sep 2023 12:01:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Benjamin Block" <bblock@linux.ibm.com>
Cc:     "Steffen Maier" <maier@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "James Bottomley" <James.Bottomley@suse.de>,
        "Swen Schillig" <swen@vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Mailing List linux-scsi" <linux-scsi@vger.kernel.org>
Subject: Re: Re: [PATCH] scsi: zfcp: Fix a potential double free in
 zfcp_port_enqueue
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230921104746.GG10864@p1gen4-pw042f0m.fritz.box>
References: <20230921063915.7703-1-dinghao.liu@zju.edu.cn>
 <20230921102102.GF10864@p1gen4-pw042f0m.fritz.box>
 <20230921104746.GG10864@p1gen4-pw042f0m.fritz.box>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <ed52141.211c9.18abb0d3396.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDHibS3EQ1lC0epAA--.17686W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgAGBmUMUaAikwAAsr
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIFNlcCAyMSwgMjAyMyBhdCAxMjoyMTowMlBNICswMjAwLCBCZW5qYW1pbiBCbG9j
ayB3cm90ZToKPiA+IEhlbGxvIExpdSBEaW5naGFvLAo+ID4gCj4gPiBnb29kIGZpbmQuCj4gCj4g
T2gsIGFsc28sIHBsZWFzZSBwdXQgbGludXgtc2NzaSBvbiB0aGUgQ0MgbGlzdC4gUGF0Y2hlcyB0
byB6ZmNwIGdvIHZpYQo+IGxpbnV4LXNjc2ksIG5vdCBsaW51eC1zMzkwLgo+IAo+ID4gCj4gPiBP
biBUaHUsIFNlcCAyMSwgMjAyMyBhdCAwMjozOToxNVBNICswODAwLCBEaW5naGFvIExpdSB3cm90
ZToKPiA+ID4gV2hlbiBkZXZpY2VfcmVnaXN0ZXIoKSBmYWlscywgemZjcF9wb3J0X3JlbGVhc2Uo
KSB3aWxsIGJlIGNhbGxlZAo+ID4gPiBhZnRlciBwdXRfZGV2aWNlKCkuIEFzIGEgcmVzdWx0LCB0
aGUgemZjcF9jY3dfYWRhcHRlcl9wdXQoKSBhZnRlcgo+ID4gPiBlcnJfb3V0IGlzIHJlZHVuZGFu
dCBiZWNhdXNlIGl0IHdpbGwgYmUgY2FsbGVkIGluIHRoZSBjYWxsLWJhY2sKPiA+ID4gZnVuY3Rp
b24gemZjcF9wb3J0X3JlbGVhc2UoKS4gUmVtb3ZlIGl0IGZyb20gdGhpcyBlcnJvciBwYXRoLgo+
ID4gCj4gPiBTbyB0aGUgcmVmZXJlbmNlIG9uIHRoZSBhZGFwdGVyIG9iamVjdCBpcyBkb3VibHkg
cHV0LCB3aGljaCBtYXkKPiA+IGxlYWQgdG8gYSBwcmVtYXR1cmUgZnJlZSBvZiB0aGUgYWRhcHRl
ciBvYmplY3QgaXRzZWxmLiBQbGVhc2UgbWVudGlvbiB0aGF0Cj4gPiBlaXRoZXIgaW4gdGhlIHN1
YmplY3QsIG9yIGRlc2NyaXB0aW9uOyBpdCBtYWtlcyBpdCBlYXNpZXIgdG8gc2VlIHdoYXQgZXhh
Y3RseQo+ID4gYnJlYWtzIGF0IGEgZ2xhbmNlLgo+ID4gCj4gPiA+IAo+ID4gPiBGaXhlczogZjM0
NTBjN2I5MTcyICgiW1NDU0ldIHpmY3A6IFJlcGxhY2UgbG9jYWwgcmVmZXJlbmNlIGNvdW50aW5n
IHdpdGggY29tbW9uIGtyZWYiKQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEaW5naGFvIExpdSA8ZGlu
Z2hhby5saXVAemp1LmVkdS5jbj4KPiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL3MzOTAvc2NzaS96
ZmNwX2F1eC5jIHwgMiArLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4gPiA+IAo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zMzkwL3Njc2kv
emZjcF9hdXguYyBiL2RyaXZlcnMvczM5MC9zY3NpL3pmY3BfYXV4LmMKPiA+ID4gaW5kZXggZGY3
ODI2NDZlODU2Li40ODllNjIzOWRlZGYgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvczM5MC9z
Y3NpL3pmY3BfYXV4LmMKPiA+ID4gKysrIGIvZHJpdmVycy9zMzkwL3Njc2kvemZjcF9hdXguYwo+
ID4gPiBAQCAtNTUyLDcgKzU1Miw3IEBAIHN0cnVjdCB6ZmNwX3BvcnQgKnpmY3BfcG9ydF9lbnF1
ZXVlKHN0cnVjdCB6ZmNwX2FkYXB0ZXIgKmFkYXB0ZXIsIHU2NCB3d3BuLAo+ID4gPiAgCj4gPiA+
ICAJaWYgKGRldmljZV9yZWdpc3RlcigmcG9ydC0+ZGV2KSkgewo+ID4gPiAgCQlwdXRfZGV2aWNl
KCZwb3J0LT5kZXYpOwo+ID4gPiAtCQlnb3RvIGVycl9vdXQ7Cj4gPiA+ICsJCXJldHVybiBFUlJf
UFRSKHJldHZhbCk7Cj4gPiAKPiA+IEknZCByYXRoZXIgaGF2ZSBhIG5ldyBsYWJlbCBhdCB0aGUg
Ym90dG9tLCBpbiBmcm9udCBvZiB0aGUgcmV0dXJuIHRoYXQgaXMKPiA+IGFscmVhZHkgdGhlcmUs
IGFuZCBqdW1wIHRvIHRoYXQsIGluc3RlYWQgb2YgYSBkaWZmZXJlbnQgZnVuY3Rpb24gZXhpdCBw
b2ludC4KPiA+IAo+ID4gPiAgCX0KPiA+ID4gIAo+ID4gPiAgCXdyaXRlX2xvY2tfaXJxKCZhZGFw
dGVyLT5wb3J0X2xpc3RfbG9jayk7Cj4gPiA+IC0tIAo+ID4gPiAyLjE3LjEKPiA+ID4gCgpUaGFu
ayB5b3UgZm9yIHlvdXIgYWR2aWNlISBJIHdpbGwgcmVzZW5kIGEgbmV3IHBhdGNoIHNvb24uCgpS
ZWdhcmRzLApEaW5naGFvCg==
