Return-Path: <linux-kernel+bounces-96307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 595D48759F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9BB1C21F25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C5213DB87;
	Thu,  7 Mar 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Omh5KtsS"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F62A139597
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849311; cv=none; b=XX9RwxJkmHdABdjzWh9qzXf71NN5ZYysfHfcgknprceybpdrLXFU1e79NxZRUsMMTehUhvcmhWH1eibQTXGfTWMViXxkZhSWO8kq303KNPd6E230Kq3I8w7XmII5N0TN0Nlkgmw7B4yp817CsWWk/JISWqvc0mwQlwrrTE4kSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849311; c=relaxed/simple;
	bh=rtNR3Kl4BKEEG0W7kNlGz0E5gqmBtrXYCOUWYhzI/rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSZnq8aTwPfuS0JWNLB5HANArMH9U0SpS2BTeFlZGCc/8iTcrJVhjIXk+m36SpOiekqvXV4DqaJtPAc3bvHaXauRhJwztTSVFNRWfb8CPwBg98wf7o2g9s604DnyeZKntmJwnEs7NgAs9jsKjonU/WGRXRUgRd/09eTYJaJ30zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Omh5KtsS; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso1554215276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 14:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709849309; x=1710454109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PUH/PGVq+mmDqUvMpUQ1WEtnhkQe+DNBNHfPK6gnis=;
        b=Omh5KtsSICECbhS0YeU7+p0y8aQO+0/0xH31irGbbdfuGQmkgXaibmwGTnHtqKhi+E
         OgTlnkz0hOLzLSO9hTiSh3pHDtlz88TpEKxSXDCCgTlwohAeEqmLweB1Ks5qmPVbUuhq
         aFO6vEQkfhiSIeHjUaUN27ocfavybfu0QvPJPvdXtoB/cxkA1kbWlmO7xKY3Xz44iiQT
         4URSEDmdpAKqy51Ebg0EwW/YmkbLqFNPcxyNRu2XEJpZeSXaucqACqpcBE0urEDDFZen
         Zf3GPoRh/aM4ueEh64XR88EFdYrx6niS2BphPkouhQL5YAPxWiglsMzslS/0Ve30IAY2
         3Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709849309; x=1710454109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PUH/PGVq+mmDqUvMpUQ1WEtnhkQe+DNBNHfPK6gnis=;
        b=dDKaIWwJJrtmfeIknkVGJHKiuuaBeWSggw7k+P9V9NPeI4I1k3aoPrVlpvO09nfXQa
         JRMD4EGIGcNknW7o4+iSG0MvrSPYYTzDtpR7kOBKZWBVSODeRRYYG1q3vkBBYlIPG6Ry
         d1rIrjExNdyE4Oiphoial3V7AjVuHXnVEtpSYjV3SoELIbQumhAHsoXNWAnWzcM5svVg
         3DIufOx3Cp0NOl5PXcPVcQqhQN/VcjRVlvHAxIH9IvAxKMQoHz+Kr2zcKEzh6hyJsfcU
         JBFV1AIB2FEo0BwXVrja5oBiIklIhwLAmEg5EVIxecTJ3c45eXvV/ZaekDM207XfpyN3
         bgmg==
X-Gm-Message-State: AOJu0YwbY/GdZAfxmdbSWGVnzKWFkVHmXdhcTfe2p3Xed6RmlRWZJpoy
	gTW1FMnrO/EnurmaskNqaU26gRGCMT8f30HRjOU1x0tjTlagtnJmWu/TGsuJrVfUvdGIrU5m8vl
	qr1DB8kG4fIoWFEY2CN0b1IrTIqo8j0JnDsUxVyix+TXym++Z
X-Google-Smtp-Source: AGHT+IEN0rSzP52l7NWiioBCC0gXpR6uj2GlvcT3TFGi0fSnPSWOqqVKLL3E819yGzNIL0KHUEn9baN/EfSz8tuiXfY=
X-Received: by 2002:a25:aa63:0:b0:dc6:7247:5d94 with SMTP id
 s90-20020a25aa63000000b00dc672475d94mr13465419ybi.55.1709849309083; Thu, 07
 Mar 2024 14:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308082039.600be106@canb.auug.org.au>
In-Reply-To: <20240308082039.600be106@canb.auug.org.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Mar 2024 23:08:17 +0100
Message-ID: <CACRpkdY7RXZvWq8Vji5TCYd-947R0NDChrnLsA2wwaXm0RNRLA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 10:20=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:

>   Fixes: a4f15a8d4c82 ("pinctrl: Add driver for Awinic AW9523/B I2C GPIO =
Expander")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: 576623d70661 ("pinctrl: Add driver for Awinic AW9523/B I2C GPIO Ex=
pander")

Fixed it up, thanks Stephen!

Yours,
Linus Walleij

