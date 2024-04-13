Return-Path: <linux-kernel+bounces-143661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32D08A3C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBFB1C20E84
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386C3716D;
	Sat, 13 Apr 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt5RjD8m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0018B14
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713001982; cv=none; b=gf4aIN+UqALwr0OQgqypiIETTMsIHRMJHV4jt5wSkk6EoFv14T2/sLc4OAShfNcTduRnEwoB2UJMv8r6vVhMrimunfrhjF1KMvglOIGwvyEGbhrKiDv14uBBo23tUtgGqSWwjQSifBsPIk2sKRWNgYEMJI4y7+B38anibHCxNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713001982; c=relaxed/simple;
	bh=rEBv6Uch7IwTGGDlnmOB5YgZdyMlc3kQYiKLZ3AnE34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/9ViNx2Zv2yXQmQ8k1byKnNQwooP3gI9NErhIi++mJnjs+BOT7sPV9kgrNqb073jaQq980EMlSMsWvCyGM9l67idzQkzSkj+TA4BbFxOSjY2fvx+fi2mwFJrwFf143a58yRhmRdjQPlTRtX+kx4JLuEzVcCPpZTxNKu8O55FBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt5RjD8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE67EC4AF1D;
	Sat, 13 Apr 2024 09:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713001982;
	bh=rEBv6Uch7IwTGGDlnmOB5YgZdyMlc3kQYiKLZ3AnE34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kt5RjD8m0LTt/yzo97q6XHXIozi28GbrYLcc8VAvTKI05Hy+Mqci3x+0HbBR+2oOm
	 k79n1ip/XV7sRHdsONhueMgPaDJoIdXPkgQz8BVCxLcltf9BMldbmbTSYEiRPkc9Ek
	 6Pzp/Yge9Za5mkEb/mYNE+Q6kK+bxgSf/Rulve/1DRkCO4NFnKM5uq3F7/x1CsHwwL
	 2WhPKGk4cJbLgY1MMlV0/sq9TPmiJq+2KL6ie8iImI14iCrFUuALfuFtwxpEXG2nP7
	 jeZQINGzazCVQEdh2NkN4QiR1apqUNeHcNwoCeeQ7YYUtEdh/f/xZMRZc+LdhW9Tx/
	 lmYuk7NnENa9Q==
Message-ID: <5528dc53-20a7-49fa-81f8-4068ff85987a@kernel.org>
Date: Sat, 13 Apr 2024 17:52:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: allow direct io of pinned files for
 zoned storage
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240411183753.2417792-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240411183753.2417792-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/12 2:37, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Since the allocation happens in conventional LU for zoned storage, we
> can allow direct io for that.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

