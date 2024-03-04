Return-Path: <linux-kernel+bounces-90961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9698707A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7998E28161A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA95CDE1;
	Mon,  4 Mar 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xz6yhItV"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B3605A5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571089; cv=none; b=c90A3KYzJlDTIepC7UUnQyLEB6neal2QTCrPC+3URRGce8VW8rXPlaz6avkhCRx7dqaCdsWxAfRUaLmGljnGbBFoSfcvoNTcRjDs4Sb8RIjwWjAX+9dBE8dGSrUFCk98SMe4zqn6VvDNA3htnJkt8cLjPkW3x6dvRpS9NgfqAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571089; c=relaxed/simple;
	bh=8YEW8/QYd153IU1YcCsQ5FCqtApBQaAp36ELoAoTGug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfEkEPnELTtCMMpDmKdpiqhya0X1pNLo3vtuQwTB/vDAp7QWKpWQrzjprrWOYjCfbSsXE5qEw0VGbBzOZxYZT8IqeLGQn4WHfMjG+KyboHrwJDWcUv6RuQSH/TFNdaJPg9hEzpASVzexZBgDV+eT5rBkXVg5kmPgz/2hxm1/y3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xz6yhItV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4532f84144so171433566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709571084; x=1710175884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOyMFcdZeiizIIdM2h9cviSaGUWkoYW6H6plPEQ7/JE=;
        b=Xz6yhItVu+bd1OAN+7W4IPdXqG1psTBThcOsS9BGq2nKTtjGKtg5WzzH41d74Rrgf4
         KUIk8doq6pwt4t5ZlWE+Qvsvu5NPKYFluovGINCBMnJcJfaZLEV1xWCG03um9qOHt4oO
         lD96ebXl460RM4ACBsNlXtAgY0EOGG+1BpxoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571084; x=1710175884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOyMFcdZeiizIIdM2h9cviSaGUWkoYW6H6plPEQ7/JE=;
        b=ZaRGJW88v3jWC/p7UDxL0XQpzaK7vcnhzR0ACgBp2XjdugjBw6F92xukj12e8Vr/dR
         jENNS8JY2NLUWIE+AuRWZwgGK9sqnsHw5SUfj+sDBUyEc4VF9Vh4r2SeYf690+Y3MZOE
         osze2YnQJX7RSIe93j2iNs4El8pGteLxcXcVnPkEfd/xAVyNOTc3ScVBi9UBwZEePxO1
         /ZEfj9bmegTOs/2lGDXjxWlIXuxb2NfvCiyDuvfN/WScHGRfq9/BEOPuvw1s4spWj6OL
         H102WIXxn03vjGJMl7Y8ZkjhEz8SR5jkj/JhCjKU53OF8gULQbcX382Ut2C+euUf5GwX
         VNEA==
X-Forwarded-Encrypted: i=1; AJvYcCVZT6/OwKPH8H2CUvoq0AuihnJX/qMUbmU7R6QZrHUi2xpTZS+tgVv8IjCEXB17zcMHXzTsZhvCR2TgSm1mqYtuAimlf03js5kUsm9b
X-Gm-Message-State: AOJu0YwuOe1OznWseTBdRrzpQnWvSGpD6jRiSvemY9cTSLwPyx1qNiMg
	zfouJbW0LdpefCDOT/cwGV/Y4DaDXD0dC4Y16MQCd9uE8Eiqf/iaXsXhyDCDIiFyICPFZqMCzSv
	bXClB
X-Google-Smtp-Source: AGHT+IHXK+XtlwXCl54s51VMYEMUiKbRfQ4zxHBP7JEcAcbRCvuL2sY5IEmmr1VQxe5pTnz2GVA/iw==
X-Received: by 2002:a17:906:d295:b0:a3e:5589:6099 with SMTP id ay21-20020a170906d29500b00a3e55896099mr6140222ejb.70.1709571083803;
        Mon, 04 Mar 2024 08:51:23 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id sa24-20020a1709076d1800b00a440019ac45sm5033319ejc.69.2024.03.04.08.51.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 08:51:22 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso98005e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:51:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWN4eS1nwxuEc/aHi5eeVJ6C/WjTgEFIxGLjBfFJcFxw6KX4cAJZ7yyrn5rENfh24gBNpnvzT7anF8PcF4XtJkBrLXScwPQvvYljv/G
X-Received: by 2002:a7b:c417:0:b0:412:dd21:292 with SMTP id
 k23-20020a7bc417000000b00412dd210292mr263164wmi.0.1709571082557; Mon, 04 Mar
 2024 08:51:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301061128.3145982-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240301061128.3145982-1-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 Mar 2024 08:51:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UP9NxfmT8rqLd-HUq8QwJXa5xO7UbrgYHLw4vOKZO7hA@mail.gmail.com>
Message-ID: <CAD=FV=UP9NxfmT8rqLd-HUq8QwJXa5xO7UbrgYHLw4vOKZO7hA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
 panel HFP and HBP
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@chromium.org, swboyd@chromium.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 29, 2024 at 10:11=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The current measured frame rate is 59.95Hz, which does not meet the
> requirements of touch-stylus and stylus cannot work normally. After
> adjustment, the actual measurement is 60.001Hz. Now this panel looks
> like it's only used by me on the MTK platform, so let's change this
> set of parameters.
>
> Fixes: cea7008190ad ("drm/panel: Fine tune Himax83102-j02 panel HFP and H=
BP")

Your "Fixes:" tag is not quite right. It needs to have the _exact_
subject of the old commit message, AKA:

Fixes: cea7008190ad ("drm/panel: boe-tv101wum-nl6: Fine tune
Himax83102-j02 panel HFP and HBP")

> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

A little odd that the patch you're fixing claimed that it caused the
measured rate to be 60.01Hz and here you're saying that it ended up
being 59.95Hz. I guess there was a measurement error when the previous
patch was posted?

In any case, the argument still holds that this is a panel that still
appears to be only used by your board, so small tweaks to the numbers
here seem OK.

Landed to "drm-misc-fixes" after:
* Adding "(again)" to the end of the subject to make it distinct from
the previous patch description
* Fixing your Fixes tag

9dfc46c87cdc drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02
panel HFP and HBP (again)


-Doug

