Return-Path: <linux-kernel+bounces-70347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB1859659
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125EB286D2D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C24E1DA;
	Sun, 18 Feb 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwCnnCM2"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814692D781
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252504; cv=none; b=DNhgK73xjbOI5rZA+7+1swjzOxFgWVyBlIm+AhPPIsynLF+nhdgRM9uVoJhLxrVW04RRUfxMiHeQcfwWscOOHJoQJLg+XPNA5kPFKBQEEgF9YHmt1IPVsv+If6VJEI1q39LYtULirsPH5SfkWq+JTlB4fbx3kluursq7wZXyttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252504; c=relaxed/simple;
	bh=TJFFmm0tNGYJ16tW2HX/PUySMw6vKw8xiB7Xdtc775k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJFYLKhzlzZ3NOH3uyQrDg8L3/jJJJpR72Jg44vuOFJS91hZNnCneXsuY3PY3T1qQPXTU1AVY3W5MexkcLIUJO3Q0IRFkg4Hg26nBqaFfBfKpDg+EoJZillg5ctFhOr6lnnS/S12JGs1i8ZAxIg3ZApDYi+ssdl9MK+obvPd5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wwCnnCM2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2999329dfe7so100680a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 02:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708252502; x=1708857302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HuygbSf4UHd35+EXR11toQj5dF2p1THmwKG5xqllq/0=;
        b=wwCnnCM23OD8k1jm/Grl/nUSgfuhZEHobTr3QSd011Mk+ObsiBPeQX3l3YE21H3q+j
         Z1RLeqUJslHUTFaJkFsYNtD5ccMITQd1pjwnjyH06+yMB09+drjURnS7gfq+Mo88RwXh
         kGgxwlNoZ4qJrPZiEfowRbNY5bPWJAfjfXw9GE0xS3cADndcO9JDq4iD73RPEhuHfHIe
         qk733IoXcDhajHCqf/pTeRlhPPasY6v2EjujCpgFEVfOxyz1LDQOqaEe7C+rhG0IXhc3
         eYec+dsZ69Ets3AibLzwcsHl/dvgzFgDpMqDRlsP5PQqYkJMuGBj4gnPNU+mKrt0U3hP
         5RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708252502; x=1708857302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuygbSf4UHd35+EXR11toQj5dF2p1THmwKG5xqllq/0=;
        b=ZZGdSJ0A2gm/0L9DKJ3kq+OgLtr2pQ0ef+ieFZ084HnDfaMyztek+eIWx0qzxnY/2V
         zZk8FCBxWs5m9yCCzI8Kne/hBQNhC6YiSMSxTOvkg+6deVwIS00hr/30D5Urj1Ky6put
         sK9UbPsPRLvi/Q2ckJxY4+s/392k1n2RJ8fRjEqnF85RVK08WGwX2Y74cadvEVJpFtO/
         Mqs/wbKtSabbowqBJ4dMknqYB5XcmEtDr3UbLjOcYCs1tw5OQjT9svTmGoS+4+3tqKky
         z5YF1hajmjmES1isdsrRQ9aY+f6kcOwq/n5Oj7Vv8SdkGYJZEmLKdDzZwnTJTmWuGIfx
         0qvg==
X-Gm-Message-State: AOJu0YxIj8vaB4i94CVUjAHInsfpSFjptgaJETWrnnrToLwySlLcljIr
	sOW78Wgxo6t6x2xPdLBTc/U58JicFaToGmTr5mUKxwHYyYpIQ7Q740us1zViIe4=
X-Google-Smtp-Source: AGHT+IHXeXDIyPNdZ2RPZVYYlClPYmadYgfkCXRMpJ8r65aqMbKTZH34Y5qfPWSqEPa9fsE6BJsIIQ==
X-Received: by 2002:a17:90a:b014:b0:299:6e88:7b6a with SMTP id x20-20020a17090ab01400b002996e887b6amr1432659pjq.36.1708252501761;
        Sun, 18 Feb 2024 02:35:01 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w19-20020a17090aea1300b002960e397891sm2172696pjy.1.2024.02.18.02.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 02:35:01 -0800 (PST)
Message-ID: <c7a8a0ff-2905-4253-bd8c-053d4a39d43f@linaro.org>
Date: Sun, 18 Feb 2024 11:34:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] clocksource: imx-sysctr: support i.MX95
Content-Language: en-US
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240205-imx-sysctr-v4-0-ca5a6e1552e7@nxp.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240205-imx-sysctr-v4-0-ca5a6e1552e7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/02/2024 04:17, Peng Fan (OSS) wrote:
> i.MX95 System Counter module control register space is blocked
> by SCMI firmware, so we use Read Register space to get the counter.
> 
> V2:
>    - imx95 is not compatible with the existing hardware, so add a
>      seperate entry for i.MX95 in dt-binding.
>    - Per Marco's comments, the global variables was removed except
>      to_sysctr. And add a new TIMER_OF_DECLARE entry for i.MX95
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


