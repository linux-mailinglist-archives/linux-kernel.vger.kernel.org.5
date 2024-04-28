Return-Path: <linux-kernel+bounces-161360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E288B4B1C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B9D1C20B03
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222585C61A;
	Sun, 28 Apr 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azX4YpuV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6E45C5F4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714298620; cv=none; b=Og6ss0g4CTCfl7IcvfFHKdH1ncRIaXe6PtZ2TsETl+W4QXUCnv6fZA7Ys9ty8oWNj+976b0PvdmLZDDdWdG0mUe/sXpo6C/GjCg/h2B6YM44LvsIj8GHnhnF2ppfCHj4TzTg6DCxNxKkU7aifBciNc58pgrU5SGecSqgdW0QzIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714298620; c=relaxed/simple;
	bh=/r25Mwjzt2gPZPypRqyLaeMI1Kmvzhl9oJdNh7ASCz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiHkVcnVIfgulSa4cUkIJ0GxN8L/7nTLu8GSd/4zVIKgKiTU+jHsikL72V06LFmJT2Uqa2CDQk8B5aXBiZSN01pUVKN4WSlUqfnElsAXdw/nyoSWHbXi3u497LyMj3hRdMqvlnGkSsJrL2v9sDSX3la0Tk/Vi1pPKQ7Oz25iD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azX4YpuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DDCC113CC;
	Sun, 28 Apr 2024 10:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714298620;
	bh=/r25Mwjzt2gPZPypRqyLaeMI1Kmvzhl9oJdNh7ASCz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=azX4YpuVYO9+yy+KGlh+9njYJnYZLQIJzyrOqkiJIwwInIzkdd37cFYC50EqIo8k1
	 UDBMe4QxunSFLNzF16KePCVbvFtvt6tn0NCntYsl4Rr3cOzDaye/b/MDqg4ACCSQ5j
	 zUWmOPsWTO/UE0QY16jJdaRPEG5RryDHeUFLrT3pTyULhYnW1V1t41xxA9uX09KJLJ
	 ma9+VZBl892EcFsImMeGLrtL3/JLMtzAuQxh3k/Uh9n0K1bhlwilW9lq3YWdgMmqfV
	 fhwKpk26AJ/tnEA9YHoFJ7uQgogB7YC1GdLlU+3I0LcraEP377tXK+D+gOTDVzKpJO
	 p0SNv7CFoej+A==
Message-ID: <89a0232f-e18e-4dab-833c-abc07f817ec7@kernel.org>
Date: Sun, 28 Apr 2024 18:03:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 2/2] erofs: reliably distinguish block based and
 fscache mode
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com
References: <20240419123611.947084-1-libaokun1@huawei.com>
 <20240419123611.947084-3-libaokun1@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240419123611.947084-3-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/19 20:36, Baokun Li wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> When erofs_kill_sb() is called in block dev based mode, s_bdev may not
> have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
> it will be mistaken for fscache mode, and then attempt to free an anon_dev
> that has never been allocated, triggering the following warning:
> 
> ============================================
> ida_free called for id=0 which is not allocated.
> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> Modules linked in:
> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> RIP: 0010:ida_free+0x134/0x140
> Call Trace:
>   <TASK>
>   erofs_kill_sb+0x81/0x90
>   deactivate_locked_super+0x35/0x80
>   get_tree_bdev+0x136/0x1e0
>   vfs_get_tree+0x2c/0xf0
>   do_new_mount+0x190/0x2f0
>   [...]
> ============================================
> 
> Now when erofs_kill_sb() is called, erofs_sb_info must have been
> initialised, so use sbi->fsid to distinguish between the two modes.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

