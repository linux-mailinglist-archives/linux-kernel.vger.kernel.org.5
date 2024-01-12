Return-Path: <linux-kernel+bounces-24309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8639182BAC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111451F2601D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875155B5CD;
	Fri, 12 Jan 2024 05:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxIQ8c9s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709B5B5BA;
	Fri, 12 Jan 2024 05:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D295C433F1;
	Fri, 12 Jan 2024 05:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705036756;
	bh=Pd4gyH5LIN6cZTdxd3SISOtfu26rxcTjII+lVxB8zN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TxIQ8c9sNq44aFJiIRjNZkWMabTYhEb8dS937HF8pK9AcN91mUr1vVOnC6qY8x7CK
	 5+udxb5iabttgdx/DJiz1ALzyj1k1GH9PSE1q8gNdvfIdT1aqljoEXHd90uYiPhzsS
	 Lxy/Aq1W9403gwoTsR7S8aODYNBFm0RhBO4Mqkwqb/I0A9nSOOFAY/e4Ap8BEInBBy
	 MCN88JTnAq0f0biGf+UmZN+r8cOldMaZ5/PvcnOltuFP9gF8uIMeODCK3l77HkATsv
	 zaEjnCZ9Lmhogo6cK6/UbMmo/MxR66QiN9HlYlSIw3EQlOvRDnjyiuI/ZTgKPZ3VJt
	 06n6lzfKCME0g==
Message-ID: <11a31e09-2e11-43a4-8995-ae70c5bef8bf@kernel.org>
Date: Fri, 12 Jan 2024 14:19:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scsi: block: ioprio: Clean up interface definition -
 ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
Content-Language: en-US
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 linux-block <linux-block@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
 Linux Regressions <regressions@lists.linux.dev>,
 lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <niklas.cassel@wdc.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
References: <CA+G9fYu1hB2OMf0EFrt_86OE=0Ug3y6nQd3=OZeEeM1jp3P92g@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CA+G9fYu1hB2OMf0EFrt_86OE=0Ug3y6nQd3=OZeEeM1jp3P92g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 14:15, Naresh Kamboju wrote:
> The LTP test 'iopri_set03' fails on all the devices.
> It fails on linux kernel >= v6.5. ( on Debian rootfs ).
> Test fail confirmed on LTP release 20230929 and 20230516.
> 
> Test failed log:
> ------------
> tst_test.c:1690: TINFO: LTP version: 20230929
> tst_test.c:1574: TINFO: Timeout per run is 0h 05m 00s
> ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
> ioprio_set03.c:48: TINFO: tested illegal priority with class NONE
> ioprio_set03.c:51: TPASS: returned correct error for wrong prio: EINVAL (22)
> 
> Investigation:
> ----------
> Bisecting this test between kernel v6.4 and v6.5 shows patch
> eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
> as the first faulty commit.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

This is fixed in LTP. Please update your LTP setup to avoid this issue.

> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240109/testrun/22021120/suite/ltp-syscalls/test/ioprio_set03/details/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240110/testrun/22034175/suite/ltp-syscalls/test/ioprio_set03/history/
> 
> Steps to reproduce:
> ---------------
> This is how you can reproduce it easily:
> Install podman or docker, tuxmake and tuxrun, if docker please change
> the --runtime below to docker.
> cd into the kernel you want to build:
> $ tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
> --kconfig defconfig --results-hook 'tuxrun --runtime podman --device
> qemu-arm64 --boot-args rw --tuxmake ./ --rootfs
> https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4.xz
> --parameters SKIPFILE=skipfile-lkft.yaml --timeouts boot=30 --overlay
> https://storage.tuxboot.com/overlays/debian/bookworm/arm64/ltp/20230929/ltp.tar.xz
> / --save-outputs --log-file - -- "cd /opt/ltp && ./runltp -s
> ioprio_set03"'
> 
> 
> Bisection log:
> ------------
> # bad: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
> # good: [6995e2de6891c724bfeb2db33d7b87775f913ad1] Linux 6.4
> git bisect start 'v6.5' 'v6.4'
> # good: [b775d6c5859affe00527cbe74263de05cfe6b9f9] Merge tag
> 'mips_6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
> git bisect good b775d6c5859affe00527cbe74263de05cfe6b9f9
> # bad: [56cbceab928d7ac3702de172ff8dcc1da2a6aaeb] Merge tag
> 'usb-6.5-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> git bisect bad 56cbceab928d7ac3702de172ff8dcc1da2a6aaeb
> # good: [b30d7a77c53ec04a6d94683d7680ec406b7f3ac8] Merge tag
> 'perf-tools-for-v6.5-1-2023-06-28' of
> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next
> git bisect good b30d7a77c53ec04a6d94683d7680ec406b7f3ac8
> # bad: [dfab92f27c600fea3cadc6e2cb39f092024e1fef] Merge tag
> 'nfs-for-6.5-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
> git bisect bad dfab92f27c600fea3cadc6e2cb39f092024e1fef
> # bad: [28968f384be3c064d66954aac4c534a5e76bf973] Merge tag
> 'pinctrl-v6.5-1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> git bisect bad 28968f384be3c064d66954aac4c534a5e76bf973
> # bad: [af92c02fb2090692f4920ea4b74870940260cf49] Merge patch series
> "scsi: fixes for targets with many LUNs, and scsi_target_block rework"
> git bisect bad af92c02fb2090692f4920ea4b74870940260cf49
> # bad: [2e2fe5ac695a00ab03cab4db1f4d6be07168ed9d] scsi: 3w-xxxx: Add
> error handling for initialization failure in tw_probe()
> git bisect bad 2e2fe5ac695a00ab03cab4db1f4d6be07168ed9d
> # good: [8759924ddb93498bd5777f0b05b6bc9cacf4ffe3] Merge patch series
> "scsi: hisi_sas: Some misc changes"
> git bisect good 8759924ddb93498bd5777f0b05b6bc9cacf4ffe3
> # good: [7907ad748bdba8ac9ca47f0a650cc2e5d2ad6e24] Merge patch series
> "Use block pr_ops in LIO"
> git bisect good 7907ad748bdba8ac9ca47f0a650cc2e5d2ad6e24
> # bad: [390e2d1a587405a522dc6b433d45648f895a352c] scsi: sd: Handle
> read/write CDL timeout failures
> git bisect bad 390e2d1a587405a522dc6b433d45648f895a352c
> # bad: [734326937b65cec7ffd00bfbbce0f791ac4aac84] scsi: core: Rename
> and move get_scsi_ml_byte()
> git bisect bad 734326937b65cec7ffd00bfbbce0f791ac4aac84
> # bad: [6c913257226a25879bfd6226e0ee265e98904ce6] scsi: block:
> Introduce ioprio hints
> git bisect bad 6c913257226a25879bfd6226e0ee265e98904ce6
> # bad: [eca2040972b411ec27483bf75dc8b84e730e88ff] scsi: block: ioprio:
> Clean up interface definition
> git bisect bad eca2040972b411ec27483bf75dc8b84e730e88ff
> # first bad commit: [eca2040972b411ec27483bf75dc8b84e730e88ff] scsi:
> block: ioprio: Clean up interface definition
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

-- 
Damien Le Moal
Western Digital Research


