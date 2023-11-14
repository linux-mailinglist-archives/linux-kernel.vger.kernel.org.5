Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752B27EB23E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjKNOgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjKNOfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:35:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A53CA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:35:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2B167218F0;
        Tue, 14 Nov 2023 14:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699972539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=RV+gR+i3a83zXYDBjrF9VPQHCl29fgiHlgJNaWNn8yo=;
        b=fXAb5rCFNjxEfWdR6xefn6YlcpQaR3bJMPCRoXtEfHqQh/fWx0WjjWPw8iU5Dj7L3+XLuG
        rAhQVD0lsqBw9o0ySVgFqYNwbpLScXcNI8blqYVgDxl2oB43TXnGfxPiphP4E3e0ntqqaN
        qkz0f64GZs099NscSr7RPK3f2DKGcUw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC98313416;
        Tue, 14 Nov 2023 14:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TLkwNLqFU2WKMgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Nov 2023 14:35:38 +0000
Message-ID: <27ba5785-a15a-416c-93be-c14a1c3dff17@suse.com>
Date:   Tue, 14 Nov 2023 15:35:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] x86/alternative: add indirect call patching
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-3-jgross@suse.com>
 <20231114123737.GBZVNqEXKgt+6P1Wiv@fat_crate.local>
 <20231114125028.GX3818@noisy.programming.kicks-ass.net>
 <20231114134715.GBZVN6Y97XrLQ4cbSL@fat_crate.local>
 <20231114141833.GX8262@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20231114141833.GX8262@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------61Pb1zKPRtufWKGFW2sVUD3N"
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -11.99
X-Spamd-Result: default: False [-11.99 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
         HAS_ATTACHMENT(0.00)[];
         REPLY(-4.00)[];
         MIME_BASE64_TEXT_BOGUS(1.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MIME_BASE64_TEXT(0.10)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         MIME_UNKNOWN(0.10)[application/pgp-keys]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------61Pb1zKPRtufWKGFW2sVUD3N
Content-Type: multipart/mixed; boundary="------------0YbBkDGKS2Ji3Uykcw3gplLF";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <27ba5785-a15a-416c-93be-c14a1c3dff17@suse.com>
Subject: Re: [PATCH v4 2/5] x86/alternative: add indirect call patching
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-3-jgross@suse.com>
 <20231114123737.GBZVNqEXKgt+6P1Wiv@fat_crate.local>
 <20231114125028.GX3818@noisy.programming.kicks-ass.net>
 <20231114134715.GBZVN6Y97XrLQ4cbSL@fat_crate.local>
 <20231114141833.GX8262@noisy.programming.kicks-ass.net>
In-Reply-To: <20231114141833.GX8262@noisy.programming.kicks-ass.net>

--------------0YbBkDGKS2Ji3Uykcw3gplLF
Content-Type: multipart/mixed; boundary="------------XGrTrWJuV23yRooblactK7fN"

--------------XGrTrWJuV23yRooblactK7fN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMTEuMjMgMTU6MTgsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUdWUsIE5v
diAxNCwgMjAyMyBhdCAwMjo0NzoxNVBNICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+PiBPbiBUdWUsIE5vdiAxNCwgMjAyMyBhdCAwMTo1MDoyOFBNICswMTAwLCBQZXRlciBa
aWpsc3RyYSB3cm90ZToNCj4+PiBUaGlzIGxvYWRzIHRoZSBmdW5jdGlvbiB0YXJnZXQgZnJv
bSB0aGUgcHZfb3BzIHRhYmxlLiBXZSBjYW4ndCBvdGhlcndpc2UNCj4+PiBkbyB0aGlzLg0K
Pj4NCj4+IE9uIFR1ZSwgTm92IDE0LCAyMDIzIGF0IDAxOjU2OjM3UE0gKzAxMDAsIEp1ZXJn
ZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4gSXQgaXMgcmVwbGFjaW5nIGFuIF9pbmRpcmVjdF8gY2Fs
bCB3aXRoIGEgX2RpcmVjdF8gb25lLCB0YWtpbmcgdGhlDQo+Pj4gY2FsbCB0YXJnZXQgZnJv
bSB0aGUgcG9pbnRlciB1c2VkIGJ5IHRoZSBpbmRpcmVjdCBjYWxsLg0KPj4NCj4+IFRoZW4g
dGhpcyBpcyBub3QganVzdCBhIEFMVF9GTEFHX0NBTEwuIFRoaXMgaXMgc29tZXRoaW5nIHNw
ZWNpYWwuIFRoZQ0KPj4gZmxhZyBkZWZpbml0aW9uIG5lZWRzIGEgYmV0dGVyIG5hbWUgYWxv
bmcgd2l0aCBhbiBleHBsYW5hdGlvbiB3aGF0IGl0DQo+PiBkb2VzLCBwZXJoYXBzIGJlc3Qg
d2l0aCBhbiBleGFtcGxlIGZyb20gdGhlIGZpbmFsIHZtbGludXggLSBub3QgZnJvbSB0aGUN
Cj4+IG9iamVjdCBmaWxlOg0KPj4NCj4+IGNhbGwgICAqMHgwKCVyaXApDQo+Pg0KPj4gPT0+
DQo+Pg0KPj4gY2FsbCAgICoweDANCj4+DQo+PiB3aGVyZSB0aGUgb2Zmc2V0cyBoYXZlbid0
IGJlZW4gbGlua2VkIGluIHlldC4NCj4gDQo+IFdlbGwsIGEgcmFuZG9tIGFic29sdXRlIGFk
ZHJlc3MgaXNuJ3QgZ29pbmcgdG8gYmUgYW55IGJldHRlciBvciB3b3JzZQ0KPiB0aGFuIDAu
IEJ1dCBwZXJoYXBzIGFkZGluZyB0aGUgcmVsb2NhdGlvbiBhcyBhIGNvbW1lbnQgaGVscHM/
DQo+IA0KPiANCj4gICAgIGZmIDE1IDAwIDAwIDAwIDAwICAgICAgIGNhbGwgICAqMHgwKCVy
aXApICAjICBSX1g4Nl82NF9QQzMyICAgIHB2X29wcysweDQNCj4gaW50bzoNCj4gICAgIGU4
IDAwIDAwIDAwIDAwIDkwCSAgIGNhbGwgICArMCAgICAgICAgICAjICBSX1g4Nl82NF9QQzMy
ICoocHZfb3BzKzB4MDQpDQo+IA0KPiANCj4+IElmIHRoaXMgaXMgZ29pbmcgaW50byB0aGUg
Z2VuZXJpYyBpbmZyYXN0cnVjdHVyZSwgdGhlbiBpdCBiZXR0ZXIgYmUNCj4+IGV4cGxhaW5l
ZCBwcm9wZXJseSBzbyB0aGF0IG90aGVyIHN0dWZmIGNhbiBwb3RlbnRpYWxseSB1c2UgaXQg
dG9vLg0KPiANCj4gQUxUX0ZMQUdfREVSRUZFUkVOQ0VfSU5ESVJFQ1RfQ0FMTCA/DQoNCkFM
VF9GTEFHX01BS0VfQ0FMTF9ESVJFQ1QgPw0KDQo+IA0KPiBJJ20gZ29pbmcgdG8gYWxyZWFk
eSByYWlzZSBteSBoYW5kIGFuZCBzYXkgdGhhdCdzIHRvbyBsb25nIDstKQ0KDQpJIHRoaW5r
IHRoZSBsZW5ndGggb2YgdGhlIG5hbWUgZG9lc24ndCBtYXR0ZXIgdGhhdCBtdWNoLCBhcyBp
dCBpcyB1c2VkIG9ubHkNCmluIHRoZSBwYXRjaGluZyBjb2RlIGFuZCB2aWEgdGhlIEFMVF9D
QUxMKCkgbWFjcm8gKGF0IGxlYXN0IGFzIGxvbmcgYXMgQm9yaXMNCmRvZXNuJ3QgYXNrIG1l
IHRvIGNoYW5nZSB0aGUgbWFjcm8gbmFtZSwgdG9vKS4NCg0KDQpKdWVyZ2VuDQo=
--------------XGrTrWJuV23yRooblactK7fN
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------XGrTrWJuV23yRooblactK7fN--

--------------0YbBkDGKS2Ji3Uykcw3gplLF--

--------------61Pb1zKPRtufWKGFW2sVUD3N
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmVThboFAwAAAAAACgkQsN6d1ii/Ey+M
5wf/WYmTd/Ym98rKo0DeNMDlv1G19ZoThwv8AoV2MxljYqh6WExjMmYuQhkbiIyPQXf+HEYMXg+f
JIvVnh49VZEAVI1IAvQrmMazWzEMKJ9TZnN8zbd468BW3dAYTWz1WO8gcXGF7FZmm6z5pd7XcftF
uw7AWQUTCQbSGrokHFrfUZqKeErvUz0BsFYrRbqveQnBOfKhm25kcPDCDGuBIoX1Zc2b6VwANomo
5IxdbhsMHa35cD7jt5KseMIpSfTWjFWA6P5gnjnJyAaycFYhe+WF3pc8wOx9z0dW5eclq62Aj+Zf
p03uc/EfkHYixlej3Abv3PD0m8XXxvEdbSSY3Im4iA==
=jdXA
-----END PGP SIGNATURE-----

--------------61Pb1zKPRtufWKGFW2sVUD3N--
