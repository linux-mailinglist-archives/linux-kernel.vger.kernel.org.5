Return-Path: <linux-kernel+bounces-59250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100D84F3D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04591F22432
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856862420C;
	Fri,  9 Feb 2024 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJcVpPu3"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC12241E6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475999; cv=none; b=eSA6mMGO7PkRcPm5IjJkzsMZtNkI4XZ2/daM6jFj69Rvt2VcF2h9VgGwNa7f47fMuB6j4JF/NwqZCtt6P2nh7yVw/mM4Rq9/pVOuRnXca3Pv7xXiP5YUl9vz3PeRyc8VVDCiyr5cYqd+IBIj+FV8n1/B5mAUhAHrNbK+Ct11HZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475999; c=relaxed/simple;
	bh=bBVodIkFUuf5TjuHA1UbbrCx/ebybTBO+Q6c/7GdpAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctmjHjZ3eaKmyA7dXpS/c5xDbt0a73eRMPr/IJregEDSQxW60wkYDg69KQXSc3D0w7WcZ3/rHEYnWma17YN4kS0KWbyu7tzTF1p4HodcwXs8dCohmo4vk6ccL9RYHjWR/LhYb52OQk0XXmBub8yQo2r7Gexndl6erSGj5cTywH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SJcVpPu3; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60498c31743so8116977b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 02:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707475997; x=1708080797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4t5G9ULgip1omppIrMSWBh824NopQFVbRmAIJheoN6k=;
        b=SJcVpPu3TpI4DvbGtfy7pgQFs5IJ9WaUqLUWMhRvmJ5hlThIk1g9ITdunms7bUQvt/
         M7qse5Xti1jvHsglZST+2HmpzV10Fv+GEdEeUwpSucRuVoRVW8EFWvxIDIqo2ZycpBwr
         VRfrG+X3qB7KxOgIT6Y/dIVhkX3JRDyNJpxL2c5Jh9bDvgzG9y10yzIfsr6fPzVFFmGx
         703+1Nbj/qSGImQttDMVNHDjvhIJVBPn5qK7Vrn1PLfl+C2h8LcrCDnCB35OrH+2ZdaQ
         xUUpptjar9PXgOottJMO9UL8BMxKRiJ8XyOk/86fTwRruUepXhzmsXEI9YLHA0Dr97KX
         H7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475997; x=1708080797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4t5G9ULgip1omppIrMSWBh824NopQFVbRmAIJheoN6k=;
        b=jw4DcVZhrE9YDt/RkTwMlksgAdWV9wyExYKW+0xisyqsdJXKQruUgdz/ZPGI8AOssG
         808HcvyLZnb8PguV1Q1zhZlNdrDTMfq9sJYEXJHpIkBHTZdbnAaP9poUwolkf11S9POX
         MkMfqfAVCE1ZJrMAoLx5BAbSQybvs1GEyL102fD/ygl3zGlpNvhDDLvKBmSpCC1vO10j
         CdVVpuivH76pdyqTZgRt1aYV6EmBMLDPegeooSDKBYahB1yK6nAD1vz46ZZU36IQ42CV
         Iwpu5uX6pYLLGjkhnu8BWTg6tgBkn/toqWyNFvSscfntd+1eaQRorPUD2H1GlRRYmpO4
         qfew==
X-Gm-Message-State: AOJu0YwTrYpbJHXU8NHFa9MhC2e3wVjYLP2HrDewMlGL0gBm+QH1DkA7
	Pi3UCOy7gd3Rdvk2ifLnqiRryv9udD2tpAQdU2gIcieYvFaNCFeBlpluvGZ0qEvC8aGSqa7qFwW
	5QB1zUpFKizhjPyisWfmRh5Yk/sm3/nAnPStl+A==
X-Google-Smtp-Source: AGHT+IEYr40Xins1Ugu9N2EC470IZHXfOwEHL+myb8RBHaNgBLYJY6StP1BZSABiyzCT43QOSlagmJhV9ZKbAkqTMZE=
X-Received: by 2002:a81:4a42:0:b0:5ff:d871:b4d with SMTP id
 x63-20020a814a42000000b005ffd8710b4dmr925660ywa.44.1707475997376; Fri, 09 Feb
 2024 02:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com> <20240123144543.9405-4-quic_bibekkum@quicinc.com>
In-Reply-To: <20240123144543.9405-4-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 9 Feb 2024 12:53:10 +0200
Message-ID: <CAA8EJpr3S1hGSjeBx+vhZZHq0OpyULCmyxasUzF6RGdTvXEBSg@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	konrad.dybcio@linaro.org, jsnitsel@redhat.com, quic_bjorande@quicinc.com, 
	mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org, 
	u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com, 
	quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 16:46, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a custom prefetch setting enabling TLB to prefetch the next set
> of page tables accordingly allowing for faster translations.
>
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 61 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h | 16 +++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++
>  4 files changed, 84 insertions(+), 3 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

