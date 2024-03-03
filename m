Return-Path: <linux-kernel+bounces-89764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D949C86F535
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177111C20C62
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD32659B61;
	Sun,  3 Mar 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3V8RTm6"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3159B54
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709473868; cv=none; b=hJAIuGn6IeGp5j3gtCJ0EdcGhf7CVqw/uMSzj9K+lfa9VGUiHQPbJf6IKd14FnL139BHQoJFvJ9zdnxP590CvpJwS2BXQosDAMeznsSBu/l1Cm5QfO4gwqjiUERFjvaELEj1pEaWuYjKlx7xxo8yw2b1Eww9ZM/uuYl0SdQ18eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709473868; c=relaxed/simple;
	bh=lL2qls7bRLi7Da91QZT/lNPcO4L4EAuIQsq3JAQG2UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UghRUJvbCJRUbIEeeZR1bh1Ioy602NSkl+ILd+/bQ9AMM+rMbzViO3mezSMDgl7uz/m9BKwF/gpUiiOMhI/jPJzwi5eUk68h4Nl3xip8qHpYOT0XtNz3NLybMD+Yvx0qP0fxw8z40XjNlLUEC51z5sue6P6adOGGXJTZkpZ8fBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3V8RTm6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412dd723af4so12855e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 05:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709473865; x=1710078665; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL2qls7bRLi7Da91QZT/lNPcO4L4EAuIQsq3JAQG2UU=;
        b=f3V8RTm6uolAfQpMgN0jnzHm9axSX9ITsznJlwL+ziMzH20Gr3/DiL1fEaLzsdfOoD
         hr2JcdbpjiUCGto7XUPo2UtvAIl8O6lbtzNUelYsy/19XOjEz70wfmwAXo/Hnk9k84l/
         2wy+vvjCqKElwn+b7qqtIuxpX3ZVrcsbhGXkqApWL5PH12hR4dml7Ho/WiUG7ZFwSM2J
         4RlvSpd/W4OP409bXua8iitf17pg7Wd+1L10eAj6dOcrUIqOaR9YLXBkyNh3jVT2AUub
         QtievqdCUHX9gORpleFXkdJsp5beNhlTFyRQDD1UXXgou8vuDoQJJfdP9HMftviN7d7B
         26Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709473865; x=1710078665;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lL2qls7bRLi7Da91QZT/lNPcO4L4EAuIQsq3JAQG2UU=;
        b=mxNRT/Y5ExZNjF99qr/CNpndsmJZk0bzBKuxZnEly0dLesDz+kntndjFC3Cswsnuzw
         m4UsPeVmYHxyay0Ugx6pa0Mk3IR6aub3Zn+xLS7zZNYvbl24CZytOpM4iNXipnlpMtxc
         sPc5QSZOzT0SOdxHrWJkh4oLHiJ+mj9VqWsfoYhx1fH/9X2sixT8S1B/dM63bRYzQs9c
         bRYyQAxaVcdXL0EH3kImBQ0ccNwU+6waXxtiqNzloM0XGs+pfyy/QOv7JR5fB2Nxvarz
         KN0UsLuk2pnXJFroHB8oyuAY36bdTZ9UxlhG5zmWsPfJyjkS9VF+V1O+GU4p8PTQzVLa
         o81A==
X-Forwarded-Encrypted: i=1; AJvYcCXOMFiLW7SqO75Of2cO1x6neKI8JjbppKY0Ojy/2clt2VQb8EGSuKnWZoPpwi5iw7NIzFahf7ewvZt7Er984qapvc/RUZngqqBA2M90
X-Gm-Message-State: AOJu0YxrrSoWF/XDniUuFgM/4X/QYMfSox5HHbmfumGy9VAnM0vGDk1N
	B5w4/RrOsyuiG4xf9ormD9O+NZ34Sl5rGKL2wgHL19G/34A2UFc5M0EBiN+Mej1CPFiPTzRYOnW
	7x9uj0S1qV6Vwquog2y9fAaXgD7bFDCPT2kOx
X-Google-Smtp-Source: AGHT+IEfuw6JENjiAQWpyQP9ZMPz7f8jMXoehxOJumvczLSkxyl9hPnL90dGK9hnHpcKLJLq9h/s+RZHsG2FNwScQhk=
X-Received: by 2002:a05:600c:a386:b0:412:aa80:bdd9 with SMTP id
 hn6-20020a05600ca38600b00412aa80bdd9mr356023wmb.2.1709473864533; Sun, 03 Mar
 2024 05:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303114139.GA11018@didi-ThinkCentre-M920t-N000>
In-Reply-To: <20240303114139.GA11018@didi-ThinkCentre-M920t-N000>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 3 Mar 2024 14:50:50 +0100
Message-ID: <CANn89iJKe-J1v6WeDVf-bb+bAGXDVg60pqwUJgm34EoLuwC6+w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/nlmon: Cancel setting the fields of
 statistics to zero.
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 12:42=E2=80=AFPM fuyuanli <fuyuanli@didiglobal.com> =
wrote:
>
> Since fields of rtnl_link_stats64 have been set to zero in the previous
> dev_get_stats function, there is no need to set them again in the
> ndo_get_stats64 function.
>
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> Link: https://lore.kernel.org/netdev/20240302105224.GA7223@didi-ThinkCent=
re-M920t-N000/
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

