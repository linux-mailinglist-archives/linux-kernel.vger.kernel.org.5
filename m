Return-Path: <linux-kernel+bounces-35880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC6683980B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2311C27388
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1BE82D8E;
	Tue, 23 Jan 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="saRQwZzb"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE981AC8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035353; cv=none; b=KzmoWpYrvZ0DBctt8IegF6A0qq4PhaKtpgN3Nwfg1wKKW1MO82k1RJIjHYp7iZh0SYIozsgtKxvuJuTaHjR/v3R/HdIwp1igo6Xmvn/jFDcVvTgnmcX1T0wud8YyZG8NWWtSbRt1ihCt8Xn+5Rg15JZLmhFc2rOZATra/sDpcsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035353; c=relaxed/simple;
	bh=lOlGlh6X349aNC5GuDUfgVZHmOFNRhSYOwVnX+TNSDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emHNg3IdFkTo06aWoNThEmgy5vbuUggRKO/3FFgeypi5s1KNZSy2pYInrAwpJaBxIVUr04+YgubJNcdjloB+3c4CqdkrV2Au3oK7C8VRlSgFDzmXksbTjngx9cbUc1WH5L/pK5m+gzNZOwEafsWLHxBfOaAOJLvmSTI4PV8bE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=saRQwZzb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50f1c524010so4966364e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706035349; x=1706640149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6EjMPAHtaQ8hjurD0Wwpn8cJ7F+mlxK/BDZ6aAcgP/s=;
        b=saRQwZzb2jEomFhhp1P7YDb4EMNZtjDQbO3zeIcry1SEM5P+2aJa0vYhVnNWDvQP3r
         1kIVqUtz6LIasgNtbb/7HcnECWfeffPEju48FrnzihDWajEdAkWNcBAydpw73baGSPJN
         W9PefTxYENKcauU9/BX7lFAlxXAVdqpc/JoSt+mz56widgW9vkKucwD0e3X1GLhK99OO
         iQFvo8kqMMD0Ld68J5Nn5aI+gaTWNcN8q+3aYv7ciA7eSfCjut0wV4zV9X/yWr+3c8lD
         NaRH5MuXgTqQqlTZohCgHREoJI/Le2Y+QK4sLaZEGyjYgSz88d058cSDkFDaSdbwTCID
         zYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035349; x=1706640149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EjMPAHtaQ8hjurD0Wwpn8cJ7F+mlxK/BDZ6aAcgP/s=;
        b=G6BH6KQdua1sitcKbMFh15u9RQpxu1wbRVYkOEm5qHBfh43qiWCTxHn2I3rwlQ3tY7
         33OR3hbMp+VXyKvBF8v3VjKOMyVxsiUdECCAxpCWrsNqkp3Zm7X+XBsvuVMecXkRoAsH
         KuEfcYlhSt5RaBxcT1buhemmvqfC4fgvMJlsuCQH3kSZo4+dxoamHSU3pfizK0vesHRx
         rYGHU8cnf2FcXFd+EHioEyH7UTtmxBQNeV2j7BxF07yuMdbbU/vRqt7XZOmdWpR98JBh
         XowlNs9jixSJWJkheZHrCtNageV2dtqgqpsO9tMy8a9E8igK7UvaIFYtqJgPNJpW8BYV
         Irig==
X-Gm-Message-State: AOJu0YwyYZGAvhEbR9MRoTVcNZi73hBPw9JN5XGstozCdDZicN1DtoxH
	nMOMcDLBELNooobYtZnQy7U7rEOh5CD46WMRPaBfcC8UMHve4NOkOTcrmyljWLxB/O4/E6q5LIF
	C
X-Google-Smtp-Source: AGHT+IH4rZ9jLHR4HLcdTKeh97zjQd2g5iE4sly5QEUhYVZ4fYd8HkX+9LsRNA5CJ/Yt+5J5MGok/w==
X-Received: by 2002:a05:6512:e8a:b0:50e:d9c5:199a with SMTP id bi10-20020a0565120e8a00b0050ed9c5199amr1707051lfb.25.1706035349242;
        Tue, 23 Jan 2024 10:42:29 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id ep26-20020a056512485a00b00510091c44a6sm40347lfb.165.2024.01.23.10.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:42:28 -0800 (PST)
Message-ID: <97589847-47ec-4012-ac07-7ffb85c27637@linaro.org>
Date: Tue, 23 Jan 2024 19:42:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] iommu/arm-smmu: add ACTLR data and support for
 SC7280
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
 <20240123144543.9405-6-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123144543.9405-6-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 15:45, Bibek Kumar Patro wrote:
> Add ACTLR data table for SC7280 along with support for
> same including SC7280 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

