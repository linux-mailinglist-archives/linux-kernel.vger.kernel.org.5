Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3BE811D24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjLMSo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjLMSoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:44:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68223116
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702493099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSA+WMrA8eO/D9HzsQduQ+zsnP8CvaI3GamGqZxjrOw=;
        b=XQWZeOnmGoZEVwMzshzA3PEB+A0XpFTyErhn/fdakFtnXy3pALDhRdVJlB+aCVXJnnKZ+T
        8vdtUdHs+Yun8+cPKvhQMibR1ACzTqoR5Dg5aJiv0Yid1rPTHX0FiGSwuhgE+gnWVOFxQK
        +G41CQhtrFCxOVq0nQSChx2/nDFKKCc=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-50ArrH42NhGY7XsJWQOJOg-1; Wed, 13 Dec 2023 13:44:56 -0500
X-MC-Unique: 50ArrH42NhGY7XsJWQOJOg-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4b4e55930f8so2756195e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493095; x=1703097895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSA+WMrA8eO/D9HzsQduQ+zsnP8CvaI3GamGqZxjrOw=;
        b=S04yK2T4mt1iNLiSFpznFDfaojD9phOBaiZHCD4uVzXG7kTTdkho3p/g8DF81a7yxM
         KhopckzensE25i4tzngQFWI2cB9x8osW0ou1tEokPY11gp/jh/eLE48O/dyp6jdhxATc
         8Zaa/WsMkavA0H6C5yRMiTbnhgKoayxKDZ+Ekqz5u6G6h5nec0TM2qYi+9qFTc476Bvb
         quOi51Uk/t0GmChc4d8NkvrIHbOSkZG2RSyRUtG6XxsRE8gERUmLfJTsVBr8K8aOlyhx
         xLY93x71kab2RC+r+7Kgp0Mc9V3/caAa0AiBMAAqYAZijBKD8IRSeGSFa2QHhdvm79Fh
         v2Ig==
X-Gm-Message-State: AOJu0Yzkl+jUWdQ/gDVHcR2m/TCrBdMRGUiseLYxdBU1jXQd3QRaXTIv
        Gab6doxiucrnItPzi21b0ZAg1O1qv7XsLQU+wcZxsap3gDhnmQa9a+tenl/ZfzSJy1X13wm8otQ
        vjGb6p2Cshb9mKdTc2n0auH0z6pJuYKseC7pts4Aa
X-Received: by 2002:a05:6122:e2e:b0:4b4:f65b:49a4 with SMTP id bk46-20020a0561220e2e00b004b4f65b49a4mr2103425vkb.16.1702493095502;
        Wed, 13 Dec 2023 10:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ87bsfaafWN7TmiHkXvwPee7xLp5yx+ghgAAlRqlkhVyDix4rrhL5FVVz/EoFRUwOMyi80+sfTHGP33aev3Q=
X-Received: by 2002:a05:6122:e2e:b0:4b4:f65b:49a4 with SMTP id
 bk46-20020a0561220e2e00b004b4f65b49a4mr2103424vkb.16.1702493095171; Wed, 13
 Dec 2023 10:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20231208184628.2297994-1-pbonzini@redhat.com> <ZXPRGzgWFqFdI_ep@google.com>
 <184e253d-06c4-419e-b2b4-7cce1f875ba5@redhat.com> <ZXnoCadq2J3cPz2r@google.com>
 <84ad3082-794b-443f-874a-d304934a395b@redhat.com> <ZXn0sR6IyzLzVHW-@google.com>
In-Reply-To: <ZXn0sR6IyzLzVHW-@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 13 Dec 2023 19:44:42 +0100
Message-ID: <CABgObfa9y3dwLjduS8UmGDRxLBfFVJ9T8GhHx=22arM+U6kBzw@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: fix supported_flags for aarch64
To:     Sean Christopherson <seanjc@google.com>
Cc:     Shaoqin Huang <shahuang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 7:15=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > selftests have the luxury of having sync-ed kernel headers, but in gene=
ral
> > userspace won't, and that means __KVM_HAVE_READONLY_MEM would be a very=
 poor
> > userspace API.  Fortunately it has "__" so it is not userspace API at a=
ll,
> > and I don't want selftests to treat it as one.
>
> Wait, what?  How does double underscores exempt it from being uAPI?  AIUI=
, the C
> standard effectively ensures that userspace won't define/declare symbols =
with
> double underscores, i.e. ensures there won't be conflicts.  But pretty mu=
ch all
> of the kernel-defined types are prefixed with "__", e.g. __u8 and friends=
, so I
> don't see how prefixing with "__" exempts something from becoming uAPI.

Userspace is generally not supposed to know that double underscore
symbols exist, though in some cases it has to (see for example
_UFFDIO_*). Looking at yesterday's patch from Dionna, userspace is
very much not supposed to use _BITUL, and even less so for _UL.

In particular, __KVM_HAVE_* symbols are meant to mask definitions in
include/uapi/linux/kvm.h.
__KVM_HAVE_READONLY_MEM was a very misguided mean to define
KVM_CAP_READONLY_MEM only on architectures where it could have
possibly be true (see commit 0f8a4de3e088, "KVM: Unconditionally
export KVM_CAP_READONLY_MEM", 2014-08-29). Which does not make sense
at all, as the commit message points out. So I'm willing to test my
chances, kill it and see if anyone complains (while crossing fingers
that Google and Amazon don't :)).

Paolo

> I completely agree that __KVM_HAVE_READONLY_MEM shouldn't be uAPI, but th=
en it
> really, really shouldn't be defined in arch/x86/include/uapi/asm/kvm.h.
>

On Wed, Dec 13, 2023 at 7:15=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Dec 13, 2023, Paolo Bonzini wrote:
> > On 12/13/23 18:21, Sean Christopherson wrote:
> > > On Tue, Dec 12, 2023, Paolo Bonzini wrote:
> > > > On 12/9/23 03:29, Sean Christopherson wrote:
> > > > > On Fri, Dec 08, 2023, Paolo Bonzini wrote:
> > > > > > KVM/Arm supports readonly memslots; fix the calculation of
> > > > > > supported_flags in set_memory_region_test.c, otherwise the
> > > > > > test fails.
> > > > >
> > > > > You got beat by a few hours, and by a better solution ;-)
> > > > >
> > > > > https://lore.kernel.org/all/20231208033505.2930064-1-shahuang@red=
hat.com
> > > >
> > > > Better but also wrong---and my patch has the debatable merit of mor=
e
> > > > clearly exposing the wrongness.  Testing individual architectures i=
s bad,
> > > > but testing __KVM_HAVE_READONLY_MEM makes the test fail when runnin=
g a new
> > > > test on an old kernel.
> > >
> > > But we already crossed that bridge and burned it for good measure by =
switching
> > > to KVM_SET_USER_MEMORY_REGION2, i.e. as of commit
> > >
> > >    8d99e347c097 ("KVM: selftests: Convert lib's mem regions to KVM_SE=
T_USER_MEMORY_REGION2")
> > >
> > > selftests built against a new kernel can't run on an old kernel.  Bui=
lding KVM
> > > selftests requires kernel headers, so while not having a hard require=
ment that
> > > the uapi headers are fresh would be nice, I don't think it buys all t=
hat much.
> > >
> > > If we wanted to assert that x86, arm64, etc. enumerate __KVM_HAVE_REA=
DONLY_MEM,
> > > i.e. ensure that read-only memory is supported as expected, then that=
 can be done
> > > as a completely unrelated test.
> >
> > selftests have the luxury of having sync-ed kernel headers, but in gene=
ral
> > userspace won't, and that means __KVM_HAVE_READONLY_MEM would be a very=
 poor
> > userspace API.  Fortunately it has "__" so it is not userspace API at a=
ll,
> > and I don't want selftests to treat it as one.
>
> Wait, what?  How does double underscores exempt it from being uAPI?  AIUI=
, the C
> standard effectively ensures that userspace won't define/declare symbols =
with
> double underscores, i.e. ensures there won't be conflicts.  But pretty mu=
ch all
> of the kernel-defined types are prefixed with "__", e.g. __u8 and friends=
, so I
> don't see how prefixing with "__" exempts something from becoming uAPI.
>
> I completely agree that __KVM_HAVE_READONLY_MEM shouldn't be uAPI, but th=
en it
> really, really shouldn't be defined in arch/x86/include/uapi/asm/kvm.h.
>

