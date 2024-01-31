Return-Path: <linux-kernel+bounces-46145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF29843B37
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D62E1C23581
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C3867A1F;
	Wed, 31 Jan 2024 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/6n7WUg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E80C633F5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693843; cv=none; b=paa0FKO96Vwoykxm2zwHS0fksAb8fr79a9NA5KxiWygb+E5zaybSBHJKLmQBIySYm4m2pzzcLu3JROKilE0x3phdWSnCIqJHHhNf3yRoWMdFNw1jnq+kkKG1yjPTpbbQw9wYFxz2P6IRUitjgQ7aM7qn1FiQXCPVn6k8uOnjpTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693843; c=relaxed/simple;
	bh=hWOX5/cVsVWdpt4YPLRhHull1xnJHywBmaWuuJ890DI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mz05+tJdCL7I9V53TPPgNPPqzpwzou2OmGYqYtXKkyVsQJIFhWfBiS62ARX9gEAZgWD08mcKAQEe/pmKtVxvxEyCIHA9XbVwPdxyLgSi57uflp3EXV5Pki1SsmD+VxXohberrrpTHkVbIoEgG0cMlQehKA2fK4EGivKbwvmXcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/6n7WUg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706693842; x=1738229842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hWOX5/cVsVWdpt4YPLRhHull1xnJHywBmaWuuJ890DI=;
  b=R/6n7WUgXMbI4suPu84TrdGicpMA74dp8pwXaG7lL23SKr57cqiuIDju
   LUvZ7UdBqCWCjFj7evVApbMzIwCxTpplYzbiTREPypRemJqFnZMraBxGb
   snDLrQHmOYez/lSNmjY+mSDh+FvGUSur306UoT5Rp6ZryO0z7zQ/Esl2N
   n0BlEWb7Ac0GlnaPQNNAi+xjeEnRgeLiFyinRlOpHdCg3YxUkh+PI/WVC
   k6A3YncharY1MvjWrevFr/OxhDbCIKkhUm5FvMmElXbCc67McgFWHHkCz
   JDZ5Y78mZfwURNlNKzWB6c74EsV4zPiaal1qkksNs/4mZ1KBeQjlduQcl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2488817"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2488817"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 01:37:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="36805516"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 31 Jan 2024 01:37:20 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rV71t-0001Or-36;
	Wed, 31 Jan 2024 09:37:14 +0000
Date: Wed, 31 Jan 2024 17:34:50 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: kernel/ptrace.o: warning: objtool: .text.unlikely: unexpected end of
 section
Message-ID: <202401311748.wrSxIcOq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1bbb19b6eb1b8685ab1c268a401ea64380b8bbcb
commit: 5431fdd2c181dd2eac218e45b44deb2925fa48f0 ptrace: Convert ptrace_attach() to use lock guards
date:   9 weeks ago
config: x86_64-buildonly-randconfig-r002-20230716 (https://download.01.org/0day-ci/archive/20240131/202401311748.wrSxIcOq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401311748.wrSxIcOq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401311748.wrSxIcOq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/ptrace.o: warning: objtool: .text.unlikely: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

