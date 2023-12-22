Return-Path: <linux-kernel+bounces-9937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB2981CD80
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4700E1F22F42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838B528DC1;
	Fri, 22 Dec 2023 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjMAzaYa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7562F25749;
	Fri, 22 Dec 2023 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703265259; x=1734801259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h9oSkiLpIQ4ZTQ9P/spHt8kihGGmKQmFaktBUWa+OUY=;
  b=LjMAzaYayRW5JTUkS6WgcpD749m7jGfqccPEkFrJML8rzscnVO0W71iy
   Imc/6DQSitfIsb3W8fI5SSVOKR4FxFS4fsDpnQ2LDlPddgKuY1MskJCDE
   jl//3dBxXHsvCfuB6rvErwXqOu4Rt3IcrMYgA3oTRr6mHW0LSbZnm6wbx
   5kH16NSQy97GWhmIIhOhhQTkSLWQalY72q/m72Hr5vuF4jaW+K8USh26L
   C1Nm5Rjy2WwDf8P644H83R9lkMasTd0AmOX5tfaHoGh69NAAcccuB+baF
   ue5gfQAPGZhX4olg/8kz8PpLgxihHo+G21JCO4uEmEY7raJ+B0dbFK3Fo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="462576695"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="462576695"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 09:14:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="780599302"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="780599302"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2023 09:14:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGj6A-0009gP-2V;
	Fri, 22 Dec 2023 17:14:10 +0000
Date: Sat, 23 Dec 2023 01:13:42 +0800
From: kernel test robot <lkp@intel.com>
To: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hgani@marvell.com, vimleshk@marvell.com,
	sedara@marvell.com, srasheed@marvell.com, egallen@redhat.com,
	mschmidt@redhat.com, pabeni@redhat.com, kuba@kernel.org,
	horms@kernel.org, wizhao@redhat.com, kheib@redhat.com,
	konguyen@redhat.com, Eric Dumazet <edumazet@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Phani Burra <phani.r.burra@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v1 1/8] octeon_ep_vf: Add driver framework and
 device initialization
Message-ID: <202312230106.7jspEybY-lkp@intel.com>
References: <20231221092844.2885872-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221092844.2885872-2-srasheed@marvell.com>

Hi Shinas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Shinas-Rasheed/octeon_ep_vf-Add-driver-framework-and-device-initialization/20231222-174910
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231221092844.2885872-2-srasheed%40marvell.com
patch subject: [PATCH net-next v1 1/8] octeon_ep_vf: Add driver framework and device initialization
reproduce: (https://download.01.org/0day-ci/archive/20231223/202312230106.7jspEybY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312230106.7jspEybY-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/clang/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make KCFLAGS= -Wtautological-compare -Wno-error=return-type -Wreturn-type -Wcast-function-type -funsigned-char -Wundef -Wformat-overflow -Wformat-truncation -Wstringop-overflow -Wrestrict -Wenum-conversion W=1 --keep-going HOSTCC=gcc-12 CC=gcc-12 -j32 KBUILD_MODPOST_WARN=1 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
   ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
>> ./drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c: 16 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
   ./samples/bpf/spintest.bpf.c: 8 linux/version.h not needed.
   ./samples/trace_events/trace_custom_sched.c: 11 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 403: need linux/version.h
   ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 27 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

