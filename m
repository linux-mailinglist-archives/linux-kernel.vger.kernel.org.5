Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79BE78F201
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbjHaRdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345099AbjHaRda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715EFE63
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693503160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNmZ0/K+kEOCBEth9KBuqCdBWRyjPscLMHE6sl2tKjg=;
        b=PBY2K6wN0ys+XMJL/xzApE/98r+zMeSRc7b2+2rx4uo5KM/c+QaYIIop4Rz1ARe0kYs3qZ
        6oHbTL0AlvJdm1Ap3czXhla4luMxrPvo133Y5pJPxTvUVh4/D5Jwk2k8IRdce0mKGRbley
        hey7aC5+tc1iLd7z7oAwApJ/AJsVPEg=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-CMwRVDhoNjK9_HpPBHS39A-1; Thu, 31 Aug 2023 13:32:39 -0400
X-MC-Unique: CMwRVDhoNjK9_HpPBHS39A-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7a28090eb26so455130241.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503157; x=1694107957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNmZ0/K+kEOCBEth9KBuqCdBWRyjPscLMHE6sl2tKjg=;
        b=QLRraEc2JiLH5cx7OSJ7wssFqNmdT1e6gJPn6gEjonV3VIARwk1njB9DBmIVzHhSxk
         lBpzRQRtDfP2oA6m97eAK+7bZKXITxzVpSntk9Js8SYwNkmoCvNk1LGkgfoxsAaYMYta
         ZeIGQLAM/2x7hukrK1+bn97deBYlNEsjt8ZsKcsVgBQUxfBywdumqg0st4sKox270/nT
         S7SE+AY6NhZFtJ/HohDT4H942P3VCVzqjvQsNZ1GjHZjR4udAAY3unuooXd1N5N5syTk
         4uuavBeXcC/YH01K30ed+Q30yYTPxlwGpdliIX9Q0sRPptnNq+36VwyxAQiCOg3opjcg
         Kp3g==
X-Gm-Message-State: AOJu0Ywhedt71LjVRu2psW23haiVjuVp9e2ilGOJ0g63Zz2eyrKxxEff
        62Z9F6tSnjTLXiynTx3E5sUzizEhUVWdHeBc/7VxoGOarbaaU5QJZbzK2bqD7g28aIKZYf8sSHz
        OldpaosMk0xN6ijrilTTYgaBay9wBBuJ4+83bb6u6tXN7ZeN/
X-Received: by 2002:a67:eb46:0:b0:44e:a94f:1019 with SMTP id x6-20020a67eb46000000b0044ea94f1019mr276362vso.31.1693503157744;
        Thu, 31 Aug 2023 10:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgtWLWSRWV9Tj2VJX44oQhCgZhdVwWYSnDwjHCG4Yfnl4QLYFfBVH0SI91ljVnEZ15wnJ3TWcBUYKJlmtC7l4=
X-Received: by 2002:a67:eb46:0:b0:44e:a94f:1019 with SMTP id
 x6-20020a67eb46000000b0044ea94f1019mr276338vso.31.1693503157512; Thu, 31 Aug
 2023 10:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230830000633.3158416-1-seanjc@google.com> <20230830000633.3158416-8-seanjc@google.com>
In-Reply-To: <20230830000633.3158416-8-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 31 Aug 2023 19:32:26 +0200
Message-ID: <CABgObfYiQMZtrgy4rrDM6ydxxqc90FUpUASY7HOaoPrOFwe6Aw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: VMX changes for 6.6
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 30, 2023 at 2:07=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> VMX changes for 6.6.  Nothing mindblowing, by far the most interesting ch=
ange
> is the super late fix for NMI VM-Exits that you've already looked at.
>
> The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b57=
4c:
>
>   Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-6.6
>
> for you to fetch changes up to 50011c2a245792993f2756e5b5b571512bfa409e:
>
>   KVM: VMX: Refresh available regs and IDT vectoring info before NMI hand=
ling (2023-08-28 20:07:43 -0700)
>
> ----------------------------------------------------------------
> KVM: x86: VMX changes for 6.6:
>
>  - Misc cleanups
>
>  - Fix a bug where KVM reads a stale vmcs.IDT_VECTORING_INFO_FIELD when t=
rying
>    to handle NMI VM-Exits

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> Sean Christopherson (3):
>       KVM: VMX: Drop manual TLB flush when migrating vmcs.APIC_ACCESS_ADD=
R
>       KVM: VMX: Delete ancient pr_warn() about KVM_SET_TSS_ADDR not being=
 set
>       KVM: VMX: Refresh available regs and IDT vectoring info before NMI =
handling
>
> Shiyuan Gao (1):
>       KVM: VMX: Rename vmx_get_max_tdp_level() to vmx_get_max_ept_level()
>
>  arch/x86/kvm/vmx/vmx.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
>

