Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD027FE05D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjK2Tgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjK2Tgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:36:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45813A2;
        Wed, 29 Nov 2023 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701286604; x=1732822604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3U8g+x9WRQnamBgjwnIAVyDf/uE18Yr4h3Vja7ObTeE=;
  b=RtdYHfnHSRJnwq/oYP4AoDYScTaataQ/j3o4+VdrmBB/oGfgZYoJiHd4
   eScxtpxFDT42sRoAgl955Wq74J5IB4URwsgFzvXFBjg5wRhL/Sx1ALEpo
   s75/ATxvNJbp83iCL/xufQyFBtVAQ3KhsXJWK6o6yk0hvkjSnQbneCF8M
   tfj0adB+PR1g4scXFAzekUkoAszflN3A8SfQFHRLGvXAEfLjM1s7rKYMl
   YK1HQHzjISiWM6XmKZdlwyzDt7rhSkeQEQ0UZBDSBBYxwBjwoV1ol7ZE2
   URfOlrEYQTQcwRoOfMHi16gVPR6uReepHJncQxvmLVza20FzHJOjDvK5d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="459709249"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="459709249"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 11:36:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1100646497"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1100646497"
Received: from ktonsber-mobl1.ger.corp.intel.com (HELO [10.249.254.194]) ([10.249.254.194])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 11:36:40 -0800
Message-ID: <720d1b54-0898-1fbc-b1a0-338782e0e485@linux.intel.com>
Date:   Wed, 29 Nov 2023 20:36:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6] Documentation/gpu: VM_BIND locking document
To:     John Hubbard <jhubbard@nvidia.com>, intel-xe@lists.freedesktop.org
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Oak Zeng <oak.zeng@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Francois Dugast <francois.dugast@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231129090637.2629-1-thomas.hellstrom@linux.intel.com>
 <2b26b696-60a3-4afa-b14e-7aa93c939130@nvidia.com>
Content-Language: en-US
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
In-Reply-To: <2b26b696-60a3-4afa-b14e-7aa93c939130@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/29/23 20:20, John Hubbard wrote:
> On 11/29/23 01:06, Thomas Hellström wrote:
>> Add the first version of the VM_BIND locking document which is
>> intended to be part of the xe driver upstreaming agreement.
>>
>> The document describes and discuss the locking used during exec-
>> functions, evicton and for userptr gpu-vmas. Intention is to be using 
>> the
>> same nomenclature as the drm-vm-bind-async.rst.
>>
>
> Hi Thomas,
>
> As requested, for the pin_user_pages() aspects (the MMU notifier
> registration case), please feel free to add:
>
> Acked-by: John Hubbard <jhubbard@nvidia.com
>
> thanks,

Hi, John,

Thanks!
/Thomas


