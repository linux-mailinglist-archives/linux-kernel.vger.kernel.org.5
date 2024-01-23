Return-Path: <linux-kernel+bounces-35879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BED839805
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C41228E43F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087A182D65;
	Tue, 23 Jan 2024 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZD/nwtfW"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D1823DB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035333; cv=none; b=ptOr21RZ97+qHF0eD3WnSUrjJVSjXRFXUY0LNVpT/+geRa+y0nDhEI+OryTXPZ2wg83UaMQp6AVgm3MPNxpEoklC5e1OCX4jITqMYI5IE+b9lQnK7JtzdJwhzf1yN0qC8RBC40jOzAAZ0ehlo78ZsvV/uuekKDfNI9CEoXcLm0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035333; c=relaxed/simple;
	bh=jYLyxNEUsjD3oHw3RfCJzuYV90CU0PZCraZsQjrd19Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvBSqLDU+EhQ0g2UmnMIA1WUe7fxhGowdatKLhsBeuF/XAKpJjmVCgY2N2mDxyEIt3Ug4n3EZaYzip8b5pnuAev3LWd+l2sge0+wKosjjWmWijDxvQWTi2ZdLWlrha+DQ9ckRCUMbHXJrKeEMlviLvp8gEOkV28EkxzfGq9hECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZD/nwtfW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso5149167e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706035330; x=1706640130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzsTsGczKI6Xyfdy4MTULSYbNs/jLsDoqBb/j5tuTTg=;
        b=ZD/nwtfWSVfMSfWLJZjx9cUGISmdJnJU05a7nDe+4/CkvN6pL8Noi3N0qRZ0W+UwLA
         JvOU5jCdnh5JP5F4Tdabkxy0HUmQaq1vCJ1ijG/1o7wbuGdHcy/BCg27nHk77YcSljwR
         gB/0ldnH0BZDsBcZ0dx1/LMGlB/UiHmMYVdDkXyqZ21Nu7kAbifQSZ6MV/0X6ahbWN8U
         jsuNGrbKyV+4YEejCfk5gC/E2RJXncnW4JCv1zzxBU0kQ3K3db8QIWQlQTt63JWmKGn4
         JLTAv8c+yjjGy6q5dHZMRPmoel3P16qxsOIoBFES8FRf5ssQ57inu08tlhPAgzb9La/V
         1E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035330; x=1706640130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzsTsGczKI6Xyfdy4MTULSYbNs/jLsDoqBb/j5tuTTg=;
        b=LVlUV5qUra+ONjn6tuI3ol8jg7sAqZBgAjV8aQddGzzeovnksmCO3hVh+avqifvkqk
         /1QmSMO/+UG8EN6BMie+jy1dbMKq7sweVBRpMdPQS48brtDW3qf34DDAdW9/JALjHGcE
         JDOxouSicoeO1RE8OuXKXx3kLKFjDB0+bR4ApIC6Y8tRo1SmolGtWryV+wg8tthDKEQ5
         bBVswjwlJWYKcs3/vfcJLakhCFxm9NGhvROpSMHBAeYxAZNY/1BrNWmfPlsN/UUhwHE5
         4ydOUBHCQiU5wAPjgn2ZXzM3Xn9tQFpveADkH50xXHlz+5IJxn10QXSppFbvLPxYW4QJ
         b24g==
X-Gm-Message-State: AOJu0YyDWYRNcq8lTLOULFM4+AKpgUJUTrJYfeNXgDcyD6dFyAhB4yGy
	iobFY9ReZAeqqO18HNYGYTBQrIHLNEZa/sd5fvU5GWzJZZpA72r1C1gWGtklqRo=
X-Google-Smtp-Source: AGHT+IGaEnFdqksia0Yy81wIZbaYWiYzTjjDrfLdKLLyXbeWrgcxmcdx+hLeizeeBQyBYR7z+QJLbA==
X-Received: by 2002:a05:6512:b90:b0:50e:7c70:fdf0 with SMTP id b16-20020a0565120b9000b0050e7c70fdf0mr2913447lfv.85.1706035329800;
        Tue, 23 Jan 2024 10:42:09 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id ep26-20020a056512485a00b00510091c44a6sm40347lfb.165.2024.01.23.10.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:42:09 -0800 (PST)
Message-ID: <61730f0a-bed9-4755-9c47-1bd2044176ed@linaro.org>
Date: Tue, 23 Jan 2024 19:42:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
 jsnitsel@redhat.com, quic_bjorande@quicinc.com, mani@kernel.org,
 quic_eberman@quicinc.com, robdclark@chromium.org,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com,
 quic_pkondeti@quicinc.com, quic_molvera@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
 <20240123144543.9405-5-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123144543.9405-5-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 15:45, Bibek Kumar Patro wrote:
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

