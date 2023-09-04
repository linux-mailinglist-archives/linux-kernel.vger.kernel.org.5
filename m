Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31280791036
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 04:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346643AbjIDC55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 22:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjIDC54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 22:57:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E70A4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693796273; x=1725332273;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O+WEzCnElmDAjJDEVfEFV2BresTNtqQ2X1bd4c5PmcI=;
  b=ieFMKzxV0+W3NrDZXI6BIhIqK87jmF9ntAXDbE7v2R/Bc+x06JBBvKaM
   99octSFiAcCLPTybcgRObAWuf9/0DAozft4Vhy3OABedvGF5tFIxfn07N
   /GoP09oG8xZ6VdHnqVUSEa0ntS6EsHzqTUH6zwCFlDnnr68Q9JLTyB9AJ
   phptluoFmIk/pcOFjc+PTjbZ80Ck58bwhNUVqBXz5VcWlLrGk9iiva6Ep
   PZthRZeKTcUc3CWyPujVTz9xBkqe0w5siTwDHUaX/ZO+rZa5F/xY+UsaT
   6VP0hhyqFEXFWNEuPjyuge7vCG3IGjNGAn/tzirZyyxDjUotS8ugQekXf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="380298075"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="380298075"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 19:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="883880778"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="883880778"
Received: from younghwa-mobl3.amr.corp.intel.com (HELO [10.212.224.212]) ([10.212.224.212])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 19:57:48 -0700
Message-ID: <f859d123-6c85-4bc4-8ac9-8761f1f3f602@linux.intel.com>
Date:   Sun, 3 Sep 2023 19:57:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "jpiotrowski@linux.microsoft.com" <jpiotrowski@linux.microsoft.com>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342402274.3934343.11704206926819634506.stgit@dwillia2-xfh.jf.intel.com>
 <4e4407b0-179d-4be4-bf0b-0d674103d4f6@linux.microsoft.com>
 <64f2137362305_4c1f3294f4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <4ff19f7c31b13a63756f40de69fbf8a24fe3bb08.camel@intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <4ff19f7c31b13a63756f40de69fbf8a24fe3bb08.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/2023 7:14 PM, Huang, Kai wrote:
> On Fri, 2023-09-01 at 09:38 -0700, Dan Williams wrote:
>>> The extended guest request is another topic, since userspace has to be aware of
>>> where the kernel choses to put the extended data, and fixup all the offsets in the
>>> table (section 4.1.8.1 in [2]). It would be better to return this data through a
>>> separate file.
>>
>> I notice that the TDX report also includes a certificate blob, so if
>> that is a common concept then yes, it makes sense to have a separate
>> file for that.
> 
> + Sathy and Isaku.
> 
> It is a common concept from the perspective of "concept", because we need
> certificates to verify the attestation blob anyway.  But in implementation,
> unlike to SEV, TDX doesn't have a command to return certificates separately or
> independently [1] -- they are embed to the Quote itself, or theoretically can be
> fetched from Intel.  
> 
> More, for TDX (SGX based attestation) certificates blob itself isn't mandatory
> to be part of the Quote.  Instead, TDX Quote can choose to include some more
> basic platform identification which can in turn be used to get those
> certificates from Intel's provisioning certificate service [2].
> 
> [1] I am not sure whether we can add one or already have one in the latest TDX
> development.  Maybe Sathy or Isaku can help to confirm.
> 
> [2]: Table 9: QE Certification Data
> https://download.01.org/intel-sgx/dcap-1.0.1/docs/Intel_SGX_ECDSA_QuoteGenReference_DCAP_API_Linux_1.0.1.pdf

Yes. TDX does not have any special command to fetch the certificate blob
separately. Currently, it is fetched as part of Quote data. But, since the
certificate blob is fixed per boot (unlike Quote data), I think it makes
sense to add a separate command for it.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
