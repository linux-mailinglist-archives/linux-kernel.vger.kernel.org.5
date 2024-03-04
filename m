Return-Path: <linux-kernel+bounces-89964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEF986F838
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8889280EDF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4398F1362;
	Mon,  4 Mar 2024 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz29fLeJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB1A31
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709515684; cv=none; b=cOVEN7zod+BfGULFJnXTOOpHaOJxvilcKGDDjs0oPA7gOolR02FxKYcgTCHtGpSIcmVHNTYZVJNDclGVqI50rui+WzCco3tDu/anA6ZTLxbrzJnLf2MrZXSYYLM0VE7Syp/CYM4VsL3r/amY0G2WxyFJLEIUy07jIu8CwBg1o0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709515684; c=relaxed/simple;
	bh=dfi6Q19o4dtW5X91PjmnXBLO706D9dkUvPeGb9h+fM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELDXI/oaoLBM8QoCPArHHT2SV/zQJTxXcnrm3233HgtNhNNvTfRIKVlghpkoFO+ogTBAMUg+GnPlg6gaYQS8Oq3izALb33UBKc3FyxwAGsnzg2OS8X9aYtlwIR/Ngq0vfZkYKkVUckDYYsze0p30//Dtqekr3JuDlPwDzrK54nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz29fLeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBCAC433F1;
	Mon,  4 Mar 2024 01:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709515684;
	bh=dfi6Q19o4dtW5X91PjmnXBLO706D9dkUvPeGb9h+fM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nz29fLeJg+Usw8Crmrfb+4d9bClJ5zrgPI9LizBUHJL7PoIi4RW+Dsn3qimX+zpUH
	 0rtSimQcwEyNA/G+sk6thdQ8DYySOFyrHMlz3IuhtnJRvhBfm00+D8QW+kkUK/cHz5
	 R83PpJw1cDO4B/5ta/Jp6gNiNrBxfgEALAgEQfkotCds4iYuluddciuqmC2mjt1x0O
	 CanSonz0YjFZ0ERgJs5HjgC+lSXFVQEzXTwt4SsT7dmOQ0o9q+XuCfkGqKIIsSL6NP
	 1pZfC2Y6Kuiw53kVUUTmvczzE6OdLnAGz3MDZsCi1WHlD+UNdn2kpfOSiCX/0Ze9In
	 ixd7VHC3hewxw==
Message-ID: <4ee229e6-53d6-41a0-99a3-49b8f99ea7f2@kernel.org>
Date: Mon, 4 Mar 2024 09:27:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] f2fs: fix to check return value of f2fs_gc_range
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1709281555-11373-1-git-send-email-zhiguo.niu@unisoc.com>
 <1709281555-11373-2-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1709281555-11373-2-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/1 16:25, Zhiguo Niu wrote:
> f2fs_gc_range may return error, so its caller
> f2fs_allocate_pinning_section should determine whether
> to do retry based on ist return value.
> 
> Also just do f2fs_gc_range when f2fs_allocate_new_section
> return -EAGAIN, and check cp error case in f2fs_gc_range.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

