Return-Path: <linux-kernel+bounces-69806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE63858ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9288A282587
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5700A4EB46;
	Sat, 17 Feb 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fl809rY3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D11487AB;
	Sat, 17 Feb 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708166679; cv=none; b=tZScvtX/ZU5jgrwySYj994XWYMo0CezVsyFAGXJI3Tqd7kuYx9Y7j50mFmGECxIUTspC/IvN0FZhz9IGAg93IVdTiqJAtEQ0nA/v+wZ4L+sGIFoTVQfWYkH1ptKKeuO9aULaoB10z7A7Phx9tTFJWNubiDHaDOT2dlHpe/sgVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708166679; c=relaxed/simple;
	bh=UW55rgsealtfBDuAKlBBXNYCymhoMGrmgrz1zNjUoQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5XG3JCPu5PaVjMyDS1OZlJ1/esLVhPjNeF6iJ0zAbdeOqL9uh4GT0xvnCHeDLqxB9xdUrJSexhQYD8gdKo/TOiGMxqCZ821Krco8CpsX0OSDY37xfLTUjidzgyCXBMM5PqfAk4FpgcaSw8COFe8j7pZBqcTVvQxtAjtXAUght0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fl809rY3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708166678; x=1739702678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UW55rgsealtfBDuAKlBBXNYCymhoMGrmgrz1zNjUoQ8=;
  b=Fl809rY3pFMFAA3JSTxd8ha8UzTAEyUlLO11bbU3DOKyECA8HQuPMgM6
   CgCAodTiZ5Hgq8nzErbLkZPt6jE2cLKvO6gz5b9wNhdbiyMJHe5C/l8Gl
   ZYhJGGs1wYd+KcSUww85psIWbC/qTGdLnDubUXoJ3mZZog3N5HYdC6kyZ
   5l73nRxIa4D9RQ+FvL6JcF83ZFyPKfyvlemam5dymZ0bqhRxfB//NU/PD
   vEPfIkvMeWjAytq3mKn8JhacNr6JX4rSVg7MXmxvejTBPRk+DexkrDIpR
   JFIMeTPcnKNSN8stABD37OO+DR1N2BORPOCflG6EIGShTD52GNGNL5zny
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2200104"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="2200104"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 02:44:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="8676121"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 17 Feb 2024 02:44:33 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbIBE-00023A-05;
	Sat, 17 Feb 2024 10:44:26 +0000
Date: Sat, 17 Feb 2024 18:43:37 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 3/3] lib/firmware_table: Provide buffer length
 argument to cdat_table_parse()
Message-ID: <202402171817.i0WShbft-lkp@intel.com>
References: <20240216155844.406996-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216155844.406996-4-rrichter@amd.com>

Hi Robert,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6be99530c92c6b8ff7a01903edc42393575ad63b]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Richter/cxl-pci-Rename-DOE-mailbox-handle-to-doe_mb/20240217-000206
base:   6be99530c92c6b8ff7a01903edc42393575ad63b
patch link:    https://lore.kernel.org/r/20240216155844.406996-4-rrichter%40amd.com
patch subject: [PATCH v4 3/3] lib/firmware_table: Provide buffer length argument to cdat_table_parse()
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20240217/202402171817.i0WShbft-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240217/202402171817.i0WShbft-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402171817.i0WShbft-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from drivers/cxl/core/pci.c:5:
   drivers/cxl/core/pci.c: In function 'read_cdat_data':
>> drivers/cxl/core/pci.c:672:31: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     672 |                 dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:146:61: note: in expansion of macro 'dev_fmt'
     146 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/cxl/core/pci.c:672:17: note: in expansion of macro 'dev_warn'
     672 |                 dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
         |                 ^~~~~~~~
   drivers/cxl/core/pci.c:672:63: note: format string is defined here
     672 |                 dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
         |                                                             ~~^
         |                                                               |
         |                                                               long unsigned int
         |                                                             %u
   drivers/cxl/core/pci.c:672:31: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     672 |                 dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:146:61: note: in expansion of macro 'dev_fmt'
     146 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/cxl/core/pci.c:672:17: note: in expansion of macro 'dev_warn'
     672 |                 dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
         |                 ^~~~~~~~
   drivers/cxl/core/pci.c:672:67: note: format string is defined here
     672 |                 dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
         |                                                                 ~~^
         |                                                                   |
         |                                                                   long unsigned int
         |                                                                 %u
   during RTL pass: mach
   drivers/cxl/core/pci.c: In function 'match_add_dports':
   drivers/cxl/core/pci.c:68:1: internal compiler error: in arc_ifcvt, at config/arc/arc.cc:9703
      68 | }
         | ^
   0x5b78c1 arc_ifcvt
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/config/arc/arc.cc:9703
   0xe431b4 arc_reorg
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/config/arc/arc.cc:8552
   0xaed299 execute
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/reorg.cc:3927
   Please submit a full bug report, with preprocessed source (by using -freport-bug).
   Please include the complete backtrace with any bug report.
   See <https://gcc.gnu.org/bugs/> for instructions.


vim +672 drivers/cxl/core/pci.c

   611	
   612	/**
   613	 * read_cdat_data - Read the CDAT data on this port
   614	 * @port: Port to read data from
   615	 *
   616	 * This call will sleep waiting for responses from the DOE mailbox.
   617	 */
   618	void read_cdat_data(struct cxl_port *port)
   619	{
   620		struct device *uport = port->uport_dev;
   621		struct device *dev = &port->dev;
   622		struct pci_doe_mb *doe_mb;
   623		struct pci_dev *pdev = NULL;
   624		struct cxl_memdev *cxlmd;
   625		struct cdat_doe_rsp *buf;
   626		size_t table_length, length;
   627		int rc;
   628	
   629		if (is_cxl_memdev(uport)) {
   630			struct device *host;
   631	
   632			cxlmd = to_cxl_memdev(uport);
   633			host = cxlmd->dev.parent;
   634			if (dev_is_pci(host))
   635				pdev = to_pci_dev(host);
   636		} else if (dev_is_pci(uport)) {
   637			pdev = to_pci_dev(uport);
   638		}
   639	
   640		if (!pdev)
   641			return;
   642	
   643		doe_mb = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
   644					      CXL_DOE_PROTOCOL_TABLE_ACCESS);
   645		if (!doe_mb) {
   646			dev_dbg(dev, "No CDAT mailbox\n");
   647			return;
   648		}
   649	
   650		port->cdat_available = true;
   651	
   652		if (cxl_cdat_get_length(dev, doe_mb, &length)) {
   653			dev_dbg(dev, "No CDAT length\n");
   654			return;
   655		}
   656	
   657		/*
   658		 * The begin of the CDAT buffer needs space for additional 4
   659		 * bytes for the DOE header. Table data starts afterwards.
   660		 */
   661		buf = devm_kzalloc(dev, sizeof(*buf) + length, GFP_KERNEL);
   662		if (!buf)
   663			goto err;
   664	
   665		table_length = length;
   666	
   667		rc = cxl_cdat_read_table(dev, doe_mb, buf, &length);
   668		if (rc)
   669			goto err;
   670	
   671		if (table_length != length)
 > 672			dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
   673				table_length, length);
   674	
   675		if (cdat_checksum(buf->data, length))
   676			goto err;
   677	
   678		port->cdat.table = buf->data;
   679		port->cdat.length = length;
   680	
   681		return;
   682	err:
   683		/* Don't leave table data allocated on error */
   684		devm_kfree(dev, buf);
   685		dev_err(dev, "Failed to read/validate CDAT.\n");
   686	}
   687	EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
   688	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

