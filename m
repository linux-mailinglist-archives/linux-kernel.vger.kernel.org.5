Return-Path: <linux-kernel+bounces-101693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2F487AA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B054F1C209EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38713481B3;
	Wed, 13 Mar 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzonOFgY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5C47773;
	Wed, 13 Mar 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344700; cv=none; b=liFZjXhRfVGnhalG+k14bdMBQAhreWKLgtY9Fq+/47ynfYD2km1URQ+Gcu/59XzeLTwhWMWPxdihUn7Kbh5mBQItZ3/puPOmor+FZclZEjtdJR+Gn7R45caW1WR/vNHjeH7d5m73B4YzzEh3B0mcHTCAEALJJq+5BZh4w+6TrAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344700; c=relaxed/simple;
	bh=4LS8aRKIv6OoIEijA+nidlByxj4qjolaeOnhyJK/vSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBuFQlelTQ8lksk/b5oEZNGXyUA4yn7DBuh+EI4OMn7tkxnDC5XE2tEmlkp01QbGImwizo3HipcGP3eRkEL5sCGjsGjXwppHhNcL8Kjb106Z69nmlPxrW51j4WP2IMYFzrZfIIB4rk6sSJdXkNOoSv+YsqtDpZbakSJcuJqNIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzonOFgY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710344698; x=1741880698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4LS8aRKIv6OoIEijA+nidlByxj4qjolaeOnhyJK/vSk=;
  b=JzonOFgYqZ2N+R+u8WO1Mvr0wwITkJUlUZDq5dwqry4n/wISQfO5qHKo
   iciWLhQ/9wtutKQmHAshti4yXhz5iHe8I99oTkuT/KvtiHPvsAhsy2Yf9
   LHhkZvv/JwmYe/5sgVYQxgzz9n0kjDoSHAsIDxrEPCbUXuTKgnPq3Sqxc
   j+FM35Kx8Cg1SJdlSd/LYMCf1hwegFIpj4FoslMQVGdwfHUUYfPOau3K0
   +lj4o8Ctq7apLD9DMEnz8+t0M/u2KGdMkBXS3dZIlATFQDsNi4bWcsAjM
   dOyOAVjTnH6du1U6xj6EGr3OmS3As8v0BvF6RuMgvw9AS5sUIxUdjIeJK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16515873"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16515873"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 08:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="42969991"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Mar 2024 08:44:53 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkQmg-000CU7-1f;
	Wed, 13 Mar 2024 15:44:50 +0000
Date: Wed, 13 Mar 2024 23:44:06 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	x86@kernel.org, linux-perf-users@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: Re: [PATCH 04/10] perf: Rename PERF_PMU_CAP_NO_INTERRUPT
Message-ID: <202403132349.Ph0CYSV2-lkp@intel.com>
References: <0999a39f0a068979dbcc6119380f63d706101b4f.1710257512.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0999a39f0a068979dbcc6119380f63d706101b4f.1710257512.git.robin.murphy@arm.com>

Hi Robin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on perf-tools-next/perf-tools-next]
[also build test WARNING on perf-tools/perf-tools linus/master v6.8 next-20240313]
[cannot apply to acme/perf/core tip/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/perf-alibaba_uncore_drw-Use-correct-CPU-affinity/20240313-013915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/0999a39f0a068979dbcc6119380f63d706101b4f.1710257512.git.robin.murphy%40arm.com
patch subject: [PATCH 04/10] perf: Rename PERF_PMU_CAP_NO_INTERRUPT
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240313/202403132349.Ph0CYSV2-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240313/202403132349.Ph0CYSV2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403132349.Ph0CYSV2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/powerpc/perf/hv-24x7.c: In function 'hv_24x7_init':
   arch/powerpc/perf/hv-24x7.c:1742:9: error: expected ';' before 'r'
    1742 |         r = create_events_from_catalog(&event_group.attrs,
         |         ^
   arch/powerpc/perf/hv-24x7.c: At top level:
>> arch/powerpc/perf/hv-24x7.c:764:12: warning: 'create_events_from_catalog' defined but not used [-Wunused-function]
     764 | static int create_events_from_catalog(struct attribute ***events_,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/create_events_from_catalog +764 arch/powerpc/perf/hv-24x7.c

5c5cd7b502595f Cody P Schafer        2015-01-30   763  
7debc970ae7a55 Li Zhong              2015-04-13  @764  static int create_events_from_catalog(struct attribute ***events_,
5c5cd7b502595f Cody P Schafer        2015-01-30   765  				      struct attribute ***event_descs_,
5c5cd7b502595f Cody P Schafer        2015-01-30   766  				      struct attribute ***event_long_descs_)
5c5cd7b502595f Cody P Schafer        2015-01-30   767  {
38d81846106bb1 Thiago Jung Bauermann 2017-06-29   768  	long hret;
5c5cd7b502595f Cody P Schafer        2015-01-30   769  	size_t catalog_len, catalog_page_len, event_entry_count,
5c5cd7b502595f Cody P Schafer        2015-01-30   770  	       event_data_len, event_data_offs,
5c5cd7b502595f Cody P Schafer        2015-01-30   771  	       event_data_bytes, junk_events, event_idx, event_attr_ct, i,
5c5cd7b502595f Cody P Schafer        2015-01-30   772  	       attr_max, event_idx_last, desc_ct, long_desc_ct;
5c5cd7b502595f Cody P Schafer        2015-01-30   773  	ssize_t ct, ev_len;
12bf85a71000af Thiago Jung Bauermann 2017-06-29   774  	uint64_t catalog_version_num;
5c5cd7b502595f Cody P Schafer        2015-01-30   775  	struct attribute **events, **event_descs, **event_long_descs;
5c5cd7b502595f Cody P Schafer        2015-01-30   776  	struct hv_24x7_catalog_page_0 *page_0 =
5c5cd7b502595f Cody P Schafer        2015-01-30   777  		kmem_cache_alloc(hv_page_cache, GFP_KERNEL);
5c5cd7b502595f Cody P Schafer        2015-01-30   778  	void *page = page_0;
5c5cd7b502595f Cody P Schafer        2015-01-30   779  	void *event_data, *end;
5c5cd7b502595f Cody P Schafer        2015-01-30   780  	struct hv_24x7_event_data *event;
5c5cd7b502595f Cody P Schafer        2015-01-30   781  	struct rb_root ev_uniq = RB_ROOT;
7debc970ae7a55 Li Zhong              2015-04-13   782  	int ret = 0;
5c5cd7b502595f Cody P Schafer        2015-01-30   783  
7debc970ae7a55 Li Zhong              2015-04-13   784  	if (!page) {
7debc970ae7a55 Li Zhong              2015-04-13   785  		ret = -ENOMEM;
5c5cd7b502595f Cody P Schafer        2015-01-30   786  		goto e_out;
7debc970ae7a55 Li Zhong              2015-04-13   787  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   788  
5c5cd7b502595f Cody P Schafer        2015-01-30   789  	hret = h_get_24x7_catalog_page(page, 0, 0);
7debc970ae7a55 Li Zhong              2015-04-13   790  	if (hret) {
7debc970ae7a55 Li Zhong              2015-04-13   791  		ret = -EIO;
5c5cd7b502595f Cody P Schafer        2015-01-30   792  		goto e_free;
7debc970ae7a55 Li Zhong              2015-04-13   793  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   794  
5c5cd7b502595f Cody P Schafer        2015-01-30   795  	catalog_version_num = be64_to_cpu(page_0->version);
5c5cd7b502595f Cody P Schafer        2015-01-30   796  	catalog_page_len = be32_to_cpu(page_0->length);
5c5cd7b502595f Cody P Schafer        2015-01-30   797  
5c5cd7b502595f Cody P Schafer        2015-01-30   798  	if (MAX_4K < catalog_page_len) {
5c5cd7b502595f Cody P Schafer        2015-01-30   799  		pr_err("invalid page count: %zu\n", catalog_page_len);
7debc970ae7a55 Li Zhong              2015-04-13   800  		ret = -EIO;
5c5cd7b502595f Cody P Schafer        2015-01-30   801  		goto e_free;
5c5cd7b502595f Cody P Schafer        2015-01-30   802  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   803  
5c5cd7b502595f Cody P Schafer        2015-01-30   804  	catalog_len = catalog_page_len * 4096;
5c5cd7b502595f Cody P Schafer        2015-01-30   805  
5c5cd7b502595f Cody P Schafer        2015-01-30   806  	event_entry_count = be16_to_cpu(page_0->event_entry_count);
5c5cd7b502595f Cody P Schafer        2015-01-30   807  	event_data_offs   = be16_to_cpu(page_0->event_data_offs);
5c5cd7b502595f Cody P Schafer        2015-01-30   808  	event_data_len    = be16_to_cpu(page_0->event_data_len);
5c5cd7b502595f Cody P Schafer        2015-01-30   809  
12bf85a71000af Thiago Jung Bauermann 2017-06-29   810  	pr_devel("cv %llu cl %zu eec %zu edo %zu edl %zu\n",
12bf85a71000af Thiago Jung Bauermann 2017-06-29   811  			catalog_version_num, catalog_len,
5c5cd7b502595f Cody P Schafer        2015-01-30   812  			event_entry_count, event_data_offs, event_data_len);
5c5cd7b502595f Cody P Schafer        2015-01-30   813  
5c5cd7b502595f Cody P Schafer        2015-01-30   814  	if ((MAX_4K < event_data_len)
5c5cd7b502595f Cody P Schafer        2015-01-30   815  			|| (MAX_4K < event_data_offs)
5c5cd7b502595f Cody P Schafer        2015-01-30   816  			|| (MAX_4K - event_data_offs < event_data_len)) {
5c5cd7b502595f Cody P Schafer        2015-01-30   817  		pr_err("invalid event data offs %zu and/or len %zu\n",
5c5cd7b502595f Cody P Schafer        2015-01-30   818  				event_data_offs, event_data_len);
7debc970ae7a55 Li Zhong              2015-04-13   819  		ret = -EIO;
5c5cd7b502595f Cody P Schafer        2015-01-30   820  		goto e_free;
5c5cd7b502595f Cody P Schafer        2015-01-30   821  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   822  
5c5cd7b502595f Cody P Schafer        2015-01-30   823  	if ((event_data_offs + event_data_len) > catalog_page_len) {
5c5cd7b502595f Cody P Schafer        2015-01-30   824  		pr_err("event data %zu-%zu does not fit inside catalog 0-%zu\n",
5c5cd7b502595f Cody P Schafer        2015-01-30   825  				event_data_offs,
5c5cd7b502595f Cody P Schafer        2015-01-30   826  				event_data_offs + event_data_len,
5c5cd7b502595f Cody P Schafer        2015-01-30   827  				catalog_page_len);
7debc970ae7a55 Li Zhong              2015-04-13   828  		ret = -EIO;
5c5cd7b502595f Cody P Schafer        2015-01-30   829  		goto e_free;
5c5cd7b502595f Cody P Schafer        2015-01-30   830  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   831  
8f69dc701aac17 Sukadev Bhattiprolu   2016-02-16   832  	if (SIZE_MAX - 1 < event_entry_count) {
8f69dc701aac17 Sukadev Bhattiprolu   2016-02-16   833  		pr_err("event_entry_count %zu is invalid\n", event_entry_count);
7debc970ae7a55 Li Zhong              2015-04-13   834  		ret = -EIO;
5c5cd7b502595f Cody P Schafer        2015-01-30   835  		goto e_free;
5c5cd7b502595f Cody P Schafer        2015-01-30   836  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   837  
5c5cd7b502595f Cody P Schafer        2015-01-30   838  	event_data_bytes = event_data_len * 4096;
5c5cd7b502595f Cody P Schafer        2015-01-30   839  
5c5cd7b502595f Cody P Schafer        2015-01-30   840  	/*
5c5cd7b502595f Cody P Schafer        2015-01-30   841  	 * event data can span several pages, events can cross between these
5c5cd7b502595f Cody P Schafer        2015-01-30   842  	 * pages. Use vmalloc to make this easier.
5c5cd7b502595f Cody P Schafer        2015-01-30   843  	 */
5c5cd7b502595f Cody P Schafer        2015-01-30   844  	event_data = vmalloc(event_data_bytes);
5c5cd7b502595f Cody P Schafer        2015-01-30   845  	if (!event_data) {
5c5cd7b502595f Cody P Schafer        2015-01-30   846  		pr_err("could not allocate event data\n");
7debc970ae7a55 Li Zhong              2015-04-13   847  		ret = -ENOMEM;
5c5cd7b502595f Cody P Schafer        2015-01-30   848  		goto e_free;
5c5cd7b502595f Cody P Schafer        2015-01-30   849  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   850  
5c5cd7b502595f Cody P Schafer        2015-01-30   851  	end = event_data + event_data_bytes;
5c5cd7b502595f Cody P Schafer        2015-01-30   852  
5c5cd7b502595f Cody P Schafer        2015-01-30   853  	/*
5c5cd7b502595f Cody P Schafer        2015-01-30   854  	 * using vmalloc_to_phys() like this only works if PAGE_SIZE is
5c5cd7b502595f Cody P Schafer        2015-01-30   855  	 * divisible by 4096
5c5cd7b502595f Cody P Schafer        2015-01-30   856  	 */
5c5cd7b502595f Cody P Schafer        2015-01-30   857  	BUILD_BUG_ON(PAGE_SIZE % 4096);
5c5cd7b502595f Cody P Schafer        2015-01-30   858  
5c5cd7b502595f Cody P Schafer        2015-01-30   859  	for (i = 0; i < event_data_len; i++) {
5c5cd7b502595f Cody P Schafer        2015-01-30   860  		hret = h_get_24x7_catalog_page_(
5c5cd7b502595f Cody P Schafer        2015-01-30   861  				vmalloc_to_phys(event_data + i * 4096),
5c5cd7b502595f Cody P Schafer        2015-01-30   862  				catalog_version_num,
5c5cd7b502595f Cody P Schafer        2015-01-30   863  				i + event_data_offs);
5c5cd7b502595f Cody P Schafer        2015-01-30   864  		if (hret) {
12bf85a71000af Thiago Jung Bauermann 2017-06-29   865  			pr_err("Failed to get event data in page %zu: rc=%ld\n",
12bf85a71000af Thiago Jung Bauermann 2017-06-29   866  			       i + event_data_offs, hret);
7debc970ae7a55 Li Zhong              2015-04-13   867  			ret = -EIO;
5c5cd7b502595f Cody P Schafer        2015-01-30   868  			goto e_event_data;
5c5cd7b502595f Cody P Schafer        2015-01-30   869  		}
5c5cd7b502595f Cody P Schafer        2015-01-30   870  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   871  
5c5cd7b502595f Cody P Schafer        2015-01-30   872  	/*
5c5cd7b502595f Cody P Schafer        2015-01-30   873  	 * scan the catalog to determine the number of attributes we need, and
5c5cd7b502595f Cody P Schafer        2015-01-30   874  	 * verify it at the same time.
5c5cd7b502595f Cody P Schafer        2015-01-30   875  	 */
5c5cd7b502595f Cody P Schafer        2015-01-30   876  	for (junk_events = 0, event = event_data, event_idx = 0, attr_max = 0;
5c5cd7b502595f Cody P Schafer        2015-01-30   877  	     ;
5c5cd7b502595f Cody P Schafer        2015-01-30   878  	     event_idx++, event = (void *)event + ev_len) {
5c5cd7b502595f Cody P Schafer        2015-01-30   879  		size_t offset = (void *)event - (void *)event_data;
5c5cd7b502595f Cody P Schafer        2015-01-30   880  		char *name;
5c5cd7b502595f Cody P Schafer        2015-01-30   881  		int nl;
5c5cd7b502595f Cody P Schafer        2015-01-30   882  
5c5cd7b502595f Cody P Schafer        2015-01-30   883  		ev_len = catalog_event_len_validate(event, event_idx,
5c5cd7b502595f Cody P Schafer        2015-01-30   884  						    event_data_bytes,
5c5cd7b502595f Cody P Schafer        2015-01-30   885  						    event_entry_count,
5c5cd7b502595f Cody P Schafer        2015-01-30   886  						    offset, end);
5c5cd7b502595f Cody P Schafer        2015-01-30   887  		if (ev_len < 0)
5c5cd7b502595f Cody P Schafer        2015-01-30   888  			break;
5c5cd7b502595f Cody P Schafer        2015-01-30   889  
5c5cd7b502595f Cody P Schafer        2015-01-30   890  		name = event_name(event, &nl);
5c5cd7b502595f Cody P Schafer        2015-01-30   891  
e5f9d8858612c1 Kajol Jain            2020-12-28   892  		if (ignore_event(name)) {
e5f9d8858612c1 Kajol Jain            2020-12-28   893  			junk_events++;
e5f9d8858612c1 Kajol Jain            2020-12-28   894  			continue;
e5f9d8858612c1 Kajol Jain            2020-12-28   895  		}
5c5cd7b502595f Cody P Schafer        2015-01-30   896  		if (event->event_group_record_len == 0) {
5c5cd7b502595f Cody P Schafer        2015-01-30   897  			pr_devel("invalid event %zu (%.*s): group_record_len == 0, skipping\n",
5c5cd7b502595f Cody P Schafer        2015-01-30   898  					event_idx, nl, name);
5c5cd7b502595f Cody P Schafer        2015-01-30   899  			junk_events++;
5c5cd7b502595f Cody P Schafer        2015-01-30   900  			continue;
5c5cd7b502595f Cody P Schafer        2015-01-30   901  		}
5c5cd7b502595f Cody P Schafer        2015-01-30   902  
5c5cd7b502595f Cody P Schafer        2015-01-30   903  		if (!catalog_entry_domain_is_valid(event->domain)) {
5c5cd7b502595f Cody P Schafer        2015-01-30   904  			pr_info("event %zu (%.*s) has invalid domain %d\n",
5c5cd7b502595f Cody P Schafer        2015-01-30   905  					event_idx, nl, name, event->domain);
5c5cd7b502595f Cody P Schafer        2015-01-30   906  			junk_events++;
5c5cd7b502595f Cody P Schafer        2015-01-30   907  			continue;
5c5cd7b502595f Cody P Schafer        2015-01-30   908  		}
5c5cd7b502595f Cody P Schafer        2015-01-30   909  
8f69dc701aac17 Sukadev Bhattiprolu   2016-02-16   910  		attr_max++;
5c5cd7b502595f Cody P Schafer        2015-01-30   911  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   912  
5c5cd7b502595f Cody P Schafer        2015-01-30   913  	event_idx_last = event_idx;
5c5cd7b502595f Cody P Schafer        2015-01-30   914  	if (event_idx_last != event_entry_count)
5c5cd7b502595f Cody P Schafer        2015-01-30   915  		pr_warn("event buffer ended before listed # of events were parsed (got %zu, wanted %zu, junk %zu)\n",
5c5cd7b502595f Cody P Schafer        2015-01-30   916  				event_idx_last, event_entry_count, junk_events);
5c5cd7b502595f Cody P Schafer        2015-01-30   917  
5c5cd7b502595f Cody P Schafer        2015-01-30   918  	events = kmalloc_array(attr_max + 1, sizeof(*events), GFP_KERNEL);
7debc970ae7a55 Li Zhong              2015-04-13   919  	if (!events) {
7debc970ae7a55 Li Zhong              2015-04-13   920  		ret = -ENOMEM;
5c5cd7b502595f Cody P Schafer        2015-01-30   921  		goto e_event_data;
7debc970ae7a55 Li Zhong              2015-04-13   922  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   923  
5c5cd7b502595f Cody P Schafer        2015-01-30   924  	event_descs = kmalloc_array(event_idx + 1, sizeof(*event_descs),
5c5cd7b502595f Cody P Schafer        2015-01-30   925  				GFP_KERNEL);
7debc970ae7a55 Li Zhong              2015-04-13   926  	if (!event_descs) {
7debc970ae7a55 Li Zhong              2015-04-13   927  		ret = -ENOMEM;
5c5cd7b502595f Cody P Schafer        2015-01-30   928  		goto e_event_attrs;
7debc970ae7a55 Li Zhong              2015-04-13   929  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   930  
5c5cd7b502595f Cody P Schafer        2015-01-30   931  	event_long_descs = kmalloc_array(event_idx + 1,
5c5cd7b502595f Cody P Schafer        2015-01-30   932  			sizeof(*event_long_descs), GFP_KERNEL);
7debc970ae7a55 Li Zhong              2015-04-13   933  	if (!event_long_descs) {
7debc970ae7a55 Li Zhong              2015-04-13   934  		ret = -ENOMEM;
5c5cd7b502595f Cody P Schafer        2015-01-30   935  		goto e_event_descs;
7debc970ae7a55 Li Zhong              2015-04-13   936  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   937  
5c5cd7b502595f Cody P Schafer        2015-01-30   938  	/* Iterate over the catalog filling in the attribute vector */
5c5cd7b502595f Cody P Schafer        2015-01-30   939  	for (junk_events = 0, event_attr_ct = 0, desc_ct = 0, long_desc_ct = 0,
5c5cd7b502595f Cody P Schafer        2015-01-30   940  				event = event_data, event_idx = 0;
5c5cd7b502595f Cody P Schafer        2015-01-30   941  			event_idx < event_idx_last;
5c5cd7b502595f Cody P Schafer        2015-01-30   942  			event_idx++, ev_len = be16_to_cpu(event->length),
5c5cd7b502595f Cody P Schafer        2015-01-30   943  				event = (void *)event + ev_len) {
5c5cd7b502595f Cody P Schafer        2015-01-30   944  		char *name;
5c5cd7b502595f Cody P Schafer        2015-01-30   945  		int nl;
5c5cd7b502595f Cody P Schafer        2015-01-30   946  		int nonce;
5c5cd7b502595f Cody P Schafer        2015-01-30   947  		/*
5c5cd7b502595f Cody P Schafer        2015-01-30   948  		 * these are the only "bad" events that are intermixed and that
5c5cd7b502595f Cody P Schafer        2015-01-30   949  		 * we can ignore without issue. make sure to skip them here
5c5cd7b502595f Cody P Schafer        2015-01-30   950  		 */
5c5cd7b502595f Cody P Schafer        2015-01-30   951  		if (event->event_group_record_len == 0)
5c5cd7b502595f Cody P Schafer        2015-01-30   952  			continue;
5c5cd7b502595f Cody P Schafer        2015-01-30   953  		if (!catalog_entry_domain_is_valid(event->domain))
5c5cd7b502595f Cody P Schafer        2015-01-30   954  			continue;
5c5cd7b502595f Cody P Schafer        2015-01-30   955  
5c5cd7b502595f Cody P Schafer        2015-01-30   956  		name  = event_name(event, &nl);
e5f9d8858612c1 Kajol Jain            2020-12-28   957  		if (ignore_event(name))
e5f9d8858612c1 Kajol Jain            2020-12-28   958  			continue;
e5f9d8858612c1 Kajol Jain            2020-12-28   959  
5c5cd7b502595f Cody P Schafer        2015-01-30   960  		nonce = event_uniq_add(&ev_uniq, name, nl, event->domain);
5c5cd7b502595f Cody P Schafer        2015-01-30   961  		ct    = event_data_to_attrs(event_idx, events + event_attr_ct,
5c5cd7b502595f Cody P Schafer        2015-01-30   962  					    event, nonce);
8f69dc701aac17 Sukadev Bhattiprolu   2016-02-16   963  		if (ct < 0) {
5c5cd7b502595f Cody P Schafer        2015-01-30   964  			pr_warn("event %zu (%.*s) creation failure, skipping\n",
5c5cd7b502595f Cody P Schafer        2015-01-30   965  				event_idx, nl, name);
5c5cd7b502595f Cody P Schafer        2015-01-30   966  			junk_events++;
5c5cd7b502595f Cody P Schafer        2015-01-30   967  		} else {
8f69dc701aac17 Sukadev Bhattiprolu   2016-02-16   968  			event_attr_ct++;
5c5cd7b502595f Cody P Schafer        2015-01-30   969  			event_descs[desc_ct] = event_to_desc_attr(event, nonce);
5c5cd7b502595f Cody P Schafer        2015-01-30   970  			if (event_descs[desc_ct])
5c5cd7b502595f Cody P Schafer        2015-01-30   971  				desc_ct++;
5c5cd7b502595f Cody P Schafer        2015-01-30   972  			event_long_descs[long_desc_ct] =
5c5cd7b502595f Cody P Schafer        2015-01-30   973  					event_to_long_desc_attr(event, nonce);
5c5cd7b502595f Cody P Schafer        2015-01-30   974  			if (event_long_descs[long_desc_ct])
5c5cd7b502595f Cody P Schafer        2015-01-30   975  				long_desc_ct++;
5c5cd7b502595f Cody P Schafer        2015-01-30   976  		}
5c5cd7b502595f Cody P Schafer        2015-01-30   977  	}
5c5cd7b502595f Cody P Schafer        2015-01-30   978  
5c5cd7b502595f Cody P Schafer        2015-01-30   979  	pr_info("read %zu catalog entries, created %zu event attrs (%zu failures), %zu descs\n",
5c5cd7b502595f Cody P Schafer        2015-01-30   980  			event_idx, event_attr_ct, junk_events, desc_ct);
5c5cd7b502595f Cody P Schafer        2015-01-30   981  
5c5cd7b502595f Cody P Schafer        2015-01-30   982  	events[event_attr_ct] = NULL;
5c5cd7b502595f Cody P Schafer        2015-01-30   983  	event_descs[desc_ct] = NULL;
5c5cd7b502595f Cody P Schafer        2015-01-30   984  	event_long_descs[long_desc_ct] = NULL;
5c5cd7b502595f Cody P Schafer        2015-01-30   985  
5c5cd7b502595f Cody P Schafer        2015-01-30   986  	event_uniq_destroy(&ev_uniq);
5c5cd7b502595f Cody P Schafer        2015-01-30   987  	vfree(event_data);
5c5cd7b502595f Cody P Schafer        2015-01-30   988  	kmem_cache_free(hv_page_cache, page);
5c5cd7b502595f Cody P Schafer        2015-01-30   989  
5c5cd7b502595f Cody P Schafer        2015-01-30   990  	*events_ = events;
5c5cd7b502595f Cody P Schafer        2015-01-30   991  	*event_descs_ = event_descs;
5c5cd7b502595f Cody P Schafer        2015-01-30   992  	*event_long_descs_ = event_long_descs;
7debc970ae7a55 Li Zhong              2015-04-13   993  	return 0;
5c5cd7b502595f Cody P Schafer        2015-01-30   994  
5c5cd7b502595f Cody P Schafer        2015-01-30   995  e_event_descs:
5c5cd7b502595f Cody P Schafer        2015-01-30   996  	kfree(event_descs);
5c5cd7b502595f Cody P Schafer        2015-01-30   997  e_event_attrs:
5c5cd7b502595f Cody P Schafer        2015-01-30   998  	kfree(events);
5c5cd7b502595f Cody P Schafer        2015-01-30   999  e_event_data:
5c5cd7b502595f Cody P Schafer        2015-01-30  1000  	vfree(event_data);
5c5cd7b502595f Cody P Schafer        2015-01-30  1001  e_free:
5c5cd7b502595f Cody P Schafer        2015-01-30  1002  	kmem_cache_free(hv_page_cache, page);
5c5cd7b502595f Cody P Schafer        2015-01-30  1003  e_out:
5c5cd7b502595f Cody P Schafer        2015-01-30  1004  	*events_ = NULL;
5c5cd7b502595f Cody P Schafer        2015-01-30  1005  	*event_descs_ = NULL;
5c5cd7b502595f Cody P Schafer        2015-01-30  1006  	*event_long_descs_ = NULL;
7debc970ae7a55 Li Zhong              2015-04-13  1007  	return ret;
5c5cd7b502595f Cody P Schafer        2015-01-30  1008  }
5c5cd7b502595f Cody P Schafer        2015-01-30  1009  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

