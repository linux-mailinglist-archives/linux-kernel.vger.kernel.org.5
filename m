Return-Path: <linux-kernel+bounces-32281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D9835961
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA801F21396
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D04A35;
	Mon, 22 Jan 2024 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjKh7hPc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD114A28
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890844; cv=none; b=rTjjb0jCN8kVGT6UjD7dQqJNEhjWYBW7MqwZJmE6we2UaxD0SQHRRmE1EkEHDSs/58bmLk25/ORoa+CoZ1F44wgBzPFx0faxmo5wYsQOPNYEYrxrVTL6VmMynwVdjQE43txpbtK/tiYcURZIldHd4zP+M/i6shD+zNJ6zt4GyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890844; c=relaxed/simple;
	bh=UwYjuWCbVnv0zBlVv4pkaoZN54Ie0tuuwcikr3lhwrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa9CZZhfTrAmbV8fAsXt/IdNokZq1lRnYFnXqvih61EmVzKzVWbKFEpUZ3yp1/Poz3HEfTPeUpY2Tresj/GTRMTZ5n8ikayNVxSsCP0pkt03y3mJe3a21+AmCkGTvFXnTPcy4YQqslrtfkELE8skaBjC5RmVW1gAb50oc1Ykmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjKh7hPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33838C43399;
	Mon, 22 Jan 2024 02:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705890843;
	bh=UwYjuWCbVnv0zBlVv4pkaoZN54Ie0tuuwcikr3lhwrs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CjKh7hPcTBDqHYMLfNQpz9/Z2qZkvb93qRtGT0X+yAP9NvycurHw06E5cXy99DsOt
	 hNw9CvjJe/vGBGbTDCIRRYp9ll9benWf8kxXNYG7dG9B/oodaNfmcuE7KF0dPhOAg8
	 60SHvHtZlnWLq6rRfLoCi/xfj/ColIugpe9B9s8MWjmTOjK/Uq34JSTbhfu5Qn2CJ+
	 IficEbrANFTUzdWQN2ExtDnrtYhrskuKeT6+xBIPMUTzAtiEQ9+Q2905JSalG2qqwM
	 dGnKANcb/LnUzKIQrbpqxQGUnBZCbQv0UE3gFGfe6YBpl+W1V7EateITjXKhzTaR46
	 aRIb2kUbTuDYQ==
Message-ID: <f9e0087e-afda-49a6-a5a2-1d5ba3098dfc@kernel.org>
Date: Mon, 22 Jan 2024 10:33:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: use IS_INODE replace IS_DNODE in
 f2fs_flush_inline_data
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com
References: <1705478398-10890-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1705478398-10890-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/17 15:59, Zhiguo Niu wrote:
> Now IS_DNODE is used in f2fs_flush_inline_data and it has some problems:
> 1. Just only inodes may include inline data,not all direct nodes
> 2. When system IO is busy, it is inefficient to lock a direct node page
> but not an inode page. Besides, if this direct node page is being
> locked by others for IO, f2fs_flush_inline_data will be blocked here,
> which will affects the checkpoint process, this is unreasonable.
> 
> So IS_INODE should be used in f2fs_flush_inline_data.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

