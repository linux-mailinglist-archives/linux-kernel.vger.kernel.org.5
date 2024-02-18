Return-Path: <linux-kernel+bounces-70395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6125859708
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D956A1C20C86
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B06BFA1;
	Sun, 18 Feb 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNs1Dh4A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123037140;
	Sun, 18 Feb 2024 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708261345; cv=none; b=WB3MBJQ3pPZM/69LUOTEaWosamQSCwIZoXJkz+osdxodlZBWn/V86rynSVso5i+h7lkfbFILTqquRbs3M1bsGA/xq/e0shOnfYC/SPR1apHkxdyfXdAyec+iud2cg9JjSttAabdJlrBh/7ahi2xuvhFARKqiCQ7OfjNOhlXI3uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708261345; c=relaxed/simple;
	bh=dVY8BMPtchDOweysfrajkGdjXqnmHGF53GbnihHyl/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/8PLPdIgs+kgqgotVNbhxXsgVepbGCtqxMQBiihs9hMT1k+0iwUcusFruhvEgb+8kC160J6ZMLRMfFyBUjZP7m5Gi2OCz4KELetoAOPTzX2ikenWBVVPuOhkoOrhiIH1jnOMDRJwCa46s3pMCLCLRDxpW2zztMDOkcvbb+wwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNs1Dh4A; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708261343; x=1739797343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dVY8BMPtchDOweysfrajkGdjXqnmHGF53GbnihHyl/8=;
  b=ZNs1Dh4AugRT7qpSPRFVWo8Ui0tYrXEoE+GqKufJAqnCVQrjgn4KbeCC
   NvTy18+zQbt1LmOFyjBl6y4SaBU5l5LEJN0yGZ7hfZli0mjYXLq4414Wf
   kAotmcCheCUhiB0ABd0WdCSqGPVZ8TVhfe4wd3Wmo7wbXHwFjqLO7UsJ+
   AObQkjp1XPzi0E3kyDJ3bLx8qhyjwgbQqhgCdfdqnnId8JCe/n37/lC/m
   c2QoXQgtmaaI3S2xC9wp6TDmT5NnVYFYTNMfYwtgDnlQlwyQs23IlRIQq
   3MmCGbstzcdeZHnhKoJlvX6R0tJ+gyBEW6nImC+MR4CfdIuIruRCKeGlb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2207210"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2207210"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 05:02:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="8850629"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 18 Feb 2024 05:02:18 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbgnS-00031w-2W;
	Sun, 18 Feb 2024 13:01:49 +0000
Date: Sun, 18 Feb 2024 20:58:37 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 3/3] lib/firmware_table: Provide buffer length
 argument to cdat_table_parse()
Message-ID: <202402182055.zfTIyfls-lkp@intel.com>
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
config: i386-randconfig-006-20240217 (https://download.01.org/0day-ci/archive/20240218/202402182055.zfTIyfls-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240218/202402182055.zfTIyfls-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402182055.zfTIyfls-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/pci.c:673:4: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
     672 |                 dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
         |                                                             ~~~
         |                                                             %zu
     673 |                         table_length, length);
         |                         ^~~~~~~~~~~~
   include/linux/dev_printk.h:146:70: note: expanded from macro 'dev_warn'
     146 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                     ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   drivers/cxl/core/pci.c:673:18: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
     672 |                 dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
         |                                                                 ~~~
         |                                                                 %zu
     673 |                         table_length, length);
         |                                       ^~~~~~
   include/linux/dev_printk.h:146:70: note: expanded from macro 'dev_warn'
     146 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                     ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +673 drivers/cxl/core/pci.c

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
   672			dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
 > 673				table_length, length);
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

