Return-Path: <linux-kernel+bounces-126409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DE38936E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6431C20A97
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93B23BE;
	Mon,  1 Apr 2024 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5rnfvDJ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC141113
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711938218; cv=none; b=eZrWIMbjxdjFHt64EGdiWCJTekf9/naxh5HLD0DuCVdyE8Yxv9ljcjfB0BWQCVBfx5THae0vBvHkG1+CGFqCz+/G4mzbpIYbVUJMGcQF2d7+bW2GV9L68LD+hXDJfSo+KSx7OEflrE053B3RQP1YZWNzRqU6ogh0GYayv5kWMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711938218; c=relaxed/simple;
	bh=j41BO2dds6Fv38WNeZ85tSAZZ0NU5bCk5e9Xy6YPOvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkfFD+3eWloOdVQmgFl/PjSOgxGUyIOJtbiqZ7YcLpqcfZVTYsJ7mtQOZDkQlotGFxbhlfLWGdVBPJPWj4wbgHx1wdeR6+f7NC4jX2NfOXHnywmMPI2+VT/6sV+TFkOZNdTzt63tqB6tsT5CKEAUOSpS8E8rWPvKW/XQr4+LGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5rnfvDJ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d475b6609eso38677511fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 19:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711938215; x=1712543015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXfMuGsoJ/atd6ywH2U36Cddge1WO0AgRUSU8JyF+V8=;
        b=a5rnfvDJV5Sb/7iXcnj05YVqRjdll/zmN7wOQ05Y4whgr6AHG0sdH8Ba9Zh26lmlZz
         cuT2wK0KdAJdJzKL0rYV4pkqhfQZYbhpeNbsUfVccdbrQmQyBXjAQu3dktyF1QrbOW/L
         IDIUepG6U35RkVW+kLrwYFArzRaddkoMEicyKgTH4YdF836HJL9DmNR8t7SczOoJOdBT
         VfpdJZvux4VLmgHNfX2LjhUheIHw4k9PVWrP+0UwLRuTVoLeF6rKQcefQL9srx8enAP/
         npuA/bxTco4EdomSNuvLnNPuiDLYOQBqnY3F+015dn16EMvc7yTQV+766gQ7AYEDh7m7
         wBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711938215; x=1712543015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXfMuGsoJ/atd6ywH2U36Cddge1WO0AgRUSU8JyF+V8=;
        b=ufUDka9LrTQBM0P7CCxTD7kKWVUI16YOLXJHWhqLMnelvhKQDYsrZJylT+xkF8pb5x
         kkS+BAz8So0hsOvxxfc0oua/F+2wPBHbDBOVLbXAHBAimrpp7N+uIASqDwUfsbgMY/ks
         S2k/mEr+ciIyfR1ifNuD7KTALf/4AXEshuE1CyfR63xNtY9hux5/3sM5S4iZoj8dPCe9
         7SWjKC/gN+u/88/q1nS2RyrN9eaCgF58PNpxC28Q2KVapbevGqUlFOWIPi4BXuuhwFD4
         RBeUxh5JH+W/j8coVTgiUUhkQ5d76CuTRahW/d7v3CUQwjwgtRzmpT3BU4n0g+f1HjRN
         OmAA==
X-Forwarded-Encrypted: i=1; AJvYcCWh3rE4fBNFyetscj65dF7dpHVkfVAI9zjUYb8A+a4YblP6tUPqXzFbWJEjWzp+I99VMHuBbeS0pGcaOajHSWKo34mXNKIgFCaio1iU
X-Gm-Message-State: AOJu0YxVm4dHpRfzvlVy/Dzla4n/xe74NLIoCC3FsP17bDwRsGppC3kp
	KaPr3+tKkq0rcrQNQnWwa5FrKImhuYACQsDBMjWcvhV07N2xX90CVKjhVtjVFj7lKceSeYNc5Bu
	YqAJNEID/hXLeJL1+QCZ9c/Nvd/DtBljglc3hJg==
X-Google-Smtp-Source: AGHT+IGYmZtdzOWFfR0vTWyRYyRt7t6Ny+ula3JSyIJ78UHqJttV707k8TBzXPIipjhpUNAlaXV03FimDjkqSbpIieM=
X-Received: by 2002:a2e:964a:0:b0:2d6:d4ca:fa8b with SMTP id
 z10-20020a2e964a000000b002d6d4cafa8bmr5023108ljh.34.1711938214572; Sun, 31
 Mar 2024 19:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-topic-sm8650-gpu-v4-0-206eb0d31694@linaro.org> <20240318-topic-sm8650-gpu-v4-2-206eb0d31694@linaro.org>
In-Reply-To: <20240318-topic-sm8650-gpu-v4-2-206eb0d31694@linaro.org>
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 1 Apr 2024 10:23:19 +0800
Message-ID: <CABymUCPqeu=41=jTnTLKkERRG9PMaqsmfyq41TDa43kNvjxEcw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sm8650-qrd: enable GPU
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Neil Armstrong <neil.armstrong@linaro.org> =E4=BA=8E2024=E5=B9=B43=E6=9C=88=
18=E6=97=A5=E5=91=A8=E4=B8=80 18:12=E5=86=99=E9=81=93=EF=BC=9A
>
> Add path of the GPU firmware for the SM8650-QRD board
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
Reviewed-by: Jun Nie <jun.nie@linaro.org>

