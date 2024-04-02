Return-Path: <linux-kernel+bounces-127732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF5B895020
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06820B216D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB44C602;
	Tue,  2 Apr 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6xSpSc1"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9906FDF6C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053993; cv=none; b=ZlCqwDGsN7wuuS3Maj80h8JHAX7O2vXriQeEEHUr27n2o4kaRYTFzzkiZCPGYY70wtaCqnHad21JeBOZVxw/6qgEy51pngtY4mX5iKq5QZYXGWQGl3rNQNpe3DthTRJcuvE6JPP94CmEPKnYG6+npwwl25suu/ptIIE/nBSOBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053993; c=relaxed/simple;
	bh=bTjAP1Oa79bQY5vP296y5F3oGcaiNBrkRdnRZD3ar3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pp1SZLHajY00ae42J5IPLDvDFTVcV2XNRRp4AU7foqHEUc4VQeExd9Gfr/tJYGgFSaKjhlImSn+q64oWi2YeM9paS7mYYglx4dfeSP6zlk/eqI4Ai/EXnM4QjXJunOCb6X6i1Z11n3mUGjUf94WWg8hVM+NWBzYSkfYVNC5yaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q6xSpSc1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso4562624276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712053990; x=1712658790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTjAP1Oa79bQY5vP296y5F3oGcaiNBrkRdnRZD3ar3c=;
        b=q6xSpSc1Cw5xmO4pUFJFgdUgI77Uu2zsSViYGYXVVys3ODKTZnxf5GabeyacgJzVRE
         lGcLUeGrDc4YksDAkMV7fMvwkAF092vm7/vdDKNI1V3amGanXVzUz8jGYh8wtaoIqQ9v
         N2UdQiVgPsWX4nIaRraShUKC6ahIGsG+3JSBN8JwOAfFv/8kqiOgfMQtwvQgMCaJlKVG
         KWMfCYTpotS+pNAffil4oES3IkqAAgQUioS+XBafeEq8vJU3pKIS2H8tKdvd90xgewll
         1p8BqxXNZk5af/3Jr8QYiNZekZ4xLL4cPKiN3S7Ml7vJryPlHWRtARXVCAJig7w09OVr
         i23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712053990; x=1712658790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTjAP1Oa79bQY5vP296y5F3oGcaiNBrkRdnRZD3ar3c=;
        b=NQjiqYT4Nk+Bbz5Q2GbO00XhJgUTyyIqLlN3NhIkTKO58HrC6aXf95l1vecVOH9O1C
         9kU91+FnXUSh0z6xemt39dic/NxlQWrMJbkwxMoEJIvVWi8DGTK6G0gHLUYeK8eWiqPI
         wX6ymnAu7f8yq3pLaJTuwust0nDsOZsS0IRhCH3yuLOBB6y/WJ04tnotKRXhBIncNBBA
         uSWtkG76lrWkAcaJHXUDuMeoT3XCQcBto9+JwwY5RK1V7vreg9vSlEVXxxc8FGn9wg8+
         977hcdlWdOyj1vAswWgzUjbBiMIgNplAs5EUSCILuyVqTpdEagHToE+Y8AZf/pstiG8A
         4Rgg==
X-Forwarded-Encrypted: i=1; AJvYcCUcraFV+it3GoHqEJ/EyWJwwPnrB8BC0iagknfxcAmCCfh6d4yjOXoa3nE7mZoY7BM5Bq4iiUVBjO89VsE+jil9Q3XXLNWzuPCGkPS2
X-Gm-Message-State: AOJu0YzWazT5A046QS3N6hbbvc0tOmbNRCW/SoqmSHRZgsLq9IMBXvsy
	+Omq+qsrpUJZzyWcl/q13FKND/e7rqizQ+hx9B/6kjdl4G27xCO72q2yE4GVmxM3CFx3wr0nezf
	tFN3ESf2Yl1DgLaCsCG5/F3Oy05+z7coEZ/vySw==
X-Google-Smtp-Source: AGHT+IElYHGm6fwXhBEqIk71kCbbQLnWRlQW5xHkW2oi+F/hIWeOy7TrU7S6sLaD7XQSTD+RZgjjCe8le7UVlrObhE8=
X-Received: by 2002:a25:2688:0:b0:dcc:3a3:9150 with SMTP id
 m130-20020a252688000000b00dcc03a39150mr10863236ybm.22.1712053989458; Tue, 02
 Apr 2024 03:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222022741.8223-1-boy.wu@mediatek.com>
In-Reply-To: <20231222022741.8223-1-boy.wu@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Apr 2024 12:32:58 +0200
Message-ID: <CACRpkdZJpoHZ9DwV4R5NBSDXTwVjWVU7a1_qh8tHCtxPWPMTnw@mail.gmail.com>
Subject: Re: [PATCH] arm: kasan: clear stale stack poison
To: "boy.wu" <boy.wu@mediatek.com>
Cc: Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:28=E2=80=AFAM boy.wu <boy.wu@mediatek.com> wrote:

> From: Boy Wu <boy.wu@mediatek.com>
>
> We found below OOB crash:
(...)
> We find the root cause of this OOB is that arm does not clear stale stack
> poison in the case of cpuidle.
>
> This patch refer to arch/arm64/kernel/sleep.S to resolve this issue.
>
> Signed-off-by: Boy Wu <boy.wu@mediatek.com>

With the commit context pointed out by Mark Rutland:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

