Return-Path: <linux-kernel+bounces-32993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA08362E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E891F247CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30953B1AB;
	Mon, 22 Jan 2024 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvK+Ctf2"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC163B185
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925773; cv=none; b=Jux9/UHdoO3DEpAPr0Ycz58SetzwbbuawRNOrhQIq0gPAt9KMiI28OgCIeg9Nix29c0dxvJUPNiMNRv9hbGCDtUmJoMFr/RZOdcRzz4q2kTWzVjO7K8oJvDm2rQ/MBS/zM8WHsjUFjcZDCqoLIArYPypwDMAp4trcMyqUfQZELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925773; c=relaxed/simple;
	bh=xNWPbodtQ9T0vN6GltcqdPEiZfmJjp0daSBiiWJEc/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t41GEgr6I3P6GQ4WTHMzPQis8sAHgE8K93y1lvy1L3SveKceGL6WXfXL97o1NwCULepYnmamR/zw/vt2PESN9+Zi0IE+18a3XtLMxcLmgjzNh7752SIeoGx0U/Zh28g7pxZ83AFO8nAFhxqfqhagNqXM6Iq+CcPhuWFvHoRVbkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qvK+Ctf2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso37325355e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705925770; x=1706530570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpW61aGgXRpH2FMku4Toj0xfUJGLWKFyCTfLMNYZlmU=;
        b=qvK+Ctf2u+t9yn+HXSyutr1veC79g6MCn1i4xbl7psmZ/IR1hIzVP4jl7l1lWubPAi
         x7hukSh5dIO6vJPIBLyP+ped8UU2WLTS7oHLuQEPRPBsRQbhnHi/aha1RQQ1FMj47VKc
         zQRCRk/MjHqMW9MN5YsmuqS81UQF0ZVrQe1WAGMUF4zOTOk9tCCZTgvRLU6YSwS+q6YO
         ZQpbX2lZJ81AyjLJX05qJ0I4xye0fsjrdLV/TNQqUfjpWZECgJxY11okBnLJ+6ESIdV6
         vFIA2AbAFZcCjLstEANHFBirXlxUyu31fciJlA7CBIXjxGpMGWAppWml3+oXVxpy8jbg
         r7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705925770; x=1706530570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpW61aGgXRpH2FMku4Toj0xfUJGLWKFyCTfLMNYZlmU=;
        b=T9uCe2ruE6c+VLMt9ba/FqhDLFUMvPZOJlMEt2gMpUW26hjBXhwD4C5pe9nl39ENXB
         +LamNHu47cg1994bbOCTbnu5AlEVOeM8YNkJfhNy4c8HZNYPb71hbS2LAK9qpqVQ/FNf
         SGDq7GUwsjHV+tV30ZP6NDLwCJYgsyaCIdKv1xo964JszISPBR7+WHqb4cE5uEjnjRc2
         3I4hibo8WmUCOqad0R4dSQdwIhd/ZoThz+SGoR4c8kbMjgw3jCcVTMSkqlFcgYfZVW8l
         N6OBLVxgdSZlvvfiVpnF5+vcTmVMfeWklv+gQJkAo1NehZ8VZe4zwPRvNT+0sCcoGEIr
         aS2w==
X-Gm-Message-State: AOJu0YzGSUsl/tVmNYLtY5RozQ4058Pvfl4hoZRCySIOHb1bL7Wcnxir
	MPpESKjl0hDs31TtKrFtJL7kJ9rtpxaCJctnqDaf2sZhXFHdxsGbaUiT9V9Qwvo=
X-Google-Smtp-Source: AGHT+IES7d4z9U6TGxHRSc/cjcO6+fJK+fqx08kexujJvJuE4IU9gnqzaWqVNLMFIlYgDIZ6xmQFSw==
X-Received: by 2002:a05:600c:3d89:b0:40e:866c:e96d with SMTP id bi9-20020a05600c3d8900b0040e866ce96dmr1496117wmb.69.1705925769747;
        Mon, 22 Jan 2024 04:16:09 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:371e:2a86:62f0:bc48? ([2a05:6e02:1041:c10:371e:2a86:62f0:bc48])
        by smtp.googlemail.com with ESMTPSA id p10-20020a05600c358a00b0040e559e0ba7sm42581477wmq.26.2024.01.22.04.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 04:16:09 -0800 (PST)
Message-ID: <1567c194-f431-433e-9cb8-b0c407061130@linaro.org>
Date: Mon, 22 Jan 2024 13:16:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: stm32: fix all kernel-doc warnings
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20240120173615.14618-1-rdunlap@infradead.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240120173615.14618-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/01/2024 18:36, Randy Dunlap wrote:
> Add a "Returns:" section in one function description.
> Use the correct function name in another function description.
> 
> These changes prevent 2 warnings:
> 
> timer-stm32.c:79: warning: No description found for return value of 'stm32_timer_of_bits_get'
> timer-stm32.c:189: warning: expecting prototype for stm32_timer_width(). Prototype was for stm32_timer_set_width() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


