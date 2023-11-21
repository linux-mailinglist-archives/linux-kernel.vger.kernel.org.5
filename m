Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005BC7F27BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjKUImH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKUImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:42:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB77AC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700556122; x=1732092122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0MNGK9YZBkizi/IsudxxJh25bd58QtBgiGdEbXBMtCg=;
  b=J+RilHspHi/6OALf1d4LlTmMieueaIwdotdPRCYG67Eq/kYQuJb0MT8o
   e0n0xZRrJkGYb+vLQj5o9ShpMFGlcbD7bdHalhJiRz/tQNX99tZuc2slc
   ExDRwJcWnM2dddfITT6XJLUBQIJnrcTg+LXLjrM96QmXJR24UM89UXIqE
   DMjvnFv0tkm/C6JTAtriSkuw5SXf7RYU1tpKeWDSPGQrQDzCKFNQVYPGW
   kcxAHwnYym8G/lBHlgoDopVPdzQvYgeDJlA3x4wYRm0sU4IilSA9ZxDsU
   9rqabHwyO765RHGxPbxPvote/edZuZekUb85sm1yA+dI95mVyy0s6+n7/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4919760"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4919760"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:42:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="770192525"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="770192525"
Received: from hasifnax-mobl1.gar.corp.intel.com (HELO [10.249.254.143]) ([10.249.254.143])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:41:57 -0800
Message-ID: <a0e64d21-799f-bb0d-c2e5-d4daadc13488@linux.intel.com>
Date:   Tue, 21 Nov 2023 09:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] Documentation/gpu: VM_BIND locking document
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     intel-xe@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Oak Zeng <oak.zeng@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Francois Dugast <francois.dugast@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231115124937.6740-1-thomas.hellstrom@linux.intel.com>
 <20231116104851.114bdb08@collabora.com>
 <0850281b667c4b88163dab60737dbc945ad742fd.camel@linux.intel.com>
 <20231116142707.044aeec2@collabora.com>
 <656d5f890de7ba3af05616122a9bd399badd35bc.camel@linux.intel.com>
 <20231116154708.148ce241@collabora.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20231116154708.148ce241@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris

On 11/16/23 15:47, Boris Brezillon wrote:
> On Thu, 16 Nov 2023 14:53:50 +0100
> Thomas Hellström <thomas.hellstrom@linux.intel.com> wrote:
>
>> On Thu, 2023-11-16 at 14:27 +0100, Boris Brezillon wrote:
>>> On Thu, 16 Nov 2023 12:48:45 +0100
>>> Thomas Hellström <thomas.hellstrom@linux.intel.com> wrote:
>>>    
>>>> Hi, Boris,
>>>>
>>>> Thanks for reviewing. Some comments below:
>>>>
I'm going to send out an updated version today with I think all of 
Danilo's comments and must of yours addressed. While I added more 
references to GPUVM, mainly as code examples and explanations, I've 
intentionally left out the "This is a driver lock and this is a gpvum 
lock distinction", The reason is twofold. First I think that when we get 
userptr into gpvum, gpuvm needs to be aware of most if not all locks. 
Second, since this document is an implementation guideline and gpuvm is 
an implementation it makes more sense to me to add pointers from the 
GPUVM documentation to the VM_BIND locking guideline, and that could be 
a task to be looked at after merging this together with implementing the 
userptr stuff. The most important thing at this point is that the 
document doesn't conflict in any way with the gpuvm implementation, and 
I've fixed those parts where I missed the separate lock protecting the 
GEM object's vm_bo list that you pointed out.

I strongly think this is the right way to go but if you disagree to the 
point where you're not willing to provide an ack or R-B, let me know and 
we can look at adding what's missing.

Thanks,

Thomas


