Return-Path: <linux-kernel+bounces-146625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD18A685D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDE628385D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3E2127E0C;
	Tue, 16 Apr 2024 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdKv9A7+"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C9127B70
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263323; cv=none; b=RnnYg1lX0q5h2xIJ9rc+fXjnuhaBQjqAALlDTlLun0z7fV7uBMX1GNF/Ahv07ZOqfZxOOxdGFf5gGO0a04jV4pCZ047Roml62gMAd6w/ZmFiORFFrVWM03wZpataUP5vsos8W/4hGBku54WXhLsFExo1jAUIc02NO5ctkieSLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263323; c=relaxed/simple;
	bh=gXScnn7hEl87X0LHuVINW9LoVC2gyqeNWlwiwXYKs4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feaQgxHTmujiM3we/tDdq8Ceob6ds9vhuLpdVsLZQigwoqMCLboeDf6JeLhhA1qnOHWRguNWFzKB0EfIXy/r5RnBlarhy5MLcoDFztev/qzAJl7mHUjxneZ+zpeXmn3b4e/+Vou4fLHfY7gAhMD2WL0koOmQ4Vul5lEzy924vRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdKv9A7+; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa17c29ba0so2481683eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713263321; x=1713868121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gXScnn7hEl87X0LHuVINW9LoVC2gyqeNWlwiwXYKs4A=;
        b=hdKv9A7+Y9zW7yIVLwQVu0RoSY0kp0nc1FOJVW7N89Z4k4IxwzGF1BJvplkVMHXBxl
         s+J5vXnuxaQIpfIPVccqRLum5dVHoJ8be3GJHRZk4wffNInRtVjyAOI8uxPAeawlU7Na
         OWrbVuc7XYOpllPVcO0knJMdnTcQYxtYC4wqwXM9u71knbX6ie+9Lp8s3csdMgO+cyZc
         TMQ+7wbsyg2XXE7IPQUJZdE3T1INlP7L7uwEv9ZDHScIYvBt8oHlobo4Z3dBUi/1aWSO
         cTi7YFbEqXQIfDMye3512OST9IWAle2r5km9EEfDas4oCRcilhJG0LXkrNcd5IgyMybC
         R8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713263321; x=1713868121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXScnn7hEl87X0LHuVINW9LoVC2gyqeNWlwiwXYKs4A=;
        b=jBOw1Tmqmj1Og8Zug/UaO0L7BSUlT+38SowAcycR0MAJQg6RiM0SVmETSOzWouDxDE
         t4m+95DUOKhz9lJPyO5ut0HFNiSuLMvNjdvlVUhQqcO/04dRt2XgNjtbmWzTudjpcJTJ
         oMmLk/vTNzdhlpd/QdQvzGawGQuFxrhvVJuMDkJ8oqb0of1mytBMCKXZyp41juvEs66s
         Ui04dI7lqKjDCPsSGgPx2RXJk6CVGXv2wFSSIK/MYXbIEhr+NluEkpTnSJCo23ySqwoE
         AuTE1oq/iWJKy9AK8F2GF/vESD62NZitWhYpiH2IoqAj88FjXXk684XGlMRJUHTQguHb
         p/zw==
X-Forwarded-Encrypted: i=1; AJvYcCW+7SYSRDXgD5R1dXofk8pDLej+qCcf7HT/aH91TpkP4Oky79KM902tBFu4qjws5imRndO2IhL9SKXg1BGxJBO1yhcb9dQwxQXENzZL
X-Gm-Message-State: AOJu0YxH7jbRJlZ9ByvkIsb8rRgvIsmhykhFkt9m+azwlrKz3x4iDmyS
	ocVml4cxkLVGVoPmzTvGZqNMt2/nTi/yp2z3gjNMczrV5/kHglLwgf1u9XtAG19I5jNvKIA7FX/
	4OFLuqTa0alVZUgvCKHFt70nJyMlFgPIqgsOe/A==
X-Google-Smtp-Source: AGHT+IE+KH4+3J+4bWImbLmf/i6TMO+pjq+Zhj12DdRm1Ocu0R700WdkfWb+yJ4DCJJOFwu9s9QfuRU794n8yE834po=
X-Received: by 2002:a05:6820:1e16:b0:5aa:676e:9ad9 with SMTP id
 dh22-20020a0568201e1600b005aa676e9ad9mr12599912oob.2.1713263321084; Tue, 16
 Apr 2024 03:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122559.898930-1-peter.griffin@linaro.org> <948a70ed-e3de-41d6-ada8-b547aa004ef0@kernel.org>
In-Reply-To: <948a70ed-e3de-41d6-ada8-b547aa004ef0@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 16 Apr 2024 11:28:30 +0100
Message-ID: <CADrjBPoo4uwiv1x1mNdtNUiaYkbksTre19AYT-ZtzjXaV63CyQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] HSI2, UFS & UFS phy support for Tensor GS101
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, 
	s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, chanho61.park@samsung.com, ebiggers@kernel.org, 
	linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Fri, 5 Apr 2024 at 08:45, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 04/04/2024 14:25, Peter Griffin wrote:
> > Hi folks,
> >
> > This series adds support for the High Speed Interface (HSI) 2 clock
> > management unit, UFS controller and UFS phy calibration/tuning for GS101.
> >
> > With this series applied, UFS is now functional! The SKhynix HN8T05BZGKX015
> > can be enumerated, partitions mounted etc. This then allows us to move away
> > from the initramfs rootfs we have been using for development so far.
> >
> > The intention is this series will be merged via Krzysztofs Samsung Exynos
> > tree(s). This series is rebased on next-20240404.
> >
> > The series is broadly split into the following parts:
> > 1) dt-bindings documentation updates
> > 2) gs101 device tree updates
> > 3) Prepatory patches for samsung-ufs driver
> > 4) GS101 ufs-phy support
> > 5) Prepatory patches for ufs-exynos driver
> > 6) GS101 ufs-exynos support
>
> UFS phy and host should go through their trees. What is the
> reason/need/requirement to put it into this patchset and merge via
> Samsung SoC tree?

Good point, there is no requirement for it to all go via Samsung SoC
tree I will remove that from the cover letter in future versions.
I see Vinod has already queued the phy parts of the series which is great :-)

regards,

Peter

