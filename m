Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF33B79CF51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjILLH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbjILLHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 385E82120
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694516729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjN147t1puwit15Ff+ftbqM2+7keP1h3ReorQBhwNxI=;
        b=Fz1Op1P1AQFH/BAm5jN0Z8O+diwlHKq8UQmlt6y+rRp2vPOmih9t/ToScdZVcRp5ZOvBtc
        uE9wWH8tzLCDtemHAUC78h1wcp2JxiPJobsh1lSxymhjcZN+aHmQDIX+/1m4I4b1CcGrv1
        iD5mi+h+ssbVIBp/i/GpwHqR1lFVb8s=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-zHcMc7h6P4SG9YrZxB3nyw-1; Tue, 12 Sep 2023 07:05:28 -0400
X-MC-Unique: zHcMc7h6P4SG9YrZxB3nyw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2bd24fcd68cso61316061fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694516727; x=1695121527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjN147t1puwit15Ff+ftbqM2+7keP1h3ReorQBhwNxI=;
        b=f03D40gjW/mkmd4WQrwZaRMagVBnxMSrUEChhP6B1gMp9OTywDegKVJ+4TJU0S2Xhv
         SO2sMxo9pg/G/SLpJqz7X28QoclSr9xf9MFNQueijh/yNOdhyqV+RHhDIL0xDDjcH03o
         AZSTNVZHZr+QYxF2xKwyyrwwa4B3b19LUoUL/fW2KN+EGJ3AyrEsz8To8iyTDISTbPn3
         qTa07hYUzvy44hCsfuOairx/3o/XPtE85eCDBX5gfYNkE5dRxCEMXjDJ1f3psxAscaxc
         8wI0W7jbIdcqL7xxVtXQHRSgy0Yaj3LSitme3tCJiFgkPUzC7udHuf/8X/R50X/F+g0k
         jOFw==
X-Gm-Message-State: AOJu0Yy6Mpny3Wnnyqnotvj1LYcob9A0JwpbuaEB+CpdMgsrrWGutJKm
        IiuBB2s3OIWIRIgzVJkUzEtTDM0/Afiw8KrZYcVcF5TG3A7TWNOQE5c+4BYDh0XFLSc+/SO4DvC
        wXVbJ4Kf56T4QcK1WQLPHZH4B
X-Received: by 2002:a2e:9b16:0:b0:2b6:ee99:fffc with SMTP id u22-20020a2e9b16000000b002b6ee99fffcmr10114958lji.36.1694516727160;
        Tue, 12 Sep 2023 04:05:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8MEhZDJdIns9gYZ0pMp3lHS7cgXicYDAaeUARQr/0BIUqNp7Q7wr+3KP9omoQVmi4sA1z5g==
X-Received: by 2002:a2e:9b16:0:b0:2b6:ee99:fffc with SMTP id u22-20020a2e9b16000000b002b6ee99fffcmr10114934lji.36.1694516726699;
        Tue, 12 Sep 2023 04:05:26 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id d10-20020a170906344a00b00977cad140a8sm6650021ejb.218.2023.09.12.04.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 04:05:26 -0700 (PDT)
Date:   Tue, 12 Sep 2023 13:05:23 +0200
From:   Danilo Krummrich <dakr@redhat.com>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        sarah.walker@imgtec.com, donald.robson@imgtec.com,
        boris.brezillon@collabora.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next v3 5/7] drm/gpuvm: add an abstraction for a
 VM / BO combination
Message-ID: <ZQBF80DkaB8Y/StN@pollux>
References: <20230909153125.30032-1-dakr@redhat.com>
 <20230909153125.30032-6-dakr@redhat.com>
 <0a8799c3-1d4c-8d87-ebca-013f6541fbc4@linux.intel.com>
 <06bbb49d-974f-e3bb-f844-1509313066cc@redhat.com>
 <05b06e5d-03aa-14f4-46b1-6057c4437043@linux.intel.com>
 <ZQA4PkxEKsuukwOW@pollux>
 <72461288-4248-9dd9-4417-aaa72b864805@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72461288-4248-9dd9-4417-aaa72b864805@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:33:14PM +0200, Thomas Hellström wrote:
> 
> On 9/12/23 12:06, Danilo Krummrich wrote:
> > On Tue, Sep 12, 2023 at 09:42:44AM +0200, Thomas Hellström wrote:
> > > Hi, Danilo
> > > 
> > > On 9/11/23 19:49, Danilo Krummrich wrote:
> > > > Hi Thomas,
> > > > 
> > > > On 9/11/23 19:19, Thomas Hellström wrote:
> > > > > Hi, Danilo
> > > > > 
> > > > > On 9/9/23 17:31, Danilo Krummrich wrote:
> > > > > > This patch adds an abstraction layer between the drm_gpuva mappings of
> > > > > > a particular drm_gem_object and this GEM object itself. The abstraction
> > > > > > represents a combination of a drm_gem_object and drm_gpuvm. The
> > > > > > drm_gem_object holds a list of drm_gpuvm_bo structures (the structure
> > > > > > representing this abstraction), while each drm_gpuvm_bo contains
> > > > > > list of
> > > > > > mappings of this GEM object.
> > > > > > 
> > > > > > This has multiple advantages:
> > > > > > 
> > > > > > 1) We can use the drm_gpuvm_bo structure to attach it to various lists
> > > > > >      of the drm_gpuvm. This is useful for tracking external and evicted
> > > > > >      objects per VM, which is introduced in subsequent patches.
> > > > > > 
> > > > > > 2) Finding mappings of a certain drm_gem_object mapped in a certain
> > > > > >      drm_gpuvm becomes much cheaper.
> > > > > > 
> > > > > > 3) Drivers can derive and extend the structure to easily represent
> > > > > >      driver specific states of a BO for a certain GPUVM.
> > > > > > 
> > > > > > The idea of this abstraction was taken from amdgpu, hence the
> > > > > > credit for
> > > > > > this idea goes to the developers of amdgpu.
> > > > > > 
> > > > > > Cc: Christian König <christian.koenig@amd.com>
> > > > > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > > > Did you consider having the drivers embed the struct drm_gpuvm_bo in
> > > > > their own bo definition? I figure that would mean using the gem bo's
> > > > > refcounting and providing a helper to call from the driver's bo
> > > > > release. Looks like that could potentially save a lot of code? Or is
> > > > > there something that won't work with that approach?
> > > > There are drm_gpuvm_ops::vm_bo_alloc and drm_gpuvm_ops::vm_bo_free
> > > > callback for drivers to register for that purpose.
> > > > 
> > > > - Danilo
> > > Now after looking a bit deeper, I think actually the question could be
> > > rephrased as, why don't we just use the
> > > struct drm_gem_object::gpuva struct as the drm_gpuvm_bo in the spirit of
> > > keeping things simple? Drivers would then just embed it in their bo subclass
> > > and we'd avoid unnecessary fields in the struct drm_gem_object for drivers
> > > that don't do VM_BIND yet.
> > struct drm_gem_object::gpuva is just a container containing a list in order to
> > (currently) attach drm_gpuva structs to it and with this patch attach
> > drm_gpuvm_bo structs (combination of BO + VM) to it. Doing the above basically
> > means "leave everything as it is, but move the list_head of drm_gpuvs per GEM to
> > the driver specific BO structure". Having a common connection between GEM
> > objects and drm_gpuva structs was one of the goals of the initial GPUVA manager
> > patch series however.
> > 
> > > Sure, this won't be per bo and per vm, but it'd really only make a slight
> > > difference where we have multiple VMAs per bo, where per-vm per-bo state
> > > either needs to be duplicated or attached to a single vma (as in the case of
> > > the external bo list).
> > 
> > Correct, one implication is that we don't get a per VM and BO abstraction, and
> > hence are left with a list of all drm_gpuva structs having the same backing BO,
> > regardless of the VM.
> > 
> > For amdgpu this was always a concern. Now that we want to keep track of external
> > and evicted objects it's going to be a concern for most drivers I guess. Because
> > the only structure we could use for tracking external and evicted objects we are
> > left with (without having a VM_BO abstraction) is struct drm_gpuva. But this
> > structure isn't unique and we need to consider cases where userspace just
> > allocates rather huge BOs and creates tons of mappings from it. Running the full
> > list of drm_gpuva structs (with even the ones from other VMs included) for
> > adding an external or evicted object isn't very efficient. Not to mention that
> > the maintenance when the mapping we've (randomly) picked as an entry for the
> > external/evicted object list is unmapped, but there are still mappings left in
> > the VM with the same backing BO.
> For the evicted object it's not much of an issue; we maintain a list of vmas
> needing rebinding for each VM rather than objects evicted, so there is no or
> very little additional overhead there. The extobj list is indeed a problem
> if many VMAs are bound to the same bo. Not that the code snippets are
> complicated, but the list traversals would be excessive.
> > 
> > Now, a way to get rid of the VM_BO abstraction would be to use maple trees
> > instead, since then we can store drm_gem_object structs directly for each VM.
> > However, Xe had concerns about using maple trees and preferred lists, plus
> > having maple trees wouldn't get rid of the concerns of amdgpu not having a VM_BO
> > abstraction for cases with tons of VMs and tons of mappings per BO. Hence,
> > having a VM_BO abstraction enabling us to track external/evicted objects with
> > lists seems to satisfy everyone's needs.
> 
> Indeed this is a tradeoff between a simple implementation that is OK for
> situations with not many VMs nor VMAs per bo vs a more complex
> implementation that optimizes for the opposite case.
> 
> So if this latter is a case we need to optimize for at this point then I
> guess it's the way to go.
> (I'm in the process of adapting the xe driver to this, so I just wanted to
> bring up areas where the implementations differ quite a lot and make sure
> options are discussed).

Thanks, I appreciate that. Just be aware of the locking issue in V3 that Boris
has pointed out. I don't know if I will get to sending out a V4 today to fix
that, but I'll try to do it by tomorrow.

- Danilo

> 
> Thanks,
> 
> Thomas
> 
> 
> > 
> > - Danilo
> > 
> > > To me that looks like a substantial amount of less code / complexity?
> > > 
> > > /Thomas
> > > 
> > > 
> > > > > Thanks,
> > > > > 
> > > > > Thomas
> > > > > 
> > > > > 
> 

