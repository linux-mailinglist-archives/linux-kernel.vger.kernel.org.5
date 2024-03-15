Return-Path: <linux-kernel+bounces-104790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBFB87D3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3775FB23A48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2267411185;
	Fri, 15 Mar 2024 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDklX0Uy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59CD531;
	Fri, 15 Mar 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527468; cv=none; b=Db5YZ7+f+IeL8hGmkC3j6Y+mJEIPOSF0QpYjr22NFD6ORnZXEqufezT/mGzJTQlDkYAeuNmyOkTnfLjjbVBBI9Pn+uZvOjWUlfNSqjhwqPsW3BkfUipiRxBS8kqCdppbyIWGoj4HUj/kTFVe86yY4aKz6s+wHjjYpHQ2LiziOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527468; c=relaxed/simple;
	bh=T+84s8L5cLj88+eB19sBYREZk0tFk9atFi3HG81DeFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv35mbzX2qdiL0TAQTL1a5dhEPLO3eW7DfTw8qLG+BW9eMK4AZcg4AMMPxjrpJQXbIdtU6p7oNt6qJJ4syAoeg0MA3TXpWMCbT6vzLx8hbiBqHrBUBGax7195QDoAuvNETAM7vqEqJY4c00RaTm6504y5RULyG1UeCYnO8vQ8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDklX0Uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6B3C433F1;
	Fri, 15 Mar 2024 18:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710527467;
	bh=T+84s8L5cLj88+eB19sBYREZk0tFk9atFi3HG81DeFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDklX0UyY5Q0UlzTkNmCf1ofzlXyxl6g40aOqZ+mFfopLVdjCWi7CRy6vCN3m5kwB
	 lb/dR2f4qChHDN/kyX/xzO92uj75eACQFwT/0Ge8FwKqSYdL9HIJuehSJwaPZCjzAh
	 AYJnX6k9TrfShnmBiR85spDggse5jhmtFgaN2psOyKDlL24s3S6tibOzbk4VOkuNfr
	 voZy9aKVk2CCUwERtmH1TAEtmBpssJutTPaMSsVq+I9yFIoXsaLnBZs7v7gFP15qUG
	 7cj5jLZxxKp+h2dsvBpji5zrgWhFlbmOmDTDE2dmEp1HMagzURpFjsKQK6994YXUUy
	 kWzX+Fkxmgv3Q==
Date: Fri, 15 Mar 2024 14:31:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5.15 64/76] proc: Use task_is_running() for wchan in
 /proc/$pid/stat
Message-ID: <ZfST6vIP6uaDLfLU@sashalap>
References: <20240313164223.615640-1-sashal@kernel.org>
 <20240313164223.615640-65-sashal@kernel.org>
 <202403132003.BF9AF5CA@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202403132003.BF9AF5CA@keescook>

On Wed, Mar 13, 2024 at 08:04:36PM -0700, Kees Cook wrote:
>On Wed, Mar 13, 2024 at 12:42:11PM -0400, Sasha Levin wrote:
>> From: Kees Cook <keescook@chromium.org>
>>
>> [ Upstream commit 4e046156792c26bef8a4e30be711777fc8578257 ]
>>
>> The implementations of get_wchan() can be expensive. The only information
>> imparted here is whether or not a process is currently blocked in the
>> scheduler (and even this doesn't need to be exact). Avoid doing the
>> heavy lifting of stack walking and just report that information by using
>> task_is_running().
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Link: https://lkml.kernel.org/r/20211008111626.211281780@infradead.org
>> Stable-dep-of: 60f92acb60a9 ("fs/proc: do_task_stat: move thread_group_cputime_adjusted() outside of lock_task_sighand()")
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Looks fine to me. Can you double-check that commit
>54354c6a9f7f ("Revert "proc/wchan: use printk format instead of lookup_symbol_name()"")
>is already backported too?

Yup, it's there too.

-- 
Thanks,
Sasha

