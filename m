Return-Path: <linux-kernel+bounces-159530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026328B2FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C00283748
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C03EBE;
	Fri, 26 Apr 2024 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1XR9eog"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E98E13A271
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110298; cv=none; b=r6sESvhcMIUT/he0Vn3SoBKBH1hhaA1QeTX1TMzBJaJpUG6ehhRbBJ/OUS2Ob4FRI4U173h3o5GcOkZooet6Cws0aEyNymPwi/lFwVNyuwQNU6TPqasyuGbQLy3eYGuzqw541f2CwNF8BqXpp5NgIPWkLwR3P210lT84+BY97+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110298; c=relaxed/simple;
	bh=pu0zE3QPPT0qSBo7dBGQlCJBtyysfRS8IdgovXoZ7wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZR5To2jyEIrEPOBw76h87mepyo6zG9k5Y54s8vQqUuU56OqDG/PbuSFONSMuRwkW9vBJTtuGnH7EM+pXd43kq5M2D1UTmPuNMw6MBQg1RXJ0isuLtYGdYdfVpzuAMjTVoRlRh5ff1mid7VPUSs1h7D/U0bcMDKJcbDEW9j8brK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1XR9eog; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714110296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zalx7EmoT1K3AB8US4D+2ZE8xlMcgkH7h+tut8rYga4=;
	b=K1XR9eogqX/P71IXYCaYyUnXFdZstQ9TTXYpug9Cy1Gtt5LDhjOR8Gnzvh123L6yTthYYw
	5zeCv/TZdtR6gCZuDtl8EJ5ueNoSArXxyo0S/wqjGITM+ZhEsJg8YUXqdAFIh0TkCW791u
	avclplqX+iM5ebO7W3jasE8zpYqJjes=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-BMGITMS0Pb-Olsn_VyC3Gg-1; Fri, 26 Apr 2024 01:44:54 -0400
X-MC-Unique: BMGITMS0Pb-Olsn_VyC3Gg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-345c686ba9bso1101608f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714110292; x=1714715092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zalx7EmoT1K3AB8US4D+2ZE8xlMcgkH7h+tut8rYga4=;
        b=B/AtOc9vZKiwMTiunZjFe4+n4W4IrtG7SbIZ4kbLiEiQr/p6mmjVSif9kVq0TYV+si
         h0Ql0VJR3Yfvqu+sbd1oKu+T6dWSHLRG44tz1Z2jG23FpyDJCglTu4/eJ8TzMGR4eqOQ
         NO6Y7A2+uhDtXIDxy9Y3+mp8wjW5Tp9tuhgJdIuInZKuh/l7oSE+LFyDjwHgXuz93FsG
         3dNC0UVTwKHFnLpNq1W1Mx0BxBoxWH6M0PK2PCg7WBN4oVG7KkL/mFQ7G33rUaQVC9AT
         7j3d5rusbbQDaNewqWF2zwi+SIYazNxiHh+SQaW7l2q5XlTwWsCD/Koaid9qBpIUGW8j
         +RDg==
X-Forwarded-Encrypted: i=1; AJvYcCWKAp2onJVaN55mSU/ZfaX6+wSyE/z5NpEM2RPrzP3W1lijOHUvdNPFgOq0dP1E6dhz1wi6uj5HH9N7JUE0964qHRotTWkPMrUqvFPP
X-Gm-Message-State: AOJu0Yw2ZAuDnDKXunGtRzR45KfwN3vrZSP1JCAf4n0ItVD+Tm7g/jeW
	v4OqSlYuG3K94GQ8J8KmSRbwR72GLrhctYtZjo56oL+p5jHT/xPuAMI9cMeMpcoITNLUZ1/KYIa
	sL0cbgvZu1OeT6UchKIFRTwLLgYBcvhJM6cU0otYiHj86nd0UEsi0dQDMpOv5EO7cWxkqBlZYET
	7ujOtB15pB8Q0tHkD49oD/jyfpQrhUXd8G/PdtsozTziHb+Ds=
X-Received: by 2002:adf:e253:0:b0:343:79e8:a4d6 with SMTP id bl19-20020adfe253000000b0034379e8a4d6mr1156403wrb.25.1714110292028;
        Thu, 25 Apr 2024 22:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqWXltO8gLCXZkrnXY5rkFkK7W0IxWNakzRZcKlEAmaam8CFb03PwsU4VGymcNZ9uSmdxI5bI5QpPBRCFyHxU=
X-Received: by 2002:adf:e253:0:b0:343:79e8:a4d6 with SMTP id
 bl19-20020adfe253000000b0034379e8a4d6mr1156391wrb.25.1714110291654; Thu, 25
 Apr 2024 22:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404185034.3184582-1-pbonzini@redhat.com> <20240404185034.3184582-10-pbonzini@redhat.com>
 <20240423235013.GO3596705@ls.amr.corp.intel.com> <ZimGulY6qyxt6ylO@google.com>
 <20240425011248.GP3596705@ls.amr.corp.intel.com> <CABgObfY2TOb6cJnFkpxWjkAmbYSRGkXGx=+-241tRx=OG-yAZQ@mail.gmail.com>
 <Zip-JsAB5TIRDJVl@google.com> <20240425165144.GQ3596705@ls.amr.corp.intel.com>
In-Reply-To: <20240425165144.GQ3596705@ls.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Apr 2024 07:44:40 +0200
Message-ID: <CABgObfbAzj=OzhfK2zfkQmeJmRUxNqMSHeGgJd+JGjsmwC_f1g@mail.gmail.com>
Subject: Re: [PATCH 09/11] KVM: guest_memfd: Add interface for populating gmem
 pages with user data
To: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	michael.roth@amd.com, isaku.yamahata@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 6:51=E2=80=AFPM Isaku Yamahata <isaku.yamahata@inte=
l.com> wrote:
> > AFAIK, unwinding on failure is completely uninteresting, and arguably u=
ndesirable,
> > because undoing LAUNCH_UPDATE or PAGE.ADD will affect the measurement, =
i.e. there
> > is no scenario where deleting pages from guest_memfd would allow a rest=
art/resume
> > of the build process to truly succeed.
>
>
> Just for record.  With the following twist to kvm_gmem_populate,
> KVM_TDX_INIT_MEM_REGION can use kvm_gmem_populate().  For those who are c=
urious,
> I also append the callback implementation at the end.

Nice, thank you very much. Since TDX does not need
HAVE_KVM_GMEM_PREPARE, if I get rid of FGP_CREAT_ONLY it will work for
you, right?

Paolo

>
> --
>
>  include/linux/kvm_host.h | 2 ++
>  virt/kvm/guest_memfd.c   | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index df957c9f9115..7c86b77f8895 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2460,6 +2460,7 @@ bool kvm_arch_gmem_prepare_needed(struct kvm *kvm);
>   *       (passed to @post_populate, and incremented on each iteration
>   *       if not NULL)
>   * @npages: number of pages to copy from userspace-buffer
> + * @prepare: Allow page allocation to invoke gmem_prepare hook
>   * @post_populate: callback to issue for each gmem page that backs the G=
PA
>   *                 range
>   * @opaque: opaque data to pass to @post_populate callback
> @@ -2473,6 +2474,7 @@ bool kvm_arch_gmem_prepare_needed(struct kvm *kvm);
>   * Returns the number of pages that were populated.
>   */
>  long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, lon=
g npages,
> +                      bool prepare,
>                        int (*post_populate)(struct kvm *kvm, gfn_t gfn, k=
vm_pfn_t pfn,
>                                             void __user *src, int order, =
void *opaque),
>                        void *opaque);
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 3195ceefe915..18809e6dea8a 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -638,6 +638,7 @@ static int kvm_gmem_undo_get_pfn(struct file *file, s=
truct kvm_memory_slot *slot
>  }
>
>  long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, lon=
g npages,
> +                      bool prepare,
>                        int (*post_populate)(struct kvm *kvm, gfn_t gfn, k=
vm_pfn_t pfn,
>                                             void __user *src, int order, =
void *opaque),
>                        void *opaque)
> @@ -667,7 +668,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, vo=
id __user *src, long npages
>                 gfn_t this_gfn =3D gfn + i;
>                 kvm_pfn_t pfn;
>
> -               ret =3D __kvm_gmem_get_pfn(file, slot, this_gfn, &pfn, &m=
ax_order, false);
> +               ret =3D __kvm_gmem_get_pfn(file, slot, this_gfn, &pfn, &m=
ax_order, prepare);
>                 if (ret)
>                         break;
>
> --
> 2.43.2
>
>
> Here is the callback for KVM_TDX_INIT_MEM_REGION.
> Note: the caller of kvm_gmem_populate() acquires mutex_lock(&kvm->slots_l=
ock)
> and idx =3D srcu_read_lock(&kvm->srcu).
>
>
> struct tdx_gmem_post_populate_arg {
>         struct kvm_vcpu *vcpu;
>         __u32 flags;
> };
>
> static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t p=
fn,
>                                   void __user *src, int order, void *_arg=
)
> {
>         struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(kvm);
>         struct tdx_gmem_post_populate_arg *arg =3D _arg;
>         struct kvm_vcpu *vcpu =3D arg->vcpu;
>         struct kvm_memory_slot *slot;
>         gpa_t gpa =3D gfn_to_gpa(gfn);
>         struct page *page;
>         kvm_pfn_t mmu_pfn;
>         int ret, i;
>         u64 err;
>
>         /* Pin the source page. */
>         ret =3D get_user_pages_fast((unsigned long)src, 1, 0, &page);
>         if (ret < 0)
>                 return ret;
>         if (ret !=3D 1)
>                 return -ENOMEM;
>
>         slot =3D kvm_vcpu_gfn_to_memslot(vcpu, gfn);
>         if (!kvm_slot_can_be_private(slot) || !kvm_mem_is_private(kvm, gf=
n)) {
>                 ret =3D -EFAULT;
>                 goto out_put_page;
>         }
>
>         read_lock(&kvm->mmu_lock);
>
>         ret =3D kvm_tdp_mmu_get_walk_private_pfn(vcpu, gpa, &mmu_pfn);
>         if (ret < 0)
>                 goto out;
>         if (ret > PG_LEVEL_4K) {
>                 ret =3D -EINVAL;
>                 goto out;
>         }
>         if (mmu_pfn !=3D pfn) {
>                 ret =3D -EAGAIN;
>                 goto out;
>         }
>
>         ret =3D 0;
>         do {
>                 err =3D tdh_mem_page_add(kvm_tdx, gpa, pfn_to_hpa(pfn),
>                                        pfn_to_hpa(page_to_pfn(page)), NUL=
L);
>         } while (err =3D=3D TDX_ERROR_SEPT_BUSY);
>         if (err) {
>                 ret =3D -EIO;
>                 goto out;
>         }
>
>         WARN_ON_ONCE(!atomic64_read(&kvm_tdx->nr_premapped));
>         atomic64_dec(&kvm_tdx->nr_premapped);
>         tdx_account_td_pages(vcpu->kvm, PG_LEVEL_4K);
>
>         if (arg->flags & KVM_TDX_MEASURE_MEMORY_REGION) {
>                 for (i =3D 0; i < PAGE_SIZE; i +=3D TDX_EXTENDMR_CHUNKSIZ=
E) {
>                         err =3D tdh_mr_extend(kvm_tdx, gpa + i, NULL);
>                         if (err) {
>                                 ret =3D -EIO;
>                                 break;
>                         }
>                 }
>         }
>
> out:
>         read_unlock(&kvm->mmu_lock);
> out_put_page:
>         put_page(page);
>         return ret;
> }
>
> --
> Isaku Yamahata <isaku.yamahata@intel.com>
>


