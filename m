Return-Path: <linux-kernel+bounces-76333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AFF85F5B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BE11C23DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D03F8FD;
	Thu, 22 Feb 2024 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDvvYDNU"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65273F8ED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597704; cv=none; b=VuZDfiqebRLpNYuJYsTpZRzSak5zPIsI4XbzMfec70jr+9QjAH8s6bTDSZQPXUL4itPW65Stf2GAS4/BekJ5PC04NafPH/YBGCGBfRE1RRSNy1AAPO2sdeQ2fnZjFvcYYNrMShykrsnLuifJnIIoZK7ziiDT0lHJTtrfdaFJyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597704; c=relaxed/simple;
	bh=e1Nf+e6QJOb88993HOv4a91YL5tPMYCzJk2a1amXTMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTHcSYgV5PFQm+VRlwH+j/mSbuBZW/rYigrZfo8ppeUruNMKvOIOiwGwFBwM7ICSr8JfI2PAnxHGno1eosBy7tWUezunJ+VFz8RjVS5FhppCAQzXNdbQZ5eg26aff/63lCnMh7GNiH8yImJCGRugBy1PvOu/lVr8ykG+fAj49EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zDvvYDNU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d01faf711so4933498f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708597699; x=1709202499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2dv+kRmhG2H1KzIBT+MOGitjcmQKTmnVtmgNOX7NH8=;
        b=zDvvYDNUOigd6PX2cmbfo5PZUdYexIsTAp65NMHGG4d79idVU94oWDtHQMV/sgUTUP
         sO0eVjXLz8bkICLmJrYrbM+uGbACc0vRRMCTvt24h9CwXvBcCl8EHgBOe9UzyvAyz7jy
         BobfgA0iMSa9BF6bVmNRmVaWtOtiBGxiHfOYu2lvftTlIPM/9PUq4hRkyuCkzBzHHiMW
         5eWhTD+xb9Ia+KrAJFUVrDHqz/aA8AfeiTiNqWmWCJcOT/0/gTDr/972jtGiLUnhNfww
         OsOuMpLXc5p9trazEHNhTZZw1o/OgGJRthlZjbBuCAc8B66k0wdA1cIM8PyKpAybgbOd
         apwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597699; x=1709202499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2dv+kRmhG2H1KzIBT+MOGitjcmQKTmnVtmgNOX7NH8=;
        b=cNzP34sfW8q4WfGR3jPNEiPIASQCWr0AUrxdlTdcvyD9qymWxMOt1aVLlB8VQKDwIG
         ajDXQauNa5oUdw3MNUKSuGYAbUxUGvj0m7uGh9vYZVZ6JeXxtmVtKLPzb1ZvZrAfq/qZ
         s3k7SfWYZ2jlKs1/rFjcttCoaBeb1rWC9LaH8lzWgtoFou1udVjTqeRAFTEWAFR2jUCb
         dpwmg8BeV3ekEg75cf2moXd83snlMJ+6M2wmRfUQ2W0U9ni5OsBNKUEHHXf522hIeZ3I
         NRF+xyZ4RkJ5nOJ1VeL92LH5qSFumyjeiFFqW6b08FEaAfnRQDkTyx0pQBYCnGW8oU+d
         zETw==
X-Gm-Message-State: AOJu0Yw5VJ6qfwh4LupkJDLQpdsVVsKUqp2qJErJdrbvvwEnQyrXW451
	LCkdtwIijtyx3rj4z6Bo76H8lQTbtk9KX1mXXWEELrG22CjH1Z6q5xcBy9k6mVI=
X-Google-Smtp-Source: AGHT+IFsDXoJccsFatQLWow2/gzhs6hnmqbEzWti/zh0leKEGUX5CqBgt0fzP7VQ1mTJLDRV15YYgw==
X-Received: by 2002:a5d:58cc:0:b0:33d:3c58:7c56 with SMTP id o12-20020a5d58cc000000b0033d3c587c56mr8240810wrf.54.1708597699137;
        Thu, 22 Feb 2024 02:28:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bx9-20020a5d5b09000000b0033d202abf01sm5124036wrb.28.2024.02.22.02.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:28:18 -0800 (PST)
Message-ID: <71157ea2-23bc-465e-89e6-2161dbcc32e6@linaro.org>
Date: Thu, 22 Feb 2024 11:28:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] thermal: ACPI: Discard trips table after zone
 registration
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <13457348.uLZWGnKmhe@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <13457348.uLZWGnKmhe@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because the thermal core creates and uses its own copy of the trips
> table passed to thermal_zone_device_register_with_trips(), it is not
> necessary to hold on to a local copy of it any more after the given
> thermal zone has been registered.
> 
> Accordingly, modify the ACPI thermal driver to store the trips table
> passed to thermal_zone_device_register_with_trips() in a local variable
> which is automatically discarded when acpi_thermal_add() returns to
> its caller.
> 
> Also make some additional code simplifications unlocked by the above
> change.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


