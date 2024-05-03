Return-Path: <linux-kernel+bounces-167408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266388BA920
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D546D2816C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232D14A61A;
	Fri,  3 May 2024 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wH8k20xP"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3DD14A0AC
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725852; cv=none; b=rYJolzXtP/9JW+k0p1WOxV4NcJMdrjI+8Yt6O2ELsh4x+G7oksCVPaMQ07rxV0owrPQbKg4DBC7ryEv2hLTB8nf/6wmEnr6uyuWwQ4Ri4/zyHFkBECdEqVOdEH9HYg+Ve1IqUnQ0lXpyE/v+48mJyViLINXQasKeu60cZZJo4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725852; c=relaxed/simple;
	bh=BKji8dql2Q7HB9ydxb8y51caf9/agXzCr0gG3HSWZek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2mZfJzx2l+Fh3xkYzL+XxBKyXUL9ww+HxD6v3tCQBaKNDQHr3NM88mdvGhLl9QDBPlvu5bpJ9G72nuc0rSNPX6kx1Ggjt9381jybYAG2d6++E2rdio2m785/5mnH3T1uDCfR1NdlJ0ZlL+DJ8mdzRuA+10HI1BWyLYm1g5QtaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wH8k20xP; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de61424f478so4071643276.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714725848; x=1715330648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKji8dql2Q7HB9ydxb8y51caf9/agXzCr0gG3HSWZek=;
        b=wH8k20xPMsXvOQCwI8eGiHhjiVmW2UZIu1AxM07J2NodowP28Zp2sjwW/eXbBK0CDx
         Yn/XEtfbliKqyS2iTVLT00NXn5n8UP8ReV1u7udr8a3hyhZnQZjNq3cj4souaR98lTAr
         NjWKDYX7kNso8RsRotwMA7ku7+M7QzCZX2ynHAn5fU5kEIxlyyGzTI7ORuQKsddI6ejG
         NfAVMmlH++6p5BOQ/MYCLE+yxfvFB34Rm7EVSF+LWMSRS0Fk6dj3PngDU93gP5DD2q/w
         Hc13IsJ9HB+8dnJ/zvXQgnVpoTqj5tX6WB07jYMhPGMYMsHj4SNzhVvtUMwM2+uuBSUF
         QSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725848; x=1715330648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKji8dql2Q7HB9ydxb8y51caf9/agXzCr0gG3HSWZek=;
        b=bhi5bz0vyfbBUsXjqGSV+zA/uYQKP+Z9xjgH1pmsQ52lXRlrO+d6s1jQMZcxHvOpt4
         Hm6+z7E1A3hG2HxFmbyjWs65hBqHDoL5z27C9jYN96lZ55kGHCfIthbAPIRHMoKe0Jwp
         fRMEPrjCb+brTlvpQg2ki1LtdnQJm+MlQykoLZsy5/I6vYY7tPN64vk/TJHECQeAJH1S
         1RUpHVRHpbLpxaVGsUGl8WezFEHy5wJIgIQZWCG/Ofm4Cln3lyTHarrgD3qncleG1FhG
         lD9E/3qr8IGkMyRl29NtZOFI9utr6PHek7yIJ6QdOaXTg3IdoaDnjtIiWhy/10mL9gd3
         9+pg==
X-Forwarded-Encrypted: i=1; AJvYcCVFnuuX1IH/yJgyiOuim6ggRns3eTSQ6nJw58mQo+B7KCFd9fkp6AMlBNaRcP1aGNMI4GCIl9N8FJ2jpo5rpUwyi0q8xQOpSKS5DXZF
X-Gm-Message-State: AOJu0YxFa/hCax066x8tUuXVODtuoFRfB17m1r9fDShJT3hiHG6pT4Fy
	h4Lu8A3Cd6BflMQEO0/TPmr9AQ/ReBDdbGuHra5BD0gkop3yndjbdzQLXaNY5cApw2vkLLOWics
	uP6jQZITng+pCIpUBEt4At2/GSOTc0k6ZBC/wFQ==
X-Google-Smtp-Source: AGHT+IGWfFGtExQ0NqT26L1KYSVbcOPkIAddlYuzm9qz4w3y6T+dxyxo9KKnqe667MkWqy0SdR4KIs+Wq8t4EpB4aMM=
X-Received: by 2002:a05:6902:2011:b0:dcf:2cfe:c82e with SMTP id
 dh17-20020a056902201100b00dcf2cfec82emr2421680ybb.55.1714725848634; Fri, 03
 May 2024 01:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com> <20240429104633.11060-8-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240429104633.11060-8-ilpo.jarvinen@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 10:43:57 +0200
Message-ID: <CACRpkdagd3W1EkJTv70pGBf-=J+yuV+osisR2YjHKuT9Oo5Caw@mail.gmail.com>
Subject: Re: [PATCH 07/10] PCI: Replace PCI_CONF1{,_EXT}_ADDRESS() with the
 new helpers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:47=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:

> Replace the old PCI_CONF1{,_EXT}_ADDRESS() helpers used to calculate
> PCI Configuration Space Type 1 addresses with the new
> pci_conf1{,_ext}_offset() helpers that are more generic and more widely
> available.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

