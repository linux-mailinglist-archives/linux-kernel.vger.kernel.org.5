Return-Path: <linux-kernel+bounces-13795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C74820F6B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 23:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5D1B217DD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 22:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16D5C2DA;
	Sun, 31 Dec 2023 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAs6avvz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72BBE48;
	Sun, 31 Dec 2023 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704060560; x=1735596560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8d1J15Mon+CMCpSQt5t6iUCErEXV8Fkc4EcOwdHGg+c=;
  b=cAs6avvzwstDeVpo1UznLzHp1Bl5ttVRCDXQA8cMNm+QWHQD+Kqk7zHZ
   RvgzlXnkB1HQl9DiIOVMmNEbr3Ps8iGy51WEVz3IlXG3Y1Fq07royI2pH
   02TVlTWYr1ebMdu/pybjgV8368+HN5Y4zA8wpIgPhaxi3P5Q1G6qzOH5H
   exa0eKZEeXjp1Y3EjlhoTbRB2l5GFeyZHhB5/iS5aO6BHYGkFTts/Tv3m
   +UYbU1RVJFYRQR3a494V7ADfUYDeQW9h8TQLWPgBSAP+RUXMXxn9uZTmc
   d1t13YCRc3xzszxZ4w+LafGd1qvQCjpWgY74FNKLGVGlZbdQXMz53PHsX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="395645655"
X-IronPort-AV: E=Sophos;i="6.04,320,1695711600"; 
   d="scan'208";a="395645655"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2023 14:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="1026390035"
X-IronPort-AV: E=Sophos;i="6.04,320,1695711600"; 
   d="scan'208";a="1026390035"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 31 Dec 2023 14:09:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rK3zc-000Jlw-1V;
	Sun, 31 Dec 2023 22:09:12 +0000
Date: Mon, 1 Jan 2024 06:09:07 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] net/smc: Improve exception handling in
 smc_llc_cli_add_link_invite()
Message-ID: <202401010536.XhzcWDPH-lkp@intel.com>
References: <5253e660-6b66-4775-ae2f-06f5a1d40be5@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5253e660-6b66-4775-ae2f-06f5a1d40be5@web.de>

Hi Markus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v6.7-rc7 next-20231222]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/net-smc-Return-directly-after-a-failed-kzalloc-in-smc_fill_gid_list/20231231-231406
base:   net/main
patch link:    https://lore.kernel.org/r/5253e660-6b66-4775-ae2f-06f5a1d40be5%40web.de
patch subject: [PATCH 2/2] net/smc: Improve exception handling in smc_llc_cli_add_link_invite()
config: x86_64-randconfig-002-20231231 (https://download.01.org/0day-ci/archive/20240101/202401010536.XhzcWDPH-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240101/202401010536.XhzcWDPH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401010536.XhzcWDPH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/smc/smc_llc.c:1175:34: warning: '&&' within '||' [-Wlogical-op-parentheses]
    1174 |             lgr->type == SMC_LGR_ASYMMETRIC_PEER ||
         |                                                  ~~
    1175 |             lgr->type == SMC_LGR_SINGLE && lgr->max_links <= 1)
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   net/smc/smc_llc.c:1175:34: note: place parentheses around the '&&' expression to silence this warning
    1175 |             lgr->type == SMC_LGR_SINGLE && lgr->max_links <= 1)
         |                                         ^                     
         |             (                                                 )
   1 warning generated.


vim +1175 net/smc/smc_llc.c

  1160	
  1161	/* as an SMC client, invite server to start the add_link processing */
  1162	static void smc_llc_cli_add_link_invite(struct smc_link *link,
  1163						struct smc_llc_qentry *qentry)
  1164	{
  1165		struct smc_link_group *lgr = smc_get_lgr(link);
  1166		struct smc_init_info *ini;
  1167	
  1168		if (lgr->smc_version == SMC_V2) {
  1169			smc_llc_send_request_add_link(link);
  1170			goto free_qentry;
  1171		}
  1172	
  1173		if (lgr->type == SMC_LGR_SYMMETRIC ||
  1174		    lgr->type == SMC_LGR_ASYMMETRIC_PEER ||
> 1175		    lgr->type == SMC_LGR_SINGLE && lgr->max_links <= 1)
  1176			goto free_qentry;
  1177	
  1178		ini = kzalloc(sizeof(*ini), GFP_KERNEL);
  1179		if (!ini)
  1180			goto free_qentry;
  1181	
  1182		ini->vlan_id = lgr->vlan_id;
  1183		smc_pnet_find_alt_roce(lgr, ini, link->smcibdev);
  1184		if (!ini->ib_dev)
  1185			goto out;
  1186	
  1187		smc_llc_send_add_link(link, ini->ib_dev->mac[ini->ib_port - 1],
  1188				      ini->ib_gid, NULL, SMC_LLC_REQ);
  1189	out:
  1190		kfree(ini);
  1191	free_qentry:
  1192		kfree(qentry);
  1193	}
  1194	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

