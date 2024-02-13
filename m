Return-Path: <linux-kernel+bounces-63378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16611852E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE70283FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A228E3C;
	Tue, 13 Feb 2024 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uxh2Rp0T"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332228E3E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821677; cv=none; b=aVoAQF3PHkTIqWgcKc2oI7WKw2ETCOyoi83wOCo9HUghzoZFliecjsqbYKG1HI33ru5ngjZaJNOk/ZtKQUBMd2SXhxB7+ZRyL9gyRUlyuaJaqieiHie0MSs6jUPKozLx5Rn9ktka1lWAatkKon3sZfWhF6A57J+gotviVOSQNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821677; c=relaxed/simple;
	bh=gYHrqM3G3kRoZsoYastsq+KgNzJfw/bctahA7VNbwNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCmDWiViB5NlmH+0HagybPMYMuMTwzX3Ss+kajHl4kXXowkE5VcbLnCuIq0H0L99EGDig5cFSZiEkjgB0WaodyA0cl7cNdPl/2lT/ELKVdpOVGWw1dRPCbuLVPj99dq9b2H6qAMREu71ssxHnt62ohriCJAQkPZc+Ubi2gQig0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uxh2Rp0T; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso809739276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707821675; x=1708426475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U1uzd+QYrNr3GtaEVm7817MCVofpByYmPHh8dkivfTM=;
        b=Uxh2Rp0T2SPY6/aSaLGY+K3wzeoyzUmbEPLlrfQ+CoCRg0lGtdMDsJb80qNmYkHCa3
         ubf6NoOCpwgKlDYZDNJYGbJ25rvGPrQXCiXaMsnvA5TBQKhskIe4xrR6sv7MvGib7k9x
         +Jwj9KxqMZOkztIT9hV/yWWfhPtDShrR3QmQnz37s5snIg2tbsXMWNChzpsamixC8bhW
         dAbXkZwgUpH4/DtQ+2F59Qj+GIOw8+OFBHpEBaNvfnIQqzVGSsZ5M0Nrh+tZg1e1vIKY
         w7hiAUcPswKg4Sr00bdOB2A4eAEOfNWLbAn4FX8udlQl4t/3g75ctbFF4AY5tux2xSD+
         d7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707821675; x=1708426475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1uzd+QYrNr3GtaEVm7817MCVofpByYmPHh8dkivfTM=;
        b=MlxyF/QNjye6KS7OeYmtdn8VhoY82DPMS2vFU0LtEMjiL1Bx3FP0hSQGHwZ0EhvxYh
         cg8u08k7q83PuSlprhcM2X7Sfo+RGvgeQX7Yy/uxrjcnKvUTVDBqxSHp1KPG/hbGDN0D
         6+ER8x4jjnSV2H3YPXsNza+TcEEbV4x251f1zzZCR+Zsbid6urPeG9elm+EWBBT7JXWp
         UqsewqS9yCGB/0H8W9tKjbmClewb+bpW26KDCpd5GAsLL7xZt99m9k2WzgBg2wIOiIcr
         1E0aS7ejJ4s42VF7jZNImRZgcpH6LrtKdp9ExHStDUY7tZFhbqRPGFcxrN0izFZKx18I
         gv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH9ejfrYY5VNRlRyzcvmkdtIjxbpvzqj11AO0L86If0VoFXj4YXifOOaq3a6BcpBfyozDoxy9hbG9NKAK9N2jKheqd2J3s6AsSKB1c
X-Gm-Message-State: AOJu0YyU53KdaFr9MjdX/UG22UwstELtr798Tp1GkRarPtNdy/C9bVfz
	jbaTb3yDMuIntFpFXI2AeUVnDtG1gME9sELqblBdH0YCIONgZHxZ5ZATjPCB6x5islTmjZbwQwT
	r08uKZW/1Zdsqv2IeQI/gqEClRStGKZaPCTZ67Q==
X-Google-Smtp-Source: AGHT+IFAWLxJcI5gkouU1r1s5LPV7Trnv3iW1vw8OhO7CT8+bqdVLybIeh0ETpjhTb6NanG6KbE/5Wo7b825LL+mGTQ=
X-Received: by 2002:a25:9703:0:b0:dc2:234d:214d with SMTP id
 d3-20020a259703000000b00dc2234d214dmr7312147ybo.40.1707821675312; Tue, 13 Feb
 2024 02:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213104754.8195-1-quic_riteshk@quicinc.com> <20240213104754.8195-2-quic_riteshk@quicinc.com>
In-Reply-To: <20240213104754.8195-2-quic_riteshk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 13 Feb 2024 12:54:24 +0200
Message-ID: <CAA8EJpq0AnPgcP_zWw2hOYKeZ7uvuf9f=Z6=af5H4BCE7TC-Dg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: defconfig: enable Novatek NT36672E DSI
 Panel driver
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com, 
	geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org, 
	nfraprado@collabora.com, m.szyprowski@samsung.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_abhinavk@quicinc.com, quic_rajeevny@quicinc.com, 
	quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 12:48, Ritesh Kumar <quic_riteshk@quicinc.com> wrote:
>
> Build the Novatek NT36672E DSI Panel driver as module
> because it is used on Qualcomm qcm6490 idp board.
>
> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> ---
> v2: Fixed review comment from Dmitry
>       - updated commit text.
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)


-- 
With best wishes
Dmitry

