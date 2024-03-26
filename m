Return-Path: <linux-kernel+bounces-119497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C288C9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF581F650DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812711AAC4;
	Tue, 26 Mar 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSmiSbL1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A21C68C;
	Tue, 26 Mar 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471619; cv=none; b=NYeeavLxP50e36IK6+AoyYN9dzE2qiFruqD5thR6Fnfjx59AtUqDb8ptcz970U+8wChf6tBQ584iLLqyhv8P3CXv2pCSRVZ6o4+I8LUHS93oIB+Jc/MUk57mDLBNUrUvCUObylGH25CH/wJBxygpiUdD+Oxj3AWTYWBHtblkixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471619; c=relaxed/simple;
	bh=cTcHrvAeiijxWXWyZWDCSqvwzr1pjWo34Vu0hn6R04g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKBskalx97vb4IwiMQALQE5nK2BSjSV8ShS6CC1t+jVekHDj85coccm5T3X8zAGX/SSuFt4MYe9iGo/fln8UPc/+mkPnATAwuhcBNGnMOfImeTlNAIcQ9Hy6sQj4gRuPczh9NKAI0OlLJWvTW3xfUUDsT28o4jxdZLj563EHchs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSmiSbL1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711471617; x=1743007617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cTcHrvAeiijxWXWyZWDCSqvwzr1pjWo34Vu0hn6R04g=;
  b=VSmiSbL1vuw/pNTE2wnlq4yrv+ckHepcmFuGc8usTpIfNMZ8sn7X51Eg
   Cn1HXa5du3HrJDOucsPT1Hz83PsgPkS5UMR6/ZQSMfhL88uGTZtoT+fYH
   Gw+XPMdpxkhx3St5wbwXkdyZGR/rjQnToLRRAXRHroDPUsOj1sNl8oX2b
   NtMtmheqL47wuoJGKpgD9vIxgOxs5YaB9yjUBM/bJCqtc6huSYtTuySyr
   RmbAhR6n4HxfRq5cR+VkfKdsD0A42sjbF9ogcGnNx3NsdKy5ag0iKVWkc
   RODiCKgl5Ti5V7ylBWsjebkSyOdnGiWz158Ta3Duwy9fTjvnWR8Y6oQdI
   w==;
X-CSE-ConnectionGUID: tQdDL4ZFQEiTFFGMCeAwQw==
X-CSE-MsgGUID: 47yctdXfT2KbhAXMNsF6Hg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17167256"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17167256"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:46:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15880418"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Mar 2024 09:46:52 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp9wo-0000EK-09;
	Tue, 26 Mar 2024 16:46:50 +0000
Date: Wed, 27 Mar 2024 00:46:40 +0800
From: kernel test robot <lkp@intel.com>
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	thomas.lendacky@amd.com, dan.j.williams@intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, graf@amazon.de, dwmw@amazon.co.uk,
	bchalios@amazon.es, xmarcalx@amazon.co.uk
Subject: Re: [PATCH v3 4/4] virt: vmgenid: add support for devicetree bindings
Message-ID: <202403270050.wJ0Hd5aB-lkp@intel.com>
References: <20240325195306.13133-5-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325195306.13133-5-sudanl@amazon.com>

Hi Sudan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8e938e39866920ddc266898e6ae1fffc5c8f51aa]

url:    https://github.com/intel-lab-lkp/linux/commits/Sudan-Landge/virt-vmgenid-rearrange-code-to-make-review-easier/20240326-035657
base:   8e938e39866920ddc266898e6ae1fffc5c8f51aa
patch link:    https://lore.kernel.org/r/20240325195306.13133-5-sudanl%40amazon.com
patch subject: [PATCH v3 4/4] virt: vmgenid: add support for devicetree bindings
config: x86_64-buildonly-randconfig-004-20240326 (https://download.01.org/0day-ci/archive/20240327/202403270050.wJ0Hd5aB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240327/202403270050.wJ0Hd5aB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403270050.wJ0Hd5aB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/virt/vmgenid.c: In function 'vmgenid_add_of':
   drivers/virt/vmgenid.c:154:15: error: 'dev' undeclared (first use in this function); did you mean 'pdev'?
     154 |         (void)dev;
         |               ^~~
         |               pdev
   drivers/virt/vmgenid.c:154:15: note: each undeclared identifier is reported only once for each function it appears in
   drivers/virt/vmgenid.c: At top level:
>> drivers/virt/vmgenid.c:60:12: warning: 'setup_vmgenid_state' defined but not used [-Wunused-function]
      60 | static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
         |            ^~~~~~~~~~~~~~~~~~~
>> drivers/virt/vmgenid.c:27:13: warning: 'vmgenid_notify' defined but not used [-Wunused-function]
      27 | static void vmgenid_notify(struct device *device)
         |             ^~~~~~~~~~~~~~


vim +/setup_vmgenid_state +60 drivers/virt/vmgenid.c

af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23  26  
fba2c3554a30ca Sudan Landge       2024-03-25 @27  static void vmgenid_notify(struct device *device)
5eb78dfcd888d3 Sudan Landge       2024-03-25  28  {
fba2c3554a30ca Sudan Landge       2024-03-25  29  	struct vmgenid_state *state = device->driver_data;
5eb78dfcd888d3 Sudan Landge       2024-03-25  30  	char *envp[] = { "NEW_VMGENID=1", NULL };
5eb78dfcd888d3 Sudan Landge       2024-03-25  31  	u8 old_id[VMGENID_SIZE];
5eb78dfcd888d3 Sudan Landge       2024-03-25  32  
5eb78dfcd888d3 Sudan Landge       2024-03-25  33  	memcpy(old_id, state->this_id, sizeof(old_id));
5eb78dfcd888d3 Sudan Landge       2024-03-25  34  	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
5eb78dfcd888d3 Sudan Landge       2024-03-25  35  	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
5eb78dfcd888d3 Sudan Landge       2024-03-25  36  		return;
5eb78dfcd888d3 Sudan Landge       2024-03-25  37  	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
fba2c3554a30ca Sudan Landge       2024-03-25  38  	kobject_uevent_env(&device->kobj, KOBJ_CHANGE, envp);
5eb78dfcd888d3 Sudan Landge       2024-03-25  39  }
5eb78dfcd888d3 Sudan Landge       2024-03-25  40  
84d2b6732ae89f Sudan Landge       2024-03-25  41  #if IS_ENABLED(CONFIG_ACPI)
fba2c3554a30ca Sudan Landge       2024-03-25  42  static void vmgenid_acpi_handler(acpi_handle handle, u32 event, void *dev)
af6b54e2b5baa5 Jason A. Donenfeld 2022-02-23  43  {
84d2b6732ae89f Sudan Landge       2024-03-25  44  	(void)handle;
84d2b6732ae89f Sudan Landge       2024-03-25  45  	(void)event;
fba2c3554a30ca Sudan Landge       2024-03-25  46  	vmgenid_notify(dev);
fba2c3554a30ca Sudan Landge       2024-03-25  47  }
84d2b6732ae89f Sudan Landge       2024-03-25  48  #endif
84d2b6732ae89f Sudan Landge       2024-03-25  49  
84d2b6732ae89f Sudan Landge       2024-03-25  50  #if IS_ENABLED(CONFIG_OF)
84d2b6732ae89f Sudan Landge       2024-03-25  51  static irqreturn_t vmgenid_of_irq_handler(int irq, void *dev)
84d2b6732ae89f Sudan Landge       2024-03-25  52  {
84d2b6732ae89f Sudan Landge       2024-03-25  53  	(void)irq;
84d2b6732ae89f Sudan Landge       2024-03-25  54  	vmgenid_notify(dev);
84d2b6732ae89f Sudan Landge       2024-03-25  55  
84d2b6732ae89f Sudan Landge       2024-03-25  56  	return IRQ_HANDLED;
84d2b6732ae89f Sudan Landge       2024-03-25  57  }
84d2b6732ae89f Sudan Landge       2024-03-25  58  #endif
fba2c3554a30ca Sudan Landge       2024-03-25  59  
fba2c3554a30ca Sudan Landge       2024-03-25 @60  static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
fba2c3554a30ca Sudan Landge       2024-03-25  61  {
fba2c3554a30ca Sudan Landge       2024-03-25  62  	if (IS_ERR(next_id))
fba2c3554a30ca Sudan Landge       2024-03-25  63  		return PTR_ERR(next_id);
fba2c3554a30ca Sudan Landge       2024-03-25  64  
fba2c3554a30ca Sudan Landge       2024-03-25  65  	state->next_id = next_id;
fba2c3554a30ca Sudan Landge       2024-03-25  66  	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
fba2c3554a30ca Sudan Landge       2024-03-25  67  	add_device_randomness(state->this_id, sizeof(state->this_id));
fba2c3554a30ca Sudan Landge       2024-03-25  68  	return 0;
fba2c3554a30ca Sudan Landge       2024-03-25  69  }
fba2c3554a30ca Sudan Landge       2024-03-25  70  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

