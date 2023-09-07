Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827A3797919
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241740AbjIGRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbjIGRBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:01:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2982134
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:00:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF35066072E5;
        Thu,  7 Sep 2023 09:42:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694076175;
        bh=ujSXbKznRz3tzlgJmYQ+xHY46tCYhDlj4ODfbR8E2bw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MWueq0NpKkebmbf8XyKKAOD0+jqkv9PQUwXtXkeVMK3kAvVyBiJv+WLKtAlBALeD0
         rn+4NBcyNB0JeNquDh0PcRxmbje+gFeu9uKPdm92fhffTg4eI8W+6MW15FW/IlZ3ef
         ut8b0oEX47GpCpbhPhLehVQfHdjt54/n9b5pdGzHzgdVnS1//x5rKYn37dRZZJigFR
         icCeavf0uIFoMi5u9GNJo1DaOoDB1PY/as+dJrOu9FKC660JRmoElT6A3wn5tku2VA
         XdqWMhc/AymK1gKrVvDcCDUXd2xi5K4uIe6oiLsbN9M3/gAJHXD+zm8Zh5bUb7VsIJ
         +gvmc04Ka0F8A==
Date:   Thu, 7 Sep 2023 10:42:52 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v2 5/7] drm/gpuvm: add an abstraction for
 a VM / BO combination
Message-ID: <20230907104252.4e15acb9@collabora.com>
In-Reply-To: <20230906214723.4393-6-dakr@redhat.com>
References: <20230906214723.4393-1-dakr@redhat.com>
        <20230906214723.4393-6-dakr@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Sep 2023 23:47:13 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> +void drm_gpuvm_bo_destroy(struct kref *kref);

I usually keep kref's release functions private so people are not
tempted to use them.

> +
> +/**
> + * drm_gpuvm_bo_get() - acquire a struct drm_gpuvm_bo reference
> + * @vm_bo: the &drm_gpuvm_bo to acquire the reference of
> + *
> + * This function acquires an additional reference to @vm_bo. It is illegal to
> + * call this without already holding a reference. No locks required.
> + */
> +static inline struct drm_gpuvm_bo *
> +drm_gpuvm_bo_get(struct drm_gpuvm_bo *vm_bo)
> +{
> +	kref_get(&vm_bo->kref);
> +	return vm_bo;
> +}
> +
> +/**
> + * drm_gpuvm_bo_put() - drop a struct drm_gpuvm_bo reference
> + * @vm_bo: the &drm_gpuvm_bo to release the reference of
> + *
> + * This releases a reference to @vm_bo.
> + */
> +static inline void
> +drm_gpuvm_bo_put(struct drm_gpuvm_bo *vm_bo)
> +{
> +	kref_put(&vm_bo->kref, drm_gpuvm_bo_destroy);

nit: can we have

	if (vm_bo)
		kref_put(&vm_bo->kref, drm_gpuvm_bo_destroy);

so we don't have to bother testing the vm_bo value in the error/cleanup
paths?

> +}
> +
