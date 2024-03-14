Return-Path: <linux-kernel+bounces-103126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34EB87BB58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208B01C215EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE975A0F9;
	Thu, 14 Mar 2024 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHqFn20q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E06347C1;
	Thu, 14 Mar 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412505; cv=none; b=YpjmaS76p3KYQ3noYPJF64G+zxaTohHlNz4QDpappZaaX+xPOUDl6QRp0XKotrhXBrBEArPbpDuuxaHBoiiiO0fhFD/kZ8fdWsrJB+XVfymBqTFWvuy5Cc1jMU3BRH8eMmyxaoQxBQHEWzTMxdz3yNy1oGWLEtHTmrwfv79zFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412505; c=relaxed/simple;
	bh=Hgh3vqIzWxqRwj99BTgkEyg/C7Qp+Y8i8zd0DBoV0s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSoXmPAe4/2nHRYRneACFn+E9kWhBK4VtfW09DxG9H7xwVPkOnEXCPADJIP3lw5IBbFlLxohOZdyiLpaZGdypHksSUPnWpYOpAG8ygIn/VwcuS5KYrNfS0ZQk219ra9ZohsWAkh6f6w00T2qUbzdI/kznjhi1/GI2i9/9USGeq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHqFn20q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267A9C433C7;
	Thu, 14 Mar 2024 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710412504;
	bh=Hgh3vqIzWxqRwj99BTgkEyg/C7Qp+Y8i8zd0DBoV0s4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QHqFn20qzFzCc3m9XfQtjPCP8ChhpEfXDlzVqGaAq47X45+NtjjXk/uAzTEYBhAXx
	 DvWcywyLjDORNUYnc90svStElyasG9rDj8NFgIBcmApxxoIkUxhQpORosFnqVAWmMj
	 whzkLD6oN71LZMFvA6Q38imkZoQIRO/rtyduiUUTsduulq1UnJdeiNtcrxaYfjCOnp
	 JvJcsCQ6jDE8Mj0A+FIfshIXXEjiIAWxD+JFpq6uGbbxfsLsK7RJyhgVfsEMqGdRlY
	 MEAUFK2AxCgTpmFLRuOVL9rcE6xzFwMPukiGGvsw3G1d1NZFWNu+NPEkJYEo1hg08Q
	 +xmlAYrfH0woA==
Message-ID: <9049ab55-7be4-4cc8-b2f2-2cc355f0bc8e@kernel.org>
Date: Thu, 14 Mar 2024 18:34:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag
Content-Language: en-US
To: Sunmin Jeong <s_min.jeong@samsung.com>, jaegeuk@kernel.org,
 daehojeong@google.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Yeongjin Gil <youngjin.gil@samsung.com>
References: <CGME20240313112650epcas1p3e65fdc5f6df18a4f700fa62bb5480b28@epcas1p3.samsung.com>
 <20240313112620.1061463-1-s_min.jeong@samsung.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240313112620.1061463-1-s_min.jeong@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/13 19:26, Sunmin Jeong wrote:
> In f2fs_update_inode, i_size of the atomic file isn't updated until
> FI_ATOMIC_COMMITTED flag is set. When committing atomic write right
> after the writeback of the inode, i_size of the raw inode will not be
> updated. It can cause the atomicity corruption due to a mismatch between
> old file size and new data.
> 
> To prevent the problem, let's mark inode dirty for FI_ATOMIC_COMMITTED
> 
> Atomic write thread                   Writeback thread
>                                          __writeback_single_inode
>                                            write_inode
>                                              f2fs_update_inode
>                                                - skip i_size update
>    f2fs_ioc_commit_atomic_write
>      f2fs_commit_atomic_write
>        set_inode_flag(inode, FI_ATOMIC_COMMITTED)
>      f2fs_do_sync_file
>        f2fs_fsync_node_pages
>          - skip f2fs_update_inode since the inode is clean
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Cc: stable@vger.kernel.org #v5.19+
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

