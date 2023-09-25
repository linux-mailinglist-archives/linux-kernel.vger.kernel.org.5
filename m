Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267AC7AD60C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjIYKcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjIYKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:32:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D70127;
        Mon, 25 Sep 2023 03:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695637925; x=1727173925;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G7gQNM2ETXkwxgbdw0M0S6loHs2HYqulZXnsb3ikQcU=;
  b=RTXjcYLbwD4jCCpZI8rqtIZMM3MHXrgOt67Lj+65mpMFF/l6DYPOLits
   /pXEK3KLDZch4pm85RclXIsXk0MTPDpHnVcrH4uZEzCXd/NjA8EqFyHuO
   oJQ+ejzdUxU/MUpdcqpKV6l5yraxSluKvfcSZ+s9Pan2CB5cgG4sGKXkH
   a6ENWQ0SB8qaZbCoVSGsMElxGT0rS5xNn4E7bP39CxYVUmqZHwJkeTj4H
   vSlxxxgsaclBqxjDoFZpDe/kTkFR9X4OiGwPD3wOVKiWb0XtmoSGwDDBA
   fm8P/rMn34WKjeqtwlATt+AxGAggDglmbvv7AMOZFHlAhTYp1ubfiIlPw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="361473793"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="361473793"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 03:32:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818562298"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818562298"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.180])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 03:31:59 -0700
Message-ID: <30f4276b-5e29-4a7a-9b4c-6bab505984ab@intel.com>
Date:   Mon, 25 Sep 2023 13:31:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mmc: sdhci: add __sdhci_execute_tuning() to header
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>,
        Drew Fustini <dfustini@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Han Gao <gaohan@iscas.ac.cn>, Icenowy Zheng <uwu@icenowy.me>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <20230921-th1520-mmc-v1-2-49f76c274fb3@baylibre.com>
 <4ef60ffd-3661-4bca-91a3-b49d6189c71b@intel.com>
 <aeb2cc43ea4e5281195c8bccd1f033ed73e6a7ef.camel@xry111.site>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <aeb2cc43ea4e5281195c8bccd1f033ed73e6a7ef.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/23 13:23, Xi Ruoyao wrote:
> On Mon, 2023-09-25 at 13:21 +0300, Adrian Hunter wrote:
>> On 22/09/23 04:49, Drew Fustini wrote:
>>> Expose __sdhci_execute_tuning() so that it can be called from the
>>> mmc host controller drivers.
>>>
>>> In the sdhci-of-dwcmshc driver, sdhci_dwcmshc_th1520_ops sets
>>> platform_execute_tuning to th1520_execute_tuning(). That function has
>>> to manipulate phy registers before tuning can be performed. To avoid
>>> copying the code verbatim from __sdhci_execute_tuning() into
>>> th1520_execute_tuning(), make it possible for __sdhci_execute_tuning()
>>> to be called from sdhci-of-dwcmshc.
>>>
>>> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 2 +-
>>>  drivers/mmc/host/sdhci.h | 1 +
>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index ff41aa56564e..fd607058d176 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2841,7 +2841,7 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_send_tuning);
>>>  
>>> -static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>>> +int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>>
>> Also need
>> 	EXPORT_SYMBOL_GPL(__sdhci_execute_tuning);
>>
>>>  {
>>>  	int i;
> 
> By the way should we rename this function?  I think
> "__sdhci_execute_tuning" vs "sdhci_execute_tuning" might be confusing
> when we export both.
> 

'name()' and '__name()' is not a particularly rare paradigm in the kernel,
so it seems ok.

