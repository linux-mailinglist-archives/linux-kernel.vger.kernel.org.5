Return-Path: <linux-kernel+bounces-7730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D90981AC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712541C22AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B747B17E9;
	Thu, 21 Dec 2023 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dM8SPboV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE584416
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a1fae88e66eso27031466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 17:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703122944; x=1703727744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQaeuehoPaO3pr13bWE/WXu451v/qATRA3gTcbFlLWc=;
        b=dM8SPboVYxCx22ZWHIV3tXCbezGMEC0Pm9cqzn+8FVnZ2i5iZQrB9GVP/vAbktQlid
         KU9eFNGYkx5zzAufV+jxW2a0TwQgyqNke0z+sB+g2lJj/yG5A971ATonE2P2on8DBqv/
         UeoFwZfyq8H1jGX1cfpc66U+wagYl/YVWWwzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122944; x=1703727744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQaeuehoPaO3pr13bWE/WXu451v/qATRA3gTcbFlLWc=;
        b=t8E38DNkknow1MhW0jY8WFOYN+hQoGrA5VwEPT224kHGEvdPbsegmw4ZQxAsFLrp9a
         XAkMybxtTpi6ayE2Q6Lfjb18GuA2oNZlKxu2QyWnxnZt4joqmyJuBCHK5VNWbbYLSe07
         dRK1wfpMxM+Dv93wiPQIY8TILD3WadOeWb8lQIOoxvg+mcsrhzIiy9u+4KFxi9SRonGm
         rkgByVW2JXmGfI17BcXVSWHjeXLw/tLEs4vBDgukeL0t5PjbsY9DGMh26fqKENIIvZh6
         P/5aKlCDZBcgOAj6wLnLvn90Q8uJPOdvWUIQOwMsDw0189kP94Ieo0vuvIOwzggTQc8y
         LiPQ==
X-Gm-Message-State: AOJu0YzPQ41LXkdYLVzuEGqikPAdavHuz88h1xpixu/kqqVCeuXBQHZ9
	oJqMAe+PXk/FgmTmaUlw9mQjZ6vsvoVmqRyI7E8=
X-Google-Smtp-Source: AGHT+IEbSh1scNxvZPP5p7QB19/NGq79kyZNFBoS727DEsf+zzQ5fgpoMAM2TrZXo1TgVD2zwj8h1w==
X-Received: by 2002:a17:906:1b10:b0:a23:6d76:4c7c with SMTP id o16-20020a1709061b1000b00a236d764c7cmr2230492ejg.107.1703122944355;
        Wed, 20 Dec 2023 17:42:24 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id lc5-20020a170906f90500b00a235dfe6b4fsm400690ejb.204.2023.12.20.17.42.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 17:42:23 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-336695c4317so217396f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 17:42:22 -0800 (PST)
X-Received: by 2002:a05:6000:1cd:b0:336:7ddc:79c8 with SMTP id
 t13-20020a05600001cd00b003367ddc79c8mr294876wrx.1.1703122942318; Wed, 20 Dec
 2023 17:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220090135.1028991-1-yu-hao.lin@nxp.com>
In-Reply-To: <20231220090135.1028991-1-yu-hao.lin@nxp.com>
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 20 Dec 2023 17:42:06 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOLPWfS2M9J7CXWSP=dWw=mVOA41Ti_RGd2kRGTfcrinw@mail.gmail.com>
Message-ID: <CA+ASDXOLPWfS2M9J7CXWSP=dWw=mVOA41Ti_RGd2kRGTfcrinw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: fix uninitialized firmware_stat
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:02=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrot=
e:
>
> Variable firmware_stat is possilbe to be used without initialization.
>
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Fixes: 1c5d463c0770 ("wifi: mwifiex: add extra delay for firmware ready")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202312192236.ZflaWYCw-lkp@intel.com/

Acked-by: Brian Norris <briannorris@chromium.org>

