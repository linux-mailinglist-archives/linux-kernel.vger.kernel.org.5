Return-Path: <linux-kernel+bounces-98439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AC9877A31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C26282147
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4E187F;
	Mon, 11 Mar 2024 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glp0MAwd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7916FF4F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710129035; cv=none; b=mgDsNNJPjLV4S8M2/kITBMj+AK7oBMe5t/kXx8k1KpEzy6F0Hp/lyh16VpHycJNrZlqNKjEfkrpmHYqx2ZUtqqAzwhgr8Z5KQ7INTJuGht+hQMGf2B+GyeBByzJ8ON4rTkf2F5JPitQdgtQhWQF7duEgEflwgOo0X9MblWJp5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710129035; c=relaxed/simple;
	bh=W+4Sfk9+nuHnW8aLHz34FpkrVlLiz/zJEGeiijQZNcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0NLpNAxSG+V/7jKaxsNlMSK2MG3Zv38NYJ1vTqWIGQHyFpeEXsM7FNexAKIg9h78Qol+Ly7SrcFNivhU2UzOng28t7xPEFZnkFGTJPfRyoR5M2kRK3IBKG8V4x6LVrEYFNuXn0oYbm+77G3A7M3rCdCzS9mt9P2fov5Ms/X10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Glp0MAwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB53DC433C7;
	Mon, 11 Mar 2024 03:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710129034;
	bh=W+4Sfk9+nuHnW8aLHz34FpkrVlLiz/zJEGeiijQZNcw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Glp0MAwdBKX9w2i13VoX/xD6FHJOXNDoicz0GLPtX59QsySdSzq8US4zme6w4b6Pz
	 HtS610j49I435APdmlZLEq8fbzUexLj6sZFvw5aarZ357C6EuS1qHELzXpJpOaq+4I
	 2jz7f2Wu1Hxo8f/qrUasVY15TA96+qmduAecC2dKiIP5e6O72XWgPhDxrOnqgGAelo
	 HXaYuEjnP8sVALBJIrXszAomnd9HYwE1tgYm7HvnJMR8FcW6VtwwBLLZamqCHCV1F6
	 294zi8UVPwguYY4bTcLiTwHoX8NEJHEaZKhYs8uAb+gToJmTdmIxeaRtU8wg+hShq9
	 43HeSnCFRY5Gg==
Message-ID: <01beda7d-5f53-4dda-8df4-8a1cd71f3bfc@kernel.org>
Date: Mon, 11 Mar 2024 11:50:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8] f2fs: unify the error handling of
 f2fs_is_valid_blkaddr
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1709879125-24671-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1709879125-24671-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/8 14:25, Zhiguo Niu wrote:
> There are some cases of f2fs_is_valid_blkaddr not handled as
> ERROR_INVALID_BLKADDR,so unify the error handling about all of
> f2fs_is_valid_blkaddr.
> Do f2fs_handle_error in __f2fs_is_valid_blkaddr for cleanup.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

