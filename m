Return-Path: <linux-kernel+bounces-151673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0498AB1E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9371F23EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B594612FB16;
	Fri, 19 Apr 2024 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCbouzFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171B12AAF4;
	Fri, 19 Apr 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540788; cv=none; b=EoDe/Y1ANugPh1Avy4HWL+a5Z6Uy5fvAXFPDfjdyaUfOWf7ZzWN1z4YithCPJFb1rwpkQYERYL/ANi52clY1MvKfLY7O9ieITNeBIYaFi8WF9oeiM7GzmT/9uDrHJuywKM6m7zepZLul+y6Bvpa8nwAYFAhUDSceDzVIXqg4Iag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540788; c=relaxed/simple;
	bh=s2YlNF511b1ugPoK8gPNXpw42GPHoGPjYZZp8GRGfW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luzcXo07VtiLLnGdJ8Gz1X0hKZfHK++Qy7TD/UE8RFlAJEYuPS9iaYnfHRzNmhva0tQQRsq1hlUy1K984Sq5DAGJJ3ugeZ0JdtilFkRoNVfpxOj+RtQmxP7+C52RKSZdG7HNYYohIs50xXz4D0aIh2iwVdpfM9biXfB4R9wC+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCbouzFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32B6C072AA;
	Fri, 19 Apr 2024 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713540787;
	bh=s2YlNF511b1ugPoK8gPNXpw42GPHoGPjYZZp8GRGfW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCbouzFUoeBBdBnn1y0uZdUe6YdPbeuxy05dOAEeC5v2BTvjkjvD5nfZfwfQOjG6V
	 Iriq9/Yb4VNX/Lr44U8vrjrHVvhMXbPAw9k+b9hKJKjlpPIvV2gDnR4liDv89qOV5G
	 Kbd+KbnoAbcTeQUPEoqTdAReDI1CeLT+6SQkQkO8O8A6xO009ITDeneE94aP9alYl5
	 G95s8JZ2ejk9aUb/2vnRXGH/HrZ2On44hVbFXTbzQAOqqd9GiI0Be6mdad1+/9vl0h
	 mHConzuXWk2VEjdwFeFiQIjUp/HTWS05Msc1WVhyCvVDxGOafId0lYzvY6u8ulT4hV
	 X5NFqVs53MoYg==
From: Will Deacon <will@kernel.org>
To: Aleksandr Aprelkov <aaprelkov@usergate.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Date: Fri, 19 Apr 2024 16:32:56 +0100
Message-Id: <171345118104.301415.8430851318356217015.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240403053759.643164-1-aaprelkov@usergate.com>
References: <20240403053759.643164-1-aaprelkov@usergate.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 03 Apr 2024 12:37:59 +0700, Aleksandr Aprelkov wrote:
> If devm_add_action() returns ENOMEM, then MSIs allocated but
> not freed on teardown.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
      https://git.kernel.org/will/c/80fea979dd9d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

