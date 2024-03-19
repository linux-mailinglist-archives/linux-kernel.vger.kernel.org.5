Return-Path: <linux-kernel+bounces-108180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D9880728
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0ABC1F22FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E06B4F8A3;
	Tue, 19 Mar 2024 22:12:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580A4F889;
	Tue, 19 Mar 2024 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886367; cv=none; b=iAGwBgjduTKMxKV1c2UouhIs7918XxjPOURixzu8lPbe1470NgmKkdxioYNeht5f5mkgemoBK1uI29cpcMgqZETMT8oMps5StmMhUUM+egd/lqehdgLfEF7pbeYQ8ONYCCW52OGbC/ndIiMt3IpgsL68YYavTqrs883rKiXBH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886367; c=relaxed/simple;
	bh=tPHeG/iPj62eX8v+YXuhixQuK4X+clWTh3PEscqnhhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ody1ax3qgYAQ5p7zTnDU1X74ila4lY1uELYY844MG2Tsosr1hJ+7/2Sj7C5+w2rSvpoJcY6StfMXXLi8mha5Y1PVTD9ljhixRAzzyXr+78EAgisQU7aHMKPZj7JsHEuimTCBY/mtT4vZM+46sZwqJJ5JEtlM4uePskjgaRxDl8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBD1C433F1;
	Tue, 19 Mar 2024 22:12:46 +0000 (UTC)
Date: Tue, 19 Mar 2024 18:15:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, Linux Kernel Functional
 Testing <lkft@linaro.org>
Subject: Re: [PATCH 0/2] tracing: Fully silence instance of -Wstring-compare
Message-ID: <20240319181509.25bacdc5@gandalf.local.home>
In-Reply-To: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
References: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 09:07:51 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> Hi all,
> 
> This series fully resolves the new instance of -Wstring-compare from
> within the __assign_str() macro. The first patch resolves a build
> failure with GCC that would be seen with just the second patch applied.
> The second patch actually hides the warning.
> 
> NOTE: This is based on trace/for-next, which does not contain the
> minimum LLVM version bump that occurred later in the current merge
> window, so this uses
> 
>   __diag_ignore(clang, 11, ...
> 
> instead of
> 
>   __diag_ignore(clang, 13, ...
> 
> which will be required when this is merged into Linus's tree. If you can
> base this series on a tree that has the merge commit e5eb28f6d1af ("Merge
> tag 'mm-nonmm-stable-2024-03-14-09-36' of
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm") in it, then that
> change can be done at application time, rather than merge time (or I can
> send a v2). It would be really nice for this to make the merge window so
> that this warning does not proliferate into other trees that base on
> -rc1.
> 

I'm guessing this isn't needed with the last update.

-- Steve

