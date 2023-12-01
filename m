Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7866A80062C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377910AbjLAIti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377916AbjLAItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:49:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0698F12A;
        Fri,  1 Dec 2023 00:49:42 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so17710665e9.3;
        Fri, 01 Dec 2023 00:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701420580; x=1702025380; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7alrT3VKpjqc/zejMMdUv/TgzBqcFS97MJedFjkKsQ=;
        b=Jpm8NPkzQRn6//lsEwPYBRhYlMjJO+L+4aV+VgCnaA7rq8xM9vVPez1pJjTstfC8eX
         Ke11jwLLRmuMQA5YShw8E1qIdLzj/iTxK4g0n8WgCr/shJbgK/7vXuPfU82WcNq1MZac
         zu7H72yar3Y2de5ZEh3sUyERKp7qPXPy7ikKtJ9l9GYsXeltLWHMVbUigeRK4qK/Z+Ti
         1vX6WN2B3vnD2nqJCiqQVimMPlOIblDyPkis59FzJdTjyJGb0TbOLt3XQPUV7df0s105
         ooZhTTgaXLH4Y1BxXfB1sIG63znhgiwrocd7zWu+khlVvxdHr9NaHIG5DkmW2EyXakay
         OXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701420580; x=1702025380;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7alrT3VKpjqc/zejMMdUv/TgzBqcFS97MJedFjkKsQ=;
        b=ksRYEKV5ksqLv0tlnwE0LD9MVP5WLmhPNfY+K7VATB+5k38YcwxqYzpaMghiZ3WpO8
         iwfiUfSxKOKZ/tmJRUXYXChauM15vWANuP12qbKsK28/DWvbcYKJ6czKD96pE5rUe/O6
         d5vXIeFPEI5wuD4bSILt5gcuMznd1eC0IDudAoifncgqvlzLd8mcbHdQBlM7TW6zqi1L
         BnnV0eK9WVJqQ4iMdgyi6kn+lq3BWApKgldH4lwlNMTswwoXV/cDzXgX2jbP4OoZSXqd
         lZAx7EQisitN4hWoTGMNTpxj1VYpXWUVivVt6pYZq/dhKeNoWCHAuLj9xlXyZlpxFuiG
         nPag==
X-Gm-Message-State: AOJu0YzYr1wxc4iU1kG4yBuWjMLe0U607MT9BHiHMecvIYJ217BQjjNB
        zt4IfWPP87UtzQbyc+7ObX0=
X-Google-Smtp-Source: AGHT+IH/tuZL4u4bQIviWnSuiOYowHBnNQAqUDTqevBXYxWKwR4Q4BeWiLBBdeifY/7JAHzUd1uS7w==
X-Received: by 2002:a7b:c855:0:b0:40b:5e21:e284 with SMTP id c21-20020a7bc855000000b0040b5e21e284mr270594wml.113.1701420580099;
        Fri, 01 Dec 2023 00:49:40 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id fa10-20020a05600c518a00b00405442edc69sm8298549wmb.14.2023.12.01.00.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:49:39 -0800 (PST)
Message-ID: <2343dacb0ec0a4878c8e41748ed6e586ff53ccd4.camel@gmail.com>
Subject: Re: [PATCH 06/12] iio: adc: ad9467: add mutex to struct ad9467_state
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Fri, 01 Dec 2023 09:49:38 +0100
In-Reply-To: <CAMknhBHsFS5p-_250WRmkH2za+QPV6WyKNfgD-E1W8=HV3W3fg@mail.gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
         <CAMknhBHsFS5p-_250WRmkH2za+QPV6WyKNfgD-E1W8=HV3W3fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTMwIGF0IDE1OjUwIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+
IE9uIFR1ZSwgTm92IDIxLCAyMDIzIGF0IDQ6MTfigK9BTSBOdW5vIFNhIHZpYSBCNCBSZWxheQo+
IDxkZXZudWxsK251bm8uc2EuYW5hbG9nLmNvbUBrZXJuZWwub3JnPiB3cm90ZToKPiA+IAo+ID4g
RnJvbTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPgo+ID4gCj4gPiBXaGVuIGNhbGxpbmcg
YWQ5NDY3X3NldF9zY2FsZSgpLCBtdWx0aXBsZSBjYWxscyB0byBhZDk0Njdfc3BpX3dyaXRlKCkK
PiA+IGFyZSBkb25lIHdoaWNoIG1lYW5zIHdlIG5lZWQgdG8gcHJvcGVybHkgcHJvdGVjdCB0aGUg
d2hvbGUgb3BlcmF0aW9uIHNvCj4gPiB3ZSBhcmUgc3VyZSB3ZSB3aWxsIGJlIGluIGEgc2FuZSBz
dGF0ZSBpZiB0d28gY29uY3VycmVudCBjYWxscyBvY2N1ci4KPiA+IAo+ID4gRml4ZXM6IGFkNjc5
NzEyMDIzOCAoImlpbzogYWRjOiBhZDk0Njc6IGFkZCBzdXBwb3J0IEFEOTQ2NyBBREMiKQo+ID4g
U2lnbmVkLW9mZi1ieTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPgo+ID4gLS0tCj4gPiDC
oGRyaXZlcnMvaWlvL2FkYy9hZDk0NjcuYyB8IDYgKysrKystCj4gPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2FkYy9hZDk0NjcuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDk0NjcuYwo+ID4gaW5k
ZXggMDQ0NzRkYmZhNjMxLi45MTgyMWRlZTAzYjcgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2lp
by9hZGMvYWQ5NDY3LmMKPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDk0NjcuYwo+ID4gQEAg
LTQsNyArNCw3IEBACj4gPiDCoCAqCj4gPiDCoCAqIENvcHlyaWdodCAyMDEyLTIwMjAgQW5hbG9n
IERldmljZXMgSW5jLgo+ID4gwqAgKi8KPiA+IC0KPiA+ICsjaW5jbHVkZSA8bGludXgvY2xlYW51
cC5oPgo+ID4gwqAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4gPiDCoCNpbmNsdWRlIDxsaW51
eC9tdXRleC5oPgo+IAo+IEFoLCB0aGUgY2FzZSBvZiB0aGUgbWlzcGxhY2VkIGhlYWRlciBmcm9t
IHRoZSBwcmV2aW91cyBwYXRjaCBpcyBzb2x2ZWQuIDotKQo+IAoKWWVwcywgaXQgbmVlZHMgdG8g
YmUgaW4gdGhpcyBwYXRjaCA6KQoKPiA+IMKgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgo+ID4g
QEAgLTEyMiw2ICsxMjIsOCBAQCBzdHJ1Y3QgYWQ5NDY3X3N0YXRlIHsKPiA+IMKgwqDCoMKgwqDC
oMKgIHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG91
dHB1dF9tb2RlOwo+ID4gCj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZ3Bpb19kZXNjwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICpwd3Jkb3duX2dwaW87Cj4gPiArwqDCoMKgwqDCoMKg
IC8qIHByb3RlY3QgYWdhaW5zdCBjb25jdXJyZW50IGFjY2Vzc2VzIHRvIHRoZSBkZXZpY2UgKi8K
PiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IG11dGV4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbG9jazsKPiA+IMKgfTsKPiA+IAo+ID4gwqBzdGF0aWMgaW50IGFkOTQ2N19z
cGlfcmVhZChzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCB1bnNpZ25lZCBpbnQgcmVnKQo+ID4gQEAg
LTE2Miw2ICsxNjQsNyBAQCBzdGF0aWMgaW50IGFkOTQ2N19yZWdfYWNjZXNzKHN0cnVjdCBhZGlf
YXhpX2FkY19jb252ICpjb252LAo+ID4gdW5zaWduZWQgaW50IHJlZywKPiA+IMKgwqDCoMKgwqDC
oMKgIGludCByZXQ7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIGlmICghcmVhZHZhbCkgewo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ3VhcmQobXV0ZXgpKCZzdC0+bG9jayk7Cj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gYWQ5NDY3X3NwaV93cml0ZShz
cGksIHJlZywgd3JpdGV2YWwpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChyZXQpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiByZXQ7Cj4gPiBAQCAtMzEwLDYgKzMxMyw3IEBAIHN0YXRpYyBpbnQgYWQ5NDY3X3Nl
dF9zY2FsZShzdHJ1Y3QgYWRpX2F4aV9hZGNfY29udiAqY29udiwKPiA+IGludCB2YWwsIGludCB2
YWwyKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChzY2FsZV92YWxbMF0g
IT0gdmFsIHx8IHNjYWxlX3ZhbFsxXSAhPSB2YWwyKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPiA+IAo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZ3VhcmQobXV0ZXgpKCZzdC0+bG9jayk7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gYWQ5NDY3X3NwaV93cml0ZShzdC0+c3BpLCBBTjg3
N19BRENfUkVHX1ZSRUYsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8tPnNjYWxlX3RhYmxl
W2ldWzFdKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkK
PiA+IAo+ID4gLS0KPiA+IDIuNDIuMQo+ID4gCj4gPiAKPiAKPiBBbHRlcm5hdGVseSwgdGhpcyBj
b3VsZCBwcm9iYWJseSBiZSBzb2x2ZWQgd2l0aCBzcGlfYnVzX2xvY2svdW5sb2NrCj4gYW5kIHNw
aV9zeW5jX2xvY2tlZCByYXRoZXIgdGhhbiBpbnRyb2R1Y2luZyBhIG5ldyBtdXRleC4KCkhtbSwg
dHlwaWNhbGx5IHlvdSBqdXN0IGhhdmUgeW91ciBvd24gbG9jay4gTm8gcmVhc29uIHRvIGxvY2sg
dGhlIHNwaSBidXMuIEFuZCBJIGFsc28KaGF2ZSBzb21lIHBsYW5zIHRvIGV2ZW50dWFsbHkgY2hh
bmdlIHRoaXMgdG8gcmVnbWFwIDopCgotIE51bm8gU8OhCgo=

