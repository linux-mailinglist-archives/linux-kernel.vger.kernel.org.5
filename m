Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43474797DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbjIGU5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 16:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjIGU5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:57:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6C01BCB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694120238; x=1725656238;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TnHPBK3JAQdjs+KKepwKfTroxYQD4ZTEDh4wzTbxXF0=;
  b=LmOwvUw2ezlcrt7UJaQCGJj/0ailE8bKR5SWbycAWUaJUndqdgG6BL8i
   L3OET/6sGPf0XxhFKnHy0cgEo4pd+NH2CoFA/QVRKiS47YJmmylccBbsx
   kBHz/ySXUgn2N0dZl+ggPwjnk6OjaSqLi+gMqAIfYhiMROF/Xj9LY/h3j
   A1ODCb8AUO9ij+8ZA7QNOo4Wj27vDJADhyjvZCHR6i7tm225VQrQe5k9O
   0Jhtl1t3KEMJAJS+JBDEcs/XvIMJm0nZ1/SeRZP8XHRSTpJn3OVlv+d5M
   CeF7RkfcPh7xmqJLZRL89YdAv7cUncrXQdwBcwJ31xPPHxQDFCwtX3lEq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="441494705"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="441494705"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 13:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="857041985"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="857041985"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 13:57:17 -0700
Message-ID: <29cd0ee1-c638-9d8e-8a1c-8c2aa2e167e7@intel.com>
Date:   Thu, 7 Sep 2023 13:57:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] x86/platform/uv: Use alternate source for socket to node
 data
Content-Language: en-US
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20230807141730.1117278-1-steve.wahl@hpe.com>
 <ad1ff365-4160-87b9-4199-ace5ff1250e1@intel.com>
 <ZPI1IP38l/X7K/k9@swahl-home.5wahls.com>
 <ZPdC2OxhPznQuYk8@swahl-home.5wahls.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZPdC2OxhPznQuYk8@swahl-home.5wahls.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 08:01, Steve Wahl wrote:
> On Fri, Sep 01, 2023 at 02:01:52PM -0500, Steve Wahl wrote:
>> On Fri, Sep 01, 2023 at 10:18:20AM -0700, Dave Hansen wrote:
>>> On 8/7/23 07:17, Steve Wahl wrote:
>>>> When nr_cpus is set to a smaller number than actually present, the
>>>> cpu_to_node() mapping information for unused CPUs is not available to
>>>> build_socket_tables().  This results in an incomplete table and will
>>>> later cause use of a -1 value for some array indexing, and eventual
>>>> kernel page faults.
>>>>
>>>> Switch to using the __apicid_to_node array, which still contains all
>>>> the information mapping apicids to nodes, even for CPUs disabled with
>>>> a reduced nr_cpus setting.
>>> Before, the lookup went:
>>>
>>> 	CPU => APICID => SOCKET
>>>
>>> But when the CPU wasn't present, there wasn't a way to start this lookup.
>>>
>>> So, instead of looping over all CPUs, looking up their APICIDs and
>>> mapping those to sockets, just take CPUs out of the equation entirely.
>>>
>>> Loop over all APICIDs which are mapped to a valid NUMA node.  Then just
>>> extract the socket-id from the APICID.
>>>
>>> Right?
>>>
>>> That seems sane enough.  It's also way less code than the previous approach.
>> Yes.  That's it precisely.  And, yes, way less code.
> Are you willling to give a "Reviewed-by:"?

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Does this need a stable@ tag when it gets applied?
