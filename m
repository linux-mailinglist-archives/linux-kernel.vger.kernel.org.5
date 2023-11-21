Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66C97F37C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjKUUyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUUyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:54:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2E919E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:54:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78A8C433C7;
        Tue, 21 Nov 2023 20:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700600078;
        bh=GyHN4wCOMA8c6nPwQG+j0NoaqWqZE4TlER9FWsCywLo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l6QuB6h0ZmMyA+kEHo0OihyS7AcrZlKV05jgRPUt0y3RxWlmN2z1O140qnaqpQgmf
         IHu/xhzVG3pcsQAHwHQF1uhjzH5aNMMq9Qq4LHONJfp4dnhJQNazfH6QlSl7GNq5zL
         dFMlIqCh4gWsnHMa0VWTE3JoxhIDmWjk2O4FyieAdPGg0vhiUK4zUqs/HlpfWHApwa
         j6hwjquCTDYnMa1mYZ/lEQcXlVo1hxB+ncICI1GmZtoiBmGDqHotm5MaCgO9LwwVZn
         JPDkiSNChbPGKIsXJxxVvWgHlAIoO+BeHvM3A+E/51prSkA4kqH1yR5McuRJZj821k
         wTtV8xWgF/rPw==
Message-ID: <89f0dbe3a390dd2d49b09c0ff75a142aa44793fd.camel@kernel.org>
Subject: Re: [PATCH v3] sign-file: Fix incorrect return values check
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yusong Gao <a869920004@gmail.com>, davem@davemloft.net,
        dhowells@redhat.com, dwmw2@infradead.org, juergh@proton.me,
        zohar@linux.ibm.com, herbert@gondor.apana.org.au,
        lists@sapience.com, dimitri.ledkov@canonical.com
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Date:   Tue, 21 Nov 2023 22:54:33 +0200
In-Reply-To: <20231121034044.847642-1-a869920004@gmail.com>
References: <20231121034044.847642-1-a869920004@gmail.com>
Autocrypt: addr=jarkko@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-21 at 03:40 +0000, Yusong Gao wrote:
> There are some wrong return values check in sign-file when call
> OpenSSL
> API. The ERR() check cond is wrong because of the program only check
> the
> return value is < 0 instead of <=3D 0. For example:
> 1. CMS_final() return 1 for success or 0 for failure.
> 2. i2d_CMS_bio_stream() returns 1 for success or 0 for failure.
> 3. i2d_TYPEbio() return 1 for success and 0 for failure.
> 4. BIO_free() return 1 for success and 0 for failure.
>=20
> Link: https://www.openssl.org/docs/manmaster/man3/
> Fixes: e5a2e3c84782 ("scripts/sign-file.c: Add support for signing
> with a raw signature")
>=20

No empty line here.

> Signed-off-by: Yusong Gao <a869920004@gmail.com>
> ---
> V1, V2: Clarify the description of git message.
> ---
> =C2=A0scripts/sign-file.c | 12 ++++++------
> =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 598ef5465f82..dcebbcd6bebd 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -322,7 +322,7 @@ int main(int argc, char **argv)
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 CMS_NOSMIMECAP | use_keyid |
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 use_signed_attrs),
> =C2=A0		=C2=A0=C2=A0=C2=A0 "CMS_add1_signer");
> -		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS |
> CMS_BINARY) < 0,
> +		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS |
> CMS_BINARY) <=3D 0,
> =C2=A0		=C2=A0=C2=A0=C2=A0 "CMS_final");
> =C2=A0
> =C2=A0#else
> @@ -341,10 +341,10 @@ int main(int argc, char **argv)
> =C2=A0			b =3D BIO_new_file(sig_file_name, "wb");
> =C2=A0			ERR(!b, "%s", sig_file_name);
> =C2=A0#ifndef USE_PKCS7
> -			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
> +			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) <=3D
> 0,
> =C2=A0			=C2=A0=C2=A0=C2=A0 "%s", sig_file_name);
> =C2=A0#else
> -			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
> +			ERR(i2d_PKCS7_bio(b, pkcs7) <=3D 0,
> =C2=A0			=C2=A0=C2=A0=C2=A0 "%s", sig_file_name);
> =C2=A0#endif
> =C2=A0			BIO_free(b);
> @@ -374,9 +374,9 @@ int main(int argc, char **argv)
> =C2=A0
> =C2=A0	if (!raw_sig) {
> =C2=A0#ifndef USE_PKCS7
> -		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s",
> dest_name);
> +		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) <=3D 0, "%s",
> dest_name);
> =C2=A0#else
> -		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
> +		ERR(i2d_PKCS7_bio(bd, pkcs7) <=3D 0, "%s", dest_name);
> =C2=A0#endif
> =C2=A0	} else {
> =C2=A0		BIO *b;
> @@ -396,7 +396,7 @@ int main(int argc, char **argv)
> =C2=A0	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s",
> dest_name);
> =C2=A0	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) <
> 0, "%s", dest_name);
> =C2=A0
> -	ERR(BIO_free(bd) < 0, "%s", dest_name);
> +	ERR(BIO_free(bd) <=3D 0, "%s", dest_name);
> =C2=A0
> =C2=A0	/* Finally, if we're signing in place, replace the original.
> */
> =C2=A0	if (replace_orig)


BR, Jarkko
