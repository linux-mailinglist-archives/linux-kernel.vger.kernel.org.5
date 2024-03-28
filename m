Return-Path: <linux-kernel+bounces-123695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33638890CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D5E1C28DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB7213A266;
	Thu, 28 Mar 2024 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEsPzbYo"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14CA13AD3B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663104; cv=none; b=mvzAlrkaBbbrVwgyo+SrpN9ERNUzvZnNaKZtaAIrua6963CjTVhVi4rdk2Ej85ZoOTNvVMzq06UMjO84SGy5WajPbDCm+juvX8gPf+gYUzmdMEhhCmm/BEihj7SL4k4zaqE1xv0OKUiFj7/zju+r9c73eXmWZ2aiUxTNf7fktTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663104; c=relaxed/simple;
	bh=EVOmIevOY7yIjg6tCh+xVx1hJEYZK8SikqOcoPFgsDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tY4SOtyBFIiT7iZxf4ky2tIlJuDFin00JkTimxQyvAH8vMogYkb9VDJzB96B2bZlyqpMN30e4cq6kvyLNOH5kiI9QGe0qnpi/Gb5AXaSH3M87zGL9rtz4fZuNVyYyvKs4OXN/mgFkzA6nyIiJmwxQRwFvNcEqYlJeQuu8FCL75I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MEsPzbYo; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso2242906a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711663101; x=1712267901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxsKZxZUzuDOnaAX/evvGdiqGyKkkrreXD8So3xuleM=;
        b=MEsPzbYoZIVNx5SGkMZr/mYjmInQ200p5GDl/yCHt/kdEY//fbNsZcTVIxrna3hI+a
         fGaGnCGioOBvTAhXc//7rkfG+uGcXVnXrrx8vP2WzoaIQqyJ5DHcdyp/zunn70pAbNv0
         cGZlfwXpnhqGURPlcSPktJdCWvDISuY1yWFXjErg/KSZtK/abww9gWt8uTJSJ3paZ1kw
         cTYq4GB7Bv/XD49HO30Xh/LuuewG2F0CFzJMDJ75Dx7T6I7y4mBI+n57jbEeHO3Yn0jz
         LI5I3KOiLm2YLu+UtW+ASmq6/VPlvxXJ3jKcwmteDQnT56EDDO3ZIo0cldJ1PYidiI5x
         oqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663101; x=1712267901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxsKZxZUzuDOnaAX/evvGdiqGyKkkrreXD8So3xuleM=;
        b=MaEcU4FcuV6t0XuGaiWy/aT2nNYV+1/UqVsqN8VGTBncrNMYOZAVDT/u8CIZxoEMqF
         90gSX6gZZQ+Oa25qRxG10uowTaVYuONK4fXy2wCK/+seT33NLwo6Cfs79EkBdAi+IDt5
         z0KX5NCBfrqg7GtX8OALlhB5XXLEL46RJvpWSC32RNSB8GtCzVUdGzjNka2zWRf43SEm
         0hoZ1RWwRDB86CJO5mLeSCLUMExfkSDNV9JkTLVAWlQfUITDS4Ui7HnOSeDy0yD65woy
         V9mTPuuFAekmMW5gSxqe3s/4r2NlYLHEtVHk2UsWnbgXOkaJzyVOSO08Rwja6ZwBbGkm
         e1kg==
X-Gm-Message-State: AOJu0YwugZyjPzV7iGRENn+g9mN9krA0OTbW0q6i9PgG78Jms1n1v2Bv
	TUHTDBIMD0TIw8fobgdNCNovIvnms2wRjq0HHnBY0eB2wNcL6+eimVcHV3XiwYm5ZWkckVy58xy
	uMU5BGTMmtqdevdr3fJscv6/qND0XelmOn/Pz
X-Google-Smtp-Source: AGHT+IE0y1seF6MQXvRRM3kwa+kdGhzZ45RQ2GHfTY+7iJdVAkXbLfTYxpaWZJXiKbseniIrUcFPm/SQhMOY2Slfwn4=
X-Received: by 2002:a05:6402:51c9:b0:568:32f7:6c53 with SMTP id
 r9-20020a05640251c900b0056832f76c53mr421604edd.3.1711663100915; Thu, 28 Mar
 2024 14:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-2-arnd@kernel.org>
In-Reply-To: <20240328143051.1069575-2-arnd@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 14:58:08 -0700
Message-ID: <CAFhGd8ortE-ahJD+BDss7qbW-=Hn2_L_r2OZfa0V87mG2KV3+g@mail.gmail.com>
Subject: Re: [PATCH 1/9] dm integrity: fix out-of-range warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Eric Biggers <ebiggers@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Depending on the value of CONFIG_HZ, clang compares about a pointless
> comparison:
>
> drivers/md/dm-integrity.c:4085:12: error: result of comparison of constan=
t 42949672950 with expression of type 'unsigned int' is always false [-Werr=
or,-Wtautological-constant-out-of-range-compare]
>                         if (val >=3D (uint64_t)UINT_MAX * 1000 / HZ) {
>
> As the check remains useful for other configurations, shut up the
> warning by adding a second type cast to uint64_t.

Yeah, nice.

>
> Fixes: 468dfca38b1a ("dm integrity: add a bitmap mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/md/dm-integrity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 37b9f8f1ae1a..7f3dc8ee6ab8 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -4221,7 +4221,7 @@ static int dm_integrity_ctr(struct dm_target *ti, u=
nsigned int argc, char **argv
>                 } else if (sscanf(opt_string, "sectors_per_bit:%llu%c", &=
llval, &dummy) =3D=3D 1) {
>                         log2_sectors_per_bitmap_bit =3D !llval ? 0 : __il=
og2_u64(llval);
>                 } else if (sscanf(opt_string, "bitmap_flush_interval:%u%c=
", &val, &dummy) =3D=3D 1) {
> -                       if (val >=3D (uint64_t)UINT_MAX * 1000 / HZ) {
> +                       if ((uint64_t)val >=3D (uint64_t)UINT_MAX * 1000 =
/ HZ) {
>                                 r =3D -EINVAL;
>                                 ti->error =3D "Invalid bitmap_flush_inter=
val argument";
>                                 goto bad;
> --
> 2.39.2
>

