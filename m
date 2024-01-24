Return-Path: <linux-kernel+bounces-36609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40A983A3BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5479BB28B41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDAA171D2;
	Wed, 24 Jan 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVK5oPfz"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726E171DC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083689; cv=none; b=OX8RU/uErI0BfqJPd1c66b5WQsrSalobHs42PiwRQRZPDMC71nN7T/0icrfe6oew5VbnUQFPlmil/Q0DmBgQ8NK+9UNzKcCgFzf9eusanmlQhk8DsFqeiV+MK4s5zt1KpSgGmiNTCCmkMI4GgbSOZfTG89One7asIYxP9T/oK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083689; c=relaxed/simple;
	bh=91SKWZKxZZJ9JjqBsEeN2LxEmIvX4sQqPRYAQaqFWFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED2A7ym/jVzo7MdIQBprf+eyoqXfAocVm1gHIB1orPSqxtG4RrDssXPPrVIZQEy7JvdPSrTydknqqMrVb1aVK4UUWQwQFoUEN+Le27MD3sD8JcNvgTJA5tKr1cHQlsC603HIPU20AxzZfpjw273+ca5OJKVL3yO5XAQ6MNwhsuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nVK5oPfz; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc223463ee4so4585244276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706083686; x=1706688486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2oicDxJ90c/wDJuJ0lxNnczG+6khLtrNzAW2IGNICIQ=;
        b=nVK5oPfzig3WsPDO+hAml4Kdf/SzPC0EMKjA6TIbVgAjx+vUbtCV54PVybfwapXHvD
         cGsT39mZjYQ4MV8gPM9TTVBu8QBZhs9jVJvVYGHWtF0T+hN8IxuXSb7Rvw9htO9fTvbc
         wuoK5cBMk9+64KENbLpLLI83JQK7eFbnIzG8wcDeVUFHVl8y+SwVh8AbL9WdKleB8hD1
         QWqaluE1OT2ejxcRHJNvrjgIsV4OokG6RMMlXGxCJvyG9/GOBaITIJ2iS32j9s6Pyy8w
         A0IH9gTyB6yj0uEdHGkcoXYaz1e3S5grxwNzBFoeAtx8ZOanPuxcm6d1tXifljtXDgJh
         qTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706083686; x=1706688486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oicDxJ90c/wDJuJ0lxNnczG+6khLtrNzAW2IGNICIQ=;
        b=JOXIGecqEIRB3tKwqB3aE6jpUZjLB6c4D5GsrqjqF6Yg0GUXv6fA9yrhfrKxLvy/wy
         9pJKWRJ2x+DZPg3x/6RQxwawO/1pRTqTVotBwWP72nOIVCYOMmw73/WO/0bgAJGI/Odh
         jEfU8/jFirnBkxmjLHFSY44hgAHp64y74yO0ppm0tYHYz9l6yIFb1soptwM0WI6YAzEq
         7l4HiOtumtywBu3u/7fgIbylH9Digou/eI1fRi/DpPnI6mVtAmY9qbtZeqAsVXifSC33
         ALV58vYrQgh4ZjcL89Wq57Q2v+YkdnNqV9ws2YTGkugLjuHVo3YVLUlB/Cx6fmSoGcSG
         F7EQ==
X-Gm-Message-State: AOJu0YyE5aNNcefeSNi/CLsubmRqr17NLKNJBmNeqe1sDXt1u6QwNA01
	y4s/uW3NudYg1uv2lr/BGSvOKYfo8MTEOAssV19xv3ZW2ikyEAsvYQ2N5oi1RbM8CdaKb7F7oX9
	YyGCbY135PQKiCqOce/pAR9rl3kamQhcOjmM1mQ==
X-Google-Smtp-Source: AGHT+IEBx+hbv8cP9QQzl1nlNfUSW8zsGd6/0L2c4D7VdKAIm+FH6gkg6c1ug2KhF8rkgn0s4KWP1B+MHSfUQwurYAE=
X-Received: by 2002:a25:bfcb:0:b0:dc2:303b:db2f with SMTP id
 q11-20020a25bfcb000000b00dc2303bdb2fmr308783ybm.101.1706083686675; Wed, 24
 Jan 2024 00:08:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124023305.15755-1-quic_tengfan@quicinc.com>
 <20240124023305.15755-2-quic_tengfan@quicinc.com> <88e8cffb-024d-4f4d-ba1f-e0be9ee85e31@linaro.org>
In-Reply-To: <88e8cffb-024d-4f4d-ba1f-e0be9ee85e31@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Jan 2024 10:07:55 +0200
Message-ID: <CAA8EJpqXS97FXoTwiLaSeHHEDOeBFRPRbCNR6WF-ArDm22tu-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: modify the wrong
 compatible name
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org, 
	konrad.dybcio@linaro.org, linus.walleij@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 08:38, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/01/2024 03:33, Tengfei Fan wrote:
> > Use right compatible name "qcom,sm4450-tlmm" instead of
> > "qcom,sm4450-pinctrl".
>
> Why do you claim this one is right and other is wrong? Provide
> arguments. To me the compatible looks correct.

Yeah, but the driver (and the dtsi) use -tlmm


-- 
With best wishes
Dmitry

