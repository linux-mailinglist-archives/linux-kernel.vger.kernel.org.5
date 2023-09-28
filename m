Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93A37B22C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjI1Qs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjI1Qs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:48:57 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A2299
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:48:54 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bffdf50212so211539021fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695919732; x=1696524532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44e7JjlG+WtSY93eeg23R+ddrkmidvGwWHPd503fikU=;
        b=zy/2a7EibPFFvegWza5ZRBitbNt0pqqw7uLf2UBMMW9p+sCzbI1qkKbDhQXl3AgrmK
         09hbUWxqFC1ss52tnhILbS7GCP7wS5jHNX5tyHUkcSUBg3gV6xupjaV3tlgkLNYQllzn
         j4zd8z0oGS/UE7I8wZuYQSK3S+d9GUYecuf+LAIby2XofsZrjd9VAxVCRXasl5ntSTzB
         HcA2Q2ADyrrUf1BbpQ6v1hkr46Cr0WMSo9TeOPu+BpXaeLMeWysY+n3LPWwK4eZ0O0nE
         S71RfRTwXNq8KaXYQmyYFkMCWsDZyf9GPVu4mUinDgDBLhz7wibbp1q4MgV48zutf+Dg
         O3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695919732; x=1696524532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44e7JjlG+WtSY93eeg23R+ddrkmidvGwWHPd503fikU=;
        b=r6PZZMWH37SHv0GHBENN7m6lwZAhbusBkd7AS7BOV4QbEBKtslhwxuNUHi69OXOVo3
         2UwnoVm7517kXD/08rysUvXKIYoHfFB76PyBDwbO1HFYzQtg4Zmb0ntHsjZknIvqR19c
         r8M1Xqo8mzDd3JOvkqiyy9YV6UZz9+vq4y6ncT57au84Jn+PgXFTp6AiUdMhoaP1ozMR
         38L1TXCY1Or1bFVEi4YUy/qZu2/tJgPsuNURnkx7kSMCI2wqYkfOJPxYec807ooFpnXX
         D2vbNb6zxDFc2cHBMvscD5JDd1wVeAavygdmOXlFcRpsEuP0UNp5FqwXD7Yo5jB/n7rC
         5Nrw==
X-Gm-Message-State: AOJu0Yw5i50HhAjlODm1PkMqlFL30zRAVkSucXPKwXzeFI1V8GojJYcE
        9LVsbE1eFDvYmL1t5twnkyaTWS2wFWbuR3Mj17GtrQ==
X-Google-Smtp-Source: AGHT+IEbRkCHOMBJe/ei0e9obPh+BFrfZpzCUXl6IIFyZN3ZHbEtYGUXGWXMnvH1SMQHZBjXtN75+lOrtiDzacUgCcA=
X-Received: by 2002:a2e:b00e:0:b0:2c0:32d7:8962 with SMTP id
 y14-20020a2eb00e000000b002c032d78962mr1673135ljk.1.1695919732494; Thu, 28 Sep
 2023 09:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230926150316.1129648-1-cleger@rivosinc.com> <CALs-Hss+OK-vJy_ZKjVbGh7rTBZA+GditWcdM1XjDDskGF76Dw@mail.gmail.com>
 <10997d30-e6b7-4a24-a43e-e22679e8d450@rivosinc.com>
In-Reply-To: <10997d30-e6b7-4a24-a43e-e22679e8d450@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 28 Sep 2023 09:48:16 -0700
Message-ID: <CALs-HssAAgbdUuoCyPEdjs+8yH+a8Gzz7jCpMre-6k21aE_sdQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?B?QmrDtnJuIFRvcGVs?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 12:49=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
>
>
> On 26/09/2023 23:43, Evan Green wrote:
> > On Tue, Sep 26, 2023 at 8:03=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger=
@rivosinc.com> wrote:
> >>
> >> Since commit 61cadb9 ("Provide new description of misaligned load/stor=
e
> >> behavior compatible with privileged architecture.") in the RISC-V ISA
> >> manual, it is stated that misaligned load/store might not be supported=
.
> >> However, the RISC-V kernel uABI describes that misaligned accesses are
> >> supported. In order to support that, this series adds support for S-mo=
de
> >> handling of misaligned accesses as well support for prctl(PR_UNALIGN).
> >>
> >> Handling misaligned access in kernel allows for a finer grain control
> >> of the misaligned accesses behavior, and thanks to the prctl call, can
> >> allow disabling misaligned access emulation to generate SIGBUS. User
> >> space can then optimize its software by removing such access based on
> >> SIGBUS generation.
> >>
> >> Currently, this series is useful for people that uses a SBI that does
> >> not handled misaligned traps. In a near future, this series will make
> >> use a SBI extension [1] allowing to request delegation of the
> >> misaligned load/store traps to the S-mode software. This extension has
> >> been submitted for review to the riscv tech-prs group. An OpenSBI
> >> implementation for this spec is available at [2].
> >
> > For my own education, how does the new SBI call behave with respect to
> > multiple harts? Does a call to change a feature perform that change
> > across all harts, or just the hart the SBI call was made on? If the
> > answer is "all harts", what if not all harts are exactly the same, and
> > some can enable the feature switch while others cannot? Also if the
> > answer is "all harts", does it also apply to hotplugged cpus, which
> > may not have even existed at boot time?
>
> Depending on the feature, they can be either global (all harts) or
> local (calling hart). The medeleg register is per hart and thus
> misaligned load/store delegation for S-mode is also per hart.

We should probably state this in the spec update then, both generally
and for each specific feature added. Otherwise firmware writers are
left not knowing if they're supposed to spread a feature across to all
cores or not.

>
>
> >
> > What happens if a hart goes through a context loss event, like
> > suspend/resume? Is the setting expected to be sticky, or is the kernel
> > expected to replay these calls?
>
> That is a good question that we did not actually clarified yet. Thanks
> for raising it !

No problem! This may also need to be specified per-feature in the
spec. I have a vague hunch that it's better to ask the kernel to do it
on resume, though ideally we'd have the terminology (and I don't think
we do?) to specify exactly which points constitute a context loss.
Mostly I'm remembering the x86 and ARM transition from S3, where lots
of firmware code ran at resume, to S0ix-like power states, where
things resumed directly into the OS and they had to figure out how to
do it without firmware. The vague hunch is that keeping the laundry
list of things firmware must do on resume low might keep us from
getting in S0ix's way, but it's all so speculative it's hard to know
if it's really a useful hunch or not.

-Evan
