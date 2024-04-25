Return-Path: <linux-kernel+bounces-157904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5A68B186A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A47BB24129
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FAB101E2;
	Thu, 25 Apr 2024 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf8mb0Bn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FDF9CC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008242; cv=none; b=P8IK12CNM/NJ7LTvVWH3dznI7/FZfnkGr3oPnh2SnhIyrRlaJqwM6KU6Y6Q1/Ch/fBluUJDyp+GVlXlUULf+qLWDuxqRf04u2j+JvRb57uJYxD1D+jHmQJFNWqq3LfjxoyF31gCWXOn6sgTOay0xKMrMuDh4r1ZLxyI+PSeOhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008242; c=relaxed/simple;
	bh=gwiGGq7OLeRP9rMmRvbPh6yrmriPk2uQO+iB3xYyuD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NL+jmcmmkEWBHLFbzDJL4+dlYye+BUGIJrFb7YcI95j4rXBrJ8q7gzHgokJrjGL3MpCL3LiRJ7OZCvdm1qBI+poxhxcWBrIRBAJt/OY6zOvtdGAwTkXObYpuS8q7+6O2LrZBFR8OxzE+w9vrqzbDrg21aNYrUn+Svivl204FFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf8mb0Bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC4EC113CD;
	Thu, 25 Apr 2024 01:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714008242;
	bh=gwiGGq7OLeRP9rMmRvbPh6yrmriPk2uQO+iB3xYyuD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gf8mb0BntIbxrKEVFT+hcbIzJu0aHeHTd9zBPxbTItCaXkWD24bprdH34+f4b/qZO
	 eo22RryNgJT6H1gArqKLq8An0Nv7n3WD1Mqfa81FfJLu268B5RNkollVNIRWrMQas3
	 lwNkcI1ibi4FKnYHeYOFF27FpM7CkE95563mZd6zoYc/K1Dkz0VsamcjWHhaMjFbRk
	 I2gfaMS8kT5/673Ld/txPAWXgXKYO0KnALqM5QhkS9q7HS0T+46KcM1eo6fy5VLFgG
	 gH0tT529EUyq6PEFHCuVGv9YGWLfsINjseMh2q8iZ0IV1fGxXMBJCQVtTzovNbInCI
	 7/ORLYW/l8XJA==
Message-ID: <7bb95d2c-be0d-488b-9f0c-23167d84e057@kernel.org>
Date: Thu, 25 Apr 2024 09:23:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix false alarm on invalid block address
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Cc: stable@kernel.org
References: <20240424173548.1515606-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240424173548.1515606-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/25 1:35, Jaegeuk Kim wrote:
> f2fs_ra_meta_pages can try to read ahead on invalid block address which is
> not the corruption case.
> 
> Cc: <stable@kernel.org> # v6.9+
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218770
> Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid_blkaddr")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

