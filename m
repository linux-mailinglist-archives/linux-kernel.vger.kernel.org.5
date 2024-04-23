Return-Path: <linux-kernel+bounces-155629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178FF8AF4FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27CBDB249AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2213D8BA;
	Tue, 23 Apr 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UR1mf/ec"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE813C9C9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891955; cv=none; b=HCSA3VWS+XCo20Qtftp/WHwmc2oyH+gOSZMxcMtBD26mHwWPxE0SAJUgqSQSYlCOhpc7hulvjcTbg2Y1WRTfgMsGYgrx9vDKFnuINp2BK6qnSfZwK/QHU3F17WQ1fn2lOHDYQqc0FxoeRo9cRnKZfEXF1t25t0fpxazKmXURa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891955; c=relaxed/simple;
	bh=cZfiLnwLrrCB4XhSu4sOa3jNqCVrSjDlUHrFtzpEUCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QA7stZ79aAav7E7koRFkMxM5tAY0iULIQtLAsijPE2f42KsHkpVQeBJbeSqv01G0N6bwa7ZaV+f24DOUiEW5Vt+/LbFmomM23+Sy1nNq62ryhVr7vCj62ThnFB6/ZOSvtJlnRvu5+gxDOLcg5HjuzD7HoMg+buaUbGDxjhRGZ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UR1mf/ec; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso424545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713891953; x=1714496753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOdb1YNU/eES1eqDg9jHW4pq0a/HP130WOY7nHDU8hA=;
        b=UR1mf/ec7v7Iu9ou9/YyWgOmT3xTCT9OFUqE70wvdnkEaNvvaGaOrkNtau/05mLlDe
         K3l+SbuylGjlF7iii1lv9HLZ3qB/4LccTacDg9FPGDwwzd9q56DfNne4Fc3pRFOPDR7l
         JqNBhSPx2wqfR39NWpy8agdqWhONeeQyg0LNm9glsBxTYVjChjnTL2s1lwSeQ4DWiuLU
         xwVidIJsNjS4++/fetmkyi4YupOEJl/J0zwfpaaz4Lzxh6aI8eoPktpKYC7lSo/7PNeR
         t4Sn5KQJfcaQU5ihl7/qzDKMK8A3UDZ7q9IQG69B3+41phJctdAeSx129iN4CRznyUpW
         exfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891953; x=1714496753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOdb1YNU/eES1eqDg9jHW4pq0a/HP130WOY7nHDU8hA=;
        b=V76DrcPmS7xQ/S+ASTbTUn6TKQjhjNM6UH9hgb/AoGR3wWBsf4Q82Md2siChTZ/k7b
         NmiZ2zdoQDejh4oZMql7uSjtVHuU8odK6p2sMVB6AJd0n4OKFLbxf8ZvChEYpN+LoLRx
         eyUwh+xTT49MBBP2VRvhK5EmNOqBsKecT4IAb3/gywkLp5uRBdA+Qhp2fZsTMAYa9Ep0
         ry3B3PZBKWf2rwHIqwylGXpAH4o5tV+3rPIcwee77nW2g/nOJnVvbi6nk5RbarEaki7G
         JDMWUEn4f26aTH9TVNABKr+6RhZLR/B9pCDDENHgskURx3UHerqqdd2PCeOwba6x8b8S
         maQQ==
X-Gm-Message-State: AOJu0YzYl+sCFeaCGENH1sfCcYZY1IdzyZZ2x0FM80s2cBilxq5gWYEV
	SuEAVyN6gVrawpgBxtyOVj9k8jnhLIHwdBlz+R67nY/14ypzdgHp2Z+iQEUur5E=
X-Google-Smtp-Source: AGHT+IFw45W7jH0R02fE4qNhgKTYnJVXBmT4FldT7BFoN5qP+VW+R8guZSnZcFy5BLVVdHWO/J2B2g==
X-Received: by 2002:a05:600c:1e2a:b0:41a:b42d:e6cd with SMTP id ay42-20020a05600c1e2a00b0041ab42de6cdmr52763wmb.4.1713891952706;
        Tue, 23 Apr 2024 10:05:52 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b0041aa79f27a0sm3735054wmo.38.2024.04.23.10.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:05:52 -0700 (PDT)
Message-ID: <284c2a8d-f786-47dd-8fd4-c2ec0919ebe1@linaro.org>
Date: Tue, 23 Apr 2024 19:05:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/16] thermal: gov_bang_bang: Clean up
 thermal_zone_trip_update()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <22273122.EfDdHjke4D@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <22273122.EfDdHjke4D@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 18:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Do the following cleanups in thermal_zone_trip_update():
> 
>   * Drop the useless "zero hysteresis" message.
>   * Eliminate the trip_index local variable that is redundant.
>   * Drop 2 comments that are not useful.
>   * Downgrade a diagnostic message from pr_warn() to pr_debug().
>   * Use consistent field formatting in diagnostic messages.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


