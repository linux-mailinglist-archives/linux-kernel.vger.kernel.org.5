Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5337377447C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjHHSVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjHHSVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:21:09 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A2C17012E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:30:55 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RKvbt03tMz9sTC;
        Tue,  8 Aug 2023 15:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1691502378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJaPJCb57rFcTjifY7HDh29RsuKKFz2of9slLTwxsBc=;
        b=H9pw2RY1RsE8VJrHAg8s6wkROee8RInItzUQQKlJrXOEKL27ySn6uRcgAmMXpMAmbAFekk
        JcZqzY8sF/VIfy0jyU2BLM953MmfvkbyTElVh/+O2+5AqJKjQs1/TeqbH50x83bTGIBIgJ
        Rzjmk2Z2mQLRATC/0MIAYNNwvfkOz0gGnDy7GLHsmxGbA+p/DtWp0tLHpggFuDjOqlO7Zj
        E8jtAXBuDetiQwVlhGdUkTKPy95a4i8o8u7nadhesxaGVwgqkUhh+EU3fZXsPnj8SHVnHH
        X9KbgAuOiEu/zDDaiNUGTElg9PjTYfD97StkO9OM4Y7eMoo8Dwl82uY5uWWZCg==
Message-ID: <dd2ceacc-f59b-9c3c-e4ce-30b3bbd6939b@mailbox.org>
Date:   Tue, 8 Aug 2023 15:46:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 03/17] drm/imagination/uapi: Add PowerVR driver UAPI
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     matthew.brost@intel.com, luben.tuikov@amd.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, mripard@kernel.org, afd@ti.com,
        boris.brezillon@collabora.com, dakr@redhat.com,
        donald.robson@imgtec.com, hns@goldelico.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com,
        dri-devel@lists.freedesktop.org
References: <20230714142543.111625-1-sarah.walker@imgtec.com>
Content-Language: en-CA
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20230714142543.111625-1-sarah.walker@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: c3pcynk7cpw94jyg1qwudy3osh1qy5xp
X-MBO-RS-ID: ec8b53fa39038fb6f46
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 16:25, Sarah Walker wrote:
> 
> +/**
> + * DOC: PowerVR IOCTL CREATE_BO interface
> + */
> +
> +/**
> + * DOC: Flags for CREATE_BO
> + *
> + * The &struct drm_pvr_ioctl_create_bo_args.flags field is 64 bits wide and consists
> + * of three groups of flags: creation, device mapping and CPU mapping.
> + *
> + * We use "device" to refer to the GPU here because of the ambiguity between
> + * CPU and GPU in some fonts.
> + *
> + * Creation options
> + *    These use the prefix ``DRM_PVR_BO_CREATE_``.
> + *
> + *    :ZEROED: Require the allocated buffer to be zeroed before returning. Note
> + *      that this is an active operation, and is never zero cost. Unless it is
> + *      explicitly required, this option should not be set.

Making this optional is kind of problematic from a security standpoint (information leak, at least if the memory was previously used by a different process). See e.g. the discussion starting at https://gitlab.freedesktop.org/mesa/mesa/-/issues/9189#note_1972986 .

AFAICT the approach I suggested there (Clear freed memory in the background, and make it available for allocation again only once the clear has finished) isn't really possible with gem_shmem in its current state though. There seems to be ongoing work to do something like that for __GFP_ZERO in general, maybe gem_shmem could take advantage of that when it lands. I'm afraid this series can't depend on that though.


> +/**
> + * DOC: PowerVR IOCTL VM_MAP and VM_UNMAP interfaces
> + *
> + * The VM UAPI allows userspace to create buffer object mappings in GPU virtual address space.
> + *
> + * The client is responsible for managing GPU address space. It should allocate mappings within
> + * the heaps returned by %DRM_PVR_DEV_QUERY_HEAP_INFO_GET.
> + *
> + * %DRM_IOCTL_PVR_VM_MAP creates a new mapping. The client provides the target virtual address for
> + * the mapping. Size and offset within the mapped buffer object can be specified, so the client can
> + * partially map a buffer.
> + *
> + * %DRM_IOCTL_PVR_VM_UNMAP removes a mapping. The entire mapping will be removed from GPU address
> + * space. For this reason only the start address is provided by the client.
> + */

FWIW, the amdgpu driver uses a single ioctl for VM map & unmap (plus two additional operations for partial residency). Maybe this would make sense for the PowerVR driver as well, in particular if it might support partial residency in the future.

(amdgpu also uses similar multiplexer ioctls for other things such as context create/destroy/...)

Just an idea, feel free to ignore.


> +/**
> + * DOC: Flags for SUBMIT_JOB ioctl geometry command.
> + *
> + * .. c:macro:: DRM_PVR_SUBMIT_JOB_GEOM_CMD_FIRST
> + *
> + *    Indicates if this the first command to be issued for a render.
> + *
> + * .. c:macro:: DRM_PVR_SUBMIT_JOB_GEOM_CMD_LAST

Does user space really need to pass in the FIRST/LAST flags, can't the kernel driver determine this implicitly? What happens if user space sets these incorrectly?


> + * .. c:macro:: DRM_PVR_SUBMIT_JOB_FRAG_CMD_PREVENT_CDM_OVERLAP
> + *
> + *    Disallow compute overlapped with this render.

Does this affect only compute from the same context, or also from other contexts?

(Similar question for DRM_PVR_SUBMIT_JOB_COMPUTE_CMD_PREVENT_ALL_OVERLAP)


P.S. I mostly just skimmed the other patches of the series, but my impression is that the patches and code are cleanly structured and well-documented.

-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

