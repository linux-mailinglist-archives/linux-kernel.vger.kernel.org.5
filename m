Return-Path: <linux-kernel+bounces-132655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9A8997D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E96B21343
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131F21514EA;
	Fri,  5 Apr 2024 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="artZWtV9"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0D15099E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305864; cv=none; b=Ibzox6IoNLaw6SFKq6Js8A8O62auNiuz2JONTiBRo8AeQ5map0qxuENscy/iMkZrxSV2rcSDk72FbmldEuImXUr9zhGlAHguhFG8/LR4gM+g//YbwzZ28FJY9rx/zo51MX62nOq9s0RcDh+awgwhiXthDfxCdEYUO9k9z/EoIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305864; c=relaxed/simple;
	bh=yxdBB10ArDmSlmE0g0r1a9LmbtngWEnM0SlxQmAvBY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkrvrYbgE9WOO6P6jmPj31nfpAPmG55eWxxUpv05wizRtfwZrn9Abcc/UJs1DAifVw9be6veMEFFu+0y32+AHhCmvVhhmAXggOWX9c4DT0ocb5y6SKFYjtLACrCQSB+G9bBYX8h4Dt4dEM7Mhrc0nciie4j9LNH68qEENxXbR/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=artZWtV9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-415584360c0so14873305e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712305859; x=1712910659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+yiJOo7/g4gpSdzIrOskjwlXwHDi0ApeHqIT18FSLE=;
        b=artZWtV9YaxV7ecokOgz02QMDGSdua/wB+XoZK/eo3Vh/wC/1cWYBFhS49mM6AhauJ
         GOK6sF+0LTqD+mGqqUuBVuN0RA4ArYbsCsK9XepqP5jjlhM5FHX+0jGZob3uHSgnsHYQ
         11i6RFzuV6mEHKmegfFRkjWqsTIPxE5kG8479OVelXnqTo7Kp3NPmXxEvVpgFDZaTJ85
         QpjyogaqcyZlAIt6Zfu6cy2jKxqAEAgz2czKwUj+wZYsRmyorpa0vC+se23o7jrZ1WT0
         pA8sbdVYL/6FEWrm6bYf64DNNksStpTGatQddBFEsVoFu9QQ5NXW/p27/yVaWokBemL0
         EiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712305859; x=1712910659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+yiJOo7/g4gpSdzIrOskjwlXwHDi0ApeHqIT18FSLE=;
        b=BKt4dgdl0+4g7CMjYYaLFIGClXzM0p7YUJe2f1rxWCII0oQmlZm/Ntdv9EwOqAa7ue
         W7TtNEpP/yUrlX5/RYuhgSj5BwMFLsceAZydgPDreOhUlG8LO3o2f+Jasa01QesJut+6
         NToZCL9pj4eGKb2Fx7lDfspkmbF5lu0JiWbAuSYPx8hIUhbhZoyenzpY9/LVEzSxlquf
         /GAej7AWQKYoGBQW28GSVYYyflpS7imOJvdxtla76r6CSxpfUlM8/XV+owMbYuLMDC6J
         MqiVmxfeIMJ6AcNHOAFDatg39LmHdWgt7LHb/OR0NmTRSAx3pnXmu/yhVivcaUXjxIUX
         IbQg==
X-Gm-Message-State: AOJu0YzXQKHGKYzM3vjs73soPDQzZ0MC5rqeuYe1hSk+a/CV1NHTwzc5
	k0Bbfi058gLLAEKvmkcIvpffHj4u5x8b8G+/g0bDzbsfTlXoZK50bjKbcZHs02E6daVHe9uNuxg
	Y
X-Google-Smtp-Source: AGHT+IHwzZg6mqbOsTet1vE1TEWA9BHTjUj5nkdl33/YZd+0KsGS7zI4vNLvez40dZEnn1sQDzcRBw==
X-Received: by 2002:a05:600c:1f93:b0:416:2a95:6e8b with SMTP id je19-20020a05600c1f9300b004162a956e8bmr572430wmb.26.1712305859037;
        Fri, 05 Apr 2024 01:30:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n8-20020a5d4c48000000b0033e7b05edf3sm1446622wrt.44.2024.04.05.01.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 01:30:58 -0700 (PDT)
Message-ID: <cf1ad84d-3983-4595-aeab-e421bc1f95b5@linaro.org>
Date: Fri, 5 Apr 2024 10:30:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] thermal: core: Rewrite comments in
 handle_thermal_trip()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <4558251.LvFx2qVVIh@kreacher> <3284691.aeNJFYEL58@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3284691.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/04/2024 20:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the comments regarding trip crossing and threshold updates in
> handle_thermal_trip() slightly more clear.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


