Return-Path: <linux-kernel+bounces-105258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F09D87DB23
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7097F1C21785
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3951BF3B;
	Sat, 16 Mar 2024 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paWoNquQ"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4BB1BF27
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710611114; cv=none; b=kK7SISN1SDZMO/4j+U/j7EAmppLinIVlQW67MTfA63e07aHc6Xe3K2eBmrnckqn7g5vnw9h1kkXu0cVAPmhAPB/nClLW2eMOyq41Bi60dHnLZ9wR7plUze2yQl2GMfJARoh7/GdXab5mmEgEqMTEGve4S3eLn3/h09bNWPqkVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710611114; c=relaxed/simple;
	bh=z+3hOi+t/3d4ZIJDT0CoWOqTE8fBj4gWak5nVoFzE5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoAfBxwptUCte3RbRY5R66BThweIZsTSnD+YV7xUlbMD6Gzv/0Kb9oS4lrcDxvgE6CRHuOGE9UGViIfhHXrkfoBalx4Wl3m1KmJXMGOY6XbWXCV1hEEq7BJGHmVhL5bpMP87XaUgmswZSwZ5M5TUQU95qlQKUGxUTbXmv6qUk3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=paWoNquQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so2621566276.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710611110; x=1711215910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJNewuV/RCfXY7Ye9IxwUjaXSFdbrW2OP2WL5QHwl/E=;
        b=paWoNquQ2gS8ed3nm9nbx/qgeyEMccrSMLw+MAEcSXUuBRwRk8RTWj/t0SCBgMSiDi
         7omRXTLm9ibhgbNyTAevTRpOLuTO77wsJXArnDK1GG52zNfTj9duaFo3Z3SmkGCPApEp
         BZoqcdBCBWbQz2aDEPUyOttB8MS3TBbZxX8ZHF6CJLwSd+17clI4P+4zBg7SpVBcoCIi
         AzZYk83awNGTgiz/kU4+Budzl5o6Lrl6xrTaFQ9ULfSkubczmdR1pmEwvFQNV76FQ2Oz
         NZexQLSokLnsrszvAUiIgbEyzohboxerTzqWUWzLXC5seplTC3ODn3G75tVbkSLosGYF
         PLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710611110; x=1711215910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJNewuV/RCfXY7Ye9IxwUjaXSFdbrW2OP2WL5QHwl/E=;
        b=eK1CkVLQwHemRZdWHFNj/NKnHw7ymkEbcbmh5eBkBYNbO74vCWw+Qx2umRMyFxIx6Q
         Yb84Vkbtk5U5e8W8ERYSOku+pcJAAT4MYCzLN+bJnxXMrvWKLppvS3Puw9igllGNSuhs
         PwPBnRe1lzz8t/AAjhyL/iqU0CiWJzEcJUFmjbo2axZclV4JMG0XRyMijp2J00JvrMNI
         6qYXk2ZiA/3GNaeOFC5/nn+F2PSPQ1WGkmqGV5U0zYxtWd1SG1LN0coLljtBk84saPDD
         61w9ayyjk4pFT2YRoJ25blX1dxwl4VImmjXc3m0gAAbkqJlOeEi6tDTn/SFobBkz6aT+
         OxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhsM5R/Rrs2fgn8cbSqE4smq2VCswRzfTbozxdxJvjwEzpFEthdD6IcW2c5npr4kSMc3MkOmG8ADw0ZFvLwqvxKy+iaRG6XATM/wfD
X-Gm-Message-State: AOJu0Yz/OzlrjY78WX+A+nIAJyZNEzid2Hb1Jf3y7W2v5HkTYwBTpP+Q
	XzzIs8Uvr6ABXaNunv3Z+WMZnFT9xsStgqb+nYwAmtH0aIkD6HeewyoPNd0rTeQeEum7jVrUnjs
	JIiDpUiet7U3hFrhyusuIdx+DXI/DEWkS27XNYw==
X-Google-Smtp-Source: AGHT+IFSqFJCubpH074e+FG4hgh5Ds4kjHPAh6KmyJr9q6e1FJXtc5mgxa74Seojj8WaamTfrsqxnGpW2QsAGZe3tw0=
X-Received: by 2002:a5b:402:0:b0:dc6:aeba:5aaf with SMTP id
 m2-20020a5b0402000000b00dc6aeba5aafmr4918450ybp.19.1710611110284; Sat, 16 Mar
 2024 10:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316170513.1159724-1-sui.jingfeng@linux.dev>
In-Reply-To: <20240316170513.1159724-1-sui.jingfeng@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 16 Mar 2024 19:44:58 +0200
Message-ID: <CAA8EJppMRKtVRXhZ+QWQbxgS3F2tdeUNnb-d-iFUUp3EnH2xBg@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: dw_hdmi: Switch to of_graph_get_remote_node()
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Sandor Yu <Sandor.yu@nxp.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 19:05, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> To reduce boilerplate, use of_graph_get_remote_node() helper instead of
> the hand-rolling code.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 31 +++--------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

