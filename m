Return-Path: <linux-kernel+bounces-122309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC3588F4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C90E1C27BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E412263A;
	Thu, 28 Mar 2024 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBg5y5MS"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD64A38
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590905; cv=none; b=AzZm9iWWucHu1AFel09UMBBJuhtx12ft8BBAfXmkExGm11CycZ/xRv4ocwbMi9sEv4Jcom0/vdz3pzIEv1aN5zgcVBAG+gfA531b6KVCfp1wAgLl5ay4NMSJM130xfOq6MGg/jU1BzRF1ACf6Hb7wOlwbwUvmm3YSG4jbtIWurg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590905; c=relaxed/simple;
	bh=HZdnwNoXxWoGzLg2VQ6m1rbwvJy9TXrJcq306nSM7WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhSyHh3LsC+25ctRxKNbkxd87CsD6aBo1cZLW85110710G2NkR83Kw8QvKaNVed0TRlxsmGEJU+be4lKBkJrg7/Mj2uvKAz7cpAU88lrpwKFYBqm7Qt2zw+oF/zeZTSMTzUGZ6ExUbZPLbfGSj2YAASjK18bEWjTAkkskBwf9Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBg5y5MS; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so426317276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711590902; x=1712195702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ALb/aRygHviOk6gluVyyo7V4k4A2Pfn1TEU0psjmkus=;
        b=DBg5y5MStygXbyrwRN8W7e27eaQiA+Y/Tofz7xAZJk9ljVbqrxkCJxly0QyDALVUhE
         GpQoNLMeAHbbkCvnpo7op9xHmxqzeFCc3H4S3+GZ+fpyO1wrTVVBYWu/Cl4sbxXbFR3g
         ZNI/vV8T05pO+Q4+l2wuZ78bPW3KDaxLjD38zGvwM4+EeEa3qHoX1A+hW/YL1pt+9z+L
         XL0kKm/JoAZKaDD02PnvRIgJm7WjMsZJ/PJt1o6yn4ToYv+vrmmPde3yzDNXP7f7EtGT
         5TlAmsVIX+/W9kUgPyxtqmDuZ5R0QljUyv3aubB7slaVnDnOHz4ZskB6kjIq2uPTrd2/
         OJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711590902; x=1712195702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALb/aRygHviOk6gluVyyo7V4k4A2Pfn1TEU0psjmkus=;
        b=BvU1++Bvsr3fRMZEfcSOCbzFX7ld4RiqYWcF5BHik0Y3s1k6EKP3yFFjFfvLVHIq2N
         zcqXh6cJrwEOixLMgFbkx8PIM3A0kd7gUYRxFcCVEf4xxShmpisKGOV7vLPaufL3XhC2
         hx6REuAjfZZUVcSW4qzBoOUXpHdm7dd9ni5tcvrYa5or2HPVBPgtNaStimHhg9BT7y3L
         xKWSYaNF1RAHt/0FEz3DKJusad9pkbIXeUTGP5OSxWf0LM9Rvdzs7XdEYb1qo3jX6slk
         DVp+O0l8XKOKxCAnLq1Ofirzp4J2xrqinJKMXFpMTKBShR4ADKYQAGJ/o96Fw+VAKzyq
         sMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSSfO7GCgVQO3Lkl0WH5+iS3AS8Rl8gpLifr1ysuEmEm+qOHmXcd4yWVSiYTLDkks7gKsUlKN9XRD+TZJMjaqOTDVGMkmNlKoMtpJN
X-Gm-Message-State: AOJu0YyxCx1WqaR2tPZglWEHD0k4tha0a6LGjSwK6Ehp3UYKhm4yFoLp
	IVBkAmewJx686pr/m5d4yBljM3IHyAhVnDk2seUTnP6dPwircUp1wXVfkvElCqC03SDXtm2glIw
	dh4kpuA3GuH9cyF+AzWIZAcaWsJtfM/FjDxbLaw==
X-Google-Smtp-Source: AGHT+IFCbaTC3zvlel//KUFNLOeGVfLTLHjUeq3vH+xCrngLpNb7HC0ZeixUsAO/5BEehPEYBqCSaYH+eE2+mYXJSu0=
X-Received: by 2002:a25:ab8d:0:b0:dcb:f7a0:b031 with SMTP id
 v13-20020a25ab8d000000b00dcbf7a0b031mr1608022ybi.50.1711590902480; Wed, 27
 Mar 2024 18:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com> <20240326-rb3gen2-dp-connector-v2-3-a9f1bc32ecaf@quicinc.com>
In-Reply-To: <20240326-rb3gen2-dp-connector-v2-3-a9f1bc32ecaf@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 28 Mar 2024 03:54:51 +0200
Message-ID: <CAA8EJporooWutXaN4DYHK_G5=zY+tW3YLcieAwAX1Xno6KanDw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: qcs6490-rb3gen2: Enable adsp and cdsp
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 04:04, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> Define firmware paths and enable the ADSP and CDSP remoteprocs.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

