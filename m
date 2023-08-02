Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62E176C8F4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjHBJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjHBJGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:06:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E157A273C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:06:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 408F16607150;
        Wed,  2 Aug 2023 10:06:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690967189;
        bh=w3kzvQfCfw77/XpFJLMzgdydPMR8fw6a28RJHdL3lf8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SIZF+7Zr4BVlRezCVuZZcRKhPJ0SsfrlIciW6jRo7igydOEP509Gge8L1X6jwq5Zd
         kdfNIbEq45RBwEyAa6TwchSSlpWG/soggncVuBgglFMze8j3jL4X+2JMhhZr4XHlh0
         zGRcHq2LDLlzr7a4HDTIG/nsKe+iCBJbTY7QoJhMZfHQCAKhRaluk6GMmhyaCVOc1W
         FnzCybMlRiLVVBqRWAAyNNZkFcaaAqo7kOxy48yVEkAk40N5T3z1xaOdmddiEgJj5P
         rz+t1elHPFVHQxA8dsMW5NIi1aGJabB1O2kMe1wkeMr+NZEMvAfwV2ez7yzNQ5dEjb
         tXFOO3SAR0hOg==
Date:   Wed, 2 Aug 2023 11:06:26 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v14 02/12] drm/shmem-helper: Add pages_pin_count field
Message-ID: <20230802110626.5035c228@collabora.com>
In-Reply-To: <156f9560-b219-7459-d06a-5a8fe07f24cf@redhat.com>
References: <20230722234746.205949-1-dmitry.osipenko@collabora.com>
        <20230722234746.205949-3-dmitry.osipenko@collabora.com>
        <20230725092709.51356f39@collabora.com>
        <20230725103234.0c8923f1@collabora.com>
        <4c5fa735-9bfd-f92a-8deb-888c7368f89e@collabora.com>
        <20230731153551.7365daa4@collabora.com>
        <156f9560-b219-7459-d06a-5a8fe07f24cf@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 04:31:52 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> On 7/31/23 15:35, Boris Brezillon wrote:
> > +Danilo, to confirm my understanding of the gpuva remap operation is
> > correct.  
> 
> Your understanding is correct.
> 
> Unfortunately, re-mapping things has such implications.
> 
> I'm currently working on tracking external GEM objects in the GPUVA 
> manager, where, ideally, you'd want to add the extobj to the VM when the 
> first mapping being backed by this GEM is created and removed when the 
> last mapping being backed by this GEM is removed. Hence, extobjs need to 
> be ref-counted based on how many mappings they back.

Uh, right. I went for a much simpler (but also less efficient) approach
where I basically track things at the mapping level (my panthor_vma
object, which inherits from drm_gpuva, has a list node so it can be
inserted in a shared_bos list tracked at the VM level), instead of the
GEM level. So we'd basically be trying to acquire resv locks multiple
times and reserving multiple slots if the same shared GEM is mapped
multiple times. With the IGNORE_DUPLICATES flag passed to drm_exec,
that works, but it might not be ideal if we expect shared BOs to be
mapped multiple times in the same VM.

> 
> However, when re-mapping such a mapping, the reference counter might 
> drop to 0 temporarily and the slot of the data structure tracking the 
> extobj is cleaned up and needs to be re-allocated. Surely, we could just 
> increase the reference count while re-mapping or for the whole 
> transaction (job), but this would make the API kinda bulky.

With things happening in the dma-signaling path, we'd need to
pre-allocate this shared-bo container object anyway, because we can't
assume there will be one available by the time we get to run the VM
operation. So I think it's safe to assume that, even if the unmap part
of the remap operation drops the last ref of this container object, when
you get to map the same BO again, you'll have another container to play
with. It's just a matter of pre-allocating one more thing when
bo_is_shared==true && op==map, I think.
