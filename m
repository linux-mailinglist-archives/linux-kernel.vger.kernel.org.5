Return-Path: <linux-kernel+bounces-130518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCA089795A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB45289C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDF5155394;
	Wed,  3 Apr 2024 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l9PaDm5p"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436115539B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173924; cv=none; b=SuoTAvudLodgareFFT7mZP0d2JbSGhI1BN9zEmETWaVZECLt2o+YGqpHNuH6mqJTeMyptYNORtB1RZv3oVDiQwIPQh2S9V5mYR6RYQ0E9vFGcmxuXYC0Y6D44aBCyHIobVNe3B11xMDbKccRhbgMy3AmPUalBwO+fd/uzKw7gkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173924; c=relaxed/simple;
	bh=E6/hGNZuv/VUHI9Dwqlaan9ffvpB8IRCvV9lU5wlBPE=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI+LcIresxXR1cLEcPOaZY0Qm5cx/iq6QFdLagVOKqeEUEFHB2KCQmDyF/vJjCu5HfCAQToSUGAiM/nL9MMLaW7vApnPAOK1dESoeCe7R0wP5vq3NHq/WP30aPc7cbYnQ158ZqzHYQUT/RN5/YLpmpbaxjxq52rMtrkW+/dRn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l9PaDm5p; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d6fd3cfaa6so3290851fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712173921; x=1712778721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLedOIV4IbUFIx9RiX1EzuAEXy2HWZd818qXPBl48uo=;
        b=l9PaDm5pq2NYZl7sgNx0i7vTV+LoLZidz/Epe4YGIatAevQ9bMLWtYsZ1QIH6BR+9o
         uVl2j4PR2p3Th96NSi7Z6XDGaoz7p4rnOqjQtNa12mZVlmA+r/F2YUVf8mup7tODLDpp
         OXJDDfIdwSJZa50uAKSeiOx46Cy4wOpzranM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712173921; x=1712778721;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLedOIV4IbUFIx9RiX1EzuAEXy2HWZd818qXPBl48uo=;
        b=m8bWRYOX/w5j1sv0vJEw0xRqZtmOftAXjs2W6orDVwZ2IkG8F3kt8iLpzKXvARMECm
         B14SyWpX4iDivdsU7Q8QUawGQDvW/HQvf8SI+PesZbhwatnIpHxwhQC6X+xBFO6VL2TO
         otdMdX4pRrp49lv2dj6aTDkotbuYRXk4h/i2ceNIHKuzKeldFX3gs7srAlyV2KSsR0EX
         4FmVwJlg2dp+GTTksuQNAon2W25Xj7n33g3+v6Z9/hovZXrBLQMMfNKrQQz7JWCq9OQN
         xQExJIV2G26GQUuKusLZREL2GRs/1Ogu7UxRBDIg/Ty0WIWaKjam/ScHLHsrLOPGswTE
         movw==
X-Forwarded-Encrypted: i=1; AJvYcCXBzWDRMCfJNwUx/LsF8G4KCiKAKUKhbCI8E1V48VwOpDv/tPc7VMDfSZdUSEdqEG5bwGKuLbhCdAjcUpKSF58u8sCstN64o1MDFg/r
X-Gm-Message-State: AOJu0YwWXMp6jEaTIoWGxK6Vzok6I++7dZmn7QhWcDgnqUmEW0TiJtmE
	0A8gVcyEf3oRA0lhdI3521kHusKxRlwXcT4OkXcJN/M+r4XKaqR/i65ij0SWs1Lic8X+HwZlEdX
	DFX4k7OJX2ki1Fx7PWUZfOfy5fxLNyL5TE3dr
X-Google-Smtp-Source: AGHT+IG7N2SDMTbPzfa+yXCQ0HUxjbibr9tRV7f3DUYPSOrMBMyaNRQsZMgCus51dZ5hRG42yuWa3WupEQJ0EfwrKa0=
X-Received: by 2002:a2e:a4d6:0:b0:2d8:4158:fa64 with SMTP id
 p22-20020a2ea4d6000000b002d84158fa64mr382308ljm.35.1712173920639; Wed, 03 Apr
 2024 12:52:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Apr 2024 12:51:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1711741835-10044-1-git-send-email-quic_khsieh@quicinc.com>
References: <1711741835-10044-1-git-send-email-quic_khsieh@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 3 Apr 2024 12:51:59 -0700
Message-ID: <CAE-0n50Z2pDGH+ncjQq-huDsn9jdN=1SfaaU+qw229nZpUVCDw@mail.gmail.com>
Subject: Re: [PATCH v3] phy/qcom-qmp-combo: propagate correct return value at phy_power_on()
To: Kuogee Hsieh <quic_khsieh@quicinc.com>, abel.vesa@linaro.org, agross@kernel.org, 
	airlied@gmail.com, andersson@kernel.org, daniel@ffwll.ch, 
	dianders@chromium.org, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, robdclark@gmail.com, sean@poorly.run, 
	vkoul@kernel.org
Cc: quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com, 
	quic_sbillaka@quicinc.com, marijn.suijten@somainline.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Kuogee Hsieh (2024-03-29 12:50:35)
> Currently qmp_combo_dp_power_on() always return 0 in regardless of
> return value of cfg->configure_dp_phy(). This patch propagate
> return value of cfg->configure_dp_phy() all the way back to caller.

Is this found via code inspection or because the phy is failing to power
on sometimes? I ask because I'm looking at a DP bug on Trogdor with
chromeos' v6.6 based kernel and wondering if this is related.

Also, is the call to phy_power_on() going to be checked in
the DP driver?

 $ git grep -n phy_power_on -- drivers/gpu/drm/msm/dp/
 drivers/gpu/drm/msm/dp/dp_ctrl.c:1453:  phy_power_on(phy);

