Return-Path: <linux-kernel+bounces-48040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A884568D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E40B27FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736C15D5D7;
	Thu,  1 Feb 2024 11:52:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E058815D5C0;
	Thu,  1 Feb 2024 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788340; cv=none; b=WANCKuuhN8+uysIfFhhWnGnK0mv84bVhEyNBd1+LNKfDg+g+bo7K3U6oTeB27YnIY84XNvX+OvWFAo7voB8q0DBvaPl135fp4iWpiY5+IHqjYDA0glexrHou5dsX4hYVTx4XxT3yK9KLbpCwmjpBA6nlnUFDe6Aa857dWbLvjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788340; c=relaxed/simple;
	bh=qcvpKI9J5YCFjyu0moCdoE2FxEsaXoox4FAuQomdOnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTqIKMa9MsmpPzO4J4eW++Izpe2oedAkvOvtHu0KS/Gky4r9T8Uycc7IzU8gOS3xz8Z7aaijQThawj0roMKO7jAnbhb32mu18/vThwmZ0Cb/OO074nGG5jPyjrpC2wadiDEOxYTC648VW2QpbfdUkJP/7QCOvWNUxl1WcYnG+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C58DA7;
	Thu,  1 Feb 2024 03:53:01 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2C883F762;
	Thu,  1 Feb 2024 03:52:16 -0800 (PST)
Message-ID: <511f5874-3c97-5928-fd59-b49516ca6b2a@arm.com>
Date: Thu, 1 Feb 2024 11:52:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Perf not able to cross compile
Content-Language: en-US
To: Anders Roxell <anders.roxell@linaro.org>,
 linux-perf-users@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
References: <CADYN=9+DUzu6xEThaWQKp0udCsPs7h3XijyE5zmn-UYG8oM+AA@mail.gmail.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <CADYN=9+DUzu6xEThaWQKp0udCsPs7h3XijyE5zmn-UYG8oM+AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/02/2024 11:32, Anders Roxell wrote:
> Hey,
> 
> I'm trying to cross compile perf ARCH=arm64 on my x86_64 host from
> linus tree [1], branch master.
> 
> 
> This is the failue I see, full log [2]:
> 
> ...
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/elf.o
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/features.o
> cc1: error: ‘-fcf-protection=full’ is not supported for this target
> error: command '/usr/local/bin/sccache' failed with exit code 1
> cp: cannot stat
> '/home/tuxbuild/.cache/tuxmake/builds/1/build/python_ext_build/lib/perf*.so':
> No such file or directory
> make[2]: *** [Makefile.perf:678:
> /home/tuxbuild/.cache/tuxmake/builds/1/build/python/perf.cpython-311-x86_64-linux-gnu.so]
> Error 1
> make[2]: *** Waiting for unfinished jobs....
>   LD      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/libbpf-in.o
>   LINK    /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/libbpf.a
> make[1]: *** [Makefile.perf:261: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> 
> Running 'x86_64-linux-gnu-python3-config --cflags' I see
> '-fcf-protection' in the output and this happens when I'm building
> cross compile arm64 on my x86_64 host machine. Building on an arm64
> host works. cross compile x86_64 on my x86_64 host works too.
> 
> I have 'aarch64-linux-gnu-python3-config' installed but that isn't used.
> 
> $ x86_64-linux-gnu-python3-config --cflags
> -I/usr/include/python3.11 -I/usr/include/python3.11  -Wsign-compare -g
>   -fstack-protector-strong -fstack-clash-protection -Wformat
> -Werror=format-security -fcf-protection  -DNDEBUG -g -fwrapv -O2 -Wall
> $ aarch64-linux-gnu-python3-config --cflags
> -I/usr/include/python3.11 -I/usr/include/python3.11  -Wsign-compare -g
>   -fstack-protector-strong -fstack-clash-protection -Wformat
> -Werror=format-security -mbranch-protection=standard  -DNDEBUG -g
> -fwrapv -O2 -Wall
> 
> I tried to set PYTHON and PYTHON_CONFIG too, but didn't work.
> 
> It doesn't try to use $(CROSS_COMPILE)python3-config, any idea how to
> use the correct config?
> 
> Cheers,
> Anders
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> [2]  https://storage.tuxsuite.com/public/linaro/lkft/builds/2bc6x6cISHzG9Jgo0oAVv2OgLOG/build.log


Hi Anders,

I see something similar but in the end it works. Despite the name, I
also get perf.cpython-311-x86_64-linux-gnu.so generated in my build, but
it's actually an arm binary.

For me I'm using python3.10, and the x86 config options don't include
-fcf-protection which is probably why it can compile successfully with
the arm compiler.

It looks like your assumption is correct and it's not using
$(CROSS_COMPILE)python3-config but just python3-config. The answer to
how to fix it is probably to start hacking at the makefiles, if PYTHON
and PYTHON_CONFIG don't work either.

James

