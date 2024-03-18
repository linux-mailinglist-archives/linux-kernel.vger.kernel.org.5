Return-Path: <linux-kernel+bounces-106505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C20087EF98
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FE0B23265
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD15D57327;
	Mon, 18 Mar 2024 18:17:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5956B7F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785848; cv=none; b=azQqX6UTxUdqk+T77snOZbSAnG5zWnj51no0tJ61DaHYWUVW8OgHqWS/0pdZ/meCKzqNfBPE0G/gVptt43O4yjB0CC4ckqtYRoqWSQ6FzxT2x4ziee7utiRB5ym8JM4v3U016bwp7jxv+jfps3c9fZLtH/7yzHgfqIOyzQpCK2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785848; c=relaxed/simple;
	bh=wpz+jpXp1/xLYY8u8ro7WOlKUYxshynrXNl0hjCDdXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joO3HKm/v4ryyEzfF63mxgkhDWvsneWj4S3JDGyWyWqsJkHH6Ewh2YVZN8EvFy4TXMznwyqHe9BX5HvPcZaC4lMLpfZfgfJWqZqjg1E7o5p3/8jc845t65MV8jqeFxIdxwEmcTYMPsYezWssLGHYLcD1UTDG3CE/b1d3XSCJgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D78C433C7;
	Mon, 18 Mar 2024 18:17:24 +0000 (UTC)
Date: Mon, 18 Mar 2024 18:17:22 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Will Deacon <will@kernel.org>, Jonathan.Cameron@huawei.com,
	Matteo.Carlini@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux@armlinux.org.uk, robin.murphy@arm.com,
	vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <ZfiFMr8s68cf2uac@arm.com>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
 <170983839495.1825460.8461454086733296317.b4-ty@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170983839495.1825460.8461454086733296317.b4-ty@arm.com>

On Thu, Mar 07, 2024 at 07:07:07PM +0000, Catalin Marinas wrote:
> On Wed, 06 Mar 2024 17:45:04 -0800, Christoph Lameter (Ampere) wrote:
> > Currently defconfig selects NR_CPUS=256, but some vendors (e.g. Ampere
> > Computing) are planning to ship systems with 512 CPUs. So that all CPUs on
> > these systems can be used with defconfig, we'd like to bump NR_CPUS to 512.
> > Therefore this patch increases the default NR_CPUS from 256 to 512.
> > 
> > As increasing NR_CPUS will increase the size of cpumasks, there's a fear that
> > this might have a significant impact on stack usage due to code which places
> > cpumasks on the stack. To mitigate that concern, we can select
> > CPUMASK_OFFSTACK. As that doesn't seem to be a problem today with
> > NR_CPUS=256, we only select this when NR_CPUS > 256.
> > 
> > [...]
> 
> Applied to arm64 (for-next/misc), thanks!
> 
> I dropped the config entry and comment, replaced it with a select as per
> Mark's suggestion.
> 
> [1/1] ARM64: Dynamically allocate cpumasks and increase supported CPUs to 512
>       https://git.kernel.org/arm64/c/0499a78369ad

I re-instated this patch in arm64 for-next/core as:

https://git.kernel.org/arm64/c/3fbd56f0e7c1

-- 
Catalin

