Return-Path: <linux-kernel+bounces-59349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC1684F5B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC8D7B20AF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE5381AF;
	Fri,  9 Feb 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8OiZyFe"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E091364DA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484761; cv=none; b=mICiDpdbH89jBgW5PQw+jfMO537hhDHZtT/gjBcRby791nM7Y8HP7uBEnIsP82EDttPY3cZK3/JUgFqmiKG8mG4Im6EX2MyEwfxZ02Aiw8e6CgaBjkZZmzr+R8bJ1Qy9mN9rqH1dAPfyPIvb0HRrZ+7D7nwB+RXtd1IKjFbcAe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484761; c=relaxed/simple;
	bh=H0Ihgqg6vcooY6HsSUddyRQvt/glr76kGUtcEmebLvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iz0bFAu8rTM3GuXcNYW92Ns1SHc09VK8oeNDNj9Sy/Rg+LCMpBotQW8Owp9o7l4JsWTVztdgkkUafdPaYrR7+ZaJKX6UM5m2SEJ0JRPnra+ugFzRkGL9GNs2eiQceBsoBCYCbng74HBiFO0TdVFASjnPYcApx2+rsmiOcbWYvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8OiZyFe; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-604ab54bb83so10255927b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484758; x=1708089558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0Ihgqg6vcooY6HsSUddyRQvt/glr76kGUtcEmebLvw=;
        b=O8OiZyFePScKt86hTEL1JwkigXacBxrfnGWw2jyuBykB5K+Ijph0TlUc0bkr1AHqtP
         XtEMSS8igprPEaRn43fJmOv3GicsLLvQG/0ilLRKHukLk/VzJDJdGOjjwCV7VmZ4vBsM
         MQ/yiWn/omfJ5OC5MSZU8B4fSxYMd0lgONXsiNPpU3Z5SvvUshz1/pKO4/yFsCt1sQki
         VRGZWI/woSvN4lC0yLxdBFcW4UJsr+Wngbo52S18w0k6QxwM+x8JuVUe1rd+Zcbd2Nfn
         qu4CvZiayR1QRXLR43NLdWVwT6L3p23cx6tGzgxUfMPptWw0ug+x92+ZECDgOZl7OgXJ
         lkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484758; x=1708089558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0Ihgqg6vcooY6HsSUddyRQvt/glr76kGUtcEmebLvw=;
        b=xOmx/zKr9F0fpNueqJEcOiTVh4o3zoB+i+5v5X2SfIh07JyvlmSFpP5+1Df40Fn0z9
         L7CnsJeEk6ZfJBz4S9Nlgn6StuPWhpjmhj9baitmXKysIsMhZliqAhVCjE+1Nx+xqri/
         reXbQFs/UHJ/Q50j7jqm/KPC16yYA6B1sTuG55lF+4XvePnm/s+doPkgxod/5ngCU71M
         qa6YwhiCS5Yu5NCDQ7UP5wF+1i/BriKH3FYm2nfIUT2tjz83FK3KRMSEAkwFQDzyuDEV
         nyjZrF/CKtr6/lvymiScvL7w4xxtxDXQ63fIoIugBJyiD781QrAS9iQDoxUci6GKhOpF
         /nsg==
X-Forwarded-Encrypted: i=1; AJvYcCWaDNSMbqnb3Qeh/rZRiEhEQLqVt/sEZFEo2neQHQSB3ZqJ3344s21QIsMk/LCI62EwaSKDSvDhuPdjk2uV5wJeFV4l1bPs1VIMdaao
X-Gm-Message-State: AOJu0YzP6gj4upzSW8idzuuLaT5D9Uk6z8i38ZVULgSDprsVDcHtVXOC
	HOtDZl235hd7HgIb07IBslPFQyY2STXDlbcEICO3ZpppcTE5thltYpkeq1yh0aE1aNj11k71OvI
	1Pvyt/7mFQRT1ms5pFbrM9365pwFxDUrvIztw+A==
X-Google-Smtp-Source: AGHT+IEWhMRKZpz6jQmO2xCeK+S38BvufNYeEIVPEoIMMs+4gr8K9BTZepoNwlEret+dAQs1S4dLcRcaZ3Sb4QQc/5k=
X-Received: by 2002:a81:6f03:0:b0:604:91b1:5401 with SMTP id
 k3-20020a816f03000000b0060491b15401mr1403138ywc.38.1707484758481; Fri, 09 Feb
 2024 05:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-3-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-3-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:19:07 +0100
Message-ID: <CACRpkdYaEAcv_au0VbJtGJtxGxNAOMrd9+5oVyR2ybb3NSJCAA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 03/11] net: dsa: realtek: convert variants
 into real drivers
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Previously, the interface modules realtek-smi and realtek-mdio served as
> a platform and an MDIO driver, respectively. Each interface module
> redundantly specified the same compatible strings for both variants and
> referenced symbols from the variants.
>
> Now, each variant module has been transformed into a unified driver
> serving both as a platform and an MDIO driver. This modification
> reverses the relationship between the interface and variant modules,
> with the variant module now utilizing symbols from the interface
> modules.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

The code looks good, easy to read and it works, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

