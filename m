Return-Path: <linux-kernel+bounces-74061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326C85CF73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0FF1B222EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3365D39AF1;
	Wed, 21 Feb 2024 05:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p2Tp0qAl"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC439ACB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708492431; cv=none; b=F/l/KcanYltzJxys1k4LCWluoKWwN5SmZ1YWoNE4KOaBElIO55ApYYmB+NymKMGYrB7sNRY/k/hAXHYcTaxb3/6hvYTJjV3dz3mqUbenLZ/OvieRJZy5dWWVo1DIa8G/GkCxxFKlErNozjgJcQhA9HItcPqov945kGDvJ1PGhv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708492431; c=relaxed/simple;
	bh=1o8mF6TRpVX6l9xjqvqTLqPBoqzums2OqnRKA/cxxfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEWw34Z5WZHgQntTGQiKELLa4f1k9aQoAgP73evDaoRuZoxCGL3b7ayXKkrzVYlZOX15bahdmQBca7AR/Ycp51+o9OqioUoZfSQurC4UJiWoZ+6Ak5g+DdYcZyUPt3366Ppn/mkdUFX4LfuiHRkn9FFXuvxtq2vqTtB+Md+HNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p2Tp0qAl; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 21:13:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708492427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4IHEn5Ij4Q9WdVqylbSxFXrKbvlcQbpoMESZ3TkdOkM=;
	b=p2Tp0qAl4s6myT2noK2Pjcb5d/Bf5IlTRxVsGnbWmTZQZlEHCddU3koMN42Ryb59ij+2vS
	gn/4ZaX8jdrcdgzgtUMoOsYrnDL1KNto9sjPCCbrp9wFPYxthMiiR6LerqgYe+oYYMaVJi
	73uDVHonoC89JFCN54IgIAUdElYXOVI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: Zenghui Yu <zenghui.yu@linux.dev>, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] KVM: arm64: vgic: Store LPIs in an xarray
Message-ID: <ZdWGhDeVN7-mPOT8@linux.dev>
References: <20240216184153.2714504-1-oliver.upton@linux.dev>
 <20240216184153.2714504-2-oliver.upton@linux.dev>
 <f6a4587c-1db1-d477-5e6c-93dd603a11ec@linux.dev>
 <ZdTeScN3XCgtRDJ9@linux.dev>
 <8c3e4679-08e7-c2bd-2fa4-c6851d080208@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3e4679-08e7-c2bd-2fa4-c6851d080208@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 21, 2024 at 01:11:02PM +0800, Zenghui Yu wrote:
> No, you're right.  My intention was to fix it in patch #10.  And as
> you've both pointed out, using xa_erase_irq() can hardly be the correct
> fix.  My mistake :-( .

Still -- thank you for pointing out the very obvious bug at the end of
the series :)

-- 
Thanks,
Oliver

