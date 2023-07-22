Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B075DC66
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGVMM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGVMM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:12:26 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CF4FE;
        Sat, 22 Jul 2023 05:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690027912; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BxlRx5NQZXcUCGSt+n3ej6CGzJFx+3G8tpxFmPdUgkBoJUy9iS6ACE0GZqyfbGY+SIGw8KECkqeMO1vy8pRoWmFy7EFGXSkQR25+XVzeQMX9tgEJIJIua7MLVs1DM4r/jJ/3jRHRNhRDoVlGND8GkZDOnnQx3oI7U3fXRfm9Afo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1690027912; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=el7ZrIrO9UyXzVKE3KwU/q6tYq8IYFl5e7HnxaVFfq8=; 
        b=CXqycX3sc0Hh2suMQ1WAYK8A2DPy5ProMLOFUNuRN/Vci2QaMC/zBkoxjUEy1pSjk7CZcIYruCiQSFb+r9LAMq2Mc30s/wKw1SrZ1iRWw+Atw85xvQEOTgLXvhFhPeMhxE2yTocMPurXqcqGjpujXqhOjqWc4YcmiEcOpxNxIgU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1690027912;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=el7ZrIrO9UyXzVKE3KwU/q6tYq8IYFl5e7HnxaVFfq8=;
        b=dmWYzTMEmXx/zxeZM9mpfIn6To3SpiR8DEQBPPE4qTKpqpXWqmNjB3W3qIgZAvRv
        lMKrFKReNtHqwLqTnDBN1j+/EcfHzbcVlgDnSoGqTxsUnU93x36XIZSVUSszL1txCNs
        ugfn+FkqYYCM1xxIcHEFfgSQmGSIl3jqOJVwXYXwcvw1nlIS3TXVsCPqexKk2AgM8jq
        del+lngdX863PdJGqZluwQsKwmEeES7MQtmbd+MpbTjX+wRqMMSBxO9qIuRMuDiYHRv
        LfKfQcUR1JR1+ENPob77WnZPopLqzRVS5S9ULR565yLP1V2pwCR/QszdPgPixBSSEi2
        PF03wm8Fgw==
Received: from edelgard.fodlan.icenowy.me (120.85.97.227 [120.85.97.227]) by mx.zohomail.com
        with SMTPS id 1690027909589553.9788050686577; Sat, 22 Jul 2023 05:11:49 -0700 (PDT)
Message-ID: <5a9ccb708f004e70e2102417eb48b766b03777cd.camel@icenowy.me>
Subject: Re: [PATCH] thermal/drivers/sun8i: Don't fail probe due to zone
 registration failure
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Mark Brown <broonie@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Sat, 22 Jul 2023 20:11:43 +0800
In-Reply-To: <20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org>
References: <20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjMtMDctMTjmmJ/mnJ/kuoznmoQgMTY6MDQgKzAxMDDvvIxNYXJrIEJyb3du5YaZ6YGT
77yaCj4gQ3VycmVudGx5IHRoZSBzdW44aSB0aGVybWFsIGRyaXZlciB3aWxsIGZhaWwgdG8gcHJv
YmUgaWYgYW55IG9mIHRoZQo+IHRoZXJtYWwgem9uZXMgaXQgaXMgcmVnaXN0ZXJpbmcgZmFpbHMg
dG8gcmVnaXN0ZXIgd2l0aCB0aGUgdGhlcm1hbAo+IGNvcmUuCj4gU2luY2Ugd2UgY3VycmVudGx5
IGRvIG5vdCBkZWZpbmUgYW55IHRyaXAgcG9pbnRzIGZvciB0aGUgR1BVIHRoZXJtYWwKPiB6b25l
cyBvbiBhdCBsZWFzdCBBNjQgb3IgSDUgdGhpcyBtZWFucyB0aGF0IHdlIGhhdmUgbm8gdGhlcm1h
bAo+IHN1cHBvcnQKPiBvbiB0aGVzZSBwbGF0Zm9ybXM6Cj4gCj4gW8KgwqDCoCAxLjY5ODcwM10g
dGhlcm1hbF9zeXM6IEZhaWxlZCB0byBmaW5kICd0cmlwcycgbm9kZQo+IFvCoMKgwqAgMS42OTg3
MDddIHRoZXJtYWxfc3lzOiBGYWlsZWQgdG8gZmluZCB0cmlwIHBvaW50cyBmb3IgdGhlcm1hbC0K
PiBzZW5zb3IgaWQ9MQoKSSB0aGluayB0aGlzIGlzIGFuIGlzc3VlIGluIHRoZSBjb3JlIHRoZXJt
YWwgc3Vic3lzdGVtLCBhbmQgc2VudCBhCnBhdGNoOyBVbmZvcnR1bmF0ZWx5IHRoZSBwYXRjaCBz
ZWVtcyB0byBiZSByZWplY3RlZCBieSBsaW51eC1hcm0ta2VybmVsCihhbmQgc29tZSBvdGhlciBt
YWlsaW5nIGxpc3RzKS4uLgoKSSB3aWxsIHRoZW4gcmVzZW5kIGl0IGFnYWluIGFuZCBwdXQgTWFy
ayBpbnRvIENDIGxpc3QuCgo+IAo+IGV2ZW4gdGhvdWdoIHRoZSBtYWluIENQVSB0aGVybWFsIHpv
bmUgb24gYm90aCBTb0NzIGlzIGZ1bGx5Cj4gY29uZmlndXJlZC4KPiBUaGlzIGRvZXMgbm90IHNl
ZW0gaWRlYWwsIHdoaWxlIHdlIG1heSBub3QgYmUgYWJsZSB0byB1c2UgYWxsIHRoZQo+IHpvbmVz
Cj4gaXQgc2VlbXMgYmV0dGVyIHRvIGhhdmUgdGhvc2Ugem9uZXMgd2hpY2ggYXJlIHVzYWJsZSBi
ZSBvcGVyYXRpb25hbC4KPiBJbnN0ZWFkIGp1c3QgY2Fycnkgb24gcmVnaXN0ZXJpbmcgem9uZXMg
aWYgd2UgZ2V0IGFueSBub24tZGVmZXJyYWwKPiBlcnJvciwgYWxsb3dpbmcgdXNlIG9mIHRob3Nl
IHpvbmVzIHdoaWNoIGFyZSB1c2FibGUuCj4gCj4gVGhpcyBtZWFucyB0aGF0IHdlIGFsc28gbmVl
ZCB0byB1cGRhdGUgdGhlIGludGVycnVwdCBoYW5kbGVyIHRvIG5vdAo+IGF0dGVtcHQgdG8gbm90
aWZ5IHRoZSBjb3JlIGZvciBldmVudHMgb24gem9uZXMgd2hpY2ggd2UgaGF2ZSBub3QKPiByZWdp
c3RlcmVkLCBJIGRpZG4ndCBzZWUgYW4gYWJpbGl0eSB0byBtYXNrIGluZGl2aWR1YWwgaW50ZXJy
dXB0cyBhbmQKPiBJIHdvdWxkIGV4cGVjdCB0aGF0IGludGVycnVwdHMgd291bGQgc3RpbGwgYmUg
aW5kaWNhdGVkIGluIHRoZSBJU1IKPiBldmVuCj4gaWYgdGhleSB3ZXJlIG1hc2tlZC4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+Cj4gLS0tCj4gSSBu
b3RpY2VkIHRoaXMgd2hpbGUgdHJ5aW5nIHRvIGRlYnVnIGFuIGlzc3VlIHdpdGggbWVtb3J5IGNv
cnJ1cHRpb24KPiBvbgo+IGJvb3Qgd2hpY2ggc2luY2UgdGhlIG1lcmdlIHdpbmRvdyBoYXMgcHJl
dmVudGVkIFBpbmU2NCBQbHVzIChhbiBBNjQpCj4gZnJvbSBib290aW5nIGF0IGFsbDoKPiAKPiDC
oMKgCj4gaHR0cHM6Ly9zdG9yYWdlLmtlcm5lbGNpLm9yZy9tYWlubGluZS9tYXN0ZXIvdjYuNS1y
YzIvYXJtNjQvZGVmY29uZmlnL2djYy0xMC9sYWItYmF5bGlicmUvYmFzZWxpbmUtc3VuNTBpLWE2
NC1waW5lNjQtcGx1cy50eHQKPiAKPiAod2hpY2ggSSBiaXNlY3RlZCB0byBhIHJhbmRvbSBtZW1v
cnkgbWFuYWdlbWVudCBjaGFuZ2UgdGhhdCBjbGVhcmx5Cj4gd2Fzbid0IGF0IGZhdWx0KSBhbmQg
aGFzIGJlZW4gY2F1c2luZyBsZXNzIGNvbnNpc3RlbnQgYnV0IHN0aWxsIHZlcnkKPiBzZXZlcmUg
Ym9vdCBpc3N1ZXMgb24gTGlicmV0ZWNoIFRyaXRpdW0gKGEgSDMpLsKgIFRoZSBjb3JydXB0aW9u
Cj4gYXBwZWFycwo+IHRvIGhhcHBlbiB3aGVuIHVuYmluZGluZyBhIHRoZSBvbmUgdGhlcm1hbCB6
b25lIHRoYXQgZG9lcyByZWdpc3RlciwKPiBJJ3ZlCj4gbm90IGZpZ3VyZWQgb3V0IGV4YWN0bHkg
d2hlcmUuCj4gCj4gVGhlIG1lbW9yeSBjb3JydXB0aW9uIGlzc3VlIG9idmlvdXNseSBuZWVkcyB0
byBiZSBkZWFsdCB3aXRoIHByb3Blcmx5Cj4gKEknbSBzdGlsbCBkaWdnaW5nIGludG8gaXQpIGJ1
dCB0aGlzIGRvZXMgYWxsb3cgYm90aCBwbGF0Zm9ybXMgdG8KPiBib290Cj4gcmVsaWFibHkgYW5k
IHNlZW1zIGxpa2UgYSBzZW5zaWJsZSB0aGluZyB0byBkbyBpbmRlcGVuZGVudGx5LCBpZGVhbGx5
Cj4gd2UKPiBjb3VsZCBnZXQgdGhpcyBpbiBhcyBhIGZpeC4KPiAtLS0KPiDCoGRyaXZlcnMvdGhl
cm1hbC9zdW44aV90aGVybWFsLmMgfCAxNiArKysrKysrKysrKysrKy0tCj4gwqAxIGZpbGUgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy90aGVybWFsL3N1bjhpX3RoZXJtYWwuYwo+IGIvZHJpdmVycy90aGVybWFsL3N1bjhp
X3RoZXJtYWwuYwo+IGluZGV4IDE5NWYzYzVkMGIzOC4uYjY5MTM0NTM4ODY3IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdGhlcm1hbC9zdW44aV90aGVybWFsLmMKPiArKysgYi9kcml2ZXJzL3RoZXJt
YWwvc3VuOGlfdGhlcm1hbC5jCj4gQEAgLTE5MCw2ICsxOTAsOSBAQCBzdGF0aWMgaXJxcmV0dXJu
X3Qgc3VuOGlfaXJxX3RocmVhZChpbnQgaXJxLCB2b2lkCj4gKmRhdGEpCj4gwqDCoMKgwqDCoMKg
wqDCoGludCBpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGZvcl9lYWNoX3NldF9iaXQoaSwgJmly
cV9iaXRtYXAsIHRtZGV2LT5jaGlwLT5zZW5zb3JfbnVtKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC8qIFdlIGFsbG93IHNvbWUgem9uZXMgdG8gbm90IHJlZ2lzdGVyLiAqLwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKHRtZGV2LT5zZW5zb3Jb
aV0udHpkKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGNvbnRpbnVlOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGhlcm1hbF96b25l
X2RldmljZV91cGRhdGUodG1kZXYtPnNlbnNvcltpXS50emQsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgCj4gVEhFUk1BTF9FVkVOVF9VTlNQRUNJRklFRCk7Cj4gwqDCoMKgwqDCoMKgwqDC
oH0KPiBAQCAtNDY1LDggKzQ2OCwxNyBAQCBzdGF0aWMgaW50IHN1bjhpX3Roc19yZWdpc3Rlcihz
dHJ1Y3QgdGhzX2RldmljZQo+ICp0bWRldikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAmdG1kZXYtCj4gPnNlbnNvcltpXSwKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZ0aHNfb3BzKTsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKElTX0VSUih0bWRldi0+c2Vuc29yW2ldLnR6ZCkp
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
UFRSX0VSUih0bWRldi0+c2Vuc29yW2ldLnR6ZCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJZiBhbiBp
bmRpdmlkdWFsIHpvbmUgZmFpbHMgdG8gcmVnaXN0ZXIgZm9yCj4gcmVhc29ucwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBvdGhlciB0aGFuIHByb2JlIGRlZmVycmFsIChlZywg
YSBiYWQgRFQpIHRoZW4KPiBjYXJyeQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KiBvbiwgb3RoZXIgem9uZXMgbWlnaHQgcmVnaXN0ZXIgc3VjY2Vzc2Z1bGx5Lgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKElTX0VSUih0bWRldi0+c2Vuc29yW2ldLnR6ZCkpIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChQVFJfRVJSKHRtZGV2LT5zZW5zb3Jb
aV0udHpkKSA9PSAtCj4gRVBST0JFX0RFRkVSKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBQVFJfRVJSKHRtZGV2
LT5zZW5zb3JbaV0udHpkKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGNvbnRpbnVlOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldm1fdGhlcm1hbF9hZGRfaHdt
b25fc3lzZnModG1kZXYtPmRldiwgdG1kZXYtCj4gPnNlbnNvcltpXS50emQpOwo+IMKgwqDCoMKg
wqDCoMKgwqB9Cj4gCj4gLS0tCj4gYmFzZS1jb21taXQ6IGZkZjBlYWYxMTQ1MmQ3Mjk0NWFmMzE4
MDRlMmExMDQ4ZWUxYjU3NGMKPiBjaGFuZ2UtaWQ6IDIwMjMwNzE4LXRoZXJtYWwtc3VuOGktcmVn
aXN0cmF0aW9uLWRmM2ExMzZjY2FmYQo+IAo+IEJlc3QgcmVnYXJkcywKCg==

