Return-Path: <linux-kernel+bounces-61672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22762851538
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4634B264FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5513D966;
	Mon, 12 Feb 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZ0qYLvi"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148D3A8ED
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744001; cv=none; b=IbGIsLgNh9uKYP1xQI+nIffNUE5kENWS+mU/NcaYAO/1jR9iG6AclgtamQrXzmhj5lgIElsuHgK5lWWNJLz/mFEkfStEQ2biXSSRktjmxk3CJx21/ydYRHL/AJ84C0hX2yDaSDMwg3nnFeaNKvRnUDVvvG3IkdNyQyvKPDG1xR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744001; c=relaxed/simple;
	bh=MiDZ9q4E4B0uRmbXb/ZjZr/uFijMH3jgqXxs5YhkZbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+tG3s8kqtIJAdbo2VcBpyKjphwJ42ePTTddw4qZ/FSrjINSq/faqWi0br511WeJ0jOktr2SNF7g0pcad8fX+Uxgb00U5JY7SntJeuijBz5Q3G8t9mppvLtuc1mC/JeQcHw+9momsxfiBiNXkh5VRnvwfaAKquh6KlhKsRNg0SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZ0qYLvi; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so7138276.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707743999; x=1708348799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G3Ap4U+w+TMZMJlT3gtIEPowqPUkZyKtzXWA3sqYoeA=;
        b=bZ0qYLvil+MOKd1hF4Cnq00KA+PBnKLjibplTbpluRIxDhEoeoBivTQMY+PsvW43o4
         I1dQZwML2Xvkstv98wHQ4fO8sreMS3qJM+YPiE/vw4Np4pcfcvUfFakpn3XsEp2foDOj
         QwlG1jmrpU6XdhSmSRDLeu8BReGZjwlj/oR5ojudj7OwzZ03rgV6CoO5YD7CS5ngnCbI
         SNRfIWGh2EgZ/AZLkivYvNV6YBIP2kI9d+OM7TnSzy/NQfGvCeLaQMp0gFQXlWMeF3Vm
         ZxIiTLhSKk7z+nqmuxj9TaxaFU50uFGC4nPS7IHQNMguobuDPomxEElZDk5X4NanJIyw
         913g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743999; x=1708348799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3Ap4U+w+TMZMJlT3gtIEPowqPUkZyKtzXWA3sqYoeA=;
        b=g9VR5gSpOl6Vnjf3nEZyqacyk5MDbepC2sVvaViRGum1lQsYLfx0QpQIgS44cBXIDy
         Wjog/FJEjYT7pgMPv//qDu5VT6oANG5a8gqmPfz3yOKw3tUIxpPQ1BV9VR1JfeC7/CtY
         +DnVkTjJu8XZdKl0PNuaS2/jwp6dtHe9pVz4H27ENJsIN7mvnEYlm0xEk44/VjauabdU
         2aFwTzFshKbi8n5wCsPgI/bnKpK5BTmzRaRfjIRsBQ8ANclIur9sbPQ79IS7nRMMnvcF
         gHcF+CnzxGNE0o8hyg3YT3LCYleFVsw4mzScZ5m7hnJB6F2dfBHKBsX75Ibs4WvuhZa/
         TzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgmwaQShOWShi1suTDXaqKaPfmbpZ0oQAa37HQyxnAU97I6sNq454KZLHbsKYUGn/EwbDE29VAVK2LYcvBupDIC8vMG7eDMSTP6foO
X-Gm-Message-State: AOJu0YyU0dC/D1Io9GXq+5R5zgzIxQa2dPERB+tweczZcBlu0WJpDyhk
	OnYnxE9j6Ga764IancjeCTEvZmfDxwsJVyqn2G5Td83BEpxUTqs8ku0VgUCKuZDBFKEq0QZU8kq
	X7PGqrvbz9mvpnWqzbLwr4VXI4aj3KOj+NzBauA==
X-Google-Smtp-Source: AGHT+IGqUIFO5vVPLAS4fp5yQ7MhqKZGG2SnCArwCgMR3tqqtlHsLSayAuhno80bIasDuonbKvwDKJ2Tqwo4xgzrov8=
X-Received: by 2002:a25:b212:0:b0:dc7:46ab:9f5e with SMTP id
 i18-20020a25b212000000b00dc746ab9f5emr5777858ybj.29.1707743998897; Mon, 12
 Feb 2024 05:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212125239.7764-1-quic_vdadhani@quicinc.com>
In-Reply-To: <20240212125239.7764-1-quic_vdadhani@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 12 Feb 2024 15:19:48 +0200
Message-ID: <CAA8EJpriONTWmdvhtuR+a3=PFs6ScO-EffCWqbt+3y9zBmwOcA@mail.gmail.com>
Subject: Re: [PATCH v4] i2c: i2c-qcom-geni: Correct I2C TRE sequence
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, andi.shyti@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vkoul@kernel.org, quic_bjorande@quicinc.com, 
	manivannan.sadhasivam@linaro.org, bryan.odonoghue@linaro.org, 
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 14:52, Viken Dadhaniya <quic_vdadhani@quicinc.com> wrote:
>
> For i2c read operation in GSI mode, we are getting timeout
> due to malformed TRE basically incorrect TRE sequence
> in gpi(drivers/dma/qcom/gpi.c) driver.
>
> I2C driver has geni_i2c_gpi(I2C_WRITE) function which generates GO TRE and
> geni_i2c_gpi(I2C_READ)generates DMA TRE. Hence to generate GO TRE before
> DMA TRE, we should move geni_i2c_gpi(I2C_WRITE) before
> geni_i2c_gpi(I2C_READ) inside the I2C GSI mode transfer function
> i.e. geni_i2c_gpi_xfer().
>
> TRE stands for Transfer Ring Element - which is basically an element with
> size of 4 words. It contains all information like slave address,
> clk divider, dma address value data size etc).
>
> Mainly we have 3 TREs(Config, GO and DMA tre).
> - CONFIG TRE : consists of internal register configuration which is
>                required before start of the transfer.
> - DMA TRE :    contains DDR/Memory address, called as DMA descriptor.
> - GO TRE :     contains Transfer directions, slave ID, Delay flags, Length
>                of the transfer.
>
> I2c driver calls GPI driver API to config each TRE depending on the
> protocol.
>
> For read operation tre sequence will be as below which is not aligned
> to hardware programming guide.
>
> - CONFIG tre
> - DMA tre
> - GO tre
>
> As per Qualcomm's internal Hardware Programming Guide, we should configure
> TREs in below sequence for any RX only transfer.
>
> - CONFIG tre
> - GO tre
> - DMA tre
>
> Fixes: d8703554f4de ("i2c: qcom-geni: Add support for GPI DMA")
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # qrb5165-rb5
> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>

Thank you,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry

