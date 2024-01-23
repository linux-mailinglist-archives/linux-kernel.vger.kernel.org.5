Return-Path: <linux-kernel+bounces-35156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6486B838CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFD328899D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4845D725;
	Tue, 23 Jan 2024 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JvljyBDE"
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB25C911
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007961; cv=none; b=bCF/WBMbSuSp8Fc9oLoSDSs/E0yjEKh7tSAFI/1Cqtw6GEWGTALw/3ATNGUMRsQnofdbrakXhwKSGbxyYSeW3r//sag4KmYlgIPOiEInuT0REfbcChCYtb2zoqtzATJZaPTNo6QrMT/gMMslSEThTXmfU5txIKfiTSuzM7/8k0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007961; c=relaxed/simple;
	bh=7wANGkPvqc+OR36L/josux0TSfXeAjjxrHp0PPQm9Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK2C7d6Dd2E5yY2UqjbgCWGz4oiKibgnhMl0azmnt00GCJpev9SjvOd7hEl2yFKv7+WD79cxVQseuN2im54dU+kWm6V7MN+esF7eJSphoEOLF8ZjlrYQr6gjS8psDf8sW+JBUYk9BqGXBpzxy9eRnnUhWQPdFa96ARJ4IP5KyPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JvljyBDE; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TK45K38bnzMq6j2;
	Tue, 23 Jan 2024 12:05:57 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TK45J5Xd3z3c;
	Tue, 23 Jan 2024 12:05:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1706007957;
	bh=7wANGkPvqc+OR36L/josux0TSfXeAjjxrHp0PPQm9Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvljyBDEANid5jv8ERtVwSxpi1/sSEsRHoeQHYvn6ppPg13FyqlE/KAEnNljLlp33
	 /XJvdjnxXUfeWX96UxAfxgq7H8wjmBCmSiSTXEUseBwcrBTGqZbib3oHfGXv1oS2Ur
	 99i3ya/rLt1p3v0Qqohv3oj030dMsCYQGGjm6tCQ=
Date: Tue, 23 Jan 2024 12:05:53 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, amir73il@gmail.com, brauner@kernel.org, avagin@google.com, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 514118380@qq.com, 
	konstantin.meskhidze@huawei.com
Subject: Re: [PATCH] selftests/landlock:Fix net_test build issues with old
 libc
Message-ID: <20240123.Baiquie9Roh6@digikod.net>
References: <20240123062621.25082-1-hu.yadi@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240123062621.25082-1-hu.yadi@h3c.com>
X-Infomaniak-Routing: alpha

Thanks, I tweaked a bit and merged this patch in my next branch.

On Tue, Jan 23, 2024 at 02:26:21PM +0800, Hu Yadi wrote:
> From: "Hu.Yadi" <hu.yadi@h3c.com>

There is an extra "." here, I fixed it. You don't need to add this From
field if it matches your email's From one.

> 
> Fixes: a549d055a22e ("selftests/landlock: Add network tests")
> 
> one issues comes up while building selftest/landlock/net_test on my side
> (gcc 7.3/glibc-2.28/kernel-4.19)
> 
> net_test.c: In function ‘set_service’:
> net_test.c:91:45: warning: implicit declaration of function ‘gettid’; [-Wimplicit-function-declaration]
>     "_selftests-landlock-net-tid%d-index%d", gettid(),
>                                              ^~~~~~
>                                              getgid
> net_test.c:(.text+0x4e0): undefined reference to `gettid'
> 
> Signed-off-by: Hu Yadi <hu.yadi@h3c.com>
> Suggested-by: Jiao <jiaoxupo@h3c.com>
> Reviewed-by: Berlin <berlin@h3c.com>
> ---
>  tools/testing/selftests/landlock/net_test.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
> index 929e21c4db05..6cc1bb1a9166 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c
> @@ -18,9 +18,15 @@
>  #include <sys/prctl.h>
>  #include <sys/socket.h>
>  #include <sys/un.h>
> -
> +#include <sys/syscall.h>
>  #include "common.h"
> 
> +
> +static pid_t sys_gettid(void)
> +{
> +	return syscall(__NR_gettid);
> +}
> +
>  const short sock_port_start = (1 << 10);
> 
>  static const char loopback_ipv4[] = "127.0.0.1";
> @@ -88,7 +94,7 @@ static int set_service(struct service_fixture *const srv,
>  	case AF_UNIX:
>  		srv->unix_addr.sun_family = prot.domain;
>  		sprintf(srv->unix_addr.sun_path,
> -			"_selftests-landlock-net-tid%d-index%d", gettid(),
> +			"_selftests-landlock-net-tid%d-index%d", sys_gettid(),
>  			index);
>  		srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
>  		srv->unix_addr.sun_path[0] = '\0';
> --
> 2.23.0
> 
> 

