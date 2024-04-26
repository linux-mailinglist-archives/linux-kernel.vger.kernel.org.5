Return-Path: <linux-kernel+bounces-159405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2578B2E33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B481C21AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616084690;
	Fri, 26 Apr 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ndWFZIg0"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A80187F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714093236; cv=none; b=TLrz527dDcyCsvINddXjZn4G+H+JVzhGupt3RgRs+INUCrWsFSlEW5BFFZeApacJz/DBNp58b5FdPzucX7OqYwJj1XgZ5nFDWIZx9WxgsK4VegFeHCQ86TuL4PZVHpyBCGVcz/+z55pffvtONhO5XfwRuWIVUZkJ4IccghbtNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714093236; c=relaxed/simple;
	bh=vaP98bHNI2EL8ADkLGZasqcIildzOGhlAde5WfgxUbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rf+yTUO1cYjKeM9gIEhwhzqTEp3iKHfng1vwzTdU3I2uXffwWuwuq7Sa9TQWpJZhCvg+TC8AVuvPOOogc9m3RFVh92G4/vtRxED7Z+xnBwhdQIn0uXWVURkLkeWIkXAAGQ1lJocelUk53c15zX3+JelRe+jlpobXzpgiiGg9NOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ndWFZIg0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572242ed990so1606198a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714093233; x=1714698033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS4hEfkYyZcUp2/3yo7BEAns+xnreNTWUG8ipJK8F2M=;
        b=ndWFZIg0W1DyLh67nMj7hBS0CE3v/3r71CDfmcGTS/etzDzNXbYR6/62B5lC7/2fPH
         Cf9XmrTydCTmMI7ro4K9pOWOaSu+qIG/h/A84HH1sRBvKhmPfX5Vakh2BOtfGhwG/4Z/
         N2KunNNku5EW8XT7X6WO/3NNF2kEWfcPCVP9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714093233; x=1714698033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nS4hEfkYyZcUp2/3yo7BEAns+xnreNTWUG8ipJK8F2M=;
        b=rfNPr9QdmA9CVecsi30qO+LnHKAAhc4v++L+gLTm4t+2N6P8SQa1Vwf5rK8KSm5y4g
         9skOkG6mPv2+K9qrpvcXjyRtA89deXsrT39abPDTborZWevOjq+KWAyt8kNfFpKs3DGG
         hnDTYdNOXIYwP/dNgyanGEJUV6MsszSy9SpuhTHfTpIIC6wiECA/Crnlc8D24eex4Uc1
         45Jp+PvztlvQQti/H/936Io0xoZWFc0Xuaq+0TF9ufC8e9AswI1KEZpEY6e5kiGDL0j4
         KvIxOaGlWa4U8S/dC/xuQISlg3kv0iUmgP885EyfQkd7TQGRxx0ypg0kldFVGbL96yJt
         XuKA==
X-Forwarded-Encrypted: i=1; AJvYcCWtIY2YBWMteh43sBo5Iw0Q5R7lEcqLOi2OX7FMtOBxVoBaGAHpGQwmwjuwz7zkdX3Jgs3UUhHuInN9vFNsWwRx6jAmOYss3MglF69l
X-Gm-Message-State: AOJu0YzKcYd4ZNTtAzm9NM0diALSZ/yVe6XHnXXMpAi+7kk6MjkyHJ5o
	PGZ7XgJlu+lRM5Wlv3F9HqQh6DvgPn9p+sWFrB6YYOypyT3IpJ+yURmbJyXHPmBKh4P/k4z3AjY
	=
X-Google-Smtp-Source: AGHT+IHNPgD97PhwW+SpO6vZ01OH761AWkgiElO1M0y8jTTL1RlK39D8nqASiROO6h6tLxEjhng4MA==
X-Received: by 2002:a17:907:31c2:b0:a52:3645:22b6 with SMTP id xf2-20020a17090731c200b00a52364522b6mr1121352ejb.1.1714093233160;
        Thu, 25 Apr 2024 18:00:33 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id bi10-20020a170906a24a00b00a54c12de34dsm10010629ejb.188.2024.04.25.18.00.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 18:00:32 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a58a36008ceso205443866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:00:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/YnJnJmynyM8kEqWzIjqx9wVJtqY/XHGxRqmr6GdffZIZVkkcucYfIRamwwm/bzu6Y/FY2H/o86QT6OCxaWym5FrXuB5DMo/8pfKB
X-Received: by 2002:a17:906:2a44:b0:a58:c237:bb77 with SMTP id
 k4-20020a1709062a4400b00a58c237bb77mr756232eje.54.1714093231535; Thu, 25 Apr
 2024 18:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418060626.431202-1-yu-hao.lin@nxp.com> <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org> <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com> <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Thu, 25 Apr 2024 18:00:17 -0700
X-Gmail-Original-Message-ID: <CA+ASDXODhWc2vhvScov=_vWyocbdks6HeMwKqRGacDogjX2=HA@mail.gmail.com>
Message-ID: <CA+ASDXODhWc2vhvScov=_vWyocbdks6HeMwKqRGacDogjX2=HA@mail.gmail.com>
Subject: Re: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host mlme
To: David Lin <yu-hao.lin@nxp.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, 
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>, "rafael.beims" <rafael.beims@toradex.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, Apr 22, 2024 at 7:29=E2=80=AFPM David Lin <yu-hao.lin@nxp.com> wrot=
e:
>         I wonder can patch v10 be accepted by you?

I took another step back to see what Marcel had to say about
external_auth, as I was not familiar with it, and it didn't come up in
discussion with Johannes earlier. If we have agreement external_auth
is inappropriate, then I'll revisit v10. That may take some time
though, as I'll be preoccupied next week.

Brian

