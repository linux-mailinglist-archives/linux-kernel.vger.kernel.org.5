Return-Path: <linux-kernel+bounces-103136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7ED87BB78
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8091F21583
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361AF60EDE;
	Thu, 14 Mar 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H648jIk3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772746EB7A;
	Thu, 14 Mar 2024 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412810; cv=none; b=dYI72CfWdnJVQdrmZ88eEw/Q0jMDSN2ZuX6wDm2fpO5K8YMXyXHRNoD1V+oLuidt4lWYwvW+iNLd7ine6+vfx6AsCkiCmgesfAV+Pnx7Wn18eHvAlgddtIkKEVh8vtNtuJPx3ibZukYi+KDl1lKd32Fot+56vYPev9eJX/EHRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412810; c=relaxed/simple;
	bh=c4J7TAHcx++DxMeKEfMzpwWlcM8HgZRjo1aIWTMX0T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmahT6/lP57PIg/q4x2GM6vDilPbdMDmpWrXqVCGmiSmSM5rLXXi9iy0K0T4djV2LlVs2Spzc/FqP889di9zeyNg6C6CxeXGr9LAhODQYckFBMQ4R7/bWoLPqi8MSqrgT+jxWJuwykV6mjv8PcA28DzHJttBhx3IW3EqIIwPpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H648jIk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D7CC43399;
	Thu, 14 Mar 2024 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710412809;
	bh=c4J7TAHcx++DxMeKEfMzpwWlcM8HgZRjo1aIWTMX0T8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H648jIk3Ql7cXi/pjB0JMa/jLn7TkBiUqTvdQ623gjNtaz9sC7anE41WVWe6Jx+bB
	 r+Y2MdID87ILDP91BvGCUnnGDvU7oPrfIy0w8HMNsmSXkBZ2MKBoKbCapAXbUX0Ke5
	 eT1WUMZDPPrRa/Mvn9XA1B6Zf2paPSmHoX3zpXx/pKQSDnD27SZyU0yiRguncpCjUT
	 TwxrkbL3gns50MSsjPDOxQurs+gpGctcw8Gy0YGnWqxiCaQ33S2lA/BUcaUqB6aseQ
	 UJFcdvTBTJPWW6lJcgpxSTHU9NWKjBBW+9QvYXSDmKT74cUdGFP4sZ0jZQ+lgMEusi
	 pkphCrAn8MdAQ==
Message-ID: <cd8ffd86-841d-4b1e-9067-c5f0bc3d9244@kernel.org>
Date: Thu, 14 Mar 2024 18:39:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] f2fs: truncate page cache before clearing flags when
 aborting atomic write
Content-Language: en-US
To: Sunmin Jeong <s_min.jeong@samsung.com>, jaegeuk@kernel.org,
 daehojeong@google.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Yeongjin Gil <youngjin.gil@samsung.com>
References: <20240313112620.1061463-1-s_min.jeong@samsung.com>
 <CGME20240313112706epcas1p2ee50d07f603422b0193f0b71bf1a75e6@epcas1p2.samsung.com>
 <20240313112620.1061463-2-s_min.jeong@samsung.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240313112620.1061463-2-s_min.jeong@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/13 19:26, Sunmin Jeong wrote:
> In f2fs_do_write_data_page, FI_ATOMIC_FILE flag selects the target inode
> between the original inode and COW inode. When aborting atomic write and
> writeback occur simultaneously, invalid data can be written to original
> inode if the FI_ATOMIC_FILE flag is cleared meanwhile.
> 
> To prevent the problem, let's truncate all pages before clearing the flag
> 
> Atomic write thread              Writeback thread
>    f2fs_abort_atomic_write
>      clear_inode_flag(inode, FI_ATOMIC_FILE)
>                                    __writeback_single_inode
>                                      do_writepages
>                                        f2fs_do_write_data_page
>                                          - use dn of original inode
>      truncate_inode_pages_final
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Cc: stable@vger.kernel.org #v5.19+
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

