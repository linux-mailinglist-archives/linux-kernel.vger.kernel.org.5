Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7D5785073
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjHWGPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjHWGP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:15:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A69E7D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:15:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8D221F38A;
        Wed, 23 Aug 2023 06:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692771300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=XX0SFi0xAKsABvy9DKR2kuVvokpN2st0DbYsF+zBs4g=;
        b=HxFOIXZhJv400/U2a4/aYilt9YwRNsVziKoouDLwz0hSJabV8a+u1RcGu/Fdkjgc+pUz7m
        b+I8jsruUnLjB6ry8tPQRRKMU4GPbpJHzBgygToYF4ijOaRRCt8zzTPWk8luOVI/bpSu2G
        hEzAtYWIdlMCfXd42gRB7Pn0QE9Q3PU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE92B13458;
        Wed, 23 Aug 2023 06:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EE+YK+Sj5WTlHwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 23 Aug 2023 06:15:00 +0000
Message-ID: <626874c3-cdd6-4547-87d7-710320c4e23f@suse.com>
Date:   Wed, 23 Aug 2023 08:15:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/xenbus: Avoid a lockdep warning when adding a watch
Content-Language: en-US
To:     Petr Pavlu <petr.pavlu@suse.com>, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20230607123624.15739-1-petr.pavlu@suse.com>
From:   Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20230607123624.15739-1-petr.pavlu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dXh4gafvuiQmFtCEUo0Ovfbq"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dXh4gafvuiQmFtCEUo0Ovfbq
Content-Type: multipart/mixed; boundary="------------42ZRJ49UHDDY0uYFOcH0jiv9";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <626874c3-cdd6-4547-87d7-710320c4e23f@suse.com>
Subject: Re: [PATCH] xen/xenbus: Avoid a lockdep warning when adding a watch
References: <20230607123624.15739-1-petr.pavlu@suse.com>
In-Reply-To: <20230607123624.15739-1-petr.pavlu@suse.com>

--------------42ZRJ49UHDDY0uYFOcH0jiv9
Content-Type: multipart/mixed; boundary="------------yzuoFKRHnC0S0MoXwIsE14h9"

--------------yzuoFKRHnC0S0MoXwIsE14h9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDYuMjMgMTQ6MzYsIFBldHIgUGF2bHUgd3JvdGU6DQo+IFRoZSBmb2xsb3dpbmcg
bG9ja2RlcCB3YXJuaW5nIGFwcGVhcnMgZHVyaW5nIGJvb3Qgb24gYSBYZW4gZG9tMCBzeXN0
ZW06DQo+IA0KPiBbICAgOTYuMzg4Nzk0XSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gWyAgIDk2LjM4ODc5N10gV0FSTklORzog
cG9zc2libGUgY2lyY3VsYXIgbG9ja2luZyBkZXBlbmRlbmN5IGRldGVjdGVkDQo+IFsgICA5
Ni4zODg3OTldIDYuNC4wLXJjNS1kZWZhdWx0KyAjOCBUYWludGVkOiBHICAgICAgICAgICAg
RUwNCj4gWyAgIDk2LjM4ODgwM10gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFsgICA5Ni4zODg4MDRdIHhlbmNvbnNvbGVkLzEz
MzAgaXMgdHJ5aW5nIHRvIGFjcXVpcmUgbG9jazoNCj4gWyAgIDk2LjM4ODgwOF0gZmZmZmZm
ZmY4MmFjZGQxMCAoeHNfd2F0Y2hfcndzZW0peysrKyt9LXszOjN9LCBhdDogcmVnaXN0ZXJf
eGVuYnVzX3dhdGNoKzB4NDUvMHgxNDANCj4gWyAgIDk2LjM4ODg0N10NCj4gICAgICAgICAg
ICAgICAgIGJ1dCB0YXNrIGlzIGFscmVhZHkgaG9sZGluZyBsb2NrOg0KPiBbICAgOTYuMzg4
ODQ5XSBmZmZmODg4MTAwYzkyMDY4ICgmdS0+bXNnYnVmZmVyX211dGV4KXsrLisufS17Mzoz
fSwgYXQ6IHhlbmJ1c19maWxlX3dyaXRlKzB4MmMvMHg2MDANCj4gWyAgIDk2LjM4ODg2Ml0N
Cj4gICAgICAgICAgICAgICAgIHdoaWNoIGxvY2sgYWxyZWFkeSBkZXBlbmRzIG9uIHRoZSBu
ZXcgbG9jay4NCj4gDQo+IFsgICA5Ni4zODg4NjRdDQo+ICAgICAgICAgICAgICAgICB0aGUg
ZXhpc3RpbmcgZGVwZW5kZW5jeSBjaGFpbiAoaW4gcmV2ZXJzZSBvcmRlcikgaXM6DQo+IFsg
ICA5Ni4zODg4NjZdDQo+ICAgICAgICAgICAgICAgICAtPiAjMiAoJnUtPm1zZ2J1ZmZlcl9t
dXRleCl7Ky4rLn0tezM6M306DQo+IFsgICA5Ni4zODg4NzRdICAgICAgICBfX211dGV4X2xv
Y2srMHg4NS8weGIzMA0KPiBbICAgOTYuMzg4ODg1XSAgICAgICAgeGVuYnVzX2Rldl9xdWV1
ZV9yZXBseSsweDQ4LzB4MmIwDQo+IFsgICA5Ni4zODg4OTBdICAgICAgICB4ZW5idXNfdGhy
ZWFkKzB4MWQ3LzB4OTUwDQo+IFsgICA5Ni4zODg4OTddICAgICAgICBrdGhyZWFkKzB4ZTcv
MHgxMjANCj4gWyAgIDk2LjM4ODkwNV0gICAgICAgIHJldF9mcm9tX2ZvcmsrMHgyYy8weDUw
DQo+IFsgICA5Ni4zODg5MTRdDQo+ICAgICAgICAgICAgICAgICAtPiAjMSAoeHNfcmVzcG9u
c2VfbXV0ZXgpeysuKy59LXszOjN9Og0KPiBbICAgOTYuMzg4OTIzXSAgICAgICAgX19tdXRl
eF9sb2NrKzB4ODUvMHhiMzANCj4gWyAgIDk2LjM4ODkzMF0gICAgICAgIHhlbmJ1c19iYWNr
ZW5kX2lvY3RsKzB4NTYvMHgxYzANCj4gWyAgIDk2LjM4ODkzNV0gICAgICAgIF9feDY0X3N5
c19pb2N0bCsweDkwLzB4ZDANCj4gWyAgIDk2LjM4ODk0Ml0gICAgICAgIGRvX3N5c2NhbGxf
NjQrMHg1Yy8weDkwDQo+IFsgICA5Ni4zODg5NTBdICAgICAgICBlbnRyeV9TWVNDQUxMXzY0
X2FmdGVyX2h3ZnJhbWUrMHg3Mi8weGRjDQo+IFsgICA5Ni4zODg5NTddDQo+ICAgICAgICAg
ICAgICAgICAtPiAjMCAoeHNfd2F0Y2hfcndzZW0peysrKyt9LXszOjN9Og0KPiBbICAgOTYu
Mzg4OTY1XSAgICAgICAgX19sb2NrX2FjcXVpcmUrMHgxNTM4LzB4MjI2MA0KPiBbICAgOTYu
Mzg4OTcyXSAgICAgICAgbG9ja19hY3F1aXJlKzB4YzYvMHgyYjANCj4gWyAgIDk2LjM4ODk3
Nl0gICAgICAgIGRvd25fcmVhZCsweDJkLzB4MTYwDQo+IFsgICA5Ni4zODg5ODNdICAgICAg
ICByZWdpc3Rlcl94ZW5idXNfd2F0Y2grMHg0NS8weDE0MA0KPiBbICAgOTYuMzg4OTkwXSAg
ICAgICAgeGVuYnVzX2ZpbGVfd3JpdGUrMHg1M2QvMHg2MDANCj4gWyAgIDk2LjM4ODk5NF0g
ICAgICAgIHZmc193cml0ZSsweGU0LzB4NDkwDQo+IFsgICA5Ni4zODkwMDNdICAgICAgICBr
c3lzX3dyaXRlKzB4YjgvMHhmMA0KPiBbICAgOTYuMzg5MDExXSAgICAgICAgZG9fc3lzY2Fs
bF82NCsweDVjLzB4OTANCj4gWyAgIDk2LjM4OTAxN10gICAgICAgIGVudHJ5X1NZU0NBTExf
NjRfYWZ0ZXJfaHdmcmFtZSsweDcyLzB4ZGMNCj4gWyAgIDk2LjM4OTAyM10NCj4gICAgICAg
ICAgICAgICAgIG90aGVyIGluZm8gdGhhdCBtaWdodCBoZWxwIHVzIGRlYnVnIHRoaXM6DQo+
IA0KPiBbICAgOTYuMzg5MDI1XSBDaGFpbiBleGlzdHMgb2Y6DQo+ICAgICAgICAgICAgICAg
ICAgIHhzX3dhdGNoX3J3c2VtIC0tPiB4c19yZXNwb25zZV9tdXRleCAtLT4gJnUtPm1zZ2J1
ZmZlcl9tdXRleA0KPiANCj4gWyAgIDk2LjQxMzQyOV0gIFBvc3NpYmxlIHVuc2FmZSBsb2Nr
aW5nIHNjZW5hcmlvOg0KPiANCj4gWyAgIDk2LjQxMzQzMF0gICAgICAgIENQVTAgICAgICAg
ICAgICAgICAgICAgIENQVTENCj4gWyAgIDk2LjQxMzQzMF0gICAgICAgIC0tLS0gICAgICAg
ICAgICAgICAgICAgIC0tLS0NCj4gWyAgIDk2LjQxMzQzMV0gICBsb2NrKCZ1LT5tc2didWZm
ZXJfbXV0ZXgpOw0KPiBbICAgOTYuNDEzNDMyXSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbG9jayh4c19yZXNwb25zZV9tdXRleCk7DQo+IFsgICA5Ni40MTM0MzNdICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBsb2NrKCZ1LT5tc2didWZmZXJfbXV0ZXgpOw0K
PiBbICAgOTYuNDEzNDM0XSAgIHJsb2NrKHhzX3dhdGNoX3J3c2VtKTsNCj4gWyAgIDk2LjQx
MzQzNl0NCj4gICAgICAgICAgICAgICAgICAqKiogREVBRExPQ0sgKioqDQo+IA0KPiBbICAg
OTYuNDEzNDM2XSAxIGxvY2sgaGVsZCBieSB4ZW5jb25zb2xlZC8xMzMwOg0KPiBbICAgOTYu
NDEzNDM4XSAgIzA6IGZmZmY4ODgxMDBjOTIwNjggKCZ1LT5tc2didWZmZXJfbXV0ZXgpeysu
Ky59LXszOjN9LCBhdDogeGVuYnVzX2ZpbGVfd3JpdGUrMHgyYy8weDYwMA0KPiBbICAgOTYu
NDEzNDQ2XQ0KPiANCj4gQW4gaW9jdGwgY2FsbCBJT0NUTF9YRU5CVVNfQkFDS0VORF9TRVRV
UCAocmVjb3JkICMxIGluIHRoZSByZXBvcnQpDQo+IHJlc3VsdHMgaW4gY2FsbGluZyB4ZW5i
dXNfYWxsb2MoKSAtPiB4c19zdXNwZW5kKCkgd2hpY2ggaW50cm9kdWNlcw0KPiBvcmRlcmlu
ZyB4c193YXRjaF9yd3NlbSAtLT4geHNfcmVzcG9uc2VfbXV0ZXguIFRoZSB4ZW5idXNfdGhy
ZWFkKCkNCj4gb3BlcmF0aW9uIChyZWNvcmQgIzIpIGNyZWF0ZXMgeHNfcmVzcG9uc2VfbXV0
ZXggLS0+ICZ1LT5tc2didWZmZXJfbXV0ZXguDQo+IEFuIFhTX1dBVENIIHdyaXRlIHRvIHRo
ZSB4ZW5idXMgZmlsZSB0aGVuIHJlc3VsdHMgaW4gYSBjb21wbGFpbiBhYm91dA0KPiB0aGUg
b3Bwb3NpdGUgbG9jayBvcmRlciAmdS0+bXNnYnVmZmVyX211dGV4IC0tPiB4c193YXRjaF9y
d3NlbS4NCj4gDQo+IFRoZSBkZXBlbmRlbmN5IHhzX3dhdGNoX3J3c2VtIC0tPiB4c19yZXNw
b25zZV9tdXRleCBpcyBzcHVyaW91cy4gQXZvaWQNCj4gaXQgYW5kIHRoZSB3YXJuaW5nIGJ5
IGNoYW5naW5nIHRoZSBvcmRlcmluZyBpbiB4c19zdXNwZW5kKCksIGZpcnN0DQo+IGFjcXVp
cmUgeHNfcmVzcG9uc2VfbXV0ZXggYW5kIHRoZW4geHNfd2F0Y2hfcndzZW0uIFJldmVyc2Ug
YWxzbyB0aGUNCj4gdW5sb2NraW5nIG9yZGVyIGluIHhzX3N1c3BlbmRfY2FuY2VsKCkgZm9y
IGNvbnNpc3RlbmN5LCBidXQga2VlcA0KPiB4c19yZXN1bWUoKSBhcyBpcyBiZWNhdXNlIGl0
IG5lZWRzIHRvIGhhdmUgeHNfd2F0Y2hfcndzZW0gdW5sb2NrZWQgb25seQ0KPiBhZnRlciBl
eGl0aW5nIHhzIHN1c3BlbmQgYW5kIHJlLWFkZGluZyBhbGwgd2F0Y2hlcy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFBldHIgUGF2bHUgPHBldHIucGF2bHVAc3VzZS5jb20+DQoNClB1c2hl
ZCB0byB4ZW4vdGlwLmdpdCBmb3ItbGludXMtNi42DQoNCg0KSnVlcmdlbg0KDQo=
--------------yzuoFKRHnC0S0MoXwIsE14h9
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------yzuoFKRHnC0S0MoXwIsE14h9--

--------------42ZRJ49UHDDY0uYFOcH0jiv9--

--------------dXh4gafvuiQmFtCEUo0Ovfbq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTlo+QFAwAAAAAACgkQsN6d1ii/Ey+M
RwgAmYVg8iwB8QzOZkrF2CucnZZHgCOnq7doZmYwc+NIOUZGxybCmUBNsjUQQHY/RFHY7nYR2VFX
Gyo04E8g0tbg77PcdMy6/lF++s+W3WGOWcvtS+ZPh6Rdh694qxVH0dlcytHs8xkAk14qZZeaiApk
P2k6pQv47j1RiZfex/o/2KMK7ZCXQ9r+Eyf5xJyXklgXLTQvluOp4cFI/9UTock6BfeUrgpPhExn
z2xlF4UV3DfysB4ZboRVJaJzFYUUkgdsjKzyE/MKFxB4QB+Y2YPhfgQPt4EA3sTSMeAPlKMHbyUN
uAt3V0C+NpQD6xUpX/kEPtFrcxMet5XfLF2WG6tguQ==
=I71y
-----END PGP SIGNATURE-----

--------------dXh4gafvuiQmFtCEUo0Ovfbq--
