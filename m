Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11FA7698F8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjGaOHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjGaOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:06:53 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC711BF4;
        Mon, 31 Jul 2023 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690812259; x=1722348259;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8c5Y6r6nrV+imaXJ+aq3XZpGq4sAW8zp+bZ99Ugqtkg=;
  b=R25t1+CRDueyhGdvrQx7QllY8prcerUGKXKI5dd8TzVe9yhFRvN3Y68H
   7JUEQVbCdh6ve8r7eETu6Tn80VXAAwEf3hyNcT8EgqUGrB1VzGUd2lIiN
   hUKwdPuT/zSUjyz07i+x8McHL4tanqLe9EjBkIqq4ngiE7i+hBRy6R6+n
   A0wmVNCtDR6s4TB5jQftGbr5mZ+QzbfkCqff6e3nxzHGz6lc7FtGMFy2z
   +mqmWuT+StG07XZnx7l0cpUmruy396xRluNUwEGapTsUGnuseqDaXxBc5
   kPMB+5vEdIMa4eQFaVdCA+EJhPcfLi+Drk992GABRNiNksMSRe6Z/njJy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435335660"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="435335660"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 07:03:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="1058942779"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="1058942779"
Received: from aantonov-mobl1.ger.corp.intel.com (HELO [10.252.37.78]) ([10.252.37.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 07:03:26 -0700
Message-ID: <9fa13591-38dc-5dbf-5271-5c2bd364f16f@linux.intel.com>
Date:   Mon, 31 Jul 2023 16:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: potential return of uninitialized variable ret in function
 skx_upi_topology_cb
To:     "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <21e2ea66-9524-8e34-a2f0-8e16b9617d68@gmail.com>
Content-Language: en-US
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
In-Reply-To: <21e2ea66-9524-8e34-a2f0-8e16b9617d68@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,
Thank you so much for reporting the issue. Seems fix wasn't picked up 
before, I will resend it.

Thank you


On 7/27/2023 3:55 PM, Colin King (gmail) wrote:
> Hi,
>
> Static analysis with cppcheck has detected a potential return of an 
> uninitialized variable in function skx_upi_topology_cb. The issue was 
> introduced with commit:
>
> commit 4cfce57fa42d277497cd2c425021312eae2f223c
> Author: Alexander Antonov <alexander.antonov@linux.intel.com>
> Date:   Thu Nov 17 12:28:28 2022 +0000
>
>     perf/x86/intel/uncore: Enable UPI topology discovery for Skylake 
> Server
>
> static int skx_upi_topology_cb(struct intel_uncore_type *type, int 
> segment,
>                                 int die, u64 cpu_bus_msr)
> {
>         int idx, ret;
>
> ^^ ret is not initialized
>
>         struct intel_uncore_topology *upi;
>         unsigned int devfn;
>         struct pci_dev *dev = NULL;
>         u8 bus = cpu_bus_msr >> (3 * BUS_NUM_STRIDE);
>
>         for (idx = 0; idx < type->num_boxes; idx++) {
>                 upi = &type->topology[die][idx];
>                 devfn = PCI_DEVFN(SKX_UPI_REGS_ADDR_DEVICE_LINK0 + idx,
>                                   SKX_UPI_REGS_ADDR_FUNCTION);
>                 dev = pci_get_domain_bus_and_slot(segment, bus, devfn);
>
> ^^ dev may be null, so ret is never assigned
>
>                 if (dev) {
>                         ret = upi_fill_topology(dev, upi, idx);
>                         if (ret)
>                                 break;
>                 }
>         }
>
>         pci_dev_put(dev);
>         return ret;
> }
>
> I suspect this probably is very unlikely, but it would be useful to 
> have ret initialized to some value to avoid garbage being returned. 
> Not sure what the best value is to set as as default in this corner case.
>
> Colin
