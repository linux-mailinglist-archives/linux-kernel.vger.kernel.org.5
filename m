Return-Path: <linux-kernel+bounces-41595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B133A83F51C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A0D283689
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1720B29;
	Sun, 28 Jan 2024 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6NmmI47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930A2200B7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706440985; cv=none; b=C7+EC0VOmyNkdD8sZvI/aQcEGqRd2Gz3tkO6cqMXb+BA/H2Raqsa8BsCPBhDQ8XvyR/ah0NZUivD41Y3eWc7sqMNNellN47+bYI7E7DiIa4WRxcD80x/sm1wRKJ5ZTa9AmnRv2vyf76NiBIueh7YVrbzEBwuvXbLEm7rjEb4NAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706440985; c=relaxed/simple;
	bh=H6ObIiC1/SrvGoNUsYPERHmflaLup99266tKz2q+n8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcUWQ/CEqzk12YzCZk+LpOSm79plCCF+xViNVQXENyffl9THSfa+rfd6lkCP+CiCVCpIEthZawJeJZ8I6sWQQPwGdLlDo1TmLmtTIo6F6Tk16DUUj7uPu8C/+bgGaTr0OVY6zkeCCIZwGQotx8dliExz2yhkmiTFxjSYO2S2N3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6NmmI47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648C4C433F1;
	Sun, 28 Jan 2024 11:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706440985;
	bh=H6ObIiC1/SrvGoNUsYPERHmflaLup99266tKz2q+n8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6NmmI47wmL2hkfLZGltatV2vMduLuKRl2JY1X+UAwUb9K8bk+Ue6SgAtdKiekNXa
	 J03Zs6jj/+3idPhvTF3eWS2YLXhAQxVabJGuXtodv2bWIAgZUonmSkIjImkIay8Deg
	 pu62F1I5ogsE9OxqJK+XFYIkxG7XuVUXaAhiolz4QLeA8RpotNrdgr9pt6J+wlTG0E
	 kqERMKu1+zU9bttFQfeCh3XUKiCft6zsZ+i5Pmo4oL/tUAzHL37t6/JlgXhBPUDQ6V
	 o4DjUq3a3cfxDa0nHYkvE10ucloFdqc7MctaoautCBVW/n0SFAHk1mKNbYpi+OENYh
	 LmTOEOLk0Yzaw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Matteo Croce <mcroce@microsoft.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] riscv: optimized memcpy
Date: Sun, 28 Jan 2024 19:10:11 +0800
Message-ID: <20240128111013.2450-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128111013.2450-1-jszhang@kernel.org>
References: <20240128111013.2450-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <mcroce@microsoft.com>

Write a C version of memcpy() which uses the biggest data size allowed,
without generating unaligned accesses.

The procedure is made of three steps:
First copy data one byte at time until the destination buffer is aligned
to a long boundary.
Then copy the data one long at time shifting the current and the next u8
to compose a long at every cycle.
Finally, copy the remainder one byte at time.

On a BeagleV, the TCP RX throughput increased by 45%:

before:

$ iperf3 -c beaglev
Connecting to host beaglev, port 5201
[  5] local 192.168.85.6 port 44840 connected to 192.168.85.48 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  76.4 MBytes   641 Mbits/sec   27    624 KBytes
[  5]   1.00-2.00   sec  72.5 MBytes   608 Mbits/sec    0    708 KBytes
[  5]   2.00-3.00   sec  73.8 MBytes   619 Mbits/sec   10    451 KBytes
[  5]   3.00-4.00   sec  72.5 MBytes   608 Mbits/sec    0    564 KBytes
[  5]   4.00-5.00   sec  73.8 MBytes   619 Mbits/sec    0    658 KBytes
[  5]   5.00-6.00   sec  73.8 MBytes   619 Mbits/sec   14    522 KBytes
[  5]   6.00-7.00   sec  73.8 MBytes   619 Mbits/sec    0    621 KBytes
[  5]   7.00-8.00   sec  72.5 MBytes   608 Mbits/sec    0    706 KBytes
[  5]   8.00-9.00   sec  73.8 MBytes   619 Mbits/sec   20    580 KBytes
[  5]   9.00-10.00  sec  73.8 MBytes   619 Mbits/sec    0    672 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   736 MBytes   618 Mbits/sec   71             sender
[  5]   0.00-10.01  sec   733 MBytes   615 Mbits/sec                  receiver

after:

$ iperf3 -c beaglev
Connecting to host beaglev, port 5201
[  5] local 192.168.85.6 port 44864 connected to 192.168.85.48 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   109 MBytes   912 Mbits/sec   48    559 KBytes
[  5]   1.00-2.00   sec   108 MBytes   902 Mbits/sec    0    690 KBytes
[  5]   2.00-3.00   sec   106 MBytes   891 Mbits/sec   36    396 KBytes
[  5]   3.00-4.00   sec   108 MBytes   902 Mbits/sec    0    567 KBytes
[  5]   4.00-5.00   sec   106 MBytes   891 Mbits/sec    0    699 KBytes
[  5]   5.00-6.00   sec   106 MBytes   891 Mbits/sec   32    414 KBytes
[  5]   6.00-7.00   sec   106 MBytes   891 Mbits/sec    0    583 KBytes
[  5]   7.00-8.00   sec   106 MBytes   891 Mbits/sec    0    708 KBytes
[  5]   8.00-9.00   sec   106 MBytes   891 Mbits/sec   28    433 KBytes
[  5]   9.00-10.00  sec   108 MBytes   902 Mbits/sec    0    591 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.04 GBytes   897 Mbits/sec  144             sender
[  5]   0.00-10.01  sec  1.04 GBytes   894 Mbits/sec                  receiver

And the decreased CPU time of the memcpy() is observable with perf top.
This is the `perf top -Ue task-clock` output when doing the test:

before:

Overhead  Shared O  Symbol
  42.22%  [kernel]  [k] memcpy
  35.00%  [kernel]  [k] __asm_copy_to_user
   3.50%  [kernel]  [k] sifive_l2_flush64_range
   2.30%  [kernel]  [k] stmmac_napi_poll_rx
   1.11%  [kernel]  [k] memset

after:

Overhead  Shared O  Symbol
  45.69%  [kernel]  [k] __asm_copy_to_user
  29.06%  [kernel]  [k] memcpy
   4.09%  [kernel]  [k] sifive_l2_flush64_range
   2.77%  [kernel]  [k] stmmac_napi_poll_rx
   1.24%  [kernel]  [k] memset

Compared with Matteo's original series, Jisheng made below changes:
1. adopt Emil's change to fix boot failure when build with clang
2. add corresponding changes to purgatory
3. always build optimized string.c rather than only build when optimize
for performance
4. implement unroll support when src & dst are both aligned to keep
the same performance as assembly version. After disassembling, I found
that the unroll version looks something like below, so it acchieves
the "unroll" effect as asm version but in C programming language:
	ld	t2,0(a5)
	ld	t0,8(a5)
	ld	t6,16(a5)
	ld	t5,24(a5)
	ld	t4,32(a5)
	ld	t3,40(a5)
	ld	t1,48(a5)
	ld	a1,56(a5)
	sd	t2,0(a6)
	sd	t0,8(a6)
	sd	t6,16(a6)
	sd	t5,24(a6)
	sd	t4,32(a6)
	sd	t3,40(a6)
	sd	t1,48(a6)
	sd	a1,56(a6)
And per my testing, unrolling more doesn't help performance, so
the "c" version only unrolls by using 8 GP regs rather than 16
ones as asm version.
5. Add proper __pi_memcpy and __pi___memcpy alias
6. more performance numbers.

Jisheng's commit msg:
Use the benchmark program from [1], I got below results on TH1520,
CV1800B and JH7110 platforms.

*TH1520 platform (I fixed cpu freq at 750MHZ):

Before the patch:

Random memcpy (bytes/ns):
   __memcpy 32K: 0.52 64K: 0.43 128K: 0.38 256K: 0.35 512K: 0.31 1024K: 0.22 avg 0.34
memcpy_call 32K: 0.41 64K: 0.35 128K: 0.33 256K: 0.31 512K: 0.28 1024K: 0.20 avg 0.30

Aligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.46 16B: 0.61 32B: 0.84 64B: 0.89 128B: 3.31 256B: 3.44 512B: 3.51
memcpy_call 8B: 0.18 16B: 0.26 32B: 0.50 64B: 0.90 128B: 1.57 256B: 2.31 512B: 2.92

Unaligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.19 16B: 0.18 32B: 0.25 64B: 0.30 128B: 0.33 256B: 0.35 512B: 0.36
memcpy_call 8B: 0.16 16B: 0.22 32B: 0.39 64B: 0.70 128B: 1.11 256B: 1.46 512B: 1.81

Large memcpy (bytes/ns):
   __memcpy 1K: 3.57 2K: 3.85 4K: 3.75 8K: 3.98 16K: 4.03 32K: 4.06 64K: 4.40
memcpy_call 1K: 3.13 2K: 3.75 4K: 3.99 8K: 4.29 16K: 4.40 32K: 4.46 64K: 4.63

After the patch:

Random memcpy (bytes/ns):
   __memcpy 32K: 0.32 64K: 0.28 128K: 0.26 256K: 0.24 512K: 0.22 1024K: 0.17 avg 0.24
memcpy_call 32K: 0.39 64K: 0.34 128K: 0.32 256K: 0.30 512K: 0.27 1024K: 0.20 avg 0.29

Aligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.20 16B: 0.22 32B: 0.25 64B: 2.43 128B: 3.19 256B: 3.36 512B: 3.55
memcpy_call 8B: 0.18 16B: 0.24 32B: 0.46 64B: 0.88 128B: 1.53 256B: 2.30 512B: 2.92

Unaligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.22 16B: 0.29 32B: 0.49 64B: 0.51 128B: 0.87 256B: 1.08 512B: 1.27
memcpy_call 8B: 0.12 16B: 0.21 32B: 0.40 64B: 0.70 128B: 1.10 256B: 1.46 512B: 1.80

Large memcpy (bytes/ns):
   __memcpy 1K: 3.63 2K: 3.66 4K: 3.78 8K: 3.87 16K: 3.96 32K: 4.11 64K: 4.40
memcpy_call 1K: 3.32 2K: 3.68 4K: 3.99 8K: 4.17 16K: 4.25 32K: 4.48 64K: 4.60

As can be seen, the unaligned medium memcpy performance is improved by
about 252%, I.E got 3.5x speed of original's. The performance of other
style mempcy is kept the same as original's.

And since the TH1520 supports HAVE_EFFICIENT_UNALIGNED_ACCESS, we can
optimize the memcpy futher without taking care of alignment at all.
Random memcpy (bytes/ns):
              __memcpy 32K: 0.35 64K: 0.31 128K: 0.28 256K: 0.25 512K: 0.23 1024K: 0.17 av
g 0.25
           memcpy_call 32K: 0.40 64K: 0.35 128K: 0.33 256K: 0.31 512K: 0.27 1024K: 0.20 av
g 0.30

Aligned medium memcpy (bytes/ns):
              __memcpy 8B: 0.21 16B: 0.23 32B: 0.27 64B: 3.34 128B: 3.42 256B: 3.50 512B:
3.58
           memcpy_call 8B: 0.18 16B: 0.24 32B: 0.46 64B: 0.88 128B: 1.53 256B: 2.31 512B:
2.92

Unaligned medium memcpy (bytes/ns):
              __memcpy 8B: 0.20 16B: 0.23 32B: 0.28 64B: 3.05 128B: 2.70 256B: 2.82 512B:
2.88
           memcpy_call 8B: 0.16 16B: 0.21 32B: 0.38 64B: 0.70 128B: 1.11 256B: 1.50 512B:
1.81

Large memcpy (bytes/ns):
              __memcpy 1K: 3.62 2K: 3.71 4K: 3.76 8K: 3.92 16K: 3.96 32K: 4.12 64K: 4.40
           memcpy_call 1K: 3.11 2K: 3.66 4K: 4.02 8K: 4.16 16K: 4.34 32K: 4.47 64K: 4.62

As can be seen, the unaligned medium memcpy is improved by 700%, I.E 8x
speed of original's.

*CV1800B platform:

Before the patch:

Random memcpy (bytes/ns):
   __memcpy 32K: 0.21 64K: 0.10 128K: 0.08 256K: 0.07 512K: 0.06 1024K: 0.06 avg 0.08
memcpy_call 32K: 0.19 64K: 0.10 128K: 0.08 256K: 0.07 512K: 0.06 1024K: 0.06 avg 0.08

Aligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.26 16B: 0.36 32B: 0.48 64B: 0.51 128B: 2.01 256B: 2.44 512B: 2.73
memcpy_call 8B: 0.10 16B: 0.18 32B: 0.33 64B: 0.59 128B: 0.90 256B: 1.21 512B: 1.47

Unaligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.11 16B: 0.12 32B: 0.15 64B: 0.16 128B: 0.16 256B: 0.17 512B: 0.17
memcpy_call 8B: 0.10 16B: 0.12 32B: 0.21 64B: 0.34 128B: 0.50 256B: 0.66 512B: 0.77

Large memcpy (bytes/ns):
   __memcpy 1K: 2.90 2K: 2.91 4K: 3.00 8K: 3.04 16K: 3.03 32K: 2.89 64K: 2.52
memcpy_call 1K: 1.62 2K: 1.74 4K: 1.80 8K: 1.83 16K: 1.84 32K: 1.78 64K: 1.54

After the patch:

Random memcpy (bytes/ns):
   __memcpy 32K: 0.15 64K: 0.08 128K: 0.06 256K: 0.06 512K: 0.05 1024K: 0.05 avg 0.07
memcpy_call 32K: 0.19 64K: 0.10 128K: 0.08 256K: 0.07 512K: 0.06 1024K: 0.06 avg 0.08

Aligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.11 16B: 0.11 32B: 0.14 64B: 1.15 128B: 1.62 256B: 2.06 512B: 2.40
memcpy_call 8B: 0.10 16B: 0.18 32B: 0.33 64B: 0.59 128B: 0.90 256B: 1.21 512B: 1.47

Unaligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.11 16B: 0.12 32B: 0.21 64B: 0.32 128B: 0.43 256B: 0.52 512B: 0.59
memcpy_call 8B: 0.10 16B: 0.12 32B: 0.21 64B: 0.34 128B: 0.50 256B: 0.66 512B: 0.77

Large memcpy (bytes/ns):
   __memcpy 1K: 2.56 2K: 2.71 4K: 2.78 8K: 2.81 16K: 2.80 32K: 2.68 64K: 2.51
memcpy_call 1K: 1.62 2K: 1.74 4K: 1.80 8K: 1.83 16K: 1.84 32K: 1.78 64K: 1.54

We get similar performance improvement as TH1520. And since CV1800B also
supports HAVE_EFFICIENT_UNALIGNED_ACCESS, so the performance can be
improved futher:
Random memcpy (bytes/ns):
   __memcpy 32K: 0.15 64K: 0.08 128K: 0.07 256K: 0.06 512K: 0.05 1024K: 0.05 avg 0.07
memcpy_call 32K: 0.19 64K: 0.10 128K: 0.08 256K: 0.07 512K: 0.06 1024K: 0.06 avg 0.08

Aligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.13 16B: 0.14 32B: 0.15 64B: 1.55 128B: 2.01 256B: 2.36 512B: 2.58
memcpy_call 8B: 0.10 16B: 0.18 32B: 0.33 64B: 0.59 128B: 0.90 256B: 1.21 512B: 1.47

Unaligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.13 16B: 0.14 32B: 0.15 64B: 1.06 128B: 1.26 256B: 1.39 512B: 1.46
memcpy_call 8B: 0.10 16B: 0.12 32B: 0.21 64B: 0.34 128B: 0.50 256B: 0.66 512B: 0.77

Large memcpy (bytes/ns):
   __memcpy 1K: 2.65 2K: 2.76 4K: 2.80 8K: 2.82 16K: 2.81 32K: 2.68 64K: 2.51
memcpy_call 1K: 1.63 2K: 1.74 4K: 1.80 8K: 1.84 16K: 1.84 32K: 1.78 64K: 1.54

Now the unaligned medium memcpy is running at 8.6x speed of original's!

*JH7110 (I fixed cpufreq at 1.5GHZ)

Before the patch:
Random memcpy (bytes/ns):
   __memcpy 32K: 0.45 64K: 0.40 128K: 0.36 256K: 0.33 512K: 0.33 1024K: 0.31 avg 0.36
memcpy_call 32K: 0.43 64K: 0.38 128K: 0.34 256K: 0.31 512K: 0.31 1024K: 0.29 avg 0.34

Aligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.42 16B: 0.55 32B: 0.65 64B: 0.72 128B: 2.91 256B: 3.36 512B: 3.65
memcpy_call 8B: 0.16 16B: 0.36 32B: 0.67 64B: 1.14 128B: 1.70 256B: 2.26 512B: 2.71

Unaligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.17 16B: 0.18 32B: 0.19 64B: 0.19 128B: 0.19 256B: 0.20 512B: 0.20
memcpy_call 8B: 0.16 16B: 0.20 32B: 0.36 64B: 0.62 128B: 0.94 256B: 1.28 512B: 1.52

Large memcpy (bytes/ns):
   __memcpy 1K: 3.62 2K: 3.82 4K: 3.90 8K: 3.95 16K: 3.97 32K: 1.33 64K: 1.33
memcpy_call 1K: 2.93 2K: 3.14 4K: 3.25 8K: 3.31 16K: 3.19 32K: 1.27 64K: 1.28

After the patch:

Random memcpy (bytes/ns):
   __memcpy 32K: 0.26 64K: 0.24 128K: 0.23 256K: 0.22 512K: 0.22 1024K: 0.21 avg 0.23
memcpy_call 32K: 0.42 64K: 0.38 128K: 0.34 256K: 0.31 512K: 0.31 1024K: 0.29 avg 0.34

Aligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.17 16B: 0.17 32B: 0.18 64B: 1.94 128B: 2.56 256B: 3.04 512B: 3.36
memcpy_call 8B: 0.17 16B: 0.36 32B: 0.65 64B: 1.12 128B: 1.73 256B: 2.37 512B: 2.91

Unaligned medium memcpy (bytes/ns):
   __memcpy 8B: 0.17 16B: 0.24 32B: 0.41 64B: 0.63 128B: 0.85 256B: 1.00 512B: 1.14
memcpy_call 8B: 0.16 16B: 0.22 32B: 0.38 64B: 0.65 128B: 0.99 256B: 1.35 512B: 1.61

Large memcpy (bytes/ns):
   __memcpy 1K: 3.43 2K: 3.59 4K: 3.67 8K: 3.72 16K: 3.73 32K: 1.28 64K: 1.28
memcpy_call 1K: 3.21 2K: 3.46 4K: 3.60 8K: 3.68 16K: 3.51 32K: 1.27 64K: 1.28

As can be seen, the unaligned medium memcpy performance is improved by
about 470%, I.E 5.7x speed of original's. The performance of other
style mempcy is kept the same as original's.

Link:https://github.com/ARM-software/optimized-routines/blob/master/string/bench/memcpy.c [1]

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
Co-developed-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/riscv/include/asm/string.h |   6 +-
 arch/riscv/kernel/riscv_ksyms.c |   2 -
 arch/riscv/lib/Makefile         |   7 +-
 arch/riscv/lib/memcpy.S         | 110 -----------------------------
 arch/riscv/lib/string.c         | 121 ++++++++++++++++++++++++++++++++
 arch/riscv/purgatory/Makefile   |  10 +--
 6 files changed, 136 insertions(+), 120 deletions(-)
 delete mode 100644 arch/riscv/lib/memcpy.S
 create mode 100644 arch/riscv/lib/string.c

diff --git a/arch/riscv/include/asm/string.h b/arch/riscv/include/asm/string.h
index a96b1fea24fe..edf1d56e4f13 100644
--- a/arch/riscv/include/asm/string.h
+++ b/arch/riscv/include/asm/string.h
@@ -12,9 +12,11 @@
 #define __HAVE_ARCH_MEMSET
 extern asmlinkage void *memset(void *, int, size_t);
 extern asmlinkage void *__memset(void *, int, size_t);
+
 #define __HAVE_ARCH_MEMCPY
-extern asmlinkage void *memcpy(void *, const void *, size_t);
-extern asmlinkage void *__memcpy(void *, const void *, size_t);
+extern void *memcpy(void *dest, const void *src, size_t count);
+extern void *__memcpy(void *dest, const void *src, size_t count);
+
 #define __HAVE_ARCH_MEMMOVE
 extern asmlinkage void *memmove(void *, const void *, size_t);
 extern asmlinkage void *__memmove(void *, const void *, size_t);
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
index a72879b4249a..c69dc74e0a27 100644
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -10,11 +10,9 @@
  * Assembly functions that may be used (directly or indirectly) by modules
  */
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strncmp);
 EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memmove);
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index bd6e6c1b0497..5f2f94f6db17 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 lib-y			+= delay.o
-lib-y			+= memcpy.o
 lib-y			+= memset.o
 lib-y			+= memmove.o
 lib-y			+= strcmp.o
 lib-y			+= strlen.o
+lib-y			+= string.o
 lib-y			+= strncmp.o
 lib-y			+= csum.o
 ifeq ($(CONFIG_MMU), y)
@@ -14,6 +14,11 @@ lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
 
+# string.o implements standard library functions like memset/memcpy etc.
+# Use -ffreestanding to ensure that the compiler does not try to "optimize"
+# them into calls to themselves.
+CFLAGS_string.o := -ffreestanding
+
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 lib-$(CONFIG_RISCV_ISA_V)	+= xor.o
 lib-$(CONFIG_RISCV_ISA_V)	+= riscv_v_helpers.o
diff --git a/arch/riscv/lib/memcpy.S b/arch/riscv/lib/memcpy.S
deleted file mode 100644
index 44e009ec5fef..000000000000
--- a/arch/riscv/lib/memcpy.S
+++ /dev/null
@@ -1,110 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2013 Regents of the University of California
- */
-
-#include <linux/linkage.h>
-#include <asm/asm.h>
-
-/* void *memcpy(void *, const void *, size_t) */
-SYM_FUNC_START(__memcpy)
-	move t6, a0  /* Preserve return value */
-
-	/* Defer to byte-oriented copy for small sizes */
-	sltiu a3, a2, 128
-	bnez a3, 4f
-	/* Use word-oriented copy only if low-order bits match */
-	andi a3, t6, SZREG-1
-	andi a4, a1, SZREG-1
-	bne a3, a4, 4f
-
-	beqz a3, 2f  /* Skip if already aligned */
-	/*
-	 * Round to nearest double word-aligned address
-	 * greater than or equal to start address
-	 */
-	andi a3, a1, ~(SZREG-1)
-	addi a3, a3, SZREG
-	/* Handle initial misalignment */
-	sub a4, a3, a1
-1:
-	lb a5, 0(a1)
-	addi a1, a1, 1
-	sb a5, 0(t6)
-	addi t6, t6, 1
-	bltu a1, a3, 1b
-	sub a2, a2, a4  /* Update count */
-
-2:
-	andi a4, a2, ~((16*SZREG)-1)
-	beqz a4, 4f
-	add a3, a1, a4
-3:
-	REG_L a4,       0(a1)
-	REG_L a5,   SZREG(a1)
-	REG_L a6, 2*SZREG(a1)
-	REG_L a7, 3*SZREG(a1)
-	REG_L t0, 4*SZREG(a1)
-	REG_L t1, 5*SZREG(a1)
-	REG_L t2, 6*SZREG(a1)
-	REG_L t3, 7*SZREG(a1)
-	REG_L t4, 8*SZREG(a1)
-	REG_L t5, 9*SZREG(a1)
-	REG_S a4,       0(t6)
-	REG_S a5,   SZREG(t6)
-	REG_S a6, 2*SZREG(t6)
-	REG_S a7, 3*SZREG(t6)
-	REG_S t0, 4*SZREG(t6)
-	REG_S t1, 5*SZREG(t6)
-	REG_S t2, 6*SZREG(t6)
-	REG_S t3, 7*SZREG(t6)
-	REG_S t4, 8*SZREG(t6)
-	REG_S t5, 9*SZREG(t6)
-	REG_L a4, 10*SZREG(a1)
-	REG_L a5, 11*SZREG(a1)
-	REG_L a6, 12*SZREG(a1)
-	REG_L a7, 13*SZREG(a1)
-	REG_L t0, 14*SZREG(a1)
-	REG_L t1, 15*SZREG(a1)
-	addi a1, a1, 16*SZREG
-	REG_S a4, 10*SZREG(t6)
-	REG_S a5, 11*SZREG(t6)
-	REG_S a6, 12*SZREG(t6)
-	REG_S a7, 13*SZREG(t6)
-	REG_S t0, 14*SZREG(t6)
-	REG_S t1, 15*SZREG(t6)
-	addi t6, t6, 16*SZREG
-	bltu a1, a3, 3b
-	andi a2, a2, (16*SZREG)-1  /* Update count */
-
-4:
-	/* Handle trailing misalignment */
-	beqz a2, 6f
-	add a3, a1, a2
-
-	/* Use word-oriented copy if co-aligned to word boundary */
-	or a5, a1, t6
-	or a5, a5, a3
-	andi a5, a5, 3
-	bnez a5, 5f
-7:
-	lw a4, 0(a1)
-	addi a1, a1, 4
-	sw a4, 0(t6)
-	addi t6, t6, 4
-	bltu a1, a3, 7b
-
-	ret
-
-5:
-	lb a4, 0(a1)
-	addi a1, a1, 1
-	sb a4, 0(t6)
-	addi t6, t6, 1
-	bltu a1, a3, 5b
-6:
-	ret
-SYM_FUNC_END(__memcpy)
-SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
-SYM_FUNC_ALIAS(__pi_memcpy, __memcpy)
-SYM_FUNC_ALIAS(__pi___memcpy, __memcpy)
diff --git a/arch/riscv/lib/string.c b/arch/riscv/lib/string.c
new file mode 100644
index 000000000000..5f9c83ec548d
--- /dev/null
+++ b/arch/riscv/lib/string.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * String functions optimized for hardware which doesn't
+ * handle unaligned memory accesses efficiently.
+ *
+ * Copyright (C) 2021 Matteo Croce
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+
+/* Minimum size for a word copy to be convenient */
+#define BYTES_LONG	sizeof(long)
+#define WORD_MASK	(BYTES_LONG - 1)
+#define MIN_THRESHOLD	(BYTES_LONG * 2)
+
+/* convenience union to avoid cast between different pointer types */
+union types {
+	u8 *as_u8;
+	unsigned long *as_ulong;
+	uintptr_t as_uptr;
+};
+
+union const_types {
+	const u8 *as_u8;
+	const unsigned long *as_ulong;
+	const uintptr_t as_uptr;
+};
+
+static void __memcpy_aligned(unsigned long *dest, const unsigned long *src, size_t count)
+{
+	for (; count > 0; count -= BYTES_LONG * 8) {
+		register unsigned long d0, d1, d2, d3, d4, d5, d6, d7;
+		d0 = src[0];
+		d1 = src[1];
+		d2 = src[2];
+		d3 = src[3];
+		d4 = src[4];
+		d5 = src[5];
+		d6 = src[6];
+		d7 = src[7];
+		dest[0] = d0;
+		dest[1] = d1;
+		dest[2] = d2;
+		dest[3] = d3;
+		dest[4] = d4;
+		dest[5] = d5;
+		dest[6] = d6;
+		dest[7] = d7;
+		dest += 8;
+		src += 8;
+	}
+}
+
+void *__memcpy(void *dest, const void *src, size_t count)
+{
+	union const_types s = { .as_u8 = src };
+	union types d = { .as_u8 = dest };
+	int distance = 0;
+
+	if (count < MIN_THRESHOLD)
+		goto copy_remainder;
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+		/* Copy a byte at time until destination is aligned. */
+		for (; d.as_uptr & WORD_MASK; count--)
+			*d.as_u8++ = *s.as_u8++;
+
+		distance = s.as_uptr & WORD_MASK;
+	}
+
+	if (distance) {
+		unsigned long last, next;
+
+		/*
+		 * s is distance bytes ahead of d, and d just reached
+		 * the alignment boundary. Move s backward to word align it
+		 * and shift data to compensate for distance, in order to do
+		 * word-by-word copy.
+		 */
+		s.as_u8 -= distance;
+
+		next = s.as_ulong[0];
+		for (; count >= BYTES_LONG; count -= BYTES_LONG) {
+			last = next;
+			next = s.as_ulong[1];
+
+			d.as_ulong[0] = last >> (distance * 8) |
+					next << ((BYTES_LONG - distance) * 8);
+
+			d.as_ulong++;
+			s.as_ulong++;
+		}
+
+		/* Restore s with the original offset. */
+		s.as_u8 += distance;
+	} else {
+		/*
+		 * If the source and dest lower bits are the same, do a simple
+		 * aligned copy.
+		 */
+		size_t aligned_count = count & ~(BYTES_LONG * 8 - 1);
+
+		__memcpy_aligned(d.as_ulong, s.as_ulong, aligned_count);
+		d.as_u8 += aligned_count;
+		s.as_u8 += aligned_count;
+		count &= BYTES_LONG * 8 - 1;
+	}
+
+copy_remainder:
+	while (count--)
+		*d.as_u8++ = *s.as_u8++;
+
+	return dest;
+}
+EXPORT_SYMBOL(__memcpy);
+
+void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
+EXPORT_SYMBOL(memcpy);
+void *__pi_memcpy(void *dest, const void *src, size_t count) __alias(__memcpy);
+void *__pi___memcpy(void *dest, const void *src, size_t count) __alias(__memcpy);
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index 280b0eb352b8..8b940ff04895 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -1,21 +1,21 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
 
-purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memcpy.o memset.o
-purgatory-y += strcmp.o strlen.o strncmp.o
+purgatory-y := purgatory.o sha256.o entry.o string.o ctype.o memset.o
+purgatory-y += strcmp.o strlen.o strncmp.o riscv_string.o
 
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
 
+$(obj)/riscv_string.o: $(srctree)/arch/riscv/lib/string.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
 $(obj)/string.o: $(srctree)/lib/string.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
 $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-$(obj)/memcpy.o: $(srctree)/arch/riscv/lib/memcpy.S FORCE
-	$(call if_changed_rule,as_o_S)
-
 $(obj)/memset.o: $(srctree)/arch/riscv/lib/memset.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-- 
2.43.0


