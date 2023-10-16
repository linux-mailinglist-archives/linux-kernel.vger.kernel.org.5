Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F085F7CB147
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjJPRXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPRXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:23:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4655B9F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:23:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1c66876aso774161966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697477028; x=1698081828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ziSfOVrFPUUVHeu10UoweKHdhwL95UR6sSsnqfpXK6Q=;
        b=HvQ5YeEvctA8aifKS1VFX6xfbbx3IvuRPYON1jqKEBTH/bGZoyl+ixbQ0pO/NV8/qo
         mmFUbag82baeh5YBFHMbS9NPswSRTxJHRdQzDT3KOuLGvJT/ax9grdYcH6LWLn6vA1+O
         45Dpj4bm/uHXzQR0DF8WMsXZyfeJGo20EZUq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477028; x=1698081828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziSfOVrFPUUVHeu10UoweKHdhwL95UR6sSsnqfpXK6Q=;
        b=ZoSpmlsJtChwNKgvgN1Q/mx/+tF8sIIQDdK9/Fb+rysQp+DscxmyCSyK8E2MEjLx/L
         JjxbXmlUgFor6PccCUNaBkHJbyenHPGt/WE5En1e629f+2a2m2ZQXiozMmqm5IeMkP+L
         vzpNvlESticL2yAQIBvrBxu61BEi2+7Zfy7JDyvxSq47XokNy7BIC9RrYx92XT7yD7/m
         VsFEnL9vWxFNcUt1eesgwm1+Tvd4IzywE81wvTiWQTZx3OC+rR/SPSjaI1LCy/SqTBOG
         n6aSLQvMFybhVYFNFUFAvJPiehN80PqrpWbSPPO4BfisqPt1DAujj9bjv/A2LdMNkJXA
         FpHw==
X-Gm-Message-State: AOJu0Yx24DIDOIsDTI0jX4eb1Hv/SieTo0qZ5fflR6p8UFzLMWMsCdzg
        +IBdSUlBJFtWToqd+WhZWvNwQLiJLzU34W3biXlzUg==
X-Google-Smtp-Source: AGHT+IEVSnfFlsK38AYeabEJvzmdOCzBWMKOUw0ZY4LUZt501NPLXYB8pOm4c4UGajThllza4oxjZw==
X-Received: by 2002:a17:906:2da:b0:9b2:ccd8:2d2b with SMTP id 26-20020a17090602da00b009b2ccd82d2bmr28673936ejk.77.1697477028611;
        Mon, 16 Oct 2023 10:23:48 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906071800b009c5c5c2c59csm10624ejb.149.2023.10.16.10.23.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 10:23:47 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9ad8a822508so779347366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:23:47 -0700 (PDT)
X-Received: by 2002:a17:907:78a:b0:9bd:a662:c066 with SMTP id
 xd10-20020a170907078a00b009bda662c066mr9387285ejb.76.1697477026848; Mon, 16
 Oct 2023 10:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org>
In-Reply-To: <20231016143828.647848-1-jeffxu@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Oct 2023 10:23:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
Message-ID: <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     jeffxu@chromium.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, willy@infradead.org,
        mawupeng1@huawei.com, linmiaohe@huawei.com, namit@vmware.com,
        peterx@redhat.com, peterz@infradead.org, ryan.roberts@arm.com,
        shr@devkernel.io, vbabka@suse.cz, xiujianfeng@huawei.com,
        yu.ma@intel.com, zhangpeng362@huawei.com, dave.hansen@intel.com,
        luto@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 07:38, <jeffxu@chromium.org> wrote:
>
> This patchset proposes a new mseal() syscall for the Linux kernel.

So I have no objections to adding some kind of "lock down memory
mappings" model, but this isn't it.

First off, the simple stuff: the commit messages are worthless. Having

   check seal for mmap(2)

as the commit message is not even remotely acceptable, to pick one
random example from the series (7/8).

But that doesn't matter much, since I think the more fundamental
problems are much worse:

 - the whole "ON_BEHALF_OF_KERNEL" and "ON_BEHALF_OF_USERSPACE" is
just complete noise and totally illogical. The whole concept needs to
be redone.

Example of complete nonsense (again, picking 7/8, but that's again
just a random example):

> @@ -3017,8 +3022,8 @@ SYSCALL_DEFINE5(remap_file_pages,
>                 flags |= MAP_LOCKED;
>
>         file = get_file(vma->vm_file);
> -       ret = do_mmap(vma->vm_file, start, size,
> -                       prot, flags, pgoff, &populate, NULL);
> +       ret = do_mmap(vma->vm_file, start, size, prot, flags, pgoff,
> +                       &populate, NULL, ON_BEHALF_OF_KERNEL);
>         fput(file);
>  out:
>         mmap_write_unlock(mm);

Christ. That's *literally* the remap_file_pages() system call
definition. No way in hell does "ON_BEHALF_OF_KERNEL" make any sense
in this context.

It's not the only situation. "mremap() as the same thing. vm_munmap()
has the same thing. vm_brk_flags() has the same thing. None of them
make any sense.

But even if those obvious kinds of complete mis-designs were to be
individually fixed, the whole naming and concept is bogus. The
"ON_BEHALF_OF_KERNEL" thing seems to actually just mean "don't check
sealing". Naming should describe what the thing *means*, not some
random policy thing that may or may not be at all relevant.

 - the whole MM_SEAL_xx vs VM_SEAL_xx artificial distinction needs to go away.

Not only is it unacceptable to pointlessly create two different name
spaces for no obvious reason, code like this (from 1/8) should not
exist:

> +       if (types & MM_SEAL_MSEAL)
> +               newtypes |= VM_SEAL_MSEAL;
> +
> +       if (types & MM_SEAL_MPROTECT)
> +               newtypes |= VM_SEAL_MPROTECT;
> +
> +       if (types & MM_SEAL_MUNMAP)
> +               newtypes |= VM_SEAL_MUNMAP;
> +
> +       if (types & MM_SEAL_MMAP)
> +               newtypes |= VM_SEAL_MMAP;
> +
> +       if (types & MM_SEAL_MREMAP)
> +               newtypes |= VM_SEAL_MREMAP;

Sure, we have that in some cases when there was a *reason* for
namespacing imposed on us from an API standpoint (ie the "open()"
flags that get turned into FMODE_xyz flags, or the MS_xyz mount flags
being turned into MNT_xyz flags), but those tend to be signs of
problems in the system call API where some mixup made it impossible to
use the flags directly (most commonly because there is some extended
internal representation of said things).

For example, the MS_xyz namespace is a combination of "these are flags
for the new mount" (like MS_RDONLY) and "this is how you should mount
it" (like MS_REMOUNT), and so the user interface has that odd mixing
of different things, and the MNT_xyz namespace is a distillation of
the former.

But we certainly should not strive to introduce *new* interfaces that
start out with this kind of mixup and pointless "translate from one
bit to another" code.

 - And finally (for now), I hate that MM_ACTION_xyz thing too!

Why do we have MM_ACTION_MREMAP, and pointless like this (from 3/8):

> +       switch (action) {
> +       case MM_ACTION_MPROTECT:
> +               if (vma->vm_seals & VM_SEAL_MPROTECT)
> +                       return false;
> +               break;

when the sane thing to do is to use the *same* MM_SEAL_xyz bitmask and
sealing bitmask and just say

        if (vma->vm_seal & vm_action)
                return -EPERM;

IOW, you have pointlessly introduced not *two* different namespaces,
but *three*. All doing the exact same thing, and all just causing
pointless and ugly code to "translate" the actions of one into the
model of another.

So get rid of the "MM_ACTION_xyz" thing. Get rid of ther "VM_SEAL_xyz"
thing. Use *one* single "these are the sealing bits".

And get rid of "enum caller_origin" entirely. I don't know what the
right model for that thing is, but that isn't it.

*Maybe* the right model is some MM_SEAL_OVERRIDE bit that user space
cannot set, but that the kernel can use internally - and if that is
the right model, then dammit, the *uses* should be very very obvious
why the override is fine, because that remap_file_pages() use sure as
hell was *not* obvious.

In fact, it's not at all obvious why anything should override the
sealing bits - EVER. So I'm not convinced that the right model is
"replace ON_BEHALF_OF_KERNEL with MM_SEAL_OVERRIDE". Why would we
*ever* want to override sealing? It sounds like complete garbage. Most
of the users seem to be things like "execve()", which is nonsensical,
since the VM wouldn't have been sealed at that point _anyway_, so
having a "don't bother checking sealing bits" flag seems entirely
useless.

Anyway, this is all a resounding NAK on this series in this form. My
complaints are not some kind of small "fix this up". These are
fundamental issues.

            Linus
