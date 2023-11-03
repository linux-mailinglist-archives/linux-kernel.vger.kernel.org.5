Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C877E00ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347246AbjKCJnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347156AbjKCJm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:42:58 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A8E1BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 02:42:55 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6754b4091b6so10453616d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 02:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699004574; x=1699609374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KR3uUy+lpOtuK74sFvr5LpDDKafluOWW+OG46f9Hrzo=;
        b=m3pY6/b6G3YJERrdwBROFGfs5vr++Ag9hIpC6AAjKkhtJXm9uyP0ggYk8B+Ncaexyi
         3clt65KmCVXky6OZlcnHlPn5CBIJ5h5Al88i5bKZT8sSQL2TCwba4/MhlCWokMY1azOz
         ioUmsNt3uOeSfXRT/RNkfb9NjcquWEVecFRd1f/o2OEHYi/rHv8JxELdmEPVGnNLZsGo
         0AGMi1aai1wST8hQZLah3xLA0lAhJ8zcBae3ytuJFPlCi24Rg96s59nTckrQlFamimQq
         KsgRNNnYrH1pISVyAHX8N8HStVQx403Shxi+vRdDUruxeWHNenFbCLAhuWK4qibWEP00
         OwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699004574; x=1699609374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KR3uUy+lpOtuK74sFvr5LpDDKafluOWW+OG46f9Hrzo=;
        b=GL3daE8Ui205wuuSBtFV1SXdy3vugs9CS0lfl3L+w9yDOIv4almRCizNc451umu++W
         mPZvcF7dmzavuyVzVgPwdqAm+Jt8SivqrqBuhHtj45fBhbfPDU7pe72ONLd8cHBk+Brq
         sXmngtAV3Q683f6kOdMt0dHnQjHInrVi6j/axtYSrT/YDcdQV9q3gzHGpjbeCH0U+QIE
         1BnzuKYAoa+dEF34b6/uvoG0CRCHUQ8zS3idNKXkXHI9iPRLi2Ws6XYSrc810Z6LpSPP
         ND1WVOZ5TcbuyGrNv3MpxXL0uIadvG1aIr1tTixg4lr05UnMkKHGM34Qcv0T8wIvLh7k
         FQwA==
X-Gm-Message-State: AOJu0YwOBgAFYbMcCg5JCa1S2PVHBjf6xj8BfV7xPqfi197ulJctrWwo
        FkISTiAHgPnGylkoWaosqYrDDKCB1RVAFkkyc2MecQ==
X-Google-Smtp-Source: AGHT+IHMtnnuJ+fshc7oeOwDt21mO974uTwKm6avpjixqQMFQPk6nu4AOneq997yl+dXgdaxeuVP+cu76MznLmTOvmQ=
X-Received: by 2002:a05:6214:401c:b0:66d:34a8:3ed0 with SMTP id
 kd28-20020a056214401c00b0066d34a83ed0mr22048546qvb.26.1699004574544; Fri, 03
 Nov 2023 02:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
In-Reply-To: <20231027182217.3615211-17-seanjc@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 3 Nov 2023 09:42:17 +0000
Message-ID: <CA+EHjTxEvJpfA7urRj6EbbuwTGWAw6ZYu6NmX9sLT5Cdp5p3eA@mail.gmail.com>
Subject: Re: [PATCH v13 16/35] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
To:     Sean Christopherson <seanjc@google.com>
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
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        David Matlack <dmatlack@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

...

> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e2252c748fd6..e82c69d5e755 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst

...

> +4.141 KVM_CREATE_GUEST_MEMFD
> +----------------------------
> +
> +:Capability: KVM_CAP_GUEST_MEMFD
> +:Architectures: none
> +:Type: vm ioctl
> +:Parameters: struct struct kvm_create_guest_memfd(in)

One struct too many.

Cheers,
/fuad
