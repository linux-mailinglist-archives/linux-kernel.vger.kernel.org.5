Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2196B77F4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350165AbjHQLJC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 07:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350157AbjHQLIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:08:44 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF410EC;
        Thu, 17 Aug 2023 04:08:43 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3a822816d52so171905b6e.1;
        Thu, 17 Aug 2023 04:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692270523; x=1692875323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzhHvOz31VAWaoXrRvUpCCJVbJBKrZfwhqIf6kXyx/Y=;
        b=YmdU3WEVr+FzzSk1BclK+3SQQ8MUeJiac4qDKPjyhHqplCI2iboutjj8Wy7Q8yPYrC
         AmikMuFyz/Eb7VYNH4WFakN0ztAMAOfNEgIiFjzawO8qS4TxXnoZ/trnVABvnxTe1vJy
         jvrbH9rS8yxi3HS+V9qyj3Efwp0npCZ8EZtDlimrwsNIq6hoM3zT0x4U92xjWkbM/Tmb
         Cc4sC5AUHN4lAg23GRZ4KDu4j6145dLodavQxE/n1nbHn3jGwAo53F5V+/IdbsrJgCnJ
         vHrhYzGdHoT8RG3p/1d2q1Zz993Oxbd2qLCL9wAZ6CxYcgeEcZOpzTmnTzuHqddaob3h
         L5xg==
X-Gm-Message-State: AOJu0Ywi3EesfYcMCFOqBR3ROlMKzXEM1nj3cy6/YZzQVjii8SwGQMGd
        8t8fbmwBlhEh2xeBygqC71/Or7Z0WVc2reMcC6I=
X-Google-Smtp-Source: AGHT+IESRULq7wGgCXgXvr4ZF9w8hIn8FcV3oM/JfbYBqtRWuvzC7hraGos4veu530g393hZLpBFLYXgVL7n28ETsAY=
X-Received: by 2002:a4a:ba93:0:b0:56d:6bd4:4db5 with SMTP id
 d19-20020a4aba93000000b0056d6bd44db5mr4198924oop.0.1692270522711; Thu, 17 Aug
 2023 04:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230607034403.2885-1-james.liu@hpe.com> <CAJZ5v0hTsEzFKvRf-MHpUxyJdFDUqc2ZL63s6BkyJyFtEzxvhw@mail.gmail.com>
 <ZIGbBF+GxHAlTqGk@ILEIUN5Z4B.asiapacific.hpqcorp.net> <CAJZ5v0iR+CAOwip0zPV1uug-0duJXFS4YMxwNWDntUnK6a+oQQ@mail.gmail.com>
 <64dbd730.050a0220.46601.d780SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <64dbd730.050a0220.46601.d780SMTPIN_ADDED_BROKEN@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 13:08:31 +0200
Message-ID: <CAJZ5v0i3MSrAQj1qbky_aJTCE2b_9Hkq2tyVMkuV_NPaUwa_cQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: reboot: Increase the delay to avoid racing after
 writing to ACPI RESET_REG on AMD Milan platforms.
To:     James Liu <james.liu@hpe.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 9:51 PM James Liu <james.liu@hpe.com> wrote:
>
> On Mon, Jun 12, 2023 at 06:57:01PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jun 8, 2023 at 11:14 AM James Liu <james.liu@hpe.com> wrote:
> > >
> > > On Wed, Jun 07, 2023 at 01:19:42PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Jun 7, 2023 at 5:44 AM James Liu <james.liu@hpe.com> wrote:
> > > > >
> > > > > For AMD Milan platforms, the delay of 15ms is insufficient to avoid racing
> > > > > of reboot mechanisms. That said, the AMD Milan processors don't reboot
> > > > > in 15ms after invoking acpi_reset().
> > > > >
> > > > > The proposed 50ms delay can effectively work around this issue.
> > > > > This extended delay aligns better with ACPI v6.4 (i.e., sec. 4.8.4.6),
> > > > > which indicates that ideally OSPM should execute spin loops on the CPUs
> > > > > in the system following a write to this register.
> > > > >
> > > > > Signed-off-by: James Liu <james.liu@hpe.com>
> > > >
> > > > Why do you want to affect everyone (including guest kernels running in
> > > > virtual machines AFAICS) in order to address a problem specific to one
> > > > platform?
> > >
> > > I hoped to address this issue for any platform requiring a longer delay to
> > > complete ACPI reset in time for any (maybe silicon-level) reasons. Some AMD Milan
> > > platforms were the cases that we've found so far.
> >
> > Do you know about any other?
>
> So far, no. Thus, I wont' proceed with anything until I find the same syndrome
> on next-gen platforms (e.g., AMD Genoa). Now, as you say, it is satisfying to
> document this quirk properly.
>
> >
> > > Except that, since ACPI spec indicates there should be a spin loop (long enough)
> > > after the write instruction to Reset Register, I thought it should be no harms to
> > > the other systems which well consider this spin loop when they claim to support
> > > ACPI reboot.
> > >
> > > Btw, I am just curious, why is the virtual machine mentioned here?
> >
> > The new delay would be over 3 times larger, so some users might be
> > surprised by it at least potentially.
>
> Got it. Just in case, if we really need to increase the delay to address it for
> certain amount of platforms, in experience, how long is the delay acceptable so
> that VM users will not be surprised?

Honestly, I don't know.

Also, it is not quite clear to me from the changelog what the problem
with the Milan platforms vs the reboot delay is and I don't think that
the second paragraph (regarding the ACPI specification compliance) is
relevant for this patch at all.
