Return-Path: <linux-kernel+bounces-143660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6862B8A3C0A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9859F1C20F37
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1B43E47E;
	Sat, 13 Apr 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/baFDjr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D873E462
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713001970; cv=none; b=sqOOfahMs+vwIwolHnRuxm3XGAcMWq+w7CCPdV7Z3hY37rxA+L+snKBCml0t/dg1TFgZNvRI/rUQ+AlQY1UlSMROU+FFug5aRVQUJBNGLA/WcBYdBiYSsAwx7oILJOWEM2uADevp8DZjppLIFSYdhLkE54QSdx2FnR5semeqtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713001970; c=relaxed/simple;
	bh=Mp/k7oxUFkv2UFyK/q+jMiwjME21YAKpLNPyj5vic3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xb7xIgGvftWqs6+6cJW38HAw3Ow0cvI1BriB3FijNoM9CYE1SqCx0QIYFczs5isUYb1LP/mWhjSM+c7QTcR73cEYZfB7jstQNw1iRi2e6PS65rhCYl3kMtPAvBqSK3mC1cm80uTLxd0ACfA6ncYSFy75cUvgAmNlvPGutgx+7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/baFDjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6179DC4AF13;
	Sat, 13 Apr 2024 09:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713001969;
	bh=Mp/k7oxUFkv2UFyK/q+jMiwjME21YAKpLNPyj5vic3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H/baFDjrcnsD3y0M27D9f32q5FfOaxBaVIKAp+xYLOxz/I28hP1axDTkLF3+b4BUR
	 pHDKate8WfXYlB8PpFy/Mhx4j4pvg3rcv2DOpluoWAtCaum7Nk1dnms9ASGebOg0tZ
	 JP6DnHDWXSyz/bNTO+wsZ9qKBeeJWCXCyBaBKnpQRubOg4QOqPyG+wwrDH31JY9Bop
	 qyI29Hzi1K27JKKsV/WhtE4IyvFgYB9Sd2xW4B3k+pK08Fk0eA6JtKMX7r2XZSSk27
	 TkuLbNbxLav25m9JcS8iPuWzyozeoJIeZuOl1oraabPg5rc/rK7utHM/GyFzadD6G2
	 VVplByDUV7TRQ==
Message-ID: <ede7ad82-29af-4bc1-946a-d47b59de8e46@kernel.org>
Date: Sat, 13 Apr 2024 17:52:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: prevent writing without fallocate()
 for pinned files
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240411175410.2406710-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240411175410.2406710-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/12 1:54, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In a case writing without fallocate(), we can't guarantee it's allocated
> in the conventional area for zoned stroage. To make it consistent across
> storage devices, we disallow it regardless of storage device types.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

