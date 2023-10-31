Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3507DCFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbjJaO4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344312AbjJaO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72934ED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698764147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YCRruDl6OMQ5U1GQ6BskW58Z9wjcFbobewT68lDnqA=;
        b=GTKZj3rE42Ym4MDkSvmztVBYbhFzTJKEEbo83b1nFdaxfLNwu5nh3TpacdFYHLBSjuDpeZ
        3RBC9CX7mXTvTRZhGY0ko+b4lprNAARO9b9YtO+svxnl6FZ+U/iz5Bm658RfA4iJvsnjO4
        YbmH+R9l2XSQNYaz/z5sNxFyq/3wM4s=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-OWlq8SlRObyoFGzDN2TBkg-1; Tue, 31 Oct 2023 10:55:31 -0400
X-MC-Unique: OWlq8SlRObyoFGzDN2TBkg-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7abdebc829aso1419742241.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698764130; x=1699368930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YCRruDl6OMQ5U1GQ6BskW58Z9wjcFbobewT68lDnqA=;
        b=ZRX9QAqSvwuvBAkjYXxSdihjxgJTF54hm7aALsM5AXyXKhlBdx9yj1hip4GEboIYmD
         Elg1CPANQnjll+EIxd/qi7ZrwyqkFl4zji/TBvnelXqS2mKVbJ/Qh6jR6+OKQ12ANSM8
         Jy+8dGgovWcuqhmLGN28HElttoLOhcyD8VX7wdKkU1kGnu13XCntfF9A64K/AGVuLb0x
         FoiY3zrOI7ntvFlsbCYg/+dJBR6q06ZQCH2KmhTMgSq40Kv+qpGt2/a0UxGzV8ng4bjN
         zkW65bKkVgu5zF0i7W+/fIiadtHPayqOXNiA0ra0ud80MsSLpUyhgQd25jGaB6TBHUhv
         XF7w==
X-Gm-Message-State: AOJu0YwgOoqJkitmd/JraBaFtAuiSj0MZm3IMJjh9S9moAz5xMMOjPoK
        7e0+fWMUHthO18mBhhL66shKNByFwqfW24kHCc+VMmCunnSPzU4xjGHpaEktwwdZtSA1fhvJBBf
        C+Ntv805McFFoRPRJ+eUt1Vjhd9MMl1mKRHDymmU8
X-Received: by 2002:a67:c29c:0:b0:457:fbe2:b8f with SMTP id k28-20020a67c29c000000b00457fbe20b8fmr11706253vsj.10.1698764130179;
        Tue, 31 Oct 2023 07:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAXxnaP57nokfR3Tx/vX2Yin3rTsz3GNvzufgEQz//hZr645kybcUed77JHMhu9kMGhV4N9spVToWKcQqNL2c=
X-Received: by 2002:a67:c29c:0:b0:457:fbe2:b8f with SMTP id
 k28-20020a67c29c000000b00457fbe20b8fmr11706218vsj.10.1698764129460; Tue, 31
 Oct 2023 07:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231027204933.3651381-1-seanjc@google.com> <20231027204933.3651381-7-seanjc@google.com>
In-Reply-To: <20231027204933.3651381-7-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 31 Oct 2023 15:55:17 +0100
Message-ID: <CABgObfarUg_qsGBnDyHGEXdazq8NPuzjpwdnHbDE6o5jOOou8g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: SVM changes for 6.7
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:49=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> An enhancement to help userspace deal with SEV-ES guest crashes, and clea=
nups
> related to not being able to do "skip" emulation for SEV guests.
>
> The following changes since commit 5804c19b80bf625c6a9925317f845e497434d6=
d3:
>
>   Merge tag 'kvm-riscv-fixes-6.6-1' of https://github.com/kvm-riscv/linux=
 into HEAD (2023-09-23 05:35:55 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-svm-6.7
>
> for you to fetch changes up to 00682995409696866fe43984c74c8688bdf8f0a5:
>
>   KVM: SVM: Treat all "skip" emulation for SEV guests as outright failure=
s (2023-10-04 15:08:53 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM SVM changes for 6.7:
>
>  - Report KVM_EXIT_SHUTDOWN instead of EINVAL if KVM intercepts SHUTDOWN =
while
>    running an SEV-ES guest.
>
>  - Clean up handling "failures" when KVM detects it can't emulate the "sk=
ip"
>    action for an instruction that has already been partially emulated.  D=
rop a
>    hack in the SVM code that was fudging around the emulator code not giv=
ing
>    SVM enough information to do the right thing.
>
> ----------------------------------------------------------------
> Peter Gonda (1):
>       KVM: SVM: Update SEV-ES shutdown intercepts with more metadata
>
> Sean Christopherson (2):
>       KVM: x86: Refactor can_emulate_instruction() return to be more expr=
essive
>       KVM: SVM: Treat all "skip" emulation for SEV guests as outright fai=
lures
>
>  arch/x86/include/asm/kvm-x86-ops.h |  2 +-
>  arch/x86/include/asm/kvm_host.h    |  4 +--
>  arch/x86/kvm/svm/svm.c             | 50 ++++++++++++++++----------------=
------
>  arch/x86/kvm/vmx/vmx.c             | 12 ++++-----
>  arch/x86/kvm/x86.c                 | 22 +++++++++++------
>  5 files changed, 45 insertions(+), 45 deletions(-)
>

