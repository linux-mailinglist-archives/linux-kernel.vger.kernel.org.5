Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE9A7C7148
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379300AbjJLPTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379223AbjJLPTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2130D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697123909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hv5P43oKEAvFZ6n9aYfnZBkLQfH7TMziNFT/6xuiaHQ=;
        b=MJCXmsaDFxuQ90tsiRvJEirDGOQL3VaIxoIcUMIzoGrw5xCzi52v0o5tqp+lsuPErKEMkl
        4W/MzqtG4Sq6El+f5sTOwAtdZiiNePusQ2S5msze/QNafj5/GH2+gato4T03jB06u+s6Ua
        V9sargjQZ8k/HQUnlIl7S7kg1AeQIuI=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-FlanP9GaO26gKOoC9vENOQ-1; Thu, 12 Oct 2023 11:18:12 -0400
X-MC-Unique: FlanP9GaO26gKOoC9vENOQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-457bc85ac53so52944137.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697123892; x=1697728692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hv5P43oKEAvFZ6n9aYfnZBkLQfH7TMziNFT/6xuiaHQ=;
        b=d9cVUidcprdPi9pQOBvZ86kX0NyHndZytau3RbOXTPejLfHEZAGuRTJl/chO3VS5+N
         veCrGIBNc7SsdnwXWUn7y5uBy6E+vX4VWilsUuR+U0CKYmx9bT+O1l+2UtjqCdtmtq8i
         9tdkn2dVQRxvZRqyDJzfgUAzqXotmrWtumy8Vh7lRvxC5feAKdzajMbM9pouAmrTGu6j
         SEfUqe+gzY/UllEzGuZwIjKbGbkzGvYjuuUtq6a9seaEeWJ2mhjEOINadDL0sbf4aqPK
         MKHkmmUi+zjtc04ewt0nrfZwRvRDNiNKW9RjTPZLw2nbtGVzqQ5vOeYe87MY8D0sZlrr
         3HwQ==
X-Gm-Message-State: AOJu0YxF1Xl8IaHOw7JdHqPeFomls2wBx0VIkkTyjZNmr1PvMArvYwQy
        iv1EF3HJAQv39GOZGJhoAwrok6cip8/mY/fxRFBrP8+9wzfFjxcE/IgAu0bz3NdzYxnOAu9juKI
        pOq9lGck4SOFecU5cKzh/lTLKm8qb7948SyzSYGHW
X-Received: by 2002:a05:6102:3d0a:b0:44e:8626:71f2 with SMTP id i10-20020a0561023d0a00b0044e862671f2mr22039163vsv.13.1697123892159;
        Thu, 12 Oct 2023 08:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBNyWxcZmfVJRlq4Pd9a/3m/udTn/3W6XtpxOGOI/a95VPzronN+92jtFhhPc0gRK2z/j8d60xOLVLvtMLn1g=
X-Received: by 2002:a05:6102:3d0a:b0:44e:8626:71f2 with SMTP id
 i10-20020a0561023d0a00b0044e862671f2mr22039149vsv.13.1697123891899; Thu, 12
 Oct 2023 08:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231006205415.3501535-1-kuba@kernel.org> <ZSQ7z8gqIemJQXI6@google.com>
 <20231009110613.2405ff47@kernel.org> <ZSRVoYbCuDXc7aR7@google.com>
 <20231009144944.17c8eba3@kernel.org> <87sf6i6gzh.fsf@intel.com>
 <20231010072359.0df918e9@kernel.org> <ZSXiapPMIPj3ko41@google.com>
In-Reply-To: <ZSXiapPMIPj3ko41@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 12 Oct 2023 17:17:59 +0200
Message-ID: <CABgObfa=k+xHztWPhWU31UqTgnoO=Yn7uT+9W-G9S7VW_HciQA@mail.gmail.com>
Subject: Re: [PATCH] KVM: deprecate KVM_WERROR in favor of general WERROR
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 1:46=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> > > The DRM_I915_WERROR config depends on EXPERT and !COMPILE_TEST, and t=
o
> > > my knowledge this has never caused issues outside of i915 developers =
and
> > > CI.
> >
> > Ack, I think you do it right. I was trying to establish a precedent
> > so that we can delete these as soon as they cause an issue, not sooner.
>
> So isn't the underlying problem simply that KVM_WERROR is enabled by defa=
ult for
> some configurations?  If that's the case, then my proposal to make KVM_WE=
RROR
> always off by default, and "depends on KVM && EXPERT && !KASAN", would ma=
ke this
> go away, no?

No objection to adding EXPERT. Adding W=3D1 when build-testing KVM
patches is a good
idea, you will still get the occasional patch from someone who didn't
have it but that's fine.

I added KVM_WERROR a relatively long time ago after a warning scrolled
away too quickly (a
harmless one, but also a kind that honestly shouldn't have made it to
Linus). At the time there
were still too many warnings to enable WERROR globally, and I feel
that now we're on the
same boat with W=3D1. I think we should keep KVM_WERROR (which was based on
DRM_I915_WERROR indeed) and maintainers should just add W=3D1 when build-te=
sting
KVM patches.

Paolo

