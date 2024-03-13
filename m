Return-Path: <linux-kernel+bounces-101625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956BA87A998
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496C2281C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6207A290A;
	Wed, 13 Mar 2024 14:36:20 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBEF43153;
	Wed, 13 Mar 2024 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340579; cv=none; b=uOZlfeX2uOPMFAdg5cZvV+COYL9urWbrcDtjzi0fCm2qayZmCMk/vzuc18cCMEqz+9KqEES3LGk4yQONrs0Nq+4rYU6Lh/uVXjdXo2YAmAhyI1qIjmb0lbXQk3bahyKEBmKCQBsDtqhLreTICOo9MPzP0Omii8u99CfN+Bf28TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340579; c=relaxed/simple;
	bh=4kSzgAPS7b/6Qy1T/egELO1W8cCxPyzCB5Q1Lg4QaMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0sm555HRzleukaVCfxuQoFPIjI/ublbtirGPgtD1ifolbK6SXY6DIftsfHjUwSbr+0wxj5y1aRxvBCXhCD90orDa3zxoUwhKHnQqmO1q6NZA60Z0PK0Qbk+oFybiF2yLTXYlaDY9vVFFV6cDwM0+ikAao6LhUtJEgrkLuq8Vik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-220ce420472so2020689fac.1;
        Wed, 13 Mar 2024 07:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710340577; x=1710945377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ/CrXQS2qKyBuyyZ5fVt7Tba0YRofaW6XNtwA1CrZ8=;
        b=At77UDB6BvJhJyeWPTaTPx0Z6Wm2idEuuvnsDnwLrdXVh/GQHr50BsrrI5ui1lZyc8
         Iw3kGJK5G2IRLv0ygy6iQUZ30SWlUqO35fBdbJkiLEhJ/o0lN7EHN0eADmh9zngqw7Jl
         uLNWusqlqA2yMqgMpGoLiXQmTU+RAKu8/95doV+i+e/iJqfn1FWMp9EWby6xTq4DTLGv
         UDlcv540Ihyphexv7EaCivPaPpruHh1/rAYBHPBmm+jXMty5eY+sErYhi0pSZlff7M+H
         E6yXVxxKKcOt/x/ghV+DBbwrOzocRb5g+W0zvLsDZxWMy9nGxo7F1wnfFx5CZl2pYxJn
         p5ag==
X-Forwarded-Encrypted: i=1; AJvYcCU3DBJUgIDjWVoz3ahsBnodKC4AIMIzy5EnFAXZjvoKyxd4DQ82Btbw4snjm0cQQhaD3TnNdxwQ14oA/oQC17O9X3z3nIQaJwX8DBFZPC2977uZBHHQ/DznQU5L6yv+6EiZyT7qsfI=
X-Gm-Message-State: AOJu0YxDtyKopF+8+jKgH2g3qGW8K3w4T64vApTOkiTNAa37UgnMuSK+
	wHvYtdV+I/quNxwI0yfdqn6zE7yjL0N8qY1HzgJIqB2R+BfhwYHWLV7zaggSw3Sn8AsZgRdi/tI
	NSeAQBwCau71B4j+s1nH8LWYeBpc=
X-Google-Smtp-Source: AGHT+IGRTbUgJg5jv7tmdyyZlPs9zAb0SbQS9bjKIAxVdawQ+PEILrXDZWItUu1HzlmpTODLRIqLKHapDaN6Et3CeCg=
X-Received: by 2002:a05:6871:3325:b0:221:cb1b:cc05 with SMTP id
 nf37-20020a056871332500b00221cb1bcc05mr2134168oac.0.1710340577247; Wed, 13
 Mar 2024 07:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8f00bf23-47cb-4656-a326-6d8d1d0d10d6@linaro.org>
In-Reply-To: <8f00bf23-47cb-4656-a326-6d8d1d0d10d6@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Mar 2024 15:36:05 +0100
Message-ID: <CAJZ5v0iSxZMPnCf3MSJMSLXhkfEmDWNVv2eq3PXSivZaYtLMFQ@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal material for v6.9-rc1
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Frank Wunderlich <frank-w@public-files.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Fabio Estevam <festevam@denx.de>, Martin Botka <martin.botka@somainline.org>, 
	Mark Brown <broonie@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Mar 13, 2024 at 3:06=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> The following changes since commit dcb497ec993265dfc5fffa60b486c1ad353e9a=
d5:
>
>    Merge branches 'thermal-core' and 'thermal-intel' (2024-03-07
> 21:05:12 +0100)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.9-rc1
>
> for you to fetch changes up to 1828c1c17bb2adf3a3f26abc69cb3fe971eac0e4:
>
>    thermal/drivers/rcar_gen3: Add support for R-Car V4M (2024-03-11
> 17:14:46 +0100)
>
> ----------------------------------------------------------------
> - Fix memory leak in the error path at probe time in the Mediatek LVTS
>    driver (Christophe Jaillet)
>
> - Fix control buffer enablement regression on Meditek MT7896 (Frank
>    Wunderlich)
>
> - Drop spaces before TABs in different places: thermal-of, ST drivers
>    and Makefile (Geert Uytterhoeven)
>
> - Adjust DT binding for NXP as fsl,tmu-range min/maxItems can vary
>    among several SoC versions (Fabio Estevam)
>
> - Add support for H616 THS controller for the Sun8i platforms. Note
>    that this change relies on another change in the SoC specific code
>    which is included in this branch (Martin Botka)
>
> - Don't fail probe due to zone registration failure because there is
>    no trip points defined in the DT (Mark Brown)
>
> - Support variable TMU array size for new platforms (Peng Fan)
>
> - Adjust the DT binding for thermal-of and make the polling time not
>    required and assume it is zero when not found in the DT (Konrad
>    Dybcio)
>
> - Add r8a779h0 support in both the DT and the driver (Geert Uytterhoeven)
>
> ----------------------------------------------------------------
> Andre Przywara (3):
>        soc: sunxi: sram: export register 0 for THS on H616
>        thermal/drivers/sun8i: Explain unknown H6 register value
>        thermal/drivers/sun8i: Add SRAM register access code
>
> Christophe JAILLET (1):
>        thermal/drivers/mediatek/lvts_thermal: Fix a memory leak in an
> error handling path
>
> Duy Nguyen (1):
>        dt-bindings: thermal: rcar-gen3-thermal: Add r8a779h0 support
>
> Fabio Estevam (1):
>        dt-bindings: thermal: qoriq-thermal: Adjust fsl,tmu-range
> min/maxItems
>
> Frank Wunderlich (1):
>        thermal/drivers/mediatek: Fix control buffer enablement on MT7896
>
> Geert Uytterhoeven (2):
>        thermal: Drop spaces before TABs
>        thermal/drivers/rcar_gen3: Add support for R-Car V4M
>
> Konrad Dybcio (2):
>        dt-bindings: thermal-zones: Don't require polling-delay(-passive)
>        thermal/of: Assume polling-delay(-passive) 0 when absent
>
> Maksim Kiselev (1):
>        thermal/drivers/sun8i: Extend H6 calibration to support 4 sensors
>
> Mark Brown (1):
>        thermal/drivers/sun8i: Don't fail probe due to zone registration
> failure
>
> Martin Botka (2):
>        dt-bindings: thermal: sun8i: Add H616 THS controller
>        thermal/drivers/sun8i: Add support for H616 THS controller
>
> Peng Fan (1):
>        thermal/drivers/qoriq: Fix getting tmu range
>
>   .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |  34 +++--
>   .../devicetree/bindings/thermal/qoriq-thermal.yaml |   3 +-
>   .../bindings/thermal/rcar-gen3-thermal.yaml        |   2 +
>   .../devicetree/bindings/thermal/thermal-zones.yaml |   2 -
>   drivers/soc/sunxi/sunxi_sram.c                     |  22 ++++
>   drivers/thermal/Makefile                           |   2 +-
>   drivers/thermal/mediatek/auxadc_thermal.c          |   3 +
>   drivers/thermal/mediatek/lvts_thermal.c            |   4 +-
>   drivers/thermal/qoriq_thermal.c                    |  12 +-
>   drivers/thermal/rcar_gen3_thermal.c                |   4 +
>   drivers/thermal/st/st_thermal.h                    |  18 +--
>   drivers/thermal/st/st_thermal_memmap.c             |   2 +-
>   drivers/thermal/sun8i_thermal.c                    | 139
> +++++++++++++++++----
>   drivers/thermal/thermal_of.c                       |  14 ++-
>   14 files changed, 203 insertions(+), 58 deletions(-)
>
> --

Pulled, thanks!

