Return-Path: <linux-kernel+bounces-57950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29FC84DF68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDC61F28527
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB44E768F7;
	Thu,  8 Feb 2024 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ud9mfGlv"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA17641F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390391; cv=none; b=hQqeVVNlgxd7Kns2rAGQpPcR9tHRCuxlTunvlG3Lgs8NB4cdYF3IusTDS9nFHDzTKwJk7I2THYpUQ8p2UjTxZNybgxjsITFcfLwY/jytOxZF85hTTkqEcdeae3/+EQj6BE+uE0tLM21UMIbsFE+TWTikad/4puD7mOLAZF9RaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390391; c=relaxed/simple;
	bh=nXEJucPloRyNfQg1hxo160IEH9PiiHbyQJDfLM4pJ+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4YMWMrHf+ae9h5ABVI4gABbbjK8fkmuZDWpaNg7v8xksc0S2kmwErNgc0ezqWa+9/UWX881wbsOHjTjjBmOkS/yT9P1gNAbitmRExTvMU/F8sKkgT9maPkl2ZPO/Box96RE36t1CpKB61pTy08id0SmNZ1IQK6i3OBurTKG3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ud9mfGlv; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-604a1581cffso9485437b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707390388; x=1707995188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zv2QzNoNrHR0W9Z/ijLeBt72BsIROQonHbxqN4l0J00=;
        b=ud9mfGlvEMFoCtW9mj0hleJ//Mg44k8dI6ENHYyaa1gbxWXi/6K9AtzVApt/URJ4nF
         unt9/3hF2cyIo4zlZ431L/xAYGdRQ20VU6lwwvrZclpvyQFFYoUq1l3ip1daxdtV+bzl
         JI/TfmPMrpFOYqvOIkle8t4O4fb/Na/l8GB9hWzU1WMsrpjGdtE7oGqIAEpGMRyWOGjh
         UNeh+lohUqwqKt99J5jkbkofaksjbmpMrloTACQLQe0qw372QmzdZobIUiLuUDiyf5L8
         1eyyJnVwxq4savaaIxoCbYEHKzkqApXgExF/Dfm6Ldt+I5dOvnJjYvqNcGIp0YPFlwE6
         BA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707390388; x=1707995188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zv2QzNoNrHR0W9Z/ijLeBt72BsIROQonHbxqN4l0J00=;
        b=Cwmb88rxLstp6vUs3CrbfKZWdfrTkqT5vjTibwxiYeO5etPz9t39GgPC8sYx45qXtc
         mAij06Svyxq1xK2Uer2UOpJXeueogHkguoLwksHLR2Mmg+b7Dpv7N9wQp5Bak/kZzgkg
         ib1vWpsqGkSiEqHBHkXPHkqx8xVQdGSZZiRYAzFRdNhkkAt373xLDBVdTUsiqYzj3Wc3
         /SrEHJyHYhclUCUERpQiwlrguK1JOWtIIVh0+BuphgVHUAIDe0odwPbxIu+g3rw6/4f3
         7hlXLBDrAg15s3g9TpwPsM6N+vERyu327y96HU6Z75ot58WiiLT11Cipy59Gi8joVKyJ
         6mWw==
X-Forwarded-Encrypted: i=1; AJvYcCW5zej5poP9Rj64WjvDApUK5hxVnu2Ve6JwPkZ321TH44iGsiKbFnu4YmK0hQDod9MAV+1P5ZtazfnezUz8pklAi7j7OkH/xJq9yidK
X-Gm-Message-State: AOJu0YyxJir4Lyw2bGw7b9NFmUxo9q4hkPZPQmZCoZ3Rx7YES5CeGbHa
	p+7aALUX1C34prWjaJgR90uZXku7ZpnFOvLo71NLDiFG+y/AeBwHPDh2m/xtfLKWNn7y9K7LBr6
	UA26EY+cDqCTOMVdC0v4zPekIKSBAAB/3KxVu+Q==
X-Google-Smtp-Source: AGHT+IHpsrmLs8p7zk/kqkNB77JilHmJAQmArskIr5lryhEV7krDIR9S8OA/Q8HDEtMaT6Hvsgwrjhorn6jBJPtU/cE=
X-Received: by 2002:a81:d202:0:b0:604:20ab:fc32 with SMTP id
 x2-20020a81d202000000b0060420abfc32mr8311495ywi.17.1707390388572; Thu, 08 Feb
 2024 03:06:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208105208.128706-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208105208.128706-1-krzysztof.kozlowski@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 8 Feb 2024 13:06:17 +0200
Message-ID: <CAA8EJppiNEJVUO-pTsCBXXjNHVrCqqV7J5wC+CihBtH0FdncsA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: minor whitespace cleanup
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 12:54, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The DTS code coding style expects exactly one space before '{' and
> around '=' characters.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm4450.dtsi   | 2 +-
>  arch/arm64/boot/dts/qcom/sm8650.dtsi   | 4 ++--
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

