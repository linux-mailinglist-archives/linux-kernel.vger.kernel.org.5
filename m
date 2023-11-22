Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FDF7F3ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjKVHVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjKVHVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:21:16 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEDC18E;
        Tue, 21 Nov 2023 23:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1700637669; x=1700896869;
        bh=KQKcYlfUBhynJr4wyR2tBUaN/WN3sfGnek/kUSlXy6w=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=WPDRTlKF+bhvFZ0g1kafvVXKkij1wkDpxk7Sh18WP/+Fhv39hf4OxHZt2O3o8xrGf
         zmfkTIGMu+hAjV4SUqBouBWBq5JBjtHJH8BS8s2f9MB88l7pWEFy1cviU7GlMWJgy3
         ahOog1HXwMJbetb2/I4eNY+IOIXo1FLhYaEb1ihKG1nV9P52Hh3SYxJFOOsSV7kXRT
         Xmr+tQvjTq2Yma/c8cLOpdyHqksSCwa9RnL8OiW+sap9dqwYkwDwXnC8591g/IvjJM
         A3rImSrVl5IIhQuuCu/etRXrWr8Ggdmh5oBXHqHlMfivOTOMLUm4zQB4WJ6azCZWND
         itGuMK4q1lTtA==
Date:   Wed, 22 Nov 2023 07:20:59 +0000
To:     Yusong Gao <a869920004@gmail.com>
From:   Juerg Haefliger <juergh@proton.me>
Cc:     jarkko@kernel.org, davem@davemloft.net, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com,
        herbert@gondor.apana.org.au, lists@sapience.com,
        dimitri.ledkov@canonical.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3] sign-file: Fix incorrect return values check
Message-ID: <20231122082050.7eeea7bd@smeagol>
In-Reply-To: <20231121034044.847642-1-a869920004@gmail.com>
References: <20231121034044.847642-1-a869920004@gmail.com>
Feedback-ID: 45149698:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_5S9CcLAoQ3T185ob3CrIvjzHrp6WwlJzSCP7jwKvM"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--b1_5S9CcLAoQ3T185ob3CrIvjzHrp6WwlJzSCP7jwKvM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Nov 2023 03:40:44 +0000
"Yusong Gao" <a869920004@gmail.com> wrote:

> There are some wrong return values check in sign-file when call OpenSSL
> API. The ERR() check cond is wrong because of the program only check the
> return value is < 0 instead of <=3D 0. For example:
> 1. CMS_final() return 1 for success or 0 for failure.
> 2. i2d_CMS_bio_stream() returns 1 for success or 0 for failure.
> 3. i2d_TYPEbio() return 1 for success and 0 for failure.
> 4. BIO_free() return 1 for success and 0 for failure.

Good catch! In this case I'd probably be more strict and check for '!=3D 1'=
.
See below.

...Juerg


> Link: https://www.openssl.org/docs/manmaster/man3/
> Fixes: e5a2e3c84782 ("scripts/sign-file.c: Add support for signing with a=
 raw signature")
>=20
> Signed-off-by: Yusong Gao <a869920004@gmail.com>
> ---
> V1, V2: Clarify the description of git message.
> ---
>  scripts/sign-file.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 598ef5465f82..dcebbcd6bebd 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -322,7 +322,7 @@ int main(int argc, char **argv)
>  =09=09=09=09     CMS_NOSMIMECAP | use_keyid |
>  =09=09=09=09     use_signed_attrs),
>  =09=09    "CMS_add1_signer");
> -=09=09ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
> +=09=09ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) <=3D 0,

ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) !=3D 1,


>  =09=09    "CMS_final");
>=20
>  #else
> @@ -341,10 +341,10 @@ int main(int argc, char **argv)
>  =09=09=09b =3D BIO_new_file(sig_file_name, "wb");
>  =09=09=09ERR(!b, "%s", sig_file_name);
>  #ifndef USE_PKCS7
> -=09=09=09ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
> +=09=09=09ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) <=3D 0,

ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) !=3D 1,


>  =09=09=09    "%s", sig_file_name);
>  #else
> -=09=09=09ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
> +=09=09=09ERR(i2d_PKCS7_bio(b, pkcs7) <=3D 0,

ERR(i2d_PKCS7_bio(b, pkcs7) !=3D 1,


>  =09=09=09    "%s", sig_file_name);
>  #endif
>  =09=09=09BIO_free(b);
> @@ -374,9 +374,9 @@ int main(int argc, char **argv)
>=20
>  =09if (!raw_sig) {
>  #ifndef USE_PKCS7
> -=09=09ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
> +=09=09ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) <=3D 0, "%s", dest_name);


ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) !=3D 1, "%s", dest_name);


>  #else
> -=09=09ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
> +=09=09ERR(i2d_PKCS7_bio(bd, pkcs7) <=3D 0, "%s", dest_name);

ERR(i2d_PKCS7_bio(bd, pkcs7) !=3D 1, "%s", dest_name);


>  #endif
>  =09} else {
>  =09=09BIO *b;
> @@ -396,7 +396,7 @@ int main(int argc, char **argv)
>  =09ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
>  =09ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", =
dest_name);
>=20
> -=09ERR(BIO_free(bd) < 0, "%s", dest_name);
> +=09ERR(BIO_free(bd) <=3D 0, "%s", dest_name);

ERR(BIO_free(bd) !=3D 1, "%s", dest_name);


>=20
>  =09/* Finally, if we're signing in place, replace the original. */
>  =09if (replace_orig)
> --
> 2.34.1
>=20


--b1_5S9CcLAoQ3T185ob3CrIvjzHrp6WwlJzSCP7jwKvM
Content-Type: application/pgp-signature; name=attachment.sig
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=attachment.sig

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFJekJBRUJDZ0FkRmlFRWhaZlU5Nkl1
cHJ2aUxkZUxEOU9MQ1F1bVFyY0ZBbVZkcTlJQUNna1FEOU9MQ1F1bQ0KUXJlZEx3LytPWFVoVzVK
dTJsdlU5VDJ2TjRrT3d0bUpkb3BBdmdBWld4RnpTYVN1RHRmTTlJVHU4ZHVXNUlNNg0KRCtzeEtM
WUdKbWI5RkFKZ3NRWDFsdFZvSGV1TjJxODFRcTNkRGNDSVBqc2J2dXh4R2NOcHVvQ0V2YU9WWGM2
cw0KeklDazJSelFHd2tNRjNGRy9MNGE3Mmh3RlMxYzhKbm1KZ2ZQbndGYVZhekV6OW5Kb0lqTDF0
bmlNOVF3RjJqWA0KUno1WjhBaFdzdlZHeVlqUEFxYnNKaU9JMlViOFJ0TzFRbnVaT09DYU5YSHM4
RlVwQWMxa1NOQy80UGYyUytuUQ0KQ3JGb0poUEFZVFozTHVFWjhDaHo0dUpFZzFUaGorTGI0ZEdK
eDNtSVBRSEREMzRkMjNhRTJTbTE1c0xCMmRWMA0KZTUyUGxWVlJTTFFmeitjcnJhRE9ZR1lOZllz
UmdGck8vRkdkYlN0aGFTb0hJWkFSNGl6aURSeUxRS3VpNjRLaA0KME9YVFBNcUU3bHRnVzFoM2pQ
WXZEQUhwZ3NjdTRxMHg4R2dlTERhTHhEeVBGcDNqNmxNY2xyQkRSK3pGa1lDTg0KeDVKYWVyS1p6
dUF2ZWpvZ1prNjdNMktmZGIxSGtVWWVGYUpxY2xkWkZVd3p1bFBxWTgzNFZWM1JEUTNtdUduUw0K
SmcxNnl5R3ZBbytkNnhkZXpLRzArU05hU3Y3LzJxSnl0VzFRNUg4OWM1ZlBSYUNUc1lQdGQyY2Fr
OHdsNjhCMQ0KRHFFakN6ZjFKdXdNWTRWVDFUTm8wM201TTVZMDQ2bzhxK002TGxpUUlqb1FqWDZm
d0RnUmJIT25sZW9OVW5IVA0KQU94alRCRElMRU83YVNhbnF4aGJIb00xQ3JST0VpOERlRGJHa3F2
c29NQWVuZE40SzY0PQ0KPWhySVMNCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQ0K

--b1_5S9CcLAoQ3T185ob3CrIvjzHrp6WwlJzSCP7jwKvM--

