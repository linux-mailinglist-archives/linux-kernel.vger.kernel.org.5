Return-Path: <linux-kernel+bounces-40424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F1383DFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5EC1F223CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5432111A;
	Fri, 26 Jan 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BkXyBCBQ"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86D20DF8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289616; cv=none; b=QtnRe6b8N/ZxokW/9WJN6PpA22D8/ef9Nx4w148XFr+HgVArAeSPxNCZgwqI46S0NPdDy5RTgoTUfwPs2FwjfBC7zfiU8wUxkUR8A5trhjTo0lmIyres24bzl9MOlFn2Q4d5Kw/JIVabKxLOys7WN7VnTsfxD5fnDQAhPzpAIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289616; c=relaxed/simple;
	bh=73loVm8ly7qdwE39+2h0z6ktV12Cx5r1ZMgjVHoK8hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYrYDvO29oVAbytdQToo+3tieFBLAZH0JKpDnOzost7tzN842VU7imzruWlJ7MWMNPWPdNchPb6BhOyYA10hXYQo4hMf4Y5zQG8fOK9755MLNZP0IDmLR7+zm6VGms6bd1GTNuLVhcv/5UY2l9vjdF46dXjDeyn0sjzVDqSTeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BkXyBCBQ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff847429d4so10945607b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289614; x=1706894414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DfcOf0udxUc+w1U/rSjRqEr06RAjRh2n5t1k3e8n0LY=;
        b=BkXyBCBQqJdFREGuiWymbR00OFuInOFGFYHdQAkSb1pflyPQrMoS5J7cvnxuoBaFq9
         +miE5T6kT1RehTmU2ok8H4TDzTxUODUZ9LVDhi5RKPwo8/IZKrGd2WiHfSFdoR3JWqF9
         iu8iRp+YyG5NYSoZYT+ospvsCI4tcLvS6eY+dlRdkX+zFN9umpGKiPPgRkLA5YRPm3pY
         +Yosf5AoLlplqntUxaC/JI+SD4dv6Qx10aVCbUKm6lTMOQTTt1AvCHeq3LhjQeh9fPzH
         mzPjUSLTquiXuEfhVuCtx/xTkHyCz+xIS+0wZCIZ+s2apSF7WB84zcaggRd0g+Hq9CtC
         uItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289614; x=1706894414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfcOf0udxUc+w1U/rSjRqEr06RAjRh2n5t1k3e8n0LY=;
        b=N584DAMZrkwz0hsp+ZCY/GP2rJGjkeToSJZB120v9PnKm+atPL9quI2ldtE3THkHnc
         VISECvs3FufkgM/Grh5guF4ecciLLYD2tfJv5yvwy4Cyyimj4zhLePeGUPEkJbqSzM18
         UaYK+JTGmxAokIBcvNef3vDGKj2Xcu1HP92wjvB2vJx14X4btlavqmaT0qSMgYJIUZix
         puFgZBYKdnGHkInqVUn0Z8RipoiH8rgj7XJeE4WQhc61fZBwDlfo2L31OgLUqB4dajzM
         A2/XeJ8CLZhh3ANuDXkjL+2IAkp6socwIjhBIusbROiSN8kofMrWlaJIdKU9eyqOFwjo
         AFeA==
X-Gm-Message-State: AOJu0YzuEKNaAeDFWCd5/ehEBlLwynZDibiW85JMPcUOj2+ogRfrQ6G6
	eA4RfFDJaV/0JH6T5mo1dbSoaIqTU4SZ9cRaqNBedDHl4UXNajFLW/461NgriKI10KWl7oE78Ok
	qt9kgdAHZegqbv2QTR7Q9+V6l7nc5NWpb//0byA==
X-Google-Smtp-Source: AGHT+IGa+zspZThxi9oRy2oS248JEsOPKalw83o4vIHdlm+VhTwbKv49+h1a4t3B8lhSzO3bv/j1ohqxDrsg6+8ov90=
X-Received: by 2002:a05:690c:f8f:b0:5ff:4987:4ef3 with SMTP id
 df15-20020a05690c0f8f00b005ff49874ef3mr211891ywb.24.1706289614301; Fri, 26
 Jan 2024 09:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124213640.7582-1-ansuelsmth@gmail.com> <53445feb-a02c-4859-a993-ccf957208115@quicinc.com>
 <f8a9e328-5284-4f24-be5d-7e9804869ecd@lunn.ch> <5d778fc0-864c-4e91-9722-1e39551ffc45@quicinc.com>
In-Reply-To: <5d778fc0-864c-4e91-9722-1e39551ffc45@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 26 Jan 2024 19:20:03 +0200
Message-ID: <CAA8EJppUGH1pMg579nJmG2iTHGsOJdgDL93kfOvKofANTGGdHw@mail.gmail.com>
Subject: Re: [net-next PATCH 0/3] net: mdio-ipq4019: fix wrong default MDC rate
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Christian Marangi <ansuelsmth@gmail.com>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Robert Marko <robert.marko@sartura.hr>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 18:03, Jie Luo <quic_luoj@quicinc.com> wrote:
>
>
>
> On 1/26/2024 1:18 AM, Andrew Lunn wrote:
> >> Hi Christian,
> >> Just a gentle reminder.
> >>
> >> The MDIO frequency config is already added by the following patch series.
> >> https://lore.kernel.org/netdev/28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org/T/#m840cb8d269dca133c3ad3da3d112c63382ec2058
> >
> > I admit this version was posted first. However, its embedded in a
> > patch series which is not making much progress, and i doubt will make
> > progress any time soon.
> >
> > If you really want your version to be used, please split it out into a
> > standalone patch series adding just MDIO clock-frequency support, with
> > its binding, and nothing else.
> >
> >      Andrew
>
> Hi Andrew,
> We will rework the patch series to include only MDIO frequency related
> function and frequency dt binding, and post the updated patch series
> on the Monday/Tuesday of next week. We will work with Christian to
> ensure he can re-use this patch as well.

Can you do the other way around: rebase your patches on top of Chritian's work?

-- 
With best wishes
Dmitry

