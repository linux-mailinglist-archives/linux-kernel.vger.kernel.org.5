Return-Path: <linux-kernel+bounces-32498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489D835C65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9E81F25BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E3520DE8;
	Mon, 22 Jan 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gVeE8TLa"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4F210E2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911489; cv=none; b=V2kYq6IkWziHAIaQNdZZU2iMJQPXEdpIur/5cj/Osz5icwsqADRXOCWtJEzzcnbnZdZDJO2iYHbsanXP3qmVD8lLB1P2je4L2thTywU1A8E/daheeS7/poXwY0XAjUluCNyyyUoMv+lfqbK5N1UqXQYLHxd3bHAIeflY/9kZ2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911489; c=relaxed/simple;
	bh=TuCnBVR88ntymG76CNyDH8bqX5RV/3GbHvDE2cVI+k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guA7P4H+FXFN+HMnt5dhprQSV2nWWALvdM2QUQWbMFSqnq7cPhbLAPw7JPucvvA7Dw6Kcj1S3O3ssCr0FjmqmCjCDZzyzgkzh9QaesN7ctnJ1A39hpKIFnjJkIG7cQyn1OYUgcU9LQZXrdA8zXLrsvtQp4vYYqZ1iXGJN50Qcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gVeE8TLa; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50ff9bde634so545383e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705911485; x=1706516285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuCnBVR88ntymG76CNyDH8bqX5RV/3GbHvDE2cVI+k0=;
        b=gVeE8TLaUNQRDxyF2WTF1vJiy3iqct0QQj0FFL9nit8OHr3tOiSvr5PafROA8m9P8W
         uxUIt65ddDIfefLPxFsix1DpSRt4SWRGlNy9o/ZeakcUEdYDAQFKuPD0RtbiNDaRVTDV
         arsS2i2a+VdL98kuW2+9FRLC5Q1RoRE1HU5W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705911485; x=1706516285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuCnBVR88ntymG76CNyDH8bqX5RV/3GbHvDE2cVI+k0=;
        b=Gs/J263ooywXWsPCxTSe6D7f/chXEGT1D2EISF6761C6iGr8A+ppk3V4A8GgiezQMR
         qlh7DwyMs6DqfqT59HOMC7F18mHHx+3hi2vJvw94KIq2gmVIPRL40RgawCscnDqJM8Ja
         LbEX0w4t/ImsPyfy81SF++Gjr0RMlrR3ltFjW8aqM0tfa4GaA1bnS+WSfjRTYqkv1G0V
         JKdjC/6UZ9dOUtuaQXbxAfqgTr08MRmdNnJcVtCjKIBERpj7rcMqfd4S+wx4Q8QPScU5
         XWLGvI/HD0ZWcx9Z3077WJd749GviSK/bErygvpXxFP2HYBLd/44L/ffDrpUXsvqN3+p
         fTHQ==
X-Gm-Message-State: AOJu0YzYFuWJWmOnPOPTdzN7KZIYsV/H3yvl4Hc5/dFAZCDMqWDtmxoV
	DzPYf/cM1/ovawPQHD6L/W8uqcoNCZ0BpPBqNhiBYsp8Wi1xlznRXQSojugwMzEGG3/iUsJdsc8
	PxcGBIqjOM6nuF1kll9Y7TEhVC5jE7Q326YVD
X-Google-Smtp-Source: AGHT+IHqFkBn13JB/hRuAs3sSSx+yTST7ZFxRuIjTeHxb63T26OccgYLsj9ML0Hpe1WxHZ/X75r0bu3mEBfMQsY40Y8=
X-Received: by 2002:a05:6512:3d1c:b0:50e:3f2e:c726 with SMTP id
 d28-20020a0565123d1c00b0050e3f2ec726mr1762337lfv.87.1705911485563; Mon, 22
 Jan 2024 00:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213150435.4134390-1-wenst@chromium.org> <20231213150435.4134390-2-wenst@chromium.org>
 <d16723a6-5602-4fa8-9cfc-589846b75f5b@gmail.com>
In-Reply-To: <d16723a6-5602-4fa8-9cfc-589846b75f5b@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 22 Jan 2024 16:17:54 +0800
Message-ID: <CAGXv+5FVOb_X02ovGgwZ=5YpipiCfO9SKD5hOrx9eweps9bB+Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: arm: mediatek: Sort entries by SoC
 then board compatibles
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Eugen Hristev <eugen.hristev@collabora.com>, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 4:02=E2=80=AFPM Matthias Brugger <matthias.bgg@gmai=
l.com> wrote:
> On 13/12/2023 16:04, Chen-Yu Tsai wrote:
> > Some of the new MediaTek board entries were inserted in a chronological
> > order, or just randomly. This makes it harder to search for an entry.
> >
> > Sort the entries by first grouping by SoC, then sorting by board
> > compatible strings. Also add a comment at the top asking people to do
> > the same.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
>
> Does not apply cleanly, would you mind to rebase the whole series onto v6=
8-rc1.

Sure. There's still a bit of discussion on patch 6. After that is resolved
I'll send a v5 which will also address some review comments.

ChenYu

