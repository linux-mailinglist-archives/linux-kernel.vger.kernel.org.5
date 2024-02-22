Return-Path: <linux-kernel+bounces-76754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818E885FC04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33AD1C241EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEE514D42F;
	Thu, 22 Feb 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vs1ERfnh"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C6149002
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614816; cv=none; b=HSpbPOnBvQuZBF0zFgVaWajxc9gODkGn/SeeJKVRJaS9yTU136zYth7EPWCXzrDf/oCl0GJ5KAXJAl6NF2CN5HCQ7yWyVawMmDU5EVq3G/WB2s08v403oH5IaMcK916GknFNnL/OwBkysdzOJuJ55+uXaV0WyWS5Ee43fzzxyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614816; c=relaxed/simple;
	bh=GZidnWS47bN5w/RNyjF7xozLnTykcDoh+67IYMboy5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVDNoi15v1qhGxe1yqv2uc839ZOfNzAm6WCe7F8WRq22AZWrNz1omQkb2c1yXZVQFmyjsgaofYom5/8E6tz72e+S0F3yFdEPpMapk8w63X5uxVtSKi58Is3R4CYBna2dVydUpxOoZne/nNCosYrCUPxKffkGBaq1C5X3+GWbvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vs1ERfnh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d36736d4eso3665781f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708614811; x=1709219611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDJcfOimbHdFhf6ZpwF6LYw9oBwXpSoe7/s5ojrCCAs=;
        b=Vs1ERfnhkOGrgBZycSJA/OejT1/3kSX836W1CJoVwE+fLdpxbxTpB8zwlZUs6BywMb
         I8xciIyprCP6gXVejX6nP6KRzIYyQLm/aEveoor73dwcMCSGS+tnd24NR+bvHE1qUpeK
         Urj1W4Y1szm+bt9GOAWEpx2nW4WeijpPVyOd/4efVhmCgk2RxbNOrwNuOVzBBArx2QEb
         iVz3skzVDQiivvYVqIOctaMOGLo7dCpF0l6x/ZvpJzOuBcs1AeuU79nb+pyuqzagenZf
         XgsYmY8v9zDjTaSGU9zBHCEtXiZ3hg89qgFBSfwDgEE6wEPxCpDOUF20i7KFenec/AYc
         98Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614811; x=1709219611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HDJcfOimbHdFhf6ZpwF6LYw9oBwXpSoe7/s5ojrCCAs=;
        b=gq5Z66BhgW+xla8MlaDqF51em5rgduk2h4F5yb7wn/J84K6ulX0ak+1E2xjxKeFP30
         C95/Sym+wEgYZYiMASrtPbNMgFok9+y7XiszmuzwKMOuidnz6yMIGtCDvTydwPwEl/Dh
         UzHcfrKZsh1IgIlU+I/eHugsfWKAy7prQxjKhn+j6taWbOiIKu0ro1Y/xZXx7QcKO6qr
         DXFhm1P8TQSC++pFwkITeGN0yae7kNL7a9ktLqyAmDEm6ZKmfZnhdGcQaWtHgnKXszA3
         m4moSN6oc4QSrbMraEvL3ws+6FyQI+uuZ7zCcn1G8kT/nOCj0CbmGObCksQ4NyAag+CM
         +a/A==
X-Forwarded-Encrypted: i=1; AJvYcCX/ByA6CKpBAH3iGuYbTnQjb5rhWYAUdysYt2BChBCeMTgS6aOOfCRA2D3Ywm+c/JdBeah30oCw2fc7eOyXmkESnS+ef1woQj9oYZkp
X-Gm-Message-State: AOJu0YwVB8Sc//PLzH+dQo9sfoVgc92Cvl3F2VKhCU95gzyMSiFN+8nO
	nTMAFmBaPKZNGmc4hVxRfFvNVFppdh5NKW+LaDEpbmfqrRftOoyj76alXlkoO/8=
X-Google-Smtp-Source: AGHT+IE3wROdfA+4GtinIm4J2aTgvzCmm/rh+JDi/HVfmwprLNADV9gOi9HjTbVE3fICbkkKMu/Y/g==
X-Received: by 2002:a5d:4fc6:0:b0:33d:3fed:6531 with SMTP id h6-20020a5d4fc6000000b0033d3fed6531mr8520211wrw.67.1708614810965;
        Thu, 22 Feb 2024 07:13:30 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b15-20020a05600c4e0f00b004128f41a13fsm369363wmq.38.2024.02.22.07.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:13:30 -0800 (PST)
Message-ID: <694c1a7e-f41a-471b-9c73-0d9eafe5f573@linaro.org>
Date: Thu, 22 Feb 2024 16:13:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] mlxsw: core_thermal: Set THERMAL_TRIP_FLAG_RW_TEMP
 directly
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <10417137.nUPlyArG6x@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <10417137.nUPlyArG6x@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:35, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the mlxsw code do that.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


