Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A47D5E82
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344571AbjJXWx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344502AbjJXWx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:53:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4051B10CB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:53:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9be3b66f254so707519966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698188002; x=1698792802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aAens+Ipl64zEiOYHIFXDI/wJ7R3A+fEEheNo8jpcMc=;
        b=NzEkeMaKiLmbLn9PMEF4bvMbrpKwVWYVts9Ii4dCapO/SX4TQYjt5E9pLrVHvf6ziG
         xsSck+ZHZ1bSLXob+fAzIf0fNKsreZyZjpy5PC+AzEDxCaW2nIqBzpblUnUZumJwAyy2
         d5IqPrX5agixJAcvO4bgtcsgcEj6/EzFUPa68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698188002; x=1698792802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAens+Ipl64zEiOYHIFXDI/wJ7R3A+fEEheNo8jpcMc=;
        b=k6teTwJsLmEKO78E8aUyPNIlqPBpfVWIoMAIuOfmStikzgtERHP1i/Xwwu4pi1rZ60
         CmG3WHmzVW5PxmxQlrAPygZXSAzeQXTL8v+8Dtrbj0N36cY044gOc0RDOlhpQyiLSLJY
         ZHB7rZ1mXfbi8nh3gyuXE9WNY/Kcg3nfKV0Ivc7mqbarYkHA/LHJ3xxqBId9XK1MbNyM
         nQuBPgQWYpHR49kyifVx9nTx7Fb3MmST6ajU9/Fu1w3gMHQVjog2ukaBJ2D5ulHb6MmX
         zAy1zOOThRl9a0vVj3d6jLJWr/ABIXtyoZ1Y+IfvchQKUQTeFQC5XaF/kOVTGpxhdqoz
         UU/g==
X-Gm-Message-State: AOJu0Yz8Bc4CrrTcGU9xN5gW6qbZz0Mdew5ptXIosajNtGseIzpo/dTP
        RJkXfeTnuuk3qcwFVA2xFT0jpDv/vMSYQKgbWvSOVQnQ
X-Google-Smtp-Source: AGHT+IFq/ZAY5SAhj4PSDetp6PEsMlJvavSyLzAtYm8RsbRbbhFxEurZVNylnB74RFyLhPRrmZgllg==
X-Received: by 2002:a17:907:d29:b0:9bd:f902:9a61 with SMTP id gn41-20020a1709070d2900b009bdf9029a61mr12088527ejc.18.1698188002150;
        Tue, 24 Oct 2023 15:53:22 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090660d400b009a1c05bd672sm8729816ejk.127.2023.10.24.15.53.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 15:53:21 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9be3b66f254so707517966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:53:21 -0700 (PDT)
X-Received: by 2002:a17:906:7956:b0:9be:e153:3b82 with SMTP id
 l22-20020a170906795600b009bee1533b82mr10560167ejo.17.1698188000824; Tue, 24
 Oct 2023 15:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-2-sebastian.reichel@collabora.com> <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
In-Reply-To: <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Oct 2023 12:53:03 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com>
Message-ID: <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, kernel@collabora.com
Content-Type: multipart/mixed; boundary="0000000000008d36ec06087e3461"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008d36ec06087e3461
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Oct 2023 at 09:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I would really prefer to just make our regular DIV_ROUND_UP() DTRT.  But:
>
>  - people do use it with complex first arguments (ie function calls
> etc) that we don't want to evaluate twice
>
>  - we can't make it an inline function, because the types aren't fixed
>
>  - we can't even use a statement expression and __auto_type, because
> these things are used in type definitions etc and need to be constant
> expressions

Ok. I have a potential beginning of a solution.

It is unbelievably disgustingly complicated. But it might approach
being correct.

And by that "it might approach being correct" I obviously mean "this
is untested, but builds at least some kernel code".

I'm almost certain it will fail on more complex cases, because I
already found a lot of questionable stuff that was simply hidden by
the old macro just silently doing the C arithmetic type conversions,
and this thing does type handling manually.

I'm hoping that somebody will go "Linus, you're just being
*completely* silly, it's much easier to do XYZ".

            Linus

--0000000000008d36ec06087e3461
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Introduce-complicated-non-overflowing-DIV_ROUND_UP.patch"
Content-Disposition: attachment; 
	filename="0001-Introduce-complicated-non-overflowing-DIV_ROUND_UP.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lo4x9kjn0>
X-Attachment-Id: f_lo4x9kjn0

RnJvbSA3MTJjOWVhY2RlZDViNzE3Y2JiODhkYjFkZjVlNDMwMzQyMDEyMjY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMjQgT2N0IDIwMjMgMTI6NTE6MDYgLTEwMDAKU3ViamVjdDog
W1BBVENIXSBJbnRyb2R1Y2UgKGNvbXBsaWNhdGVkKSBub24tb3ZlcmZsb3dpbmcgRElWX1JPVU5E
X1VQKCkKCkRvaW5nIGEgbm9uLW92ZXJmbG93aW5nIERJVl9ST1VORF9VUCgpIHRoYXQgaXMgdXNh
YmxlIGluIGFsbCBjb250ZXh0cyBpcwphY3R1YWxseSB2ZXJ5IG5hc3R5LgoKVGhpcyBpcyBhIHRy
aWFsIGJhbGxvb24uLiAgVGhlIHNpZ25lZCBjYXNlcyBuZWVkIG1vcmUgdGhvdWdodC4gIFRoZSBi
ZXN0Cm9wdGlvbiB3b3VsZCBiZSB0byBkaXNhbGxvdyB0aGVtIChieSBub3QgbGlzdGluZyB0aGVt
IGluIHRoZSBfR2VuZXJpYygpCnJ1bGVzKS4gQnV0IHRoZXkgY3VycmVudGx5IGhhcHBlbiwgb2Z0
ZW4gZm9yIGJhZCByZWFzb25zLCBpZSB3aXJlbGVzcyBoYXMKCglESVZfUk9VTkRfVVAoaW50ZXJ2
YWwsIE1TRUNfUEVSX1NFQyk7CgphbmQgd2hpbGUgJ2ludGVydmFsJyBpcyBhIHByb3BlciB1MzIs
IE1TRUNfUEVSX1NFQyBpcyBkZWZpbmVkIHRvIGJlCicxMDAwTCcsIHNvIHRoZSByZXN1bHRpbmcg
QyBhcml0aG1ldGljIGlzIGRvbmUgaW4gc2lnbmVkICdsb25nJy4KCldlIGFsc28gaGF2ZSB0aGlu
Z3MgbGlrZQoKCURJVl9ST1VORF9VUChtYXhfcGZuIDw8IFBBR0VfU0hJRlQsIDFVTCA8PCBUQl9T
SElGVCkKCmluIHRoZSBrYXNsciBjb2RlLCB3aGVyZSB0aGUgY29tcGlsZXIgY29tcGxhaW5zIGlm
IHdlIGV2ZXIgdGhlbiB1c2UgdGhhdAonMVVMIDw8IFRCX1NISUZUJyBhcyBhbiAnaW50JyBpbiB0
aGUgbWFjcm8gZXhwYW5zaW9uLCBzbyB0aGUKdHlwZS1zcGVjaWZpYyBtYWNyb3MgYWxsIHRha2Ug
dGhlIGRpdmlzb3IgYXMgYSAndW5zaWduZWQgbG9uZycgZXZlbiBpZgp0aGF0IG1pZ2h0IGJlIHdp
ZGVyIHRoYW4gdGhlIHRhcmdldCB0eXBlLgoKTm90LXlldC1zaWduZWQtb2ZmLWJ5OiBMaW51cyBU
b3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Ci0tLQogaW5jbHVkZS9saW51
eC9kaXZfcm91bmRfdXAuaCB8IDEwNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogaW5jbHVkZS91YXBpL2xpbnV4L2NvbnN0LmggICB8ICAgNiArLQogMiBmaWxlcyBjaGFuZ2Vk
LCAxMDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBp
bmNsdWRlL2xpbnV4L2Rpdl9yb3VuZF91cC5oCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9k
aXZfcm91bmRfdXAuaCBiL2luY2x1ZGUvbGludXgvZGl2X3JvdW5kX3VwLmgKbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi5kN2ZkMzE5YmE1YzEKLS0tIC9kZXYvbnVsbAor
KysgYi9pbmNsdWRlL2xpbnV4L2Rpdl9yb3VuZF91cC5oCkBAIC0wLDAgKzEsMTA0IEBACisjaWZu
ZGVmIF9ESVZfUk9VTkRfVVBfSAorI2RlZmluZSBfRElWX1JPVU5EX1VQX0gKKworLyoKKyAqICdE
SVZfUk9VTkRfVVAobixkKScgaXMgYW5ub3lpbmdseSBjb21wbGljYXRlZCB0byBkbywgYmVjYXVz
ZSB3aGlsZQorICogd2UndmUgaGlzdG9yaWNhbGx5IGV2YWx1YXRlZCAnZCcgbXVsdGlwbGUgdGlt
ZXMgdXNpbmcgdGhlIHNpbXBsZQorICogZXhwcmVzc2lvbgorICoKKyAqICAgICgoKG4pICsgKGQp
IC0gMSkgLyAoZCkpCisgKgorICogd2UgZG8gX25vdF8gd2FudCB0byBldmFsdWF0ZSAnbicgbXVs
dGlwbGUgdGltZXMuIEFuZCB0aGUgc2ltcGxlCisgKiBleHByZXNzaW9uIGNhbiBvdmVyZmxvdyB0
byB6ZXJvIGZvciBiaWcgdmFsdWVzIG9mICduJy4KKyAqCisgKiBBIG5vbi1vdmVyZmxvd2luZyB2
ZXJzaW9uIChieSBEYXZpZCBMYWlnaHQpIGlzCisgKgorICogICAgKCgobikgLSAxKS8oZCkgKyAx
KQorICoKKyAqIGJ1dCB0aGVyZSB0aGUgJ24tMScgd2lsbCB1bmRlcmZsb3cgd2hlbiAnbicgaXMg
emVybywgYW5kIGFkZGluZyB0aGUKKyAqIGNvbmRpdGlvbmFsIGZvciB0aGF0IHdvdWxkIHRoZW4g
ZXZhbHVhdGUgJ24nIHR3aWNlLgorICoKKyAqIEF2b2lkaW5nIHRoZSBkb3VibGUgZXZhbHVhdGlv
biB3aXRoIGEgc3RhdGVtZW50IGV4cHJlc3Npb24gdXNpbmcKKyAqCisgKiAgICAoeyBfX2F1dG9f
dHlwZSBfX24gPSAobikgLi4uLiB9KQorICoKKyAqIGxpa2Ugd2UgZG8gd2l0aCB0aGUgc2ltaWxh
cmx5IGNvbnN0cmFpbmVkICdtaW4oKScgYW5kICdtYXgoKScKKyAqIGRlZmluZXMgd291bGQgYmUg
dHJpdmlhbCwgYnV0IGNhbm5vdCBiZSB1c2VkIGluIGEgdG9wLWxldmVsCisgKiBjb250ZXh0IGxp
a2UgYSB0eXBlIGRlZmluaXRpb24sIHdoaWNoIGlzIGEgY29tbW9uIGNhc2UuCisgKgorICogRXZl
biB1c2luZyBfX2J1aWx0aW5fY2hvb3NlX2V4cHIoKSBhbmQgb25seSB1c2luZyB0aGUgc3RhdGVt
ZW50CisgKiBleHByZXNzaW9uIGZvciB0aGUgbm9uLWNvbnN0YW50IGNhc2UsIGdjYyByZWZ1c2Vz
IHRvIGV2ZW4gcGFyc2UKKyAqIHN0YXRlbWVudCBleHByZXNzaW9ucyBvdXRzaWRlIG9mIGZ1bmN0
aW9uIGNvbnRleHQ6CisgKgorICogICBlcnJvcjogYnJhY2VkLWdyb3VwIHdpdGhpbiBleHByZXNz
aW9uIGFsbG93ZWQgb25seSBpbnNpZGUgYSBmdW5jdGlvbgorICoKKyAqIFRoZSBvYnZpb3VzIHNv
bHV0aW9uIGlzIHRvIHVzZSBhbiBpbmxpbmUgZnVuY3Rpb24sIGJ1dCB0aGF0IGZhaWxzCisgKiBk
dWUgdG8gZm9yY2VkIHR5cGUgY29udmVyc2lvbi4gQW5kIHdpZGVuaW5nIHRoZSB0eXBlcyB0byB0
aGUgbWF4aW11bQorICogc2l6ZSBnZW5lcmF0ZXMgaG9ycmlmaWMgY29kZS4KKyAqCisgKiBFbmQg
cmVzdWx0OiB0aGlzIGhvcnJvci4KKyAqLworCisvKgorICogU3BsaXQgdGhlIGxvZ2ljIGludG8g
dGhlIGNvbnN0YW50IGNhc2UgKHdoaWNoIGNhbiBiZSB1c2VkIGV2ZXJ5d2hlcmUpCisgKiBhbmQg
dGhlIG5vbi1jb25zdGFudCBjYXNlIChsaW1pdGVkIHRvIGZ1bmN0aW9uIGNvbnRleHQsIGJ1dCBu
ZWVkcyB0bworICogcGFyc2UgZXZlcnl3aGVyZSkuCisgKi8KKyNkZWZpbmUgX19rZWVwX2NvbnN0
KGNvbmQsIGV4cHIpIFwKKwlfX2J1aWx0aW5fY2hvb3NlX2V4cHIoX19pc19jb25zdGV4cHIoY29u
ZCksIF9fY29uc3RfIyNleHByLCBfXyMjZXhwcikKKyNkZWZpbmUgX19LRVJORUxfRElWX1JPVU5E
X1VQKG4sIGQpIFwKKwlfX2tlZXBfY29uc3QobiwgZGl2X3JvdW5kX3VwKG4sZCkpCisKKy8qCisg
KiBUaGUgY29uc3RhbnQgY2FzZSBpcyB0cml2aWFsLCBzaW5jZSB0aGVuIHdlIGNhbiBqdXN0IHJl
LWV2YWx1YXRlIHRvCisgKiBvdXIgaGVhcnRzIGNvbnRlbnQuCisgKi8KKyNkZWZpbmUgX19jb25z
dF9kaXZfcm91bmRfdXAobixkKSAoKG4pICE9IDAgPyAoKG4pLTEpLyhkKSsxIDogMCkKKworLyoK
KyAqIFRoZSBvdGhlciBjYXNlcyBuZWVkIHRvIGJlIHNwbGl0IGJ5IHR5cGUuCisgKgorICogU2ln
bmVkIGNhc2VzIHNlZW0gYmFkbHkgZGVmaW5lZCwgYnV0IGRvIGV4aXN0LiBXZSBzaG91bGQKKyAq
IGNvbnNpZGVyIHJlbW92aW5nIHRoZW0gZnJvbSB0aGlzIF9HZW5lcmljKCksIGFuZCBmaXhpbmcg
YW55CisgKiByZXN1bHQgJ25vdCBjb21wYXRpYmxlIHdpdGggYW55IGFzc29jaWF0aW9uJyBjYXNl
cy4KKyAqLworI2RlZmluZSBfX2Rpdl9yb3VuZF91cChuLGQpIF9HZW5lcmljKChuKSsoZCksCQlc
CisJdW5zaWduZWQgbG9uZyBsb25nOiBfX2Rpdl9yb3VuZF91cF91bGwobixkKSwJXAorCWxvbmcg
bG9uZzogX19kaXZfcm91bmRfdXBfbGwobixkKSwJCVwKKwl1bnNpZ25lZCBsb25nOiBfX2Rpdl9y
b3VuZF91cF91bChuLGQpLAkJXAorCWxvbmc6IF9fZGl2X3JvdW5kX3VwX2wobixkKSwJCQlcCisJ
dW5zaWduZWQgaW50OiBfX2Rpdl9yb3VuZF91cF91KG4sZCksCQlcCisJaW50OiBfX2Rpdl9yb3Vu
ZF91cF9pKG4sZCkpCisKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBsb25nIF9fZGl2X3Jv
dW5kX3VwX3VsbCh1bnNpZ25lZCBsb25nIGxvbmcgbiwgdW5zaWduZWQgbG9uZyBkKQoreworI2lm
ZGVmIENPTkZJR18zMkJJVAorCWlmICghbikKKwkJcmV0dXJuIDAKKwlkb19kaXYobi0xLCBkKTsK
KwlyZXR1cm4gbisxOworI2Vsc2UKKwlyZXR1cm4gX19jb25zdF9kaXZfcm91bmRfdXAobixkKTsK
KyNlbmRpZgorfQorCitzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgX19kaXZfcm91bmRfdXBf
dWwodW5zaWduZWQgbG9uZyBuLCB1bnNpZ25lZCBsb25nIGQpCit7IHJldHVybiBfX2NvbnN0X2Rp
dl9yb3VuZF91cChuLGQpOyB9CisKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IF9fZGl2X3Jv
dW5kX3VwX3UodW5zaWduZWQgaW50IG4sIHVuc2lnbmVkIGxvbmcgZCkKK3sgcmV0dXJuIF9fY29u
c3RfZGl2X3JvdW5kX3VwKG4sKHVuc2lnbmVkIGludClkKTsgfQorCisvLyBWZXJ5IHF1ZXN0aW9u
YWJsZSBzaWduZWQgY2FzZXMuLi4KK3N0YXRpYyBpbmxpbmUgbG9uZyBsb25nIF9fZGl2X3JvdW5k
X3VwX2xsKGxvbmcgbG9uZyBuLCB1bnNpZ25lZCBsb25nIGQpCit7CisJaWYgKG4gPCAwKSByZXR1
cm4gMDsKKwlyZXR1cm4gX19kaXZfcm91bmRfdXBfdWxsKG4sZCk7Cit9CisKK3N0YXRpYyBpbmxp
bmUgbG9uZyBfX2Rpdl9yb3VuZF91cF9sKGxvbmcgbiwgdW5zaWduZWQgbG9uZyBkKQoreyByZXR1
cm4gX19jb25zdF9kaXZfcm91bmRfdXAobiwobG9uZylkKTsgfQorCitzdGF0aWMgaW5saW5lIGlu
dCBfX2Rpdl9yb3VuZF91cF9pKGludCBuLCB1bnNpZ25lZCBsb25nIGQpCit7IHJldHVybiBfX2Nv
bnN0X2Rpdl9yb3VuZF91cChuLChpbnQpZCk7IH0KKworI2VuZGlmCmRpZmYgLS1naXQgYS9pbmNs
dWRlL3VhcGkvbGludXgvY29uc3QuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9jb25zdC5oCmluZGV4
IGE0MjkzODFlN2NhNS4uOGVmYTFkNzdjNDE0IDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGlu
dXgvY29uc3QuaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgvY29uc3QuaApAQCAtMjAsNiArMjAs
MTAgQEAKICNkZWZpbmUgX19BQyhYLFkpCShYIyNZKQogI2RlZmluZSBfQUMoWCxZKQlfX0FDKFgs
WSkKICNkZWZpbmUgX0FUKFQsWCkJKChUKShYKSkKKworLyogT2RkIGhpc3RvcmljYWwgcGxhY2Vt
ZW50ICovCisjaW5jbHVkZSA8bGludXgvZGl2X3JvdW5kX3VwLmg+CisKICNlbmRpZgogCiAjZGVm
aW5lIF9VTCh4KQkJKF9BQyh4LCBVTCkpCkBAIC0zMSw2ICszNSw0IEBACiAjZGVmaW5lIF9fQUxJ
R05fS0VSTkVMKHgsIGEpCQlfX0FMSUdOX0tFUk5FTF9NQVNLKHgsIChfX3R5cGVvZl9fKHgpKShh
KSAtIDEpCiAjZGVmaW5lIF9fQUxJR05fS0VSTkVMX01BU0soeCwgbWFzaykJKCgoeCkgKyAobWFz
aykpICYgfihtYXNrKSkKIAotI2RlZmluZSBfX0tFUk5FTF9ESVZfUk9VTkRfVVAobiwgZCkgKCgo
bikgKyAoZCkgLSAxKSAvIChkKSkKLQogI2VuZGlmIC8qIF9VQVBJX0xJTlVYX0NPTlNUX0ggKi8K
LS0gCjIuNDIuMC4zOTguZ2E5ZWNkYTI3ODgKCg==
--0000000000008d36ec06087e3461--
