Return-Path: <linux-kernel+bounces-95127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFAA874984
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED811C20E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5576062A1D;
	Thu,  7 Mar 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yabwS6aa"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0A6306D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799870; cv=none; b=MWeieIZPktMEl4l/uMOM4M7brElDOpzdTrw/o4bL4YlGxkxt1jnQy5tIB3sPJfbT9fWWZB2SLad7z6/+CM6oJKZFNBOgLsSSe7Q5t/LUnAp8VqclOJl9Q1HEpimougWOhWhfpI08DWT0HT+eYGm+vd3bCHnygYNs1/CKycNNBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799870; c=relaxed/simple;
	bh=HwIOtDxBs12zJ1pvutYk5Ifex95KRtN8D3N43+ZcAH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvjJNMPLGPa7f4p47dknRtGLBtEI0JrUHJieacTK8IS7vU0cFvYGGyCEWS4fprgg0S/VSNTDAc5LuIlcpFLEbXmV7JCRaPxA8QSiNYtSekl9YQjzl2HZ+9fWOUCTh+2cAGU2t88qXJjOpIPqwZrZMfclBXqcyth6nS067eET2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yabwS6aa; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso635997276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709799868; x=1710404668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HrWzrMUBdT94HiU9dUcTPoeH7WMZ5J8gNIFhjinA3XM=;
        b=yabwS6aaXCzgGvFibIinRm8ZSwvAXOfLiefILhrE84G1GObiyJyukOfnwE+z911cHk
         t4zrC+KFZu1EGcn8gE31PLQpt0Li2WToMHv0joeWB2CGdSmkWNIZUuC409nIA1l+OlpN
         ldQfWsQbHl9p9UzrEz0gjphgZZxKDrgb8fh0NwJBkWxSp6v4Tn4J02Rltt3M3zJ8AR51
         Ll9fO6vhKwvxFzivk7IEkiaHCa4MWBx56DamQ/1PcnOnYBjcpROMhN7CxIMrK2dOCFBy
         97XXU8JU5aPN4luq4dXqrl/ZtwC+yelVyVPcvwQecB6eAX6SysAMx7sJpnrjQHkZpdkr
         ruWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799868; x=1710404668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrWzrMUBdT94HiU9dUcTPoeH7WMZ5J8gNIFhjinA3XM=;
        b=v3xegytgc4Tg679+xoQFmUaabF2H7z8T7fRpiyd+SjItIvLcWA5w8WqFYis1lCXFPg
         Kqes1pVC6HFdyjVsYVgqxdmSgBd+HjbU/hnzwXCHpzn/L4CViGSJpk0uWnGgp4aQZq73
         69Y93Ja7OD0+qTja0ZWMKnaWBjcNKsB72PkvhNdQQULReehGGfONi35pCmPHS1lY2Jrp
         kqDcRNF8a4drFtEMfPxrzLeWp19NClbs1gRMJTGR9O6iFwCwDGa0i4jLXuraJvZSir0E
         QE6yd8XzBgCVcGK6qs76Cd0bPcSGqtUKd9Qr83FAHzDsUFIsPzCA7i5XDIoyf78ECT81
         79ww==
X-Forwarded-Encrypted: i=1; AJvYcCUvqdRV7QE2mZm131ThHpoI/zTYFcspocg1VacXqufz2f7xbtMOIDCoDpJI+40d8Yss9kmFeu7ebDVbUVZZfk5dZGs7GJgD3dD05qXM
X-Gm-Message-State: AOJu0YxDD6XQfwah0+f9JlHOwgVl2Zc2B9t5pyaWvp4IDyHVieqvcHjo
	V2JWwAz9qyNv1Pn2DQ7tZwbo2o88a76WMjB1DrdblpL8c7rc8KW8fSQODser8Xk4aWcuY1IwtmB
	pVDqCFjl/Y5VTdDxORKNu5cliXGez3UuCiQYikg==
X-Google-Smtp-Source: AGHT+IGo9lHi+LEb+DS8+PgVMTubJMqAp8Nr0DkwjG6EMkEJSTxocKlvC0xiwUrwFMIXHE/XWrup2AjbpmgQzZTgH3U=
X-Received: by 2002:a25:8a08:0:b0:dbe:4f15:b5cf with SMTP id
 g8-20020a258a08000000b00dbe4f15b5cfmr14221787ybl.15.1709799868120; Thu, 07
 Mar 2024 00:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215103929.19357-1-quic_riteshk@quicinc.com> <5271ebb4-68e7-468f-b1e0-b35a77f53902@quicinc.com>
In-Reply-To: <5271ebb4-68e7-468f-b1e0-b35a77f53902@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 10:24:17 +0200
Message-ID: <CAA8EJpridDoMFRTo46n6dqvm1Lu8Bxka2S5AD97JjXM_6WhCLg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] add display and panel on qcm6490 idp
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com, 
	geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org, 
	nfraprado@collabora.com, m.szyprowski@samsung.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_abhinavk@quicinc.com, quic_rajeevny@quicinc.com, 
	quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 10:20, Ritesh Kumar <quic_riteshk@quicinc.com> wrote:
>
>
> On 2/15/2024 4:09 PM, Ritesh Kumar wrote:
> > Build the Novatek NT36672E DSI Panel driver as module and enable
> > display subsystem on Qualcomm qcm6490 idp board.
> >
> > Ritesh Kumar (2):
> >    arm64: defconfig: enable Novatek NT36672E DSI Panel driver
> >    arm64: dts: qcom: qcm6490-idp: add display and panel
>
> Can you please review and apply these two patches.

Can you please read docs regarding the kernel development process?


-- 
With best wishes
Dmitry

