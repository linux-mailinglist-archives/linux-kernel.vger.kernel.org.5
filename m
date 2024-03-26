Return-Path: <linux-kernel+bounces-119580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F688CAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B287325A68
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CAB1CD2D;
	Tue, 26 Mar 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnxQ3DuY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487F51C6A0;
	Tue, 26 Mar 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473837; cv=none; b=TUcCP9+98FYCTdHvnTtmaq4vhHfNeWf4U0zQ6TXTU902UbliuskJUm9gr9uS8aiiaGKo/94xqaU99cw72SQKV412i2cZ104df5rmMNwk0m15DrcvPOYjxU4c4bFvrd594yNS1mVmyAjudLsKSe1m7YRTTDcbFxE760U0P2WtNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473837; c=relaxed/simple;
	bh=HRBtzkJ1pX+jhcAjFkL9mb/xPm8GrXvFzAWcUwwYUGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YH891Mx6Dz50Asi9CrKz6EKwaMwNe8xULy3LzqudZwngI1qkwbg6y3kLN8SbAp8ORzpG1s5VXc1Wl+jzvgqmU7jP5gOqDzC/n+hHr7xQZtcMtawqkTQDY2w18ZI+Rey8eYHt1Mp0PHbcM8IA5pQgUqG5974NObV2oJZlc9JqThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnxQ3DuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98704C433F1;
	Tue, 26 Mar 2024 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711473836;
	bh=HRBtzkJ1pX+jhcAjFkL9mb/xPm8GrXvFzAWcUwwYUGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnxQ3DuY2B9Y+YJtijJIzcsk1tt6BsE2CmrIOzBKiXyo6jgrCT/+SULBA/22A8XJQ
	 H35MKgwLTXFog5kUDCHE8sd2JKSPxw/+NKGAsizph0s8zhSow4kf32D4vBe3I6fQ9h
	 Md4m57/xPEfcHck/5bCr7xuFytxsmAbwsVwYsv+oF1XNeatgdq53TMNfh3gVjC0OUI
	 63Jh6mW2hByZKdSLqZ03jfqOPqPt/0xDIhLG6js6wW/fACgcY8fctPBweGIHbt9ONd
	 8IBWY0YXbLrTWWPlZjCAIRtUS6D8RdmgDky2WkbSU1zMnU9rqh91LRX4REvKIc1+CS
	 SNOYkR6MOpAJA==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Mostafa Saleh <smostafa@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	nicolinc@nvidia.com,
	mshavit@google.com,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix access for STE.SHCFG
Date: Tue, 26 Mar 2024 17:23:18 +0000
Message-Id: <171145006028.35099.17017166136066755497.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240323134658.464743-1-smostafa@google.com>
References: <20240323134658.464743-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 23 Mar 2024 13:46:58 +0000, Mostafa Saleh wrote:
> STE attributes(NSCFG, PRIVCFG, INSTCFG) use value 0 for "Use Icomming",
> for some reason SHCFG doesn't follow that, and it is defined as "0b01".
> 
> Currently the driver sets SHCFG to Use Incoming for stage-2 and bypass
> domains.
> 
> However according to the User Manual (ARM IHI 0070 F.b):
> 	When SMMU_IDR1.ATTR_TYPES_OVR == 0, this field is RES0 and the
> 	incoming Shareability attribute is used.
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu/arm-smmu-v3: Fix access for STE.SHCFG
      https://git.kernel.org/will/c/ec9098d6bffe

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

