Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68EC79ACE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347512AbjIKVYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbjIKMAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:00:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFBCCDD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:00:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1E1A966072FC;
        Mon, 11 Sep 2023 13:00:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694433638;
        bh=uUUWwdEXUnbUt4WJ5vJ0ZVeiLzvKE3X94A9kyzMwdDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kdSWcuhPucKf1SWwF9Xd2KzH6nORnBcR+JeKOFlnueJL0/XPGegRPuH0+zKelQYBC
         zjlAIftDpHO1rgMkPN4NV4vjr/QldwIUc7L+FLHh80krFHaJJtePwoPkFoUVK3/dq1
         EFzVIUyekJWVJI8zW0DInYnPBX70y/WTnoFBiMYiZkTPfCqkPZ9OANMSzKfsSXect5
         hjJ61dtkBz/PqlaMsnLWsygSA6NepTxVi7MK0H1ACUFZrG54UcwjwJX5JTfUn8BAML
         kfCiYeX4Ezf6GXSEZ4fzi82lHATEOACKmqBrqFN48PlLq0dkSPmMxZhfh0TN/BYh7A
         zZRSx5lE7lA1A==
Date:   Mon, 11 Sep 2023 14:00:35 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3 4/7] drm/gpuvm: common dma-resv per
 struct drm_gpuvm
Message-ID: <20230911140035.06159577@collabora.com>
In-Reply-To: <20230909153125.30032-5-dakr@redhat.com>
References: <20230909153125.30032-1-dakr@redhat.com>
        <20230909153125.30032-5-dakr@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Sep 2023 17:31:11 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> @@ -240,9 +240,22 @@ struct drm_gpuvm {
>  	 * @ops: &drm_gpuvm_ops providing the split/merge steps to drivers
>  	 */
>  	const struct drm_gpuvm_ops *ops;
> +
> +	/**
> +	 * @d_obj: Dummy GEM object; used internally to pass the GPU VMs
> +	 * dma-resv to &drm_exec.
> +	 */
> +	struct drm_gem_object d_obj;
> +
> +	/**
> +	 * @resv: the &dma_resv for &drm_gem_objects mapped in this GPU VA
> +	 * space
> +	 */
> +	struct dma_resv *resv;

Hm, I'd be tempted to drop this field and add a drm_gpuvm_resv() helper
returning vm->d_obj.resv;

>  };
