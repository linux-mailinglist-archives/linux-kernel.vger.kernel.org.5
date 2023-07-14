Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C71D75374C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjGNKBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjGNKAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92DE44
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689328804;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=eKV/7hFuiV30Ml3tisHE3vvK+gLZw+sge5BSt5/bp7c=;
        b=C8NqPxjIyANirS1GefiLFg+01bxVKpUPf8uFFH5rwEPsVeAEsKL13WqClGDRexiKc70uq4
        rkASO69bShEbFvyKwg1qRcdu/eqSC8iDhLOCkLFIZM5Qr1ys72A8X6junQNHHXO9TerxjL
        xaKddPyb2UwVKGVSBxvcoEbPxLu5dyQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-xCQsnt1fN5O_RplVmRGsaw-1; Fri, 14 Jul 2023 06:00:02 -0400
X-MC-Unique: xCQsnt1fN5O_RplVmRGsaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7B0C3C01DB0;
        Fri, 14 Jul 2023 10:00:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A65701454142;
        Fri, 14 Jul 2023 09:59:47 +0000 (UTC)
Date:   Fri, 14 Jul 2023 10:59:44 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Luca Boccassi <bluca@debian.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <ZLEckECoBwzxLPAD@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <ZK/9MlTh435FP5Ji@gambale.home>
 <CAMw=ZnRQ0qNg0hT27DWvfZ1DH3dLdu0U7zYN8HvJDx7NPVy_pQ@mail.gmail.com>
 <CAMj1kXEAmsLM0kXLyjRX5bK3b0EzRCGBkUq2DdXknLhwDc7Krg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEAmsLM0kXLyjRX5bK3b0EzRCGBkUq2DdXknLhwDc7Krg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:33:44AM +0200, Ard Biesheuvel wrote:
> On Fri, 14 Jul 2023 at 01:13, Luca Boccassi <bluca@debian.org> wrote:
> >
> > On Thu, 13 Jul 2023 at 14:33, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > Therefore, I don't think it makes sense for the upstream kernel source
> > > to carry a revocation index. It is ultimately up to the owner of the
> > > signing key to decide which value gets signed along with the image, and
> > > this is fundamentally part of the configure/build/release workflow.  No
> > > distro builds and signs the upstream sources unmodified, so each signed
> > > release is a fork anyway, making a upstream revocation index almost
> > > meaningless. Also, while backporting revocation index bumps to -stable
> > > should not result in any issues, I don't think the associated
> > > bookkeeping belongs in the hands of the stable tree maintainers.
> >
> > The reason it's a good idea to store it here is because otherwise
> > there would need to be another external "registry" that matches 1:1,
> > and that is maintained identical everywhere, perfectly in sync,
> > forever, and any 'new' distro and/or distro maintainer would have to
> > discover and use that registry, and would be completely oblivious to
> > it otherwise.
> >
> 
> But why does there need to be a single, shared upstream 'generation
> id' in the first place? The upstream is just a bunch of source files
> that can be built in a million different ways, including for different
> architectures that can all boot via EFI.

To be clear, having an upstream SBAT component & generation id is
not a hard requirement.

It was/is just a best practice, based on the general OSS principal that
if every downstream consumer ends up mostly duplicating each others'
work, then it is usually a better idea to collaborate in the upstream
context and thus do it only once.

This is likely to be less error prone, because while some downstreams
may be informed enough to keep track of everythying an do updates at
the right time, others may not be.

That does put some of the burden onto the upstream maintainer instead,
but that may be tempered by the downstream maintainers responding to a
security issue doing the triage & submitting the needed change (if any)
back to upstream.

If the ultimate outcome of the discussion is that the kernel rejects
the idea of maintaining this info upstream, then downstreams will just
have to do the work individually & try to collaborate in other contexts
to get consistency in their approach. I think that'd be disappointing,
but it wouldn't be show-stopper.


The generation ID is intentionally coarse/crude, because its hard the
requirement of minimizing NVRAM storage over time. So it doesn't try
to distinguish amongst scenarios where some compilation configurations
are vulnerable and some are not. If one scenario needs revoking then
every scenario gets revoked. That's an unfortunate tradeoff, but one
that was / is not easy to avoid given the EFI NVRAM limitations.

It could be possible to have a distinct SBAT component ID per kernel
architecture, if it is anticipated that SecureBoot related flaws might
commonly only affect 1 arch, not all. Separate SBAT component per
arch shouldn't negatively impact NVRAM usage, as any deployment only
needs to deal with its own native arch.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

