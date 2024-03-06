Return-Path: <linux-kernel+bounces-93489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0603D87308D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3501280C37
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207295D478;
	Wed,  6 Mar 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tde68+9o"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC185CDE8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713224; cv=none; b=ItA/54sMdheWPLxGPu7/7yO9pqm0YyGhRJH1zqWDzK8YPe2WX49tqjFExGFu4anlYkwBuxQFyI08BexnxaaGAHQocqBvvHj3tlJZIcYUYujMkWvuWkbWmaQACAogs1YnLaWpinuKTB38akYFzQHzK59Y5c/X05yeTIqHMr66R0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713224; c=relaxed/simple;
	bh=KTDdaS8pSZ7S0Ht19FItkyULUTjJ5smibVaca3J25K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJt62sX80QZq31EX+Tquj7BDJGzpasytRYGjGZteeUmvBRGhF00A5e51QgeRq7xWp0+c0rU7sqja9uvrqS5C+im90V8ASIfKlEDHIFrua4WvVCN7nLlEXSD469Ca7v9ZSscnBQiOhITsmEUdklR9Yhl9Mx34vNEe8WIxBWIXIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tde68+9o; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so6975942276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709713222; x=1710318022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yEWYz4fTnrwGdwxrJSxUI6WQLItdsaHDpjBckmCjGBo=;
        b=tde68+9opuhIpNESgV9JR6CIHmR9Q5DxzeGIr3OLv70vUifj60N03baL6rd5Gy/dI1
         G2Gci1+52t4ASyDJVTGbaBnWe8Db936k9cZBRQUDyHEuA+PTmywNeellsWp9ORYW0v9H
         zd1YDmis8FeR5bFtkxb4SBHWZSLLzjuyhVN62ypqLzL3u4A9W/VngXa8w52LD4ICLgO/
         /8yWrDZC/Ma1wGeiwJofnetjwAP8/CgIF3riltJ4TIb0KWRA6Ufrc42X4/MZoGVOA3w2
         6z3O5Hnpx5ciPxJBmyNHwnQ3OSBpNTVs4EP50lSSP8PGANuD1t0dU94hpKppSR0VVbZE
         NEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713222; x=1710318022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEWYz4fTnrwGdwxrJSxUI6WQLItdsaHDpjBckmCjGBo=;
        b=xUZXkSyOw4MJZni49/xhpZkSHw4XBywufMvGZ44EJh5SxxKSC+NzmcvDlD/hdhoiUw
         lat1x6OLzgMH24PWDtxZs3hAE6z9nfr3FfyoJpkkrr4bf8UHKqwv5wdEM10iB4Vpgyfy
         j8NTtzYQ6TEjf7WKNp8DLZlvcZIOvWeeGOT+CdN+gJbt+4hVtwpd99VRXcvEEdqCHnFL
         QguZMyWTf3Caauo8YMLw4fNev1Uy48jWu1G7/HQ2vQRNysrORvVJisPkjBfBG1NuETUf
         2XYEUTUaDNkw5Ch+Xxv/dbZs55RNiEkH7PsDmjDmY5z0o4mAHCGRjw2B8ZBE77LezENs
         xYgg==
X-Forwarded-Encrypted: i=1; AJvYcCWM54sOEwCrsQej14STBl8yRTSUtaXbsmM1IZpny3BeX2mYpuCnfxO1ou7oRRN634hYmmtL3WeqS6B2BkL/PuqsuWpsxapa8OVY8R+7
X-Gm-Message-State: AOJu0Ywq2W9PyEyDuatkhZqVh9C+NgyfX1aq6dUFCk5HVEWMcW+fF9VJ
	UR7ByET3YjshJosBZDO+/pRSJUxaDKLmWd839pcI7WtmQYRcwsw+XikpD1QQyL/bx3WL0U5sq7g
	6Vd67RUjG/rpRxVJEvZ3BtP+yz6oiD8ahR60XnQ==
X-Google-Smtp-Source: AGHT+IHqaAUVnMg7KxPdK8tkDPA3uORN9IoePxYNCC3cqO9e5WJNI2KZdPGog1tQCvSwi7LWQ6nGEb52GA0R7WzgoEw=
X-Received: by 2002:a05:6902:2513:b0:dc7:8c3a:4e42 with SMTP id
 dt19-20020a056902251300b00dc78c3a4e42mr14807411ybb.30.1709713222025; Wed, 06
 Mar 2024 00:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz> <20240306-castor-changes-v1-2-2286eaf85fff@z3ntu.xyz>
In-Reply-To: <20240306-castor-changes-v1-2-2286eaf85fff@z3ntu.xyz>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 10:20:10 +0200
Message-ID: <CAA8EJpoYmdfB30byfAW3ngUTw_11-uD+emfdFevVd7kqqFWt6Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] ARM: dts: qcom: msm8974pro-castor: Add mmc aliases
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 01:26, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Add the mmc0 & mmc1 aliases to make sure internal storage always becomes
> /dev/mmcblk0 and SD card becomes /dev/mmcblk1
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

