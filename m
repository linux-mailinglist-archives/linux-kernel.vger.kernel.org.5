Return-Path: <linux-kernel+bounces-47942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2127B8454F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED1528B221
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2EE15B963;
	Thu,  1 Feb 2024 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeBRUtQj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5915B11D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782360; cv=none; b=Fv4sDkP7lry/FHYg4JE7l7kOsQuOPaSqdFtXG8jPb8OO4EuxzJQlTOuEGtk0+WcM4VHNJYxHBQWjJvrxUGS1d+7y7yPqqgoguY4ADksZ4GoSNMUF/Jh3HSM0dkE30xHBfesbcchnCvY/jXutg7F3qM2kXhubWZ7Bn/2LyAhlpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782360; c=relaxed/simple;
	bh=xgv/7hDr2uvhT7hu1oZd6ibQtw0XJlZmREdi4If0dxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQhvwbv+tEFbVjKl44e7l8Z8I/GwNV65zFByd0Ffx9N2qJhDZ+xVbh7ERympIcv/RHBp21tk4vC/Zs6nIMMrWfZ0ZECZgbOhxNKZhKgsBjZS8K92yk4n18H7QgqjEPpoqR6+bzXWc+dnniRTjy6RMgmHNPdBi2Zm7kW0BxgsLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeBRUtQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D16C43394;
	Thu,  1 Feb 2024 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706782359;
	bh=xgv/7hDr2uvhT7hu1oZd6ibQtw0XJlZmREdi4If0dxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OeBRUtQjoGkGyIx+UPEsbNTOt5bobSGpbkfynd/vSy173VNN9xUKOwntk2GOFDXEX
	 lCe4+Z48NGrn2/YWiSskdNeCzGGp2xdzT6uP/qtfwOAGM46sodToE38Lf+7bJTL8lW
	 N+NNhsPYx1RCHrzO/M0qlxcVt9fUVhoKrmo6jEaovFJGkh+0Zmdei0Tv64aO0i15nt
	 f6cMVU1n7spLN58C8YCLzRKibb2BN54pNcyn1w4I6SJDD8bfYYDkfjAYZNwgTCj+T1
	 IFXEdEkrfv8lhOKkKocK8Cmbn3zUK66WVosQO3gXN6RTdNvO6vTR1fC7oeFFBeTrDT
	 V/UbQUaywzqbA==
Message-ID: <e7809d8d-a8da-483b-a52e-cb3ee5583db8@kernel.org>
Date: Thu, 1 Feb 2024 18:12:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2] f2fs-tools: allocate logs after
 conventional area for HM zoned devices
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240131183306.536372-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240131183306.536372-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/1 2:33, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Make to allocate logs after conventional area for HM zoned devices to
> spare them for file pinning support.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

