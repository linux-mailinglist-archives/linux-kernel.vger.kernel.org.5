Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34979AFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbjIKVNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbjIKRTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:19:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177331AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694452756; x=1725988756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ovfcmpc5bfHVVimrVWvGkjkz+gms3X4ouh+AmvWcn/k=;
  b=cX8BnQb+E0jn18kqx2kvsQ+CR4zdfRRmAWxR/EBenJnZX4t6wc+5pTIh
   yx7wTuZ3JwQ78h44S3qz/A0dDRpp3mwSe6l7DIJykMIQFhNa46bafRTmL
   VZpc1jVMq0e7Yc4/YpaYIZA727aPeOFnNUfZTeCu9sfXAbIdxXlF+/iaS
   ki+teq1Xx0Mi3ztYZC/K8+AO3ABxpwiSfx0/HDDU+B5RHG9wjs+M+5CPt
   5cuOxpvv0ZH7lgXqxQcUJkU1ERPKYMebWv61XR7E8Ma4AIHhy9J/kuoyQ
   mEec9p2Jp0X+KXX2MYli78G5E3LAvyj/kDPWUI9HmbHOqHwwfBwNunVvC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358436284"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="358436284"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 10:19:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="813472649"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="813472649"
Received: from lbinmo2x-mobl1.gar.corp.intel.com (HELO [10.249.254.187]) ([10.249.254.187])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 10:19:12 -0700
Message-ID: <0a8799c3-1d4c-8d87-ebca-013f6541fbc4@linux.intel.com>
Date:   Mon, 11 Sep 2023 19:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v3 5/7] drm/gpuvm: add an abstraction for a
 VM / BO combination
Content-Language: en-US
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230909153125.30032-1-dakr@redhat.com>
 <20230909153125.30032-6-dakr@redhat.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <20230909153125.30032-6-dakr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Danilo

On 9/9/23 17:31, Danilo Krummrich wrote:
> This patch adds an abstraction layer between the drm_gpuva mappings of
> a particular drm_gem_object and this GEM object itself. The abstraction
> represents a combination of a drm_gem_object and drm_gpuvm. The
> drm_gem_object holds a list of drm_gpuvm_bo structures (the structure
> representing this abstraction), while each drm_gpuvm_bo contains list of
> mappings of this GEM object.
>
> This has multiple advantages:
>
> 1) We can use the drm_gpuvm_bo structure to attach it to various lists
>     of the drm_gpuvm. This is useful for tracking external and evicted
>     objects per VM, which is introduced in subsequent patches.
>
> 2) Finding mappings of a certain drm_gem_object mapped in a certain
>     drm_gpuvm becomes much cheaper.
>
> 3) Drivers can derive and extend the structure to easily represent
>     driver specific states of a BO for a certain GPUVM.
>
> The idea of this abstraction was taken from amdgpu, hence the credit for
> this idea goes to the developers of amdgpu.
>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Did you consider having the drivers embed the struct drm_gpuvm_bo in 
their own bo definition? I figure that would mean using the gem bo's 
refcounting and providing a helper to call from the driver's bo release. 
Looks like that could potentially save a lot of code? Or is there 
something that won't work with that approach?

Thanks,

Thomas


