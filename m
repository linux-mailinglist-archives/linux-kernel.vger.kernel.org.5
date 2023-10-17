Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B313E7CB9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjJQFVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJQFVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:21:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED639E;
        Mon, 16 Oct 2023 22:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697520061; x=1729056061;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0ljYECpynZJuwW/CzHhX9ZRRExV5kXxxKaS9D40UqLM=;
  b=bPcsKFCCnSO8bwW2wqkVc9UACV1lz3ash7OAjQqXpOdggL1aTvVKhdrN
   ofHgCvbFIm41q5H9yo2U8hpCHlOwYmPPAuxPTO536+6LjKHP8Us4WzLLQ
   he9PV/eX+ZTsE1gf5/MaHAPvK8sCPcAdWBs8izIvTP1dC9mxYpZQq/lhW
   SZj4sTmj3vwVogHfE98cQqeWrHMnFjEwZNb2jXiiDITD4gJbTJ11pVH4b
   bEZyYcmQ1v8RuAnafL4BbZZvcUfFV2QbuGX4hbLWY5WkqXwEkNIK7zCrY
   A7mo4QRLnsBkN71QKXyAZ7Ua2aNDkUtu3tP9I6Xw6Q8GTRBd5vHR0F/qG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370771752"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370771752"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="846685324"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="846685324"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:20:56 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Hocko, Michal" <mhocko@suse.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
In-Reply-To: <923d65270ad08d47adae0d82ab4b508d01e9cc00.camel@intel.com>
        (Vishal L. Verma's message of "Tue, 17 Oct 2023 08:31:04 +0800")
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
        <20231005-vv-kmem_memmap-v5-2-a54d1981f0a3@intel.com>
        <651f27b728fef_ae7e7294b3@dwillia2-xfh.jf.intel.com.notmuch>
        <923d65270ad08d47adae0d82ab4b508d01e9cc00.camel@intel.com>
Date:   Tue, 17 Oct 2023 13:18:56 +0800
Message-ID: <87edhtaksf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Verma, Vishal L" <vishal.l.verma@intel.com> writes:

> On Thu, 2023-10-05 at 14:16 -0700, Dan Williams wrote:
>> Vishal Verma wrote:
>> >
> <..>
>
>> > +
>> > +       rc = kstrtobool(buf, &val);
>> > +       if (rc)
>> > +               return rc;
>>
>> Perhaps:
>>
>> if (dev_dax->memmap_on_memory == val)
>>         return len;
>>
>> ...and skip the check below when it is going to be a nop
>>
>> > +
>> > +       device_lock(dax_region->dev);
>> > +       if (!dax_region->dev->driver) {
>>
>> Is the polarity backwards here? I.e. if the device is already attached to
>> the kmem driver it is too late to modify memmap_on_memory policy.
>
> Hm this sounded logical until I tried it. After a reconfigure-device to
> devdax (i.e. detach kmem), I get the -EBUSY if I invert this check.

Can you try to unbind the device via sysfs by hand and retry?

--
Best Regards,
Huang, Ying

>>
>> > +               device_unlock(dax_region->dev);
>> > +               return -ENXIO;
>>

[snip]
