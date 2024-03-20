Return-Path: <linux-kernel+bounces-109088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4488147F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0D1B222AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF845524C0;
	Wed, 20 Mar 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIuESAPt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E34C61F;
	Wed, 20 Mar 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948356; cv=none; b=iBfOOiC+3/jkue5x0spiZUAA6DWtvttTJpGQS4qfG60aWIwfd9tyCIo/Wg/Z8Zq5sfN3GYurVlAHjedonllWQ236LpHL7Vn9T0sEDMrQphIrZ7VgekAvulg2b3G3qVBvinrgMMz8amF0Kf/NEB09MDD43JPkhzyrYja0ElQmbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948356; c=relaxed/simple;
	bh=0UWHhH7UBptN7bELngpHg4QMteISn0vghq9W+vJ512A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iIsJbwlHYhkb6HAPsZ2jZBo7QTc2xapPSJOzDoPN6foE+qewKSn4nqhGf+rFVKnIk9QscZE5OzI9U8IcjLWfRVLQlmkLWdLWyoN516ogymCtvr1ieVAxhwezWwH1dX2fTmMbT7zs8JQbf6ZXizoQtGXUsSYqI6ADGQoSIGkVcFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIuESAPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF0FC433C7;
	Wed, 20 Mar 2024 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948355;
	bh=0UWHhH7UBptN7bELngpHg4QMteISn0vghq9W+vJ512A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MIuESAPtRv5GCgirO/qyzmRLvHHXJCOrd8plPAqUfLX2iR/7j7XUgPTzp85BLcf2t
	 JUMAxHHID/F3grlo60zxh7IOHAutVwv2Bw77Nh3uF94JTl3HeBxVN5CXrHNqJkLEoZ
	 RZ2WsXwn6RnI53FjjkCIqecI8Wlj8s6/U0RxYanVFyy80rQlcARHCa7kGsGOfFZLfi
	 ayJKHO3W78VYlmjzB/4RZ0ZgSAPONOi6qYKHVHcX8TujvDzcyL861ms/7HGtAOBnrf
	 I+4BubwtX/3n36arXTF00LzJ4meYKBO5jMgH73O07HuFOPPdgBGCivkYaBRdy2rIGI
	 W++pT72selqRw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Breno Leitao <leitao@debian.org>,  Jeff Johnson <jjohnson@kernel.org>,
  <kuba@kernel.org>,  <keescook@chromium.org>,  "open list:NETWORKING
 DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,  "open list:QUALCOMM
 ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,  open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
References: <20240319104754.2535294-1-leitao@debian.org>
	<9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
Date: Wed, 20 Mar 2024 17:25:52 +0200
In-Reply-To: <9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com> (Jeff
	Johnson's message of "Wed, 20 Mar 2024 08:12:46 -0700")
Message-ID: <87wmpwaprz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 3/19/2024 3:47 AM, Breno Leitao wrote:
>> Embedding net_device into structures prohibits the usage of flexible
>> arrays in the net_device structure. For more details, see the discussion
>> at [1].
>> 
>> Un-embed the net_device from struct ath10k by converting it
>> into a pointer. Then use the leverage alloc_netdev() to allocate the
>> net_device object at ath10k_core_create(). The free of the device occurs
>> at ath10k_core_destroy().
>> 
>> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
>> 
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>
> NAK this based upon the ath11k patch results.
>
> As suggested there we should just use kmalloc/kfree to match the existing logic.

BTW if the patch is not tested on a real device then it's good to
document that in the commit message with "Compile tested only" or
similar.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

