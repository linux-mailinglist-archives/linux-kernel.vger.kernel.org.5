Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5669F7D861C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbjJZPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjJZPja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:39:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F251A7;
        Thu, 26 Oct 2023 08:39:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1555C433CA;
        Thu, 26 Oct 2023 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698334768;
        bh=FDj+TtkA41V8W+Dgx4SdwNTR5EfRCiqvl6KQP3P3OD0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fZprWnS1zKe9CbthGm2D8C8zn1nHzy+//yBaYsrHS2yMyLV4Mra2DrQCWoWjXTzBz
         wmZsR2S4VUKMnbpnDA2j8BvXxn9wQ2HGezAJaWDPSU5a6RYVylVKNc71ZBr7bTLf/0
         md20LufSdvrHbA+7Y/9HEHJai5JDJ/LXeslMvVgc38iVm9ALkXNI0bSx4/No1e7twd
         9IQkuaWHkBn4DGJqpMUo8J4lmwsu3KxMDmWbAFDWyLMymS1z2I94MghGWnphoVzqHH
         ek932aj5ECM/nNLrYNV+rPymMUzHfp8t1fNRvVqE1wuLbmDiAGPKuWymrgHTW8l+XM
         Ylf5ZSpZl3/Zg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so16284501fa.0;
        Thu, 26 Oct 2023 08:39:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YycJx7gjlFqJWtnyEptC+EvpBCU/kzfQDlV15e8dOd+jvbJktUV
        V5fomMX7Z0RRR3nhiznnQsBKbpobR11Q4BMQFms=
X-Google-Smtp-Source: AGHT+IE320/m4nxTYakuJFBJp88Ll7maED97PBXuy6j3H25+6YoIexbnB90kueybRhWmacv8IDTeoQ5wlVQQTkiVzRM=
X-Received: by 2002:a2e:b04b:0:b0:2c5:1b01:b67f with SMTP id
 d11-20020a2eb04b000000b002c51b01b67fmr13026501ljl.52.1698334766885; Thu, 26
 Oct 2023 08:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsCskpn_TNpSwLq9HGUgtT=aZpDzs7SVrqpa9WmyYFaxQ@mail.gmail.com>
 <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZTqGBzOQd4Oi3e9j@FVFF77S0Q05N.cambridge.arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 26 Oct 2023 17:39:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
Message-ID: <CAMj1kXE8VrG6aPsjByd83kavw7He6vn=DszhJfAd-TfP9y8VBA@mail.gmail.com>
Subject: Re: qemu-arm64: handle_futex_death - kernel/futex/core.c:661 - Unable
 to handle kernel unknown 43 at virtual address
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 17:30, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Oct 26, 2023 at 08:11:26PM +0530, Naresh Kamboju wrote:
> > Following kernel crash noticed on qemu-arm64 while running LTP syscalls
> > set_robust_list test case running Linux next 6.6.0-rc7-next-20231026 and
> > 6.6.0-rc7-next-20231025.
> >
> > BAD: next-20231025
> > Good: next-20231024
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > Log:
> > ----
> > <1>[  203.119139] Unable to handle kernel unknown 43 at virtual
> > address 0001ffff9e2e7d78
> > <1>[  203.119838] Mem abort info:
> > <1>[  203.120064]   ESR = 0x000000009793002b
> > <1>[  203.121040]   EC = 0x25: DABT (current EL), IL = 32 bits
> > set_robust_list01    1  TPASS  :  set_robust_list: retval = -1
> > (expected -1), errno = 22 (expected 22)
> > set_robust_list01    2  TPASS  :  set_robust_list: retval = 0
> > (expected 0), errno = 0 (expected 0)
> > <1>[  203.124496]   SET = 0, FnV = 0
> > <1>[  203.124778]   EA = 0, S1PTW = 0
> > <1>[  203.125029]   FSC = 0x2b: unknown 43
>
> It looks like this is fallout from the LPA2 enablement.
>
> According to the latest ARM ARM (ARM DDI 0487J.a), page D19-6475, that "unknown
> 43" (0x2b / 0b101011) is the DFSC for a level -1 translation fault:
>
>         0b101011 When FEAT_LPA2 is implemented:
>                  Translation fault, level -1.
>
> It's triggered here by an LDTR in a get_user() on a bogus userspace address.
> The exception is expected, and it's supposed to be handled via the exception
> fixups, but the LPA2 patches didn't update the fault_info table entries for all
> the level -1 faults, and so those all get handled by do_bad() and don't call
> fixup_exception(), causing them to be fatal.
>
> It should be relatively simple to update the fault_info table for the level -1
> faults, but given the other issues we're seeing I think it's probably worth
> dropping the LPA2 patches for the moment.
>

Thanks for the analysis Mark.

I agree that this should not be difficult to fix, but given the other
CI problems and identified loose ends, I am not going to object to
dropping this partially or entirely at this point. I'm sure everybody
will be thrilled to go over those 60 patches again after I rebase them
onto v6.7-rc1 :-)
