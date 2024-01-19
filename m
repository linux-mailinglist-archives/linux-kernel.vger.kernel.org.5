Return-Path: <linux-kernel+bounces-31094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C48978328C6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D2B1C20EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDED54C633;
	Fri, 19 Jan 2024 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c36eHIUj"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE854C61D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663808; cv=none; b=kWotkSvoFk4L9+uHEBgcgr8AJ6vFPx9Musb+Hifgwt5LNE7Dwh5gVEyeAEmPswVPCbNKwpXrUB/uTa2GqbuayHXNTmfpAcoFfQ5XXjFhVtnGbmpRxgl9ZzXnJSeBoFieXZSoZgtQ32Hb/MSk+i4DyNx9Lr6RnqPhnRNR75QlfdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663808; c=relaxed/simple;
	bh=ycObeh3kTOplxvPsJQvoz4NRPDs3AIyv+TTx70yn/rc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a+VGB2HW8TUkrq5T5iMIldaA3A1OJHDVhHBrAftiaghmxh7gXMvJ4lxvgj9/fdCdHPF6lKro0FnfkIkTyzMyae6OAm8JD5gl+QnPzxJxEI6u1LG+LQ6nTKviHHH8A2BHN5PcA4ziV6F+UPIzs5VeKZQm/j4oztYJygEw1ioW64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c36eHIUj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e76626170so7087605e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705663805; x=1706268605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySPxDNryS5ASfYRJDMll4nnGiSTqlh9txjSwMehzbzg=;
        b=c36eHIUj2dXiDJ7yTcn6lw38nvaC1dvB5/t1AoJxO5OiMO89Ju5YNUHdvSph+01wpz
         +VnMfqvHo+mZT6tuRfVym0qMUZQ8tz88ovABeNMjIe3UZlZO41Ss45h33i+/yzE8IqtG
         q4QxkybAnmRYAAiDbgImwYb1oxJWEKMm31QvFCpxrGwqrW+KqfydK+IVg0rZrYdr2C0G
         9OxqaQIixVhEqPRWEMo6kWacGIENPIrkfS+UKWjs/i4Qj02RGU3OhKsnlbqLYrKWRL52
         WMjQc5Q+twhmPFhy62WB4dyFU4TN+9B5yZm1jBa9+NdtHmh4FbvP4jyENbjuA2V2QCgz
         Tuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705663805; x=1706268605;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySPxDNryS5ASfYRJDMll4nnGiSTqlh9txjSwMehzbzg=;
        b=q8nNbOwgEys1pai29alZ9HshuvQXFEsAy+2gQFxK24pZ1l/ilpj3jZ4abJB8G1NlKu
         QO900T6+FLy/meBSOWPLyH5Ecxuu79VYwGkzejqej6SuBuAypyLdIzFBOh3wWF3m4egC
         6sQ4z3ag6UKhherWEfKvlp26OSY8o9t79fWvERJyybKJx1+CKJzDI/X35x0HJP5hotQ0
         tSPSDckkYzKvaImNhUN7jkNWSPrgvsub8GmejcoXP3jGkMmyTNXQ5Hhc+wkhWwoXPjUU
         2isLVRlKsQjLp9NdlyxSzD7Dn/jDnLTs4kwTT6KMmiVvIRHoz9x0diusvyUheSwKD3Rp
         y8oA==
X-Gm-Message-State: AOJu0Yw5uaxgLh5NFtSfvsfcAQzGoXoySi4cm0YuoxxISka9Hh/HpWNt
	ElJWMFg73ArSpb5saxsu7MdkB5DCxn4bkiC08Pqm0MHbwWCZTE72mOAIAZqRgic=
X-Google-Smtp-Source: AGHT+IHytkIjK1uUjP5dyPRB2d2VaTknqCDXrx30bTQY2P3ra4sBTGsqAdJNMcOBYcs6uDsMbh+jZA==
X-Received: by 2002:a05:600c:6d7:b0:40e:4a58:3c1c with SMTP id b23-20020a05600c06d700b0040e4a583c1cmr1650492wmn.154.1705663804748;
        Fri, 19 Jan 2024 03:30:04 -0800 (PST)
Received: from [192.168.100.48] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c45c400b0040e6ff60057sm20073664wmo.48.2024.01.19.03.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 03:30:04 -0800 (PST)
Message-ID: <415de540-5462-4ccb-9785-f56920b663f1@linaro.org>
Date: Fri, 19 Jan 2024 11:30:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: rpmh-rsc: Enhance check for VREG in-flight
 request
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Maulik Shah <quic_mkshah@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_eberman@quicinc.com, quic_collinsd@quicinc.com, quic_lsrao@quicinc.com
References: <20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com>
 <82e4796a-8983-4045-8ca2-71aa9af7a120@linaro.org>
In-Reply-To: <82e4796a-8983-4045-8ca2-71aa9af7a120@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/01/2024 10:34, Bryan O'Donoghue wrote:
> Consider removing the /* comment */ if it helps to apply the change 
> earlier than 658628e7ef78e8.
> 
> ---
> bod
> 

Earlier than 40482e4f73640d !

---
bod

