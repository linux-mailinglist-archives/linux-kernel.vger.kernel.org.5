Return-Path: <linux-kernel+bounces-87756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F03586D893
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2781C20E06
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1AB2B9CE;
	Fri,  1 Mar 2024 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaRpmYTF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106D1FAB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255736; cv=none; b=N0z9/MlTs9l7W1fDQMgeZY2YNd0ce/MshafD67/N6Bsgup2zgM1f5cpLeIjUkjJmCAT7HBKsOb/kOPcngBLIl+KEnhNClrChDF1+yR0VrKA5V6QESk/QnIkaIr7Uo5SAZHQdirF7oFmxtMyLXuz2x3c3wHOmQT0fYXjpBo7tOOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255736; c=relaxed/simple;
	bh=C93BUuyWefWIHd961kpiGpVzFvnTiGjz9VvWBdFszQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXT0LO+TLQg2vBqdJ21cmltx6ePB+375m2PtqlC1LxzEz/VeqW214ZwmcCTOL3rem+Iv0k4wo5FFeumWH/52R1AoFk/C3eXfIb2FkX6njrFOfySQMBpXIZ3XbaMI2VdouL4Qfr3ovGrlTZrJzWklgbMqo43XeO5p83vXn9Hgxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaRpmYTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C109C433F1;
	Fri,  1 Mar 2024 01:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709255736;
	bh=C93BUuyWefWIHd961kpiGpVzFvnTiGjz9VvWBdFszQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MaRpmYTFVIE6Vs0hf2Kj+mp1qbjMPivsvKxvSqSUTptitSMJcCbTI0czh+6c1bGTV
	 1RZ4kQdDOOPIEpsjZsC7O9clv1XikchBQofj3NCc1ikXqh7AiUNAsTEhXhhRqmSS9X
	 06waoeyn/L3jJoL5NCYmUgI8X3LgDmN5gU2qfMxlHZOmuhIFR0lDCeYGNZeh6NfGVq
	 LSe6QE+hODlXtat+nocTvJKar3VXA9k/5IooxyZ3b4y6aFy248xvi64U1hGL+FE+eW
	 zPsCxCGaujHoGoMxesj+rZp3N0X4yVZk7aoYuiHCu/UQx3hzc1t+mZJbtD9s9Hbcxi
	 P69kJkQHj6VcQ==
Message-ID: <356f3dfc-1dff-45d1-862c-4784af763b14@kernel.org>
Date: Fri, 1 Mar 2024 09:15:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to do sanity check in update_sit_entry
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1709121594-22314-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1709121594-22314-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/28 19:59, Zhiguo Niu wrote:
> If GET_SEGNO return NULL_SEGNO for some unecpected case,
> update_sit_entry will access invalid memory address,
> cause system crash. It is better to do sanity check about
> GET_SEGNO just like update_segment_mtime & locate_dirty_segment.
> 
> Also remove some redundant judgment code.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

