Return-Path: <linux-kernel+bounces-134147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AC689AE3E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CF52818E4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91255184F;
	Sun,  7 Apr 2024 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsY5VSIX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AE1C0DD2
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 03:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712459924; cv=none; b=X5dzboS8P4BiDcBm8m3ZCExT/1t0xZ5wMNp1es19bZ4XaD04mPeFFtCmh2N+5XlT+qYmCH0dX5pMafbpxQ0Gu5HYDd8ien2GnWoEozLC6F3DBL/zSxiA6V6N2OxehAL8oo7aNLQGKkfcwLjN02FpyOT6yjNgA3S99iaSisLbbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712459924; c=relaxed/simple;
	bh=GfHdM845LVYN0VF6JBM4aQ/V9T9fVQ4Q9Q1cqF4MPfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWEQ6+Cyd9fR14HryS851g596TxYsz/dr1r2fVTcSfqmC/knIOsPNhYOMiv6KEIwe0Y1sJ2pHSJZOhYZ1Tr5pcmGhnEJirgQk19DTe/RB+BdKy+BPLpCdnR8kghX/opAMlpxr9oOpsWVRR1uWRdNPzq0RdYHa7KaWUim9NAeNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsY5VSIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDD9C433F1;
	Sun,  7 Apr 2024 03:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712459924;
	bh=GfHdM845LVYN0VF6JBM4aQ/V9T9fVQ4Q9Q1cqF4MPfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CsY5VSIXCwd9RjyKto8s+bj5xSu9koFkrbsW3JSFb9Lgjf4dp2FLBXM51Y6t6WWLO
	 DyVJGPTWPh8Ku4mCHD68+a07fcPntCkegZVFlorwFC/IFOZGtcRS7PEAoei/t8TAfA
	 OcBtS5Pi0CB1f4B5iqzwLcueBWPSyNIa8ke0B5ZucFcogEdmBjK8kzg3va2V87W3+d
	 T6CYH+o/VYHblE13Xz/oQaa4j9O1r2qK8ZltMbPnBCYw+pJTjkj+/I/ynLQuz6wleu
	 hBuMNQozMSL3xzvZmTO7T3XSVzYnw1ozReplSMss89Nn9JEeHFy5HXlz4WdDkMBo1j
	 l10rbrGpwrmeg==
Message-ID: <d6546291-53af-480f-87d1-6ef06e8fe58e@kernel.org>
Date: Sun, 7 Apr 2024 11:18:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: prevent writing without fallocate()
 for pinned files
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240401151351.248913-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240401151351.248913-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/1 23:13, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In a case writing without fallocate(), we can't guarantee it's allocated
> in the conventional area for zoned stroage. To make it consistent across
> storage devices, we disallow it regardless of storage device types.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

