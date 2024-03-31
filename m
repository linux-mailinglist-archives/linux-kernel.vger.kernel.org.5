Return-Path: <linux-kernel+bounces-126378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4A38935FC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 23:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5CF1C21262
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED57F148318;
	Sun, 31 Mar 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M9zBtTSc"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54826AEA
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711920633; cv=none; b=QsDZu1v3vJw/gpZSeG+xRtU9tUclN7fhmAaPwBWkCru+VaybkLotquG/stKqAqECLVcEsW+ORkMMoF1Z6pmo7+ucNwCWNrsVXIVn2GTUYx/lXYZxGJC9uyfzcGeRNwD4BCs2WdhCvvnga7oKSTcpYmQ7t6QvCWVei01jz437aU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711920633; c=relaxed/simple;
	bh=hjG8SPTf/rr2h+XjqAzsDGTKdabLcLfs23sxMbjwxxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rle24RgZ069T0hixHnRPgQjMXCWFgYVvPRKkBbkIxtfnxwLMNvHy7UGhjoXsngcvIFQF7UPeIJHyHPb+z2Haup3SJZX3otKVC/vko6gFNnBWGh5cqSdy5FXB4QlbcuRe2qEHR8ET0K/Nf2h0Uffd4u/+iEWP6d8HFSYTHZpC1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=M9zBtTSc; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2584556a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711920631; x=1712525431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjG8SPTf/rr2h+XjqAzsDGTKdabLcLfs23sxMbjwxxw=;
        b=M9zBtTScBCRGFMrmGdazMz8lT3ziMGKkpH+OVLvnQ15L3WxwRBqXq+9Uc/elJuMC0/
         lPywucGsgCU6Zt0kv3L9kJxRQwny5Z7WW6+l4vKWuaPDm6Vi9CyaY0V1TtyoGljDIPa+
         T6JD5N6Nfhs21gablOU7U6Qy6k/Llonf79XffwzhyrvEG5bxR3ws83nriCmD44D2AI93
         kiitS+5/0w+tDT7Hrt5jFtutv1dEwsUng129gIXK5VKLdx+lo+q0i8cSWglM6Wbgt2R7
         M2EbtkfmSqYAlm0th4ZqJiH0h/OWdP40Ex9tdN0IMqJHoM+JN5s+yw8koBibC/yq1Etc
         H1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711920631; x=1712525431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjG8SPTf/rr2h+XjqAzsDGTKdabLcLfs23sxMbjwxxw=;
        b=KpPdwUpQtZwtbdk01Gj+0vE0oFdtG2iI3Gv1OFqrnl2Wdy+tLORCXudVl3ni9qUK4A
         s1C8Tnp4/VSZg2TzS0y2Aho7d8UV6lXGPU44ZnFPTgmvRtRWCywtqI9S9VpDClZIAR8j
         Pdypz3fE1bG/E3WLQyjYSw4anl3fcRhP6u3Bsu8u4NnAPzujzy7Lykk0F/MGoMROpcbj
         xC+OztH6+otQSDaqQuSSQzvIaFxblV0nhByyIgynRF6x7h0vCd4j3yz1hgMbp6o31lDA
         Hx9GG2CgCATA1ZXOOvpJCZ0cgvjBhE4i0Ok/jHTLlyzRgSvzNOLpauVeCSqiENT8lJdM
         7QWA==
X-Forwarded-Encrypted: i=1; AJvYcCU9QpH3INd62WxhNOhInoxitog9rQw70mJDTJyNzcAoPINNlvDgJ+RGcTz9MoP0Tx3WDpiVJUU1OEgsQtWgYG3Z9J1nzZCDx44AMtaC
X-Gm-Message-State: AOJu0Yz1fvZw2zPViyybRi+U+il3XMamnRFrUFNALQLmjanLTgPkDKUo
	Bctlk1sJvgKjW92NQwkUSE1xaTgsAgzvqapYzCBEezp9S7CCWzjm1NLTOya7QB49e2b70UH14CH
	U8VIFrKeNSYdgE7UaeM6oVML7NZg=
X-Google-Smtp-Source: AGHT+IFOl2eQUDEKSEnuYYa47BveettHtGVprWDJLdBW4K9i5zx/xcE0zrtkjZI3CKVRZqZEktcJne+RnreB2oNwZmc=
X-Received: by 2002:a17:903:2986:b0:1e0:b8b5:5037 with SMTP id
 lm6-20020a170903298600b001e0b8b55037mr10243634plb.69.1711920630781; Sun, 31
 Mar 2024 14:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323231309.415425-1-martin.blumenstingl@googlemail.com>
 <20240323231309.415425-2-martin.blumenstingl@googlemail.com> <117365b8-ece1-4bc0-93f1-3e8c2861758d@salutedevices.com>
In-Reply-To: <117365b8-ece1-4bc0-93f1-3e8c2861758d@salutedevices.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 31 Mar 2024 23:30:19 +0200
Message-ID: <CAFBinCD3Uuchp7ezuML2c5DSuq+OdxG=mk7mjJk2YhetPk63bg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] iio: adc: meson: fix voltage reference selection
 field name typo
To: George Stark <gnstark@salutedevices.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	neil.armstrong@linaro.org, lars@metafoo.de, jic23@kernel.org, 
	linux-amlogic@lists.infradead.org, 
	"kernel@salutedevices.com" <kernel@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi George,

On Tue, Mar 26, 2024 at 12:45=E2=80=AFAM George Stark <gnstark@salutedevice=
s.com> wrote:
>
> Hello Martin
>
> Thanks for the patch
you're welcome

> Should the tag
> Fixes: 90c6241860bf ("iio: adc: meson: init voltage control bits")
> be added?
My understanding is that "Fixes" is for actual bugfixes. There's no
harm done by a type that's only visible in the driver source (it's not
exposed to DT, userspace or elsewhere).


Best regards,
Martin

