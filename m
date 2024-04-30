Return-Path: <linux-kernel+bounces-164734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09BD8B81D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01E91C21820
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDB31A38E6;
	Tue, 30 Apr 2024 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EpJy6oa1"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62A179B2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512128; cv=none; b=jX293kMojnr3xV7GKBywNp5AoCOf8ZKLnNXesF7Fwj9JGTr/l5oTWhpmzH0Q/Sdlotn2CNXZi0bMGEYU3k9+FbpT6HD3E2pmYKLZbI9mq2oSO9sJFYO1iH+BIfu9QPLSZb1VT8y/r4MQMTy8E7oCty8+aFnIZOMn3anQB+7BAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512128; c=relaxed/simple;
	bh=I/EVp4TZiR8OTln35vMm6hHoxU6T0GwrW0UNOvI5cik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMwd9m/aQJnHfTTbEXPWBn4Ma+cdIW28GD+R8Ab+jY1VemLTt9CxwIhWuCjTFsgU+r81LQsLnGJabqB9fRM44JdqOxl1OW5KWhJhFKthEdiycOAbcVg3G2lwX8f/Z38Xfda5EkKc78ZmGT9EdRz3HVSfJN9nL45Sb7uw61UbRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EpJy6oa1; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-439b3cc8d91so32609681cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714512124; x=1715116924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbllIAN5xE2NiWzInq5JcWusAiQpLXP/Mpzf2+wDG9o=;
        b=EpJy6oa1sIh/R8QjKDO6oLT80FgAAetyXUr7eqUNvfS9UCEoA0rzI0ZnjhqxGjQ2v0
         5DQnxR5c0XIfFsBIB0RXxXLtiQGeLoEn1jbnaPAXsn25yt8Ry7VPEvZd7xGYETX57/qC
         PL2UtCH26zYfrqC9yU05qolNI7w0gmz6UeZ3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714512124; x=1715116924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbllIAN5xE2NiWzInq5JcWusAiQpLXP/Mpzf2+wDG9o=;
        b=p2OWmbPjymVmLdD91RaHflkmhnHXe0c0V7tFCXL7ODkJN4XHRj2uJDEkLZi2sLjkYJ
         R6ero0JmgIMid+tL0oNLw+iiP4Tz+TEEPDh2dZs6UgLI8sTWy2WZxK4Q36hO0wQhZ6AN
         RbBqsQ9mzYhG2S73jWzfdYjqNY1lYRi/58nrGMyVbYZZzRtA51HxJmHIwLgOCBqrqcrt
         6vcm8lo013lbwOtPbXhGozZ5u5es8/+Eh5iOGsGnBLW9s4UZCCBkyPm3tRpnpqH2v4a4
         nTBUs9QglgGwbMUZHUHHzlV8IPzGwdtIxY8kk0laYebPvn5iCFAlNVb6PKibywYr3RzB
         j0zw==
X-Forwarded-Encrypted: i=1; AJvYcCWnMYuYGZnX1na4Kmw4U+93NGJNTnR/h2ke+/PJ+rRG/7JuR3wTh8IQB1kfbdk2CyGs00cgnW8GnD7p6NcMTjBJz4oWxiOZMNjehZ5y
X-Gm-Message-State: AOJu0Yzkln3dkxK5StzBzdL3WA0FnU1qJjw8VXSMqKre5XIkKl/9tDEn
	2cKWxtdjVsm6qHUhN1aJVIO1nGXZ385t+OqlhhLvQ+5Nw1FAgX5XYax7Bblz2huvNONo4nqqXfY
	=
X-Google-Smtp-Source: AGHT+IFJMe8wRy5RX/LUUTjq8rlOECAu/h3xzZFhDnEqnrV8+vCw3qMDfFgi8nNWTEjEMcaWLnlJcg==
X-Received: by 2002:ac8:5755:0:b0:43c:6cc9:3349 with SMTP id 21-20020ac85755000000b0043c6cc93349mr504116qtx.54.1714512124286;
        Tue, 30 Apr 2024 14:22:04 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id k8-20020ac86048000000b00434efa0feaasm11692415qtm.1.2024.04.30.14.22.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 14:22:03 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-439b1c72676so59821cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:22:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWi/WAB43TgUk/UQ1sdhoeOgmY3ue7ATIrJKP6d6zKZnv1iohM+628ycDHDywHavpet3SUlfBZ/wdRtSfhFyM5c22yzEYHMU1LQLxdA
X-Received: by 2002:a05:622a:44e:b0:43a:f42f:ef0d with SMTP id
 o14-20020a05622a044e00b0043af42fef0dmr20528qtx.23.1714512122930; Tue, 30 Apr
 2024 14:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430170741.15742-1-johan+linaro@kernel.org> <20240430170741.15742-4-johan+linaro@kernel.org>
In-Reply-To: <20240430170741.15742-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Apr 2024 14:21:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XAF1_faO2uRzo0Sm0VOxWmqs7YCT0Ncw=Nv1iSndhBZA@mail.gmail.com>
Message-ID: <CAD=FV=XAF1_faO2uRzo0Sm0VOxWmqs7YCT0Ncw=Nv1iSndhBZA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: qca: generalise device address check
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 30, 2024 at 10:08=E2=80=AFAM Johan Hovold <johan+linaro@kernel.=
org> wrote:
>
> The default device address apparently comes from the NVM configuration
> file and can differ quite a bit between controllers.
>
> Store the default address when parsing the configuration file and use it
> to determine whether the controller has been provisioned with an
> address.
>
> This makes sure that devices without a unique address start as
> unconfigured unless a valid address has been provided in the devicetree.
>
> Fixes: 00567f70051a ("Bluetooth: qca: fix invalid device address check")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 21 ++++++++++++---------
>  drivers/bluetooth/btqca.h |  2 ++
>  2 files changed, 14 insertions(+), 9 deletions(-)

I can confirm that my sc7180-trogdor-based devices manage to detect
the default address after this series and thus still look to the
device-tree for their address. Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>

I'll continue to note that I still wish that detecting the default
address wasn't important for trogdor. I still feel that the fact that
they have a valid BT address stored in their device tree (populated by
firmware) should take precedence. ...but I won't insist.

I'm happy to let Bluetooth/Qualcomm folks decide if they like this
implementation and I don't have tons of Bluetooth context, so I'll not
add a Reviewed-by tag.

-Doug

