Return-Path: <linux-kernel+bounces-24731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9961982C179
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7961C2210A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C796DCEC;
	Fri, 12 Jan 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM7i33VK"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDDA6D1DC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9344f30caso4473858b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705069249; x=1705674049; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2sON2zsEgmOr2oRLYLHAKX2KUxW1/7chOQU/DqL3AV4=;
        b=ZM7i33VKYCX1edB2L20HggEYeq92vLAv03XZkFWET0Me19h+/e42BJDieztjJEvEtx
         +Dr8P3Cw5XA+ku9VijxxP+3PIIQ7132NSim5mamdOqCkja5zsEqOiW6eCGP1BP1NkKgv
         sHEVpwCSHOoec0F0ZnIHtzm4XF4T4cJlqFDgz2qTjEkMa8ZIWYRm9ttFedeLyso6myrd
         8LZqO2n7tmILBmYwEjYzcOMquXYcQro414C2B5IFxOpYP0p9cy/hGcc9IoUmmRhuOg51
         jfg6L0Fsdy9of/Vn9h9bCwr6cjXmLSLkQ8aiPdF6QQQ/wlhRl5uvTZECfNB8cLfhbUWp
         v6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705069249; x=1705674049;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2sON2zsEgmOr2oRLYLHAKX2KUxW1/7chOQU/DqL3AV4=;
        b=YiWVCkqgNhyWzgco8lm84uUYomx5lS6a0xWc6JDYiIYiW1o6kUXZI6Q9ub+JOfa2JB
         xpAD/VlTzLTbGv8J9x3zxtss6EviZqccAS6eA3cmmcs2K4ByirrcI5epu9GEUj+XV1Mq
         nA3yQBbbEFhf3iOVMJZXTyzdkQi1Thjmh5bG+pEcVkHwnpQqM7WzsV++7CQP9uwvqCa4
         aHx0MdF7pRovYD0lv3WDYqOM4HAbVLARosEMaItRdtEo3GJQSeCR58lxerCmuJE7JAyQ
         1rTifoHjmoRuh3LBc3bRV1PXRlw3WkRhVjUg/tlf63N8Irgum/AUtI1gEUgzw3HGPG6a
         5muQ==
X-Gm-Message-State: AOJu0YyhxFAX/0WAdGhdzZsED5Pn0LNSQgCyhLK+mya+M89ivqyCDvN8
	hQ02DhE6r7kKGnDqHaH3l2c=
X-Google-Smtp-Source: AGHT+IGEI+FxtB7YCv0q78LKq6Lhf6thYTjYnOOjc2RxTqiVGhRFJeuJkzcDbU6KfHBrh+/NGHAYWQ==
X-Received: by 2002:a05:6a00:3a1c:b0:6d9:baf0:b8a2 with SMTP id fj28-20020a056a003a1c00b006d9baf0b8a2mr1589144pfb.4.1705069249175;
        Fri, 12 Jan 2024 06:20:49 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g26-20020aa79f1a000000b006dab0d72cd0sm3221775pfr.214.2024.01.12.06.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:20:48 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6C65B18503882; Fri, 12 Jan 2024 21:20:45 +0700 (WIB)
Date: Fri, 12 Jan 2024 21:20:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Deliberately sending partial patch sets?
Message-ID: <ZaFKvZg-MtZgbCKA@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YnDQqZwqJe9COSOd"
Content-Disposition: inline


--YnDQqZwqJe9COSOd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Let's say that there is a contributor who wish to send a patch set (e.g.
20-30 patches in the series) to LKML. But instead of sending the full
series, he either do one of the following:

* Send only the cover letter (analogous to movie trailers)
* Send only a few arbitrary patches in a series that are most important
  (e.g. patch [01,04,11,18,23/30]) (analogous to match highlights)
* Send only the first few patches in a series (i.e. subject of one of
  patches says [09/30]) (analogous to sample book chapters)

The rest of patches are behind closed doors (i.e. not sent), possibly
behind charm-priced (pay)walls.

Is the submission like above acceptable (when in review)?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--YnDQqZwqJe9COSOd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZaFKuQAKCRD2uYlJVVFO
oyK3AP9E9wtVBSlPGAo0UtbWhvTCnSDB86LMRwdKtVCcAfIGJAD/dV+/2leBp+jD
89GKopwZUgbpZg+Rv4SkXMeeLXtxbQE=
=UalB
-----END PGP SIGNATURE-----

--YnDQqZwqJe9COSOd--

