Return-Path: <linux-kernel+bounces-146195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFA38A61E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713F7283F92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33C2033E;
	Tue, 16 Apr 2024 03:54:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34130D512
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713239667; cv=none; b=YadPm9HYI5I06sBVbsm67Zkr7fZpmhfBj3Y1CRAA5DkbKLwSzjUQaI1b0G561HNj51rkSi1nlK4cdc+5EaoiSHrgPz5yDPilXUpH+l01F0M5/BEfnVcXR2fK8bDnLaW9BpgBFZwWk8EIshiT2fs42zmuyg9P0OPY53l9LCgdtZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713239667; c=relaxed/simple;
	bh=wo0tpVuElMq45g8m7XIJHWZiP2YhlXaLXq6AtakN6lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnOxxGh9GVMDiqvySuH7B7LaPqwmywaSAgPHB3QgiBSq9cQNbaxb2GYl48+crusAUrsFhee4ccjOwHZWTCVNZ5Z/P39TRWjOQBEkKbxvaF9i6j5GtzXeSwATq09NCFavkccKh1gztx6vpuxvVbiHm2oTDZ4uUgtKheaewgm7cTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C679E2F4;
	Mon, 15 Apr 2024 20:54:53 -0700 (PDT)
Received: from [10.163.59.235] (unknown [10.163.59.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AF333F64C;
	Mon, 15 Apr 2024 20:54:20 -0700 (PDT)
Message-ID: <fec0df6a-c35c-41fe-8b03-de1b15893ff8@arm.com>
Date: Tue, 16 Apr 2024 09:24:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/8] arm64/hw_breakpoint: Enable FEAT_Debugv8p9
Content-Language: en-US
To: linux-arm-kernel@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240405080008.1225223-1-anshuman.khandual@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240405080008.1225223-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 13:30, Anshuman Khandual wrote:
> This series enables FEAT_Debugv8p9 thus extending breakpoint and watchpoint
> support upto 64. This has been lightly tested and still work is in progress
> but would like to get some early feedback on the approach.
> 
> Possible impact of context switches while tracing kernel addresses needs to
> be evaluated regarding MDSELR_EL1 access. This series is based on v6.9-rc2.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (8):
>   arm64/sysreg: Add register fields for MDSELR_EL1
>   arm64/sysreg: Add register fields for HDFGRTR2_EL2
>   arm64/sysreg: Add register fields for HDFGWTR2_EL2
>   arm64/sysreg: Update ID_AA64MMFR0_EL1 register

Since the above patches add and update register definitions related to
HW breakpoints, and have already been reviewed by Mark, will send them
independently.

