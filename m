Return-Path: <linux-kernel+bounces-151675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3469A8AB1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C6D1C21E41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917C6130A56;
	Fri, 19 Apr 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi9AiWme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30912F5AF;
	Fri, 19 Apr 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540795; cv=none; b=Wld/e068YB4BOVWkmtwxP0iaAiEEs+nCQN65gBl1Sx2++ZHeM1DZ1jIkK/6k6/JxJN2RxkpLCfVLc3pA7/MglwzOwtDVIAlP1SYcbwE/bhIZdAY/xHFcf1WU0n3cCc9gnWcOUzjuWUxESAln9Z/Xqy4ffSPIBTZyBwjo87UQ0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540795; c=relaxed/simple;
	bh=qh3vNFBVAwBLO622Q3sbcNK0OnRPD6sqlJxOuDdcyBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHLEXW6gAysctb5FBXsRm2SylfW103euhhwk9eBP0DAewH8VigAxPinrIsQwN+4o9i+/uBxbIDqDLAJ3icqxQxSHOGtmwKZEYpPMwd4KykxZKkLaG2II9syIX5KMnD0eO+J2Vzlacx64Dhlu+am2wbLxTcs8wL4tL8solZvNO2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi9AiWme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBD4C32782;
	Fri, 19 Apr 2024 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713540795;
	bh=qh3vNFBVAwBLO622Q3sbcNK0OnRPD6sqlJxOuDdcyBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oi9AiWme+dHsshak9uz3sb7NIUWiOkX6kVzQdudCPe45QeF4RYdGtGace23uUBVO1
	 +KgKULeNKBPI3X0vOD3cIi1EObCf4Vp9RfDHkMgC0ZXHxKz/PcGcvojcv/y5zMZqD6
	 0/mXtMBPHXKh3f8qtqeFD4OqXblx4Z7iAamJ7Bp6a8ewKbiFE48Yb+etircx2RlgRI
	 9L4CJoc7e5WTU7vIQNXxK4m7RjOlmPe4RBZoISSp1IT9CASZyTZ5Ne4fFI3FzHhkJ1
	 GyFGq6BawYh1vcex9e2tclwJKcQ6BOzBiiFMv0Hx1REe/Cr81/zzU82B7d1LIBVHaM
	 cOcTWvKYjk0Hw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	David Woodhouse <dwmw2@infradead.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Support clean reboot after hibernate on Arm64
Date: Fri, 19 Apr 2024 16:32:58 +0100
Message-Id: <171345345397.312430.3943582845307730698.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240412073530.2222496-1-dwmw2@infradead.org>
References: <20240412073530.2222496-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 11 Mar 2024 12:19:14 +0000, David Woodhouse wrote:
> When the hardware signature in the ACPI FACS changes, the OS is supposed
> to perform a clean reboot instead of attempting to resume on a changed
> platform.
> 
> Although these patches have a functional dependency, they could be merged
> separately. The second patch just won't *see* a FACS table if the ACPICA
> fix isn't present.
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/2] ACPICA: Detect FACS even for hardware reduced platforms
      https://git.kernel.org/arm64/c/bc5b492ac305
[2/2] arm64: acpi: Honour firmware_signature field of FACS, if it exists
      https://git.kernel.org/arm64/c/fbaad243b536

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

