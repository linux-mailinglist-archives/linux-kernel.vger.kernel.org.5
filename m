Return-Path: <linux-kernel+bounces-94484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89215874074
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9E21F24B3E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA414036F;
	Wed,  6 Mar 2024 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hP/X1F1E"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006DD13BAE3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753678; cv=none; b=fa1lht4j1g1OuYtG1R4Nh0MSRSqK6v+ZYko/kN96GCiPlhM+5qsawkBGsg2d88Sd6C9V5fWwd69tQSeKvRDxmaFeAlxdvFQZrXZhlDwxJxaSxTVArpp4Os9gxJfrmFdRhs87WZ4DSW8feQV/VL4rAf+iqAgZyM8ZCaim0J2LPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753678; c=relaxed/simple;
	bh=GPl4f9lkb9zfcnX1eSvWK+7OEpHSENA0ItGNLyBGujs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edH+jtS7v1iQPzmefz/5+YDSCnkdqTAFsINEZh9sOqO7i8LS8TdTpB8xji07icUQ3ScXf5XWpwzTgx347+gwJ70YjofqnKyPvdey6jyz5NqSLOv0tGDdd9GUj1mofK/maAwt7uDz9ZV9tsBeBuPIwrF1XrEcsj/KLGIPqhR5q5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hP/X1F1E; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-609d3cca399so953837b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709753675; x=1710358475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=691+S3DdWk+L0K/JU/znAwv1QVBesVwE/4bn6nlDzxc=;
        b=hP/X1F1Ex/22E2USdubYniRf8BuMzaCcBZAP97njsPWN6akgZ4s0kO2oB76IfGfxxW
         mfLMJA0FVtrmhlgL44EjIl8WjMsaTB6sdPFPX0Mx4QCtx1pRnPNj3JicYiQBs1OPA0Nm
         iWtaiJC7+fHYVfSIvwdKLaWJ61wmM3RvQ0MUn5+fha0SsaIzHhulcjs0B47wyaSS98za
         eEsRNxfHaG4Ahu9AZ0aIAeYc94W1WclfgzmNxDHOLqxLeTP9IDf57Y/WNt+mf4V4nRo/
         BdWHyVk+j1G6w0Tbwpi9/k/s3yMZosK7wFClEytI5/TYT8R1OQikr94eR7cuyEXk9Mkr
         jyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709753675; x=1710358475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=691+S3DdWk+L0K/JU/znAwv1QVBesVwE/4bn6nlDzxc=;
        b=EUSMxdqvok77rr+a7cg/lpnAAnhwghlIGd03BD/5ZRK6j5AlgfQdTK8yQCp9xpb7o0
         D8ZSROKb4GG8BCjrXL4lcVpVDo3WNUT85n9roQ50E2pTew/LmZFlaVTjYyrqGwbP3cmS
         Y0HGKN9mGe9yahaNyGYzLIEmJUYx54kztP7688MlJcDVhZUZB3mmIDSItwM3qWrSj0Yx
         q8CYS9bc4rlYySAbtMsJC9RBgUDJS2qoQUgF+vGrmRLxcb0/dgzwe+UUDOalIc17Ow7R
         bseGSWDZ9nblaTrx0Gq2VG9LDFTMJdAMYYkIgsQdVzO1qLCyNhujy/AzK2j0fqFcB1Mv
         7FQA==
X-Forwarded-Encrypted: i=1; AJvYcCXwPsM2mHTBYFwWjT7dRKDVDy1V+WfKYW38wgmIBjUW0ZcsnYiB2U6guV3iJXkLB2x5qECD4DklkN/hemeS0ZQWQkoUkzytIaLlA1HD
X-Gm-Message-State: AOJu0YyySPfWv+vS/c7QRVZC6ccS0ESF0Y5353EG8xfrjwioWirCUbXW
	5MbDTfUr+kPwkB+c67WE+IZjiY5WMkAx/y4BWl0vkP7Rmq2g+Ih16cAzUE93wktxObme0MoPki/
	u8kQLGghYqEkMq8o+I5UWGCF+3Q5fVd80pLjzqw==
X-Google-Smtp-Source: AGHT+IGfu6v6iBASHmlnOcH0IML4GeYFVxrMhaEGg0cT57WTqCMrmKobsugqpKnztn7XphhO9id/EyH2W0TGTFiCjtU=
X-Received: by 2002:a25:ce8c:0:b0:dcf:fecd:7d3c with SMTP id
 x134-20020a25ce8c000000b00dcffecd7d3cmr13047837ybe.46.1709753674996; Wed, 06
 Mar 2024 11:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA8EJpreeGWfstEKEFiHM_RJCZbYYdo0H=fY0GqPPtZM-7ZUhA@mail.gmail.com>
 <20240306153610.1289999-1-amadeus@jmu.edu.cn>
In-Reply-To: <20240306153610.1289999-1-amadeus@jmu.edu.cn>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 21:34:23 +0200
Message-ID: <CAA8EJpoghqa5r2vc5XXdfVJy1WDBysXs4LdMybgdgqMTcEPDfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU Frequency
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 17:36, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Hi, Dmitry
> > How is it "some"? You are enabling this opp for all IPQ6000 SoC instances.
>
> This is not the case, please see `opp-supported-hw = <0x4>;`.
> Also: https://github.com/torvalds/linux/blob/master/drivers/cpufreq/qcom-cpufreq-nvmem.c#L345
> This 1.2GHz Frequency only takes effect when BIT(2) exists.
> For fused 1.5GHz devices, the 1.2GHz frequency will not appear.
> I have tested this patch on both fused 1.2GHz and 1.5GHz devices.

I did before writing the comment. You have the only IPQ6000 case, it
sets  drv->versions = IPQ6000_VERSION = BIT(2) = 0x4. So, as I said,
you are enabling this for all IPQ6000 SoC versions, unless I miss
something.

-- 
With best wishes
Dmitry

