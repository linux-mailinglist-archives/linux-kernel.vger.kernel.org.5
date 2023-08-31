Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C845578F21A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbjHaRok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjHaRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C300E5F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693503831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbNtR3x5h1n+MpnWUotTWnTTRtqAlLh7xBmJIFkm6Kc=;
        b=anQ6x/7vWF1q+9HGoD6Uot0oMutGxuY0MBHchujzD7ImmmiAHtbZez0XszpqXGlQidGGyB
        HrzOXidymHEHvej/glVRxYSluNVrM/BHcHEFAZSe7SPR9YuHkkvoo55h/N64qimt34ohZR
        z3L2mBGLPCbl/tjMXL4P5lotHO7yWFo=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-jgjIt1-zMAe8KDSycBC33g-1; Thu, 31 Aug 2023 13:43:49 -0400
X-MC-Unique: jgjIt1-zMAe8KDSycBC33g-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-44d5f9dbb22so480018137.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503829; x=1694108629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbNtR3x5h1n+MpnWUotTWnTTRtqAlLh7xBmJIFkm6Kc=;
        b=cA7YOAn/5yJAygcD00WiGFhj58VMFJIXppdQ61elOeqxwoSkUWz8yX6nD3lD1L0Q9X
         5v2LnEz4YIxCOa/PJAvj9gn4qweJvHQBacnynRyL2mbPTzUapJ82k/Tg+uOmZvJtQwIJ
         zwMRPcxyDufzE1sGcLu5QNqQ943UGrBMAvZvq682UTl03uTHwNGGVXOtSJnc06NiEqS8
         QJdkfYyW08nHNtNTxsauPFn8nvFYjNv5D/ckKiO4aABSzdMQLClQZRpRB0pOFU5c+wm6
         KcM40UhdG9GITeDsAhRjizIyYpnQVEm4KopnVDo2RqrU8a4Rpsf+7mZ5osiQdDEXwdOu
         FJ2w==
X-Gm-Message-State: AOJu0YweQqVJIRhxNAWAK3t9U/ovsZVNt9lDzzw2jDIcvTn1G79+moib
        xHErNNFMqpJV3vNy04V3p60B9Ngl1pchQBoLe39rfk3ONvjdoUHYARb0vyM0t/pwGvFF8Ad2yWs
        dRaLXqZyDIOx3KD9C4nHak96S5AMN4LzKJn+W4gDK
X-Received: by 2002:a67:b348:0:b0:44d:4dd6:7966 with SMTP id b8-20020a67b348000000b0044d4dd67966mr270868vsm.34.1693503829217;
        Thu, 31 Aug 2023 10:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Lhu9D2uLY3G5GKeuGfkfL01e+wQA6XurYaOrmtPNMsRlMc3ZXV57VRUQeP13vNV2mHG+roIxYBshzXXxBEg=
X-Received: by 2002:a67:b348:0:b0:44d:4dd6:7966 with SMTP id
 b8-20020a67b348000000b0044d4dd67966mr270855vsm.34.1693503829033; Thu, 31 Aug
 2023 10:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230830000633.3158416-1-seanjc@google.com> <20230830000633.3158416-4-seanjc@google.com>
 <ZPDNielH+HOYV89u@google.com>
In-Reply-To: <ZPDNielH+HOYV89u@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 31 Aug 2023 19:43:37 +0200
Message-ID: <CABgObfZoJjz1-CMGCQqNjA8i_DivgevEhw+EqfbD463JAMe_bA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: MMU changes for 6.6
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
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

On Thu, Aug 31, 2023 at 7:27=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> +Like
>
> On Tue, Aug 29, 2023, Sean Christopherson wrote:
> > Please pull MMU changes for 6.6, with a healthy dose of KVMGT cleanups =
mixed in.
> > The other highlight is finally purging the old MMU_DEBUG code and repla=
cing it
> > with CONFIG_KVM_PROVE_MMU.
> >
> > All KVMGT patches have been reviewed/acked and tested by KVMGT folks.  =
A *huge*
> > thanks to them for all the reviews and testing, and to Yan in particula=
r.
>
> FYI, Like found a brown paper bag bug[*] that causes selftests that move =
memory
> regions to fail when compiled with CONFIG_KVM_EXTERNAL_WRITE_TRACKING=3Dy=
.  I'm
> redoing testing today with that forced on, but barring more falling, the =
fix is:

Ok, I'll apply these by hand.

Paolo

