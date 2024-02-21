Return-Path: <linux-kernel+bounces-74846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C085DD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C1D1C231E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173B27BB1F;
	Wed, 21 Feb 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGmawmjF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870678B53
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524199; cv=none; b=DJmWIFMeNashf0XJSDUwAH6k4oaIOcoz91Mo2PRIi4vhYl6gVC0pwlPREF07yE26G0J/dToOm5cSW/qT4iu5FweONilI/5vZVZmimvEnCItY0/3ZTjWQ3cCDmF4LgAX+B/7ifx3ylsL9II5Zj4fzC0519PnfAlKgluM7TrRNHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524199; c=relaxed/simple;
	bh=WbR09E2BAJWLw9OtAqy3g7gorLJvcxK+W0yTQGH+68Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0UbgmCQQhcjPWJETm+7GTIJ7njxfxhyOGK/BPySsgsu/LJHPFy67eCMdmDPS5gU70Byt8sWFUltiWVBBIn+kgchtyRZU0TIFcCUNevu5jQRipdDl0hOqj9+NXvxygN6F9n1qLd/cEKuoxFGUSbcTM6XVpwdm0HvvDFDtvIbytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGmawmjF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708524196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qxhHc1567b1ENtQyC/DDNYQ6oTNC8pvgtuZ4hffmPl8=;
	b=AGmawmjFdZC1ueXylWJrrJdwf+GU1CMvEVXL36DowE96Fu6OXnHMkiZkU8WEc7+PHs2q/E
	nugHBcFv7XwslpBtVDT2smYWY4WyG0O7g2NqyI9PRVGVtLj9eJDC3jMSfUl/6F2DIDJ6zh
	B40iRtE0ZeH7xtK3dqVKzFbrcKXHZ5U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-6gNUYFe7OUGst4VmuEV0cg-1; Wed, 21 Feb 2024 09:03:00 -0500
X-MC-Unique: 6gNUYFe7OUGst4VmuEV0cg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68f892ca388so32674516d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708524174; x=1709128974;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxhHc1567b1ENtQyC/DDNYQ6oTNC8pvgtuZ4hffmPl8=;
        b=HDQpGQ1hDdCMeYBcS+XCw3uE5BZbwJLBk8NZWXpFV2nE374lqmcn8jJG/lUFu0O2bi
         pw7f2xYn/50JyI/kDX59cW7WF8mPlccpeh69w20knt19dmMUj3ulJKgQ7EDq4OXJXvRe
         YEoXZOuEv6VnES05FP/ndoJlA2m830SawcUqHPGdtN6j8mqYdoJvNB+RxLIMiEN3tkwr
         fwVOMJIYi3lkpEUoFSpZe+VbPa++LsC8OgBe7vF2SY4rH9suAizCPG/CchVw5cVXkt1d
         wFCOzGZeqALYQRKYOwwAKj88edIgTUBhiaEWN4y/VyoCteMIuE4Ux3mrdi8t04eK9TXq
         UD9w==
X-Gm-Message-State: AOJu0YxsIV9nMJK+chn8UA9DXLWw19TT34F+QoeFdQ3Bcd+PokV1AbsY
	QNsabpZFo5hKk5LupSrxPciH7T2ZTr/ZJenKOqD8thwEiwbKcz3vnlt7OzcJji1tjNswPGYAUlZ
	5w64vGfYXrQXl3GCiJ7EGopvDBiopvmDYOyH73CYVi5Vuuy9piMAfPp55Vz4Ryg==
X-Received: by 2002:a0c:c990:0:b0:68f:3eba:a48d with SMTP id b16-20020a0cc990000000b0068f3ebaa48dmr12710092qvk.41.1708524174601;
        Wed, 21 Feb 2024 06:02:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHckauFrmZGyOAWybLLLokvSHMsRkW8uHIjd0Z2XeHrafitW4WwmFNP3O4DoXw5BTJX7ZcpfA==
X-Received: by 2002:a0c:c990:0:b0:68f:3eba:a48d with SMTP id b16-20020a0cc990000000b0068f3ebaa48dmr12710058qvk.41.1708524174145;
        Wed, 21 Feb 2024 06:02:54 -0800 (PST)
Received: from x1 (c-24-2-114-156.hsd1.pa.comcast.net. [24.2.114.156])
        by smtp.gmail.com with ESMTPSA id e5-20020a056214162500b0068f0923ff12sm5490576qvw.30.2024.02.21.06.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:02:53 -0800 (PST)
Date: Wed, 21 Feb 2024 09:02:52 -0500
From: Brian Masney <bmasney@redhat.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@redhat.com>,
	Erico Nunes <nunes.erico@gmail.com>,
	Enric Balletbo i Serra <eballetbo@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
Message-ID: <ZdYCjDPvEp4iFaZ1@x1>
References: <20240221125928.3711050-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221125928.3711050-1-javierm@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Wed, Feb 21, 2024 at 01:59:17PM +0100, Javier Martinez Canillas wrote:
> These options are needed by some Linux distributions (e.g: Fedora), so
> let's enable them to make it easier for developers using such distros.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


