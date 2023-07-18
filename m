Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1A757F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjGRO1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjGRO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:27:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9860199;
        Tue, 18 Jul 2023 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689690470; x=1721226470;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=19XepKsMICRDWf3P5XYy0kL4w0Zj42OXH3hKop15his=;
  b=GUXOZqR7DHu8BXGN0eOvirYcZIN1ndR7OAfkMzLn5a6BJQdjpgbpovU+
   jczK68J0dtkrwgIzvcyUnOnl5FVDr1H5efy6Ds+a7sg0Ndh8I4jVTpiCI
   KkOrPvNFbt2NtnPWZ/47Ij/AxXfzY68HW81xqupJvwF80uI7Ak0vBP/wK
   /VwkVj4vIzPNFQ8MIzSslX8SgMGxBbXTF6zM5+7gS5TqDfo23+1wFP0aE
   HqqpqVUsrtlymrk4+58U8gupUyWmTqtqEhb8xWhx5q1KzMTvxQcdej0Vu
   tolCBGVaYjyNFI2d24HbznLi4+IeV2c1yzAFHXyPa6pkBR+gwmoKSGakf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="366262553"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="366262553"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:27:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="726953755"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="726953755"
Received: from pkarurmo-mobl.amr.corp.intel.com (HELO [10.209.37.195]) ([10.209.37.195])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:27:49 -0700
Message-ID: <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
Date:   Tue, 18 Jul 2023 07:27:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kai.huang@intel.com, reinette.chatre@intel.com,
        kristen@linux.intel.com, seanjc@google.com, stable@vger.kernel.org
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
 <20230717202938.94989-1-haitao.huang@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230717202938.94989-1-haitao.huang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 13:29, Haitao Huang wrote:
> Under heavy load, the SGX EPC reclaimers (current ksgxd or future EPC
> cgroup worker) may reclaim the SECS EPC page for an enclave and set
> encl->secs.epc_page to NULL. But the SECS EPC page is used for EAUG in
> the SGX #PF handler without checking for NULL and reloading.
> 
> Fix this by checking if SECS is loaded before EAUG and load it if it was
> reclaimed.

It would be nice to see a _bit_ more theory of the bug in here.

What is an SECS page and why is it special in a reclaim context?  Why is
this so hard to hit?  What led you to discover this issue now?  What is
EAUG?
