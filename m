Return-Path: <linux-kernel+bounces-109894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AED885775
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E821F1C2129D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F93D56448;
	Thu, 21 Mar 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEU9gnbf"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACBB56754
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016945; cv=none; b=VCy6aeqT5WCPzRzOCiNnyv6YVGc0ZswFa39a+EnFl6oWk1NgXrDd8owPcduakv1231IFTsYfUFZNfgekslePOUWcPGMlGk5sA3eXPJb1fA7SPpX1fYx7PraCYnH03xpdxjFJxoKGDBANKIMf0BaUaBbd7E2iJ8TffVCHl8YnSUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016945; c=relaxed/simple;
	bh=P9oLwk7VJIg3OdusQw6OhW8NcToKDBX6FFXyfjBmguI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyCKy6D42Z7pGOrjuZN+0pQzlwIN6lEyQ0EgJD7IsINXRwqX6FBCl3HDiRx4erQg0DzewCJasSeCGcFFAYfxQB+oBz0sOUA09PlFzQH4bZFqccWsjKG1NiDj06vUB2I8VKLNq1p1lF2hmqyb0rccBpafqF5tZ8ir3mkFDBZJMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HEU9gnbf; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so792480276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711016942; x=1711621742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+uLfK8GwjqCfs3VrBCTLKTjymM9xM7mMzCdCq1/Z8B4=;
        b=HEU9gnbfJxiR4PtnaS3yck/by5EvQHOr0SZfCa/B/BsSXfvASxwZaAnGoid2udQZ9/
         TFSX5j7Xc5LzebvSOq74zHyndQ6AQRKhssEK5Va8jUHA18ar9FaUhNQyU5VF7CLFciMb
         tB3/2Qppldc7FCenKG6WwNp3HuJeD9E+fdw4Hnu7bpDA/tZk/43pz3fKzwJOr0y4TsKC
         lCmJHZrJCOccpiPaD9HreHUcX3gftkCx2GuWNJ6BmC3wuCxcnHjSxRKwj/ltGBFjCI5U
         bcs0uu6PGP6bTccYQHs9Zkz7inbRcUENBLekyyHbBsvhy7m9RFaLgL9km/kWSRYMiEFt
         XQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711016942; x=1711621742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uLfK8GwjqCfs3VrBCTLKTjymM9xM7mMzCdCq1/Z8B4=;
        b=IYnxA6RbkswUV1U6rsiQS1OlWEpFrCxE7RUvE2L6ULeXmkGyDtlnKaz5fcYRfXHsG2
         hc9iUGySaWho+15x6peTI4RX0/0BYAyFeA4VFIZV41XvIdGkzJviCCrL8O7Ybk436yNp
         hXa/zz78gCjCGE35x912wa+EgVXAH8FVqfWKub+KAb1pCFG9TclRVNlGf8TNCN1Z8m6g
         ubH6OYSXY6lNkGHF28GoCi9dJYUyOhESyDMyV2mbFaz6T86ViPF+2vmGWsBjaMgsjQ/Q
         m/2Z5wUwC1lEwYYmFvtvQgEe7qXhHn76t+9vmUi5/xPTRRzJDGn4MwLrGbPA8+PshwUx
         U/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5zNcMI24xM25yGkPH8XcNksWDkoN6rCDVNABNMbwEapaUN+tkA6SPl+zbtr8I7+N1hxCuy9OrM5bFcLJRYA2/c8Q1SLPsBwUZXswa
X-Gm-Message-State: AOJu0YxOZm/cfNARDWpQ1xD/rM06Z2BvckoOFGG6imGpcTo+gAyIhBAD
	FDbgFgXOs9h8cw9L9dUSULHa9Pf93rpMUnSG4IzDKTxUE/SnwWzZm4cAuZgDfveahyZrPTDURQJ
	6VWfBoA+LD6mJ0Qpy2s47a5ggkhhb4HM2tmKuKQ==
X-Google-Smtp-Source: AGHT+IGTcMuTl2BR8QgKlXuZ62FCg9xZRjlzbWgj/MWKvepEwUPTunC3DUu1ys33B8adCr0Kx8RWRCBXkvGDVJ+BSaM=
X-Received: by 2002:a05:6902:2408:b0:dd1:4908:7a91 with SMTP id
 dr8-20020a056902240800b00dd149087a91mr1515831ybb.49.1711016942104; Thu, 21
 Mar 2024 03:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com> <20240321-apss-ipq-pll-cleanup-v2-6-201f3cf79fd4@gmail.com>
In-Reply-To: <20240321-apss-ipq-pll-cleanup-v2-6-201f3cf79fd4@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Mar 2024 12:28:51 +0200
Message-ID: <CAA8EJppOmPJ+mNEfsS7kJYR5ASpa8__a9002KpPjaAwkwTcdMA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] clk: qcom: clk-cbf-8996: use HUAYRA_APPS register
 map for cbf_pll
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 09:50, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> The register map used for 'cbf_pll' is the same as the one defined for
> the CLK_ALPHA_PLL_TYPE_HUAYRA_APSS indice in the 'clk_alpha_pll_regs'
> array.
>
> Drop the local register map and use the global one instead to reduce
> code duplication.
>
> No functional changes intended. Compile tested only.
>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Changes since v1:
>   - new patch
>
> Note: Although this patch is not strictly related to the subject of the
> series but as the change has been suggested by Dmitry during the review
> process it has been added here for completeness.
> ---
>  drivers/clk/qcom/clk-cbf-8996.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

