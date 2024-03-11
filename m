Return-Path: <linux-kernel+bounces-98983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459AF8781E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9111F22E24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC69405C6;
	Mon, 11 Mar 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHXDGY09"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076F1426A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168244; cv=none; b=D73yPMCAaCnf1/a/il4DZDFtyiHXxO6hyOfx26xnna5/CI+PBmWyFUivBeqMrEC0TTBlbutM9Dz1f/WY8smPOcK3AFvvKKPPeyZZe52mUIeuv8hBIRri/WBhPX8T5oKaR/a5qRdYZDEpXQBXB2LV2v2ujuha9Nn062aWJWTNEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168244; c=relaxed/simple;
	bh=YFHELlx50p3iAmGFim0fvJoZs45ytT+Tg3y8mAusNwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFLTVEA6w0RhatKkltAN3hkFjAn7zoDHpXDy9THOMoaBWpQxMvJCqqgZcCeYv3QFFArDIb4d3fsxp6PAMfyxWLoXPhwx3+eRCXYk9Y4kK5mFtPW3/TwSBOua2xBMFGW6e+DlmazGJ+6UczK4jwImopA67oP2jUK7PGWgBdx3N98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHXDGY09; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710168242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bCmY0lttRLSUbF4PLN5OL33CGHOcaBgqHKUv4QxTtWM=;
	b=XHXDGY09FTUX3yHu9+1i/lG2PgcNE5029sAgMFrl90AbOMQpBgR45paYWGQRB0oKO8SUIB
	BMRsQ2FQiLP7cupJfnXyUJgQBcM5S5g5movTnxq8HEaZT2yOBaLqZNaQ9sYkPhMSSk4h82
	zvcRzvIeasxW6oCDp+7Zn1ux3pQa6QE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-lriFz63QMyaTgXEFvwZsUw-1; Mon, 11 Mar 2024 10:43:50 -0400
X-MC-Unique: lriFz63QMyaTgXEFvwZsUw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a26f2da3c7bso240347966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710168229; x=1710773029;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCmY0lttRLSUbF4PLN5OL33CGHOcaBgqHKUv4QxTtWM=;
        b=wD/2LQ44mc70Xj1yy/JPG2Fy8UVnvRqgZ41GHUBS4SLnrNOrnSERTiaPRuzdnIg3i0
         CDSNptHXSG6zNyWG3DJA8R5ri+WEqhxnv3r5iEFwm0kS+D38YlpKZAKQXQWi0+qNadnD
         4l/N+YgDb4kWFFuA/G1Kg0ZQ4Pux3Rm8HGiZyrzjM/qb7fvlf1ONZiW6+gkyJtkYxWSe
         D2srJ0cQQbzSg369icXz0EUT01UppghHU1bNb5knE9CvPJg858ZLB1HX0a4rYMKyJBp9
         c1JOwdNNhuRxrJGFd449ksrydAheJRPz7BE5jCi6DMDIGAFzMxO3yCXMvEZ8xMZEW873
         5YGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmUHIpU96gWTNjhOK+BHB24cHrulheY+mIJ4xRT0Pqv48iKHzhh2CgeifQGCxtxlk4yFmEzRgMfZyQdBknDb/jUj81hXammbTUsKIo
X-Gm-Message-State: AOJu0Yzo8hNuCY+iDHN7nK4Ai8bDjSVRtTqSJb66QeUdNlFFSXLtPav4
	oRPF0OqMe0643hmzWpfL0h2CEXqA0bceAmVhYKHZ8cMT6ZEXRxRSXQAKIuAE1VuU8RNCG6Smtm/
	CdpgUk5LZzNY1Hk3CN3+M1xYii/ha27Rfv0erKWBE2RIpmZRKz/h45oPKXKKx3A==
X-Received: by 2002:a17:907:1603:b0:a45:20e4:e5ed with SMTP id cw3-20020a170907160300b00a4520e4e5edmr3655253ejd.77.1710168229243;
        Mon, 11 Mar 2024 07:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSt5xWxn5fPjZ9zpX4YYK4dzOMQubhQCKhz+bDzcyOgm8sO+u/90UunQ8oAI4tVtpH/65ASA==
X-Received: by 2002:a17:907:1603:b0:a45:20e4:e5ed with SMTP id cw3-20020a170907160300b00a4520e4e5edmr3655236ejd.77.1710168228884;
        Mon, 11 Mar 2024 07:43:48 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.77.21])
        by smtp.googlemail.com with ESMTPSA id t25-20020a1709063e5900b00a45c8c9a876sm2911741eji.88.2024.03.11.07.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 07:43:47 -0700 (PDT)
Message-ID: <6c7ca4d6-6f92-4107-a716-073ce0f7a02d@redhat.com>
Date: Mon, 11 Mar 2024 15:43:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] KVM: Xen and gfn_to_pfn_cache changes for 6.9
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
References: <20240308223702.1350851-1-seanjc@google.com>
 <20240308223702.1350851-9-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240308223702.1350851-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/24 23:37, Sean Christopherson wrote:
> Aaaand seeing my one commit in the shortlog made me realize I completely forgot
> to get acks from s390 on the kvm_is_error_gpa() => kvm_is_gpa_in_memslot()
> refactor.  Fudge.
> 
> s390 folks, my apologies for not reaching out earlier.  Please take a look at
> commit 9e7325acb3dc ("KVM: s390: Refactor kvm_is_error_gpa() into
> kvm_is_gpa_in_memslot()").  It *should* be a straight refactor, and I don't
> expect the rename to be contentious, but I didn't intend to send this pull request
> before getting an explicit ack.
> 
> As for the actual pull request, the bulk of the changes are to add support
> for using gfn_to_pfn caches without a gfn, e.g. to opimize handling of overlay
> pages, and then use that functionality for Xen's shared_info page.
> 
> Note, the commits towards the end are a variety of fixes from David that have
> been on the list for a while, but only got applied this week due to issues with
> the patches being corrupted (thanks to Evolution doing weird things).

Evolution?!? :)

> The following changes since commit db7d6fbc10447090bab8691a907a7c383ec66f58:
> 
>    KVM: remove unnecessary #ifdef (2024-02-08 08:41:06 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/kvm-x86/linux.git tags/kvm-x86-xen-6.9
> 
> for you to fetch changes up to 7a36d680658ba5a0d350f2ad275b97156b8d4333:
> 
>    KVM: x86/xen: fix recursive deadlock in timer injection (2024-03-04 16:22:39 -0800)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM Xen and pfncache changes for 6.9:
> 
>   - Rip out the half-baked support for using gfn_to_pfn caches to manage pages
>     that are "mapped" into guests via physical addresses.
> 
>   - Add support for using gfn_to_pfn caches with only a host virtual address,
>     i.e. to bypass the "gfn" stage of the cache.  The primary use case is
>     overlay pages, where the guest may change the gfn used to reference the
>     overlay page, but the backing hva+pfn remains the same.
> 
>   - Add an ioctl() to allow mapping Xen's shared_info page using an hva instead
>     of a gpa, so that userspace doesn't need to reconfigure and invalidate the
>     cache/mapping if the guest changes the gpa (but userspace keeps the resolved
>     hva the same).
> 
>   - When possible, use a single host TSC value when computing the deadline for
>     Xen timers in order to improve the accuracy of the timer emulation.
> 
>   - Inject pending upcall events when the vCPU software-enables its APIC to fix
>     a bug where an upcall can be lost (and to follow Xen's behavior).
> 
>   - Fall back to the slow path instead of warning if "fast" IRQ delivery of Xen
>     events fails, e.g. if the guest has aliased xAPIC IDs.
> 
>   - Extend gfn_to_pfn_cache's mutex to cover (de)activation (in addition to
>     refresh), and drop a now-redundant acquisition of xen_lock (that was
>     protecting the shared_info cache) to fix a deadlock due to recursively
>     acquiring xen_lock.
> 
> ----------------------------------------------------------------
> David Woodhouse (5):
>        KVM: x86/xen: improve accuracy of Xen timers
>        KVM: x86/xen: inject vCPU upcall vector when local APIC is enabled
>        KVM: x86/xen: remove WARN_ON_ONCE() with false positives in evtchn delivery
>        KVM: pfncache: simplify locking and make more self-contained
>        KVM: x86/xen: fix recursive deadlock in timer injection
> 
> Paul Durrant (17):
>        KVM: pfncache: Add a map helper function
>        KVM: pfncache: remove unnecessary exports
>        KVM: x86/xen: mark guest pages dirty with the pfncache lock held
>        KVM: pfncache: add a mark-dirty helper
>        KVM: pfncache: remove KVM_GUEST_USES_PFN usage
>        KVM: pfncache: stop open-coding offset_in_page()
>        KVM: pfncache: include page offset in uhva and use it consistently
>        KVM: pfncache: allow a cache to be activated with a fixed (userspace) HVA
>        KVM: x86/xen: separate initialization of shared_info cache and content
>        KVM: x86/xen: re-initialize shared_info if guest (32/64-bit) mode is set
>        KVM: x86/xen: allow shared_info to be mapped by fixed HVA
>        KVM: x86/xen: allow vcpu_info to be mapped by fixed HVA
>        KVM: selftests: map Xen's shared_info page using HVA rather than GFN
>        KVM: selftests: re-map Xen's vcpu_info using HVA rather than GPA
>        KVM: x86/xen: advertize the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA capability
>        KVM: pfncache: check the need for invalidation under read lock first
>        KVM: x86/xen: allow vcpu_info content to be 'safely' copied
> 
> Sean Christopherson (1):
>        KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()
> 
>   Documentation/virt/kvm/api.rst                     |  51 +++-
>   arch/s390/kvm/diag.c                               |   2 +-
>   arch/s390/kvm/gaccess.c                            |  14 +-
>   arch/s390/kvm/kvm-s390.c                           |   4 +-
>   arch/s390/kvm/priv.c                               |   4 +-
>   arch/s390/kvm/sigp.c                               |   2 +-
>   arch/x86/include/uapi/asm/kvm.h                    |   9 +-
>   arch/x86/kvm/lapic.c                               |   5 +-
>   arch/x86/kvm/x86.c                                 |  68 ++++-
>   arch/x86/kvm/x86.h                                 |   1 +
>   arch/x86/kvm/xen.c                                 | 325 ++++++++++++++-------
>   arch/x86/kvm/xen.h                                 |  18 ++
>   include/linux/kvm_host.h                           |  56 +++-
>   include/linux/kvm_types.h                          |   8 -
>   .../testing/selftests/kvm/x86_64/xen_shinfo_test.c |  59 +++-
>   virt/kvm/pfncache.c                                | 245 +++++++++-------
>   16 files changed, 602 insertions(+), 269 deletions(-)
> 


