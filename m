Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0EA8080F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377613AbjLGGns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjLGGnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:43:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643F137;
        Wed,  6 Dec 2023 22:43:51 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CB8121E1B;
        Thu,  7 Dec 2023 06:43:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD1F313976;
        Thu,  7 Dec 2023 06:43:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id a1MdNKRpcWVPDQAAD6G6ig
        (envelope-from <jgross@suse.com>); Thu, 07 Dec 2023 06:43:48 +0000
Message-ID: <ed0729b6-8896-41cb-87fc-9111afc68151@suse.com>
Date:   Thu, 7 Dec 2023 07:43:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Content-Language: en-US
To:     Stefano Stabellini <sstabellini@kernel.org>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc:     Jan Beulich <jbeulich@suse.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Stabellini, Stefano" <stefano.stabellini@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-3-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop>
 <ZWiyBP4Lzz5lXraP@macbook>
 <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
 <ZWmgJNidFsfkDp7q@macbook>
 <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop>
 <ZW2ptexPQXrWBiOS@macbook>
 <alpine.DEB.2.22.394.2312041413000.110490@ubuntu-linux-20-04-desktop>
 <ZW7rDjjC0gxEI1cq@macbook> <15275706-5c31-4e29-aa29-9f5e90526219@suse.com>
 <BL1PR12MB5849C871B0B9577D1E0BF576E784A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <alpine.DEB.2.22.394.2312061818030.1265976@ubuntu-linux-20-04-desktop>
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
In-Reply-To: <alpine.DEB.2.22.394.2312061818030.1265976@ubuntu-linux-20-04-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------C0PSzc0vkP7HoL45f5JNvA73"
X-Rspamd-Queue-Id: 7CB8121E1B
X-Spam-Score: 15.00
X-Spamd-Result: default: False [15.00 / 50.00];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
         HAS_ATTACHMENT(0.00)[];
         ARC_NA(0.00)[];
         MIME_BASE64_TEXT_BOGUS(1.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         MX_GOOD(-0.01)[];
         MIME_BASE64_TEXT(0.10)[];
         RCPT_COUNT_TWELVE(0.00)[21];
         SIGNED_PGP(-2.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         MIME_UNKNOWN(0.10)[application/pgp-keys]
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of jgross@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=jgross@suse.com
X-Rspamd-Server: rspamd1
X-Spam: Yes
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------C0PSzc0vkP7HoL45f5JNvA73
Content-Type: multipart/mixed; boundary="------------F8iAGw8AGSFDCfHq3IpTt9ap";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Jan Beulich <jbeulich@suse.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Stabellini, Stefano" <stefano.stabellini@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Message-ID: <ed0729b6-8896-41cb-87fc-9111afc68151@suse.com>
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-3-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop>
 <ZWiyBP4Lzz5lXraP@macbook>
 <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
 <ZWmgJNidFsfkDp7q@macbook>
 <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop>
 <ZW2ptexPQXrWBiOS@macbook>
 <alpine.DEB.2.22.394.2312041413000.110490@ubuntu-linux-20-04-desktop>
 <ZW7rDjjC0gxEI1cq@macbook> <15275706-5c31-4e29-aa29-9f5e90526219@suse.com>
 <BL1PR12MB5849C871B0B9577D1E0BF576E784A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <alpine.DEB.2.22.394.2312061818030.1265976@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2312061818030.1265976@ubuntu-linux-20-04-desktop>

--------------F8iAGw8AGSFDCfHq3IpTt9ap
Content-Type: multipart/mixed; boundary="------------s057rkIjgnPzUMCdRntGVAzT"

--------------s057rkIjgnPzUMCdRntGVAzT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMTIuMjMgMDM6MTgsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gVHVl
LCA1IERlYyAyMDIzLCBDaGVuLCBKaXFpYW4gd3JvdGU6DQo+PiBXaGVuIFBWSCBkb20wIGVu
YWJsZSBhIGRldmljZSwgaXQgd2lsbCBnZXQgdHJpZ2dlciBhbmQgcG9sYXJpdHkgZnJvbSBB
Q1BJIChzZWUgYWNwaV9wY2lfaXJxX2VuYWJsZSkNCj4+IEkgaGF2ZSBhIHZlcnNpb24gb2Yg
cGF0Y2ggd2hpY2ggdHJpZWQgdGhhdCB3YXksIHNlZSBiZWxvdzoNCj4gDQo+IFRoaXMgYXBw
cm9hY2ggbG9va3MgbXVjaCBiZXR0ZXIuIEkgdGhpbmsgdGhpcyBwYXRjaCBpcyBPS2lzaC4g
SnVlcmdlbiwNCj4gd2hhdCBkbyB5b3UgdGhpbms/DQoNClRoZSBhcHByb2FjaCBzZWVtcyB0
byBiZSBmaW5lLg0KDQoNCkp1ZXJnZW4NCg0KPiANCj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYveGVuL2VubGlnaHRlbl9wdmguYyBiL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHZo
LmMNCj4+IGluZGV4IGFkYTM4NjhjMDJjMi4uNDNlMWJkYTlmOTQ2IDEwMDY0NA0KPj4gLS0t
IGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdmguYw0KPj4gKysrIGIvYXJjaC94ODYveGVu
L2VubGlnaHRlbl9wdmguYw0KPj4gQEAgLTEsNiArMSw3IEBADQo+PiAgIC8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+PiAgICNpbmNsdWRlIDxsaW51eC9hY3BpLmg+
DQo+PiAgICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgv
cGNpLmg+DQo+Pg0KPj4gICAjaW5jbHVkZSA8eGVuL2h2Yy1jb25zb2xlLmg+DQo+Pg0KPj4g
QEAgLTI1LDYgKzI2LDEyNyBAQA0KPj4gICBib29sIF9fcm9fYWZ0ZXJfaW5pdCB4ZW5fcHZo
Ow0KPj4gICBFWFBPUlRfU1lNQk9MX0dQTCh4ZW5fcHZoKTsNCj4+DQo+PiArdHlwZWRlZiBz
dHJ1Y3QgZ3NpX2luZm8gew0KPj4gKyAgICAgICBpbnQgZ3NpOw0KPj4gKyAgICAgICBpbnQg
dHJpZ2dlcjsNCj4+ICsgICAgICAgaW50IHBvbGFyaXR5Ow0KPj4gKyAgICAgICBpbnQgcGly
cTsNCj4+ICt9IGdzaV9pbmZvX3Q7DQo+PiArDQo+PiArc3RydWN0IGFjcGlfcHJ0X2VudHJ5
IHsNCj4+ICsgICAgICAgc3RydWN0IGFjcGlfcGNpX2lkICAgICAgaWQ7DQo+PiArICAgICAg
IHU4ICAgICAgICAgICAgICAgICAgICAgIHBpbjsNCj4+ICsgICAgICAgYWNwaV9oYW5kbGUg
ICAgICAgICAgICAgbGluazsNCj4+ICsgICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAg
aW5kZXg7ICAgICAgICAgIC8qIEdTSSwgb3IgbGluayBfQ1JTIGluZGV4ICovDQo+PiArfTsN
Cj4+ICsNCj4+ICtzdGF0aWMgaW50IHhlbl9wdmhfZ2V0X2dzaV9pbmZvKHN0cnVjdCBwY2lf
ZGV2ICpkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZ3NpX2luZm9fdCAqZ3NpX2luZm8pDQo+PiArew0K
Pj4gKyAgICAgICBpbnQgZ3NpOw0KPj4gKyAgICAgICB1OCBwaW4gPSAwOw0KPj4gKyAgICAg
ICBzdHJ1Y3QgYWNwaV9wcnRfZW50cnkgKmVudHJ5Ow0KPj4gKyAgICAgICBpbnQgdHJpZ2dl
ciA9IEFDUElfTEVWRUxfU0VOU0lUSVZFOw0KPj4gKyAgICAgICBpbnQgcG9sYXJpdHkgPSBh
Y3BpX2lycV9tb2RlbCA9PSBBQ1BJX0lSUV9NT0RFTF9HSUMgPw0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBBQ1BJX0FDVElWRV9ISUdIIDogQUNQSV9BQ1RJ
VkVfTE9XOw0KPj4gKw0KPj4gKyAgICAgICBpZiAoZGV2KQ0KPj4gKyAgICAgICAgICAgICAg
IHBpbiA9IGRldi0+cGluOw0KPj4gKyAgICAgICBpZiAoIXBpbikgew0KPj4gKyAgICAgICAg
ICAgICAgIHhlbl9yYXdfcHJpbnRrKCJObyBpbnRlcnJ1cHQgcGluIGNvbmZpZ3VyZWRcbiIp
Ow0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gKyAgICAgICB9DQo+
PiArDQo+PiArICAgICAgIGVudHJ5ID0gYWNwaV9wY2lfaXJxX2xvb2t1cChkZXYsIHBpbik7
DQo+PiArICAgICAgIGlmIChlbnRyeSkgew0KPj4gKyAgICAgICAgICAgICAgIGlmIChlbnRy
eS0+bGluaykNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGdzaSA9IGFjcGlfcGNpX2xp
bmtfYWxsb2NhdGVfaXJxKGVudHJ5LT5saW5rLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW50cnktPmluZGV4LA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJnRyaWdnZXIsICZwb2xhcml0eSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOw0KPj4gKyAgICAgICAgICAg
ICAgIGVsc2UNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGdzaSA9IGVudHJ5LT5pbmRl
eDsNCj4+ICsgICAgICAgfSBlbHNlDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+PiArDQo+PiArICAgICAgIGdzaV9pbmZvLT5nc2kgPSBnc2k7DQo+PiArICAgICAg
IGdzaV9pbmZvLT50cmlnZ2VyID0gdHJpZ2dlcjsNCj4+ICsgICAgICAgZ3NpX2luZm8tPnBv
bGFyaXR5ID0gcG9sYXJpdHk7DQo+PiArDQo+PiArICAgICAgIHJldHVybiAwOw0KPj4gK30N
Cj4+ICsNCj4+ICtzdGF0aWMgaW50IHhlbl9wdmhfbWFwX3BpcnEoZ3NpX2luZm9fdCAqZ3Np
X2luZm8pDQo+PiArew0KPj4gKyAgICAgICBzdHJ1Y3QgcGh5c2Rldl9tYXBfcGlycSBtYXBf
aXJxOw0KPj4gKyAgICAgICBpbnQgcmV0Ow0KPj4gKw0KPj4gKyAgICAgICBtYXBfaXJxLmRv
bWlkID0gRE9NSURfU0VMRjsNCj4+ICsgICAgICAgbWFwX2lycS50eXBlID0gTUFQX1BJUlFf
VFlQRV9HU0k7DQo+PiArICAgICAgIG1hcF9pcnEuaW5kZXggPSBnc2lfaW5mby0+Z3NpOw0K
Pj4gKyAgICAgICBtYXBfaXJxLnBpcnEgPSBnc2lfaW5mby0+Z3NpOw0KPj4gKw0KPj4gKyAg
ICAgICByZXQgPSBIWVBFUlZJU09SX3BoeXNkZXZfb3AoUEhZU0RFVk9QX21hcF9waXJxLCAm
bWFwX2lycSk7DQo+PiArICAgICAgIGdzaV9pbmZvLT5waXJxID0gbWFwX2lycS5waXJxOw0K
Pj4gKw0KPj4gKyAgICAgICByZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMg
aW50IHhlbl9wdmhfdW5tYXBfcGlycShnc2lfaW5mb190ICpnc2lfaW5mbykNCj4+ICt7DQo+
PiArICAgICAgIHN0cnVjdCBwaHlzZGV2X3VubWFwX3BpcnEgdW5tYXBfaXJxOw0KPj4gKw0K
Pj4gKyAgICAgICB1bm1hcF9pcnEuZG9taWQgPSBET01JRF9TRUxGOw0KPj4gKyAgICAgICB1
bm1hcF9pcnEucGlycSA9IGdzaV9pbmZvLT5waXJxOw0KPj4gKw0KPj4gKyAgICAgICByZXR1
cm4gSFlQRVJWSVNPUl9waHlzZGV2X29wKFBIWVNERVZPUF91bm1hcF9waXJxLCAmdW5tYXBf
aXJxKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCB4ZW5fcHZoX3NldHVwX2dzaShn
c2lfaW5mb190ICpnc2lfaW5mbykNCj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBwaHlzZGV2
X3NldHVwX2dzaSBzZXR1cF9nc2k7DQo+PiArDQo+PiArICAgICAgIHNldHVwX2dzaS5nc2kg
PSBnc2lfaW5mby0+Z3NpOw0KPj4gKyAgICAgICBzZXR1cF9nc2kudHJpZ2dlcmluZyA9IChn
c2lfaW5mby0+dHJpZ2dlciA9PSBBQ1BJX0VER0VfU0VOU0lUSVZFID8gMCA6IDEpOw0KPj4g
KyAgICAgICBzZXR1cF9nc2kucG9sYXJpdHkgPSAoZ3NpX2luZm8tPnBvbGFyaXR5ID09IEFD
UElfQUNUSVZFX0hJR0ggPyAwIDogMSk7DQo+PiArDQo+PiArICAgICAgIHJldHVybiBIWVBF
UlZJU09SX3BoeXNkZXZfb3AoUEhZU0RFVk9QX3NldHVwX2dzaSwgJnNldHVwX2dzaSk7DQo+
PiArfQ0KPj4gKw0KPj4gK2ludCB4ZW5fcHZoX3Bhc3N0aHJvdWdoX2dzaShzdHJ1Y3QgcGNp
X2RldiAqZGV2KQ0KPj4gK3sNCj4+ICsgICAgICAgaW50IHJldDsNCj4+ICsgICAgICAgZ3Np
X2luZm9fdCBnc2lfaW5mbzsNCj4+ICsNCj4+ICsgICAgICAgaWYgKCFkZXYpIHsNCj4+ICsg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICsgICAgICAgfQ0KPj4gKw0KPj4g
KyAgICAgICByZXQgPSB4ZW5fcHZoX2dldF9nc2lfaW5mbyhkZXYsICZnc2lfaW5mbyk7DQo+
PiArICAgICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgICAgICAgICB4ZW5fcmF3X3ByaW50
aygiRmFpbCB0byBnZXQgZ3NpIGluZm8hXG4iKTsNCj4+ICsgICAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPj4gKyAgICAgICB9DQo+PiArDQo+PiArICAgICAgIHJldCA9IHhlbl9wdmhf
bWFwX3BpcnEoJmdzaV9pbmZvKTsNCj4+ICsgICAgICAgaWYgKHJldCkgew0KPj4gKyAgICAg
ICAgICAgICAgIHhlbl9yYXdfcHJpbnRrKCJGYWlsIHRvIG1hcCBwaXJxIGZvciBnc2kgKCVk
KSFcbiIsIGdzaV9pbmZvLmdzaSk7DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4+ICsgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICByZXQgPSB4ZW5fcHZoX3NldHVwX2dz
aSgmZ3NpX2luZm8pOw0KPj4gKyAgICAgICBpZiAocmV0ID09IC1FRVhJU1QpIHsNCj4+ICsg
ICAgICAgICAgICAgICByZXQgPSAwOw0KPj4gKyAgICAgICAgICAgICAgIHhlbl9yYXdfcHJp
bnRrKCJBbHJlYWR5IHNldHVwIHRoZSBHU0kgOiV1XG4iLCBnc2lfaW5mby5nc2kpOw0KPj4g
KyAgICAgICB9IGVsc2UgaWYgKHJldCkgew0KPj4gKyAgICAgICAgICAgICAgIHhlbl9yYXdf
cHJpbnRrKCJGYWlsIHRvIHNldHVwIGdzaSAoJWQpIVxuIiwgZ3NpX2luZm8uZ3NpKTsNCj4+
ICsgICAgICAgICAgICAgICB4ZW5fcHZoX3VubWFwX3BpcnEoJmdzaV9pbmZvKTsNCj4+ICsg
ICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICByZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICtFWFBP
UlRfU1lNQk9MX0dQTCh4ZW5fcHZoX3Bhc3N0aHJvdWdoX2dzaSk7DQo+PiArDQo+PiAgIHZv
aWQgX19pbml0IHhlbl9wdmhfaW5pdChzdHJ1Y3QgYm9vdF9wYXJhbXMgKmJvb3RfcGFyYW1z
KQ0KPj4gICB7DQo+PiAgICAgICAgICB1MzIgbXNyOw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYWNwaS9wY2lfaXJxLmMgYi9kcml2ZXJzL2FjcGkvcGNpX2lycS5jDQo+PiBpbmRleCBm
ZjMwY2VjYTIyMDMuLjYzMGZlMGEzNGJjNiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYWNw
aS9wY2lfaXJxLmMNCj4+ICsrKyBiL2RyaXZlcnMvYWNwaS9wY2lfaXJxLmMNCj4+IEBAIC0y
ODgsNyArMjg4LDcgQEAgc3RhdGljIGludCBhY3BpX3Jlcm91dGVfYm9vdF9pbnRlcnJ1cHQo
c3RydWN0IHBjaV9kZXYgKmRldiwNCj4+ICAgfQ0KPj4gICAjZW5kaWYgLyogQ09ORklHX1g4
Nl9JT19BUElDICovDQo+Pg0KPj4gLXN0YXRpYyBzdHJ1Y3QgYWNwaV9wcnRfZW50cnkgKmFj
cGlfcGNpX2lycV9sb29rdXAoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IHBpbikNCj4+ICtz
dHJ1Y3QgYWNwaV9wcnRfZW50cnkgKmFjcGlfcGNpX2lycV9sb29rdXAoc3RydWN0IHBjaV9k
ZXYgKmRldiwgaW50IHBpbikNCj4+ICAgew0KPj4gICAgICAgICAgc3RydWN0IGFjcGlfcHJ0
X2VudHJ5ICplbnRyeSA9IE5VTEw7DQo+PiAgICAgICAgICBzdHJ1Y3QgcGNpX2RldiAqYnJp
ZGdlOw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9zdHVi
LmMgYi9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jDQo+PiBpbmRleCBlMzRi
NjIzZTRiNDEuLjFhYmQ0ZGFkNmY0MCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL3hl
bi1wY2liYWNrL3BjaV9zdHViLmMNCj4+ICsrKyBiL2RyaXZlcnMveGVuL3hlbi1wY2liYWNr
L3BjaV9zdHViLmMNCj4+IEBAIC0yMCw2ICsyMCw3IEBADQo+PiAgICNpbmNsdWRlIDxsaW51
eC9hdG9taWMuaD4NCj4+ICAgI2luY2x1ZGUgPHhlbi9ldmVudHMuaD4NCj4+ICAgI2luY2x1
ZGUgPHhlbi9wY2kuaD4NCj4+ICsjaW5jbHVkZSA8eGVuL2FjcGkuaD4NCj4+ICAgI2luY2x1
ZGUgPHhlbi94ZW4uaD4NCj4+ICAgI2luY2x1ZGUgPGFzbS94ZW4vaHlwZXJ2aXNvci5oPg0K
Pj4gICAjaW5jbHVkZSA8eGVuL2ludGVyZmFjZS9waHlzZGV2Lmg+DQo+PiBAQCAtMzk5LDYg
KzQwMCwxMiBAQCBzdGF0aWMgaW50IHBjaXN0dWJfaW5pdF9kZXZpY2Uoc3RydWN0IHBjaV9k
ZXYgKmRldikNCj4+ICAgICAgICAgIGlmIChlcnIpDQo+PiAgICAgICAgICAgICAgICAgIGdv
dG8gY29uZmlnX3JlbGVhc2U7DQo+Pg0KPj4gKyAgICAgICBpZiAoeGVuX2luaXRpYWxfZG9t
YWluKCkgJiYgeGVuX3B2aF9kb21haW4oKSkgew0KPj4gKyAgICAgICAgICAgICAgIGVyciA9
IHhlbl9wdmhfcGFzc3Rocm91Z2hfZ3NpKGRldik7DQo+PiArICAgICAgICAgICAgICAgaWYg
KGVycikNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gY29uZmlnX3JlbGVhc2U7
DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICAgICAgICAgIGlmIChkZXYtPm1zaXhfY2FwKSB7
DQo+PiAgICAgICAgICAgICAgICAgIHN0cnVjdCBwaHlzZGV2X3BjaV9kZXZpY2UgcHBkZXYg
PSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgLnNlZyA9IHBjaV9kb21haW5fbnIo
ZGV2LT5idXMpLA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYWNwaS5oIGIvaW5j
bHVkZS9saW51eC9hY3BpLmgNCj4+IGluZGV4IDY0MWRjNDg0Mzk4Ny4uMzY4ZDU2YmEyYzVl
IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9hY3BpLmgNCj4+ICsrKyBiL2luY2x1
ZGUvbGludXgvYWNwaS5oDQo+PiBAQCAtMzc1LDYgKzM3NSw3IEBAIHZvaWQgYWNwaV91bnJl
Z2lzdGVyX2dzaSAodTMyIGdzaSk7DQo+Pg0KPj4gICBzdHJ1Y3QgcGNpX2RldjsNCj4+DQo+
PiArc3RydWN0IGFjcGlfcHJ0X2VudHJ5ICphY3BpX3BjaV9pcnFfbG9va3VwKHN0cnVjdCBw
Y2lfZGV2ICpkZXYsIGludCBwaW4pOw0KPj4gICBpbnQgYWNwaV9wY2lfaXJxX2VuYWJsZSAo
c3RydWN0IHBjaV9kZXYgKmRldik7DQo+PiAgIHZvaWQgYWNwaV9wZW5hbGl6ZV9pc2FfaXJx
KGludCBpcnEsIGludCBhY3RpdmUpOw0KPj4gICBib29sIGFjcGlfaXNhX2lycV9hdmFpbGFi
bGUoaW50IGlycSk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS94ZW4vYWNwaS5oIGIvaW5j
bHVkZS94ZW4vYWNwaS5oDQo+PiBpbmRleCBiMWUxMTg2MzE0NGQuLmNlN2Y1NTU0Zjg4ZSAx
MDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUveGVuL2FjcGkuaA0KPj4gKysrIGIvaW5jbHVkZS94
ZW4vYWNwaS5oDQo+PiBAQCAtNjcsNiArNjcsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgeGVu
X2FjcGlfc2xlZXBfcmVnaXN0ZXIodm9pZCkNCj4+ICAgICAgICAgICAgICAgICAgYWNwaV9z
dXNwZW5kX2xvd2xldmVsID0geGVuX2FjcGlfc3VzcGVuZF9sb3dsZXZlbDsNCj4+ICAgICAg
ICAgIH0NCj4+ICAgfQ0KPj4gK2ludCB4ZW5fcHZoX3Bhc3N0aHJvdWdoX2dzaShzdHJ1Y3Qg
cGNpX2RldiAqZGV2KTsNCj4+ICAgI2Vsc2UNCj4+ICAgc3RhdGljIGlubGluZSB2b2lkIHhl
bl9hY3BpX3NsZWVwX3JlZ2lzdGVyKHZvaWQpDQo+PiAgIHsNCj4+DQo+Pj4NCj4+PiBKYW4N
Cj4+DQo+PiAtLSANCj4+IEJlc3QgcmVnYXJkcywNCj4+IEppcWlhbiBDaGVuLg0KPj4NCg0K

--------------s057rkIjgnPzUMCdRntGVAzT
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------s057rkIjgnPzUMCdRntGVAzT--

--------------F8iAGw8AGSFDCfHq3IpTt9ap--

--------------C0PSzc0vkP7HoL45f5JNvA73
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmVxaaQFAwAAAAAACgkQsN6d1ii/Ey9J
Wgf+OZUvDxMPXqpbWcYsWoxtJvQKv8eDe+y8cWoaT3lIFYkCqHl8BSLdb2VJ/8pN9bGenyZf96aU
07ASqIxcsroIEMpUtGeixD+qI38IujKO3raTZPjg2BO5Qt4v5y4Ukqk73GQb+ZIm5K+9vrQBBKLm
gEs+PZ1Ey/OrJs+JYkmPoJDP0Iw042kUxxT0FY5LN3R9LRCQkFqY0Kb7DYonfJwqMx2YxrlUepma
vShbEUPozNWGgilVil/lU9V8UKPynAVDPp80zXKF29yqBz1kd64XL0S1QL0MKULK1+CXbQ3Dkd+y
2bAjkge1U3hb2QaKeO+SrCrupMTtTUILXsmD7dB0kA==
=T8Na
-----END PGP SIGNATURE-----

--------------C0PSzc0vkP7HoL45f5JNvA73--
