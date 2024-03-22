Return-Path: <linux-kernel+bounces-111098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82458867E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F079F1C2339E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15341642A;
	Fri, 22 Mar 2024 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8dM5SRM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C612E7D;
	Fri, 22 Mar 2024 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094603; cv=none; b=ZmfnwOUtRDt0jTgrAbhJip5sCJsJRMnUqEbZoKYUkLCZqf9LGL6kN2BTtSdbZdymZ4ZDMQXgh26d3YBEwqViqd7U1m0pFpgNpt+Fm8bcNBJ0Z4WN68TL1uX1ICZz8GRDWRSWy4p8KKeX5pDgb3psPvH548dhFCIxXw03SUBacXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094603; c=relaxed/simple;
	bh=KtREvos/d5+aLyOdl8HCquwfkvZVafN4A82rG+GpL2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbX6KJ7YLgqbILiIpphZphHtvh7y7LWmgM7gExb4HXlWeC5bxuyaNf/8QCxaEhrUBVnV3zJjKNlIVj2oyYcmR0iTkXfQTs9CTBhpeSioQch/qJJ+vbyD1xaNwoAw6aIDU5sYBMtqAbVNcyIfxUSQRQTl5DA2/44CEThVBRRjcFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8dM5SRM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711094601; x=1742630601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KtREvos/d5+aLyOdl8HCquwfkvZVafN4A82rG+GpL2A=;
  b=e8dM5SRMs2OED8prvICJ3caPykHy7rauzZnajMLk7uTaenIOyHp6dcAk
   zlh8zq1O7csNMXhsGDiDUZ84Nn8XOnT1uExCx4M22NHyCNq4kIuynMvWx
   ZN+v9VVGcIs7cS861uQ3G4nuZYAIESigkimp7XWDMfx5myhQ1qTcKge5p
   JGRdqda0MvMCHC6GG4c9Xa79SXXZwGUzVgYM4cZaDxHQ5eDtVUciMi4uR
   abR0IlV1Ko/FqHIjiRkts85qHw2YCV3FVPhVhoeSkb+E3F1erT227496h
   eWsysqsYXP02O5EQ38rbbc22aXvCKQdZCqkzph1fZx6iK38ZxfHbXVCto
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5959701"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="5959701"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 01:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="19373642"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 22 Mar 2024 01:03:16 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnZru-000K91-14;
	Fri, 22 Mar 2024 08:03:14 +0000
Date: Fri, 22 Mar 2024 16:02:18 +0800
From: kernel test robot <lkp@intel.com>
To: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	thomas.lendacky@amd.com, dan.j.williams@intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, graf@amazon.de,
	dwmw@amazon.co.uk, bchalios@amazon.es, xmarcalx@amazon.co.uk
Subject: Re: [PATCH v2 4/4] virt: vmgenid: add support for devicetree bindings
Message-ID: <202403221537.Dais4vyo-lkp@intel.com>
References: <20240321025105.53210-5-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321025105.53210-5-sudanl@amazon.com>

Hi Sudan,

kernel test robot noticed the following build errors:

[auto build test ERROR on a4145ce1e7bc247fd6f2846e8699473448717b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Sudan-Landge/virt-vmgenid-rearrange-code-to-make-review-easier/20240321-105317
base:   a4145ce1e7bc247fd6f2846e8699473448717b37
patch link:    https://lore.kernel.org/r/20240321025105.53210-5-sudanl%40amazon.com
patch subject: [PATCH v2 4/4] virt: vmgenid: add support for devicetree bindings
config: s390-randconfig-002-20240322 (https://download.01.org/0day-ci/archive/20240322/202403221537.Dais4vyo-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 23de3862dce582ce91c1aa914467d982cb1a73b4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240322/202403221537.Dais4vyo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403221537.Dais4vyo-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390x-linux-ld: drivers/virt/vmgenid.o: in function `vmgenid_add':
>> vmgenid.c:(.text+0xe8): undefined reference to `of_address_to_resource'
>> s390x-linux-ld: vmgenid.c:(.text+0x148): undefined reference to `of_iomap'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

