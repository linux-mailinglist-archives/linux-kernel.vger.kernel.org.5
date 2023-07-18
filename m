Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B026D75823D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjGRQgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGRQgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E663118
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689698129;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUR0oJybeI4oXO29z6+EY+F38K+4Hu0LKW46ZxDd5hY=;
        b=KPsza9ZqUwuoPFMw4NsSsJa6HV9S00SgBW9AK52wV4QX4FgZGBSetWKytZX7doAxE5pvBB
        mT7vFPWUOmN+GOhJ9dfOh6Rc/SWJd6jN+3Fq5rDzHZz3eg1mkCNo0sZNVHzDS+0qeMaWTU
        w7Z3ll5H7mck/09qf/9AQkgHyXs1mOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-KcKh7oGhNN-4GhLOh-3J8A-1; Tue, 18 Jul 2023 12:35:26 -0400
X-MC-Unique: KcKh7oGhNN-4GhLOh-3J8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1C7D8F184C;
        Tue, 18 Jul 2023 16:35:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA8F540C2070;
        Tue, 18 Jul 2023 16:35:21 +0000 (UTC)
Date:   Tue, 18 Jul 2023 17:35:19 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Luca Boccassi <bluca@debian.org>, Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <ZLa/R9tZ0hB0KOXj@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <ZK/9MlTh435FP5Ji@gambale.home>
 <df7941b9-11ea-9abd-e070-4e9926aecdc3@redhat.com>
 <CAMw=ZnTSyeL4x1o_GVKNsZdCUe2D2H53quK-TSFhOkuONjC73A@mail.gmail.com>
 <CABgObfb_jGgs-yMSsHtHhEStFDp4f072LN7pW+3dSuVhAP87Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfb_jGgs-yMSsHtHhEStFDp4f072LN7pW+3dSuVhAP87Ag@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:51:56PM +0200, Paolo Bonzini wrote:
> On Tue, Jul 18, 2023 at 4:03 PM Luca Boccassi <bluca@debian.org> wrote:
> > > So perhaps there could be some kind of protocol that would let a new
> > > kernel tell the bootloader "don't boot an older kernel than me in the
> > > future".  It could even be an extension to the SBAT spec itself.  I
> > > haven't really thought much about it, tbh.  However, I'm quite positive
> > > that a revocation index attached to the kernel image cannot really work
> > > as a concept, not even if it is managed by the distro.
> >
> > You are pretty much describing SBAT there. Except for the detail that
> > it can't be the component that can be compromised that tells you
> > whether it's compromised and you should trust it... A system's SBAT
> > policy is a single entity, managed centrally, and deployed everywhere.
> 
> Fine, so can the SBAT spec be extended to have some kind of version
> that is not a single number? If that is provided, Linux could have the
> mechanism to place the kernel version in the .sbat section. But I
> agree with Borislav, Greg and others that a single revocation index
> simply doesn't cut it.

In theory it could already be treated as being a version if you were
to just encode the 3 version number components into an integer.

There's a slight caveat that when parsing sbat shim currently appears
to store the generation number in a uint16, so the size is somewhat
limited. Probably still just enough bits to encode a kernel version,
though changing shim code to uint32 looks easy enough too.

Directly encoding the version number though has implications for
revokation wrt stable branches though. My impression is that the
generation number was intentionally separate from a version number,
so that people could backport particular fixes to a stable branch
and then declare it to be the same "generation" as the latest
devel branch, or other stable branches which also included the
equiv fixes.

Obviously that presumes that an old branch can be made secure by
selectively backporting patches. That is a view which is obviously
not universally accepted, especially in upstream context, as clearly
expressed in several mails in this thread. It is what distros would
typically claim to achieve though. I'm not sure it is possible to
satisfy both those differing views.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

