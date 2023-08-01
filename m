Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A995276A673
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjHABjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjHABjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:39:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317E019AF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 18:39:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso47613205e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 18:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1690853938; x=1691458738;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=334XzK4sUQw29izKxXhVMPDqKOQOFm4Il91KEG4/Jt8=;
        b=AanWT0epf4MShymtvLHSoWkqKvnKTGhrbmMCLffmEcS1CZjw8L7jFwYSCsFdgUcL+Z
         Iua3Oqaxp09HrQQgzuwpFyI5cF3gXPBLJJXuGQBa2t0AcBlizvEOGzVMsh/JDRqWcEQC
         zteelzy/yhv3CD8KjnNO0skVQxoynGmIo7om1Ybg9l6I059Zt95hAUGhT2ulawoaKQUF
         4JsH6df2C0ZfdxLKPNecs5YoHVCECzKCyipbND4c+Fwnjty7bfvCMvmYksUpd8bz+tH4
         YN1/EAis5L2eKJ8SWevWA9tEndLzJ4C3SPzwIgsfbXTSQ4mt6hi2nmX6UNfZsGHVnFBS
         /p4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690853938; x=1691458738;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=334XzK4sUQw29izKxXhVMPDqKOQOFm4Il91KEG4/Jt8=;
        b=EHhUNsAKp7hIGaHYfvCjemyliJYfp1xORE/Zxp3c9c/Pim77D+fETXvMllkiSA+DiB
         KlysR863twPmHcWa7xnq3/mabWyEnNuB+6eBpdTLzjsFXCYcUGaC5q/94Z6lwZbRUNMn
         53CRFZ9n04i682Dn/7fxIK2a6tRF9dHbOYYCUjTg93pcuJgVMjenF/yyvuo52E99llqC
         U6z1dv8HAxMD8bNosHBa43uY1eZfsbypFPPBScWPymc7Hxh6zizvhAfCw5Xzz0/Mi1MU
         HPLQcnVt5/bMf8Ph0SkwWrlihvEFY1GfhnswivbpLb6FGXnIMsX0lubJwqeUHwzTxuyb
         3ivQ==
X-Gm-Message-State: ABy/qLYasxJGcAXBitKje6AGtMD6ZWPHLDseYmOUu6vH7MFUY7do428U
        0z36UDcDKumGMVVLvL7X4+lggw==
X-Google-Smtp-Source: APBJJlG8zOALv1XaxPHw32cKXqy4Xd9IRY59uS09ybdBueIiM2qDPOhScVDNregC/9kM33vdQWnqkg==
X-Received: by 2002:a1c:f019:0:b0:3fb:b5dc:dab1 with SMTP id a25-20020a1cf019000000b003fbb5dcdab1mr1043631wmb.39.1690853938565;
        Mon, 31 Jul 2023 18:38:58 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b003172510d19dsm14657118wrt.73.2023.07.31.18.38.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2023 18:38:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <347eab9f-b64a-b124-ba7a-ee458e6407f3@gigawatt.nl>
Date:   Tue, 1 Aug 2023 02:38:47 +0100
Cc:     Andy Lutomirski <luto@kernel.org>, Rich Felker <dalias@libc.org>,
        linux-x86_64@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C330BFF-A81A-465D-BE7D-6DB6A7B263AF@jrtc27.com>
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
 <20201012134444.1905-1-jrtc27@jrtc27.com>
 <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
 <20201101012202.GM534@brightrain.aerifal.cx>
 <7842A462-0ADB-4EE3-B4CB-AE6DCD70CE1C@jrtc27.com>
 <20201101015013.GN534@brightrain.aerifal.cx>
 <CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com>
 <04832096-ED7F-4754-993D-F578D4A90843@jrtc27.com>
 <EEC90B2F-E972-475F-B058-918CDE401618@jrtc27.com>
 <20201101210102.GO534@brightrain.aerifal.cx>
 <29423184-A433-42D4-B635-CDEFE7271B40@jrtc27.com>
 <2AC632C0-EC00-4C4E-92DC-B7F238897C4C@jrtc27.com>
 <CALCETrWWcVhYoVuvovo558sXpA7X75jNpf8LA+w+k-dzyRiUcg@mail.gmail.com>
 <347eab9f-b64a-b124-ba7a-ee458e6407f3@gigawatt.nl>
To:     Harald van Dijk <harald@gigawatt.nl>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Aug 2023, at 01:43, Harald van Dijk <harald@gigawatt.nl> wrote:
>=20
> On 06/12/2020 22:55, Andy Lutomirski wrote:
>> On Sat, Dec 5, 2020 at 4:01 PM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>>>=20
>>> Ping?
>> Can you submit patches implementing my proposal?  One is your =
existing
>> patch plus fixing struct msghdr, with Cc: stable@vger.kernel.org at
>> the bottom.  The second is a removal of struct msghdr from uapi,
>> moving it into include/inux (no uapi) if needed.  The second should
>> not cc stable.
>=20
> Hi,
>=20
> This looks like it was forgotten, but it is still needed. Jessica, are =
you interested in submitting the requested change? If not, would it be =
okay if I do so? I have been running this locally for a long time now.

Hi,
Please feel free to; sorry that it dropped off my radar. Part of the
issue is my laptop no longer being x86, making it more annoying to test.

> There is one complication that I think has not been mentioned yet: =
when _GNU_SOURCE is defined, glibc does provide a definition of struct =
msghdr in <sys/msg.h> with a field "__syscall_slong_t mtype;". This =
makes it slightly more likely that there is code out there in the wild =
that works fine with current kernels and would be broken by the fix. =
Given how rare x32 is, and how rare message queues are, this may still =
be acceptable, but I am mentioning it just in case this would cause a =
different approach to be preferred. And whatever is done, a fix should =
also be submitted to glibc.

Given POSIX is very clear on how msghdr works I think we have to break
whatever oddball code out there might be using this. The alternative is
violating POSIX in a way that makes correct code compile fine but fail
at run time on x32, which is a terrible place to be, especially when
the =E2=80=9Cfix=E2=80=9D is to special-case x32 to go against what =
POSIX says. I just
can=E2=80=99t see how that=E2=80=99s a good place to stay in, even if =
something might
break when we fix this bug.

Thanks,
Jess

> (musl define struct msghdr as well, but defines mtype unconditionally =
as having type long, so if this approach is still preferred, needs no =
changes.)
>=20
> Cheers,
> Harald van Dijk

