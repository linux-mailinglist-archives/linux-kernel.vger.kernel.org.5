Return-Path: <linux-kernel+bounces-50796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1B3847DF6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3B9293035
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1FC6FC9;
	Sat,  3 Feb 2024 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y56084aF"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFAD6FA7;
	Sat,  3 Feb 2024 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921088; cv=none; b=bMXQUDNR9OtF826hEcZ/83dxZhiwl2/LZ7LETXkBV3k5NfNPr50ZHrsFxv/mqBtcc16jOzQ/vP/isInT/kva7bIxPzV0dlQW1IgSxX+mHoL+v30Ri4Pzh9Zyxowy7c5J38eIp9fSAitYZ/47kbQ4Q77YVs8c2sgEEYcy3pVOfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921088; c=relaxed/simple;
	bh=zUIeMJGJsDVudEVRKt5eSdSNz+XroeHA+2tekhGEG1Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hgi23lwXilFqJBPA6ISY/gLo716RB+ymyyKlBZqePNUuDVzOlWviawLlqiLAPzexhbncEz5uIuCkxZ/dBARpiyRXSJwOgVSXQdcdZ0wgZq4yQjI4phF0UJ/KMZRv+u3xYfFQO+/nj+yjCC1A3pMKKJE+6WKz/X4rLXft7LJvy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y56084aF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.192.9.210] (unknown [167.220.81.210])
	by linux.microsoft.com (Postfix) with ESMTPSA id B45BB20B2000;
	Fri,  2 Feb 2024 16:44:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B45BB20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706921086;
	bh=Prii4YevyN1al6PBr0yJWiEWaRsQTGvMPZyZ2za0dn4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Y56084aFN67h8N4285xhoYoD4TWQbWwxM7i39nvKoVgm/ao6/+x8IWPV3MXllKO3t
	 9+RwZSWedbMeqReg4cTbo+1Opd43PQr+lf6zXJeS8zO3YFxtkvR0eGLttl/8Obt26B
	 bk3zIRnWOjBum+pXZfhE+XRtlhnObLVri9sokuoo=
Message-ID: <b361b7ed-bd2c-4816-b97a-1a5993524d48@linux.microsoft.com>
Date: Fri, 2 Feb 2024 16:44:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] acpi: Use access_width over register_width for
 system memory accesses
Content-Language: en-US
From: Jarred White <jarredwhite@linux.microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20231216001312.1160-1-jarredwhite@linux.microsoft.com>
 <CAJZ5v0gZ39zJEGV7gQLg6Y0=ke1W7bctqtZ46K+SR9RT5Bx4Hg@mail.gmail.com>
 <6e7db718-65ec-4461-bab9-0ee4c96c25eb@linux.microsoft.com>
 <bf1a84e0-bf88-41a1-ad0c-4270aaa5d3aa@linux.microsoft.com>
In-Reply-To: <bf1a84e0-bf88-41a1-ad0c-4270aaa5d3aa@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 1/12/2024 6:19 AM, Jarred White wrote:
> 
> Unfortunately, we have no hardware platform with this configuration to 
> test with. What is the level of concern here? Were there previous 
> changes that raised this similar concerns?
> 
> 
> Thanks,
> Jarred
> 

I just wanted to follow-up on my previous questions.


Thanks,
Jarred

