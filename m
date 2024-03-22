Return-Path: <linux-kernel+bounces-111315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768B886A94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D000C283E67
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273AD3B798;
	Fri, 22 Mar 2024 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+YL2wp5"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CB3B2A4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104116; cv=none; b=cUViV0wzVt5fSF6IgRfNps7JrllrKvdW6iE3spThLxqc2Dv11c2Myk+PmtTIxogfFVe0uuQIxSSIklMGUs9TMII3INxNQLQpBrSKri44b+SYMPOOCZn0s8GwiesO0rKp67nXJxwL6rR9gzJJRdj2iX+5NDXbKQmzh+zqcRTbf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104116; c=relaxed/simple;
	bh=XgOxXIIS8s1afwdjn0g6jOtbTTYtoWP3qkygqGIn09c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBhOfrAzBXEcHNorbBrVq6EVy+/bSv52qogeXsF4uLP4HizllVAbKIGZVoQAvGcKjY9NM4mupbETAJq5kA7mRvRwLuXuxFi83G+RMl6fYz34iIUDm22RHacqYHvLu4pUEw/RjFy6y2JwWLd3cOzb9LkU34uu+iT/QkfoS+8PJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+YL2wp5; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso1947205276.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711104114; x=1711708914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ1G2x/oaXXsE8SC8MGGRjcMdOfVG6tRQLbgz1tdtwI=;
        b=D+YL2wp5o60PTdT3GxATJnMcNpa5PGJUE8+YO8wXIv9yZVB0IF1bT7GYcPCQowvawX
         CYNOohq4R24rBTligYNCBxqGQDX4d2kHL0OiZYw62YbRXgvqALGYpszO4Q4owYIZCK/a
         mtnbOMarWZ7I87fTEEIj4e0B6PRlJHnbuyM6eRpHkWzyUwF0+d7u+puTjDq2xbqYMMM4
         /wSIwNqZcUWZAYQync7rOvFQ/nJQCLBjQ31IOCoGdueCm1fUrWv8N/uphKFru88NBVlo
         3RXrE/uri8Sa93ZLlQWifL00R6c6fop2YG6fx8W96LQIEC5m6Q9jMUTA4pioDcq5iage
         /xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711104114; x=1711708914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJ1G2x/oaXXsE8SC8MGGRjcMdOfVG6tRQLbgz1tdtwI=;
        b=YZ/4S3gCVpKsXz3rNrR+QKzjF9bQViLaAXeOCRX/pK2QxlnBpVQcNoUEJHXjKruFcR
         8Bv1/KZYInm69Nzb1NEml1Fi5RdGoD7BNKcGSGkN2HngQ/XX9os4oGvESOXt96/YejOc
         vZV0qL4xx8Wtk8Hr93wbEWu9ztKe6tK/8rcRnfJxiQI2Ys8BVJ+K4t1QNPQvzaeqRUeM
         tGVPRbBVJr+K9A6ViB/Rfy0nKTpumsZ3BqatR4KcaY33Vl7h8oNRaSii92R0rVC1hrrg
         +Xhw0/EcSKS7oQWuWQISIUbKOvwcEP45BP1mEsdKzTWo2uuu7LU+b9ig7LdQtN6RRCtT
         dtig==
X-Forwarded-Encrypted: i=1; AJvYcCXs1j286EMTUwzoOOPLB5euMRG9OWjc/1ZwC0iojjgQJQHGQg6Tf9hYuPjRyMXCmURC8jeyYZqRJy0zOpL3TYevXzIhUEjFq8r5Ivv4
X-Gm-Message-State: AOJu0YyPiwS8+laSTbKC8zH5UGzA5xsbpZfvi1cAdz2XdZrZN0QjjEgt
	SUsPATP/O4vH/i3+BW565JtU7KallDHoQzKzEfPYSGJ+LCAG5Orq/CpBCpb8/HeZqNDi5RcKFhc
	PT6rupJXQ19wXA8CMg2las18LXzhmRw9u54SLkQ==
X-Google-Smtp-Source: AGHT+IF+DVq3nhDm54jpxuWlZ1AandcnO6fyhOF34a+zdn1HBb50LNm0GahsR5m0NoIZpPjbkOLpfMdQkKElsW4T2Ns=
X-Received: by 2002:a25:b118:0:b0:dc6:d22e:ef4c with SMTP id
 g24-20020a25b118000000b00dc6d22eef4cmr1726459ybj.17.1711104114082; Fri, 22
 Mar 2024 03:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
 <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-4-3ec0a966d52f@linaro.org>
In-Reply-To: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-4-3ec0a966d52f@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Mar 2024 12:41:42 +0200
Message-ID: <CAA8EJpoY6V=g2TpP0goj_96Yhg3Hdo+T3iDL-fK2WZCuZW62aA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] phy: qcom: qmp-pcie: register PHY AUX clock for
 SM8[456]50 4x2 PCIe PHY
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 11:42, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock,
> enable this second clock by setting the proper 20MHz hardware rate in
> the Gen4x2 SM8[456]50 aux_clock_rate config fields.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

