Return-Path: <linux-kernel+bounces-50546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A963847A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC341C257D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D9D17BC1;
	Fri,  2 Feb 2024 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AdRDldI6"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE51803D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906223; cv=none; b=se5/C1kEtmcgQSjZ6tRhhmHWF3lA6c+ttPPHmjTCPcjcyi8UfGLQfDTAKkgxEQPjfpLhSRXta9nRuhqTAN9mA2JYwD+xHs7sx7JGWi+GoYhNocsOdrkW1ngzrWeRWG1L/umTxuINcw/tiQNRvXA8Y1liICg+hhXmpNYfA60dTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906223; c=relaxed/simple;
	bh=53lrrcAwsOReEPvUCjLVaJtxk7JP82CHsTgE15pO0as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FG4asIGy+YXfnPHl4yAf4HJdgu6sMbVgIKQNbCkzkq/WGtokmnwymdQJ5TkNCrKYUeFRh1XoIUw7J76HO8pOmzDpgLkD+H+SENgzSJh02epmcPLcWUED+cQolMRjMDsuYZD9PqiIFExrf2vKD1cm4apZ/B2D1Rf447w9R7mwNs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AdRDldI6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55ff5f6a610so1134678a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 12:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706906219; x=1707511019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h1IIKH0viGaA3orHuy1hmOvR0Hle+LrWHOWH3Kx7Iw=;
        b=AdRDldI6kbgDQkN8r07POl0MgA5ekz6Be9bJih8f9S4ZaCEedtCPBgJpsFVuFbZn1w
         fadMvQKESc8Cue14gWHK4oEesN3T8aVdvDW/xwy3ZKemwfbVWmgIdqiIDZZ9PPpOChnW
         izl1xoXkYbE+rDSbIktCnyM4TapuRW/g8dnXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906219; x=1707511019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0h1IIKH0viGaA3orHuy1hmOvR0Hle+LrWHOWH3Kx7Iw=;
        b=FZNtoEV9LUxIzEP3DRtkjCrZR4k+vMiw6JtLTPfogCjsiinCn1vMTknI82sOE+co82
         ezLeqXqB1+5Hb9KAZpoPk5I7Rn770G7BaX/V3qIZcEwiBrnpv1JXlJyTHltcgIcITwKB
         tkkjGvixNiAHCUXbNnkEaMfOcnnR4lgxQfs60ITq7qTZzVxYQK1d463xW3NkGw8GW1dp
         Rissm69JWPs+jl6Hy71NQh2gQAsSMt0/sh9CdE1EwdBz8S9sOjowNno7xJHXo+aXTr4X
         I26TXHVz1AIspEPM02GG9ggWHQ2F9ziwXCI6eI4g0J982WkilQQGAt5upWhPFDU+pg20
         ocaQ==
X-Gm-Message-State: AOJu0YyUw+rKIyJqaiTYAe97XBhgVA2zaeMmYS1QZOBs7A8Hx8QLo4R2
	OGvpgWRzzZfF5dP5xN0Gn8FztLZDqDy/aWNrdZiNx9VPuWofomhr26P+NS+pFmcbNz+f4vcYS0v
	s1Q7m
X-Google-Smtp-Source: AGHT+IEcLQ0icpmNoy+J+kDMq54/4FuTbAdxRRN7Ob0FvPAi70bsan/AGhaq32V/bhYEYG8GiHJZYg==
X-Received: by 2002:a17:906:f844:b0:a36:bc20:9a30 with SMTP id ks4-20020a170906f84400b00a36bc209a30mr4590802ejb.54.1706906219424;
        Fri, 02 Feb 2024 12:36:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVghUENIoO47m2PJfqJHBKuP25jbNJTNRXaGyoFMoLTrrpxg0JGyMr1hRYcJ2ggz9Va986E30100ICsAzJUnQL4Eq88Qbwt4UAh+bYO
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906640d00b00a35d7b6cb63sm1216220ejm.28.2024.02.02.12.36.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 12:36:59 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55fff7a874fso13a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 12:36:59 -0800 (PST)
X-Received: by 2002:a50:8d15:0:b0:55f:a1af:bade with SMTP id
 s21-20020a508d15000000b0055fa1afbademr6757eds.4.1706905905770; Fri, 02 Feb
 2024 12:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202202329.4172917-1-quic_jhugo@quicinc.com>
In-Reply-To: <20240202202329.4172917-1-quic_jhugo@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Feb 2024 12:31:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WkNKFiRKyadVnAMmtcDH=PVv6vk2CvMbME9FZ5UHNxuw@mail.gmail.com>
Message-ID: <CAD=FV=WkNKFiRKyadVnAMmtcDH=PVv6vk2CvMbME9FZ5UHNxuw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: drm/bridge: ti-sn65dsi86: Fix bouncing
 @codeaurora address
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	quic_bjorande@quicinc.com, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 2, 2024 at 12:25=E2=80=AFPM Jeffrey Hugo <quic_jhugo@quicinc.co=
m> wrote:
>
> The servers for the @codeaurora domain are long retired and any messages
> sent there bounce.  Sandeep Panda's email address is no longer valid and
> should be repleaced.  However Sandeep has left the company and has not
> been active sice, therefore it looks like this binding is orphaned.
>
> Doug is listed as the reviewer for this file in MAINTAINERS and has
> volunteered to be listed within the file as the binding maintainer.
> Therefore replace Sandeep with Doug to make the documentation current.
>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  .../devicetree/bindings/display/bridge/ti,sn65dsi86.yaml        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi8=
6.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> index 6ec6d287bff4..c93878b6d718 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: SN65DSI86 DSI to eDP bridge chip
>
>  maintainers:
> -  - Sandeep Panda <spanda@codeaurora.org>
> +  - Douglas Anderson <dianders@chromium.org>

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Unless there are comments, I'll let this stew over the weekend and
then land it through drm-misc next week.

-Doug

