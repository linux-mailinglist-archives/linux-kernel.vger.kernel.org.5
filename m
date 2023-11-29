Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6560E7FD395
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjK2KIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK2KIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:08:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E80E1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:08:17 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B401221999;
        Wed, 29 Nov 2023 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701252495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=o7/7OYBC0d+NuoDlWBudGfL8iqt5rUlQdKgbKwJCHdk=;
        b=Fh0+DyASlPShxRnRFMYHINKafS2o1Qos19J+8ciZ/Q3qlfyGeRN7yWw37qtNn72PczWL6E
        EjSN4Fju0VTCx88O+iMM6WMLG19pHsV44PBbtBbrDU0eqEn3lncfQfI4uetcs4Z8wuZKO9
        RoLk1JjsXpONaUP1McC2RWesTUU2raw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DA691388B;
        Wed, 29 Nov 2023 10:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id UkUBFY8NZ2U0AwAAD6G6ig
        (envelope-from <jgross@suse.com>); Wed, 29 Nov 2023 10:08:15 +0000
Message-ID: <f0e45cd2-5dc8-494f-a48d-369902c07fb6@suse.com>
Date:   Wed, 29 Nov 2023 11:08:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-5-jgross@suse.com>
 <20231121184505.GGZVz6sc+4sP7/HFji@fat_crate.local>
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
In-Reply-To: <20231121184505.GGZVz6sc+4sP7/HFji@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iKzHs0rV0FyeY2dv94qiYU6g"
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-5.19 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
         HAS_ATTACHMENT(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_BASE64_TEXT_BOGUS(1.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         MIME_BASE64_TEXT(0.10)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email];
         SIGNED_PGP(-2.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         MIME_UNKNOWN(0.10)[application/pgp-keys]
X-Spam-Score: -5.19
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
--------------iKzHs0rV0FyeY2dv94qiYU6g
Content-Type: multipart/mixed; boundary="------------oBwYgkt0X0dAEdJB4l4COvoj";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <f0e45cd2-5dc8-494f-a48d-369902c07fb6@suse.com>
Subject: Re: [PATCH v4 4/5] x86/paravirt: switch mixed paravirt/alternative
 calls to alternative_2
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-5-jgross@suse.com>
 <20231121184505.GGZVz6sc+4sP7/HFji@fat_crate.local>
In-Reply-To: <20231121184505.GGZVz6sc+4sP7/HFji@fat_crate.local>

--------------oBwYgkt0X0dAEdJB4l4COvoj
Content-Type: multipart/mixed; boundary="------------wgdYZujGgDKQNfZ0lPQXwIK3"

--------------wgdYZujGgDKQNfZ0lPQXwIK3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMTEuMjMgMTk6NDUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBP
Y3QgMzAsIDIwMjMgYXQgMDM6MjU6MDdQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IEluc3RlYWQgb2Ygc3RhY2tpbmcgYWx0ZXJuYXRpdmUgYW5kIHBhcmF2aXJ0IHBhdGNo
aW5nLCB1c2UgdGhlIG5ldw0KPj4gQUxUX0ZMQUdfQ0FMTCBmbGFnIHRvIHN3aXRjaCB0aG9z
ZSBtaXhlZCBjYWxscyB0byBwdXJlIGFsdGVybmF0aXZlDQo+PiBoYW5kbGluZy4NCj4+DQo+
PiBUaGlzIGVsaW1pbmF0ZXMgdGhlIG5lZWQgdG8gYmUgY2FyZWZ1bCByZWdhcmRpbmcgdGhl
IHNlcXVlbmNlIG9mDQo+PiBhbHRlcm5hdGl2ZSBhbmQgcGFyYXZpcnQgcGF0Y2hpbmcuDQo+
Pg0KPj4gRm9yIGNhbGwgZGVwdGggdHJhY2tpbmcgY2FsbHRodW5rc19zZXR1cCgpIG5lZWRz
IHRvIGJlIGFkYXB0ZWQgdG8gcGF0Y2gNCj4+IGNhbGxzIGF0IGFsdGVybmF0aXZlIHBhdGNo
aW5nIHNpdGVzIGluc3RlYWQgb2YgcGFyYXZpcnQgY2FsbHMuDQo+IA0KPiBXaHkgaXMgdGhp
cyBpbXBvcnRhbnQgc28gdGhhdCBpdCBpcyBjYWxsZWQgb3V0IGV4cGxpY2l0bHkgaW4gdGhl
IGNvbW1pdA0KPiBtZXNzYWdlPyBJcyBjYWxsdGh1bmtzX3NldHVwKCkgc3BlY2lhbCBzb21l
aG93Pw0KDQpJTUhPIGl0IGlzIGEgbm9uLW9idmlvdXMgY2hhbmdlLCBzbyBJIHNwZWxsZWQg
aXQgb3V0IGV4cGxpY2l0bHkuIEkgY2FuIGRyb3ANCnRoYXQgcGFyYWdyYXBoIGlmIHlvdSB3
YW50Lg0KDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9z
c0BzdXNlLmNvbT4NCj4+IEFja2VkLWJ5OiBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz4NCj4+IC0tLQ0KPj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9h
bHRlcm5hdGl2ZS5oICAgIHwgIDUgKysrLS0NCj4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20v
cGFyYXZpcnQuaCAgICAgICB8ICA5ICsrKysrKy0tLQ0KPj4gICBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9wYXJhdmlydF90eXBlcy5oIHwgMjYgKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+ICAgYXJjaC94ODYva2VybmVsL2NhbGx0aHVua3MuYyAgICAgICAgICB8IDE3ICsrKysr
KysrLS0tLS0tLS0tDQo+PiAgIGFyY2gveDg2L2tlcm5lbC9tb2R1bGUuYyAgICAgICAgICAg
ICAgfCAyMCArKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4gICA1IGZpbGVzIGNoYW5nZWQsIDMx
IGluc2VydGlvbnMoKyksIDQ2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9hbHRlcm5hdGl2ZS5oIGIvYXJjaC94ODYvaW5jbHVkZS9h
c20vYWx0ZXJuYXRpdmUuaA0KPj4gaW5kZXggMmE3NGE5NGJkNTY5Li4wN2IxN2JjNjE1YTAg
MTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9hbHRlcm5hdGl2ZS5oDQo+
PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9hbHRlcm5hdGl2ZS5oDQo+PiBAQCAtODks
NiArODksOCBAQCBzdHJ1Y3QgYWx0X2luc3RyIHsNCj4+ICAgCXU4ICByZXBsYWNlbWVudGxl
bjsJLyogbGVuZ3RoIG9mIG5ldyBpbnN0cnVjdGlvbiAqLw0KPj4gICB9IF9fcGFja2VkOw0K
Pj4gICANCj4+ICtleHRlcm4gc3RydWN0IGFsdF9pbnN0ciBfX2FsdF9pbnN0cnVjdGlvbnNb
XSwgX19hbHRfaW5zdHJ1Y3Rpb25zX2VuZFtdOw0KPj4gKw0KPiANCj4gYXJjaC94ODYvaW5j
bHVkZS9hc20vYWx0ZXJuYXRpdmUuaDo5MjpleHRlcm4gc3RydWN0IGFsdF9pbnN0ciBfX2Fs
dF9pbnN0cnVjdGlvbnNbXSwgX19hbHRfaW5zdHJ1Y3Rpb25zX2VuZFtdOw0KPiBhcmNoL3g4
Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYzoxNjM6ZXh0ZXJuIHN0cnVjdCBhbHRfaW5zdHIgX19h
bHRfaW5zdHJ1Y3Rpb25zW10sIF9fYWx0X2luc3RydWN0aW9uc19lbmRbXTsNCj4gDQo+IFph
cCB0aGUgZGVjbGFyYXRpb24gZnJvbSB0aGUgLmMgZmlsZSBwbHMuDQoNCk9rYXkuDQoNCj4g
DQo+PiAgIC8qDQo+PiAgICAqIERlYnVnIGZsYWcgdGhhdCBjYW4gYmUgdGVzdGVkIHRvIHNl
ZSB3aGV0aGVyIGFsdGVybmF0aXZlDQo+PiAgICAqIGluc3RydWN0aW9ucyB3ZXJlIHBhdGNo
ZWQgaW4gYWxyZWFkeToNCj4+IEBAIC0xMDQsMTEgKzEwNiwxMCBAQCBleHRlcm4gdm9pZCBh
cHBseV9maW5laWJ0KHMzMiAqc3RhcnRfcmV0cG9saW5lLCBzMzIgKmVuZF9yZXRwb2luZSwN
Cj4+ICAgCQkJICBzMzIgKnN0YXJ0X2NmaSwgczMyICplbmRfY2ZpKTsNCj4+ICAgDQo+PiAg
IHN0cnVjdCBtb2R1bGU7DQo+PiAtc3RydWN0IHBhcmF2aXJ0X3BhdGNoX3NpdGU7DQo+PiAg
IA0KPj4gICBzdHJ1Y3QgY2FsbHRodW5rX3NpdGVzIHsNCj4+ICAgCXMzMgkJCQkqY2FsbF9z
dGFydCwgKmNhbGxfZW5kOw0KPj4gLQlzdHJ1Y3QgcGFyYXZpcnRfcGF0Y2hfc2l0ZQkqcHZf
c3RhcnQsICpwdl9lbmQ7DQo+PiArCXN0cnVjdCBhbHRfaW5zdHIJCSphbHRfc3RhcnQsICph
bHRfZW5kOw0KPj4gICB9Ow0KPj4gICANCj4+ICAgI2lmZGVmIENPTkZJR19DQUxMX1RIVU5L
Uw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0LmggYi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydC5oDQo+PiBpbmRleCAzNzQ5MzExZDUxYzMu
LjljNmM1Y2ZhOWZlMiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Bh
cmF2aXJ0LmgNCj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0LmgNCj4+
IEBAIC03NDAsMjAgKzc0MCwyMyBAQCB2b2lkIG5hdGl2ZV9wdl9sb2NrX2luaXQodm9pZCkg
X19pbml0Ow0KPj4gICANCj4+ICAgI2lmZGVmIENPTkZJR19YODZfNjQNCj4+ICAgI2lmZGVm
IENPTkZJR19QQVJBVklSVF9YWEwNCj4+ICsjaWZkZWYgQ09ORklHX0RFQlVHX0VOVFJZDQo+
PiAgIA0KPj4gICAjZGVmaW5lIFBBUkFfUEFUQ0gob2ZmKQkJKChvZmYpIC8gOCkNCj4+ICAg
I2RlZmluZSBQQVJBX1NJVEUocHR5cGUsIG9wcykJX1BWU0lURShwdHlwZSwgb3BzLCAucXVh
ZCwgOCkNCj4+ICAgI2RlZmluZSBQQVJBX0lORElSRUNUKGFkZHIpCSphZGRyKCVyaXApDQo+
PiAgIA0KPj4gLSNpZmRlZiBDT05GSUdfREVCVUdfRU5UUlkNCj4+ICAgLm1hY3JvIFBBUkFf
SVJRX3NhdmVfZmwNCj4+ICAgCVBBUkFfU0lURShQQVJBX1BBVENIKFBWX0lSUV9zYXZlX2Zs
KSwNCj4+ICAgCQkgIEFOTk9UQVRFX1JFVFBPTElORV9TQUZFOw0KPj4gICAJCSAgY2FsbCBQ
QVJBX0lORElSRUNUKHB2X29wcytQVl9JUlFfc2F2ZV9mbCk7KQ0KPj4gKwlBTk5PVEFURV9S
RVRQT0xJTkVfU0FGRTsNCj4+ICsJY2FsbCBQQVJBX0lORElSRUNUKHB2X29wcytQVl9JUlFf
c2F2ZV9mbCk7DQo+PiAgIC5lbmRtDQo+PiAgIA0KPj4gLSNkZWZpbmUgU0FWRV9GTEFHUwlB
TFRFUk5BVElWRSAiUEFSQV9JUlFfc2F2ZV9mbDsiLCAicHVzaGY7IHBvcCAlcmF4OyIsIFwN
Cj4+IC0JCQkJICAgIEFMVF9OT1RfWEVODQo+PiArI2RlZmluZSBTQVZFX0ZMQUdTIEFMVEVS
TkFUSVZFXzIgIlBBUkFfSVJRX3NhdmVfZmw7IiwJCQlcDQo+PiArCQkJCSBBTFRfQ0FMTF9J
TlNUUiwgQUxUX0NBTExfQUxXQVlTLAlcDQo+PiArCQkJCSAicHVzaGY7IHBvcCAlcmF4OyIs
IEFMVF9OT1RfWEVODQo+IA0KPiBIb3cgaXMgdGhhdCBzdXBwb3NlZCB0byB3b3JrPw0KPiAN
Cj4gQXQgYnVpbGQgdGltZSBmb3IgYSBQQVJBVklSVF9YWEwgYnVpbGQgaXQnbGwgaGF2ZSB0
aGF0IFBBUkFfSVJRX3NhdmVfZmwNCj4gbWFjcm8gaW4gdGhlcmUgd2hpY2ggaXNzdWVzIGEg
LnBhcmFpbnN0cnVjdGlvbnMgc2VjdGlvbiBhbmQgYW4gaW5kaXJlY3QNCj4gY2FsbCB0bw0K
PiANCj4gCWNhbGwgKnB2X29wcysyNDAoJXJpcCk7DQo+IA0KPiB0aGVuIGl0J2xsIGFsd2F5
cyBwYXRjaCBpbiAiY2FsbCBCVUdfZnVuYyIgZHVlIHRvIFg4Nl9GRUFUVVJFX0FMV0FZUy4N
Cj4gDQo+IEkgZ3Vlc3MgdGhpcyBpcyB5b3VyIHdheSBvZiBzYXlpbmcgInRoaXMgc2hvdWxk
IGFsd2F5cyBiZSBwYXRjaGVkLCBvbmUNCj4gd2F5IG9yIHRoZSBvdGhlciwgZGVwZW5kaW5n
IG9uIFg4Nl9GRUFUVVJFX1hFTlBWLCBhbmQgdGhpcyBpcyBhIHdheSB0bw0KPiBjYXRjaCB1
bnBhdGNoZWQgbG9jYXRpb25zLi4uDQo+IA0KPiBUaGVuIG9uIGEgcHYgYnVpbGQgd2hpY2gg
ZG9lc24ndCBzZXQgWDg2X0ZFQVRVUkVfWEVOUFYgZHVyaW5nIGJvb3QsDQo+IGl0J2xsIHJl
cGxhY2UgdGhlICJjYWxsIEJVR19mdW5jIiB0aGluZyB3aXRoIHRoZSBwdXNoZjtwb3AuDQo+
IA0KPiBBbmQgaWYgaXQgZG9lcyBzZXQgWDg2X0ZFQVRVUkVfWEVOUFYsIGl0J2xsIHBhdGNo
IGluIHRoZSBkaXJlY3QgY2FsbCB0bw0KPiAuLi4uIC9tZSBncmVwcyB0cmVlIC4uLiBwdl9u
YXRpdmVfc2F2ZV9mbCBJIGd1ZXNzLg0KPiANCj4gSWYgYW55dGhpbmcsIGhvdyB0aG9zZSBB
TFRfQ0FMTF9BTFdBWVMgdGhpbmdzIGFyZSBzdXBwb3NlZCB0byB3b3JrLA0KPiBzaG91bGQg
YmUgZG9jdW1lbnRlZCB0aGVyZSwgb3ZlciB0aGUgbWFjcm8gZGVmaW5pdGlvbiBhbmQgd2hh
dCB0aGUNCj4gaW50ZW50IGlzLg0KDQpJIGNhbiBkbyB0aGF0LCBidXQgT1RPSCB0aGUgZXhp
c3RpbmcgY29tbWVudHMgYXJlIHF1aXRlIGNsZWFyOg0KDQogICogSWYgQ1BVIGhhcyBmZWF0
dXJlMiwgbmV3aW5zdHIyIGlzIHVzZWQuDQogICogT3RoZXJ3aXNlLCBpZiBDUFUgaGFzIGZl
YXR1cmUxLCBuZXdpbnN0cjEgaXMgdXNlZC4NCiAgKiBPdGhlcndpc2UsIG9sZGluc3RyIGlz
IHVzZWQuDQoNCj4gDQo+IEJlY2F1c2Ugb3RoZXJ3aXNlIHdlJ2xsIGhhdmUgdG8gc3dhcCBp
biB0aGUgd2hvbGUgbWFjaGluZXJ5IGJhY2sgaW50bw0KPiBvdXIgTDFzIGVhY2ggdGltZSB3
ZSBuZWVkIHRvIHRvdWNoIGl0Lg0KPiANCj4gQW5kIGJ0dywgdGhpcyB3aG9sZSBwYXRjaGlu
ZyBzdHVmZiBiZWNvbWVzIGluc2FuZWx5IG5vbi10cml2aWFsIHNsb3dseS4NCg0KTm90IHdv
cnNlIHRoYW4gdG9kYXkuIEl0IGp1c3QgcmVwbGFjZXMgdGhlIHBhcmF2aXJ0IHBhdGNoaW5n
IHdpdGggYW4NCmFsdGVybmF0aXZlIHBhdGNoaW5nLg0KDQo+IA0KPiA6LVwNCj4gDQo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NhbGx0aHVua3MuYyBiL2FyY2gveDg2L2tl
cm5lbC9jYWxsdGh1bmtzLmMNCj4+IGluZGV4IGZhYTlmMjI5OTg0OC4uMjAwZWE4MDg3ZGRi
IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NhbGx0aHVua3MuYw0KPj4gKysr
IGIvYXJjaC94ODYva2VybmVsL2NhbGx0aHVua3MuYw0KPj4gQEAgLTIzOCwxNCArMjM4LDEz
IEBAIHBhdGNoX2NhbGxfc2l0ZXMoczMyICpzdGFydCwgczMyICplbmQsIGNvbnN0IHN0cnVj
dCBjb3JlX3RleHQgKmN0KQ0KPj4gICB9DQo+PiAgIA0KPj4gICBzdGF0aWMgX19pbml0X29y
X21vZHVsZSB2b2lkDQo+PiAtcGF0Y2hfcGFyYXZpcnRfY2FsbF9zaXRlcyhzdHJ1Y3QgcGFy
YXZpcnRfcGF0Y2hfc2l0ZSAqc3RhcnQsDQo+PiAtCQkJICBzdHJ1Y3QgcGFyYXZpcnRfcGF0
Y2hfc2l0ZSAqZW5kLA0KPj4gLQkJCSAgY29uc3Qgc3RydWN0IGNvcmVfdGV4dCAqY3QpDQo+
PiArcGF0Y2hfYWx0X2NhbGxfc2l0ZXMoc3RydWN0IGFsdF9pbnN0ciAqc3RhcnQsIHN0cnVj
dCBhbHRfaW5zdHIgKmVuZCwNCj4+ICsJCSAgICAgY29uc3Qgc3RydWN0IGNvcmVfdGV4dCAq
Y3QpDQo+PiAgIHsNCj4+IC0Jc3RydWN0IHBhcmF2aXJ0X3BhdGNoX3NpdGUgKnA7DQo+PiAr
CXN0cnVjdCBhbHRfaW5zdHIgKmE7DQo+PiAgIA0KPj4gLQlmb3IgKHAgPSBzdGFydDsgcCA8
IGVuZDsgcCsrKQ0KPj4gLQkJcGF0Y2hfY2FsbChwLT5pbnN0ciwgY3QpOw0KPj4gKwlmb3Ig
KGEgPSBzdGFydDsgYSA8IGVuZDsgYSsrKQ0KPj4gKwkJcGF0Y2hfY2FsbCgodTggKikmYS0+
aW5zdHJfb2Zmc2V0ICsgYS0+aW5zdHJfb2Zmc2V0LCBjdCk7DQo+IA0KPiB0aXA6eDg2L3Bh
cmF2aXJ0IGhhczoNCj4gDQo+IDVjMjJjNDcyNmU0YSAoIng4Ni9wYXJhdmlydDogVXNlIHJl
bGF0aXZlIHJlZmVyZW5jZSBmb3IgdGhlIG9yaWdpbmFsIGluc3RydWN0aW9uIG9mZnNldCIp
DQo+IA0KPiBQZXJoYXBzIHJlZG8geW91cnMgb250b3Agb2YgdGlwL21hc3RlcjoNCg0KWWVz
LCBvZiBjb3Vyc2UuDQoNCg0KSnVlcmdlbg0K
--------------wgdYZujGgDKQNfZ0lPQXwIK3
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------wgdYZujGgDKQNfZ0lPQXwIK3--

--------------oBwYgkt0X0dAEdJB4l4COvoj--

--------------iKzHs0rV0FyeY2dv94qiYU6g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmVnDY4FAwAAAAAACgkQsN6d1ii/Ey9A
ZggAiSlqf+uRGjK8j1VuJy+w1iPbsh+odCkMl/1SwaZHkOqargDstid1CScrWSOuBXrUDLxkk5NN
Bbv9QtmfkU5pxKdDeMAB8Se3aA2AKwWWMEvKj80eYELMoYfgx2Mkw4rM4Ym15cZ2KITyHcakA3jD
mbU6naESsM9KMDKdlBx/Pg/bAETG7PXY7mE2DfiUFavSWGIYNbs4rlseYSUaK3zXcyULv+nShs9j
ETkt0VaZjMw/yzfvbF0hUf5nzdR7kbVdiEf1Nvwxo6qBXB2dKlnGoYBSudWHG9/aWc6K+v8ZKRXE
TcZVgRfd45Jg1BsVCo+mjiwLSJBSQDSmYa9yvGrZ5Q==
=a5WD
-----END PGP SIGNATURE-----

--------------iKzHs0rV0FyeY2dv94qiYU6g--
