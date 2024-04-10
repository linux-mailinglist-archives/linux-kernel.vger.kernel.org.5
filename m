Return-Path: <linux-kernel+bounces-137805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5261889E7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C8F1F22ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8479A20E3;
	Wed, 10 Apr 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMTN7850"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD4717FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713074; cv=none; b=bAHq3ZA5QLe3srLnZc0X7Bt/fw4XCJ37327Lpm3GrlI8zetcKCsB1qsWqAzkj0OfLRVTEkBrnsU0fpj7SlGjZ1wlwFEOogKNUkeemzazyV3KypHMFYXD4dAbwjiBDmamyShPPiOC7mtlMa4YzvzDsZF5QrWz+BxyXjqn+PQaF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713074; c=relaxed/simple;
	bh=j0XT/UNN8yGtPAmEwlK2RwyMQXk8mWRburu1amJVRx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1sb4eBANv7mqxPf0qfqjUuG+bE6dReUQJM/cM+R5YGPeJvgQYt4ASpF25XsODmmkRLpemKTmB8308hN7PC8/DP2K5iLG6j579gH5xO+5A2ffFFVhJ/7cVWsn0E8uoaWD9nSmwsRaQPM1MI47b+EhPKb5XKc4EU4/GaRtJzxc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMTN7850; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95C7C433C7;
	Wed, 10 Apr 2024 01:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712713074;
	bh=j0XT/UNN8yGtPAmEwlK2RwyMQXk8mWRburu1amJVRx0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZMTN78500hQJFeDYbSgpBReY0tHTAgjJzJd9Zj41fcg9xX6h7Flun1g9HhgcoCAe7
	 Y2kI1petVXLj/cvEOryWuSiTImaK01Eti5XYHS5nLvHwvf2MG1rwvx8q3zrAa+AZwy
	 fI/3/AzlrooXQEDyFUXi6ZHRb3U92KQuQe1YCKrqO4foe4npYUJRaxBqveSqCzj9QA
	 y4RxWxwgRtLf0hlH6+Einz+i9YcaDeMnklUaIE9sIoRnSp5XvKBPOCAD8zjZOO0izB
	 qmtKBwlzwCpFb65l2o88AHuJGOCK8OHSEWWx6eOH73uOCWY6XkIqQ+ZGhKUZvqPG6z
	 2w2YzOV5H7LTw==
Message-ID: <4885b9ef-6e2f-42d0-b1fa-bddb42d74a2e@kernel.org>
Date: Wed, 10 Apr 2024 09:37:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: write missing last sum blk of file
 pinning section
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240409233411.1197830-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240409233411.1197830-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/10 7:34, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> While do not allocating a new section in advance for file pinning area, I
> missed that we should write the sum block for the last segment of a file
> pinning section.
> 
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

