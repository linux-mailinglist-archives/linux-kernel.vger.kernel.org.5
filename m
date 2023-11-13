Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F25D7E9796
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 09:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjKMIZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 03:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKMIZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 03:25:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C314710F0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 00:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699863899; x=1731399899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kGU4JUG2Lr96HBJbf/kazk1tGm2ODqpAeWA0HE3tUjU=;
  b=ljVEd/kC4DL5WUKZBAXOgaBsu+C9lFdtqE4+EqXpNgQUeyL39Njy1XbE
   Xxhj8A+h75rN/Bxce4d9MDC9RnIh+0nT2ejCgHyGe9tZwbJNpgXbPRDCg
   9F4RROofJcDjcwl1EK5HGG8Xbcuxvl8hkCDWzyKhtKwwZHJvdTINUhSVR
   Q2P/IvNK1dJ15ad6m2dceK2dnw7xWNL4ylIymtTW01WMq24I5wlKcnti9
   JL4knmlsWKLFk18oEvOGciPat+m+rWTu9maGsKexrX78BghFoYkjsOunX
   fWgFsqLLXypoTMIG8hP1WhI84pxf4c9QVu4wNHwbikE2Z5qo0U90UVwI8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="375421979"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375421979"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:24:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="740700336"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="740700336"
Received: from rdegreef-mobl2.ger.corp.intel.com (HELO [10.251.217.208]) ([10.251.217.208])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:24:55 -0800
Message-ID: <f229d1ed-b71e-434a-acca-06ee81826260@linux.intel.com>
Date:   Mon, 13 Nov 2023 09:24:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver: gpu: Fixing warning directly dereferencing a rcu
 pointer
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     nouveau@lists.freedesktop.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231113081040.2947143-1-singhabhinav9051571833@gmail.com>
Content-Language: en-US
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20231113081040.2947143-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Den 2023-11-13 kl. 09:10, skrev Abhinav Singh:
> This patch fixes a sparse warning with this message
> "warning:dereference of noderef expression". In this context it means we
> are dereferencing a __rcu tagged pointer directly.
>
> We should not be directly dereferencing a rcu pointer, rather we should
> be using rcu helper function rcu_dereferece() inside rcu read critical
> section to get a normal pointer which can be dereferenced.
>
> I tested with qemu with this command
> qemu-system-x86_64 \
> 	-m 2G \
> 	-smp 2 \
> 	-kernel bzImage \
> 	-append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
> 	-drive file=bullseye.img,format=raw \
> 	-net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
> 	-net nic,model=e1000 \
> 	-enable-kvm \
> 	-nographic \
> 	-pidfile vm.pid \
> 	2>&1 | tee vm.log
> with lockdep enabled.
>
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
>   drivers/gpu/drm/nouveau/nv04_fence.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nv04_fence.c b/drivers/gpu/drm/nouveau/nv04_fence.c
> index 5b71a5a5cd85..e62bad1ac720 100644
> --- a/drivers/gpu/drm/nouveau/nv04_fence.c
> +++ b/drivers/gpu/drm/nouveau/nv04_fence.c
> @@ -39,7 +39,9 @@ struct nv04_fence_priv {
>   static int
>   nv04_fence_emit(struct nouveau_fence *fence)
>   {
> -	struct nvif_push *push = fence->channel->chan.push;
> +	rcu_read_lock();
> +	struct nvif_push *push = rcu_dereference(fence->channel)->chan.push;
> +	rcu_read_unlock();
>   	int ret = PUSH_WAIT(push, 2);
>   	if (ret == 0) {
>   		PUSH_NVSQ(push, NV_SW, 0x0150, fence->base.seqno);

I'm not an expert in nouveau fence channel lifetime, but I'm pretty sure 
this should probably be a rcu_dereference_protected, since a fence 
likely can't lose its channel before its command to signal is submitted.

But in case it's not, I would at least advise to check for 
fence->channel lifetime before submitting a patch like this. At least 
the original code warned about it not being 100% correct.

Cheers,

~Maarten

