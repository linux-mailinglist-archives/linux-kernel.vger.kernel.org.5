Return-Path: <linux-kernel+bounces-60496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C798505B2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37931C21175
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6DC5CDE9;
	Sat, 10 Feb 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6f7HItU"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749815D463
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585775; cv=none; b=f+DkZGBYwLqx1X2RmXrkTBotW6Ne4L5Gw09Fg8sQogetzgi73Kr5JzTBfWb3KALvfEzxljQvyOMPU5NIq9qKzagf0HFwwWZkFotm403LtQbrIQ+R7My4Xqpka+4u/o8abxJtDBubFRO17xDmrgeZlG1fCQGf8MEvMO6b8mAiJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585775; c=relaxed/simple;
	bh=yXq0eQN0IMkM9OvgeuQdLA51FwQpaGpF9u82EJZYeYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3d2uGlA6Jzsmyjiz706HbC/09DrnJF29NMyCWNqccZnqTjwQ/roFLsEa+pu7PO45hW+ovAlRfFe7JSF7oqe3e6OrULNSlWfV/oSUWld+ZBBCYZ8pSFauPBVEsrhYoSbZv0lMOYbcO8gq2/8gUMuBz+MFWur6Jzl2ZA61Xu6MMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i6f7HItU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5605c7b1f32so2598297a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707585772; x=1708190572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbVwA3r2T4XIvj2MIMw96k+rlz8R9spHjVGSs/k39Oc=;
        b=i6f7HItU+0DN046QP45gt4uMVRhXO0IetetSq5eCVraBremVnNQPYhSXOimLVnw6Mb
         vFJ0Ofc8/37pSQXUHKVf9+D4uugL7fkUEDkE1p3LADOvUmdTvI88ToxGDLc1bx7nuGeZ
         rxVZPof//9V6OacIs1+9j6qgWp7+3JBy7R97JjJTPLsyPuMOfR0pK7lamUdRjRmVv+Hf
         eLWR51RAqmjsfcAl5AlD6rDIUOc8gN/iOWRXHl7xY7HXZ/GWbTuV2hu/7HQ/jNiC//TY
         8pGgbk5eW58LWPWtgMrGHwOFTaLxMOrRohze7xLSvaDIO7cr4lwCMhqAsSEmuUcy8wJl
         rKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585772; x=1708190572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbVwA3r2T4XIvj2MIMw96k+rlz8R9spHjVGSs/k39Oc=;
        b=vz2/D5wpsMSMWPBAfEhQzgKHeuhRjgdc1rKWwV1WWgQIMPnNXTuZYZTXbRHF0GZ1nM
         c8VLH2oXuV4RYIipY9ST3ivS+BdqBANUuZ1fllkkYG94prWzrWP3Ap9ZnYaf65IflOyS
         dTBLYalOX5JDhkSniY2DHLQlacH6vqG0WBGKM8XN2q2qaqUDCwz5fhxAJja/phXATXUV
         qJY9W+ILK9/Eqk6mPp27U5uaYy/q8pXAOuIgSacot4vWdDB8B0RNKXecQTSkuTQ0j52p
         0sLp/xJpd1gHUY4ihIo/Hl8elIJQhKK1G9O/Znq5QOuoXxlqlLhOmiO6sWMBjWahYyGK
         fmcw==
X-Forwarded-Encrypted: i=1; AJvYcCUPclf4fpHkWzu1gUNqMOZKu/6Ocf38goHzG54UlA4m3ZEXdeOAMzhuWYBug91WZfakd8v4v41PHM4i/BLo2NDhLN9rtABQs7Ged5Xd
X-Gm-Message-State: AOJu0YzH/yCsdS+XDlEEiBSnLFpD+QGBkH/sandaMuS4sl83dCDsav60
	fphAU9i81JX2ZU0suAWMHgmCI75exmd+Mocmzhr3yZ6vQCjXT/1AW4rodCwevYg=
X-Google-Smtp-Source: AGHT+IGjoZvwR/m5KuFRcY0hOSai9+AEivTeOhkS5ox7CXsFR1jLXzf0c93cLSctabNSd6vaZ6PMqA==
X-Received: by 2002:aa7:d60c:0:b0:561:b28:e61 with SMTP id c12-20020aa7d60c000000b005610b280e61mr1685777edr.31.1707585771786;
        Sat, 10 Feb 2024 09:22:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQ6Yzt65ip2g8FNsleIQBI8vTw+gpSs7VD4tpfkofMR/vl1KFjfdrfMPnCkB9feLjhvH2AzFXfKMGiNoEhhQASy2iQRWeMBDDqXqLx4f1ls19KQ6M7q63LqgfPgW/UHajaBHeHh0kqvozVFXJEOZdId5ZSrmDJGG3dJ+tS9E5Wz9lSo5GyDAl3JwROeg3kG6Gu79dJUEla55Ej6Al1Yl6jn4tfnMuE2W3luEYyDCiKSHe8uTsUUsWoZzoAcEaqwwdkVlyi4KOSycGVoKISNujC7+3LyRql9j2B0t0ip1r/fM2MJcoz/ROsfeGBt2rcTSI85+E2h9EENBm/BB8G/SJ4rTyuWYIp8tuXkkXih/tTLi63ABxf6Gg5UbWVyNXE5OjXd6S/c4ocjBPdZdlZ2ttHQ1Fe1l3kcBhJCtvwHhcl
Received: from [192.168.1.116] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id dk21-20020a0564021d9500b0055c85e6d75dsm922314edb.87.2024.02.10.09.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 09:22:51 -0800 (PST)
Message-ID: <d0c8fdcc-bf1b-47cb-9d34-337c069cbd2c@linaro.org>
Date: Sat, 10 Feb 2024 18:22:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ARM: dts: qcom: msm8226: Add CPU and SAW/ACC nodes
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
References: <20240210-msm8226-cpu-v2-0-5d9cb4c35204@z3ntu.xyz>
 <20240210-msm8226-cpu-v2-3-5d9cb4c35204@z3ntu.xyz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240210-msm8226-cpu-v2-3-5d9cb4c35204@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/10/24 17:28, Luca Weiss wrote:
> From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> 
> Add CPU and SAW/ACC nodes to enable SMP on MSM8226.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> [luca: update some nodes to fix dtbs_check errors, reorder, cleanup]
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

