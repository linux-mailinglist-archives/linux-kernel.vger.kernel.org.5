Return-Path: <linux-kernel+bounces-54450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF22084AF6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B82E2875CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982812AAC3;
	Tue,  6 Feb 2024 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kesKdZ7b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B7128837;
	Tue,  6 Feb 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206162; cv=none; b=PXiH9nttrPbW823mZ5IpSlMBV+p+K2Zgr120vGUfGD9pBSyeZf8ynf/Ypb9yh+Nm7/A/dZuaYgMhWOciBQ/AvIR31oFRcVtxpkno+eQvors72pis/PbQaI8wN12hwBBKNY9i9etar1LD/hl8/bVGQg6R0lmhWfdlWSlZ7ifmbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206162; c=relaxed/simple;
	bh=kibuinQQboCOdIbObfqQOCERxYUraXYrglrTfEYaZlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaAYvwk+6D1yee2NqP3uz5fPtywkqlSVqKJGZHTnMuldfKfuC/VUF+cePVah1QhUUy4+N5lDY0F0TWbHnxym2ZjQn+WskeyAaJUaYKHQ6ZvQRtkm5vtVvCGHu5OnFnrouWW04nIdqTGgr3kcliY8Yb4YZlenTu1bWxmbaE4EvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kesKdZ7b; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707206160; x=1738742160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kibuinQQboCOdIbObfqQOCERxYUraXYrglrTfEYaZlo=;
  b=kesKdZ7bMElefYnxzZC+hxWNpw6nmH6Paq5LWtlacGJC0nVjGnoFzvbl
   hC/LSKV1ClC5slML6V6Vh7plP4ESmbcy342QlK4gipUkG+xbbXuEKwZgE
   PWzw4a9VtI9QlEWf6o875A4A4nCZHFZGQuNb4miF/yqm+exGWeoeP5gge
   8SBqbV1+d99PU6fjhDezfDFCG6oLW2Li+YSxveEdIEei47LOnRvGxdM54
   rjHxN5GBgnvDqzPAOMIqS2t3VlM+ZMH8unRDa9ZEaYMysmUOxAiWYasl1
   MjZCv6xjbDAaXe2/GGnLBW8PHAExH5iGMnhlxNmcQUZeAtH/acu8a+SUw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="3651567"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="3651567"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 23:55:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="1228376"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Feb 2024 23:55:55 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXGJ6-0001Ay-2x;
	Tue, 06 Feb 2024 07:55:52 +0000
Date: Tue, 6 Feb 2024 15:55:08 +0800
From: kernel test robot <lkp@intel.com>
To: Odelu Kukatla <quic_okukatla@quicinc.com>, djakov@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rafael@kernel.org, corbet@lwn.net,
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_okukatla@quicinc.com,
	quic_viveka@quicinc.com, peterz@infradead.org,
	quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org,
	konrad.dybcio@linaro.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
Message-ID: <202402061541.oNi4V6C6-lkp@intel.com>
References: <20240205145606.16936-2-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205145606.16936-2-quic_okukatla@quicinc.com>

Hi Odelu,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.8-rc3 next-20240205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Odelu-Kukatla/interconnect-qcom-icc-rpmh-Add-QoS-configuration-support/20240205-230208
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240205145606.16936-2-quic_okukatla%40quicinc.com
patch subject: [PATCH v2 1/4] interconnect: qcom: icc-rpmh: Add QoS configuration support
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240206/202402061541.oNi4V6C6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240206/202402061541.oNi4V6C6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402061541.oNi4V6C6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/interconnect/qcom/icc-rpmh.c: In function 'qcom_icc_set_qos':
>> drivers/interconnect/qcom/icc-rpmh.c:46:36: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      46 |                                    FIELD_PREP(QOS_DISABLE_MASK, qos->prio_fwd_disable));
         |                                    ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +46 drivers/interconnect/qcom/icc-rpmh.c

    25	
    26	/**
    27	 * qcom_icc_set_qos - initialize static QoS configurations
    28	 * @qp: qcom icc provider to which @node belongs
    29	 * @node: qcom icc node to operate on
    30	 */
    31	static void qcom_icc_set_qos(struct qcom_icc_provider *qp,
    32					struct qcom_icc_node *node)
    33	{
    34		const struct qcom_icc_qosbox *qos = node->qosbox;
    35		int port;
    36	
    37		if (!qp->regmap)
    38			return;
    39	
    40		if (!qos)
    41			return;
    42	
    43		for (port = 0; port < qos->num_ports; port++) {
    44			regmap_update_bits(qp->regmap, QOSGEN_MAINCTL_LO(qos, port),
    45					   QOS_DISABLE_MASK,
  > 46					   FIELD_PREP(QOS_DISABLE_MASK, qos->prio_fwd_disable));
    47	
    48			regmap_update_bits(qp->regmap, QOSGEN_MAINCTL_LO(qos, port),
    49					   QOS_DFLT_PRIO_MASK,
    50					   FIELD_PREP(QOS_DFLT_PRIO_MASK, qos->prio));
    51	
    52			regmap_update_bits(qp->regmap, QOSGEN_MAINCTL_LO(qos, port),
    53					   QOS_SLV_URG_MSG_EN_MASK,
    54					   FIELD_PREP(QOS_SLV_URG_MSG_EN_MASK, qos->urg_fwd));
    55		}
    56	}
    57	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

