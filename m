Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9DB7A79B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjITKu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjITKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:50:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AB183;
        Wed, 20 Sep 2023 03:50:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DF1C433C7;
        Wed, 20 Sep 2023 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695207044;
        bh=bIXhOQis1Sn3vDslhC5JOJ46taY/IsHYFumVE4W8Y80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VXqJG4lV3wtMjenjbKnz4AsLWvuuyyOBcDoFkIXAx3ndSX+O49DrlYN1AqVyqX4PU
         QXSS5Bg8hKoR/QVFgvpH0fjCclcmCfzRCxUrD9TSgcCC79ofxZdWT8qPRmN9jXAdXM
         lgdug6jqMidDA+9D+lycVhB/tiadWlYrg41eb6q8Pm5DEqS+fnIFUundXOL+JEAEY5
         5nMdbQszsrad83IuEmIReGPc2N9dhNAfboNZlzbrHI90mSQnAZEyMi2LLAdGT5QoXK
         CCjGrUcxHYC14nbFOePBYzOMi47JSYtSEasazxqIbtVgtZ7YOALF03bd4JNal/qJwS
         gdzCflxF3WNKw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2bffa8578feso61283241fa.2;
        Wed, 20 Sep 2023 03:50:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YwEgUJsW3jNF9WKIFl/YO+NKZf5XWrA3x8eF0NJmrkBfBOwasyW
        cHiyOGwpqn11wGf9idKBjM4ylatBl7Ku1D1eebc=
X-Google-Smtp-Source: AGHT+IHfM05co9ZEeBSxDjJRZrcRdy68odWxBS48uGxXpH1ue24f8M12y+gEOGX0fSu6rxr+dxPeMYdxQNv8JVZ2Hhc=
X-Received: by 2002:a2e:86d6:0:b0:2bc:cc1a:139c with SMTP id
 n22-20020a2e86d6000000b002bccc1a139cmr1796132ljj.11.1695207042721; Wed, 20
 Sep 2023 03:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230911052535.335770-1-kernel@jfarr.cc> <20230913160045.40d377f9@rotkaeppchen>
 <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com> <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
 <CALu+AoRiok-bzM4OQbiix44O-PUgO2N6Yi+_qTOn4iWtk_u4cg@mail.gmail.com>
In-Reply-To: <CALu+AoRiok-bzM4OQbiix44O-PUgO2N6Yi+_qTOn4iWtk_u4cg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 20 Sep 2023 10:50:31 +0000
X-Gmail-Original-Message-ID: <CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
Message-ID: <CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
To:     Dave Young <dyoung@redhat.com>
Cc:     Jan Hendrik Farr <kernel@jfarr.cc>,
        Philipp Rudo <prudo@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>,
        bhelgaas@google.com, Luca Boccassi <bluca@debian.org>,
        lennart@poettering.net, "Liu, Pingfan" <piliu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 08:40, Dave Young <dyoung@redhat.com> wrote:
>
> On Wed, 20 Sept 2023 at 15:43, Dave Young <dyoung@redhat.com> wrote:
> >
> > > > In the end the only benefit this series brings is to extend the
> > > > signature checking on the whole UKI except of just the kernel image.
> > > > Everything else can also be done in user space. Compared to the
> > > > problems described above this is a very small gain for me.
> > >
> > > Correct. That is the benefit of pulling the UKI apart in the
> > > kernel. However having to sign the kernel inside the UKI defeats
> > > the whole point.
> >
> >
> > Pingfan added the zboot load support in kexec-tools, I know that he is
> > trying to sign the zboot image and the inside kernel twice. So
> > probably there are some common areas which can be discussed.
> > Added Ard and Pingfan in cc.
> > http://lists.infradead.org/pipermail/kexec/2023-August/027674.html
> >
>
> Here is another thread of the initial try in kernel with a few more
> options eg. some fake efi service helpers.
> https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e
>

Currently, UKI's external interface is defined in terms of EFI
services, i.e., it is an executable PE/COFF binary that encapsulates
all the logic that performs the unpacking of the individual sections,
and loads the kernel as a PE/COFF binary as well (i.e., via
LoadImage/StartImage)

As soon as we add support to Linux to unpack a UKI and boot the
encapsulated kernel using a boot protocol other than EFI, we are
painting ourselves into a corner, severely limiting the freedom of the
UKI effort to make changes to the interfaces that were implementation
details up to this point.

It also means that UKI handling in kexec will need to be taught about
every individual architecture again, which is something we are trying
to avoid with EFI support in general. Breaking the abstraction like
this lets the cat out of the bag, and will add yet another variation
of kexec that we will need to support and maintain forever.

So the only way to do this properly and portably is to implement the
minimal set of EFI boot services [0] that Linux actually needs to run
its EFI stub (which is mostly identical to the set that UKI relies on
afaict), and expose them to the kexec image as it is being loaded.
This is not as bad as it sounds - I have some Rust code that could be
used as an inspiration [1] and which could be reused and shared
between architectures.

This would also reduce/remove the need for a purgatory: loading a EFI
binary in this way would run it up to the point were it calls
ExitBootServices(), and the actual kexec would invoke the image as if
it was returning from ExitBootServices().

The only fundamental problem here is the need to allocate large chunks
of physical memory, which would need some kind of CMA support, I
imagine?

Maybe we should do a BoF at LPC to discuss this further?

[0] this is not as bad as it sounds: beyond a protocol database, a
heap allocator and a memory map, there is actually very little needed
to boot Linux via the EFI stub (although UKI needs
LoadImage/StartImage as well)

[1] https://github.com/ardbiesheuvel/efilite
