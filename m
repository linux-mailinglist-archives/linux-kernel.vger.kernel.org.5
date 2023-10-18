Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CCC7CE0A0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345052AbjJRPCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:02:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CAABA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:02:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF514218E4;
        Wed, 18 Oct 2023 15:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697641348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=jzXgVRfpnKfLdJIsMvo8ZrfE8gdp2wpYDQL32PELeI4=;
        b=h/h/ouk74lnL5nk57wdB26GDlpGKYp+A84iAX9Nn0zu3GIUiqxCU4ZvMsiLYMI/KXVVsuP
        cWHPfH0HcfLFcSnwWDjrBlGYVTANirO1oAWeUskJkw1QbPsGPmLw7kSyRwaMw9VnIVjFKT
        vpVsuhBHOq2b8y3q3CTkFTYrfaVdDJI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EB8113780;
        Wed, 18 Oct 2023 15:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ApJiGYTzL2UEawAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 18 Oct 2023 15:02:28 +0000
Message-ID: <91bc1200-a12b-4a71-b7d3-f1af94da90d3@suse.com>
Date:   Wed, 18 Oct 2023 17:02:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
References: <20231016123933.17284-1-jgross@suse.com>
 <20231016123933.17284-4-jgross@suse.com>
 <20231016142930.GE33217@noisy.programming.kicks-ass.net>
 <4f5cc965-36da-43f0-aaaa-082a2235ec1e@suse.com> <ZS/C1HS/EEXTtVji@gmail.com>
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
In-Reply-To: <ZS/C1HS/EEXTtVji@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UA756g8TuaITJxxgQbj9xO0i"
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
         BAYES_HAM(-3.00)[99.99%];
         MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
         HAS_ATTACHMENT(0.00)[];
         REPLY(-4.00)[];
         MIME_BASE64_TEXT_BOGUS(1.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MIME_BASE64_TEXT(0.10)[];
         RCPT_COUNT_TWELVE(0.00)[13];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         MIME_UNKNOWN(0.10)[application/pgp-keys]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UA756g8TuaITJxxgQbj9xO0i
Content-Type: multipart/mixed; boundary="------------c01St8HcXHcYYzxOKnu9Fzvm";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <akaher@vmware.com>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Message-ID: <91bc1200-a12b-4a71-b7d3-f1af94da90d3@suse.com>
Subject: Re: [PATCH v2 3/4] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
References: <20231016123933.17284-1-jgross@suse.com>
 <20231016123933.17284-4-jgross@suse.com>
 <20231016142930.GE33217@noisy.programming.kicks-ass.net>
 <4f5cc965-36da-43f0-aaaa-082a2235ec1e@suse.com> <ZS/C1HS/EEXTtVji@gmail.com>
In-Reply-To: <ZS/C1HS/EEXTtVji@gmail.com>

--------------c01St8HcXHcYYzxOKnu9Fzvm
Content-Type: multipart/mixed; boundary="------------zP3Cer6SjJS0jYLanVpDv7iT"

--------------zP3Cer6SjJS0jYLanVpDv7iT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTguMTAuMjMgMTM6MzQsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IE9uIDE2LjEwLjIzIDE2
OjI5LCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+PiBPbiBNb24sIE9jdCAxNiwgMjAyMyBh
dCAwMjozOTozMlBNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+PiBJbnN0ZWFk
IG9mIHN0YWNraW5nIGFsdGVybmF0aXZlIGFuZCBwYXJhdmlydCBwYXRjaGluZywgdXNlIHRo
ZSBuZXcNCj4+Pj4gQUxUX0ZMQUdfQ0FMTCBmbGFnIHRvIHN3aXRjaCB0aG9zZSBtaXhlZCBj
YWxscyB0byBwdXJlIGFsdGVybmF0aXZlDQo+Pj4+IGhhbmRsaW5nLg0KPj4+Pg0KPj4+PiBU
aGlzIGVsaW1pbmF0ZXMgdGhlIG5lZWQgdG8gYmUgY2FyZWZ1bCByZWdhcmRpbmcgdGhlIHNl
cXVlbmNlIG9mDQo+Pj4+IGFsdGVybmF0aXZlIGFuZCBwYXJhdmlydCBwYXRjaGluZy4NCj4+
Pj4NCj4+Pj4gRm9yIGNhbGwgZGVwdGggdHJhY2tpbmcgY2FsbHRodW5rc19zZXR1cCgpIG5l
ZWRzIHRvIGJlIGFkYXB0ZWQgdG8gcGF0Y2gNCj4+Pj4gY2FsbHMgYXQgYWx0ZXJuYXRpdmUg
cGF0Y2hpbmcgc2l0ZXMgaW5zdGVhZCBvZiBwYXJhdmlydCBjYWxscy4NCj4+Pj4NCj4+Pj4g
U2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4+DQo+
Pj4gSSBjYW5ub3QgaGVscCBidXQgZmVlbCB0aGlzIHdvdWxkJ3ZlIGJlZW4gYmV0dGVyIGFz
IHR3byBwYXRjaGVzLCBvbmUNCj4+PiBpbnRyb2R1Y2luZyBBTFRfTk9UX1hFTiBhbmQgdGhl
biBhIHNlY29uZCB3aXRoIHRoZSByZXN0Lg0KPj4NCj4+IEluIGNhc2UgSSBuZWVkIHRvIHJl
c3BpbiBJJ2xsIHNwbGl0IGl0IHVwLg0KPiANCj4gWWVhaCwgd291bGQgYmUgbmljZSB0byBz
cGxpdCB0aGlzIHBhdGNoIGludG8gdHdvLCBhcyBQZXRlciByZXF1ZXN0ZWQuDQoNCk9rYXks
IHdpbGwgcmVzZW5kIHRoZSBzZXJpZXMgcHJvYmFibHkgdG9tb3Jyb3cuDQoNCg0KSnVlcmdl
bg0KDQo=
--------------zP3Cer6SjJS0jYLanVpDv7iT
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------zP3Cer6SjJS0jYLanVpDv7iT--

--------------c01St8HcXHcYYzxOKnu9Fzvm--

--------------UA756g8TuaITJxxgQbj9xO0i
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmUv84QFAwAAAAAACgkQsN6d1ii/Ey/a
aAf/agxbvT+jMBfCzPRfFBt0cc9jl3YMcvYfoK0TfS5n0aqZoC7N7hlKTvBFFI9uh5WmDnCuk+UK
SGvDYtvmaC+LAQ6xyKiy7AJFpONP5PQB/ljBPiDWpOp1Ehd9g1PU4J+lCectuaaUt0HVLoqmHx7f
oVPNHt44ybcQz5k+7QuWDGvlSdL/BcrAxAtzZ+k9SjXFWpGLxGM4BU8+70hwE8suT2IL5xFHeA15
bw2YUOsOrH9yj5CBpdhYoOiks1nFfVHcXWoqZ6RNmL22UxyFSiDLU3Cy5CGCpiTzpjPbw7CHMmP7
a38q1ol6BvPONnKvPrbsWAgnoqG7HxE67ynHMO8QbA==
=mWkZ
-----END PGP SIGNATURE-----

--------------UA756g8TuaITJxxgQbj9xO0i--
