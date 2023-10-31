Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9677DCE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344638AbjJaNn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344642AbjJaNnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835FE9F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698759783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwSdYaOUr2kkGu8J8P5xSwLcOrRCIPx0rihuqWdukug=;
        b=hrN2yzqd58yYJGB2p6o5O29ro08XpBgzJX7NLnPQU8NktyWPEFwBco81/Fb/y9bHx9TJt+
        XhcqM36PBIAGC+Ipw2ZZmmssMXaSlR+bGFJ5S5mEY09VB+/CnzzADaxL1g/KEXImPrGfr6
        1rHjhRbSZ8SBWeg33wnKCe+p/NVhgqY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-729IKFgnM6Waf9VEznhPwQ-1; Tue, 31 Oct 2023 09:43:02 -0400
X-MC-Unique: 729IKFgnM6Waf9VEznhPwQ-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-457cbda3299so1838252137.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698759782; x=1699364582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwSdYaOUr2kkGu8J8P5xSwLcOrRCIPx0rihuqWdukug=;
        b=u3lMjM3hsdeUhrVQiPxiDGtHiKdVnUaVYVLRCvDrkSWKIV+kCv6SLKFzbo7H1qYa5r
         aQqYOSYJJ2IVT4xopDSMDxgsxiYNP1yNdJUkrEnI9WYMFyn8SAZWwID0eudr0eN+x10D
         343ixpNYNT2QhVV/FmCIgYuWEXbjXsnEXR5uiagAnpjbDoavnJZDVxUfd+A1lQYPmwzX
         gH7pkkQkxcdM5RbD3oG8k1/9vmBEa0qyh8rfKs7NiDfZIfInYRPpSpjMX9TjE+oeAiS1
         pMyWeOmkQNPcqpDQtmOP5NWaJ39oQOhytkwjDaYVyp/VnTb89sQj5bvZBFbI65I5C/NP
         asEA==
X-Gm-Message-State: AOJu0Yz5ovrBRQtQfex7rbb6xVmsE+GdR/Cpkqh1YJaYtzMS46HTgbnF
        8VDOt1Z7h4ByThxETOsx8Dto7t0GQwNpM4GkANsHCKd8aqlks8mD6VgyZynJj0DY77xrRFETrNB
        XxR84Jh+kWmzHqx0dfpHpyV3Cv0yHY6w3bOW8o53M
X-Received: by 2002:a67:c309:0:b0:454:5a16:890d with SMTP id r9-20020a67c309000000b004545a16890dmr9314390vsj.24.1698759781857;
        Tue, 31 Oct 2023 06:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRazy8qcp9t/yo0fBuQc907BQJ2j/Y0Wh4UUVqODMdn1cN5WQIVHfZbUEnhTxW0TsQjpHHlBdX/HV9WIFM0tQ=
X-Received: by 2002:a67:c309:0:b0:454:5a16:890d with SMTP id
 r9-20020a67c309000000b004545a16890dmr9314371vsj.24.1698759781573; Tue, 31 Oct
 2023 06:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231030134806.24510492@canb.auug.org.au> <20231030-ignorant-liebschaft-6d603ab43494@brauner>
 <3ed75fa4-6b49-4fd2-a907-8619ca19a8b8@redhat.com> <20231031073705.512dab4b@canb.auug.org.au>
 <ZUAaiA0-FNRNy7wJ@google.com> <20231031081035.7f7d860b@canb.auug.org.au>
In-Reply-To: <20231031081035.7f7d860b@canb.auug.org.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 31 Oct 2023 14:42:49 +0100
Message-ID: <CABgObfa_-BYrx0s=PAed=S2C-NgoCuvdYaVS_D9Fm6FxSChQNA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kvm-x86 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sean Christopherson <seanjc@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:10=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi Sean,
>
> On Mon, 30 Oct 2023 14:05:12 -0700 Sean Christopherson <seanjc@google.com=
> wrote:
> >
> > That's my bad, I wanted to get the guest_memfd code exposure asap and j=
umped the
> > gun.  I'll yank the branch out kvm-x86/next.
>
> Thanks.

In all fairness, it was only recently pushed back from 6.7 to 6.8 so
it probably would have made sense to include it _even earlier_. But I
agree that at this point it's better if we wait for 6.7-rc1 before it
makes it back into linux-next. At that point I'll include the conflict
resolution myself.

Paolo

