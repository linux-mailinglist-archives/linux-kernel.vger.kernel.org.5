Return-Path: <linux-kernel+bounces-125919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C2F892E36
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0680B1F218C9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 01:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155F72572;
	Sun, 31 Mar 2024 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHKamGTk"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48DA10F2
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711849009; cv=none; b=NhggoXRqgNruwTPVdgyCwrWu9XinVOcun4PP20tNHAEVLugvL2OUILI8XG0ClpNLAzJXkXiPdHCMntCHKp2FPbo1ItUL/GrNGoj9TqbIs9QH+XekZaWf6moki928yzlqCJoafERHgXddOQ/6bPCbiPLAzrvB1O0MKMvgjAKoEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711849009; c=relaxed/simple;
	bh=EXKQs2yHznRuQNdL5NyjxdibUS87VDcxqibYqOefYFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfJw5ABMXjyuobhW3eONJ2ZaQmCqKFO3Bs4I2/MN9TcL0YBtpubcklt0O8JD7c5yES2s/PWJiA8pIDpCoWI3XhGp5G+/wF0ix3LkkUw9r8pEuAoYTzTj5zVr5umSr4XsP7x8FTgl8B3Dwqjx7yG7j3epBp7qWjG31zXo70PLqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pHKamGTk; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso2852085276.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 18:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711849007; x=1712453807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4dFkRVydPkaE015eU5BNJh990ZNi0Lf5ZRU1eS0SWY0=;
        b=pHKamGTkFPGBAu5+CBVZ49MUJGvVOC1bv2R5ubBXmmCwbuD1tgNUTmK2n9SOBlqpal
         VfhXGG7oe+k9+JqVQEm0/tP6gUhEy7r93dPH85ISkHeMBbx1+X2MOm7dxH1Te8YgCkdk
         ZaGrYgrBwuGVs0P9HVmIcULBk0K/iRL79VF8PxQadUI/QwwP0gNW8pn0zGjjx28Siw4J
         1t/CFaTxQl2gCqezj1HInIgu9EI1le86oyeSgPwYV7UdeuiYF+U/X9RSIF2DRi/26nOy
         iAYYbpZLqV1LcnZz0PD9SOzt0Xc22n99Fh+NePuOCpvr/Hftt7f5ibqhBmGXk3GYiAYn
         +qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711849007; x=1712453807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dFkRVydPkaE015eU5BNJh990ZNi0Lf5ZRU1eS0SWY0=;
        b=cMu0qH7JYajZaB1Dg8LedkUvl5gx/4099dAT14bCydnkwEnn/favPOLo//vDS01ooA
         VHcqemzsZt1hkHRQC/RLl78ffm+Jq/HakeG/QD3RNBPK66LwGEijPs/Q8PWeFfp3M/5+
         IdDOexrV83dDPqQyFPu+bncm6B/xmh15jFsDKdn/trRvjeNGQ0fw9t03TBSrcbMI9711
         ikBZJM+6pet4CsI2DPtUafHv7WlGpYcCUaIzEdEkQDemZPx8UODIksSKojTftpBJ01er
         j0Ge8Cvl5YVIJCIfzM8szVEk40/2nIkiY7EWrcQuvsp8WbnEqxpCrIedWADinK2RMQVg
         BLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe5KcJcBm0ygVcJwZEkAhk9ODTfzyHMdG9sOBnJICuKhJ9Tb2rsgnjUUDbrFrFJUgIb5C/Rc+u9ENDQWjW+aWslw2cdGBDwQ9xoWeo
X-Gm-Message-State: AOJu0YxPCL0j8L+X3lE5WOgRg+A2AkVSnuXzYpFUXp88sXaugbjs1yE3
	1I9F3L1b2wkOJpsGnazILTv7ej71QnS4BZOxV6JipNOnAUmOq+7cLzP1RDi0Jm3mQd7sEwWo2SV
	dXVuFPnkreqw7+hY8R4VXxOC9YgxeX9LJDzVhfg==
X-Google-Smtp-Source: AGHT+IHAjPkSd3yfAE7NxKWJXWx1xvCt643u6rPv6idQACrkemOcNCuSb2gCAYq8f+RLRMwcZpBCFbJctjz3VUfO1z0=
X-Received: by 2002:a5b:f82:0:b0:dc6:b617:a28c with SMTP id
 q2-20020a5b0f82000000b00dc6b617a28cmr5201001ybh.5.1711849006870; Sat, 30 Mar
 2024 18:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com> <20240330182817.3272224-6-quic_ajipan@quicinc.com>
In-Reply-To: <20240330182817.3272224-6-quic_ajipan@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 31 Mar 2024 04:36:35 +0300
Message-ID: <CAA8EJpo+RDowyrrAWMAzotdZFZwjZU77Rsb3tX__V0qLPU22Cw@mail.gmail.com>
Subject: Re: [PATCH 5/7] clk: qcom: Add CAMCC driver support for SM4450
To: Ajit Pandey <quic_ajipan@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Mar 2024 at 20:30, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>
> Add Camera Clock Controller (CAMCC) support for SM4450 platform.
>
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig        |    8 +
>  drivers/clk/qcom/Makefile       |    1 +
>  drivers/clk/qcom/camcc-sm4450.c | 1688 +++++++++++++++++++++++++++++++
>  3 files changed, 1697 insertions(+)
>  create mode 100644 drivers/clk/qcom/camcc-sm4450.c

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

