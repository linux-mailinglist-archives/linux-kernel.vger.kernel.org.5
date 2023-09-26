Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E437AE8FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjIZJ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjIZJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:26:34 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FA2B3;
        Tue, 26 Sep 2023 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1695720383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHBvuudP4pKRGMI+5QzAgBxLIrsXOrLJ9iqlMBxOiN0=;
        b=jlAges8dZ4ozxPdauu1jCcRu4OkV0xEo1tEkfT8fO1nQra6p2wiuwC1Rt1fTphVsuj2BiE
        HF3uytG/dHfki4JeWXGvTd/kZVM/n8Rz38K2K5Oeh/e4BgnlBgbFtiUVP3VKSeALttLR3F
        Gso31O8IU6t459yIbtPB7JiYBTnqiho=
Message-ID: <8c8a41b2740976f33c3993f609123f957f5df7de.camel@crapouillou.net>
Subject: Re: [RFT PATCH] mtd: rawnand: ingenic: move the GPIO quirk to
 gpiolib-of.c
From:   Paul Cercueil <paul@crapouillou.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-mips@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 26 Sep 2023 11:26:21 +0200
In-Reply-To: <20230926111643.58ee4587@xps-13>
References: <20230926090623.35595-1-brgl@bgdev.pl>
         <20230926111643.58ee4587@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksCgpMZSBtYXJkaSAyNiBzZXB0ZW1icmUgMjAyMyDDoCAxMToxNiArMDIwMCwgTWlxdWVsIFJh
eW5hbCBhIMOpY3JpdMKgOgo+IEhpIEJhcnRvc3osCj4gCj4gYnJnbEBiZ2Rldi5wbMKgd3JvdGUg
b24gVHVlLCAyNiBTZXAgMjAyMyAxMTowNjoyMyArMDIwMDoKPiAKPiA+IEZyb206IEJhcnRvc3og
R29sYXN6ZXdza2kgPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGluYXJvLm9yZz4KPiA+IAo+ID4gV2Ug
aGF2ZSBhIHNwZWNpYWwgcGxhY2UgZm9yIE9GIHBvbGFyaXR5IHF1aXJrcyBpbiBncGlvbGliLW9m
LmMuCj4gPiBMZXQncwo+ID4gbW92ZSB0aGlzIG92ZXIgdGhlcmUgc28gdGhhdCBpdCBkb2Vzbid0
IHBvbGx1dGUgdGhlIGRyaXZlci4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogQmFydG9zeiBHb2xh
c3pld3NraSA8YmFydG9zei5nb2xhc3pld3NraUBsaW5hcm8ub3JnPgo+ID4gLS0tCj4gPiBUaGlz
IGlzIGFuIGFsdGVybmF0aXZlIHRvIHRoZSBwcmV2aW91cyBwYXRjaCB0aGF0IGluc3RlYWQgb2YK
PiA+IHJlcGxhY2luZwo+ID4gb25lIGFjdGl2ZS1sb3cgc2V0dGVyIHdpdGggYW5vdGhlciwganVz
dCBtb3ZlcyB0aGUgcXVpcmsgb3ZlciB0bwo+ID4gZ3Bpb2xpYi1vZi5jCj4gPiAKPiA+IMKgZHJp
dmVycy9ncGlvL2dwaW9saWItb2YuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCA5ICsrKysrKysrKwo+ID4gwqBkcml2ZXJzL210ZC9uYW5kL3Jhdy9pbmdl
bmljL2luZ2VuaWNfbmFuZF9kcnYuYyB8IDEyIC0tLS0tLS0tLS0tLQo+ID4gwqAyIGZpbGVzIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi1vZi5jIGIvZHJpdmVycy9ncGlvL2dwaW9saWItb2Yu
Ywo+ID4gaW5kZXggNTUxNWYzMmNmMTliLi41OGMwYmJlOWQ1NjkgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL2dwaW8vZ3Bpb2xpYi1vZi5jCj4gPiArKysgYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi1v
Zi5jCj4gPiBAQCAtMTkyLDYgKzE5MiwxNSBAQCBzdGF0aWMgdm9pZCBvZl9ncGlvX3RyeV9maXh1
cF9wb2xhcml0eShjb25zdAo+ID4gc3RydWN0IGRldmljZV9ub2RlICpucCwKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHsgImhpbWF4LGh4ODM1NyIswqDCoMKgwqDCoMKgwqAiZ3Bpb3MtcmVzZXQiLMKgwqBm
YWxzZSB9LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB7ICJoaW1heCxoeDgz
NjkiLMKgwqDCoMKgwqDCoMKgImdwaW9zLXJlc2V0IizCoMKgZmFsc2UgfSwKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqIFRoZSByYi1ncGlvcyBzZW1hbnRpY3Mgd2FzIHVuZG9jdW1lbnRlZCBhbmQKPiA+IHFp
LGxiNjAgKGFsb25nIHdpdGgKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0
aGUgaW5nZW5pYyBkcml2ZXIpIGdvdCBpdCB3cm9uZy4gVGhlIGFjdGl2ZQo+ID4gc3RhdGUgZW5j
b2RlcyB0aGUKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBOQU5EIHJlYWR5
IHN0YXRlLCB3aGljaCBpcyBoaWdoIGxldmVsLiBTaW5jZQo+ID4gdGhlcmUncyBubyBzaWduYWwK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpbnZlcnRlciBvbiB0aGlzIGJv
YXJkLCBpdCBzaG91bGQgYmUgYWN0aXZlLQo+ID4gaGlnaC4gTGV0J3MgZml4IHRoYXQKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBoZXJlIGZvciBvbGRlciBEVHMgc28gd2Ug
Y2FuIHJlLXVzZSB0aGUgZ2VuZXJpYwo+ID4gbmFuZF9ncGlvX3dhaXRyZHkoKQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGhlbHBlciwgYW5kIGJlIGNvbnNpc3RlbnQgd2l0
aCB3aGF0IG90aGVyCj4gPiBkcml2ZXJzIGRvLgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHsgInFpLGxiNjAi
LMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJyYi1ncGlvcyIswqDCoMKgwqDCoHRydWUgfSwKPiAK
PiBJIGRpZG4ndCBrbm93IGFib3V0IHN1Y2ggYSBsaXN0LCBpbnRlcmVzdGluZy4gQmV0dGVyIGJl
IGF3YXJlIHdoZW4KPiBkZWJ1Z2dpbmcgOikKPiAKPiBJSVJDIExpbnVzIHdhcyBmaW5lLCBzbyBp
ZiBQYXVsIGFsc28gYWdyZWVzIEkgZ3Vlc3MgdGhpcyBpcyBiZXR0ZXIKPiB0YWtpbmcgdGhyb3Vn
aCB0aGUgZ3BpbyB0cmVlPyBJIGRvbid0IGhhdmUgYW55IGluZ2VuaWMgcmVsYXRlZAo+IGNoYW5n
ZXMKPiBxdWV1ZWQgcmlnaHQgbm93IHNvIGZlZWwgZnJlZSB0byB0YWtlIGl0LgoKV29ya3MgZm9y
IG1lLgoKPiAKPiBBY2tlZC1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGlu
LmNvbT4KCkFja2VkLWJ5OiBQYXVsIENlcmN1ZWlsIDxwYXVsQGNyYXBvdWlsbG91Lm5ldD4KCj4g
VGhhbmtzLAo+IE1pcXXDqGwKCkNoZWVycywKLVBhdWwK

