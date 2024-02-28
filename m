Return-Path: <linux-kernel+bounces-85055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D636186AFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919EA289596
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211014DFC4;
	Wed, 28 Feb 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybwxBiXI"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2351614AD2A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125444; cv=none; b=PcuQJqQjc3ykaHGY6dsrC2Yju8Ts6ayRqPiGYFMRk/gDqqUvBOrsrqNarFfpjJLfj+55LYuHkjlKSxQ/E9c9yxqNN2tY5E3zXp/g7oSYC0YPDbIGkxF8I+IGsBam915Um/5KmPo6IHv0bxTLn+SqmtSRfWHA+ialHAmGe47N46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125444; c=relaxed/simple;
	bh=vFTpKydtyiDddUobygfeyVWyr4s0AkGFJ6e0BY5C7PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLmbZ5bw5UwukYNhM8evIdw3AQnu6h4MZEnrC880MY0UIZk9HldFDOjyHZ8CBFw38iv6xnuBHQjH03DN1NL6GIIZ3IFbBI87sj+87zrMuMo1A1n7w5Rg6Nqu6j2YT6u1c+SNOwGU0Sa/nqN7a4h3yr0kpo5y4a+68uBm5YPo4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ybwxBiXI; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so5834468276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125441; x=1709730241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X4xrPKeqtgEGV9Q4IBEmk+WaDilZyeoAcRRC9Axa6hc=;
        b=ybwxBiXIRXB5RiLEhGRthnkei3MMShfAuSq4rpub29+ACNPlYcJNGepRlhAeOx+0x2
         9lXVSoj3DuPlJ/wvjH9Smzdi4YW/ILbbKmow/F+shWX7dOFkPfoau1kWYlRFnfC0CP3x
         dBJve3sRmnSw6tCnqp/iAJdzluc5hVAkGoLrgRLzUzKdOZ20Tg/u7mn8mjmhnTZsMZzH
         asC46cXmOjus/h2kwSiDjRZ2UowcBmAA/WEjH5Tn/+rx/g1PwiFr9R5nQbu+OjAfKDEH
         V9koODHEsb/JKOj6M5+7yLjtDStqR1TZIDPd2H3KFYV8Oxi9q76QhEDz0aJck9V0dsGk
         XRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125441; x=1709730241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4xrPKeqtgEGV9Q4IBEmk+WaDilZyeoAcRRC9Axa6hc=;
        b=SfI6MFvAkV5mj8Q4HQgqMujbrVd6vhoLp5Va5UAadK56F8+K+Kh3KkMh2gduhofKr4
         YJ/oSZOQa5Gz6Hfjv+X0QomH6pCdzTyE29q+oYYJQJjTHCSpoG+qvlA6qUgadj1CfTV8
         xa/u4DWPfdLIGGJe3XJXyOF1QoVICMVIVX2fajLYr6T5YW5AvTgp+snQoHbE6G0ZNsIf
         DNBOQapUsrF9to8jnEKt9hqYJzf6/HD3fAJZBJfihIWaALZOAcp3C3VCOq4sEcnIfiyd
         ShHhAOKDnl8JGTDNeCl7g9E2dyhoFnPtoriLhxOOC3P127P0AgjqrfAIeOlhLTD+4pbk
         QboQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhF65GmJjivdYSks01JwmTkPDkLCca9b0CNxKDZrsHGZwiu9MGmCHzijFgruAstK7YaToqrQkFLneaH9PZWOJkh4z5JgDSmUJNHw/o
X-Gm-Message-State: AOJu0YwvRpHs47qmPzetB0ZBW3cLbWoYn6cD3PPEljRnQzcydBmVCHdW
	x0G4ZOfaVNhYXTueyXrXohz41RJrOols2yrwBfAAyF39XTOSBMwzPQey3bj9PpLmsBWLCb3rWPQ
	ZADBw3el16J1UHdLg4rDELIwcjv9uLQjiSbzufg==
X-Google-Smtp-Source: AGHT+IGfbfWQ26vfcOGPm96x3PWRIKRsRzOqFj+BnyrgrRljfJCRT/1aUOwJAvx2MvOjZjDrvH/UChy9Nm4zE+AZOHU=
X-Received: by 2002:a25:9c02:0:b0:dcc:2f94:591a with SMTP id
 c2-20020a259c02000000b00dcc2f94591amr1934963ybo.12.1709125441193; Wed, 28 Feb
 2024 05:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217144202.3808-1-jszhang@kernel.org>
In-Reply-To: <20240217144202.3808-1-jszhang@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 14:03:25 +0100
Message-ID: <CAPDyKFptc2K3PfrzQxzWctnCNbqRZVOmDDLDe9uWLUPp1Q7_Vw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: sdhci-of-dwcmshc: support Sophgo CV1800B and SG2002
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 15:55, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Add support for the mmc controller in the Sophgo CV1800B and SG2002
> with corresponding new compatible strings. Implement custom sdhci_ops.
> Currently, only sd card and no-1-8-v is implemented and tested, I will
> try to find a board with emmc and sd/sdio sdr104 support.
>
>
> Jisheng Zhang (2):
>   dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo CV1800B and SG2002
>     support
>   mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002
>
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  2 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 66 +++++++++++++++++++
>  2 files changed, 68 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe

