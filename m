Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06762807E27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjLGB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjLGB6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:58:12 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9DEAB9;
        Wed,  6 Dec 2023 17:58:16 -0800 (PST)
Received: from dinghao.liu$zju.edu.cn ( [10.190.66.146] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 7 Dec 2023 09:58:00 +0800
 (GMT+08:00)
X-Originating-IP: [10.190.66.146]
Date:   Thu, 7 Dec 2023 09:58:00 +0800 (GMT+08:00)
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
In-Reply-To: <SJ0PR18MB5216D284A0CFEF612721D5FDDB84A@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231206064531.6089-1-dinghao.liu@zju.edu.cn>
 <SJ0PR18MB5216D284A0CFEF612721D5FDDB84A@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7f6e6e60.21d45.18c41ff00b8.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBXX9eoJnFluc5VAA--.18379W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgsCBmVwRZQh7wABsG
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VtYW4sCgo+ID5xZWRfaWx0X3NoYWRvd19hbGxvYygpIHdpbGwgY2FsbCBxZWRfaWx0X3No
YWRvd19mcmVlKCkgdG8gZnJlZSBwX2h3Zm4tCj4gPj5wX2N4dF9tbmdyLT5pbHRfc2hhZG93IG9u
IGVycm9yLiBIb3dldmVyLAo+ID5xZWRfY3h0X3RhYmxlc19hbGxvYygpIGZyZWVzIHRoaXMgcG9p
bnRlciBhZ2FpbiBvbiBmYWlsdXJlIG9mCj4gPnFlZF9pbHRfc2hhZG93X2FsbG9jKCkgdGhyb3Vn
aCBjYWxsaW5nIHFlZF9jeHRfbW5ncl9mcmVlKCksIHdoaWNoIG1heQo+ID5sZWFkIHRvIGRvdWJs
ZS1mcmVlLiBGaXggdGhpcyBpc3N1ZSBieSBzZXR0aW5nIHBfaHdmbi0+cF9jeHRfbW5nci0KPiA+
PmlsdF9zaGFkb3cgdG8gTlVMTCBpbiBxZWRfaWx0X3NoYWRvd19mcmVlKCkuCj4gPgo+ID5GaXhl
czogZmU1NmI5ZTZhOGQ5ICgicWVkOiBBZGQgbW9kdWxlIHdpdGggYmFzaWMgY29tbW9uIHN1cHBv
cnQiKQo+ID5TaWduZWQtb2ZmLWJ5OiBEaW5naGFvIExpdSA8ZGluZ2hhby5saXVAemp1LmVkdS5j
bj4KPiA+LS0tCj4gPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9xbG9naWMvcWVkL3FlZF9jeHQuYyB8
IDEgKwo+ID4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gPgo+ID5kaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2ljL3FlZC9xZWRfY3h0LmMKPiA+Yi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9xbG9naWMvcWVkL3FlZF9jeHQuYwo+ID5pbmRleCA2NWUyMDY5M2M1NDku
LjI2ZTI0NzUxNzM5NCAxMDA2NDQKPiA+LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2lj
L3FlZC9xZWRfY3h0LmMKPiA+KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2ljL3FlZC9x
ZWRfY3h0LmMKPiA+QEAgLTkzMyw2ICs5MzMsNyBAQCBzdGF0aWMgdm9pZCBxZWRfaWx0X3NoYWRv
d19mcmVlKHN0cnVjdCBxZWRfaHdmbgo+ID4qcF9od2ZuKQo+ID4gCQlwX2RtYS0+dmlydF9hZGRy
ID0gTlVMTDsKPiA+IAl9Cj4gPiAJa2ZyZWUocF9tbmdyLT5pbHRfc2hhZG93KTsKPiA+KwlwX2h3
Zm4tPnBfY3h0X21uZ3ItPmlsdF9zaGFkb3cgPSBOVUxMOwo+IFtTdW1hbl0gSGkgRGluZ2hhbywK
PiAKPiBJIGFtIG5vdCBzdXJlIGhvdyB0aGlzIHdpbGwgaGVscCBwcmV2ZW50IHRoZSBkb3VibGUg
ZnJlZSBoZXJlPyBJZiBxZWRfaWx0X3NoYWRvd19hbGxvYygpIGZhaWxzIHRvIGFsbG9jYXRlIG1l
bW9yeSwgdGhlbiBzdGlsbCBxZWRfY3h0X21uZ3JfZnJlZSgpIHdpbGwgYmUgY2FsbGVkIGFuZCBr
ZnJlZSgpCj4gd2lsbCB0cnkgdG8gZnJlZSB0aGUgTlVMTCBwb2ludGVyLiBTaG91bGRuJ3QgaXQg
YmUgbGlrZSBiZWxvdz8KPiAKPiBpZiAocF9tbmdyLT5pbHRfc2hhZG93KQo+IAlLZnJlZShwX21u
Z3ItPmlsdF9zaGFkb3cpOwo+ID4gfQo+ID4KPiA+IHN0YXRpYyBpbnQgcWVkX2lsdF9ibGtfYWxs
b2Moc3RydWN0IHFlZF9od2ZuICpwX2h3Zm4sCj4gPi0tCj4gPjIuMTcuMQo+ID4KCmtmcmVlKE5V
TEwpIGlzIHNhZmUgaW4ga2VybmVsLiBCdXQga2ZyZWUoKSB3aWxsIG5vdCBzZXQgdGhlIGZyZWVk
CnBvaW50ZXIgdG8gTlVMTC4gVGhlcmVmb3JlLCBjaGVja2luZyBwX21uZ3ItPmlsdF9zaGFkb3cg
d2lsbApub3QgcHJldmVudCB0aGUga2ZyZWUoKSBmb3IgdGhlIHNlY29uZCB0aW1lLiBNYW55IGRv
dWJsZS1mcmVlCmJ1Z3MgYXJlIGZpeGVkIGJ5IHNldHRpbmcgdGhlIGZyZWVkIHBvaW50ZXIgdG8g
TlVMTCAoZS5nLiwgCjZiMGQwNDc3ZmNlNyAoIm1lZGlhOiBkdmItY29yZTogRml4IGRvdWJsZSBm
cmVlIGluCmR2Yl9yZWdpc3Rlcl9kZXZpY2UoKSIpKSwgc28gSSBqdXN0IGZpeCB0aGlzIGJ1ZyBp
biB0aGUgc2FtZQp3YXkuIAoKUmVnYXJkcywKRGluZ2hhbw==
