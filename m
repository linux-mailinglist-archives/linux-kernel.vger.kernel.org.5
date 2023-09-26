Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2969C7AED04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjIZMlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjIZMlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:41:10 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69B94FC;
        Tue, 26 Sep 2023 05:41:01 -0700 (PDT)
Received: from dinghao.liu$zju.edu.cn ( [10.192.76.118] ) by
 ajax-webmail-mail-app2 (Coremail) ; Tue, 26 Sep 2023 20:40:40 +0800
 (GMT+08:00)
X-Originating-IP: [10.192.76.118]
Date:   Tue, 26 Sep 2023 20:40:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     "Alexander Aring" <alex.aring@gmail.com>,
        "Stefan Schmidt" <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Harry Morris" <harrymorris12@gmail.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ieee802154: ca8210: Fix a potential UAF in
 ca8210_probe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20230926100202.011ab841@xps-13>
References: <20230926032244.11560-1-dinghao.liu@zju.edu.cn>
 <20230926100202.011ab841@xps-13>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <38f11c6a.2d287.18ad18184c8.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDHibRJ0RJldU0UAQ--.23767W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgIKBmURl6BBWgAAsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBNaXNzaW5nIENjIHN0YWJsZSwgdGhpcyBuZWVkcyB0byBiZSBiYWNrcG9ydGVkLgoKSSB3aWxs
IGNjIHN0YWJsZSAoc3RhYmxlQHZnZXIua2VybmVsLm9yZykgZm9yIHRoZSBuZXh0IHZlcnNpb24s
IHRoYW5rcyEKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9pZWVlODAyMTU0L2NhODIxMC5j
IGIvZHJpdmVycy9uZXQvaWVlZTgwMjE1NC9jYTgyMTAuYwo+ID4gaW5kZXggYWViYjE5ZjFiM2E0
Li5iMzVjNmY1OWJkMWEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC9pZWVlODAyMTU0L2Nh
ODIxMC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC9pZWVlODAyMTU0L2NhODIxMC5jCj4gPiBAQCAt
Mjc1OSw3ICsyNzU5LDYgQEAgc3RhdGljIGludCBjYTgyMTBfcmVnaXN0ZXJfZXh0X2Nsb2NrKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGkpCj4gPiAgCX0KPiA+ICAJcmV0ID0gb2ZfY2xrX2FkZF9wcm92
aWRlcihucCwgb2ZfY2xrX3NyY19zaW1wbGVfZ2V0LCBwcml2LT5jbGspOwo+ID4gIAlpZiAocmV0
KSB7Cj4gPiAtCQljbGtfdW5yZWdpc3Rlcihwcml2LT5jbGspOwo+ID4gIAkJZGV2X2NyaXQoCj4g
PiAgCQkJJnNwaS0+ZGV2LAo+ID4gIAkJCSJGYWlsZWQgdG8gcmVnaXN0ZXIgZXh0ZXJuYWwgY2xv
Y2sgYXMgY2xvY2sgcHJvdmlkZXJcbiIKPiAKPiBJIHdhcyBob3BpbmcgeW91IHdvdWxkIHNpbXBs
aWZ5IHRoaXMgZnVuY3Rpb24gYSBiaXQgbW9yZS4KCkkgdW5kZXJzdGFuZC4gSW4gdGhlIG5leHQg
cGF0Y2ggdmVyc2lvbiwgSSB3aWxsIGp1c3QgcmV0dXJuIG9mX2Nsa19hZGRfcHJvdmlkZXIoKS4g
Cgo+IAo+ID4gQEAgLTI3ODAsNyArMjc3OSw3IEBAIHN0YXRpYyB2b2lkIGNhODIxMF91bnJlZ2lz
dGVyX2V4dF9jbG9jayhzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQo+ID4gIHsKPiA+ICAJc3RydWN0
IGNhODIxMF9wcml2ICpwcml2ID0gc3BpX2dldF9kcnZkYXRhKHNwaSk7Cj4gPiAgCj4gPiAtCWlm
ICghcHJpdi0+Y2xrKQo+ID4gKwlpZiAoSVNfRVJSX09SX05VTEwocHJpdi0+Y2xrKSkKPiA+ICAJ
CXJldHVybgo+ID4gIAo+ID4gIAlvZl9jbGtfZGVsX3Byb3ZpZGVyKHNwaS0+ZGV2Lm9mX25vZGUp
Owo+IAo+IEFsZXgsIFN0ZWZhbiwgd2hvIGhhbmRsZXMgd3BhbiBhbmQgd3Bhbi9uZXh0IHRoaXMg
cmVsZWFzZT8KPgogCklzIHRoZXJlIGFueSBwcm9ibGVtIEkgbmVlZCB0byBoYW5kbGUgaW4gdGhl
IG5leHQgcGF0Y2g/CgpSZWdhcmRzLApEaW5naGFvCg==
