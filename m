Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82976A755
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjHADLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHADLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:11:16 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8CB19B0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1690859472;
        bh=o5T+kQNuX4fm5oyHji4BaVyoYdYzeQvuWfMgaOEgsDI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EWqvVrxikyW8hDHE1M0bLV4dBqFku6M5JFxdkgExjh7V77P1QoTCtCX4zWjjg73Pr
         6Bp+lbzY4tT9Q4m9YpVlcv/1q7amCHf9BsrXXPUMZR6CRtZcQbjidfOm1Jwl7QVazx
         AIsGZtocu/lItXMvJR45uPjQSeJ6NCp+9S7w3jkE=
Received: from [IPv6:240e:358:11f9:8b00:dc73:854d:832e:3] (unknown [IPv6:240e:358:11f9:8b00:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 75EA46599C;
        Mon, 31 Jul 2023 23:11:02 -0400 (EDT)
Message-ID: <8573346a40ff1490cdc15d5e11d982a06e98d3bb.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Fixup cmpxchg sematic for memory barrier
From:   Xi Ruoyao <xry111@xry111.site>
To:     guoren@kernel.org, chenhuacai@kernel.or, kernel@xen0n.name,
        arnd@arndb.de, andi.shyti@linux.intel.com, wangrui@loongson.cn,
        andrzej.hajda@intel.com, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Date:   Tue, 01 Aug 2023 11:10:55 +0800
In-Reply-To: <20230801011554.3950435-1-guoren@kernel.org>
References: <20230801011554.3950435-1-guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTMxIGF0IDIxOjE1IC0wNDAwLCBndW9yZW5Aa2VybmVsLm9yZyB3cm90
ZToKPiBGcm9tOiBHdW8gUmVuIDxndW9yZW5AbGludXguYWxpYmFiYS5jb20+Cj4gCj4gV2hlbiBj
bXB4Y2hnIGZhaWxlZCwgbm8gbWVtb3J5IGJhcnJpZXIgd2FzIG5lZWRlZCB0byB0YWtlLiBPbmx5
Cj4gd2hlbiBjbXB4Y2hnIHN1Y2Nlc3MgYW5kIHRoZSBuZXcgdmFsdWUgaXMgd3JpdHRlbiwgdGhl
biB0aGUgbWVtb3J5Cj4gYmFycmllcnMgbmVlZGVkLgo+IAo+IMKgLSBjbXB4Y2hnX2FzbTrCoMKg
IFVubmVjZXNzYXJ5IF9fV0VBS19MTFNDX1dCIGZvciB0aGUgZmFpbCBwYXRoIHdvdWxkCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWR1Y2UgdGhlIHBlcmZvcm1hbmNlIG9m
IHRoZSBjbXB4Y2hnIGxvb3AgdHJ5aW5nLgoKSSdtIG5vdCBhbiBleHBlcnQgaW4gbWVtb3J5IG1v
ZGVscywgYnV0IGluIHByYWN0aWNlIHRoaXMgYmFycmllciBpcwpyZWFsbHkgbmVlZGVkIG9yIGNt
cHhjaGcgd2lsbCBiZSAibm90IGF0b21pYyIuICBTZWUKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtbWlwcy8xZDQ5ZGExMS01MWQ1LWUxNDgtY2IwMi05YmQwZWU1N2ZhZTZAZmx5Z29hdC5j
b20vLgoKPiDCoC0gY21weGNoZ19zbWFsbDogTWlzcyBhbiBuZWNlc3NhcnkgX19XRUFLX0xMU0Nf
V0Igd2hlbiBzYyBzdWNjZWVkcy4KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEl0J3MgYSBidWcgYmVjYXVzZSB0aGVyZSBpcyBubyBtZW1vcnkgc3luY2hyb25pemF0aW9uCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3aGVuIHNjIHN1Y2NlZWRzLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IEd1byBSZW4gPGd1b3JlbkBsaW51eC5hbGliYWJhLmNvbT4KPiBTaWdu
ZWQtb2ZmLWJ5OiBHdW8gUmVuIDxndW9yZW5Aa2VybmVsLm9yZz4KPiAtLS0KPiDCoGFyY2gvbG9v
bmdhcmNoL2luY2x1ZGUvYXNtL2NtcHhjaGcuaCB8IDYgKystLS0tCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNo
L2xvb25nYXJjaC9pbmNsdWRlL2FzbS9jbXB4Y2hnLmggYi9hcmNoL2xvb25nYXJjaC9pbmNsdWRl
L2FzbS9jbXB4Y2hnLmgKPiBpbmRleCA5NzlmZGU2MWJiYTguLjZhMDViOTI4MTRiNiAxMDA2NDQK
PiAtLS0gYS9hcmNoL2xvb25nYXJjaC9pbmNsdWRlL2FzbS9jbXB4Y2hnLmgKPiArKysgYi9hcmNo
L2xvb25nYXJjaC9pbmNsdWRlL2FzbS9jbXB4Y2hnLmgKPiBAQCAtMTAyLDggKzEwMiw4IEBAIF9f
YXJjaF94Y2hnKHZvbGF0aWxlIHZvaWQgKnB0ciwgdW5zaWduZWQgbG9uZyB4LCBpbnQgc2l6ZSkK
PiDCoMKgwqDCoMKgwqDCoMKgIsKgwqDCoMKgwqDCoMKgbW92ZcKgwqDCoMKgJHQwLCAlejTCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcbiLCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoFwKPiDCoMKgwqDCoMKgwqDCoMKgIsKgwqDCoMKgwqDCoMKgIiBzdCAi
wqDCoCR0MCwgJTHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoFxuIsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+IMKgwqDCoMKgwqDCoMKgwqAiwqDC
oMKgwqDCoMKgwqBiZXF6wqDCoMKgwqAkdDAsIDFiwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcbiLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwKPiAt
wqDCoMKgwqDCoMKgwqAiMjrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcbiLCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwKPiDCoMKgwqDCoMKgwqDCoMKgX19XRUFLX0xMU0NfTULC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+ICvCoMKgwqDCoMKg
wqDCoCIyOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFxuIsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgXAo+IMKgwqDCoMKgwqDCoMKgwqA6ICI9JnIiIChfX3JldCksICI9WkIiKCpt
KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBcCj4gwqDCoMKgwqDCoMKgwqDCoDogIlpCIigqbSksICJKciIg
KG9sZCksICJKciIgKG5ldynCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBcCj4gwqDCoMKgwqDCoMKgwqDCoDogInQwIiwgIm1lbW9yeSIp
O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+IEBAIC0xNDgsMTAgKzE0OCw4
IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IF9fY21weGNoZ19zbWFsbCh2b2xhdGlsZSB2
b2lkICpwdHIsIHVuc2lnbmVkIGludCBvbGQsCj4gwqDCoMKgwqDCoMKgwqDCoCLCoMKgwqDCoMKg
wqDCoG9ywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCUxLCAlMSwgJXo2wqDCoMKgwqDCoFxu
Igo+IMKgwqDCoMKgwqDCoMKgwqAiwqDCoMKgwqDCoMKgwqBzYy53wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgJTEsICUywqDCoMKgwqDCoMKgwqDCoMKgwqBcbiIKPiDCoMKgwqDCoMKgwqDCoMKgIsKg
wqDCoMKgwqDCoMKgYmVxesKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCUxLCAxYsKgwqDCoMKgwqDC
oMKgwqDCoMKgXG4iCj4gLcKgwqDCoMKgwqDCoMKgIsKgwqDCoMKgwqDCoMKgYsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoDNmwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFxuIgo+IC3C
oMKgwqDCoMKgwqDCoCIyOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXG4iCj4gwqDCoMKgwqDCoMKgwqDCoF9f
V0VBS19MTFNDX01CCj4gLcKgwqDCoMKgwqDCoMKgIjM6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcbiIKPiAr
wqDCoMKgwqDCoMKgwqAiMjrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFxuIgo+IMKgwqDCoMKgwqDCoMKgwqA6
ICI9JnIiIChvbGQzMiksICI9JnIiICh0ZW1wKSwgIj1aQyIgKCpwdHIzMikKPiDCoMKgwqDCoMKg
wqDCoMKgOiAiWkMiICgqcHRyMzIpLCAiSnIiIChtYXNrKSwgIkpyIiAob2xkKSwgIkpyIiAobmV3
KQo+IMKgwqDCoMKgwqDCoMKgwqA6ICJtZW1vcnkiKTsKCi0tIApYaSBSdW95YW8gPHhyeTExMUB4
cnkxMTEuc2l0ZT4KU2Nob29sIG9mIEFlcm9zcGFjZSBTY2llbmNlIGFuZCBUZWNobm9sb2d5LCBY
aWRpYW4gVW5pdmVyc2l0eQo=

