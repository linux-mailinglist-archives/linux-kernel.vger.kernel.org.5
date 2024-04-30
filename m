Return-Path: <linux-kernel+bounces-164578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88548B7F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2DA1F23CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED6A1836E0;
	Tue, 30 Apr 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alJe3dij"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A646181B9D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501108; cv=none; b=jZyQevHixlovxlblc8OuhP3fV3OfrQ4e/YSuxrWngYKLA4xUTthwfT9H9FF8rvXWcH0cXaocOSvgUOgZxikjMU7RIgtJ05KjnDesDkjYWliqFQixc6w0dEYq/6vbpO43p9gdjVO0Qveaxp7zJm9fUsSYtMplv9vfEGCFD7wo8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501108; c=relaxed/simple;
	bh=UutKKL5v4hLIvztgtNbZifKME80U9mdpqFYB4ZXETek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxrRIMBFEP+niGH9tojU/inRuGaz1bG2txSEmaBtOxDPwifDOzO8qzd2Urx8F1iATNwvD4nSOoiX7elDAVAFChNukYckD8k8vG/dVs2hTWrtmeCosm0mwuBG91aWO673QNXb8joB143w0Hxr7uB6FGR70j8TAaG1I5PERpXd2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alJe3dij; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714501105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7bMjhKG6eUiLMls1sKg9TQtPsjkZbGw6Je2cQ0wOI9I=;
	b=alJe3dij+SMpVlfs7RfBcAURCQ7wsYV8FSZXpDXAVSrVbkp0d0carrVT3xMWBsH0VawLB+
	lpK+MzfAeuQv45Xmkr3PECflM0kAkXAOcH2IoVMVQ+PP2f5AehRiF8GvNN3fTKf8eV3Pwd
	GFMAmvxtNdITWMiea0qDVB37wkf5E90=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Si9XaispPq6zm1il1YFk7A-1; Tue, 30 Apr 2024 14:18:24 -0400
X-MC-Unique: Si9XaispPq6zm1il1YFk7A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6a0a0eb9cd9so69486476d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714501103; x=1715105903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bMjhKG6eUiLMls1sKg9TQtPsjkZbGw6Je2cQ0wOI9I=;
        b=DcHZBruZ7CzkenG6DlIpAw1t84mA1hBo0BjnknRjYGqTMzNvgKhwu8ynFK3vnpI1cN
         ZANuLEaDEDtw73pnFTZvUsUGuAn93EkfjcuwdtrzDhvNcERFVn9XmlLw1SOVeRPNI44Z
         cygIbsA/4NtJEu8d54ZygmCrZzjznCq8Fx7DnlhoD4v719IXL+HndW2WIz6eTRc7R2f2
         1rU/9Z653DyNY4DKG5xbL28ARtMIFyNUx7PpvJppa99+EzgnepLASd1ITj5d/7UU0PVn
         dnzeZ8U4F7Avc5y7zcfhq02UtvwNLjKS2jmys35a5lUpxznRBvfF8IpWGzxcOey/keZB
         N1Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVzImS7NDxdGSrgzbig88kkW/Sj0JWq7mZiq1xRpQEUIlM1n3JFnUChYGUScyt3BoEGcgul1ZjWNw8WlFJEZpSFIXBzwS5scP8NCDFS
X-Gm-Message-State: AOJu0YykZZygrum4O+7NJDMBTxNss5aX14d2PMAK4Yk0+f4VoIu6noWZ
	jwJaoIrBU+s19q3nYTaCHd2/vfdaqdKJ0hWslyyQmQNaK3VUM4sa4tsULFTdx2ZiruUNZybgfNx
	8wMLYHzXqNIucUsh2SrktjC5yhfKWBI32zA6qt18L4d4/qVsDKafakmBoFmSRWQ==
X-Received: by 2002:a05:6214:1bcc:b0:699:2760:b44 with SMTP id m12-20020a0562141bcc00b0069927600b44mr136871qvc.8.1714501103207;
        Tue, 30 Apr 2024 11:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUnGrLFR1P3p5845OT+cZcbzwoG5yrAYahQu0eKiEn6wC9wa0Bi1GmTFeAdhouIlg0/I+oSA==
X-Received: by 2002:a05:6214:1bcc:b0:699:2760:b44 with SMTP id m12-20020a0562141bcc00b0069927600b44mr136842qvc.8.1714501102808;
        Tue, 30 Apr 2024 11:18:22 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id y10-20020a0ceaca000000b006a0e69dc029sm439759qvp.82.2024.04.30.11.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:18:22 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:18:20 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: mark ethernet devices as
 DMA-coherent
Message-ID: <tsdaohzq7sk5d5fnakv6hoq4ykytbkrtxv7bxvbctu5bnyh5wi@6dgtg754axyo>
References: <20240425-mark_ethernet_devices_dma_coherent-v1-1-ad0755044e26@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425-mark_ethernet_devices_dma_coherent-v1-1-ad0755044e26@quicinc.com>

On Thu, Apr 25, 2024 at 04:07:10PM -0700, Sagar Cheluvegowda wrote:
> Ethernet devices are cache coherent, mark it as such in the dtsi.
> 
> Change-Id: Id180fae617f2e348c0a80c6664b131cc57fcb4d6
> Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>

In addition to what others have said, I think you should include
fixes tags for this, so something like:

Fixes: ff499a0fbb23 ("arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface")
Fixes: e952348a7cc7 ("arm64: dts: qcom: sa8775p: add a node for EMAC1")

to indicate this isn't just an improvement, but a proper bug fix.

Thanks,
Andrew


