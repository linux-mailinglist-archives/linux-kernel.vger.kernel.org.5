Return-Path: <linux-kernel+bounces-64206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB425853BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680E21F24CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEB460907;
	Tue, 13 Feb 2024 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxYvo063"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5160B80;
	Tue, 13 Feb 2024 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854660; cv=none; b=KRqXz4Z+MbDZPqOjU/zhTscU2XnsYFaiGOqP2RaRwyaYZ2Ua5ovwAD64VbsIOqo0nETM8BZtqQj7F7Rhi3n2kSGa0rfwSnEchHCvwE+FSjtjVIaEJso3iOJSr/aFnCQpGD07+uayK+baTK5VTMp4IszaQ0gQPg+qiPVm7SAYzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854660; c=relaxed/simple;
	bh=gS7XSVnmGHUZZL8dRfKAhJLTPooei6VyxIjJkD8MGfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckJZrgGbaNCjX94fpZPsmAuucLCdbHB33i1jpV3j/h8Y2f39Eg7frKaO4WxuTXlT/+8KSZa+gMgfeYiExySBz5G1x6HEXs7YYkZs/7/lFiftK8Xfj3Bg30s0tiMuoL/Js1dbuwcOaYlTTY8eiYtoTsc4uVZR1WPK/XAXWJfl7bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxYvo063; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2866b15b013so1005114a91.0;
        Tue, 13 Feb 2024 12:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707854659; x=1708459459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gS7XSVnmGHUZZL8dRfKAhJLTPooei6VyxIjJkD8MGfk=;
        b=TxYvo063guTFtpZiEYOuLoRy54CeG5f+L8yWFw4Sgg8ooIwPdr+BErUkGJbiSD+puc
         kr3SseELocPG4/WSh2b75SNExUrl0TYGMqXF9wa5ts4bJ5PDVzwNYcnkSatQ7wNPd/hC
         /ochCV+ouT9yYxYF6GSetb80siiZ3zYphbRr3TnkDSwjt20niAhppgK/lS9HOM+tVpVL
         zmgPgXtCzCrK3IM8yUuYmkmVBAf3/GRyLM5bmrDHgfb3vfEWs3PItF2Wy/FUvl5/PML6
         U/JpmmU6WKWAMt4oMxhd0uP+zwrcruVuFWaCsbPqPowXlaJChDNI+rf3IoMVWOfVYVK9
         HSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707854659; x=1708459459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gS7XSVnmGHUZZL8dRfKAhJLTPooei6VyxIjJkD8MGfk=;
        b=U0rOPhJrcUT5OIhjnjGIHOlS7s0Bekpg+UF4AVSxhiL3p+nDG5j+izckHbck66VD4b
         zgAIB895PF2TkgQg+DSPwYychmVZzCY7NFa2ypH6JfCd2d/3BR0RvO96wj/jt0S5QNuM
         Tcq+tf6mAhtbvlJnBViSJyFUlOkRTuiKK0g+nv7fUcKQgReLZNbtKih/D98QGQJbYz1r
         F7bUIu0kxckPtcwEpicgwANo5YE6RBZsgRmUPPvQ3l8oABeA7iNZa5GSsoEEJ6ZqhW7e
         GNutHTDu2NlQrYuZQ2fhkXlZQ5AKf9kol4nWg3/IsuQHnzBwpapAnuUgUPObVfUdpjNx
         sPmg==
X-Forwarded-Encrypted: i=1; AJvYcCVYbSq5ZijCZ+QYrPv/DdaO1QQxE4oDAspJfEjBUEGn5C1PhGVglech9kGf24oqZ/hpiNXCYo2AF1Zo03uZij60tLXKs9EvRV4+3x9O9y+Y0p3TE5svc22i8MaYWenPuulJQAl01xKz
X-Gm-Message-State: AOJu0Yz20aIE2EVJnC8COttoZLT7ZkkqprSkYjsrMtF8J6Sf/f063npS
	9vv5WAA9SmxOxzhb46UVWJlRxN3zd/B+Y9WWNOST81FChBJb6kEgSG3RW9222mD0luDq2SyDbhc
	lbDMqJ6IRBi+koSY39PP/0yr96og=
X-Google-Smtp-Source: AGHT+IEpODzboQ+ni3J5nxXjJRN+UJ8kIv/WswCu70Sa0dc3sEVV5/Dn8R2RUyEZyPmZtByzCSh/b7T7Y/McQ5MdhZ4=
X-Received: by 2002:a17:90a:17cb:b0:298:b4da:f90f with SMTP id
 q69-20020a17090a17cb00b00298b4daf90fmr525843pja.1.1707854658792; Tue, 13 Feb
 2024 12:04:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202115330.wxkbfmvd76sy3a6a@runtux.com> <20240213170657.puwlx5pjl3odcs2k@runtux.com>
 <CAOMZO5CD7+E_BBH+oQ8HUdBeRFZxWW7s2uJgS5eaQAW_Fe4CNg@mail.gmail.com> <20240213200235.htnvyy343qiw3kbv@runtux.com>
In-Reply-To: <20240213200235.htnvyy343qiw3kbv@runtux.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Feb 2024 17:04:04 -0300
Message-ID: <CAOMZO5B3zD4rQP8uHMjQ-NRLBnUzis-Ay45tj40J7RFPzAZ=Pg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] spi-mxs: Fix chipselect glitch
To: Ralf Schlatterbeck <rsc@runtux.com>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 5:02=E2=80=AFPM Ralf Schlatterbeck <rsc@runtux.com>=
 wrote:

> My blog post might go away at some point.
> And I think when looking at the original patch (in the Fixes: line) it
> is quite obvious that the file in question was overlooked during the
> original change. So it was hard to find and I documented it but looking
> at it in context should be pretty clear.

Yes, that's fine. Mark has already applied it, so we are all good.

Thanks for the fix.

