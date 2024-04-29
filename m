Return-Path: <linux-kernel+bounces-162111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502918B560E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A256B23F12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934403C482;
	Mon, 29 Apr 2024 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQPbM460"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD93D3BB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388925; cv=none; b=W5eMy4I0p6cKRLWDjbiEaSi0/r0n3XbPjmM55VwBQHL2j0ym5qZKoPewjxEvIgvUE5st9iRxKxDR9QA1zfJDHKL/7shSjp6S/bgBCn6i5zM56upS/LmcGhYFpZbXxrYTB81GWmG37+MZ3WwGVqeF+XooJ3vCvnWyY9FtwTPTaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388925; c=relaxed/simple;
	bh=9c7oxmiXTpo5sdlDiSIF1N+bBYPppb/Glq+E27VXlkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ng/mGcfY5s7QG2J5vCuk1gmKERfnC6vSoFuYNjvqzzIEhVi8b7ihq7+1j+2qt4X5MrpAnTpOVoZi2MpPVwGeXPFvS377dP5guNYfHyxprWujGa7IH7w6HR19aKMBl6GhN3jR8yw8hYP9pQTGiEZnmZK9Yia0Ewnon1NtmQxo0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZQPbM460; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2df848f9325so27843161fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714388922; x=1714993722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H5nlE/gKXKtZyCtKakKoynFLO/s21hRFIz45EgqLtos=;
        b=ZQPbM460kozq1CpFc+Plb987ashUoCYhb8CLXrqLu52eVeb7LHngaOLgXGWnR4KoSm
         flfUTU80UqUOpk9d/N6VRaUSnthl0GCyODewjnd/Ia5GKX+wVbBbxz6U1f9zsZvUf25e
         ErxJvc/sqSR2HB1zuUWnkkYWJbWpg3bw8vqQulIXxcgIu+Yu2Mn2bGs4XYDdsw4N4Hpm
         HAgWDHT4tbaeNrVu0Y5WD7IEztlpA0b+ea1Qhwx3rm6w0f/2Np+FFOUkIUPqhnqCfn5f
         BcSKtz5rAyuSdTg7U0fJkBjQrYEoYO/rtJ7vvgceRKgavFrDWQs6Hltos9d+tXmg/EhE
         XBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714388922; x=1714993722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5nlE/gKXKtZyCtKakKoynFLO/s21hRFIz45EgqLtos=;
        b=tGpFtiBhE2TFwwnUNEM7yRl5JSOYP3dPhkjxx9w2hPxtIV1a4H8INIknyqzM7dAYCc
         7kbisRfxHLCHYXDXW/ZI7scXBcHU+MhQYmF3SxgasqaDtlM1SBt/rgJJEY+rbaE0ePS0
         URk4z8iXCXnoIh842Y9Q7H9Q+a3105AatbZRgZe1iHw/eikKmdXeLayY+AqNUxakdT19
         ahdObyt3IFZjuLSBdwFW7+grCAZpmeZqdrBjKBfwgyE1T6g5Sc1Y8TPItzkkIURLXKV6
         bzqTKGHVleZ0XqEH35zqR6Xy/78i9OmMKPdNVMfceJN1xJj0Q3P6cOfoA32z2taty9A1
         TgIg==
X-Forwarded-Encrypted: i=1; AJvYcCWjeXLyTK6X3YSWY+NY0iif6dWmv/9kIaIE80aPO5qtYs4k9/sdH9lC2RNmuEuyrn4RPXvb84mVPSCE1aDAOH+9s5YpZQQqYuA+ybwq
X-Gm-Message-State: AOJu0YwwyooftdAFSENqiBdjsHawlOWVd1PuK3dgmBfPz3VWMT6aZZL3
	6jPzRmRseCdQI6EwVo5UNhjqoDyandOucfIZWpEDPStnzNgF5ZDrOKU4LTinLyA=
X-Google-Smtp-Source: AGHT+IEuF9MTMbDDvvruAjzlean3gb0uB7Mg8YLjCNZkBk4ndSHhKaHF5XHYI+hxCwcB4isDtTQ6/Q==
X-Received: by 2002:a2e:3513:0:b0:2de:d00f:e656 with SMTP id z19-20020a2e3513000000b002ded00fe656mr6854910ljz.37.1714388922282;
        Mon, 29 Apr 2024 04:08:42 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a16-20020adffb90000000b0034af18ef68csm21326343wrr.5.2024.04.29.04.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 04:08:41 -0700 (PDT)
Message-ID: <cfd60a71-b0c1-49d5-82ce-0c52764cea14@linaro.org>
Date: Mon, 29 Apr 2024 12:08:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/6] interconnect: icc-clk: Allow user to specify
 master/slave ids
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@linaro.org,
 djakov@kernel.org, dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240429091314.761900-1-quic_varada@quicinc.com>
 <20240429091314.761900-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240429091314.761900-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2024 10:13, Varadarajan Narayanan wrote:
>   	for (i = 0, j = 0; i < num_clocks; i++) {
>   		qp->clocks[i].clk = data[i].clk;
>   
> -		node = icc_node_create(first_id + j);
> +		node = icc_node_create(first_id + data[i].master_id);

You have a few conditionals in the way down the end of the existing 
for() loop but then you hit this

         onecell->nodes[j++] = node;
     }

which means that this

     node = icc_node_create(first_id + data[i].master_id);

is not analogous to this

     node = icc_node_create(first_id + j);

So for any loop of this for() where j was incremented previously you 
would not _not_ have the same node ids after your change.

In other words dropping the j index will result in different node numbering.

Is that

a) intended
b) correct

Your commit log says "allow the drive rto provide the preferred master 
ids and slave ids" which it does but it _also_ changes the autogenerated 
ids.

So could you either a) fix that or b) justify it, in your commit log.

Also I think the 8996 specific change should be in its own patch.

TBH I'm not sure the autogen change is on-purpose or warranted and for 
certain the commit log is not elucidating on which is the intended case.

I think you should rewrite this patch in two ways

1. Fix the autogen case or
1. Justify the change for the autogen case.
2. Separate drivers/clk/qcom/clk-cbf-8996.c into its own patch that
    applies directly after changing the core

Perhaps you've already gone through this debate with other reviewers but 
then you haven't captured that in your cover letter or commit log so at 
a minimum, please do that.

---
bod

