Return-Path: <linux-kernel+bounces-128052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22F2895566
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C451286464
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAE083CC3;
	Tue,  2 Apr 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woYu/9YX"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D281AB6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064604; cv=none; b=Hhzk+dJbfyItliTH6iGY8JBXDoDqxa0lTMGYm1kqsHpm8fmyHOmFtEyxhg3aMkCtM13cXs0pLcl6DxiTGDXiyiWkjZcOoQ/mpRlMGgFnB9ZwPYhE9VWPlPShyu4lVuUZxQvVX2fiXR/iF2vGPo7cK8TmwPuzffa0hQfGUtEnnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064604; c=relaxed/simple;
	bh=Rsf4Hmc7EDYpsM//x1hgr83P1rDRhRAlcJu2Zk3nTCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXMRcd4zJECnSFRxXZJpiUZtSAOvIBgsYe3K17TkRzzi6189V6rE+aZtEquJSw2chuIgPz7yJOoeKsEq7L7wbz11n6q3VugQyvy5FFpR0kpuhH+olAFndpduNe1XIe2fNmeIGFYBydCHFwCMKPrDo5sdEmHXwu/tbc8j0RNcjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=woYu/9YX; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so5020865276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712064600; x=1712669400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rsf4Hmc7EDYpsM//x1hgr83P1rDRhRAlcJu2Zk3nTCI=;
        b=woYu/9YXSb60X2ootZrB1VmfxbjbMgLW7Fy9fHUPrTY4eP/5RSTsGqxDewVPhTw/kf
         k1psm7lNmPJzvdEU7g87iuBAKv8D4vYKqvINhxBZyn/ML+eyn3610Gd79tlPyQuJVVFY
         M4FCWwHmzHRoe0Ch4QlFbwleBBzQ2nP8gdN8fLC2s/GEifGt8+dupAhW5YqTnRu7MIou
         w6zf3CTFi+Qw+t6n42FMZ25VpF8mB4so8WiVmVvt9GK4Ygmt4tGFG4HuMv3HbqrUvfQF
         Hcp8+EKffmi6c0Odqht5e3rqPKdjMs68xlw0S2F4I6VG5HRFSmOnrwYXoh2fmk9FZPNs
         hdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064600; x=1712669400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rsf4Hmc7EDYpsM//x1hgr83P1rDRhRAlcJu2Zk3nTCI=;
        b=mEmE4CJR282iO72CxYtZ+LSPgUmR2uZjL2HwR1UPk3yAX2WbMv2Licg/cFgNY44mTx
         tfYE/K+dePmwE0dm5WE4rjbTzehy+ZPkOtVhOnoz0frFCE0V8e/Tuzc2am58JWOL5GlZ
         bQntVRXLCgVdI3SP0v/Bu2eCTZhLjn5NwhH5MovRRmnxET6KNwQXWntbU2VFWgZeqnDE
         rmdskJg4tL2GhzFF3arplAfW7V9klSE3e02pYYgLgufoKvBaYse4zelTz6h77a4wmB3m
         iejJ8v2t8miTVrDrY9Eoe2GFbpJ9q1I0DINLWqg3AUjVhzb5t/1b5SkNPj+pQlzwrNc5
         VDvg==
X-Forwarded-Encrypted: i=1; AJvYcCVh7fiC8p9S9uzX+wEmzyUzZrahJCSO4PnIoNA4kHQqZO3GlvkTOCXmmixh2LBKMMCycVLP9cRi8dlt64oto9q8sky4reXZE7svr2E/
X-Gm-Message-State: AOJu0YwotojUU1FdM8G6q8E419FYfKWF9tUV9go58y72qcw4R290nFpv
	i+3ZVi4yXn3X1n9gPG10Kgh9lpTRGICF8Je0oqhza09nuZvqhriUqaIKt1b/eUgk0IYy47cNuf+
	nObadZWq5XlWnAQ+EECd5EErJeAyn4UoCBmamOQ==
X-Google-Smtp-Source: AGHT+IFLJO8J2fFfhy698GFEfXDi3jvJf3a6TN+kjIFjbSxpGgHCRCMV4mzFo3tqzFMXkC9wbzCSEw9BhXR+zLg9a/A=
X-Received: by 2002:a25:c05:0:b0:dd0:bb34:1e77 with SMTP id
 5-20020a250c05000000b00dd0bb341e77mr8834023ybm.53.1712064600135; Tue, 02 Apr
 2024 06:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325204344.2298241-1-paweldembicki@gmail.com> <20240325204344.2298241-13-paweldembicki@gmail.com>
In-Reply-To: <20240325204344.2298241-13-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Apr 2024 15:29:48 +0200
Message-ID: <CACRpkda0+eEig-jzVtZ4oB5q2TNYdGVyGuwpqJH6dvSdqaASAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 12/16] net: dsa: vsc73xx: introduce tag 8021q
 for vsc73xx
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:45=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
com> wrote:

> This commit introduces a new tagger based on 802.1q tagging.
> It's designed for the vsc73xx driver. The VSC73xx family doesn't have
> any tag support for the RGMII port, but it could be based on VLANs.
>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

