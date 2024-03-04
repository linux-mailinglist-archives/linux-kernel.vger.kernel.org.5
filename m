Return-Path: <linux-kernel+bounces-90809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB78870548
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EAD28BD2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A127481DA;
	Mon,  4 Mar 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxOxqIhv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A971D47793;
	Mon,  4 Mar 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565484; cv=none; b=I3F8O280dJx/5vfZOKGaeV3SIU/WgBW/kSOvdI0Gj44sXtE7lCDHEemCaTFQs+QGvAMS9dRl8JExCuOJDWkYME2KJIV/lQRMjO61vsurJ6G67jDY7D+h/CFN70Z+NjrxfV4a56LMSjoUimHvLU5dkJplwtHguJRDmQqFhcoOAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565484; c=relaxed/simple;
	bh=m8IOE/o5VvohqpjXBtrbigMUqed0yEWG8TTcV+4qeRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2O0DyBCY2cOwhrAXCVdI6t+C9O3x5O0biWTcsdPEzWgE8Hmm7EzwNx2HumBu0Q65EV6NotO0fmf1WdDWb6grNiLrtnj+DnWYMVvoWOlWTvWbM78MlysovtM/8TABxxpfmZVg8uQbb89iGGKjBKk+NesLGRslneecoFVas3WJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxOxqIhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AE8C43394;
	Mon,  4 Mar 2024 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709565484;
	bh=m8IOE/o5VvohqpjXBtrbigMUqed0yEWG8TTcV+4qeRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxOxqIhvL+o2H3sSeNxhMyEDlxT/3+QRuVcRD/t70pz5KglppCH3uaUF1Kr4STmgc
	 BHR8CR/SiafRHaZQkVFhgZuOKRfngmX3K/cQwcXfdu6U/fr9+G+Cu4/OJQJlcu1tD1
	 Ytg1AO4QOs9QpPFi0L+DyHE095Y65ZZLulvsOr9oyX2yh3CynKChqCG9W+5Jxsazg3
	 81Ai5P3NjI7AM8+3VhHhPbE1rwZiDF6ZEMZOhKFQbtUiwUKrM9lhMiOTDO2siFVvUV
	 qo8Ct5fpYz4B5TebH0FsZ/Bn2489Z3Xf027NXkCvriTG45WU3FeXIwmyxQgCY1f4/W
	 kgkR2A8p45vAw==
From: Will Deacon <will@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/4] StarFive's StarLink PMU Support
Date: Mon,  4 Mar 2024 15:17:53 +0000
Message-Id: <170956198957.3271304.10140223421156074821.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240229072720.3987876-1-jisheng.teoh@starfivetech.com>
References: <20240229072720.3987876-1-jisheng.teoh@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 15:27:16 +0800, Ji Sheng Teoh wrote:
> Changes since v6:
> - Address comments from Will
>   - Add "COMPILE_TEST" to STARFIVE_STARLINK_PMU Kconfig dependency.
>   - Fix incorrect bitmask with BIT_ULL().
>   - Drop kfree() which is not needed in devm_kzalloc() allocation.
> 
> Changes since v5:
> - Add entry to MAINTAINERS and mark the driver as "Maintained".
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/4] perf: starfive: Add StarLink PMU support
      https://git.kernel.org/will/c/c2b24812f7bc
[2/4] dt-bindings: perf: starfive: Add JH8100 StarLink PMU
      https://git.kernel.org/will/c/66461b43b0c0
[3/4] docs: perf: Add description for StarFive's StarLink PMU
      https://git.kernel.org/will/c/49925c1c5a6c
[4/4] MAINTAINERS: Add entry for StarFive StarLink PMU
      https://git.kernel.org/will/c/b9f71ab2152e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

