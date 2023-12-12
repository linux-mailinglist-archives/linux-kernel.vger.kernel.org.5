Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7AB80FB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377471AbjLLXkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjLLXkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:40:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D48D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702424420; x=1733960420;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=rYt9y8KfAs0S4u+oQu0MTYyoDHJrw5FTNqxPbQrg/eU=;
  b=m64MaDwgFstmFrltKmvZ1GmpqdVHJ2uH5a+9jfnDehQCrP5Bxn6Y57sM
   UvKJNWKvr6KWi5aAMT7tSxMdfX3b2zJnvfqPSO90Mi7mEHa6dscl8fxTs
   t5i+A7F9hyR+dNkNrOaLjBn/N6AXngjD/BwZ+wsr7HPANSLq8BHyP2hIh
   QoOhZonMYI2qWZ4tsqYX3l6TY545LrvBdjSuduEfZIgqcS24w36oP9xJQ
   yreE+VLpj9wBC/HwUZb3molb6WWJznblnhL+gpeem6DwEH9JkSJ6mNHdI
   SB6gX1Psil1uAhlkpF45UOdXqlxHJq+ef5pe7gldkpaEBnx0GPlYAhKCX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="398730465"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="398730465"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="723414887"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="723414887"
Received: from rfield-mobl1.amr.corp.intel.com (HELO [10.209.75.26]) ([10.209.75.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:40:19 -0800
Message-ID: <b2e7daff1e314d927cc4b4713afa31ac25787825.camel@linux.intel.com>
Subject: Re: [RFC PATCH v2 3/5] padata: dispatch works on different nodes
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ligang.bdlg@bytedance.com
Date:   Tue, 12 Dec 2023 15:40:18 -0800
In-Reply-To: <20231208025240.4744-4-gang.li@linux.dev>
References: <20231208025240.4744-1-gang.li@linux.dev>
         <20231208025240.4744-4-gang.li@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> =20
>  	list_for_each_entry(pw, &works, pw_list)
> -		queue_work(system_unbound_wq, &pw->pw_work);
> +		if (job->numa_aware)
> +			queue_work_node((++nid % num_node_state(N_MEMORY)),

The nid may fall on a NUMA node with only memory but no CPU.  In that case =
you
may still put the work on the unbound queue. You could end up on one CPU no=
de for work
from all memory nodes without CPU. Is this what you want?  Or you would
like to spread them between CPU nodes?

Tim

> +					system_unbound_wq, &pw->pw_work);
> +		else
> +			queue_work(system_unbound_wq, &pw->pw_work);
> =20
>  	/* Use the current thread, which saves starting a workqueue worker. */
>  	padata_work_init(&my_work, padata_mt_helper, &ps, PADATA_WORK_ONSTACK);

