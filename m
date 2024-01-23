Return-Path: <linux-kernel+bounces-35219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEA3838DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749C2B2144A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B185D915;
	Tue, 23 Jan 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEKue+x8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95B5D8F5;
	Tue, 23 Jan 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010699; cv=none; b=G88PL/VNZBkzjK98YIb3A2GRJadgl1jqPq+M2mBhSQBz9CCcTDUt9liXdkYH08L6mi9GEXxeIwBVuxBe4M1jrXWpRbGfQP0uQSL9msO3o5nN0C/8kUwxEhfXBHp6w4Tb4o3jS/7RAdrNRzZYB6iUvxNIecsh2A7ICzwWEfR2IZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010699; c=relaxed/simple;
	bh=eVteaCDp+KI9ue5dP1Jh4rwkWPglMdLIUPjw2f79rnU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=c6Qcpm4WRpM2Yu2pN2uXj/0+MjG8eofZx/w3qgW4aVmUHeUyK0ASfv2Bqd+8Ecf4kOu/TFgGaaP6GV7njm+lYT9a84pOHjQfQ4x7GiUYCUPbN8jqCJkygLvmWJDcOHrGoi+c4KlxBImxvTaZyybFZzs76aO0xWuyBSWW+A8P8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEKue+x8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6494C43390;
	Tue, 23 Jan 2024 11:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706010698;
	bh=eVteaCDp+KI9ue5dP1Jh4rwkWPglMdLIUPjw2f79rnU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=dEKue+x8GGQMHmrkSO7aEgzamumcgotpPCrAMMSIGfFIst3qTfM8y13pFWL9NLe0g
	 OPDfSuJEb1jMPU1mAF4GsgU1YSDHH4OU8BDPxpWXcESDBxVlSFiKdVa84+1A6jtJdl
	 fHocw0xyIv2LneahdG1MGsfval0n6NC31eNszDn17neLK60XdfrvEBL04RAgebycyf
	 3n86YK168Q45/CkTBHMX7yvoPhK3K5fL8p54n+S5l/cM+nJjuZFTGmIKfMKT9U9JSR
	 Z0/CMoYn+GyjRsTjtCBW0mkxp4rt22OpWC01wj5xU+iBE/Gu9vsOt8OsP3JGOT5x2g
	 IKkqzJh0v2a4A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: iwlegacy: Use kcalloc() instead of kzalloc()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240119171655.7740-1-erick.archer@gmx.com>
References: <20240119171655.7740-1-erick.archer@gmx.com>
To: Erick Archer <erick.archer@gmx.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@gmx.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170601069480.3962299.16944652749116926438.kvalo@kernel.org>
Date: Tue, 23 Jan 2024 11:51:36 +0000 (UTC)

Erick Archer <erick.archer@gmx.com> wrote:

> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not change the
> former (unlike the latter).
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

acf868ff60b1 wifi: iwlegacy: Use kcalloc() instead of kzalloc()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240119171655.7740-1-erick.archer@gmx.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


