Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF267E2971
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjKFQKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKFQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:10:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF8134;
        Mon,  6 Nov 2023 08:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699287047; x=1730823047;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=5GCvRiNJ6dV/UFrpMZoxAhMDSzAyJ+nl9Yy7Gla6K/8=;
  b=ZXgy+Xq61MvlXU8c7SqAM76EkbDWO3F5iV5DAnaAqOpxZAZ5RMiS2eND
   TMC7wWQGv/XoVqQObfUrBL9UhypWuVuB/uVb368ht+FuZgNm2kOUcWAhP
   2SWns3tyvwNwBYGDIsCGPwgbaGH8KJuldv+ZIh4US+lZFIsTTiYx7iq6N
   jZqumo0VUTAxk/3fGwmJXd3rVISx3XXAACn+7V2RFVhrccFXE+oSbGhGY
   yYpYNpomIeVbKnCc+p6fDAzOCk34QA9Rboc1hSOOLxRsnlKJJ0uQ4IW6S
   PFKWtdRUrdRX3ZI+GvWjNtRgtUNkUogSD532L9GETZ6JZ3hQOOoQX2bUd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="388185695"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="388185695"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 08:10:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="828265482"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="828265482"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.93.50.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 06 Nov 2023 08:10:45 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, tj@kernel.org,
        mkoutny@suse.com, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com,
        "Haitao Huang" <haitao.huang@linux.intel.com>
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com,
        "Sean Christopherson" <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 10/12] x86/sgx: Implement EPC reclamation for cgroup
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-11-haitao.huang@linux.intel.com>
Date:   Mon, 06 Nov 2023 10:10:44 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2dzwj6kvwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <20231030182013.40086-11-haitao.huang@linux.intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There is an issue WRT charging proper mem_cgroups for backing pages once  
per-cgroup reclamation is implemented.

Please apply the fix-up patch [1] on top of this patch or the series.

Thanks
Haitao

[1]  
https://lore.kernel.org/all/20231106155859.7251-1-haitao.huang@linux.intel.com/
 
