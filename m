Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4768042C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjLDXrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjLDXr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:47:28 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E78310F;
        Mon,  4 Dec 2023 15:47:31 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfabcbda7bso25329895ad.0;
        Mon, 04 Dec 2023 15:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701733651; x=1702338451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gphLFD3StfVvSAYt1zjXPlM1pfegurD/W83pLMCAJCg=;
        b=ECgQlK3yV72+QeFURVQqAgFlihMMrmG6SWaTSt4tuIZpG7WS6imOmcjkjrWIerDpTy
         sLCryMyrWxJ7TFshx86C+iXUN4TSxfkGSDG5Kg27htMDTbg9A8ofeoLilWuW+aNHgPz7
         zHfVpRSFVsmYYczkJDPKH9zDTDWPsk6s1sjs/QWSfPows6zp3bvda4y9PU4qwPsHkW1J
         +Nsbo2K4ta3Gmb0u3M3zZqyd9dk2esxgnpIjBsQ1Giao3YpGFlOlG+VsQPRhQmi3toEL
         5vl3OMbgj+JGHy57ohI/T2rYNo8ML5x+XZp1CobRP/2viO/VIZkEwWTL8C8fJ07VlJRC
         bILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733651; x=1702338451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gphLFD3StfVvSAYt1zjXPlM1pfegurD/W83pLMCAJCg=;
        b=XTp1K8SeSCNAx/17w1LTduTUW3aIWexk9c3owxC/Ajly4u/Rxt+FSKxahVx+uOhrCO
         knl1UM+MLVNjyFT07VcjqzMbp5OfP/uA7q+mwg6Q+2JO5WAQat6JQXPJyUXk6bPN2iEL
         QkRdfp7gQRFsoXz8YoiLNdXJ6LVyY2VTotdDd574UcAsC0La+zvEPdnA5MYqQlc02OHI
         wIZO4Bmisfv0AmmexR5OuDiXjaF83PzFGwsvHXDM/7AD4fwhEoBtGWq2L2QzzSXA+rVp
         F/H6H8IMSSxlFmHJWywTHl2pLtdyrOCFzETHYnYZWeL/vvOAsbVuvjQcACwBdDzgp34G
         Tgzg==
X-Gm-Message-State: AOJu0Yzw1PgpDPI3tGIjjSwVGIZ/XBRpqdWvXS05CBMUrJzic0cu8Syg
        +fXjEAcUURuyPIIAO3x6/88=
X-Google-Smtp-Source: AGHT+IFCuY0x1KsDmRlv1VupknATBmVkZUnttorhhgIp+4H6iQ/mKnipNcSb27Ih+5on1562bCepXQ==
X-Received: by 2002:a17:902:ac88:b0:1d0:6ffd:6123 with SMTP id h8-20020a170902ac8800b001d06ffd6123mr577670plr.69.1701733650595;
        Mon, 04 Dec 2023 15:47:30 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001cf9ddd3552sm7020503plb.85.2023.12.04.15.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 15:47:30 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id CD54B102124C0; Tue,  5 Dec 2023 06:47:26 +0700 (WIB)
Date:   Tue, 5 Dec 2023 06:47:26 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Laight <David.Laight@aculab.com>,
        attreyee-muk <tintinm2017@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3] locking: Document that some lock types must stay
 alive during unlock
Message-ID: <ZW5lDougvHxM_F64@archie.me>
References: <20231204132259.112152-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MqPrBdX8kks83CUm"
Content-Disposition: inline
In-Reply-To: <20231204132259.112152-1-jannh@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MqPrBdX8kks83CUm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 02:22:59PM +0100, Jann Horn wrote:
> diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/=
locktypes.rst
> index 80c914f6eae7..c9a4bcc967ea 100644
> --- a/Documentation/locking/locktypes.rst
> +++ b/Documentation/locking/locktypes.rst
> @@ -95,6 +95,29 @@ rw_semaphores have a special interface which allows no=
n-owner release for
>  readers.
> =20
> =20
> +Releasing and freeing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +For some lock types, such as spinlocks, the lock release operation is de=
signed
> +to allow another concurrent task to free the lock as soon as the lock ha=
s been
> +released - in other words, similarly to refcounts, the unlock operation =
will not
> +access the lock object anymore after marking it as unlocked.
> +
> +This behavior is guaranteed for:
> +
> + - spinlock_t (including in PREEMPT_RT kernels, where spinlock_t is
> +   implemented as an rtmutex)
> +
> +There are other lock types where the lock release operation makes no such
> +guarantee and the caller must ensure that the lock is not destroyed befo=
re the
> +unlock operation has returned.
> +Most sleeping locks are in this category.
> +
> +This is the case in particular for (not an exhaustive list):
> +
> + - mutex
> + - rw_semaphore
> +
> +
>  rtmutex
>  =3D=3D=3D=3D=3D=3D=3D
> =20
> diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locki=
ng/mutex-design.rst
> index 78540cd7f54b..bbb4c4d56ed0 100644
> --- a/Documentation/locking/mutex-design.rst
> +++ b/Documentation/locking/mutex-design.rst
> @@ -101,6 +101,8 @@ features that make lock debugging easier and faster:
>      - Detects multi-task circular deadlocks and prints out all affected
>        locks and tasks (and only those tasks).
> =20
> +The mutex user must ensure that the mutex is not destroyed while a unlock
> +operation is still in progress, see Documentation/locking/locktypes.rst.
> =20
>  Interfaces
>  ----------
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 2deeeca3e71b..fa4834dba407 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -532,6 +532,11 @@ static noinline void __sched __mutex_unlock_slowpath=
(struct mutex *lock, unsigne
>   * This function must not be used in interrupt context. Unlocking
>   * of a not locked mutex is not allowed.
>   *
> + * The caller must ensure that the mutex stays alive until this function=
 has
> + * returned - mutex_unlock() can NOT directly be used to release an obje=
ct such
> + * that another concurrent task can free it.
> + * See Documentation/locking/locktypes.rst.
> + *
>   * This function is similar to (but not equivalent to) up().
>   */
>  void __sched mutex_unlock(struct mutex *lock)
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 2340b6d90ec6..cbc00a269deb 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1615,6 +1615,11 @@ EXPORT_SYMBOL(down_write_trylock);
> =20
>  /*
>   * release a read lock
> + *
> + * The caller must ensure that the rw_semaphore stays alive until this f=
unction
> + * has returned - up_read() can NOT directly be used to release an objec=
t such
> + * that another concurrent task can free it.
> + * See Documentation/locking/locktypes.rst.
>   */
>  void up_read(struct rw_semaphore *sem)
>  {
> @@ -1625,6 +1630,11 @@ EXPORT_SYMBOL(up_read);
> =20
>  /*
>   * release a write lock
> + *
> + * The caller must ensure that the rw_semaphore stays alive until this f=
unction
> + * has returned - up_write() can NOT directly be used to release an obje=
ct such
> + * that another concurrent task can free it.
> + * See Documentation/locking/locktypes.rst.
>   */
>  void up_write(struct rw_semaphore *sem)
>  {
>=20
> base-commit: 3b47bc037bd44f142ac09848e8d3ecccc726be99

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--MqPrBdX8kks83CUm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZW5lCQAKCRD2uYlJVVFO
o7AGAQCxQDdMoa5qBDqARjHmnVOnNfr5hLFNc01F/umPrzGkMgEAor3qQvguVhl0
e5AsPgqRXBFgIiZaZUP5vLbL1m+K5wY=
=ZAi5
-----END PGP SIGNATURE-----

--MqPrBdX8kks83CUm--
