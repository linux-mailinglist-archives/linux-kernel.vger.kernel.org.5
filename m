Return-Path: <linux-kernel+bounces-129221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECC6896748
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF01B286631
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40635D47F;
	Wed,  3 Apr 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fueck/pa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217BF286A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130788; cv=none; b=MmXd6gVFRtdgyboZXmeelaALndgRWW2F+rVvLuy0PcgwrtQ05zkTWBlTKB2e2Wc52q0ImcuAMqGahECqLRy3mbutizqyyYEnei9jXjqp2B8oiEg7LkVWilwSStlN9Svt32Tgfju56pTZ5cm1RvkX+lyxZKI3C8w1c53i3RvJyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130788; c=relaxed/simple;
	bh=UF8VZWQYrDPa5ZvXYzCePHI2u907Bm5qMxInSbFNez8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QrwNpjHVlX07NOeQGW+wD61HzcxsO+uVfIWvmkhxpZJhV3nQkcN7E/RRY9tEQU62aUiWw1tnuRsRNsztpKuVhi4KN5Ss6daXZPm9WNr37REQAjGtK5Cfk9dCzNLSqBoOHppoDg/yzxMVW410IYJ55Bh1iF0RgKQYnxv+jf5IBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fueck/pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FD0C433C7;
	Wed,  3 Apr 2024 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712130787;
	bh=UF8VZWQYrDPa5ZvXYzCePHI2u907Bm5qMxInSbFNez8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Fueck/pazjrmw9hlAWejuuzypoYszBb7Ik2UJtDqNJsObeg9GpKuCocv5IuV1OEGY
	 nBQuutzxlKh6xaF8wGRbHCY4oHwGV09Jxawd4PGlW4BDVG7JcMQU07iFiu3MpEd4NZ
	 V3PwPDKjqZ8qiJsy6Bt6leU02rv/xdjmMSxJYpzpQZpcDahoWNxtswbGir9Rf6Z4f2
	 d+1JrNcNA5HPvvd94ZOC5x+ptRS3Rn/B+QeGX+E0sxmTqxI5aaN/XeWuoAFd0Ubwa3
	 0GC+5EjLGW/Wxz0aLHZqCK/VcvtFntGPvF5EN/EGCSprjxHhai9wqc+OKtEFvmdmTL
	 AJjodlkFYcdzg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Vineet Gupta <vineetg@rivosinc.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Andrew Waterman <andrew@sifive.com>,
 Palmer Dabbelt <palmer@rivosinc.com>, lkml <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: ARM SVE ABI: kernel dropping SVE/SME state on syscalls
In-Reply-To: <1bea609b-0acb-4adf-902c-e7e94de40977@rivosinc.com>
References: <bc21c53f-23b9-4596-b757-fc7707f91f24@rivosinc.com>
 <ZgxKXy6r0X7Whu5U@FVFF77S0Q05N>
 <1bea609b-0acb-4adf-902c-e7e94de40977@rivosinc.com>
Date: Wed, 03 Apr 2024 09:53:04 +0200
Message-ID: <87wmpeq3vj.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Vineet Gupta <vineetg@rivosinc.com> writes:

> You don't have to, Bjorn found the bug and he'll post a fix to lists soon.

FWIW, my patch is here:
https://lore.kernel.org/linux-riscv/20240403072638.567446-1-bjorn@kernel.or=
g/


Bj=C3=B6rn

