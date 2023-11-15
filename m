Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FCA7ED5F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjKOVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjKOVWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:22:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C8292;
        Wed, 15 Nov 2023 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700083338; x=1731619338;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=FT7PreuJ3lVSxdZI3Kl8HWil/xrTD5aZhsrselUmF1M=;
  b=Vo+JG/GA9YN1ktsxqjLakemjqQEe+wFJvXY39OLSrO+cD5noQWzfJH55
   2QLUBXlS5zskBsJydDrg2euawxvSzMIrCSPr8vmIfmn+Ots/LII9cskm9
   NHi0mAcVpwjZv/WcadjU3B62nwvgJ4zyvRyNJzFGIPlE/zl5pWfp9NZAA
   /Up+/+AAvzCXfjjsaR16GoGMRTbSYv6wWxDP+P3hQENjPIUW4/bSLIYgF
   7It6TC3HdJij3iyj8BxYc3I8EPJKBt7hTJC2KCg+aJ1GRro2lz0hlj1s/
   d5EcKmVvGF2tWLSLQzXEXDT0+4Nh9FL56muNQNfY7Co3sVclOgKrqYQv8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9598794"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="9598794"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 13:22:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831050068"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="831050068"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.93.50.236])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 15 Nov 2023 13:22:15 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: Re: [PATCH v6 12/12] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-13-haitao.huang@linux.intel.com>
 <CWZOSGQ2RYRX.2T0TCXOL4991P@kernel.org>
Date:   Wed, 15 Nov 2023 15:22:13 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2egyzbzxwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CWZOSGQ2RYRX.2T0TCXOL4991P@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +CG_ROOT=/sys/fs/cgroup
>> +if [ ! -d "/sys/fs/cgroup/misc" ]; then
>> +    echo "# cgroup V2 is in use."
>> +else
>> +    echo "# cgroup V1 is in use."
>> +    CG_ROOT=/sys/fs/cgroup/misc
>> +fi
>
> Does the test need to support v1 cgroups?
>
I thought some distro may still only support V1. I do my most work on  
Ubuntu22.04 which by default is v1 so it's convenient for me to test. But  
not strong opinions.

Thanks
Haitao
