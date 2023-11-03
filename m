Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E087E0C18
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjKCXRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjKCXR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:17:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E09D5A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:17:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b31e000e97so36317857b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699053445; x=1699658245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wL2niLMenc8rXWamhCVdrH1GL3hMVyvGfUspx7X4DS0=;
        b=y34aghm2O6SNvK8GRGqx/sn9ZtIKtyEKMe8V+/zJansECIFreEzwNQdaN7qaCTMxno
         iQyNclZxVpo458htEdZJR3G15cLAf//+VCR0X7Bb9mY8NQfPYk2RLQxot9vowL58J+WQ
         5hHhx/vsC4Fi5BrmYkOcz2Ry0VrZACj8kcr2w0P5oaF34k83fCp/HQQiRzJGW8Gpgnpt
         LE8G4T/CWtPumWqO8WdX3VhR7PfMiIcBYnlzl1o/d6i7pLaKqyDczwP5Xg+Vnz46J/mp
         wCPQ54D8JTsXgyveHL72zftw7M4doAMgz1QNm9HMEpFyaIBnh8OXueGidAopbHc09qPm
         VOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053445; x=1699658245;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wL2niLMenc8rXWamhCVdrH1GL3hMVyvGfUspx7X4DS0=;
        b=WppjfBU56TeeSK02rHbnCY1Gu6mlDBlz7+y/KNF68aEth0tYVnDE1xeSjhcXgZFTw+
         VNzdJgchK1GUo4T4j4mQFcmIEHLwzVsosduQ32Cyel52M56tMdj6m6DI3WLjRA6E5BX1
         SClbcToPoEqx6ngsJ/TyJbCk1BhvdsoQgO0HrULdrOMO92VFMizKvpXgX9xBnSoeN6R8
         Ww314mz1TYCgwHL8RNXnzvRSXXsacnk6QmRqnjVBQrVxtQB1CU1PK1I33qvt9RK8C3Y6
         r1fPsxCYCSqOL9McIw78gYGWffr1RHkFag2vMxC4NPZErK5MRsfxzhirbXCAvoX0wKlM
         pI/Q==
X-Gm-Message-State: AOJu0YzY1SqYRZMnmj7/xqO+27auOrvrbuArYcAEKbXSeOauYp3TsaEf
        PVAjD2J6UWW7J6oQSJ9fhtYGKnx9omg=
X-Google-Smtp-Source: AGHT+IGJDyi83TwJx+I35GsLQytKZmA4RJCyClEGAPsqdhhOEgS+Lm1oHaoRVNSHVuwQA3+7WVp40Ul4xUY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4958:0:b0:59f:3cde:b33a with SMTP id
 w85-20020a814958000000b0059f3cdeb33amr84737ywa.6.1699053444944; Fri, 03 Nov
 2023 16:17:24 -0700 (PDT)
Date:   Fri, 3 Nov 2023 16:17:23 -0700
In-Reply-To: <CA+EHjTzGzXnfXHh0m5iHt9m3BxerkUS56EVPDA_az6n2FRnk3w@mail.gmail.com>
Mime-Version: 1.0
References: <20231027182217.3615211-1-seanjc@google.com> <20231027182217.3615211-17-seanjc@google.com>
 <CA+EHjTzj4drYKONVOLP19DYpJ4O8kSXcFzw2AKier1QdcFKx_Q@mail.gmail.com>
 <ZUF8A5KpwpA6IKUH@google.com> <CA+EHjTwTT9cFzYTtwT43nLJS01Sgt0NqzUgKAnfo2fiV3tEvXg@mail.gmail.com>
 <ZULJYg5cf1UrNq3e@google.com> <CA+EHjTzGzXnfXHh0m5iHt9m3BxerkUS56EVPDA_az6n2FRnk3w@mail.gmail.com>
Message-ID: <ZUV_g1_3pj62OgF-@google.com>
Subject: Re: [PATCH v13 16/35] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Fuad Tabba <tabba@google.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023, Fuad Tabba wrote:
> On Wed, Nov 1, 2023 at 9:55=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > E.g. a misbehaving userspace could prematurely delete a memslot.  And t=
he more
> > fun example is intrahost migration, where the plan is to allow pointing=
 multiple
> > guest_memfd files at a single guest_memfd inode:
> > https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com
> >
> > There was a lot of discussion for this, but it's scattered all over the=
 place.
> > The TL;DR is is that the inode will represent physical memory, and a fi=
le will
> > represent a given "struct kvm" instance's view of that memory.  And so =
the memory
> > isn't reclaimed until the inode is truncated/punched.
> >
> > I _think_ this reflects the most recent plan from the guest_memfd side:
> > https://lore.kernel.org/all/1233d749211c08d51f9ca5d427938d47f008af1f.16=
89893403.git.isaku.yamahata@intel.com

Doh, sitting in my TODO folder...

https://lore.kernel.org/all/20231016115028.996656-1-michael.roth@amd.com

> Thanks for pointing that out. I think this might be the way to go.
> I'll have a closer look at this and see how to get it to work with
> pKVM.
