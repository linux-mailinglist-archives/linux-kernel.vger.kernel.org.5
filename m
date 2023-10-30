Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4897DBD83
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjJ3QK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjJ3QKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:10:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEC5C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:10:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a5a3f2d4fso3987948276.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698682249; x=1699287049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/eJ4eIlm/QBKFGigGc88HjjNKR0Bxic1+CMFaJ9ygg=;
        b=xIpHiLlYMInUSLi5VCe6TqJpt61TrAn/5ZPqHyszcZVdiUz0c28xoPUwvcEMHNUUBu
         bjF6Yr/DB7VAqku0bXwkoDWpKKaLxSJLtdpMLXIhVr1yBgLYL10+qdippLa24OArU/Ob
         OwQ2TTIYKwbkYktDUAQAIdsnD/M4DgEeFtpYBvnMbhG3d/BCNvQoQVsQPU27dnX1jXDB
         UeMR4FLftEFiRahqkhojZ8222kP2JSVepRntLbr6vFa4dpcBCRJpOWtfBeutPekiBf49
         oUMkfOtdlQQrA4ZJF3Lld7zJYzp8Ky17grYE0WRGw7K9oXCY6meP3JgYnvf8zfFcsScO
         Pq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698682249; x=1699287049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/eJ4eIlm/QBKFGigGc88HjjNKR0Bxic1+CMFaJ9ygg=;
        b=MiWH2kNNvOjCtgmkeV8VpMQlX4JYOXM1GOG4A1wILjAP3cF/DVoafCx2KvrOayWuRx
         +WE84+ibhhlXT4Gty5RqcSmI1SjJn/OQxFtx+jtiTD1KrNKZzxYrweSobZbKv6fnUi2i
         vgnqQ/njFpJkF+U8daM8j4NDHjZcjBcGjP0XA8H/14w/bXem4IUHbs/eKBpXDHKsCtZ/
         6R8y1wCMbKOkGMa11umnqp26upGfgnpsWj5kT3RFmd0gvbmyAmQCylL/6JoGWeDmdi9z
         RBmh7bxlV7F+pdFXT4Tq0trfKNuPvx1lEE3KSgPWt4KNPdC8Rxu/sUcSfn5SAbisY0CI
         S5CQ==
X-Gm-Message-State: AOJu0YyynuuFj4tWKDdtZXKSOmgpXYsG50K9otPZfzJhdVofuknp5Gkg
        nUVoeL9qDFSNCqWSMVx5wzhALC7Kvs0=
X-Google-Smtp-Source: AGHT+IG/nj4LaX3JPzHZqsehR5FWhArOOi7E0ApKeqEkunCLK98IonUlxUU55c5VBDsNlZFSGb1icvfnahw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP id
 v3-20020a056902108300b00d9ac3b84274mr243782ybu.7.1698682249642; Mon, 30 Oct
 2023 09:10:49 -0700 (PDT)
Date:   Mon, 30 Oct 2023 16:10:48 +0000
In-Reply-To: <ZT9lQ9c7Bik6FIpw@chao-email>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-14-seanjc@google.com>
 <ZT9lQ9c7Bik6FIpw@chao-email>
Message-ID: <ZT_ViJOW1p4TN_fI@google.com>
Subject: Re: [PATCH v13 13/35] KVM: Introduce per-page memory attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        David Matlack <dmatlack@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023, Chao Gao wrote:
> On Fri, Oct 27, 2023 at 11:21:55AM -0700, Sean Christopherson wrote:
> >From: Chao Peng <chao.p.peng@linux.intel.com>
> >
> >In confidential computing usages, whether a page is private or shared is
> >necessary information for KVM to perform operations like page fault
> >handling, page zapping etc. There are other potential use cases for
> >per-page memory attributes, e.g. to make memory read-only (or no-exec,
> >or exec-only, etc.) without having to modify memslots.
> >
> >Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
> >userspace to operate on the per-page memory attributes.
> >  - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
> >    a guest memory range.
> 
> >  - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
> >    memory attributes.
> 
> This ioctl() is already removed. So, the changelog is out-of-date and needs
> an update.

Doh, I lost track of this and the fixup for KVM_CAP_MEMORY_ATTRIBUTES below.

> >+:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> >+:Architectures: x86
> >+:Type: vm ioctl
> >+:Parameters: struct kvm_memory_attributes(in)
> 
> 					   ^ add one space here?

Ah, yeah, that does appear to be the standard.
> 
> 
> >+static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
> >+					  struct kvm_gfn_range *range)
> >+{
> >+	/*
> >+	 * Unconditionally add the range to the invalidation set, regardless of
> >+	 * whether or not the arch callback actually needs to zap SPTEs.  E.g.
> >+	 * if KVM supports RWX attributes in the future and the attributes are
> >+	 * going from R=>RW, zapping isn't strictly necessary.  Unconditionally
> >+	 * adding the range allows KVM to require that MMU invalidations add at
> >+	 * least one range between begin() and end(), e.g. allows KVM to detect
> >+	 * bugs where the add() is missed.  Rexlaing the rule *might* be safe,
> 
> 					    ^^^^^^^^ Relaxing
> 
> >@@ -4640,6 +4850,17 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
> > 	case KVM_CAP_BINARY_STATS_FD:
> > 	case KVM_CAP_SYSTEM_EVENT_DATA:
> > 		return 1;
> >+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> >+	case KVM_CAP_MEMORY_ATTRIBUTES:
> >+		u64 attrs = kvm_supported_mem_attributes(kvm);
> >+
> >+		r = -EFAULT;
> >+		if (copy_to_user(argp, &attrs, sizeof(attrs)))
> >+			goto out;
> >+		r = 0;
> >+		break;
> 
> This cannot work, e.g., no @argp in this function and is fixed by a later commit:
> 
> 	fcbef1e5e5d2 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")

I'll post a fixup patch for all of these, thanks much!
