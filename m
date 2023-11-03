Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A13F7E03A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377647AbjKCNPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376554AbjKCNPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9511D54
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699017246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JeaDcEiv+OJg0rs4GLDtEP9L7bFfkuejpkBRQMtkogU=;
        b=RV6Y2NS9Zew2F7oDI2WGqAf6pXsBfWgAZF8FEmCg4O6gTFpSIN8pyBTm/ur2Ag+go2bvSo
        53iyGgivQe/j0CDq29QXP6lbRbEiRlXn/kQRQEYxV69rgotPS0fMCWdUXE7Jp7oUbV1lpv
        f17F7AoMPlpn5CPDpRseloM3ja0BXro=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-namQgnXzP46eHX0wco1Jfg-1; Fri, 03 Nov 2023 09:14:05 -0400
X-MC-Unique: namQgnXzP46eHX0wco1Jfg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54061ad6600so1767384a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017244; x=1699622044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeaDcEiv+OJg0rs4GLDtEP9L7bFfkuejpkBRQMtkogU=;
        b=uQfzjZ5mdQ1yhbLOVdjTySAWxuyn2cx98Ifuxw7j5RwKRbrFts2y83VXTQEYG/VrDd
         dY76ur3jHkIYxDD8eGbGZr5eabUxnhdEcFSZUaKOmTHBCoIS5ej7v0UMhsh8GtjUCERA
         hW/xCRIhDW1x90i4AOq6Sugz3avnDTFBtILnU6DiADE8Aq+L9VYU8n36Ui73y8l5QeR3
         g7mcYiPyIQrtO+Fyy7tbnoYXy1as6o91u6gReBR8kJywr71hIJvY9p7wAbxX+ZZuujIY
         QnrZTWg0f7A5bSVjw10i5u8lWdsgLwmdaQNwyL/lGzUOza+p0Pdb8YH0O5B4tWadK+cg
         Lafg==
X-Gm-Message-State: AOJu0YwPGFUzNvurTRWwPOJkCL5VRkJ1f5Z75Nwp9ppt2izWMQYWu4DQ
        G+0xd5VlV0P3/vRBNUIcqqlsknTZLoxUs2J9JoYG0r0/grON4MbrVvxP4jH5dpvHK/agtOLzUAh
        capczGdczuRVLCVQlfDOJagqt
X-Received: by 2002:a50:aad8:0:b0:543:6444:ef2a with SMTP id r24-20020a50aad8000000b005436444ef2amr7882703edc.32.1699017244398;
        Fri, 03 Nov 2023 06:14:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3lBEphXT3+HJ50//TEhF8drMREBzcuwnqkwelfwZLHV53PXj0681AMylRS6SA/ZFsXHXmIQ==
X-Received: by 2002:a50:aad8:0:b0:543:6444:ef2a with SMTP id r24-20020a50aad8000000b005436444ef2amr7882683edc.32.1699017244056;
        Fri, 03 Nov 2023 06:14:04 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id h15-20020a056402094f00b0053116e45317sm944419edz.44.2023.11.03.06.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:14:03 -0700 (PDT)
Date:   Fri, 3 Nov 2023 14:14:01 +0100
From:   Danilo Krummrich <dakr@redhat.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        faith@gfxstrand.net, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v8 09/12] drm/gpuvm: reference count
 drm_gpuvm structures
Message-ID: <ZUTyGTxcH7WlHKsv@pollux>
References: <20231101233113.8059-1-dakr@redhat.com>
 <20231101233113.8059-10-dakr@redhat.com>
 <be93d9ef-3d3e-4262-a280-d2922b983ca1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be93d9ef-3d3e-4262-a280-d2922b983ca1@amd.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 08:18:35AM +0100, Christian König wrote:
> Am 02.11.23 um 00:31 schrieb Danilo Krummrich:
> > Implement reference counting for struct drm_gpuvm.
> 
> From the design point of view what is that good for?

It was discussed in this thread [1].

Essentially, the idea is to make sure that vm_bo->vm is always valid without the
driver having the need to take extra care. It also ensures that GPUVM can't be
freed with mappings still held.

> 
> Background is that the most common use case I see is that this object is
> embedded into something else and a reference count is then not really a good
> idea.

Do you have a specific use-case in mind where this would interfere?

> 
> Thanks,
> Christian.

[1] https://lore.kernel.org/dri-devel/6fa058a4-20d3-44b9-af58-755cfb375d75@redhat.com/

> 
> > 
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >   drivers/gpu/drm/drm_gpuvm.c            | 44 +++++++++++++++++++-------
> >   drivers/gpu/drm/nouveau/nouveau_uvmm.c | 20 +++++++++---
> >   include/drm/drm_gpuvm.h                | 31 +++++++++++++++++-
> >   3 files changed, 78 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> > index 53e2c406fb04..6a88eafc5229 100644
> > --- a/drivers/gpu/drm/drm_gpuvm.c
> > +++ b/drivers/gpu/drm/drm_gpuvm.c
> > @@ -746,6 +746,8 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
> >   	gpuvm->rb.tree = RB_ROOT_CACHED;
> >   	INIT_LIST_HEAD(&gpuvm->rb.list);
> > +	kref_init(&gpuvm->kref);
> > +
> >   	gpuvm->name = name ? name : "unknown";
> >   	gpuvm->flags = flags;
> >   	gpuvm->ops = ops;
> > @@ -770,15 +772,8 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
> >   }
> >   EXPORT_SYMBOL_GPL(drm_gpuvm_init);
> > -/**
> > - * drm_gpuvm_destroy() - cleanup a &drm_gpuvm
> > - * @gpuvm: pointer to the &drm_gpuvm to clean up
> > - *
> > - * Note that it is a bug to call this function on a manager that still
> > - * holds GPU VA mappings.
> > - */
> > -void
> > -drm_gpuvm_destroy(struct drm_gpuvm *gpuvm)
> > +static void
> > +drm_gpuvm_fini(struct drm_gpuvm *gpuvm)
> >   {
> >   	gpuvm->name = NULL;
> > @@ -790,7 +785,33 @@ drm_gpuvm_destroy(struct drm_gpuvm *gpuvm)
> >   	drm_gem_object_put(gpuvm->r_obj);
> >   }
> > -EXPORT_SYMBOL_GPL(drm_gpuvm_destroy);
> > +
> > +static void
> > +drm_gpuvm_free(struct kref *kref)
> > +{
> > +	struct drm_gpuvm *gpuvm = container_of(kref, struct drm_gpuvm, kref);
> > +
> > +	if (drm_WARN_ON(gpuvm->drm, !gpuvm->ops->vm_free))
> > +		return;
> > +
> > +	drm_gpuvm_fini(gpuvm);
> > +
> > +	gpuvm->ops->vm_free(gpuvm);
> > +}
> > +
> > +/**
> > + * drm_gpuvm_bo_put() - drop a struct drm_gpuvm reference
> > + * @gpuvm: the &drm_gpuvm to release the reference of
> > + *
> > + * This releases a reference to @gpuvm.
> > + */
> > +void
> > +drm_gpuvm_put(struct drm_gpuvm *gpuvm)
> > +{
> > +	if (gpuvm)
> > +		kref_put(&gpuvm->kref, drm_gpuvm_free);
> > +}
> > +EXPORT_SYMBOL_GPL(drm_gpuvm_put);
> >   static int
> >   __drm_gpuva_insert(struct drm_gpuvm *gpuvm,
> > @@ -843,7 +864,7 @@ drm_gpuva_insert(struct drm_gpuvm *gpuvm,
> >   	if (unlikely(!drm_gpuvm_range_valid(gpuvm, addr, range)))
> >   		return -EINVAL;
> > -	return __drm_gpuva_insert(gpuvm, va);
> > +	return __drm_gpuva_insert(drm_gpuvm_get(gpuvm), va);
> >   }
> >   EXPORT_SYMBOL_GPL(drm_gpuva_insert);
> > @@ -876,6 +897,7 @@ drm_gpuva_remove(struct drm_gpuva *va)
> >   	}
> >   	__drm_gpuva_remove(va);
> > +	drm_gpuvm_put(va->vm);
> >   }
> >   EXPORT_SYMBOL_GPL(drm_gpuva_remove);
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > index 54be12c1272f..cb2f06565c46 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > @@ -1780,6 +1780,18 @@ nouveau_uvmm_bo_unmap_all(struct nouveau_bo *nvbo)
> >   	}
> >   }
> > +static void
> > +nouveau_uvmm_free(struct drm_gpuvm *gpuvm)
> > +{
> > +	struct nouveau_uvmm *uvmm = uvmm_from_gpuvm(gpuvm);
> > +
> > +	kfree(uvmm);
> > +}
> > +
> > +static const struct drm_gpuvm_ops gpuvm_ops = {
> > +	.vm_free = nouveau_uvmm_free,
> > +};
> > +
> >   int
> >   nouveau_uvmm_ioctl_vm_init(struct drm_device *dev,
> >   			   void *data,
> > @@ -1830,7 +1842,7 @@ nouveau_uvmm_ioctl_vm_init(struct drm_device *dev,
> >   		       NOUVEAU_VA_SPACE_END,
> >   		       init->kernel_managed_addr,
> >   		       init->kernel_managed_size,
> > -		       NULL);
> > +		       &gpuvm_ops);
> >   	/* GPUVM takes care from here on. */
> >   	drm_gem_object_put(r_obj);
> > @@ -1849,8 +1861,7 @@ nouveau_uvmm_ioctl_vm_init(struct drm_device *dev,
> >   	return 0;
> >   out_gpuvm_fini:
> > -	drm_gpuvm_destroy(&uvmm->base);
> > -	kfree(uvmm);
> > +	drm_gpuvm_put(&uvmm->base);
> >   out_unlock:
> >   	mutex_unlock(&cli->mutex);
> >   	return ret;
> > @@ -1902,7 +1913,6 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
> >   	mutex_lock(&cli->mutex);
> >   	nouveau_vmm_fini(&uvmm->vmm);
> > -	drm_gpuvm_destroy(&uvmm->base);
> > -	kfree(uvmm);
> > +	drm_gpuvm_put(&uvmm->base);
> >   	mutex_unlock(&cli->mutex);
> >   }
> > diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
> > index 0c2e24155a93..4e6e1fd3485a 100644
> > --- a/include/drm/drm_gpuvm.h
> > +++ b/include/drm/drm_gpuvm.h
> > @@ -247,6 +247,11 @@ struct drm_gpuvm {
> >   		struct list_head list;
> >   	} rb;
> > +	/**
> > +	 * @kref: reference count of this object
> > +	 */
> > +	struct kref kref;
> > +
> >   	/**
> >   	 * @kernel_alloc_node:
> >   	 *
> > @@ -273,7 +278,23 @@ void drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
> >   		    u64 start_offset, u64 range,
> >   		    u64 reserve_offset, u64 reserve_range,
> >   		    const struct drm_gpuvm_ops *ops);
> > -void drm_gpuvm_destroy(struct drm_gpuvm *gpuvm);
> > +
> > +/**
> > + * drm_gpuvm_get() - acquire a struct drm_gpuvm reference
> > + * @gpuvm: the &drm_gpuvm to acquire the reference of
> > + *
> > + * This function acquires an additional reference to @gpuvm. It is illegal to
> > + * call this without already holding a reference. No locks required.
> > + */
> > +static inline struct drm_gpuvm *
> > +drm_gpuvm_get(struct drm_gpuvm *gpuvm)
> > +{
> > +	kref_get(&gpuvm->kref);
> > +
> > +	return gpuvm;
> > +}
> > +
> > +void drm_gpuvm_put(struct drm_gpuvm *gpuvm);
> >   bool drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm, u64 addr, u64 range);
> >   bool drm_gpuvm_interval_empty(struct drm_gpuvm *gpuvm, u64 addr, u64 range);
> > @@ -673,6 +694,14 @@ static inline void drm_gpuva_init_from_op(struct drm_gpuva *va,
> >    * operations to drivers.
> >    */
> >   struct drm_gpuvm_ops {
> > +	/**
> > +	 * @vm_free: called when the last reference of a struct drm_gpuvm is
> > +	 * dropped
> > +	 *
> > +	 * This callback is mandatory.
> > +	 */
> > +	void (*vm_free)(struct drm_gpuvm *gpuvm);
> > +
> >   	/**
> >   	 * @op_alloc: called when the &drm_gpuvm allocates
> >   	 * a struct drm_gpuva_op
> 

