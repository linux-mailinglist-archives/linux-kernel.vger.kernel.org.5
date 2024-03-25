Return-Path: <linux-kernel+bounces-116950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAB388B1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C29ADBC3332
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381E137C58;
	Mon, 25 Mar 2024 11:58:09 +0000 (UTC)
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A116ABFB;
	Mon, 25 Mar 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366425; cv=none; b=PDd+pHbGTO5fN5RcgZomRnffeR10S9ThC7DH2Dho9oDaxXKKzLmlZiwqDpn4Cm/UKHUDAaLHsXknGiRQY3WLreln0amDbE6hPeovNmdo8JZQNrCKBUVu3KgvUUdUSRstVQjiyJyaCSyuMWpI1urF9Aj0yp5y5yalaPOo67T52Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366425; c=relaxed/simple;
	bh=d1NXbW2w7/mQjBWshCTZp7FbmTNm1QltMzADk0eDBcQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KOcmNx4TNF8j8zykUJ34CR4TAeCJKrbAZJjclBxp8klKhM28zZHgwsWDmBGCY3P5MT0xCWz1Z4CGBhgkR2dbGCz8SyOkie2Jb90jAyPXYrekybL0DkxDtklOfePA0u+IT3k4Ez2bMRIScXSb2PLcSL91QIU1mGG82L1zBiHNSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd7672.dip0.t-ipconnect.de [93.221.118.114])
	by mail.itouring.de (Postfix) with ESMTPSA id 3502510376F;
	Mon, 25 Mar 2024 12:26:35 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id D9218F01607;
	Mon, 25 Mar 2024 12:26:34 +0100 (CET)
Subject: Re: [PATCH 6.8 000/715] 6.8.2-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de
References: <20240324223455.1342824-1-sashal@kernel.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <00caf4e2-ea56-5d5e-03a4-df8fc91a0c77@applied-asynchrony.com>
Date: Mon, 25 Mar 2024 12:26:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2024-03-24 23:22, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 715 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Applying the patch to 6.8.1 quickly fails the build of a previously
working config with:

   CALL    scripts/checksyscalls.sh
   DESCEND objtool
   INSTALL libsubcmd_headers
   DESCEND bpf/resolve_btfids
   CC      /tmp/linux-6.8.2/tools/bpf/resolve_btfids/libbpf/staticobjs/bpf.o
In file included from /usr/include/stdio.h:34,
                  from libbpf.h:14,
                  from bpf.c:36:
bpf.c: In function 'bpf_token_create':
bpf.c:1293:60: error: 'union bpf_attr' has no member named 'token_create'; did you mean 'iter_create'?
  1293 |         const size_t attr_sz = offsetofend(union bpf_attr, token_create);
       |                                                            ^~~~~~~~~~~~
bpf.c:1293:32: note: in expansion of macro 'offsetofend'
  1293 |         const size_t attr_sz = offsetofend(union bpf_attr, token_create);
       |                                ^~~~~~~~~~~
In file included from bpf.c:37:
bpf.c:1293:60: error: 'union bpf_attr' has no member named 'token_create'; did you mean 'iter_create'?
  1293 |         const size_t attr_sz = offsetofend(union bpf_attr, token_create);
       |                                                            ^~~~~~~~~~~~
libbpf_internal.h:107:54: note: in definition of macro 'offsetofend'
   107 |         (offsetof(TYPE, FIELD) + sizeof(((TYPE *)0)->FIELD))
       |                                                      ^~~~~
bpf.c:1301:14: error: 'union bpf_attr' has no member named 'token_create'; did you mean 'iter_create'?
  1301 |         attr.token_create.bpffs_fd = bpffs_fd;
       |              ^~~~~~~~~~~~
       |              iter_create
bpf.c:1302:14: error: 'union bpf_attr' has no member named 'token_create'; did you mean 'iter_create'?
  1302 |         attr.token_create.flags = OPTS_GET(opts, flags, 0);
       |              ^~~~~~~~~~~~
       |              iter_create
bpf.c:1304:25: error: 'BPF_TOKEN_CREATE' undeclared (first use in this function); did you mean 'BPF_ITER_CREATE'?
  1304 |         fd = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
       |                         ^~~~~~~~~~~~~~~~
       |                         BPF_ITER_CREATE

Introduced by "libbpf-add-bpf_token_create-api.patch".

A quick search indicates that at least mainline commit 35f96de04127
aka "bpf: Introduce BPF token object" is missing (but does not apply),
likely others.


