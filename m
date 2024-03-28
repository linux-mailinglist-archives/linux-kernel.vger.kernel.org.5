Return-Path: <linux-kernel+bounces-122623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6CE88FA82
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9C52A702E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4A5381BD;
	Thu, 28 Mar 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8meCpGh"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAED28DD2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616243; cv=none; b=kHeOAVPfup5m21PWi9KMQaBic6w/MX4XaMNpWiUKf7F43mwXAnrrGTC5tGkx+uILuvcUsorRa6gCxvv4usF5qUjyCY5FjyNV7BZRDUQZXJqLDGh9Scc1y1BS5HR+nHYbPH1KsaH9cbMmAKR5tmLT1qmabb0s0cLZKx+DxwVQp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616243; c=relaxed/simple;
	bh=4F3JozY+G9dFPmMVqsIC2mv1plVDgN7zok2F2MfKt6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GycbSUO0/+ECKWJB/VhT95k0m47wo1E5Yv0cj1VjZR35ODz6EMKH8G1dtum5r0ePSGs6GZ30XkU9PIgFpA2Pcudjsg/VCPdEphj22bnhdqkRvVKH3EqRaZLIOiD0RfpQrzmZrIeB2Qx2MY6W9W31zMcg0eJeB+gSeHZEa5KMsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i8meCpGh; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so692461276.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711616241; x=1712221041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F3JozY+G9dFPmMVqsIC2mv1plVDgN7zok2F2MfKt6E=;
        b=i8meCpGhFn5xCiIILqhnwryOHOOlJrjwaZMRsfKs+/hdnNDugS+2YP4UTDf/j+wQMj
         Bmpg3nV/aBY1ohvz1siMXvgdHv1c7mdN6N+2HOYAVB0KY3hPvyJF38+Q7uGb/nxSguZC
         wAm+TZ4ohQzp9YtvGvygHsKCPov3V2mnGzCr7Wct/LVZm8ddgxmDR1nBUdoTHcKK1/Vo
         oFApd8SgEnfvUga42RmRRMYjj3pgXMjuzkZ/8QSYK4mXoMbfI8nzwlH2B5gf4ryZ2/Hb
         wca1vJCY67aMg+BEROiKoWMzcBexwB5J7AKoAY6hrTa8Xl4bYAWX6Yu5oQatvu81Q0Q9
         lfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711616241; x=1712221041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F3JozY+G9dFPmMVqsIC2mv1plVDgN7zok2F2MfKt6E=;
        b=Wo9BJTtSzs01NMv7a+LewFJLEGYkct88PyHMujSVhWgOuo3V4FgRJhcI6vhjmjiwlz
         sOIHe7SxZrVDU8DWkBuW7TvwdLcjpZvqqktWYz8bUUjcHEcGpTtQnifBo8M0tcG59BnJ
         wbFpU1Fk0sRaRyauPffGXMQu45qedGS7LXYGl+2yaQEeDS8rJI+ee5oFxED6XeA9NbdL
         8kuH5kOlJItRz8ld59Ufe+5DM0iUZR8yX13k4AZxjUjx0SSOhdMCt37qMeV9nOhcS0fA
         Yj8obB0sb19fO4h321we8hFopESo/vL2GnjgZHN5vHQ5rT0KkkI9eNI7EEHfqnlJssCu
         RTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPO3ioUc/OTqvNBj7hO9zNoQgBG41+1HnS+B1GWv2TrwNRUcyyXeHN2ZqGndcC63lJiDNU0KIuGFLn8VE2etfWKGLFP+Odlht4cCBj
X-Gm-Message-State: AOJu0YwAvzgDtKHbL7a3x+9tcbSslLpMfiKxudq6pSpyHEhq0toj1IqS
	IGqp3H7puMrJ2P1MtDlkAIpvlpTLJwWu1CQJjDTCjaGQI+8EVgaPhkY/aCGnkl6z+/iVjl3VTUm
	g/f+jZOyc+piGKTiBHJwts2wlMRqNbOcT+O/3GA==
X-Google-Smtp-Source: AGHT+IGKapoSLxpG9GrnNkjIeTSAnIkOLQk1JL/u0vi14kt6WJXVX3bRQ84jY5/TNx6lXuPoBgs2NzIE5E+MDpY0epU=
X-Received: by 2002:a25:1606:0:b0:dc7:4725:56df with SMTP id
 6-20020a251606000000b00dc7472556dfmr1939509ybw.23.1711616241053; Thu, 28 Mar
 2024 01:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312025807.26075-1-quic_tengfan@quicinc.com> <20240312025807.26075-3-quic_tengfan@quicinc.com>
In-Reply-To: <20240312025807.26075-3-quic_tengfan@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 09:57:10 +0100
Message-ID: <CACRpkdb6LbBkt7aSr_B9=xSpJrjaHhR_MNz9g+LYJwhxdUqDWA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: pinctrl: qcom: update functions to
 match with driver
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 3:59=E2=80=AFAM Tengfei Fan <quic_tengfan@quicinc.c=
om> wrote:

> Some functions were consolidated in the SM4450 pinctrl driver, but they
> had not been updated in the binding file before the previous SM4450
> pinctrl patch series was merged.
(...)
> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>

Patch applied.

Yours,
Linus Walleij

