Return-Path: <linux-kernel+bounces-96225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E38758E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595A028684A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C813A26F;
	Thu,  7 Mar 2024 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KcMfZOh9"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB113A256
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845028; cv=none; b=gl4RB0Xd9FVk7w7waD1HpUtQC/pNkYvP6JE1eakyV4J1IvHawRAYLxDu2383rG0zDZMNHAgT/1HBRrfLHlHOMxDKPOLrlhn8BDzgdLe0IgY/8k08J0GvwROOZXc+P5UutYPCPoL61v9g4GgmkhDhb+LQyoFsWTGw2OrqHWSjDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845028; c=relaxed/simple;
	bh=WzIUrKuTcQtnZfN/u8fsJicsMBuji7c9mAvndxpFOI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnzNRTshw7OPEgHAE0CEZlFRmKUVLPAiPlMzm5Y8CRZr++vE5j9BR/+znrdPiqe3UBMvSVpyY4pj4WT57mJBPi6jAo/x6hRuGNr8Jc2IUtPWuYvyUW4F9ne6Mkt8xRV8Ue1kxDPg5ZoDDjFZl/AjOzhnwJejnZHjfgkwF2u3Vqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KcMfZOh9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dcad814986so11320445ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1709845026; x=1710449826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HvgM94yOMQ3al/rhaQFl0ZOyGyu4vO9RcRBauMLLTQ=;
        b=KcMfZOh9DHfIDWuM6gflNbc0j8MXk3mIspVNuysTBni7rVfdQoW9aMN1JlrW7cZNwq
         gMrVjLBA2EUbQ/zf+4L6Ot4oAOYLvA2Qe9MOyb7jfgtZk+McwdjnYhdp8ICpuKW9+qQ1
         Pzvn6cpjY2xoHnKOK/AdUKG5/Ifqtm2ibTRNdTirw0sdxEEokMcdLmeUEo4SvMoelVrQ
         qtndog45NOW2Eirq5HDEuz3FnmLDSc9R8mjwpwwSVLV1onVdBdxT1xRYdSLEjuKBlWA7
         ynXZxXiQDztjZ5xraQLd2Fmp8sEAD9M5oeocsAg/+7xG5MEGQO20QVmjtBA+0efDsrxp
         YFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709845026; x=1710449826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HvgM94yOMQ3al/rhaQFl0ZOyGyu4vO9RcRBauMLLTQ=;
        b=b6V9hwoQhCO5xZbt8uTdRQ9dCHLzfoa/+6OD3Z93Iw6xyU2wJSnu/uWL7AKxuopMu3
         IyGbiwF954Mj1CJ4UuJ4NwSPSUPprmeNEdI6wJB0mtu6JOWG8lbudKnShglV7YjiMkHt
         d/+KOxUuDgW+32DhDM9JoRHxtRUTmYauyxhHwNNy+Y1kbyWhHUliSBBZNVtLQPC/Y/Ym
         /7TH5dqZCTZAmwaC/4GdGqTptfCUiSCLoS80yFvwLBV8AJwVIs55GqYqQbkj1tVtfI8r
         55e2ZO4nEYbX7geqbR+t5BJHKCkmaBu0OY8ugmVA74wzfSSXysCQLAc0g/9FuH83qjvg
         b46g==
X-Forwarded-Encrypted: i=1; AJvYcCW+/7ML/jhe7rqcwhnMJFSIMNnlYMiU5rz9vz+qcjrOLTvsIKYhr9bX0JGX/taoT8+SyAhnBCelB+6yysQV2rJV39WpFZVYPFqJX7L9
X-Gm-Message-State: AOJu0Yx5nNeuqkspAh9uuSLBgsmXvSwDHB8BnQ8XB6nMDJnLER3Mebuu
	3gJD93M9ZRHebZPGlaMCtlVUN3q7NctyN4Wy7FcyT8vOuc2hgeYFSfpl5h5BwCZKSAScmEQRJHz
	P/PMCYabn7G754HG6wMZRhpoCEpqnLio7Y3Q=
X-Google-Smtp-Source: AGHT+IGt7Dqb5XEk2y4DbDdfMCVp5j+FZ950sYjKYa9RjJ9fuWNWUsuIQr2zJX9YLvdoU9GIH/i5pXMEg4OQLRCvLOY=
X-Received: by 2002:a17:902:da92:b0:1dc:cf38:3a92 with SMTP id
 j18-20020a170902da9200b001dccf383a92mr10372068plx.8.1709845026269; Thu, 07
 Mar 2024 12:57:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709621888-3173-1-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1709621888-3173-1-git-send-email-quic_mojha@quicinc.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 7 Mar 2024 21:56:55 +0100
Message-ID: <CAFBinCC2n+Muu2qaAG0PWFj6f+bVFDtHnzm78jSpeodTD47TOg@mail.gmail.com>
Subject: Re: [PATCH] nvmem: meson-mx-efuse: Remove nvmem_device from efuse struct
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, neil.armstrong@linaro.org, 
	khilman@baylibre.com, jbrunet@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Mukesh,

On Tue, Mar 5, 2024 at 7:58=E2=80=AFAM Mukesh Ojha <quic_mojha@quicinc.com>=
 wrote:
>
> nvmem_device is used at one place while registering nvmem
> device and it is not required to be present in efuse struct
> for just this purpose.
>
> Drop nvmem_device and manage with nvmem device stack variable.
I'm generally fine with this approach

[...]
> @@ -223,9 +222,9 @@ static int meson_mx_efuse_probe(struct platform_devic=
e *pdev)
>                 return PTR_ERR(efuse->core_clk);
>         }
>
> -       efuse->nvmem =3D devm_nvmem_register(&pdev->dev, &efuse->config);
> +       nvmem =3D devm_nvmem_register(&pdev->dev, &efuse->config);
But this doesn't compile for me:
  CC      drivers/nvmem/meson-mx-efuse.o
./drivers/nvmem/meson-mx-efuse.c: In function 'meson_mx_efuse_probe':
./drivers/nvmem/meson-mx-efuse.c:252:9: error: 'nvmem' undeclared
(first use in this function)
 252 |         nvmem =3D devm_nvmem_register(&pdev->dev, &efuse->config);


Best regards,
Martin

