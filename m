Return-Path: <linux-kernel+bounces-31850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2F83356F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D69F1C218F3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691D31095C;
	Sat, 20 Jan 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="cGpXFM98"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88F14AAB
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705770122; cv=none; b=lvN34BBHQ6bpVIGb7oqYj+TripAAbJgnXzgihIAa9ku7z56AFkm2AHy2Qghh3hG5vFKggnxCujssf9KYaSmM/yXKo4Lb/f8AvvXVA74iZONjt9S8DWvMpaOXIHmk4lK/vrfvwmFrHF2RONjMjMygDAQFDYLyktHi2qmuDikMxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705770122; c=relaxed/simple;
	bh=iOKtxqkD+uVBgNmg41T8J8mZCNBvDaB3xqiyDIU9ZEA=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=ArJ1KAL1FzA9HGE/KNy6rBebItExEMP45zWYq8xEMtD+M+QFr1xLCU7KEBPEKTVVtOxANysZdrj6Sro2KCNxcaaqvtov1czTLFNiYUcb5hZ5O+tq4x6vWKfaIHimE2ol0aLq+sSo6XDFyA3aKz6Y7ki5Ps66JgvPQlKNcGH28Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=cGpXFM98; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PcVDw+MAg0iXihFy7kIFofjy7tQqpJkW2nROprh3snQ=;
  b=cGpXFM989Nd+JoJA+xDXSj1VV/aEGoAWmr19ute3OnKMI2HYnOIhs1+/
   XkhsYZ80BkCjQzcUCkk5tCF/iC76GHa2kp+2NobQToop/sB7RsYd+h35Z
   ouh2wZ8BfO6CVUMaVpAgmSMj4yLH6WGs6mDS5fDDDAVB28IIoH52D/+Sk
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,208,1701126000"; 
   d="scan'208";a="77357534"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 18:01:53 +0100
Date: Sat, 20 Jan 2024 18:01:53 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
    Sebastian Reichel <sebastian.reichel@collabora.com>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/clk/rockchip/clk-pll.c:912:2-8: WARNING: do_div() does a
 64-by-32 division, please consider using div64_u64 instead. (fwd)
Message-ID: <alpine.DEB.2.22.394.2401201801080.3267@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Sun, 21 Jan 2024 00:55:25 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/clk/rockchip/clk-pll.c:912:2-8: WARNING: do_div() does a
    64-by-32 division, please consider using div64_u64 instead.

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Elaine Zhang <zhangqing@rock-chips.com>
CC: Heiko Stuebner <heiko@sntech.de>
CC: Sebastian Reichel <sebastian.reichel@collabora.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d64bf433c53cab2f48a3fff7a1f2a696bc5229a
commit: 8f6594494b1cb0ad14493795b436413cfe64a0f8 clk: rockchip: add pll type for RK3588
date:   1 year, 2 months ago
:::::: branch date: 18 hours ago
:::::: commit date: 1 year, 2 months ago
config: arm-randconfig-r062-20240117 (https://download.01.org/0day-ci/archive/20240121/202401210007.174n0NM0-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202401210007.174n0NM0-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/clk/rockchip/clk-pll.c:912:2-8: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.

vim +912 drivers/clk/rockchip/clk-pll.c

8f6594494b1cb0 Elaine Zhang 2022-10-18  895
8f6594494b1cb0 Elaine Zhang 2022-10-18  896  static unsigned long rockchip_rk3588_pll_recalc_rate(struct clk_hw *hw, unsigned long prate)
8f6594494b1cb0 Elaine Zhang 2022-10-18  897  {
8f6594494b1cb0 Elaine Zhang 2022-10-18  898  	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
8f6594494b1cb0 Elaine Zhang 2022-10-18  899  	struct rockchip_pll_rate_table cur;
8f6594494b1cb0 Elaine Zhang 2022-10-18  900  	u64 rate64 = prate, postdiv;
8f6594494b1cb0 Elaine Zhang 2022-10-18  901
8f6594494b1cb0 Elaine Zhang 2022-10-18  902  	rockchip_rk3588_pll_get_params(pll, &cur);
8f6594494b1cb0 Elaine Zhang 2022-10-18  903
8f6594494b1cb0 Elaine Zhang 2022-10-18  904  	rate64 *= cur.m;
8f6594494b1cb0 Elaine Zhang 2022-10-18  905  	do_div(rate64, cur.p);
8f6594494b1cb0 Elaine Zhang 2022-10-18  906
8f6594494b1cb0 Elaine Zhang 2022-10-18  907  	if (cur.k) {
8f6594494b1cb0 Elaine Zhang 2022-10-18  908  		/* fractional mode */
8f6594494b1cb0 Elaine Zhang 2022-10-18  909  		u64 frac_rate64 = prate * cur.k;
8f6594494b1cb0 Elaine Zhang 2022-10-18  910
8f6594494b1cb0 Elaine Zhang 2022-10-18  911  		postdiv = cur.p * 65535;
8f6594494b1cb0 Elaine Zhang 2022-10-18 @912  		do_div(frac_rate64, postdiv);
8f6594494b1cb0 Elaine Zhang 2022-10-18  913  		rate64 += frac_rate64;
8f6594494b1cb0 Elaine Zhang 2022-10-18  914  	}
8f6594494b1cb0 Elaine Zhang 2022-10-18  915  	rate64 = rate64 >> cur.s;
8f6594494b1cb0 Elaine Zhang 2022-10-18  916
8f6594494b1cb0 Elaine Zhang 2022-10-18  917  	return (unsigned long)rate64;
8f6594494b1cb0 Elaine Zhang 2022-10-18  918  }
8f6594494b1cb0 Elaine Zhang 2022-10-18  919

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

