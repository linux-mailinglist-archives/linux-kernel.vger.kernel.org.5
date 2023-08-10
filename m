Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74884776D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjHJBXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHJBXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:23:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E950DE7A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691630609; x=1723166609;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I3CngUi8vhKHabYkxIW1a+jmYrp3dBujJNCcldodz6s=;
  b=Vxf5kj1v2G2JaMo3/UwobfeIMJ2t0wBr7760JAYka3g/WdMQPNhxlKm4
   yQHeVB/Xd/NGPadCSQUcFujJnoQqbHFRFatnLF78N1kydqG3/+GvtN66W
   SoFo3/cQvyuszkCp0I8WCEOAtj/OmGuBNYd92dx0y9Z0I0Zp8mOggUuyN
   r2xy8HCsVTJ3UfRWBrdNowtMkKUwHT65D0oucDurE25xFXPyMe0aP7Y4t
   NFEy5xC9KtvhcgTGXYrkULLyN38F38tyQN6sQv7D8XmEBPXuYswvquJmI
   bL7i3eV1XyeaC2JZ4rj5XVfnJ7nvQ2L5aHDgkEkHcXeqmCSA5GVLcwj+p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="351573637"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="351573637"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 18:23:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="978601698"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="978601698"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.239]) ([10.254.214.239])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 18:23:25 -0700
Message-ID: <84ee4ce8-8589-68da-b105-f96c961ade16@linux.intel.com>
Date:   Thu, 10 Aug 2023 09:23:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, Tina Zhang <tina.zhang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Share sva domains with all devices bound to a mm
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <184044ad-880f-5452-727b-f7fd18330c22@linux.intel.com>
 <ZNOmsfE3Eheuelv8@ziepe.ca>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNOmsfE3Eheuelv8@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/9 22:46, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 08:18:18AM +0800, Baolu Lu wrote:
>> On 2023/8/8 15:49, Tina Zhang wrote:
>>> A sva domain's lifetime begins with binding a device to a mm and ends
>>> by releasing all the bound devices from that sva domain. Technically,
>>> there could be more than one sva domain identified by the mm PASID for
>>> the use of bound devices issuing DMA transactions.
>>>
>>> To support mm PASID 1:n with sva domains, each mm needs to keep both a
>>> reference list of allocated sva domains and the corresponding PASID.
>>> However, currently, mm struct only has one pasid field for sva usage,
>>> which is used to keep the info of an assigned PASID. That pasid field
>>> cannot provide sufficient info to build up the 1:n mapping between PASID
>>> and sva domains.
>> Is it more appropriate to have the same life cycle for sva domain and mm
>> pasid? I feel that they represent the same thing, that is, the address
>> space shared by mm to a device.
> No! The iommu_domain and the PASID are totally seperate objects with
> their own lifecycles.
> 
> The SVA domain should NEVER be tied to the mm enqcmd PASID.

Okay. Fair enough.

> 
> We might decide to free all the domains and keep the PASID around (can
> we even revoke the enqcmd pasid while the MM is alive?)

We ever did this and was removed to make code simple.

Best regards,
baolu
