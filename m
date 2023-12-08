Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5C480A2B2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573644AbjLHLxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjLHLxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:53:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7FF172E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:53:49 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4FB012119D;
        Fri,  8 Dec 2023 11:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1702036428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=biD4CxwZuZP7nMGf3yxzKnyhfCl4MTC6np3ZEE49Lfk=;
        b=Jzi83PC2gD7pdHdesktf7kElv0gcI8ajA9nyseN286HZxwk/+1ZetC8enz0URydcEDqjoO
        spuGaayDj5DFIdDJLnU22EVefL7PMaQk1/3wfki7c/3r//v/Grp1hFQoXI7DAV4QNE6mg/
        xlgVxjnFNm5kUGw37KWqJ6AAETieTLI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1702036428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=biD4CxwZuZP7nMGf3yxzKnyhfCl4MTC6np3ZEE49Lfk=;
        b=Jzi83PC2gD7pdHdesktf7kElv0gcI8ajA9nyseN286HZxwk/+1ZetC8enz0URydcEDqjoO
        spuGaayDj5DFIdDJLnU22EVefL7PMaQk1/3wfki7c/3r//v/Grp1hFQoXI7DAV4QNE6mg/
        xlgVxjnFNm5kUGw37KWqJ6AAETieTLI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7C2413335;
        Fri,  8 Dec 2023 11:53:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id kDWpNssDc2WvPQAAD6G6ig
        (envelope-from <jgross@suse.com>); Fri, 08 Dec 2023 11:53:47 +0000
Message-ID: <cb98079d-1cbe-4034-8c55-5e71b790a887@suse.com>
Date:   Fri, 8 Dec 2023 12:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20231129133332.31043-1-jgross@suse.com>
 <20231129133332.31043-5-jgross@suse.com>
 <20231206110843.GCZXBWO12KW2aDq+MO@fat_crate.local>
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
In-Reply-To: <20231206110843.GCZXBWO12KW2aDq+MO@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EQoxi8jA4JROMOCnY0upXiTY"
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-1.35 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         TO_DN_SOME(0.00)[];
         HAS_ATTACHMENT(0.00)[];
         MIME_BASE64_TEXT_BOGUS(1.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         MIME_BASE64_TEXT(0.10)[];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.16)[69.07%];
         MIME_UNKNOWN(0.10)[application/pgp-keys];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_TWELVE(0.00)[12];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.35
Authentication-Results: smtp-out1.suse.de;
        none
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
--------------EQoxi8jA4JROMOCnY0upXiTY
Content-Type: multipart/mixed; boundary="------------qaEbTYlaM0kPNiMaSX5rzRmV";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <akaher@vmware.com>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <cb98079d-1cbe-4034-8c55-5e71b790a887@suse.com>
Subject: Re: [PATCH v5 4/5] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
References: <20231129133332.31043-1-jgross@suse.com>
 <20231129133332.31043-5-jgross@suse.com>
 <20231206110843.GCZXBWO12KW2aDq+MO@fat_crate.local>
In-Reply-To: <20231206110843.GCZXBWO12KW2aDq+MO@fat_crate.local>

--------------qaEbTYlaM0kPNiMaSX5rzRmV
Content-Type: multipart/mixed; boundary="------------aCuCz4J40IP9jHRpTzff801t"

--------------aCuCz4J40IP9jHRpTzff801t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMTIuMjMgMTI6MDgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBO
b3YgMjksIDIwMjMgYXQgMDI6MzM6MzFQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEluc3RlYWQgb2Ygc3RhY2tpbmcgYWx0ZXJuYXRpdmUgYW5kIHBhcmF2aXJ0IHBhdGNo
aW5nLCB1c2UgdGhlIG5ldw0KPj4gQUxUX0ZMQUdfQ0FMTCBmbGFnIHRvIHN3aXRjaCB0aG9z
ZSBtaXhlZCBjYWxscyB0byBwdXJlIGFsdGVybmF0aXZlDQo+PiBoYW5kbGluZy4NCj4+DQo+
PiBUaGlzIGVsaW1pbmF0ZXMgdGhlIG5lZWQgdG8gYmUgY2FyZWZ1bCByZWdhcmRpbmcgdGhl
IHNlcXVlbmNlIG9mDQo+PiBhbHRlcm5hdGl2ZSBhbmQgcGFyYXZpcnQgcGF0Y2hpbmcuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0K
Pj4gQWNrZWQtYnk6IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQu
b3JnPg0KPj4gLS0tDQo+PiBWNToNCj4+IC0gcmVtb3ZlIG5vIGxvbmdlciBuZWVkZWQgZXh0
ZXJuIGRlY2xhcmF0aW9ucyBmcm9tIGFsdGVybmF0aXZlLmMNCj4+ICAgIChCb3JpcyBQZXRr
b3YpDQo+PiAtIGFkZCBjb21tZW50IGFib3V0IEFMVEVSTkFUSVZFW18yXSgpIG1hY3JvIHVz
YWdlIChCb3JpcyBQZXRrb3YpDQo+PiAtIHJlYmFzZSB0byB0aXAvbWFzdGVyIChCb3JpcyBQ
ZXRrb3YpDQo+PiAtLS0NCj4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vYWx0ZXJuYXRpdmUu
aCAgICB8ICA1ICsrLS0NCj4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaCAg
ICAgICB8ICA5ICsrKystLQ0KPj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydF90
eXBlcy5oIHwgNDAgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+PiAgIGFyY2gveDg2
L2tlcm5lbC9hbHRlcm5hdGl2ZS5jICAgICAgICAgfCAgMSAtDQo+PiAgIGFyY2gveDg2L2tl
cm5lbC9jYWxsdGh1bmtzLmMgICAgICAgICAgfCAxNyArKysrKystLS0tLS0NCj4+ICAgYXJj
aC94ODYva2VybmVsL21vZHVsZS5jICAgICAgICAgICAgICB8IDIwICsrKystLS0tLS0tLS0t
DQo+PiAgIDYgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgNDggZGVsZXRpb25z
KC0pDQo+IA0KPiBBZnRlciB0aGlzIG9uZTogKC5jb25maWcgaXMgYXR0YWNoZWQpLg0KLi4u
DQoNCk91Y2guDQoNClRvb2sgbWUgYSB3aGlsZSB0byBmaW5kIGl0LiBQYXRjaCA1IHdhcyBy
ZXBhaXJpbmcgdGhlIGlzc3VlIGFnYWluLCBhbmQgSSB0ZXN0ZWQNCm1vcmUgdGhvcm91Z2hs
eSBvbmx5IHdpdGggYWxsIDUgcGF0Y2hlcyBhcHBsaWVkLg0KDQoNCkp1ZXJnZW4NCg0K
--------------aCuCz4J40IP9jHRpTzff801t
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------aCuCz4J40IP9jHRpTzff801t--

--------------qaEbTYlaM0kPNiMaSX5rzRmV--

--------------EQoxi8jA4JROMOCnY0upXiTY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmVzA8sFAwAAAAAACgkQsN6d1ii/Ey89
IAf9GjKjUQ+T9ntZDvoyK6Nh9Ua/iEHOvCuhDnZnTPisT1BLzzIT3xrM3ELgwZwsZh8ANbY5aXpB
SCZQVURzhvtPWQnnQg0vlU3QFZbhdfslMJlWwEr5IT78XHVWq1A1hlSURP52MT74G3lR/S33tTRJ
6SglvyT5PB0ur96gTJ9CNqJckynbJvwn/SM3N3+PzVF/D0vyvsJ9WrtCRGdmNl7G1gshXO8W/Fg8
phu/Ii0QyYIZNpXGmb6tBJ7TresmWiPO+r/vYodev/6QfWx0ZFSJ9gwP2NITDfeLdadwl/kNNtMl
W3SpTTf1wjLZseP9od0D1IjmBrlM0FtxzKalB1TeNA==
=3aar
-----END PGP SIGNATURE-----

--------------EQoxi8jA4JROMOCnY0upXiTY--
