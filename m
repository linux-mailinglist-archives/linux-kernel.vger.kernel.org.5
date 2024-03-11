Return-Path: <linux-kernel+bounces-98599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E37877C76
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AAB0B20BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0487A14291;
	Mon, 11 Mar 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqsVZoD6"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DB17557
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148659; cv=none; b=oT9ujkIbx3A8VGz09g6MnCbrcIcr3lJZJcOXamVJ7T3CJolBiv/oNdO0uCq9IbjQy+l1cSJRyYwJKNMRFFS/26rT0Kmo4kgJa1YTDNCH0Y75dbcUVV/sr4IShu7s0VPxCyhzr16ixdYPMEXfE03/5yo7E/FeT+0ehKR2F7SK7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148659; c=relaxed/simple;
	bh=Is/1Xbta9s2UxLfZpz2OSmt7FWUJ8wyiHna4Rm4EUJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKfXnCzcIh+lPwFay6DXeq3EhLScMjDcxp50h4i8aMUXTuPcwb2E3Ar7uN0qGufjb4NggsJHcnv2U7eK/fhxST4RnYohz5yjk2aWgvLOzz/kv3CDQbXOCNngKFWM7p+ttSRhj6oUhzQ07ArnMTwe23FQ56u62SaRXkZG2Dt66g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqsVZoD6; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609408d4b31so39286017b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710148657; x=1710753457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+1SkM0ODd2CKqsVxZGXnA9O/skjPPIIln7iOxk5hQM=;
        b=bqsVZoD6IyKCMnHlxDOUeWOV/+bfgIHsetu8zx/DxN91KpH+DkI60H1vTLW5ndJww+
         GA/wkFM513+EeXHjy3X3DOWpAgkiqbAdLI0aJ+OtPAhkVNLUaEcH1hg1liuWxTcN3318
         3FXlG/z2hVkEMgMyoITOgqnrWr4lA0gEdm8Uu73M4DU/TpDwrd/8OsiEze5zSMYQGtQr
         IIl1OqDgEom76nZoZqmshYknwh1Fp/L3UNX6HcMnYOjOoDKK2+L5uOarAf+1M4hYVZNn
         I3xcJNwSrUVXxF0i03Shjy2p90YieZP7kZT+JImi1tBNaa4vmNXB3poiUhUKXj0WOPm2
         LJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148657; x=1710753457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+1SkM0ODd2CKqsVxZGXnA9O/skjPPIIln7iOxk5hQM=;
        b=oWUvSZlpHRo7lTpmlYCRnsIB5wHhFu0AlQLEnsJ0cigNFj3iIhNjdxcE6+sQp/nve/
         MQIK5MbU5L2rjPjvGraPSMqg5UZpm0AH/tq8aFv52ufdQeUJZ1Z/EkEUbfDIBn8yIEdz
         gXg0U8dCU+QIZhyNurOlASlxEfxzz6Zmct7uUkO3a/EQ5AiiEmL35yvAWlZlY165W1AV
         EbKvvHCF0aQzLxpU5V8m1ie+lLHfWaNo+AsWSNd+w3V34/a+qyDuj+fGDwqopUi8cfxD
         4asVoitzySiPMh5cZF9zqeEKl4T/oCQpOUAHZ5n/FmqeGMMI5exHkgN95yA0zJszdpN6
         2vzA==
X-Forwarded-Encrypted: i=1; AJvYcCX1+5PwwchjDseQQcxe6rxu97kPPVjRoWS7Nwc8RUbbGTrrSPGDb9N5WRn2JretRBXf7ltfyUjBJ8IQ6JAFaH69hYEniHfO7fKVPe+Q
X-Gm-Message-State: AOJu0YwzVy3BbjZUIv4FpBnYtlD6h5RNFI2z86rZNf97lrMivR7T4nxN
	AF04TDZdJzYjY+mta4TTFw+IfyFkIQgzgQ1uIQz/su3VC9zfXmIY+26sUoS4ugodnf5qI79QEkh
	RRVblhizM0E9eg5Z2Jgw6z30J0+U=
X-Google-Smtp-Source: AGHT+IFKKGTpBd3b/HphE+pp0f/oX3wCJ2i4qtFaoZ+Tiib1TohKa+wlIuvcEOog/K/bqRCdFei/1O6RYZg+7urpuJo=
X-Received: by 2002:a25:850d:0:b0:dcf:4793:9a25 with SMTP id
 w13-20020a25850d000000b00dcf47939a25mr4576097ybk.44.1710148656709; Mon, 11
 Mar 2024 02:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305160902.1363835-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240305160902.1363835-1-andriy.shevchenko@linux.intel.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Mon, 11 Mar 2024 10:17:25 +0100
Message-ID: <CAMeQTsbbXxoAtYDPuUdByvBNgs=23tn7ZhYAanCyUtELJq7HBA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drm/gma500: Remove unused intel-mid.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 5:09=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> intel-mid.h is providing some core parts of the South Complex PM,
> which are usually are not used by individual drivers. In particular,
> this driver doesn't use it, so simply remove the unused header.
>

Applied to drm-misc-next

Thanks
Patrik

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpu/drm/gma500/oaktrail_lvds.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma=
500/oaktrail_lvds.c
> index d974d0c60d2a..72191d6f0d06 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
> @@ -11,8 +11,6 @@
>  #include <linux/i2c.h>
>  #include <linux/pm_runtime.h>
>
> -#include <asm/intel-mid.h>
> -
>  #include <drm/drm_edid.h>
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_simple_kms_helper.h>
> --
> 2.43.0.rc1.1.gbec44491f096
>

