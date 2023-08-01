Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E13776AAE6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjHAI0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjHAI0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:26:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281A1728
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:25:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 22ECF1F897;
        Tue,  1 Aug 2023 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690878356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D7mR+cr7Rhxvm15bIGnuHEnrpm0WTie+xL79QA56DeI=;
        b=ERSzZSfEqa3sPWvZgE1oPU1m+1G9QNaBn1MyD5taf6eoLHVgqL/AslbozdVghLbJCFSPOA
        HxlB99AE5OhoEcUkC+JxSAtYv/vuQC2nWX+paGSzxvcc6lu3z8yzPLp6Z7tYYByg6SVo1m
        WuQtHBLldAPz9Ek2tkR6ybI8z1pv4XA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1657139BD;
        Tue,  1 Aug 2023 08:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1gXELZPByGR3IgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 01 Aug 2023 08:25:55 +0000
Message-ID: <bd5a43b8-c07d-c906-c0ef-ac8b3ae537e2@suse.com>
Date:   Tue, 1 Aug 2023 10:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
 <87v8dzl0wm.ffs@tglx> <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>
 <f0d5b71b-4344-2f35-03ee-3af6ebd038b2@suse.com> <87o7jrkyjf.ffs@tglx>
 <3af74b7a-be7f-3fdb-396e-e76b8ca1efaf@suse.com> <87il9zkw7h.ffs@tglx>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <87il9zkw7h.ffs@tglx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ljlMijAOCnmeyu7ymUiiOPbN"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ljlMijAOCnmeyu7ymUiiOPbN
Content-Type: multipart/mixed; boundary="------------L66IB1nFflxXbgWI1E4J00ss";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Message-ID: <bd5a43b8-c07d-c906-c0ef-ac8b3ae537e2@suse.com>
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
 <87v8dzl0wm.ffs@tglx> <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>
 <f0d5b71b-4344-2f35-03ee-3af6ebd038b2@suse.com> <87o7jrkyjf.ffs@tglx>
 <3af74b7a-be7f-3fdb-396e-e76b8ca1efaf@suse.com> <87il9zkw7h.ffs@tglx>
In-Reply-To: <87il9zkw7h.ffs@tglx>

--------------L66IB1nFflxXbgWI1E4J00ss
Content-Type: multipart/mixed; boundary="------------p4tMMXxkdTehiucVsIdkJSBR"

--------------p4tMMXxkdTehiucVsIdkJSBR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMDguMjMgMTA6MjMsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gVHVlLCBB
dWcgMDEgMjAyMyBhdCAwOTozNywgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IE9uIDAxLjA4
LjIzIDA5OjMyLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+Pj4gT24gVHVlLCBBdWcgMDEg
MjAyMyBhdCAwOTowOCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+Pj4gT24gMDEuMDguMjMg
MDg6NDksIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+ICAgICB2b2lkIF9faW5pdCB4ZW5f
aW5pdF9hcGljKHZvaWQpDQo+Pj4+ICAgICB7DQo+Pj4+ICAgICAgICAgICAgeDg2X2FwaWNf
b3BzLmlvX2FwaWNfcmVhZCA9IHhlbl9pb19hcGljX3JlYWQ7DQo+Pj4+IC0gICAgICAgLyog
T24gUFYgZ3Vlc3RzIHRoZSBBUElDIENQVUlEIGJpdCBpcyBkaXNhYmxlZCBzbyBub25lIG9m
IHRoZQ0KPj4+PiAtICAgICAgICAqIHJvdXRpbmVzIGVuZCB1cCBleGVjdXRpbmcuICovDQo+
Pj4+IC0gICAgICAgaWYgKCF4ZW5faW5pdGlhbF9kb21haW4oKSkNCj4+Pj4gLSAgICAgICAg
ICAgICAgIGFwaWNfaW5zdGFsbF9kcml2ZXIoJnhlbl9wdl9hcGljKTsNCj4+Pj4gLQ0KPj4+
PiAgICAgICAgICAgIHg4Nl9wbGF0Zm9ybS5hcGljX3Bvc3RfaW5pdCA9IHhlbl9hcGljX2No
ZWNrOw0KPj4+DQo+Pj4gSSBkb24ndCB0aGluayB0aGlzIG9uZSBpcyBuZWVkZWQuDQo+Pg0K
Pj4gSW5kZWVkLg0KPiANCj4gQ2FuIHlvdSBzZW5kIGEgcmVhbCBwYXRjaCBwbGVhc2Ugd2hp
Y2ggSSBjYW4gYWRkIHRvIHRoYXQgcGlsZSBhdCB0aGUNCj4gcmlnaHQgcGxhY2U/DQoNCkkg
dGhpbmsgYWRkaW5nIGl0IHJpZ2h0IGFmdGVyIHBhdGNoIDUwIHNob3VsZCBiZSBmaW5lPw0K
DQpUaGUgV0FSTigpIHdpbGwgYmUgaXNzdWVkIG9ubHkgd2l0aCBwYXRjaCA1OC4NCg0KDQpK
dWVyZ2VuDQo=
--------------p4tMMXxkdTehiucVsIdkJSBR
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------p4tMMXxkdTehiucVsIdkJSBR--

--------------L66IB1nFflxXbgWI1E4J00ss--

--------------ljlMijAOCnmeyu7ymUiiOPbN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTIwZMFAwAAAAAACgkQsN6d1ii/Ey9N
lAgAkRPDzF1ckrn6Jp1Os5tYPp3cPiAek5fP1kYuO06yDxDC1IFTjH3t5mLM1NdtVMJnsiu5WJqR
VZpXuxyzWgfqpDT1bHiEjC9AwNIE+TC78YO/y4fNh3MwUcyWPiA++UGUvKop9HUlF7ihnFo1YPo0
7/M1Cm5FEir7chTiD9W+OBPogxLUbxPbbC9UQlYX7SBf1uk1mRBN6xtUs5YhZaViYhGR98h49Pi9
1tzm2hxN27pw528bNRFHFRWGekfcU8G8R3/M0g+FGeEAzbDm+N9IG2T0ApBYzzrbgA9EnbRgE1Li
18UVKPlR3QRLsyR8muRl7dcZzrrL36xoHklj4875Rw==
=D3XJ
-----END PGP SIGNATURE-----

--------------ljlMijAOCnmeyu7ymUiiOPbN--
