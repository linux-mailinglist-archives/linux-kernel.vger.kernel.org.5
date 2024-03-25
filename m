Return-Path: <linux-kernel+bounces-117905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDFE88B11C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597F41C62941
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091D546450;
	Mon, 25 Mar 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="J9OjiBv8"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC72233A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397622; cv=none; b=SjzdQpkt+DCosNO9OTuXJesJQhjAB8vT5E46JkN/pt5vW1onkN9gdNgAOU9eR6OPmbeaqYVwOCbdASbD60NsT0D8B8pNgiW90AW1iO2qDk2txwGTZttJOb3x7wjNfPSHjS9xNgY3hMRF/YhZP0ZZRvEGY3COkLGOJHO/kI7EmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397622; c=relaxed/simple;
	bh=2GSynMfQlWPEYmmMwEWyYBd32soX6drKAt4Jc4GY5nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbvxQ3rOzzlun3Y++R8poRuA2WHekyGtgwJxDCwvvOIPGeUmnG0n3tCEGgX+6i+CUoj18YVsYMdaPIlEN6ezMI8lFgfd9OMZIQvcyJbaj97RCFYe2OHZuqJ/VHZah3xTzQnH39mjYuepBPa1rHjUd7W4G19zF7GzPqa5S+pKoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=J9OjiBv8; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2222b96e4d2so2781007fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1711397619; x=1712002419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5MRZLBOe60pVxfq+JGemFNyckt0tyihI28+0Lv7YxQ=;
        b=J9OjiBv8/T5ocMJDd/5wJvUXzMs8u3YHJsOsFtK7aZEATajUMTEf/ZiNit9GXGq5mI
         vi9YmwAQaAMPlYwNwB1En/hSAePenDYeHPAHyLeyW1MwNTmayE/YGQRzl0lUgdO9DNqB
         0bLT2Z853bAEEqAIpo7o5ZN1i494sBxalLoJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397619; x=1712002419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5MRZLBOe60pVxfq+JGemFNyckt0tyihI28+0Lv7YxQ=;
        b=wVnG8qG69SC7rWBHAIdPt8VwhYeeGk7UofjW7mVV/zVBP6nDj0ndyxsN/Ck54Ifmbt
         +ZUgBtBPga8Knki1PJLKhiv3jI8Riv0Oc5mWrzxdEmKoBUV/1rREk1/QGGOaghCXXmQj
         9g6kh3uuQQWhZ1rUgV8IO1p3Fl3HXG532DuQSX+7BsDaJ2heBNUp4SAD/yQdGCX22c0A
         hgl4J6v0HBp1JjsIAkjPZXTmT66gY9EvFIZ2HMKzwPK+pYKU6igf67vlOosEkhLG2cKb
         L4omF7fl05o0fvI4zLb9QpDWu1m/3Wp05sPSU5k+MWqCkDpFT84ES03aWGTOHSzUpHZK
         pFig==
X-Gm-Message-State: AOJu0YzziDBKciH5DYZ5UgmIAvBeDBFZnfBHUMPIOs5EiS9jcBXHI6kN
	s8mqFHdut7ulROJn9ypqGFAuVxq+Hqt/tCd1+p0R9DUPpBoebxiEdLVpzNwdsw==
X-Google-Smtp-Source: AGHT+IH5MILjTlLT4XjELr9ZSTY0NYuaahWY+8R6aTQhpg+l1C2xqghpFtR7CSPKI3vDqSz/Q/RNiA==
X-Received: by 2002:a05:6870:4205:b0:229:8236:ae9 with SMTP id u5-20020a056870420500b0022982360ae9mr8470126oac.59.1711397619514;
        Mon, 25 Mar 2024 13:13:39 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id n20-20020a9d4d14000000b006e67e27fd71sm1271489otf.28.2024.03.25.13.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:13:39 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 25 Mar 2024 15:13:37 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
Message-ID: <ZgHa8SsZfpNR2r6L@fedora64.linuxtx.org>
References: <20240325120018.1768449-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>

On Mon, Mar 25, 2024 at 08:00:18AM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:13 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

