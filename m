Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27D77E1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245249AbjHPM3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245270AbjHPM3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D252718
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692188853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ijKYo6YIrYvwnBAnXfDfO1VnMtwxZii0rV5a4PpvoTc=;
        b=iWKmKyso5NdYaqhQdAF1kUR7Q7i0oski5lBLe71yBxapBB7pS7iSIvh9lcJd0AWyhOhh+R
        Qx8pij2pZpzoQO4BYKJ/zUcbp2vv9ArX4st3ginUOImVBo3EqYAGl1MHTuFvtnQfBGYlRG
        nr49BwEzn1+Ctg+bjsup0C7ENGh4xl0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-DwvFF-UiNjWlm0MM59Iu9w-1; Wed, 16 Aug 2023 08:27:30 -0400
X-MC-Unique: DwvFF-UiNjWlm0MM59Iu9w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993eeb3a950so369203766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692188849; x=1692793649;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijKYo6YIrYvwnBAnXfDfO1VnMtwxZii0rV5a4PpvoTc=;
        b=S+NL2Svq6qlGRBQ3zbVqO5u6gP8mKhDYEXb62GHobROMr/axfy7Gt4Hfz0nSy31mnY
         dvcqPlnD4jQywcY6O11a378iENuBF3Lp2KHEbEQtsjfVNBZc25nLYxGmiACPkbr6aKhl
         MIsk+rid0JKJYp2C45N0S/OD2uDgj7SLsefiaqyFfRNZwrEYNVEUdjnT9eUllP2KXxwS
         qOgNSZ1DJbzwh9H+nggEWOjPF00tD9szTXTKIkFKw3iZkX0t9SBhhubqRFyYM8Hd8Q60
         lWJ9T8KQUySI+2hkAxB/vH7Id3IlHFxybr67+V9fF/QWJZzgqKcrqG8Ntg+kXPymwTnv
         2FCA==
X-Gm-Message-State: AOJu0Yz8hZcqj39jKSmGUwevPXG2Ym2l+57c7HWdTpKO6DkVhD2pdejA
        nzPal6H0Cae1zf9mSgroVKu828P6dEmUBmpdmWULd5oR0c9b6J3Uf77KqIf09TfNmWTotAW8nOt
        sz5oILV0TQoKm1yJorff8/tQr
X-Received: by 2002:a05:6402:31f7:b0:523:406a:5f6 with SMTP id dy23-20020a05640231f700b00523406a05f6mr1443607edb.12.1692188849185;
        Wed, 16 Aug 2023 05:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU/74XE/K5Jc7jA6BEqLvhuW4kSG78ZzyQI/ebU7QqsSkoPCOzbXSL5nsV7AciG7WH7ck9vQ==
X-Received: by 2002:a05:6402:31f7:b0:523:406a:5f6 with SMTP id dy23-20020a05640231f700b00523406a05f6mr1443587edb.12.1692188848862;
        Wed, 16 Aug 2023 05:27:28 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7c508000000b005255eec8797sm4365977edq.79.2023.08.16.05.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:27:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Roman Mamedov <rm+bko@romanrm.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux KVM <kvm@vger.kernel.org>,
        Borislav Petkov (AMD) <bp@alien8.de>
Subject: Re: Fwd: kvm: Windows Server 2003 VM fails to work on 6.1.44 (works
 fine on 6.1.43)
In-Reply-To: <8cc000d5-9445-d6f1-f02e-4629a4a59e0e@gmail.com>
References: <8cc000d5-9445-d6f1-f02e-4629a4a59e0e@gmail.com>
Date:   Wed, 16 Aug 2023 14:27:27 +0200
Message-ID: <87o7j75g0g.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> I notice a regression report on Bugzilla [1]. Quoting from it:
>
>> Hello,
>> 
>> I have a virtual machine running the old Windows Server 2003. On kernels 6.1.44 and 6.1.45, the QEMU VNC window stays dark, not switching to any of the guest's video modes and the VM process uses only ~64 MB of RAM of the assigned 2 GB, indefinitely. It's like the VM is paused/halted/stuck before even starting. The process can be killed successfully and then restarted again (with the same result), so it is not deadlocked in kernel or the like.
>> 
>> Kernel 6.1.43 works fine.
>> 
>> I have also tried downgrading CPU microcode from 20230808 to 20230719, but that did not help.
>> 
>> The CPU is AMD Ryzen 5900. I suspect some of the newly added mitigations may be the culprit?
>
> See Bugzilla for the full thread.
>
> Anyway, I'm adding it to regzbot as stable-specific regression:
>
> #regzbot introduced: v6.1.43..v6.1.44 https://bugzilla.kernel.org/show_bug.cgi?id=217799
> #regzbot title: Windows Server 2003 VM boot hang (only 64MB RAM allocated)
>
> Thanks.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217799

From KVM's PoV, I don't see any KVM/x86 patches v6.1.44..v6.1.45 and in fact
there are only two x86 patches:

f2615bb47be4 x86/CPU/AMD: Do not leak quotient data after a division by 0
98cccbd0a19a x86/hyperv: Disable IBT when hypercall page lacks ENDBR instruction

and I'm pretty certain the later is unrelated; f2615bb47be4 looks like
it can, in theory, be related. Cc: Borislav.

-- 
Vitaly

