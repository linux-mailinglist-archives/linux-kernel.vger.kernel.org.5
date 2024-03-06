Return-Path: <linux-kernel+bounces-93504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B33BE8730C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8BBB24ED8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEC25D754;
	Wed,  6 Mar 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUNn94dG"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C935C8F9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713898; cv=none; b=etc1+wsC7BGOio8PZZqUV0O99ZKfrS0hMijqpcTbWKrKcVJM9ntEA2HVPfggBW5Iuv3FyANRdYq8+Vg40r4ciK/Ww3JrO3yXiy8ebATH09Rt3drvVIv5sjQxpSUF9cTwhmE5poQkI+F4bI905vHQn7OMwNvGM138ccmISKDk1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713898; c=relaxed/simple;
	bh=jyJfCp5OfDLV0vJjPYvgRyGpn9ZGCSUjJg2Lp5gPxbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIVuoY00yOaJvnzk3L7jLRrlNgGMxlg6qcGFqKdfFIwH0nOaxTXN7rID9wI3zyFOsNgbf6zpP0UJCu17Gl0TncjjQpiQjP3WcFJOg8jLBok3qO0s8JDElcHW6iUnrkgF13WyQ2SUxrljsOnyrdFV03eam5xcBJmy854RtojRwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GUNn94dG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-608c40666e0so62660127b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709713896; x=1710318696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyJfCp5OfDLV0vJjPYvgRyGpn9ZGCSUjJg2Lp5gPxbI=;
        b=GUNn94dGRxdMLZdNrtL+U0o1POZRJ8qfYxFDTmVLBLa44TywyCQrj3mvf2vSdb7fUm
         eZiufHlr0Wsk3K2iAgXsxLBl0XxrtHj9bb5A4LAXVGFoy6GwDt8FHopZc4XoEQ9gdYQf
         jl/0+90/BMPriCrvUBP+i1SYsuV3fVb9VhUP5xyQbwtwNjJTo7dNBp8g4y5t73ehhKAJ
         W3skDC/KFTfRiCbqlQZBeuzuvXWkWIWN8VNheZWfwzzY7D4hzAJxST/Vt1R9eD9soFEa
         FNqoqGNyqUlxMdgstwEI1a8Cx0zTI0UcKO0zdNV2RLgenz33RAF+KgaW+zyZKqvWhVtM
         RtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713896; x=1710318696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyJfCp5OfDLV0vJjPYvgRyGpn9ZGCSUjJg2Lp5gPxbI=;
        b=Ex7Se+e7ks7HRsagtMdDiP1V5DvVCPW65+6LTUdKR/ucAc01VdBnHKQq6tEJDAacYW
         Tvskd6inBOK/fmnBu1hxa2H0RK5GGCEaQy12T0jDQKLb26WWxbCqiAtEIpyis8l4l5LK
         7sK1J5+vFEF7EfePWizCJYO4ps5WpL3tu6D0Dm1sL8QOPZd1dh96ZqzlMLslZTdlDA8d
         Ii30UpTlAy6pB1kdkceUIIKKkuNrE4hyCZwy9EnZ+zYpxTjDgkoiOKY5+r+s43oRoZ1R
         R33ljvG3wOO9jy2E9rNggsxu3AVstw120SbIk09SSMz/zB3Bfz4d6TFLp6HZH4H/lW1d
         +BUw==
X-Forwarded-Encrypted: i=1; AJvYcCUNkPco+OGHsYkxuWHxFBIRD9oO6Gb0KuNSI6MY7PBjOidnMT2mg5BdgvezrHZbmR32RfsT6O3NGFyHk5nGTGhhcJO7yVAa552LZ4Id
X-Gm-Message-State: AOJu0YyHDrr0/EO9E+BJoxfFetl92nkFUVMhxbGjI+GqLiQSmc+Fdd0O
	f3nfEhgQiNnRguAG41xOYI1UJ5I+QBdgBEGjHkv3mwAwwk46T4iprrrEz8f2CFt7Ivw1HTbzVgC
	lCXA33wH4EWTNpzc3TAL0VrnoTFf2Dc4/YaDVWw==
X-Google-Smtp-Source: AGHT+IFe2cHdjC0zImLtE7dX7CjofAAtqRWjocUz6T7nhpqnCF+/HJ3jk1WHZkdRVj+sVVBs8P7hOIo9q8+hxeZwX9c=
X-Received: by 2002:a81:ab4e:0:b0:609:356a:7b22 with SMTP id
 d14-20020a81ab4e000000b00609356a7b22mr12125019ywk.22.1709713896313; Wed, 06
 Mar 2024 00:31:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com> <20240301221641.159542-15-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-15-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 09:31:24 +0100
Message-ID: <CACRpkdbUNtQqTADMmLn+RWHvxMakrVCpXtGShz-=2oiz0pLdCA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 14/16] net: dsa: Define max num of bridges in
 tag8021q implementation
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:18=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
com> wrote:

> Max number of bridges in tag8021q implementation is strictly limited
> by VBID size: 3 bits. But zero is reserved and only 7 values can be used.
>
> This patch adds define which describe maximum possible value.
>
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

