Return-Path: <linux-kernel+bounces-88363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96F86E081
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9451F22140
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D1B6E5FB;
	Fri,  1 Mar 2024 11:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gly2++nY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7AD6E5FA;
	Fri,  1 Mar 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292973; cv=none; b=Pb0qFFtBs61Ej1RkIkJc1D4nwn/7ROtH1w5a3PGyWL/AlHDYej2JwJnvv7F3sUzPE8SfGe/k+X37VAILjm+sw5QYBNSEu8PASHSl9YoOVH6fzK4HB91/RrGX+panEJ6kFE68h9ZPt0DdQ6pev313ot4fvp49kOa9sklQcsiLEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292973; c=relaxed/simple;
	bh=IUevqR1A07cWHkVggjDSo4XmHuRv9F+Y/1PfArld/rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrSwQ4yEw3DA5fB7t5pZ48UndF9jHueEFCz/jYCe3ny0lVzvwuqpuTNkjY68GbnFdFUT0OefOtgjYakWH++8GZu0gKK8YsoGE5FQTcgJiI3Lt5lNi9tkvuO8bDRbRgn143BfVgexBXTCSavuTVNNSGw78vZnVw7zNPliWxcHbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gly2++nY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709292971; x=1740828971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IUevqR1A07cWHkVggjDSo4XmHuRv9F+Y/1PfArld/rQ=;
  b=Gly2++nYshSQB1wQElOTCOaXfcs9xo79ISBFaqOUH+1alCpWTGxuIanc
   FVPsLrmRjBMDou37D0eEtjbamt51YGKEzCGwV+ltiVykrt4MrM0mIq2+x
   mrmxLEz6EZHmsx85YOL1E6PWPNTvYiT9kJEe4pyUAoUJoy5SJ5uojc4Rt
   2OaLVzjM8QNtzgLnKUFSd/1YYu6unfV0vKeLD1f9abKv1WUzoW9UgxDfe
   rFtX2nFUAGiLb8+/lNh05V/CPEzy9feZlZMyAFTk41bWwrPp+TrwOwnOj
   RA6vibmJnBoqyA929dqLsZA3SIPZRLGiSJulhYJOfVaLPncKHsI5eDl85
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14466310"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="14466310"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 03:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="12880627"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2024 03:36:06 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rg1BL-000Dp8-0s;
	Fri, 01 Mar 2024 11:36:03 +0000
Date: Fri, 1 Mar 2024 19:35:51 +0800
From: kernel test robot <lkp@intel.com>
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/16] net: dsa: vsc73xx: add
 port_stp_state_set function
Message-ID: <202403011918.VO71zUCH-lkp@intel.com>
References: <20240223210049.3197486-7-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223210049.3197486-7-paweldembicki@gmail.com>

Hi Pawel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Pawel-Dembicki/net-dsa-vsc73xx-use-read_poll_timeout-instead-delay-loop/20240224-050950
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240223210049.3197486-7-paweldembicki%40gmail.com
patch subject: [PATCH net-next v5 06/16] net: dsa: vsc73xx: add port_stp_state_set function
config: x86_64-randconfig-161-20240301 (https://download.01.org/0day-ci/archive/20240301/202403011918.VO71zUCH-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403011918.VO71zUCH-lkp@intel.com/

smatch warnings:
drivers/net/dsa/vitesse-vsc73xx-core.c:1054 vsc73xx_refresh_fwd_map() warn: inconsistent indenting

vim +1054 drivers/net/dsa/vitesse-vsc73xx-core.c

  1031	
  1032	static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
  1033	{
  1034		struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
  1035		struct vsc73xx *vsc = ds->priv;
  1036		u16 mask;
  1037	
  1038		if (state != BR_STATE_FORWARDING) {
  1039			/* Ports that aren't in the forwarding state must not
  1040			 * forward packets anywhere.
  1041			 */
  1042			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
  1043					    VSC73XX_SRCMASKS + port,
  1044					    VSC73XX_SRCMASKS_PORTS_MASK, 0);
  1045	
  1046			dsa_switch_for_each_available_port(other_dp, ds) {
  1047				if (other_dp == dp)
  1048					continue;
  1049				vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
  1050						    VSC73XX_SRCMASKS + other_dp->index,
  1051						    BIT(port), 0);
  1052			}
  1053	
> 1054		return;
  1055		}
  1056	
  1057		/* Forwarding ports must forward to the CPU and to other ports
  1058		 * in the same bridge
  1059		 */
  1060		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
  1061				    VSC73XX_SRCMASKS + CPU_PORT, BIT(port), BIT(port));
  1062	
  1063		mask = BIT(CPU_PORT);
  1064	
  1065		if (dp->bridge) {
  1066			dsa_switch_for_each_user_port(other_dp, ds) {
  1067				if (other_dp->bridge == dp->bridge &&
  1068				    other_dp->index != port &&
  1069				    other_dp->stp_state == BR_STATE_FORWARDING) {
  1070					int other_port = other_dp->index;
  1071	
  1072					mask |= BIT(other_port);
  1073					vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER,
  1074							    0,
  1075							    VSC73XX_SRCMASKS +
  1076							    other_port,
  1077							    BIT(port), BIT(port));
  1078				}
  1079			}
  1080		}
  1081	
  1082		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
  1083				    VSC73XX_SRCMASKS + port,
  1084				    VSC73XX_SRCMASKS_PORTS_MASK, mask);
  1085	}
  1086	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

