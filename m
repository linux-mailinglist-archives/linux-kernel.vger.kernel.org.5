Return-Path: <linux-kernel+bounces-75690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8729685ED70
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5031F239CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D9712E1DA;
	Wed, 21 Feb 2024 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNMHIhrU"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD812DDA3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559448; cv=none; b=nQ/cWpIbJdS4L1jsqY0iwKfDLvFmfBAzKwdwbIZtHPxXknlIpgj+G0vAg4IZ6j4+tILgc/8Rodovd1b95bcHrJLZZXhv6zdMBW3pHvxe1Ss1V3HiUBxoN1VKnk+6zCNYtAykdvGm2mJY5hkfWZfcCJCuSPhOb0tSHV9ElY38xKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559448; c=relaxed/simple;
	bh=ZGM7SjD+2AN/b3C707WSEvKO5EIsUT4jEoH/tDMkotc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LECS1wDfwo/CFZU58vYi2srGq22v6WEcOKdAyIP0uHbcU4LsPHnNoHBLzxg3TgOsoqox/8bZ1yI3SPBPTgFMEge4AQEMCoI3OgTWTKJmU+TxTluaZazSG8bXmx5uNl0d7os/0knKoUabWlOTp0yjEMJjffXtczZK0v9GIN3+zao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gNMHIhrU; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso7042844276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708559445; x=1709164245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dRyWhwvB+YgxB8WYY/8RDhojBr0l/X72f+I+EDyaksA=;
        b=gNMHIhrUKvRdbJg6mCYzEy12MX7Q3pEKIDaul3Q+uf0Fvp9ztIggXadHRNDTxv85KW
         LMhdthjINDZEQHTJwP8SxfCMFuIy987F0xC5UBNdYiwHlB4hDMW/uff+eBj+8kd5dWZX
         u+BHbGKV6TkQ7PLQpHk0AaKikHbULlafhSFfdsvnuM2e3lzO+ZyYJ5uygCIDY5wi/4nr
         dmvZm61JTjwL8j+UdKDRa+W7sgX8KEiQxUnI+Z1UWxmcXRcngjLXXwgF6LNHpxD6DWCy
         dxI9CGpYqI2MKl3pGfilhpC7SHkuWaXq4vm4hZRBDDnOThdfVdY8WvmLZotKnBB5KQQE
         I3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559445; x=1709164245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRyWhwvB+YgxB8WYY/8RDhojBr0l/X72f+I+EDyaksA=;
        b=hxzBISw0CuOr2fsBonZdnfwqsnFsAPv7B9CYDwBIbX5YSadQdV3tGhXQXwxMp6mNHm
         0hK86P+/Dah1nXG45PDPizP18SISGjjJVVZ4ofxqABTTA2E5GsRHaJDvHahSP0P0G4n3
         stnaoPJnlnH+rlOXUz5W/pvyg7JH/07kmUIXGY2yPPlYdf3SQdrpsQR+onAgrZ6AQPF6
         7PMcSzpFRw1524Dp1yDLFMj7oQTOIQw6ApjerQuVg14edJGyejxM7Sfl/x53i1hPdX6y
         9wLdRg/kpghP7Kcm+A1mAVkJ/mEk9s7VC+7WMqIks9M8BbNWosPUIvpr0xYjqW55YDG9
         hdMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQowdTPQWsEnEGb5rSNYh02nXLbuIR5UtOKbCfXaDwo4LD6Syg8ArjDRZWTy64DrQye5gpyxUcc7YAxfUbTa/1bzIXDUSyqltKpW4a
X-Gm-Message-State: AOJu0Yw4nTmWEYDbrgVA4/BAZoYbfQUgeUtTaxLH9SGPlDM72D3mSiHu
	s+eo0+dBQFy98BqW6zS3xxf0Kjs5nY2tra7jBQJoA5ith6IVhCrPqbDv0EPrsKBYeLXTviahygR
	6+sm9YxKnRofM3bK7dTaRjpKuOkdbzhcEGLrdS3xl32pb4KXJHqc=
X-Google-Smtp-Source: AGHT+IHU3Y06Sp27kn+vm0riOHx7jAbAYGiCMmYl9aItPwEeAoJ6loAk6SaQpv3mn4p+wcmpr6CrNg3BZNb7xYkUQRU=
X-Received: by 2002:a25:8d01:0:b0:dc6:c2b2:c039 with SMTP id
 n1-20020a258d01000000b00dc6c2b2c039mr882350ybl.41.1708559445157; Wed, 21 Feb
 2024 15:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com> <20240221-rb3gen2-dp-connector-v1-7-dc0964ef7d96@quicinc.com>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-7-dc0964ef7d96@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 01:50:34 +0200
Message-ID: <CAA8EJpq=kFhdqbnLXLLdQ3AkYb=vNOzjn1hMoNJx8qEJ4FLx-Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] arm64: dts: qcom: qcs6490-rb3gen2: Introduce USB redriver
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> The RB3gen2 has a USB redriver on APPS_I2C, enable the bus and introduce
> the redriver. The plumbing with other components is kept separate for
> clarity.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>




-- 
With best wishes
Dmitry

