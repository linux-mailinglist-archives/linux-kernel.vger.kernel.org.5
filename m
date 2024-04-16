Return-Path: <linux-kernel+bounces-146565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 346F08A674E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B33B20E41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7F85C69;
	Tue, 16 Apr 2024 09:40:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460AB6F06D;
	Tue, 16 Apr 2024 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260404; cv=none; b=Iqpg5t9XO1jPjDdwPmurByOMIGt/iyUe+qXpya2T7oY06z959xaIA1BQ2fnLv1te6ZeeTQLaXwKvpSmb/jTOTqCIW7Yfn/rI571et0PdicJNmJnEgCDV6ODhv1KKcPUrHN9UjYFyTh7Nx/HvAXhnU1rUmNoTp5+lnsGIAshNlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260404; c=relaxed/simple;
	bh=N5iDA4J5EI5OwQuYiba40jo6h+OcdalhCXiQdQOaXBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjLmST5ehaL6ysB1EQsl/Yv8MLcIc4cmVLvuke3YfeM95OvoDzzrpwz+0nknD6kXlhZ/4LmHwS4v82xXhq7rvuAwlOm/QA4+Ldx3XaZqkK/GcsThvm7X8kqhizIc2sB/GYOD96cfctvI51PBiKZb2yZ1zh0TkGk+B3duHQXurXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E70441063;
	Tue, 16 Apr 2024 02:40:30 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8941D3F792;
	Tue, 16 Apr 2024 02:40:00 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:39:57 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	Sudeep Holla <sudeep.holla@arm.com>, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
	bhelgaas@google.com, james.morse@arm.com, jhugo@codeaurora.org,
	jeremy.linton@arm.com, john.garry@huawei.com,
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com,
	tiantao6@huawei.com
Subject: Re: [PATCH v3 2/3] riscv: cacheinfo: initialize cacheinfo's level
 and type from ACPI PPTT
Message-ID: <Zh5HbV_M6wOdf9QN@bogus>
References: <20240416031438.7637-1-cuiyunhui@bytedance.com>
 <20240416031438.7637-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416031438.7637-2-cuiyunhui@bytedance.com>

On Tue, Apr 16, 2024 at 11:14:37AM +0800, Yunhui Cui wrote:
> Before cacheinfo can be built correctly, we need to initialize level
> and type. Since RSIC-V currently does not have a register group that
> describes cache-related attributes like ARM64, we cannot obtain them
> directly, so now we obtain cache leaves from the ACPI PPTT table
> (acpi_get_cache_info()) and set the cache type through split_levels.
>
> Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>

I had already given the reviewed-by for the series, anyways here we go again:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

