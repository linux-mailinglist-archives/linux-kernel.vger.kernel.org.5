Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A17379CE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjILKfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbjILKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:33:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5C1199C;
        Tue, 12 Sep 2023 03:33:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DE0C433C8;
        Tue, 12 Sep 2023 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694514792;
        bh=G6tVIRokXJPGvWKTOTzEY6bZMaPMLiU8C0XfnDPSZEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q70e/AuK1dlDgyzk41Krdj9+9w+iAK60hbwst/thT3/E+V0KBqHGq1bFVgnz1Y5tE
         BNcZP8gyWxZmWST7xvNT50QLa1ma63GmiAsqDWy8g7fdExd57pqsnNBpEGG5y1CZZ4
         2heJ6mtCFwi67ozo4eMk4t6tHr94WJ0+E7dwbUXTNqGn7j9LaJoii57znlFVGsSLTr
         CalxdbClCdh/LrVxIBFE7zWni43Mp/BcEIcZiCJ88jtqnZd7S+8SJsueC3Lp4b40+d
         +fJZjQLcQazODhw0TaBJUbAqaBJzs0VoOyrGVHiL5tqKRbPbbB7mhVtMICse6Raz7p
         hKI6oYLR2eDCg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 13:33:07 +0300
Message-Id: <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jan Hendrik Farr" <kernel@jfarr.cc>,
        <linux-kernel@vger.kernel.org>
Cc:     <kexec@lists.infradead.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <dhowells@redhat.com>, <vgoyal@redhat.com>,
        <keyrings@vger.kernel.org>, <akpm@linux-foundation.org>,
        <bhe@redhat.com>, <bhelgaas@google.com>, <lennart@poettering.net>,
        "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
In-Reply-To: <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 12, 2023 at 1:54 AM EEST, Jan Hendrik Farr wrote:
> > What the heck is UKI?
>
> UKI (Unified Kernel Image) is the kernel image + initrd + cmdline (+
> some other optional stuff) all packaged up together as one EFI
> application.
>
> This EFI application can then be launched directly by the UEFI without
> the need for any additional stuff (or by systemd-boot). It's all self
> contained. One benefit is that this is a convenient way to distribute
> kernels all in one file. Another benefit is that the whole combination
> of kernel image, initrd, and cmdline can all be signed together so
> only that particular combination can be executed if you are using
> secure boot.

Is this also for generic purpose distributions? I mean it is not
uncommon having to tweak the command-line in a workstation.

> The format itself is rather simple. It's just a PE file (as required
> by the UEFI spec) that contains a small stub application in the .text,
> .data, etc sections that is responsible for invoking the contained
> kernel and initrd with the contained cmdline. The kernel image is
> placed into a .kernel section, the initrd into a .initrd section, and
> the cmdline into a .cmdline section in the PE executable.

How does this interact with the existing EFI stub support in linux?

> If we want to kexec a UKI we could obviously just have userspace pick
> it apart and kexec it like normal. However in lockdown mode this will
> only work if you sign the kernel image that is contained inside the
> UKI. The problem with that is that anybody can then grab that signed
> kernel and launch it with any initrd or cmdline. So instead this patch
> makes the kernel do the work instead. The kernel verifies the
> signature on the entire UKI and then passes its components on to the
> normal kexec bzimage loader.
>
> Useful Links:
> UKI format documentation: https://uapi-group.org/specifications/specs/uni=
fied_kernel_image/
> Arch wiki: https://wiki.archlinux.org/title/Unified_kernel_image
> Fedora UKI support: https://fedoraproject.org/wiki/Changes/Unified_Kernel=
_Support_Phase_1

BR, Jarkko
