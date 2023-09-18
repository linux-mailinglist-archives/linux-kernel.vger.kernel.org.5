Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3601F7A42D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbjIRHen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbjIRHeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:34:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7566B13E;
        Mon, 18 Sep 2023 00:33:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so37526375ad.1;
        Mon, 18 Sep 2023 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695022429; x=1695627229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9axyicU382Wx57Axqhzn+OpOnJ8J96M6SztAroiYJ4=;
        b=iDmLc/LVeWcOJZSo1eeUblrgVfoCgSnIiTI7BpJe2Cgxl93Mazw3wtenohNOsEC0MK
         5HknrHE00ZVU5V481D1nOSNMyfpH0ASYoFwWmcndG3YLV9gH4R3AhHZof2m+e1eT1xuZ
         om5J5fShI+RSK2LYRAqMfjlsFbqgSESG4HctEx7yOuzdmCMa+qgYOl6jSFivQDMuHlT7
         7T5nHjoMBeM4LzYOB2owwRj2e982Bjh2l7DmVtR/lILww4nIP2Mi9ZbKYJ93Hob8FmoZ
         uLFpUzSKEz31borDc/WFEsjcacyIV1TUV3ayLTTn716OHIeGnEInclFg0I2gbTq5oxEg
         bMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695022429; x=1695627229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9axyicU382Wx57Axqhzn+OpOnJ8J96M6SztAroiYJ4=;
        b=LZkzemFNOCLdfiUQLu3cknck27l0OQa/R53Uq1Cd/41kZJCmi5XHwUf67TlFvaaTPI
         yFk6lgHqj64OydVcP/ngMf1YpivKtlqlzaLqSTjmuFtJxeISvDwB/p96uTEhJgCVNt02
         6TYR6A5mexrOEJSEVtv6ohuh4TGmNCGvBDdmbKrbNLpJiM2BX1d/6nFoTWFhzxthTsBq
         mlutGL8Elq5W9PrwB2XNZKLT59pvF001or4HGpCUIU0HJSXU1rR1sTALnEm2pmtSqvC3
         0T3xTWRebDdKKpl/6z0ogtbULFq7CZAu4cddOyJ4Wa7xHSDchIr19C3T+hOCLPL7Lk1N
         neXw==
X-Gm-Message-State: AOJu0Yz0OSiD7dzz7RdaviuP5HHPn1twbEDt2BxPsF/FCmX0gHf2Dxyu
        y5F6yIxT7Gqn++oJtSGtOMA=
X-Google-Smtp-Source: AGHT+IHCvr0c0V4kcGq2yVg4a3uADaAMj0rHY9u126lIOA4UJdIeTedksYARQrYi0Z+KRSTjVSprew==
X-Received: by 2002:a17:903:234e:b0:1c3:d864:d6a8 with SMTP id c14-20020a170903234e00b001c3d864d6a8mr10237307plh.23.1695022428741;
        Mon, 18 Sep 2023 00:33:48 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001b9ecee459csm2290542pld.34.2023.09.18.00.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 00:33:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id ED56980D9E27; Mon, 18 Sep 2023 14:33:43 +0700 (WIB)
Date:   Mon, 18 Sep 2023 14:33:43 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Charles Han <hanchunchao@inspur.com>, <corbet@lwn.net>,
        <djwong@kernel.org>, <dchinner@redhat.com>,
        <allison.henderson@oracle.com>, <bhelgaas@google.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: xfs: Remove repeated word in comments
Message-ID: <ZQf9V5fz5NItte_i@debian.me>
References: <20230918071905.296081-1-hanchunchao@inspur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nGYxsMAcG22j/Khb"
Content-Disposition: inline
In-Reply-To: <20230918071905.296081-1-hanchunchao@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nGYxsMAcG22j/Khb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 03:19:05PM +0800, Charles Han wrote:
> diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Docum=
entation/filesystems/xfs-online-fsck-design.rst
> index 1625d1131093..a0678101a7d0 100644
> --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> @@ -1585,7 +1585,7 @@ The transaction sequence looks like this:
>  2. The second transaction contains a physical update to the free space b=
trees
>     of AG 3 to release the former BMBT block and a second physical update=
 to the
>     free space btrees of AG 7 to release the unmapped file space.
> -   Observe that the the physical updates are resequenced in the correct =
order
> +   Observe that the physical updates are resequenced in the correct order
>     when possible.
>     Attached to the transaction is a an extent free done (EFD) log item.
>     The EFD contains a pointer to the EFI logged in transaction #1 so tha=
t log

I don't see any code comments in that doc. The patch title should have been
"Documentation: xfs: Remove duplicate 'the' in transaction sequence process=
".

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--nGYxsMAcG22j/Khb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQf9UQAKCRD2uYlJVVFO
o5IwAQDHbUekcN12IVObhYxj7ZNBAapn0riFXPkSi8MV+sXE8AEA00EC05unU4u0
HNj0trC03PZGMlKVAAlR96xtaOPZuw8=
=iVTH
-----END PGP SIGNATURE-----

--nGYxsMAcG22j/Khb--
