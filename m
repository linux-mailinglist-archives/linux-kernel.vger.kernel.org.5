Return-Path: <linux-kernel+bounces-10805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9569F81DC03
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1F31F2178E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 18:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA3D2EE;
	Sun, 24 Dec 2023 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDlNubcP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D674FBE8;
	Sun, 24 Dec 2023 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703444099; x=1734980099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QkRfWSWR/XMDhOsYtyqhQDrgzSxc71smIy67/8QzOS4=;
  b=XDlNubcPBAKkvsgn68yIY33Hf9fEEggOYSqaRZb8uvq7s+iKUlSfMR7T
   tNpQ/bUqwns131836znNJW5y++RzO+mDALQQHbSlm66KpTtEcbhur6AR7
   E8gdu7SFesAtN8Q3ISZ0OaTsrf9PLXaG8b0oEAezx2Aw6QE33nxBeLujB
   4rbLpFRYEl0eUEn7YjDyY6f5PmkUoDw4ad0YjEVjaSG7cqMpYH98Jpem4
   X7F0A/O1/ue/xHXabJVEVukJ6AcJk8pUc1Eod8Gm0UFMfFxV7s60YzodN
   3XtTfwmfLHnDseiJ9evw4vTcllTNeCuNhmi9TyjkRL+ERsegBIRdYk2J/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="427414104"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="427414104"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 10:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="848056972"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="848056972"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Dec 2023 10:54:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHTcg-000CXN-1n;
	Sun, 24 Dec 2023 18:54:51 +0000
Date: Mon, 25 Dec 2023 02:54:48 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net,
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH next] crypto: fix oob Read in arc4_crypt
Message-ID: <202312250259.yyBgM27K-lkp@intel.com>
References: <tencent_656D589558EA3EED8ACF3C79166F202E010A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_656D589558EA3EED8ACF3C79166F202E010A@qq.com>

Hi Edward,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231222]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/crypto-fix-oob-Read-in-arc4_crypt/20231222-172845
base:   next-20231222
patch link:    https://lore.kernel.org/r/tencent_656D589558EA3EED8ACF3C79166F202E010A%40qq.com
patch subject: [PATCH next] crypto: fix oob Read in arc4_crypt
config: i386-buildonly-randconfig-003-20231224 (https://download.01.org/0day-ci/archive/20231225/202312250259.yyBgM27K-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312250259.yyBgM27K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312250259.yyBgM27K-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/crypto/padlock-aes.c:13:
>> include/crypto/internal/skcipher.h:27:33: warning: 'crypto_skcipher_type' defined but not used [-Wunused-const-variable=]
      27 | static const struct crypto_type crypto_skcipher_type;
         |                                 ^~~~~~~~~~~~~~~~~~~~


vim +/crypto_skcipher_type +27 include/crypto/internal/skcipher.h

    24	
    25	struct aead_request;
    26	struct rtattr;
  > 27	static const struct crypto_type crypto_skcipher_type;
    28	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

