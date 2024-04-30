Return-Path: <linux-kernel+bounces-164043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8EC8B77A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35C91F22B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7120172796;
	Tue, 30 Apr 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QRhixgYn"
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E428171E6E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485292; cv=none; b=afrN6hhgTjWTDKfXA/TSTkmbN77XZFHO2rwtmmvrEFcfC3cJxL/6rSOvRAGVzLAc6B67YaXYijxvcLVpOofjR8OoqlmZ0BvubtAIyD3VUGd9eFp9zGDy6eaQr2/lsYwaR+zLc+bNY+qkNcUPClNyBXuzN6GYbmLyfzWlckGD6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485292; c=relaxed/simple;
	bh=j7uCyw9gJWCykaUxpDFOXMmF9t4ZvW27l4JLBpjd2og=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZEZsxsXAMRo5Tx80KHeIU5xlGT2nVWf8/lGl1CULQxUSlrkqsn122B/hX1ozfdqeErpCiP3CWaGI/8TojRJI10QNk+1M9VnT8SMnfTeUhVTt8kqhszUT0OY6/liuSzPBo2NIm+JQWJYEMyS7mXjgUUy9gHVEI/17Hosb4f0RKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QRhixgYn; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VTMBm3dQPzrnc;
	Tue, 30 Apr 2024 15:54:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714485280;
	bh=j7uCyw9gJWCykaUxpDFOXMmF9t4ZvW27l4JLBpjd2og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QRhixgYnlBaRvvyb3lebMIaeuqK1e5AWRewZ92+iiAJoapexwVWFLHAAv5v6MKpj9
	 vDysK6E3qcIRS0TbubkMImRRoYgbuhwLQ/qsfv6WLy2A/7aWpc0gWaMgtyDs5hLTpB
	 mDZJgdAvUcoaA56JS2/diOTsOq6ZTjHvY+a0O0WQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VTMBl3881zNKv;
	Tue, 30 Apr 2024 15:54:39 +0200 (CEST)
Date: Tue, 30 Apr 2024 15:54:38 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Shengyu Li <shengyu.li.evgeny@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Will Drewry <wad@chromium.org>, kernel test robot <oliver.sang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Fix Kselftest's vfork() side effects
Message-ID: <20240430.eudae0Mahbie@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429191911.2552580-1-mic@digikod.net>
X-Infomaniak-Routing: alpha

Shuah, could you please take this series in your tree and push it to
next?  This mainly fixes an issue in the pidfd tests and we should get
this merged before the final 6.9 release. Thanks.

Jakub, can you please review it?

Mark, it would be good to have your Tested-by tags. :)


On Mon, Apr 29, 2024 at 09:19:02PM +0200, Mickaël Salaün wrote:
> Hi,
> 
> As reported by Kernel Test Robot [1], some pidfd tests fail.  This is
> due to the use of vfork() which introduced some side effects.
> Similarly, while making it more generic, a previous commit made some
> Landlock file system tests flaky, and subject to the host's file system
> mount configuration.
> 
> This series fixes all these side effects by replacing vfork() with
> clone3() and CLONE_VFORK, which is cleaner (no arbitrary shared memory)
> and makes the Kselftest framework more robust.
> 
> I tried different approaches and I found this one to be the cleaner and
> less invasive for current test cases.
> 
> This third series replace improve the clone3_vfork() helper and add
> Reviewed-by tags.
> 
> I successfully ran the following tests (using TEST_F and
> fork/clone/clone3) with this series:
> - landlock:fs_test
> - landlock:net_test
> - landlock:ptrace_test
> - move_mount_set_group:move_mount_set_group_test
> - net/af_unix:scm_pidfd
> - perf_events:remove_on_exec
> - pidfd:pidfd_getfd_test
> - pidfd:pidfd_setns_test
> - seccomp:seccomp_bpf
> - user_events:abi_test
> 
> [1] https://lore.kernel.org/oe-lkp/202403291015.1fcfa957-oliver.sang@intel.com
> 
> Previous versions:
> v1: https://lore.kernel.org/r/20240426172252.1862930-1-mic@digikod.net
> v2: https://lore.kernel.org/r/20240429130931.2394118-1-mic@digikod.net
> 
> Regards,
> 
> Mickaël Salaün (9):
>   selftests/pidfd: Fix config for pidfd_setns_test
>   selftests/landlock: Fix FS tests when run on a private mount point
>   selftests/harness: Fix fixture teardown
>   selftests/harness: Fix interleaved scheduling leading to race
>     conditions
>   selftests/landlock: Do not allocate memory in fixture data
>   selftests/harness: Constify fixture variants
>   selftests/pidfd: Fix wrong expectation
>   selftests/harness: Share _metadata between forked processes
>   selftests/harness: Fix vfork() side effects
> 
>  tools/testing/selftests/kselftest_harness.h   | 113 +++++++++++++-----
>  tools/testing/selftests/landlock/fs_test.c    |  83 ++++++++-----
>  tools/testing/selftests/pidfd/config          |   2 +
>  .../selftests/pidfd/pidfd_setns_test.c        |   2 +-
>  4 files changed, 135 insertions(+), 65 deletions(-)
> 
> 
> base-commit: e67572cd2204894179d89bd7b984072f19313b03
> -- 
> 2.44.0
> 

