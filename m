Return-Path: <linux-kernel+bounces-127773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349C8950BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227C41F24C0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD5D6215F;
	Tue,  2 Apr 2024 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyr3C/ng"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBBA65BAA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054943; cv=none; b=qN2qgwq1L1ObCBRJZWrcwl+s1307w3W7BJKiWv6GrnOtBpufhCzYGnkQDgPdzXoppj6TAYEBBglM2V+9b71OcdWF/G+qflfxsR/O/ymDV+pSGh1oTfe/DDv5KvOC1BLCqfbuUFv195h5nC4No8n/W+cT3vhenJErjePiE1K5BbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054943; c=relaxed/simple;
	bh=ntfWqHpmDy4DIMcm7CKN+FPSTquvhkckHhRW34UWCtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgDwLTIXplx9NyWurIhywKF/rz70qTOK82pVw7Dr8VLSFwRYdWXshy9gvCB84Y9wV+t0xfcidtiVVE9XrZtIronyvCuJ1w0o3ipFeERSgRwDI4xtFoNtPRcfBHL/wwqN2p53OAl3JIE/In4U5MzWQjjDvPrCvnwrZAa7aDOL9N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fyr3C/ng; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso5153126276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054939; x=1712659739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cL+6rU031lCbn4rJijXxXCPdj92d+pFHGEV2AGXf59Q=;
        b=fyr3C/ngTM2VuxuFV12egZBfFLQ4AxVeiSt2FjHUuultNYQuRd3xWWLYOn9q3mU4J8
         d1MQ+NGV6jqVWtDUpV2oE6xP+c44ufRS4UoTiZLWZR5qGp/IfZ09oW99yQDJR4DOGDQw
         BgxV/At5a2wwkuBFn11ZDArQu68DcH+UHJpQe8H1gIUmsSlH/WLA1Q/p86qdMYFyhuH2
         C1XqLR1YND2h0M/ld0sTne9OwweQ4NjxxQnoupiYz0mBDmMLs3AJ4v+57FTDSSeA8dU1
         TU+Kv9kTi2nvbtaapvwsHUkC7iNHapr+LXW9ui80qroQUBdAofRDpMmZ72BqT8WxwbqN
         azeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054939; x=1712659739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cL+6rU031lCbn4rJijXxXCPdj92d+pFHGEV2AGXf59Q=;
        b=iIN07XbMFsdnxk5o1OHB1T86wjKlKh0T0BlgEFtUj6a9PWxb134+UHxlGK8+JNR1BW
         Oee0zAPbvyD5tkIhavlMroqcCBKC8gHNWJiDr5khSxNyXVfzNIN+K2dpe4z1qPmkMqDz
         baQC0PKOgh3nsM7I9fSHHHDhE6NuclmtvY931e4nS1v7VAYqBrs1wIRKl4Eck/o/SrML
         6n1zADlOR/TDNG7KjVMq9sftMV5JjCWNLpabeeUSm+HckSQrALirVwPPHOBYRwCU1Cao
         a3QKjPAd9t83QRKZzIH42A8S/HLBImdsi8jtIZ6HtmZHhYhlLUSa0MyDrrcUytInZjas
         sMMA==
X-Forwarded-Encrypted: i=1; AJvYcCWDakBEt1LIDW8eTEHrA8l2Z73eKbWkdxJuBIDljR7uO62arFpKcJhJebQjjWEirgW7mJmNWjl+QeeOpSq5hZvas9UIefiMcJOTzuC6
X-Gm-Message-State: AOJu0Yy3eC5y1F5IcvQqJ99viKvgydXAPi0fHFNw3vFkgJyZUWNdK5h/
	2ZXjXLJrMr4NuIrpDQ/HJZLAsG2pNr+ZkewAatgtEFcnh1ziQFdfvGUUZYXvpBVFRktGnhv08z4
	4/N6CyIQ/xfLbGHgko4wfswgnMuUfiCq1KgGhDQ==
X-Google-Smtp-Source: AGHT+IF3amTy3mi9gx0Fg8qpLFvR2VZ42wU7eSSjKWNzlxbLx8pQTgtu/c6DCvvde5oLRreiYm6VwKWGKN3tbIa8iIE=
X-Received: by 2002:a25:99c1:0:b0:dcd:aee6:fa9 with SMTP id
 q1-20020a2599c1000000b00dcdaee60fa9mr8752476ybo.53.1712054939333; Tue, 02 Apr
 2024 03:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com> <20240402103406.3638821-7-quic_varada@quicinc.com>
In-Reply-To: <20240402103406.3638821-7-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 13:48:48 +0300
Message-ID: <CAA8EJpok9DzjSSt=ejegFo78zJqycs3S+bua76oXDivvzW7icg@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> IPQ SoCs dont involve RPM in managing NoC related clocks and
> there is no NoC scaling. Linux itself handles these clocks.
> However, these should not be exposed as just clocks and align
> with other Qualcomm SoCs that handle these clocks from a
> interconnect provider.
>
> Hence include icc provider capability to the gcc node so that
> peripherals can use the interconnect facility to enable these
> clocks.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

