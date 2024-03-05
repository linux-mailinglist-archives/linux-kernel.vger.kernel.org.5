Return-Path: <linux-kernel+bounces-92576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4C872268
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D92B24118
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79C7126F1F;
	Tue,  5 Mar 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiZp1Ho0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0270126F11
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651138; cv=none; b=lITHUssFu44ciWH8035TKw4Phj6gl9FtEVVrsiRFZQU/QaNAHch3rAUWu1b75wvWQ4Zvnb0slXG/wduCp7uPFTjm+LGXN1Tfk6QED67Ql+H1AAGjOJqGDWG0ZWc18vUM1ttOezQ8qBs/r8l/n1LtSNWBTKOgDjnnS5YBAniZafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651138; c=relaxed/simple;
	bh=gLPbfwuyxSScV3FBIWDvzEVVNxNHjNXrVi/0DTiPWz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRW9jyDmScTzneFY+663PbrSD6/FiOkSpAjyLMiTa7fr6Md2p7ZlsHfk9agLv6zbezQ5R02oFUjPJxRs/FlX0cqDSPdhVAFVzSIdX4uuZTNYD6NhLyJYyKyRw5HLJl31rXt7NUCxVB7t9K0KmvyLGcOeaCzVtFq6+ilwDVMW27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiZp1Ho0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8378AC43143
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709651137;
	bh=gLPbfwuyxSScV3FBIWDvzEVVNxNHjNXrVi/0DTiPWz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fiZp1Ho0Gif3cKd09FYqiAlwCbP7RYHzUtSAw6iOqfBciarjmpll75Dlxh7MvBsoO
	 mX0AiaGP8xtypa6DP7h3s6ioD4l7e94AkqUJuYCrFxOXYVitAbGmrsoba+Q02sUChM
	 fbFNs/i9em8t2C697ABvxV8jHWPfwSfPbfy8AYvXX+Ijly/BdW8fO05u51bLQ3hEyy
	 03rxe3dewsZe1RcVEZQdzn/6JEnOIt2xgItW5ATg46l041uPcdEzq0TVKCUV4Qo0FU
	 bO2XzBr4Er18JgJ9DR1CLM/LcDIIJ4RWfcjQ204eL1eYn0WPL1KRvdtzbbajdjzDxH
	 Yro1afGOhA3Dg==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60974cb1cd7so51375357b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:05:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXseXWv6l5Jo2Bh3yocnDw5NFQxuYj2wxFsoKVA9YyZU7BgmCJTpXJYvnMy6htJHyC/hJkMskVGcYUShajwbrXsSFzzjkSI7+b/5DP+
X-Gm-Message-State: AOJu0YwsivEn3SrBM4zWGODdvVhOxcQiGHSRskSfMstwBMDW/KtaBxU9
	ib7oZGs5PaQnf1ejBtdV2KjdhqYbU8cGUX2lkQG6sUOdO3Q3in4YJoVQym3uRm070oitlRYcBg3
	iLX2LrziZRKzsy0MTLDdHvtdciV04pjGKT1toLQ==
X-Google-Smtp-Source: AGHT+IFWDUM9HwjAVyidIugRw2o1bmiLQVQlI7WwFoXm7E/t7apfeZzkR+tB9l1gWqxkRhVhPTEX9nsRr8SIgWb3PLw=
X-Received: by 2002:a25:b91:0:b0:dc7:46b7:6d67 with SMTP id
 139-20020a250b91000000b00dc746b76d67mr10095871ybl.33.1709651136730; Tue, 05
 Mar 2024 07:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219-adv7511-cec-edid-v3-0-445aed2f1cd7@bang-olufsen.dk> <20240219-adv7511-cec-edid-v3-2-445aed2f1cd7@bang-olufsen.dk>
In-Reply-To: <20240219-adv7511-cec-edid-v3-2-445aed2f1cd7@bang-olufsen.dk>
From: Robert Foss <rfoss@kernel.org>
Date: Tue, 5 Mar 2024 16:05:26 +0100
X-Gmail-Original-Message-ID: <CAN6tsi4WzRPKRFTFcK=DwdL_Z_gJPugM1BYaZAGEq2GEkAq_TQ@mail.gmail.com>
Message-ID: <CAN6tsi4WzRPKRFTFcK=DwdL_Z_gJPugM1BYaZAGEq2GEkAq_TQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: adv7511: get edid in hpd_work to
 update CEC phys address
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Content-Type: text/plain; charset="UTF-8"

Sorry to ask for this again, but this series has non-trivial merge
conflicts with upstream again.

Could you rebase it and send out an updated version?

