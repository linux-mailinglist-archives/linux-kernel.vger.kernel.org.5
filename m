Return-Path: <linux-kernel+bounces-137797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E17389E7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1EE1C217A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345210E3;
	Wed, 10 Apr 2024 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVDyR12B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676764A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712328; cv=none; b=aXdilf1OnqcKMmYfq4htGBTASurmda+YnxnBzWHcfalCFxtA4uxfDhlPr8kRlLxUC46EIwzVqZv/0cGzq7D4aL854oWUo3V7KfB1UEL2UHvZWpri0M/B5/mOSTdHb6jXP/TXoMfGdTWvGh4Gq/G67YyVjUu4mZPngUlG6Hkdu18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712328; c=relaxed/simple;
	bh=Ou5zIoiVqyh7NGlOGsFz+bFF2CoeqMAsgzjLT3LU3cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuJHe+P2xXllILO4+IHVlGkDHmiuXsmeEWpvv4UT8x9j7vQSV6ge0RaB/xKeISBWePzuHlhhlKz/HMuENn375ndikIvwX7lRzEPhMqF1wREzFa1QCNqcH8uW+Ev0mUAkGCJ5YE7EVkoC7og0dlNbUs1T1RLoW8clBWjOFyaC0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVDyR12B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC26C433F1;
	Wed, 10 Apr 2024 01:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712712327;
	bh=Ou5zIoiVqyh7NGlOGsFz+bFF2CoeqMAsgzjLT3LU3cM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oVDyR12BfVxGXBv25opL4e4YGBJeCythNo4XuWRN8hBXxkCZBO59Qs4rphAWJbKsF
	 IxUQ4rvEV5PYeMSnixqRN3elKr4mB3/Lc+ruN/GKSf0UlyVt8DQwdCY6Akj9DblSBQ
	 bXBe3qHcISDy1yWLrM4FmDOWzA1MHphtNDk6R0SWEUKuICgT+p3zLyW1zqJUT24N8s
	 u4/Gp5bnnCPYL+kzDV5fbz+f4Jgm6cs92h764vA1FkZ5/KSZ2oxUHTS/InUDmQHDRE
	 pwv0EcN4Bex+tHja5Y6olVWeRZVgzEqaOKy69TasrhH813N5rt9WeKA9hSYcJY722l
	 etrMReabFl3nQ==
Message-ID: <6a7442d9-edee-4a03-9a6c-2ff10fff121c@kernel.org>
Date: Wed, 10 Apr 2024 09:25:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't set RO when shutting down f2fs
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Cc: =?UTF-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
References: <20240404195254.556896-1-jaegeuk@kernel.org>
 <ZhVqwwCesxWOfbOA@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZhVqwwCesxWOfbOA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/10 0:20, Jaegeuk Kim wrote:
> Shutdown does not check the error of thaw_super due to readonly, which
> causes a deadlock like below.
> 
> f2fs_ioc_shutdown(F2FS_GOING_DOWN_FULLSYNC)        issue_discard_thread
>   - bdev_freeze
>    - freeze_super
>   - f2fs_stop_checkpoint()
>    - f2fs_handle_critical_error                     - sb_start_write
>      - set RO                                         - waiting
>   - bdev_thaw
>    - thaw_super_locked
>      - return -EINVAL, if sb_rdonly()
>   - f2fs_stop_discard_thread
>    -> wait for kthread_stop(discard_thread);
> 
> Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

