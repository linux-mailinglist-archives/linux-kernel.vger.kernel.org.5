Return-Path: <linux-kernel+bounces-53263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C68084A2D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7D628A504
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7E348791;
	Mon,  5 Feb 2024 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KSWzHKh3"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF07482FC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159371; cv=none; b=m0vtPMfMjUnWt/ZFP1FzvqCrMvCAAVCfeF/jyu8ISVcKwVSWZkw6Lt4HD23l/DFjG+qso21rXt2VVpL8hDN+ZHRmGpdJzE3HBsVCpDmAoaPP2eWkvYEjSfYZT/q49kjJhloBIa6rkHTa4nl5uCM7d9DqbuPH8t96O1UcEX1FrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159371; c=relaxed/simple;
	bh=bzT5qI0/N/5/dC92OnguBaRNvQJRdU3/Ts0xpiY9+mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eocZIFRj8jYCF8IBiAkYoru+z0UdsExg/JS5YKkTUTHHu+7XX/pL6BWfcr+cE3TfK5I5pfnXIZVx/4pxVidwyDO4VGu1rs084C0f296wgurpcllPD6RQDUIyTeZ/yFGB1qKc8atx15qBv6LFG8fFi0uFmW1xh1/gbXY+ozJ4bxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KSWzHKh3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6040fe8ba39so51772397b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707159368; x=1707764168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G808gfmzZ9j432kXszfFxMM7lLJBObo6nQSQeq1OGNo=;
        b=KSWzHKh3aqfSaI4DCQDG2EG6ONC1PGYkP7sBHZrCQL2hlaCIALf9JQTyR7I8B6hoMW
         4jz1EQLIayD9n5SRDmEUOOC/Vi2uvivsSrplX5pD+l+yzKISlWmCWMnBTY/wp/NOwczq
         fHHiS81k/racTd18syZvQCLLZKz6bNsWN+5S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159368; x=1707764168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G808gfmzZ9j432kXszfFxMM7lLJBObo6nQSQeq1OGNo=;
        b=trN82p0u2L/Lq9xOHDzq2GpRXi3F2fbvQ9u1BnatIYMuThKG7sKHUw3EaALgDDrN5O
         luO4s3OK+sapwJL5XHY88dc6z7IU4DUCAXLRIspdybH4GYeEWHuLvO5xiIMgGwvcEnZQ
         3ah1bmM3veXoebh2jHr6lD1B/ZNW5e8RzDK7U4dhnc0JQ6GIjCzg3GLGi+inoHg6C4wX
         zyXfarCyY0PFuOt2EHuQuZghConDa5i65cOajG4XNt/xZBUmWGES2w9jMJfqbcf2nVxC
         3r7V69nWF9hUwRm4HaAdhxDRcc+fKVnhKm0yybuGcXvD1w4BE5kDvXriGe/+bbsnsPNo
         Vt0g==
X-Gm-Message-State: AOJu0Yx4QJfNFOJp49RY1Y1KTlzTwaLsOdXWu+RrChPUJ4/3nuGInZO/
	IYeTTTSs0bWyh9G2D3Rcjk7n+E3sBAMpLIn7HI31ifvryyyvul3Q3hGf3lJMnlY8yR5Ea3sJMpF
	/PlSc
X-Google-Smtp-Source: AGHT+IHm9/2ZASdfom+CepHigyivw2perLKntuflP0VQja02t9AWwvJhjzoktGAJxYe70pyioEYekw==
X-Received: by 2002:a05:690c:a9a:b0:602:ce8b:6aec with SMTP id ci26-20020a05690c0a9a00b00602ce8b6aecmr492067ywb.51.1707159368083;
        Mon, 05 Feb 2024 10:56:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXiZaedOLMw9/Q5qkNFzTA+Xo/2njT8fYAfvDGhIz9H/MbnKO4xmb5XNNCuEVF6fCrnlcoSNTLCm/c11rS+WQAMIzqm6jyLbIpDJHl4
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id cn28-20020a05690c0d1c00b0060417488ec9sm75053ywb.87.2024.02.05.10.56.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:56:07 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fd15fe6a8so11975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:56:07 -0800 (PST)
X-Received: by 2002:a05:600c:5185:b0:40f:dd8f:152c with SMTP id
 fa5-20020a05600c518500b0040fdd8f152cmr31004wmb.4.1707159366499; Mon, 05 Feb
 2024 10:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202202329.4172917-1-quic_jhugo@quicinc.com>
In-Reply-To: <20240202202329.4172917-1-quic_jhugo@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Feb 2024 10:55:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WyUzDXhr_g4C_5MiDioBt=9D0fkL2cQStP+EFmkydbsg@mail.gmail.com>
Message-ID: <CAD=FV=WyUzDXhr_g4C_5MiDioBt=9D0fkL2cQStP+EFmkydbsg@mail.gmail.com>
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

Pushed to drm-misc-next:

2592a36d9569 dt-bindings: drm/bridge: ti-sn65dsi86: Fix bouncing
@codeaurora address

-Doug

