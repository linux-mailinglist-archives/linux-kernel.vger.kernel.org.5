Return-Path: <linux-kernel+bounces-82736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1148688DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2C1B2297F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7761353377;
	Tue, 27 Feb 2024 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaq4xH5c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F55336E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709014117; cv=none; b=r7FP+8MnSCiAiqeA69kGB9TcXc6zi4JFyOk817X5iWLXJd4S0nNkyy1BSXtNVJSL/NAIyglfmz69YQFDuysF3t8sl2WYsFcTqHgp1TQKQSnJswgO9Nh/pnsOLQEi0LziIyLiJhVmuHIMu3JOys6c1FzpocmXdxR3KxuEsNSEW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709014117; c=relaxed/simple;
	bh=zyZ53bXR7NudODqVYwDdT0UwnIl9wLhNRm6xad5mwF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BzN5xcCaReUsOa5dkd9DS1E0NQqtEElt7PTfPF6vJyach2DOu65P3SJFBqilOXoajCBGLZ8lv/hn94eU5wLtWS7wDkHl+RUqTY1V2ZevEqVB0kT7gc1H5jqKnDejRBAPaJMxIEHEezIU3Ey/oAmnZ7qWCB6iUVDX9afQU0XMGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaq4xH5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D443C433F1;
	Tue, 27 Feb 2024 06:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709014117;
	bh=zyZ53bXR7NudODqVYwDdT0UwnIl9wLhNRm6xad5mwF8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qaq4xH5c7VeCzJjc5mjEH0XkwhczWdFoKePFxbXKp4YGH0th+3DGsEbFmlSEP0JoG
	 1JFm2DdfNKc+/+cNNMxfqBbOUPKQbqgavpesyfCD9gkPvhGxG74stgbksDT/gGjTvM
	 o8gy5feGCR2wcnbkz6NI/GwiwkrJ8DUKAvVK3PCs+yQY7ipKxqWadvHj7wdAabD1d8
	 houexgAywN35U6sDPjTp/l24LuEJF5sLZJqBtD/drFJFwhQMtLH2p+4HHdC9LTwkxe
	 7yqcZ185YFUGfQ2cceNVw3+I+7W3f/mHML4Zuf1FgWpsG7IrrELm6G9cheyvLIRA5O
	 KccidT5fU3GLQ==
Message-ID: <be97cea3-fb46-4c87-b858-e28f31bfa45c@kernel.org>
Date: Tue, 27 Feb 2024 14:08:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 1/5 v2] f2fs: check number of blocks in a
 current section
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <Zd0bUnFCWmPtwK2u@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Zd0bUnFCWmPtwK2u@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/27 7:14, Jaegeuk Kim wrote:
> In cfd66bb715fd ("f2fs: fix deadloop in foreground GC"), we needed to check
> the number of blocks in a section instead of the segment.
> 
> Fixes: cfd66bb715fd ("f2fs: fix deadloop in foreground GC")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

