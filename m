Return-Path: <linux-kernel+bounces-39429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9A83D106
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B387E1C247FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADE91B596;
	Thu, 25 Jan 2024 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KM6zBS97"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF218EA1;
	Thu, 25 Jan 2024 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227057; cv=none; b=R/XM9D6j12Ij3WWtrcvaWOGMr/Xb56OIlz1nEFGZWfKDuzKeg/Xlj1a/g9HwLkwSB+d40oKNbt0rmUwFo8dQMvCTo4O77yD7ewzDa9rVplpuLBXuTfurOyGY5KrQM90E60dsHmYw/sko+L2CohZpiPdSFRRtCXT5PStaqPTVsrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227057; c=relaxed/simple;
	bh=3uFlompF9soIL+QzuHer4RVOjpFnG41ZrxgVyatxx8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O+vpE8ilzi/M+7qJ8mUjH2jE9MnVpvmPALXGh04OW1m+mMzAkj3oqWxT0Gvy62wYdJ6UbjpkLPaXzGo255Gk++3l6fea8ie9me53V8wy5PADFRPE4gXS9JwoK93ajMnwCpIT4FhClUccv9pFAIq6HPUwip5fr2xpPsevtMOuYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KM6zBS97; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706227056; x=1737763056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3uFlompF9soIL+QzuHer4RVOjpFnG41ZrxgVyatxx8I=;
  b=KM6zBS977o27qcXCShMYAJlvcMarJx/DOFiaMuh2R85okz5H66PHZuH3
   SXkp3p6ORLEwIbpEm73AklHagXcGMvyUDMs8BmOzPJ6PaDKIw/8V6FmzC
   kSFohTJBYqI2jtFr4oyFxAZkij5JgrvhbSYSBV+ZjHWq//xp96rqmAKaU
   4wO4A6AC+SJCWo112bK48R5Lg22XsUnRJYvTnSvwQ4C+2WbY47/X2Gfwp
   Rs/nMxp2rMS+nGRdNnt4DoiP/JObf4/K9wnbW/LOt5n0M7Jeovu358J0k
   wHKkTeWbKS3pfdOaNlJLURdRfbY7iw+VRne24k4OA//+hz2uO8OusRUV7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15867558"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15867558"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:57:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930191095"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930191095"
Received: from vcostago-mobl3.jf.intel.com ([10.24.14.99])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:57:34 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [RFC v2 0/4] overlayfs: Optimize override/revert creds
Date: Thu, 25 Jan 2024 15:57:19 -0800
Message-ID: <20240125235723.39507-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

It was noticed that some workloads suffer from contention on
increasing/decrementing the ->usage counter in their credentials,
those refcount operations are associated with overriding/reverting the
current task credentials. (the linked thread adds more context)

In some specialized cases, overlayfs is one of them, the credentials
in question have a longer lifetime than the override/revert "critical
section". In the overlayfs case, the credentials are created when the
fs is mounted and destroyed when it's unmounted. In this case of long
lived credentials, the usage counter doesn't need to be
incremented/decremented.

Add a lighter version of credentials override/revert to be used in
these specialized cases. To make sure that the override/revert calls
are paired, add a cleanup guard macro. This was suggested here:

https://lore.kernel.org/all/20231219-marken-pochen-26d888fb9bb9@brauner/

With a small number of tweaks:
 - Used inline functions instead of macros;
 - A small change to store the credentials into the passed argument,
   the guard is now defined as (note the added '_T ='):
   
      DEFINE_GUARD(cred, const struct cred *, _T = override_creds_light(_T),
                  revert_creds_light(_T));

 - Allow "const" arguments to be used with these kind of guards;

Some comments:
 - If patch 1/4 is not a good idea (adding the cast), the alternative
   I can see is using some kind of container for the credentials;
 - The only user for the backing file ops is overlayfs, so these
   changes make sense, but may not make sense in the most general
   case;

For the numbers, some from 'perf c2c', before this series:
(edited to fit)

#
#        ----- HITM -----                                        Shared                          
#   Num  RmtHitm  LclHitm                      Symbol            Object         Source:Line  Node
# .....  .......  .......  ..........................  ................  ..................  ....
#
  -------------------------
      0      412     1028  
  -------------------------
          41.50%   42.22%  [k] revert_creds            [kernel.vmlinux]  atomic64_64.h:39     0  1
          15.05%   10.60%  [k] override_creds          [kernel.vmlinux]  atomic64_64.h:25     0  1
           0.73%    0.58%  [k] init_file               [kernel.vmlinux]  atomic64_64.h:25     0  1
           0.24%    0.10%  [k] revert_creds            [kernel.vmlinux]  cred.h:266           0  1
          32.28%   37.16%  [k] generic_permission      [kernel.vmlinux]  mnt_idmapping.h:81   0  1
           9.47%    8.75%  [k] generic_permission      [kernel.vmlinux]  mnt_idmapping.h:81   0  1
           0.49%    0.58%  [k] inode_owner_or_capable  [kernel.vmlinux]  mnt_idmapping.h:81   0  1
           0.24%    0.00%  [k] generic_permission      [kernel.vmlinux]  namei.c:354          0

  -------------------------
      1       50      103  
  -------------------------
         100.00%  100.00%  [k] update_cfs_group  [kernel.vmlinux]  atomic64_64.h:15   0  1

  -------------------------
      2       50       98  
  -------------------------
          96.00%   96.94%  [k] update_cfs_group  [kernel.vmlinux]  atomic64_64.h:15   0  1
           2.00%    1.02%  [k] update_load_avg   [kernel.vmlinux]  atomic64_64.h:25   0  1
           0.00%    2.04%  [k] update_load_avg   [kernel.vmlinux]  fair.c:4118        0
           2.00%    0.00%  [k] update_cfs_group  [kernel.vmlinux]  fair.c:3932        0  1

after this series:

#
#        ----- HITM -----                                   Shared                        
#   Num  RmtHitm  LclHitm                 Symbol            Object       Source:Line  Node
# .....  .......  .......   ....................  ................  ................  ....
#
  -------------------------
      0       54       88  
  -------------------------
         100.00%  100.00%   [k] update_cfs_group  [kernel.vmlinux]  atomic64_64.h:15   0  1

  -------------------------
      1       48       83  
  -------------------------
          97.92%   97.59%   [k] update_cfs_group  [kernel.vmlinux]  atomic64_64.h:15   0  1
           2.08%    1.20%   [k] update_load_avg   [kernel.vmlinux]  atomic64_64.h:25   0  1
           0.00%    1.20%   [k] update_load_avg   [kernel.vmlinux]  fair.c:4118        0  1

  -------------------------
      2       28       44  
  -------------------------
          85.71%   79.55%   [k] generic_permission      [kernel.vmlinux]  mnt_idmapping.h:81   0  1
          14.29%   20.45%   [k] generic_permission      [kernel.vmlinux]  mnt_idmapping.h:81   0  1


The contention is practically gone.

Link: https://lore.kernel.org/all/20231018074553.41333-1-hu1.chen@intel.com/

Vinicius Costa Gomes (4):
  cleanup: Fix discarded const warning when defining guards
  cred: Add a light version of override/revert_creds()
  overlayfs: Optimize credentials usage
  fs: Optimize credentials reference count for backing file ops

 fs/backing-file.c       | 124 +++++++++++++++++++---------------------
 fs/overlayfs/copy_up.c  |   4 +-
 fs/overlayfs/dir.c      |  22 +++----
 fs/overlayfs/file.c     |  70 ++++++++++++-----------
 fs/overlayfs/inode.c    |  60 ++++++++++---------
 fs/overlayfs/namei.c    |  21 ++++---
 fs/overlayfs/readdir.c  |  18 +++---
 fs/overlayfs/util.c     |  23 ++++----
 fs/overlayfs/xattrs.c   |  34 +++++------
 include/linux/cleanup.h |   2 +-
 include/linux/cred.h    |  21 +++++++
 kernel/cred.c           |   6 +-
 12 files changed, 215 insertions(+), 190 deletions(-)

-- 
2.43.0


