Return-Path: <linux-kernel+bounces-129747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A68896F71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121571C26AB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F24146D54;
	Wed,  3 Apr 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsev50hI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF0148318
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148740; cv=none; b=E9u6Rw4k7FbMQGjfbwteNXsx6tx8h+fYSc4O0e2nI41vQjSAfh8+XziKzxOv7kEfvvvszbi58DbJxy3+DZrM4/Wv1JqeYchATikYT/lY0UuJ7SFRtyrFGsDk2Ma4eUegqhVZmqzd1WXR1hM4B5yXvzSLmyg5ynoyM1lTMey24IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148740; c=relaxed/simple;
	bh=KTbI/ksSemO199S8nZZfV3jPhmS7kS2sBWwVojZaqVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVZFAPUX3wcojWcgX+NtakSxlZjv+jGEJrKszKQnb/1P44YFNzImSjTw+wE5iJPULoM+s18ktNCfoCO/pPUiU0wE82e/8RPyTgFyl5R500c4mOxJGq9/NGyEIYwFb70vVWhMv0QvwGyfZoNUSrOpvpo+733qfzBc9dWGhT8r2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsev50hI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712148737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lzo04337+pWNqFR9KY5np7872oqctqWVTvayomhrVIY=;
	b=dsev50hISDVPIgEwKur0Dy5C3+YuIPXlzF6B0+H4b6Ip9JYw6/7BwZWrFVOaqgbyekXNGu
	LVFXeA18wWDBsmjc+BrSA2v08eLZ0U+ylEVHiSREDWNUCFglPqV3Ke0+U+PoEM2uRqVMUu
	gspz2KvZpuMl3eywKjnRlxq75JEHwZI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-NFMpeP6vMSSDd44-g6NrlQ-1; Wed, 03 Apr 2024 08:52:13 -0400
X-MC-Unique: NFMpeP6vMSSDd44-g6NrlQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3436714e286so1193194f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 05:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712148732; x=1712753532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lzo04337+pWNqFR9KY5np7872oqctqWVTvayomhrVIY=;
        b=oeE8IaDyEWtl8HizjaroIrvH+LH7vE7dy7EHvav6CH8ElpOEMejmZWyVAnLXdS23h4
         I6GF6nByqGgYO8q89+Ep5GHJcOMOvkhtcBQa1eSXrQIKJMZjaOFExxduF5oNoE10b069
         kdohwrsYxjzr9TydxBo+3MIOGpPHk5FVAUIk8eAPAZIqtN29tU0ReRXKLf1XS4UDbTYh
         mvHC9HWVu6dx2RGpPweDOviEZkaU9p8wnNY3kHb5jbGBUdop6OqGN7/yBvR2mbfjihgH
         8brgPciPdOpvbkkTup3GTXs4o9FyH+eHG/CO/WPj77SBp570cu2OImI0ldFVQbu1f/wJ
         dH1g==
X-Forwarded-Encrypted: i=1; AJvYcCXpcVo7GGGuFICjstVqXylrYeg/XnG8oQvB1AUrqkspRO+6mRQp6xwl5xa7j3Hd8qGwjkbv2ugi6+FV/p7ocHGzwfnegeJ4m0aoSbJ1
X-Gm-Message-State: AOJu0Yx+q+6u3ylzC/+23Yu38dtGAAqQxtb0a2poNUWqgCv/mAoc+W97
	JESTFLCDXVg1zFDocEhCnEsWtU66YuOLLnn6sIZInTogr1yVd2/vJcc/O+AW0IojDW8JTDkm8L2
	RKSvoGyLHo3joVFCV4EUVFfhkOJ/eYGbaHFbJWbByDarI5CZkbK9po+ZF+PvPhY52xGoShmJlbz
	ozpwh3r3go6hllGvWqKWzsola7YwI5HFveXj77
X-Received: by 2002:a5d:48cc:0:b0:33e:ca29:5a3 with SMTP id p12-20020a5d48cc000000b0033eca2905a3mr10071621wrs.23.1712148731978;
        Wed, 03 Apr 2024 05:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2UoNabPuQYMXaCFPaD8DdCLeElDGS9RU+nviM9wFLu/qKDV0J6kv+wy2lYCLkobeqVDalIcJhUKiwuGQdPuY=
X-Received: by 2002:a5d:48cc:0:b0:33e:ca29:5a3 with SMTP id
 p12-20020a5d48cc000000b0033eca2905a3mr10071597wrs.23.1712148731603; Wed, 03
 Apr 2024 05:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329225835.400662-1-michael.roth@amd.com> <20240329225835.400662-12-michael.roth@amd.com>
 <8c3685a6-833c-4b3c-83f4-c0bd78bba36e@redhat.com> <20240401222229.qpnpozdsr6b2sntk@amd.com>
 <20240402225840.GB2444378@ls.amr.corp.intel.com>
In-Reply-To: <20240402225840.GB2444378@ls.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 3 Apr 2024 14:51:59 +0200
Message-ID: <CABgObfb4fQpUTzhpX9Bkcu0_+bOcCSCtuy+5-rttTLm-bY8i2w@mail.gmail.com>
Subject: Re: [PATCH v12 11/29] KVM: SEV: Add KVM_SEV_SNP_LAUNCH_UPDATE command
To: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, 
	seanjc@google.com, vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, 
	Brijesh Singh <brijesh.singh@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	isaku.yamahata@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 12:58=E2=80=AFAM Isaku Yamahata <isaku.yamahata@inte=
l.com> wrote:
> I think TDX can use it with slight change. Pass vcpu instead of KVM, page=
 pin
> down and mmu_lock.  TDX requires non-leaf Secure page tables to be popula=
ted
> before adding a leaf.  Maybe with the assumption that vcpu doesn't run, G=
FN->PFN
> relation is stable so that mmu_lock isn't needed? What about punch hole?
>
> The flow would be something like as follows.
>
> - lock slots_lock
>
> - kvm_gmem_populate(vcpu)
>   - pin down source page instead of do_memcopy.

Both pinning the source page and the memcpy can be done in the
callback.  I think the right thing to do is:

1) eliminate do_memcpy, letting AMD code taking care of
   copy_from_user.

2) pass to the callback only gfn/pfn/src, where src is computed as

    args->src ? args->src + i * PAGE_SIZE : NULL

If another architecture/vendor needs do_memcpy, they can add
something like kvm_gmem_populate_copy.

>   - get pfn with __kvm_gmem_get_pfn()
>   - read lock mmu_lock
>   - in the post_populate callback
>     - lookup tdp mmu page table to check if the table is populated.
>       lookup only version of kvm_tdp_mmu_map().
>       We need vcpu instead of kvm.

Passing vcpu can be done using the opaque callback argument to
kvm_gmem_populate.

Likewise, the mmu_lock can be taken by the TDX post_populate
callback.

Paolo

>     - TDH_MEM_PAGE_ADD
>   - read unlock mmu_lock
>
> - unlock slots_lock
>
> Thanks,
>
> > With that model, the potential for using kvm_gmem_populate() seemed
> > plausible to I was trying to make it immediately usable for that
> > purpose. But maybe the TDX folks can confirm whether this would be
> > usable for them or not. (kvm_gmem_populate was introduced here[2] for
> > reference/background)
> >
> > -Mike
> >
> > [1] https://lore.kernel.org/kvm/20240319155349.GE1645738@ls.amr.corp.in=
tel.com/T/#m8580d8e39476be565534d6ff5f5afa295fe8d4f7
> > [2] https://lore.kernel.org/kvm/20240329212444.395559-3-michael.roth@am=
d.com/T/#m3aeba660fcc991602820d3703b1265722b871025)


