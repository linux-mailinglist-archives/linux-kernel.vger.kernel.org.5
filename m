Return-Path: <linux-kernel+bounces-74879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526B85DE92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FBF1F24803
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC1C69962;
	Wed, 21 Feb 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEiH24lQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C443C69D38;
	Wed, 21 Feb 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525161; cv=none; b=OcoA8ginLsodMlFk2OfNuRyGj5GzRE43WKmc+MpETkusXoX1p8tts+E3VSX2AeBiSQPR8vl5wr/AePSaChqFUj2eQNFvRDa91vVWs1U2u9e3ZYxh3tg9CdjqM4DMYNavC4oYBDQyWVbFid2mt3dUIVYowkgDGmEnWYOqNWNx4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525161; c=relaxed/simple;
	bh=pBP4apZEIb1BfKNb3zOTB1MGhktsRwpxUnHa99kXSi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGafaXrJ4wQmUYUcO/JO32ygbjBebA+u1T8CiGsBkjr/sObiJKcXlAxoV02HIDP6d/+DM7dwoh9edVtUmHjO/D3N0eOI23HEgiKtWsxRNLONYWuQuM0XhKveK5mFb+Q1orjMd61bPFSMijns16/MwaNQ32sn0E/N1M1wDe3Zq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEiH24lQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708525159; x=1740061159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pBP4apZEIb1BfKNb3zOTB1MGhktsRwpxUnHa99kXSi8=;
  b=hEiH24lQoLUcWGjscdt0R9nB/F5dveWGHhloVHH/r3eyB0ygzx/V8W1k
   l7/y+OA29+8rC6G2UG3wGOXdLCGm/3xcLnu+AUu0HPbk4y1yQdXz3O5Cr
   OnSip6Zm7sV9Fd0u4WCim8LSnm/7YcC/usT7EwxxkqkQzRD9ddC+2rO3/
   j5B0lh0qb7cKqfuV+K6c5BTuoSDjx59vc/nzwxNJRAEhx3BR7TiaFvcMX
   6QX95b+FlBI9b3vm9FLPxS0qOAOVpSuPIiKZsRRG7D6Jc5pl6zcc3hJ5a
   U9jHxcz57vt6dO5pOtPzOD/lNtmVKLrnMWbq2rfAXhkfrxrHh6yfcTR9B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="25149096"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="25149096"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:19:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="28298325"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Feb 2024 06:19:17 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcnRD-0005Om-19;
	Wed, 21 Feb 2024 14:19:08 +0000
Date: Wed, 21 Feb 2024 22:18:06 +0800
From: kernel test robot <lkp@intel.com>
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, justin.iurman@uliege.be
Subject: Re: [PATCH net-next 2/3] ioam6: multicast event
Message-ID: <202402212253.mfysd5E1-lkp@intel.com>
References: <20240220194444.36127-3-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220194444.36127-3-justin.iurman@uliege.be>

Hi Justin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a6e0cb150c514efba4aaba4069927de43d80bb59]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Iurman/uapi-ioam6-API-for-netlink-multicast-events/20240221-034623
base:   a6e0cb150c514efba4aaba4069927de43d80bb59
patch link:    https://lore.kernel.org/r/20240220194444.36127-3-justin.iurman%40uliege.be
patch subject: [PATCH net-next 2/3] ioam6: multicast event
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20240221/202402212253.mfysd5E1-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240221/202402212253.mfysd5E1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402212253.mfysd5E1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv6/ioam6.c: In function 'ioam6_event':
>> net/ipv6/ioam6.c:657:9: warning: enumeration value 'IOAM6_EVENT_UNSPEC' not handled in switch [-Wswitch]
     657 |         switch (type) {
         |         ^~~~~~


vim +/IOAM6_EVENT_UNSPEC +657 net/ipv6/ioam6.c

   638	
   639	void ioam6_event(enum ioam6_event_type type, struct net *net, gfp_t gfp,
   640			 void *opt, unsigned int opt_len)
   641	{
   642		struct nlmsghdr *nlh;
   643		struct sk_buff *skb;
   644	
   645		if (!genl_has_listeners(&ioam6_genl_family, net,
   646					IOAM6_GENL_EV_GRP_OFFSET))
   647			return;
   648	
   649		skb = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
   650		if (!skb)
   651			return;
   652	
   653		nlh = genlmsg_put(skb, 0, 0, &ioam6_genl_family, 0, type);
   654		if (!nlh)
   655			goto nla_put_failure;
   656	
 > 657		switch (type) {
   658		case IOAM6_EVENT_TRACE:
   659			if (ioam6_event_put_trace(skb, (struct ioam6_trace_hdr *)opt,
   660						  opt_len))
   661				goto nla_put_failure;
   662			break;
   663		}
   664	
   665		genlmsg_end(skb, nlh);
   666		genlmsg_multicast_netns(&ioam6_genl_family, net, skb, 0,
   667					IOAM6_GENL_EV_GRP_OFFSET, gfp);
   668		return;
   669	
   670	nla_put_failure:
   671		nlmsg_free(skb);
   672	}
   673	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

