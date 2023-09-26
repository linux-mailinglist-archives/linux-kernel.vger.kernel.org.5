Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3719E7AF1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjIZRVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjIZRVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758DCE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695748838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hl8P0PehXe7JNy/kAUbNrPxe3ImQTd0Amx2bvocE0Xk=;
        b=gb0m8jZcRHvSDdvXSmNAfPRHH6ibgme5xawboY0+kT0wHaY9RAJTvs7sA8U5ritv8hhmJz
        QFL1ZGYoWjQzWMLCclZ3T+hVnSKDUdN5em/P5pFU47Myrk/BAC4LV7YRs531GTkdGhL0Tj
        puaOKlFohXnIdT3KBYTF/wR2C8tZI4k=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-wJ9wqXIGOqKzK0G9d48-FA-1; Tue, 26 Sep 2023 13:20:37 -0400
X-MC-Unique: wJ9wqXIGOqKzK0G9d48-FA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-45289b05c67so5110583137.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695748836; x=1696353636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hl8P0PehXe7JNy/kAUbNrPxe3ImQTd0Amx2bvocE0Xk=;
        b=ELY8SPYD5oyvhispsx25B+PIevd6OHMvAzUET6oqzqLCK5nQTByXWdTZiKsJqs2tIA
         tOj3w3jSnlfn9bSqMzEqapITwFcLGKJGG82j1l+Ug618rg1N88MwPNPB+l+aaayXGor9
         ZlQNpdn7wvRJFs1inSE6a+a8FfzplAaCf/IUNQSW2IHLn4gTUFm1bh0jRtxpWceE6WQL
         shZ81Uhy075h+hLTuEB2YdiQqi0tBom21svDipGdmOzRv0lLVK+DhV2XgvNhhImTY6no
         hYOd18u11NXl5eE3dcpyY8PyTLZI8Zn/V+N9D4Y4OWKsYbZI4mvjWiKpTmOI7p+GU+1V
         waNA==
X-Gm-Message-State: AOJu0Yz3BBWM90el1eIt8sPWNQbpPQ6F0ii0wU3u7Z8aRaM6z61iVgpw
        7J2iE1FiUM+ZtZbkcstG35fK+hd4V/iob5tOwP68UQdX2L9t2THBiGNoBAIdnJ+OkPTBe9sQS8z
        g9d61vtxb7XRIzyyL8qI08xR8nvxBwMv3JhavfVtN
X-Received: by 2002:a67:b40c:0:b0:452:5df8:b951 with SMTP id x12-20020a67b40c000000b004525df8b951mr7866122vsl.25.1695748836514;
        Tue, 26 Sep 2023 10:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtG5ssRygCikczLM//vmZQQ56XN5Yc2hah1+LcfqviSBpBhHmQW1yO2wDZk2XQOdJfhfItOO2+2CVLUvw5E8M=
X-Received: by 2002:a67:b40c:0:b0:452:5df8:b951 with SMTP id
 x12-20020a67b40c000000b004525df8b951mr7866096vsl.25.1695748836240; Tue, 26
 Sep 2023 10:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <1b52b557beb6606007f7ec5672eab0adf1606a34.camel@infradead.org>
 <CABgObfZgYXaXqP=6s53=+mYWvOnbgYJiCRct-0ob444sK9SvGw@mail.gmail.com>
 <faec494b6df5ebee5644017c9415e747bd34952b.camel@infradead.org>
 <3dc66987-49c7-abda-eb70-1898181ef3fe@redhat.com> <d3e0c3e9-4994-4808-a8df-3d23487ff9c4@amazon.de>
In-Reply-To: <d3e0c3e9-4994-4808-a8df-3d23487ff9c4@amazon.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 26 Sep 2023 19:20:24 +0200
Message-ID: <CABgObfZb4CvzpnSJxz9saw8PJeo1Y2=0uB9y4_K+Cu9P9FpF6g@mail.gmail.com>
Subject: Re: [RFC] KVM: x86: Allow userspace exit on HLT and MWAIT, else yield
 on MWAIT
To:     Alexander Graf <graf@amazon.de>
Cc:     David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@amazon.es>,
        "Griffoul, Fred" <fgriffo@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 6:44=E2=80=AFPM Alexander Graf <graf@amazon.de> wro=
te:
> On 23.09.23 11:24, Paolo Bonzini wrote:
> > Why do you need it?  You can just use KVM_RUN to go to sleep, and if yo=
u
> > get another job you kick out the vCPU with pthread_kill.  (I also didn'=
t
> > get the VSM reference).
>
> With the original VSM patches, we used to make a vCPU aware of the fact
> that it can morph into one of many VTLs. That approach turned out to be
> insanely intrusive and fragile and so we're currently reimplementing
> everything as VTLs as vCPUs. That allows us to move the majority of VSM
> functionality to user space. Everything we've seen so far looks as if
> there is no real performance loss with that approach.

Yes, that was also what I remember, sharing the FPU somehow while
having separate vCPU file descriptors.

> One small problem with that is that now user space is responsible for
> switching between VTLs: It determines which VTL is currently running and
> leaves all others (read: all other vCPUs) as stopped. That means if you
> are running happily in KVM_RUN in VTL0 and VTL1 gets an interrupt, user
> space needs to stop VTL0 and unpause VTL1 until it triggers VTL_RETURN
> at which point VTL1 stops execution and VTL0 runs again.

That's with IPIs in VTL1, right? I understand now. My idea was, since
we need a link from VTL1 to VTL0 for the FPU, to use the same link to
trigger a vmexit to userspace if source VTL > destination VTL. I am
not sure how you would handle the case where the destination vCPU is
not running; probably by detecting the IPI when VTL0 restarts on the
destination vCPU?

In any case, making vCPUs poll()-able is sensible.

Paolo

> Nicolas built a patch that exposes "interrupt on vCPU is pending" as an
> ioeventfd user space can request. That way, user space can know whenever
> a currently paused vCPU has a pending interrupt and can act accordingly.
> You could use the same mechanism if you wanted to implement HLT in user
> space, but still use an in-kernel LAPIC.

