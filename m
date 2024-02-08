Return-Path: <linux-kernel+bounces-58192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F784E28D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840D61F2245E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EFE7D40A;
	Thu,  8 Feb 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUJNWnmZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854E7D40D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400367; cv=none; b=aR367ywIduQBw0VooRjcZM2EWipEKhmiy87Xlud1jAghHwVoszu1hl5i/Iwv9FBracrhBbsqL5vVsNL3j5Ix6POEuArkHh9OwWkmiWvBica6SpRL4SkDsDHt01l4Z1Rb57FtkesfsOS6MvliMqYaEkEuFeTl5jZ7G6VCk8t9vqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400367; c=relaxed/simple;
	bh=9xl/xf5Zm2xj1VG07G8QhuS3IcaSc1uWPaXLLQ05TAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rzCb4TLhd5u0jHnqPl5Hz3us8bb7UWo3rVKjR161rQKJ4Au0GJd7GRwcgjH/fzt0Ml3xe/9ZsZSRw5CMk+506rFZer4005DIAXTkPUTugxJJWDYTknYZhy7qr9m2pno8GwjTGMcGFWk31VTLbHBkf6E0b8ih0Gum7PQnqsqB3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUJNWnmZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707400366; x=1738936366;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9xl/xf5Zm2xj1VG07G8QhuS3IcaSc1uWPaXLLQ05TAw=;
  b=YUJNWnmZcZltKUFjIxcT/wd1eu9X63VVQ9YcuuN3MCUrAhm831HHO4a1
   zFZoV68eNYTMhHZO7Vw58vJ+sh4N/KNBTktmIvcgLXrmx9PVjuu/vFH43
   oJrzY32Zv0tgmSEo1qwa1KVxCC/4btJDVihibqlXbzbbnY1NMEme/5Zx0
   IBX25iJQe6V6XKQ/Td9akWIn/8nx+HItsNHny3vjX+Ss0nAph4fJszYE8
   JOyFBU2eZ9Ijfo6K5jPJubJIeXFgEkwwTeGUv9eNiJGJsrCT7cSdYQO5Y
   /3uURUESyNebNc971nQvELJ+UF5PfCPNNM5TfkCGhsgFpRK7OzwdGf00b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="5001936"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="5001936"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:52:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6283423"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Feb 2024 05:52:43 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rY4pU-0003n6-0i;
	Thu, 08 Feb 2024 13:52:40 +0000
Date: Thu, 8 Feb 2024 21:52:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam0-next20240207 1/1]
 ./usr/include/linux/seg6_hmac.h:12:17: warning: field 'tlvhdr' with variable
 sized type 'struct sr6_tlv' not at the end of a struct or class is a GNU
 extension
Message-ID: <202402082103.XZKY73Gh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam0-next20240207
head:   8fbd8ae9e6d71833931c62ad11ca636ccb833387
commit: 8fbd8ae9e6d71833931c62ad11ca636ccb833387 [1/1] treewide: Replace zero-length arrays with flex-array members
config: i386-randconfig-013-20240208 (https://download.01.org/0day-ci/archive/20240208/202402082103.XZKY73Gh-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240208/202402082103.XZKY73Gh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402082103.XZKY73Gh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/seg6_hmac.h:12:17: warning: field 'tlvhdr' with variable sized type 'struct sr6_tlv' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
      12 |         struct sr6_tlv tlvhdr;
         |                        ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

