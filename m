Return-Path: <linux-kernel+bounces-72985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3332085BB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54EB282E33
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E8D67C72;
	Tue, 20 Feb 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFrD+wMj"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12F67C71
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431073; cv=none; b=Pm4u4gHyXB/S+hIqddHa0W3x/kWmdRRIn4q1C4rc5UhynAm6OU/fYn7WCK5iL4qihGqfZmeMoHdNIRlBR0ivm+XHeTSykdtGSJclL0kcpdOa7cciu9LL+GPHZJY5Gn34kdEyY4IbwNHmKiAbbPdvxvbRl4ZlxNY9HcDFwgHDH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431073; c=relaxed/simple;
	bh=BqaQAXupnrIUquuSop0hnKVxmWNQgaRJfNNMkdEr9pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOxsopgCLeXm9TiJkB60aGuyATf8VNw8DfJLdh1RIgq4TCrfiwrIbqTMultQvsHm/56oDhW8hfBXFT1n1maaMOMjfFeph48sR3qSOY0cBhsMWVx25MdG5L8GGw1gsm2HQ8wOADDBXR9L9m41iu273z0iIAQCQ1TcAb7qzuVk/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gFrD+wMj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60837b7a8ddso21146437b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708431071; x=1709035871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dy/caDfZjOGZ/ICXi5t2Xv/6rJdHheSidVH0lV0pHS0=;
        b=gFrD+wMjVKIF/fXKHYVJcJVWuNLohOYEJHkqwV8/0gqu+7KWfnUaLG7Gga/l5+VbsJ
         4y+DBviY79C1KePTwfaSQCw+2Jv5SZBVVek5BhMCIVOa2cYihFXZq/gxq5kgA+Wdr+18
         5iWndKfwbm8bLtY5Yb4+hY+E82DcQs3cS1Ws5x6HSCQBatua4EtB4cotI2lbt9Mv6jdH
         B7MjCW++8xQbU0EtIdPnIBd/GCu9Nj1/Xr2u1Og0zWWdkvb5JV6zzUhwbUwNICOOzkoi
         VXevboR0CiZOoEBpDWaTfuKmdgutYn882fe4sArz2NeH9rVyCnuMxdsg+VFIZPUrlJD7
         F6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431071; x=1709035871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dy/caDfZjOGZ/ICXi5t2Xv/6rJdHheSidVH0lV0pHS0=;
        b=fyMAO8SUaLs6XWEWWEySPsYWnnfeK96MJjREWJnf11BirV5+F4L2aWJCHGvZFvzV3g
         ogqOJ/PbHnV95h7PfmRRjApuoyo0Vc27XOnujDrzzdw1yp8EBJFJuyANQKIsJaWYkZ3B
         J902/GobUXL5G7L8tF4XYLn8ys5LQx1Xo5JiY1PInmS5Cf/5vC/y6OC8KtcgAr3oH7EO
         NV2b5LnOqp2rg4zAeMIj7G6krNTMO4GVFZOOExbbaPYD4jKSEq3GuygaRLClpoEE74OB
         YXih/6y9lMcAljNAScCqN0RJRXTaCkh4Ky7TlmhFaajJtam+DDmCy0nxNRG49yP/N/TQ
         BK3A==
X-Forwarded-Encrypted: i=1; AJvYcCWvD362OmPVXJYGS4LtPEbnOtOj02D6sPsCG11cQTTe0gxuxHrBgCR/XyTRfXSDZV2zZzehCl7yctP0RSxubrr7iw0tOA0y5emOX/Y2
X-Gm-Message-State: AOJu0YxW+rt9Q2YEDD35l1bHSbJwn27rcQhmatDczOE7DvtOgcsLW/DR
	85o6RQaO70IkZx0hEBJIsdr0mCiLG2Tb9Rcxjc/vjhlgYQmx0w7g9VeJ43aK9G/AVRSIiPl35av
	5mzxTefj2LqrFhoUUQj7CI1Pb5gy6jk8586XqUQ==
X-Google-Smtp-Source: AGHT+IF2zDf3XgcK9QP2IYaoigNbZzdQSINGOcFBC2jSQR7qeBk1CasXZT2gneoj3MATMAClXBgLcHMA0tFxwFBaxmU=
X-Received: by 2002:a05:6902:2709:b0:dcc:f8e5:c8c8 with SMTP id
 dz9-20020a056902270900b00dccf8e5c8c8mr16849736ybb.45.1708431071014; Tue, 20
 Feb 2024 04:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220-x1e80100-phy-edp-compatible-refactor-v5-0-e8658adf5461@linaro.org>
 <20240220-x1e80100-phy-edp-compatible-refactor-v5-1-e8658adf5461@linaro.org>
In-Reply-To: <20240220-x1e80100-phy-edp-compatible-refactor-v5-1-e8658adf5461@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 14:11:00 +0200
Message-ID: <CAA8EJpp20nq4X_n0Bp1ZmZ7yffWm1zYpH12QL-Gj_nP7wuq1Hg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] phy: Add Embedded DisplayPort and DisplayPort submodes
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan@kernel.org>, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 13:58, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> In some cases, a DP PHY needs to be configured to work in eDP mode.
> So add submodes for both DP and eDP so they can be used by the
> controllers for specifying the mode the PHY should be configured in.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

