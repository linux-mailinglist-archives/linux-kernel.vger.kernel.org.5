Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE21E7979FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbjIGR1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbjIGR1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB934CC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694107515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/OggNw1/miPktGc+ci31BRP+FmUzQnb0YqvkymMCSY=;
        b=R9u++OPnI+k2Tg5OTwQ2BGiCDTyK5rQsIJhbZQg4PuJlhcn450AFbuj7mI8wi52YbuUTzo
        cvH9B61OPpdeoiJ9Av7e9B4C94uJrVvHrL4vrfXEhWlU1VzzbtUrBxadjCno6+0+HdGiDK
        kcgz3/oo5U/KoHAv1Bdq6U0VeNsL/hk=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-YZZQtMPoO6ODY5WwRHwAVQ-1; Thu, 07 Sep 2023 13:25:13 -0400
X-MC-Unique: YZZQtMPoO6ODY5WwRHwAVQ-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-48d12c648c0so469427e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694107513; x=1694712313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/OggNw1/miPktGc+ci31BRP+FmUzQnb0YqvkymMCSY=;
        b=I7dIs+kpWQ2sPXAuJdCxg3bTGNWifcuScc+doISvKECKyEZRogWY9EPx2Rk3fuo7NS
         Il9ecuyQLt82WTTJeFQTYekUqxEBWUEO493GIub3e7O14CtJkwGA+V43WWsXxyKML61/
         VF5PVWIi4ajxoBNQE1HcbqHbAG72wgR+1kqrdZw1omlKG1nXqYDn93Ff773sZhCtD+7Q
         uPBpM33t/KH4XMgkC4YY7fYM15v7A9Kkj0Vw9fs4LrMJiZtnetz0EEN8VqbU3TgbcSAP
         Z5t+BjwismjsSaj/LUf5QMz0NuxbD3ZcZMUa+IvELzWNmQRVCsCGhEmNYUk+fQAfyuvB
         gMnQ==
X-Gm-Message-State: AOJu0Yy2JyKQst61fvyCWZPOuZWzoSCLB+g2QxVii3wB8kVMZvp86Eol
        72knlok1n+9O7AFG8wndLmiUdjcdeHNDz1LsViqtmHf3K3vacQW6k2grP7u9cjK0uvqvIM+qOJ6
        oZeiaufa8beFgnktR+vR8ViuH3sqPn1LuBG+TuaQn
X-Received: by 2002:a67:fb85:0:b0:44e:8773:8c72 with SMTP id n5-20020a67fb85000000b0044e87738c72mr471110vsr.0.1694107513200;
        Thu, 07 Sep 2023 10:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhxn1D0fWjFQ1Y4HMVqjWJenp+XHu4GQAlpBeL+3lmhOq5kMP3AE5qEO3Ic1zVaOD1QOnI28eqes0wk4MOGHc=
X-Received: by 2002:a67:fb85:0:b0:44e:8773:8c72 with SMTP id
 n5-20020a67fb85000000b0044e87738c72mr471100vsr.0.1694107512915; Thu, 07 Sep
 2023 10:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
 <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com> <20230808200111.nz74tmschph435ri@box>
 <878ra0ck4k.ffs@tglx> <20230825134746.k7hkpa3e7wnsuq7m@box.shutemov.name> <ZOjF2DMBgW/zVvL3@google.com>
In-Reply-To: <ZOjF2DMBgW/zVvL3@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 7 Sep 2023 19:25:01 +0200
Message-ID: <CABgObfZE+1AkEPyXzQQCV5Ssho5hMrBvAi5rFdTKNNAAijhRjw@mail.gmail.com>
Subject: Re: [PATCH] x86/tdx: Mark TSC reliable
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 5:25=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > > TDX aside it might be useful to have a mechanism to select TSC over K=
VM
> > > clock in general.
> >
> > Sean, Paolo, any comment on this?
>
> I would expect the VMM to not advertise KVM clock if the VM is going to r=
un on
> hosts with stable TSCs, i.e. the guest really shouldn't need to do anythi=
ng in.
> But I avoid clocks and timekeeping like the plague, so take that with a g=
rain of
> salt, e.g. maybe there's a good reason to always advertise kvmclock.

Mostly because users avoid clocks and timekeeping _even more_;
advertising kvmclock is safe in general, so userspace does it in case
the VM is later migrated to a machine with unstable TSC.

> For TDX and other paranoid guests, I assume the kernel command line is ca=
ptured
> as part of attestation.   And so the existing "no-kvmclock" param should =
be
> sufficient to ensure the guest doesn't use KVM clock over the TSC, though=
 IIRC
> TDX requires a constant, non-stop TSC, so it's likely not strictly necess=
ary.

As Kirill said, the guest still has to protect itself, so the patch
makes sense (I see a v2 has been posted in the meanwhile).

Paolo

