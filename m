Return-Path: <linux-kernel+bounces-148711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EDD8A8680
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DCA1C20E84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A9B14C587;
	Wed, 17 Apr 2024 14:43:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E280514A4C5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365003; cv=none; b=C/8TtCYeYQ2xoLi5QQIRxxyW95vm3G5JE7pwVqiIYI/YtyR5DTEyy7MApiVET2pDmFFryUn7CeZy2/9nCAec9bzLBDPBm8dxjhuVN11l+UseVXS38kYvV/A18Srd00WaT8YMMoctlpbGDdgJtalLURXIoOK9crpjXwHZ6eQB0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365003; c=relaxed/simple;
	bh=bgmmRAgGPHG0jRQKUH4mmqT3ONaK2R/3lJz5tz8Gimk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJH50o2maIK/PqeOMGr7mWl0W51i+asG1CsPtQxEYfsFd1F5czxlMSwhYgFCjrDVvlZ82SHAITW/ke1SHIvp1viDbMBR2O8QKruCKw1qwKdOui5LhJ+PYgm6YRzq4f14gxbEHVcBFfd88gj0cvMN8hWinMWyw43uS6a1rBSnp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A80E2F;
	Wed, 17 Apr 2024 07:43:49 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00B4D3F738;
	Wed, 17 Apr 2024 07:43:17 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:43:15 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 31/31] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <Zh/gA29yEpbinEPh@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-32-james.morse@arm.com>
 <99ac181d-d93c-4b11-84aa-48953d9eb5a3@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ac181d-d93c-4b11-84aa-48953d9eb5a3@amd.com>

Hi,

On Mon, Apr 15, 2024 at 03:44:48PM -0500, Moger, Babu wrote:
> James/Dave,
> This is a huge change. Can this be broken into multiple patches?
> It will be a major task in case we need to bisect to pinpoint any issues
> later.
> Thanks
> Babu

[...]

I guess this might be possible, though when moving groups of static
functions around that refer to each other it might be more trouble than
it is worth.

I'll need to discuss with James.

Either way, I think this patch will need to rebuilt when spinning v2 of
this series.  I've been rebasing it by hand, which is not exactly
foolproof!

It ought to be possible to break this up into one patch per affected .c
file at least, if people feel that it is worthwhile.

Cheers
---Dave

