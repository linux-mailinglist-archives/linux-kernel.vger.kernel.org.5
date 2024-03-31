Return-Path: <linux-kernel+bounces-126352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7329989357D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4341C21608
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFDD146D76;
	Sun, 31 Mar 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkdU9EiU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5570B4688;
	Sun, 31 Mar 2024 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711912141; cv=none; b=PtP8iikdgVU9g9R6EmnJwrIMDRYcM1pZh4aCVRjBlMxqgHCWLo77rxsVKDEtPOaL4AE9WbJa81Tfn46l1x4LGrasopx1AuzIdZsXGVxpPRhBMkmmcQzyRpd67LkrAdbkcUHlcRcQfx09ay6uzrk/24uPO55aTIMjVCA5k+iQ6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711912141; c=relaxed/simple;
	bh=v/zuC8dt4PV8gMPcCnVwh1IagNNndASoACR2DPKF6zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGbnnlaj5+OcavjWrXqkOKc8G4KUpLtXkQLWkqnmKpuuipIoc7a38MQyWpHVRzqPfXHVIGbjeXD/vIv3NRB/xokRHclWzs9y03w+cMa1b8ptDH4qggo7jAYCE9gw1QmcX9aJZKGVn0bEtrEQ2bKtJduzAKtODZuXYp4DekCNZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkdU9EiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348A7C433C7;
	Sun, 31 Mar 2024 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711912140;
	bh=v/zuC8dt4PV8gMPcCnVwh1IagNNndASoACR2DPKF6zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EkdU9EiU/fOn+VGtH/tMC4xLPQef/k8wjFWti0XMQjY0ZC+CwZadjgwdsOnuiSFvw
	 xPviXDAw+R09SJt/zL1282C9RYbrWZujNgIu13gna1VsZUMsilrog1MuCyndMg90jK
	 lSN7+qQFSB18Qru/PmhPexFbSbL/AZ6BJLjFFB49RRi2WZvV/NX00if0UIeggw3ap/
	 aCdVgYMQmXvS2iKJAx+VPbDgaQjccZ+aQPZbOtAsmH8KrnMRMqubWTturx7IEni3/d
	 oWhO8Gsuegc5AQVQDzgSjEth8LXHD3AnBaFIz6b41Onab2Mhk+86ujvXyomS1dCkke
	 6DLAsl7U8CMRg==
From: SeongJae Park <sj@kernel.org>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Srinivasulu Thanneeru" <sthanneeru@micron.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v9 1/2] memory tier: dax/kmem: introduce an abstract layer for finding, allocating, and putting memory types
Date: Sun, 31 Mar 2024 12:08:57 -0700
Message-Id: <20240331190857.132490-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240329053353.309557-2-horenchuang@bytedance.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ho-Ren,

On Fri, 29 Mar 2024 05:33:52 +0000 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:

> Since different memory devices require finding, allocating, and putting
> memory types, these common steps are abstracted in this patch,
> enhancing the scalability and conciseness of the code.
> 
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>  drivers/dax/kmem.c           | 20 ++------------------
>  include/linux/memory-tiers.h | 13 +++++++++++++
>  mm/memory-tiers.c            | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 18 deletions(-)
> 
[...]
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 69e781900082..a44c03c2ba3a 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
>  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  			     const char *source);
>  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> +							struct list_head *memory_types);
> +void mt_put_memory_types(struct list_head *memory_types);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
>  {
>  	return -EIO;
>  }
> +
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
> +{
> +	return NULL;
> +}
> +
> +void mt_put_memory_types(struct list_head *memory_types)
> +{
> +
> +}

I found latest mm-unstable tree is failing kunit as below, and 'git bisect'
says it happens from this patch.

    $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
    [11:56:40] Configuring KUnit Kernel ...
    [11:56:40] Building KUnit Kernel ...
    Populating config with:
    $ make ARCH=um O=../kunit.out/ olddefconfig
    Building with:
    $ make ARCH=um O=../kunit.out/ --jobs=36
    ERROR:root:In file included from .../mm/memory.c:71:
    .../include/linux/memory-tiers.h:143:25: warning: no previous prototype for ‘mt_find_alloc_memory_type’ [-Wmissing-prototypes]
      143 | struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
    .../include/linux/memory-tiers.h:148:6: warning: no previous prototype for ‘mt_put_memory_types’ [-Wmissing-prototypes]
      148 | void mt_put_memory_types(struct list_head *memory_types)
          |      ^~~~~~~~~~~~~~~~~~~
    [...]

Maybe we should set these as 'static inline', like below?  I confirmed this
fixes the kunit error.  May I ask your opinion?

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index a44c03c2ba3a..ee6e53144156 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -140,12 +140,12 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
        return -EIO;
 }

-struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
+static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
 {
        return NULL;
 }

-void mt_put_memory_types(struct list_head *memory_types)
+static inline void mt_put_memory_types(struct list_head *memory_types)
 {

 }


Thanks,
SJ

