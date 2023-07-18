Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11E17588EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGRXLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGRXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:11:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F887A1;
        Tue, 18 Jul 2023 16:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689721907; x=1721257907;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=epGXauxX0A+NisaFyr7qkRW9M1vL4VeMJkPviHyjRcE=;
  b=my3UUGzZkLzEl/MQxcGrBrEM5u1mVEWpELidzcZ+q/K+k+RMGFTAm5r4
   Mty2Kkn62wCIpRnKuxZwcOj6AtCeVp06LhXpWTcSuDHs0W0pQpl6kVkb8
   WKCwL9i/IfQlc74fJRKmrm6SDmFQeHkqSGoHWBFrLNpXlkpGv+72VmiKp
   7etawvNsglfiapVc7/OpRzHTmVaFK9crPGhEH/MLaaR13v1TZoDovzwUo
   w46EJYIG4DFK79H+8yPdBDFPF9fhyNke5dRuepQLSEc3loc7VdpvN/w1l
   RDARhsu+5FFejTs1sSZTWsc0XfIqI3xKEdA0gNiJZdSHglOWxvn1gm9NO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="430094615"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="430094615"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 16:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="837449283"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="837449283"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 18 Jul 2023 16:11:44 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
 <20230717202938.94989-1-haitao.huang@linux.intel.com>
 <CU5ERP8KIR0W.JN8OYIY3AQI6@suppilovahvero>
Date:   Tue, 18 Jul 2023 18:11:43 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18av1t14wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CU5ERP8KIR0W.JN8OYIY3AQI6@suppilovahvero>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 10:37:45 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon Jul 17, 2023 at 11:29 PM EEST, Haitao Huang wrote:
>> Under heavy load, the SGX EPC reclaimers (current ksgxd or future EPC
>> cgroup worker) may reclaim the SECS EPC page for an enclave and set
>> encl->secs.epc_page to NULL. But the SECS EPC page is used for EAUG in
>> the SGX #PF handler without checking for NULL and reloading.
>>
>> Fix this by checking if SECS is loaded before EAUG and load it if it was
>> reclaimed.
>>
>> Fixes: 5a90d2c3f5ef8 ("x86/sgx: Support adding of pages to an  
>> initialized enclave")
>> Cc: stable@vger.kernel.org
>
> Given that
>
> 	$ git describe --contains 5a90d2c3f5ef8
> 	v6.0-rc1~102^2~16
>
> You could also describe this as:
>
> Cc: stable@vger.kernel.org # v6.0+

Will add

>
...
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>

Thank you.
Haitao
