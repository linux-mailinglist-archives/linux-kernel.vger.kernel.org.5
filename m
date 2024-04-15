Return-Path: <linux-kernel+bounces-145944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE0F8A5D21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64ABF1C21C94
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB23157485;
	Mon, 15 Apr 2024 21:44:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD0156967
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217485; cv=none; b=e3eYzGggr8NsQGKOSav3cg+OegLAV3XcTn6KCzBGuEzqQcMkZfmjcgpSC4B27jOtiVPEXeYvPR70Pjesv0Tch6oMJqQfOrag4a1n6PK96KIxnpVAWULk1xunjzDgOErHl1DumQ1buxfi0QxMTOmHN4L49FctAizxcIO6hB1knKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217485; c=relaxed/simple;
	bh=YaVEnL7fTVUDsWoGF3mIRRcFiRd8xm30iOoRq9T0wwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KURRPN+JrOMq/KHMNxR8ilrlnKzyynFpHEPgo2y0gnaJORNpVakDWPxcIBmR7tDc4LiMvM7mtvE+0Gg0b8gM/IPMX8IT3u9VYTYXQLm+DmXVpJbcxZmA/9vsUiSKz50YcBymb4/sWmfoB5EAakirzRcOtU2IFk+PADKlyvfo9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 574E32F4;
	Mon, 15 Apr 2024 14:45:12 -0700 (PDT)
Received: from [10.57.19.68] (unknown [10.57.19.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FF4B3F738;
	Mon, 15 Apr 2024 14:44:42 -0700 (PDT)
Message-ID: <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
Date: Mon, 15 Apr 2024 22:44:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
To: Eric Wagner <ewagner12@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-15 7:57 pm, Eric Wagner wrote:
> Apologies if I made a mistake in the first bisect, I'm new to kernel
> debugging.
> 
> I tested cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
> 3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly and both were good.
> Then I ran git bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
> as the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good and the
> bisect log is attached. It ended up at the same commit as before.
> 
> I've also attached a picture of the boot screen that occurs when it hangs.
> 0000:05:00.0 is the PCIe bus address of the RX 580 eGPU that's causing the
> problem.

Looks like 59ddce4418da483 probably broke things most - prior to that, 
the fact that it's behind a Thunderbolt port would have always taken 
precedence and forced IOMMU_DOMAIN_DMA regardless of what the driver may 
have wanted to say, whereas now we ask the driver first, then complain 
that it conflicts with the untrusted status and ultimately don't 
configure the IOMMU at all. Meanwhile the GPU driver presumably goes on 
to believe it's using dma-direct with no IOMMU present, resulting in 
fireworks when its traffic reaches the IOMMU. Great :(

However the other notable thing that also happened between 6.6 and 6.7 
was the removal of the AMD iommu_v2 code, so there's some possibility 
that the GPU driver still may have only been working before due to that 
also subverting the default domain with its own identity domain, so 
whether it would actually work again with 
iommu_get_default_domain_type() sorted out is yet another question... As 
a first step I'd test the quick hack below, but be prepared for things 
to still break slightly differently.

Cheers,
Robin.

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 996e79dc582d..063e1eb32fbd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1774,7 +1774,7 @@ static int iommu_get_default_domain_type(struct 
iommu_group *group,
  				untrusted,
  				"Device is not trusted, but driver is overriding group %u to %s, 
refusing to probe.\n",
  				group->id, iommu_domain_type_str(driver_type));
-			return -1;
+			//return -1;
  		}
  		driver_type = IOMMU_DOMAIN_DMA;
  	}

