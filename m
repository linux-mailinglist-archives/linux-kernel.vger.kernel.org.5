Return-Path: <linux-kernel+bounces-93967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A7087379E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327CC1F21111
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46163130E49;
	Wed,  6 Mar 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjSmJycj"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C5130AF2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731250; cv=none; b=ZpliKFOExtZeirXal9ZYeMwSjQKYEVqzly4l9kzueD7e4Nd/9h3oU2BaIRdA2WkiCdBy8dcDckRBHVdw/lIVX6zLMPV4Any5fQrJgMgoYxv2aoUTuHuHyt8Em45rz5+O9fucTDNfD3p730AgJqqj/4S0pTk8XHXhnRAXxKi85Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731250; c=relaxed/simple;
	bh=nBs7TdXFCXnNJZ4WHVSS4j0C5NzoL0MpmB4YFyPNPK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWI/EmSmbxmAwv1G6gXOaowgR7lH0zRNAWyPjXVGct9N+qAVzw1kz+V8UsK2dg7LAEZ2kd5Ffp85pwTF+mbzz3zApbM/XlDMweOF6No8O55ZbNoEFw+cdUQdTUeBZi6aPR8RUc/f+Gd02B3rIR/i39giZLQ7Pvnm5oqak6JwLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjSmJycj; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51364c3d5abso475540e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 05:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709731247; x=1710336047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGafd5o7nTif4HlzBCMz5R0a3iIosjRD5sBkjCzMzNw=;
        b=bjSmJycjbqj+pPwJQ0nL1b++KhAuzHwfPshGUQszc+GTRjtpm6mUTnurdwNd9WNT6k
         lt5WybrFL3lyZM94Se0e3Uzk2VTWqZV15o4rb0DlOKrZL2FX0uMSIcQMxO7LmGOYUXfl
         pIRzJJKh/fqDfH5H6LZYSnrx+pCsls3Gu3+O4eiZ7fASPRhFeioDOH1Zzwcqrdz4+pf/
         Rk50N0a9cXVw/JBs8iyM50wKeuphEYwFmbON42oDekX8KjL1b6qDASOLpkRkRcdhrxFB
         ViBtNTS8fGx0l38q2QSCMhd5HcoC0UEhonGXFqxufNCQDdgRh7aI7XyynpdacpM1CPxp
         +XZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731247; x=1710336047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGafd5o7nTif4HlzBCMz5R0a3iIosjRD5sBkjCzMzNw=;
        b=RTqxl6ffcd97JosUuZk6CBUu0miemec5TpKYG6Cc+C5mUfi03/qEWr7IFsprIEcVn1
         1QP6GJffK3r032C527mY8I3gB2Z5D7AbjUVQOlwVSkQvqmKY+cR9rRWPGGqFCgsl7bpA
         vqbPKkEbV0oHxpWtSk7+q7DkoBpRt9iWY8VzjLHFj+tOaWxqsmyD77HsirMsOybxXMSq
         dSvY12Rvu0cpVTx0Y0RCsonlfQso/cutZXrAmQyj4SwsDdamu0HFPTbf1KJ6xIJCwHUX
         St4wK9LluTjjQVJA/C8RursbCCbj7fs8aEmaeKSiMfMTM52WHdkAl17l9e0E5Nvic6a6
         D00g==
X-Forwarded-Encrypted: i=1; AJvYcCW44SaP2kcrRmD03zDZ6S24pO2F6INhxhgU8lfSusFCE005XNSDfysexYvsEuFh3dwzrFZsL9NQ8YRGhMef7YYtknRJCWoBnTJo6xvt
X-Gm-Message-State: AOJu0YwRNyqzD6wpEWS5pDS25ce3mrwVyrtT7+KBM4z40fiEb4IwtuQY
	+AczPbv6psAY49/pTsPE1Kb4BcYb5eZRbW/VVCA9o4nsH27u5j4muTQIRkKW6T4=
X-Google-Smtp-Source: AGHT+IGuzcOpnnYGitOUKg0eIcpax1P0SCRnafBWI5CDR1GCfMIip0nEjhzRY5duyzhvSfqpYfKUzw==
X-Received: by 2002:ac2:4158:0:b0:513:46d7:f85d with SMTP id c24-20020ac24158000000b0051346d7f85dmr3585768lfi.38.1709731246777;
        Wed, 06 Mar 2024 05:20:46 -0800 (PST)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c348600b00412f778c4e3sm1544564wmq.23.2024.03.06.05.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 05:20:46 -0800 (PST)
Message-ID: <10ecc833-2abc-4396-8789-aa4020df7336@linaro.org>
Date: Wed, 6 Mar 2024 13:20:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/20] media: venus: core: Remove cp_start
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-12-3dac84b88c4b@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-12-3dac84b88c4b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 21:09, Konrad Dybcio wrote:
> It's hardcoded to be zero. Always. Ever since msm-3.10. Or maybe
> even before. Remove it!
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


