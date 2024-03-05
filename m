Return-Path: <linux-kernel+bounces-93068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B8872A65
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172831F26E07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B512D201;
	Tue,  5 Mar 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxdjCd65"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041BB1862F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678752; cv=none; b=mGL4U/bDxEHbiZ5sLDN8amUYyfy9mRscds17GJDR2tQxRvmrCpHEsUFzSr7KUQAlYBN0+Nf44LNBb7Vbx+0iFdHqXzyAC0N65yo7EueHPoj5Xii9cc7uS1XVoDSnKyNCqvCZtbEk9Xat2YNwyN5daSD4D6IWVfuP7ojjqNaFQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678752; c=relaxed/simple;
	bh=jtM/RjfeuOYALyILOB3IoGS/0L6GWVnfUaDVIucLSgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8kLq1pGXQI+NE6QDql5hf9/wYbJAKtFIQyl1z2K4U7ctU+cDqW/8xTF9q4GVqP3tQnR/9I+IR+c6re4ekAUGLesV7C5xIkeAYPItVFYVPJ8jDD+QBlOb0OXUY5hp08iix+P6dU3gUhAOqfRGf861bol0q7t/4E0oDvl/Lo0r3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lxdjCd65; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso241319276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 14:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709678750; x=1710283550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtM/RjfeuOYALyILOB3IoGS/0L6GWVnfUaDVIucLSgs=;
        b=lxdjCd65Baf+2A1XSEzUeVJd5i/eoiHZ4fPI/rG8Q6dogfwMMaoWqtouF2jkI/POSF
         lmbdW1dR4/aMTOvCoXO4EMrP4MS/Kf12Sxu20fPnZagciSaZUVtOeRrupIkbTGtdOnd3
         bwGWArxh+w3gKyz0eEgsLVtkbmXF8mfTzRszMdmuGkU0C/AGO1uQUVthRkltliKPc3Ml
         b88/0Mp42nCZb5UiyquARB3grtEAT9DKbLgTybMxS1W/TNQdt1rygd9ZaizdIA0+n47T
         ZY1MmTB7lBWwR+EVOvbB0UY9RaRbjNrLUC7CflIxGYAzeHn0WXB/OuvtAYJvE/hnDtoJ
         jGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709678750; x=1710283550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtM/RjfeuOYALyILOB3IoGS/0L6GWVnfUaDVIucLSgs=;
        b=qRwcly/8j5k34rMOvLU3hDvDfMeyl6ueQ4onFr0skPMu8DsoxV8YKum7RyPEzNXYEI
         XI3KV7JGvTk26spx8lbjF3jrTKp51ZoBNeLktkjuAjpw+qJRtluU1LHaIUHFSNLfNKS5
         1cnHThTd3Fs1b9R7PZU/26FgcSrrFVRDtRJ8M1FXVXo2v89cED6hEAOFEgFffBiPNBt7
         wdHXocmu7SeOhixXqCjVNe4rADXCwjkCWrmFDM4icSOZ7OirYVMl9DkAMugpT4npwJWI
         zWcG9KjNVQ0r/JGyKGkaTlqo3D3/rn+9ZDs4E8HMSUAYkKHi6sy7KN8fJfCv/VYZl0CH
         jTpA==
X-Forwarded-Encrypted: i=1; AJvYcCXeYmuk7HFpxrf6L5TtEAL3wpMj5TzzUJB59F0nj0jAKZJPKYsqJFGcSlreZAPfyBmNI7Gk+R3Hlh8iG/6/zfRzNQWgxvYm5LaFei7l
X-Gm-Message-State: AOJu0Yw+FTB7yoa7m6Gy/oXA3fiBDtRyb6P8DFAfJejQ6C7L+cBfZwoP
	V5jMWVtsm07owvYZa3olo4sfdHyiZtZg5LoQVGjpqSj2F9QhZFY/gIR0HGkzfyYonzuPW+hESrg
	nXQJHqQMlVicrn5quXW2mi9bRhUu7jEPj8BNYrw==
X-Google-Smtp-Source: AGHT+IHJzuPy26fVcm9Bfi8lrllbWjsH8MnEDwTMR6XgU2zPh46aAe3ia9QjdcGO3U5lMTwPinVC0sHP87rW8pzMSIU=
X-Received: by 2002:a25:d887:0:b0:dc6:c670:c957 with SMTP id
 p129-20020a25d887000000b00dc6c670c957mr2933253ybg.32.1709678749981; Tue, 05
 Mar 2024 14:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-1-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Mar 2024 23:45:19 +0100
Message-ID: <CACRpkdY1QfeqRfU-doq_qss8VzgWo9jLnULQREGmHPqsgpqWaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/16] net: dsa: vsc73xx: Make vsc73xx usable
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:17=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
com> wrote:

> This patch series focuses on making vsc73xx usable.

Can't help to think it is a bit funny regarding how many units
of this chips are shipped in e.g. home routers.

They all work pretty much like the in-kernel driver, or a bit
less than that, just hammered down spraying packets in all
directions.

Yours,
Linus Walleij

