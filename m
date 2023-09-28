Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797AC7B240D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjI1RiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1RiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:38:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F16C1A2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695922679; x=1727458679;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vUYvjPlgFPXD0fht4ZgNaZaIp5jz+/28FbQ6ukEjL3g=;
  b=gBtZaDc2sJaN0BETrgVLHQOX8l3Xr9GaoZkQHNhOBvNrNPZX1E2Q9b1z
   X/gE/ZTTLW1MLeZ+ipFOUadFDp8iYVaCM1f1MgIDJAUY3vxPOXjsKJgBf
   rHHHaCQdh+g+IZfEJJ8GLOWHXkl75ilV0EHlunYd88b0qpOC0TAVr6C8O
   dGz9aAObrxybCfo8zxMtch/GPGeCIoN9u09kasFedT2dQkoBSbIC6p9H1
   ra3QaO0usqkLB6WeWMOtwsXhqd2hXsU58MO72V5C2x7XxZwagiTfSW1my
   MolbXl91p3WPzoJpXd3hr8fmvfjE0XmLXsHO50tm92RTQCnBhyRZzDWdM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="448618131"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="448618131"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="699365408"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="699365408"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:37:56 -0700
Message-ID: <f0f68a16-9bf2-703a-345f-5061e821e80a@intel.com>
Date:   Thu, 28 Sep 2023 10:37:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        stanislav.kinsburskii@gmail.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
        wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        graf@amazon.de, pbonzini@redhat.com
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv> <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <fa924c8d-c954-5612-37eb-43e1976a1b7b@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <fa924c8d-c954-5612-37eb-43e1976a1b7b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 10:35, David Hildenbrand wrote:
> On 28.09.23 15:22, Dave Hansen wrote:
>> On 9/27/23 09:13, Stanislav Kinsburskii wrote:
>>> Once deposited, these pages can't be accessed by Linux anymore and thus
>>> must be preserved in "used" state across kexec, as hypervisor state is
>>> unware of kexec.
>>
>> If Linux can't access them, they're not RAM any more.  I'd much rather
>> remove them from the memory map and move on with life rather than
>> implement a bunch of new ABI that's got to be handed across kernels.
> 
> The motivation of handling kexec (faster?) in a hyper-v domain doesn't
> sound particularly compelling got me for such features. If you inflated
> memory, just don't allow to kexec. It's been broken for years IIUC.

That's a good point.  What prevents deflating before kexec?
