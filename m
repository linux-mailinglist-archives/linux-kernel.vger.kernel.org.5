Return-Path: <linux-kernel+bounces-117885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD47588B0D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883A52E325C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7C73FBA0;
	Mon, 25 Mar 2024 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Qstw1Oc6"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837FB219E5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397160; cv=none; b=Re4wgzVfCOzGuFltE+NYUI+/rxhudGGGDz/6kdBAHcKAxyFFG6Nd4rFLstzlgkTKlvLJOkKT4pZltl/GBj7wpDrFhuRfZ4VnCS7rWdnzGBgPGPHTjukyjA+sTz9gRsDreUJhVyiHO0Oz0oPwyu/3fUWBV4YOnyh01Roeu9ucPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397160; c=relaxed/simple;
	bh=UjrUvFUa0XDyVul18UUTRk6viKLJkQaQh7vx2mOVQvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ0kIum3x5A6b5RnZjj8o5uwLzNw0lWzumlBi0XMOVGh55C1bAlKiDWqNyIwTQAXSVgdqvBdKjICBiL+O5Gao7wBIcBV3IELBjob/AbC0nbDOewmJsohMi9emStvsKB92m6smAN/Rd8fftfKMrShd4/TNXO/+AzJozL8MH/2ovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Qstw1Oc6; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e6a9e2e2b6so2604040a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1711397156; x=1712001956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0s4wc3i/rfC3/kxPVkBRBN3/JL52yC7W1Cjubckw3aI=;
        b=Qstw1Oc6PeGe7QTXrkhKhbfHA/q8M3FNDYbOEOPwiwUBvwAgOdHeljJUGVkgeor2YD
         TGf6MEaDWhhhpZgLVaOYrieSDF2c6qjDKdhsVYO27aMZzmAYaRLEO/OKc5o/7WbIhnfr
         iT0quJTZ9rPRKyxDVZCPEsqork5YDfAtVT60Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397156; x=1712001956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s4wc3i/rfC3/kxPVkBRBN3/JL52yC7W1Cjubckw3aI=;
        b=MlKpgeElpSAy62Ee0+YZ9ifYuV2ega8Jy1ewTR6+H5kIZmzq0XDbj2UD/Uk85d3QzN
         U06QF+M2bvaJXx1wGJZCyOpf2R19XKBhsxlxKTvU+07Gqum7jdyMArKgnTpWtKENrXev
         AXweNdgb4pPOVkCLDWGFQ7RaF9L6vsVrh9rHKtl8vL9kvDfb75TO9+bu7yGjUfZAhsrB
         11BRsiEobo8p2NWhL1O8/EBDOSh41wfOxP2kr7MXWp2C+3IYaWQP4NbI4CfrRJyh2eeg
         vUtlhQvauvzu9lXqUYkewb4Q7biQQ7tiTU2iq/FZ7lyqoG3BekstcFktDq7J285ygpKX
         qk5A==
X-Gm-Message-State: AOJu0Yz5RbgG08Y5iGD8m60Wj2D9EQQzIyAHu/NpxXXnjzwDTJvBnUWE
	uqNgwGT/P1+8vGQzOGbAnpo/7CJIidh8COiNGaZU8+1Dcr8j18oEcMYXf7M7bluxL+P+pQB0hpc
	ofg==
X-Google-Smtp-Source: AGHT+IEz2C6ZNyFMQGJcw/HWcHLsyuzCTD2CcJ7kx+2L35Lrd7WJVLF0L9DJWnDMbuCXNFX6SJqKrw==
X-Received: by 2002:a05:6870:55cd:b0:229:fd96:1e40 with SMTP id qk13-20020a05687055cd00b00229fd961e40mr9859382oac.44.1711397156561;
        Mon, 25 Mar 2024 13:05:56 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id pn17-20020a0568704d1100b0022a56a9dc6csm246922oab.10.2024.03.25.13.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:05:56 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 25 Mar 2024 15:05:54 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Message-ID: <ZgHZIpmQ5pWcrG-h@fedora64.linuxtx.org>
References: <20240325120003.1767691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>

On Mon, Mar 25, 2024 at 08:00:03AM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

