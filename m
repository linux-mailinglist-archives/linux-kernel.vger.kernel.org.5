Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8AA7A7D74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjITMJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjITMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278F2D8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695211701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9gjTDHVASAKCokWMOtiChMaZbc6RktsbuYFIDgKDVpo=;
        b=UkssILkWloE2Ytoq7rbya3G+IRJAHpZ9mu72n3hFxbQcrveE2UzWYyncdxG8tD9qupGKX/
        GcO3AKwKIUvx0uwlqLt+HjWqWXI8CSsWXHH5yO24lFwzx7ihEVLUJddDpF1j+Xam2KIbpy
        Zn/0IySETQ8zviWSZNUTyk86zODfMhI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-InwisGL-O5S9OD9YZ3lgtA-1; Wed, 20 Sep 2023 08:08:19 -0400
X-MC-Unique: InwisGL-O5S9OD9YZ3lgtA-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-34fc0587f6aso2801185ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695211699; x=1695816499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gjTDHVASAKCokWMOtiChMaZbc6RktsbuYFIDgKDVpo=;
        b=AjNTDW5Q1hjqO8OdUBr1f6J3UFuXfwJQP7bGZWJsJ6YT/I0orRhypLNciz0758cC2N
         s6sNdLTr1kuN4Qy81NMfsvNpueVZ0AWn3rfsVXPwo77+JsDYTyBON2Vys6YTayY0S6Dv
         BD5pTvILSE58UCAjR1DdVp+tAif0VJqICYb7SeRve4VbWPCXD9p6bF7bhmkTeutnHLJy
         gfLaB1hAycS3IWx07bM4fFNAY+OcBi5BtyVsVEL6eN2j2rlG4ng63vrOHB5GJ2ZXZfGt
         LvDUr0KUkkzD8ImbEqwBvrcjlBGE7M0n4T6ZdGazy+9FiyfU0/ErXTWqC0xVZtCWrphf
         +yqg==
X-Gm-Message-State: AOJu0Yw3Sbu7QPG3LUKEMRfuf0nR9Lm4O1vXd3hkf6vISi7afkbHUyiV
        3TAnN/PaK8MPTLHUVDO8MdaV2h+dM1rRaJuC7iDRvhnrymVkRE9WGg4Jl40KdEdvmZgWQbD4OaZ
        htid0mYrgZHJgl4Ru2Awd1/00LC6iXLfzFESX+g/q
X-Received: by 2002:a92:d58d:0:b0:34c:d535:9f9d with SMTP id a13-20020a92d58d000000b0034cd5359f9dmr2779622iln.1.1695211699037;
        Wed, 20 Sep 2023 05:08:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEndobUX1kqTE6fsmuTy1rK/EW3Xe3ZPyXIJ4TN3BgZiZSImYUMvuETvHMY+D4sdfIqWtrCxyByQJkrBu0Nu0k=
X-Received: by 2002:a92:d58d:0:b0:34c:d535:9f9d with SMTP id
 a13-20020a92d58d000000b0034cd5359f9dmr2779602iln.1.1695211698772; Wed, 20 Sep
 2023 05:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230911052535.335770-1-kernel@jfarr.cc> <20230913160045.40d377f9@rotkaeppchen>
 <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com> <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
 <CALu+AoRiok-bzM4OQbiix44O-PUgO2N6Yi+_qTOn4iWtk_u4cg@mail.gmail.com> <CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
In-Reply-To: <CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Wed, 20 Sep 2023 20:07:58 +0800
Message-ID: <CALu+AoTwqL3y=NhojN2Sb=Ms33id9Nco9QU8JccFrJ_nza5jAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
To:     Ard Biesheuvel <ardb@kernel.org>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 18:50, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 20 Sept 2023 at 08:40, Dave Young <dyoung@redhat.com> wrote:
> >
> > On Wed, 20 Sept 2023 at 15:43, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > > > In the end the only benefit this series brings is to extend the
> > > > > signature checking on the whole UKI except of just the kernel image.
> > > > > Everything else can also be done in user space. Compared to the
> > > > > problems described above this is a very small gain for me.
> > > >
> > > > Correct. That is the benefit of pulling the UKI apart in the
> > > > kernel. However having to sign the kernel inside the UKI defeats
> > > > the whole point.
> > >
> > >
> > > Pingfan added the zboot load support in kexec-tools, I know that he is
> > > trying to sign the zboot image and the inside kernel twice. So
> > > probably there are some common areas which can be discussed.
> > > Added Ard and Pingfan in cc.
> > > http://lists.infradead.org/pipermail/kexec/2023-August/027674.html
> > >
> >
> > Here is another thread of the initial try in kernel with a few more
> > options eg. some fake efi service helpers.
> > https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e
> >
>

Ard, thanks for the comments.

> Currently, UKI's external interface is defined in terms of EFI
> services, i.e., it is an executable PE/COFF binary that encapsulates
> all the logic that performs the unpacking of the individual sections,
> and loads the kernel as a PE/COFF binary as well (i.e., via
> LoadImage/StartImage)
>
> As soon as we add support to Linux to unpack a UKI and boot the
> encapsulated kernel using a boot protocol other than EFI, we are
> painting ourselves into a corner, severely limiting the freedom of the
> UKI effort to make changes to the interfaces that were implementation
> details up to this point.

Agreed, it seems UKI is more flexible and complex than the zboot,
we do need to carefully think about a better solution.

>
> It also means that UKI handling in kexec will need to be taught about
> every individual architecture again, which is something we are trying
> to avoid with EFI support in general. Breaking the abstraction like
> this lets the cat out of the bag, and will add yet another variation
> of kexec that we will need to support and maintain forever.
>
> So the only way to do this properly and portably is to implement the
> minimal set of EFI boot services [0] that Linux actually needs to run
> its EFI stub (which is mostly identical to the set that UKI relies on
> afaict), and expose them to the kexec image as it is being loaded.
> This is not as bad as it sounds - I have some Rust code that could be
> used as an inspiration [1] and which could be reused and shared
> between architectures.

Great!

>
> This would also reduce/remove the need for a purgatory: loading a EFI
> binary in this way would run it up to the point were it calls
> ExitBootServices(), and the actual kexec would invoke the image as if
> it was returning from ExitBootServices().
>
> The only fundamental problem here is the need to allocate large chunks
> of physical memory, which would need some kind of CMA support, I
> imagine?

Hmm, I thought that your idea is to write the efi stub code in "purgatory"
so kexec can jump to it while rebooting then it will be able to access the
whole usable memory, but it seems you want an efi app run under linux
and somehow provide services to kexec?  My EFI knowledge is incomplete
and outdated,  If my understanding of your proposal is true how can it keep
running after switching to the new kernel stub?

>
> Maybe we should do a BoF at LPC to discuss this further?

It does deserve more discussion, unfortunately I will not be able to join LPC,
Philipp Rudo (cced) planned attend the conf, so I think you guys can
discuss together with
other people interested. I think I will watch the recordings or
joining virtually if possible.

>
> [0] this is not as bad as it sounds: beyond a protocol database, a
> heap allocator and a memory map, there is actually very little needed
> to boot Linux via the EFI stub (although UKI needs
> LoadImage/StartImage as well)
>
> [1] https://github.com/ardbiesheuvel/efilite
>

