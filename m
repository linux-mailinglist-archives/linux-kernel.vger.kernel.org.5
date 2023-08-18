Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE20D78111F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378866AbjHRRA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378872AbjHRRAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:00:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6650C3C3D;
        Fri, 18 Aug 2023 10:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1FF560DBB;
        Fri, 18 Aug 2023 17:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA405C433C8;
        Fri, 18 Aug 2023 17:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692378039;
        bh=U1lILcAAq6UqewmXOvmloUOdvzlXGMCiCEEtq7k0bP4=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=heO6ejZgXvKlne4AE7aDAuQTwpmdv9xjFjMNAmANXO3oEv2wWvOT7R+/35fXyM0Ws
         rrMkF25NXQ+0MWr61C+ng3lnjEedLmeewFpCcFQM+Cba0kkBrEhtcVIjQ7F8c14Gr5
         u5WxZLpNZavLjVpL3LiMg1cNl8FT2FI3DlhN8zwf071W7N96stdbat+v7KwAfq/LnK
         As9VbaIZScS9x5//JEt+v10pZd9X9vH92G9HQwMZZ8eaBN38ymIVFzej6s8R/5btjt
         ZtC5o+O4buOq4PDR+WKn7XJVBRDQ2EGPca6y0jnnfPf9nP4XOxZr5hhAMVg9rv9PCT
         ECWAOFY1gxKow==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Aug 2023 20:00:35 +0300
Message-Id: <CUVTY0NCB0N6.VPFM83M83ZUR@suppilovahvero>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        <todd.e.brandt@linux.intel.com>, <linux-integrity@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <len.brown@intel.com>,
        <charles.d.prestopine@intel.com>, <rafael.j.wysocki@intel.com>
Subject: Re: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some
 Intel systems
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
 <CUV5EXGO425W.1RGBLDQJ8GK9W@suppilovahvero>
 <5a344d1ffa66fac828feb3d1c6abce010da94609.camel@linux.intel.com>
 <CUV6EA5WZ2O5.5G3IV9BQITOG@suppilovahvero>
 <bd4890a3-419c-463d-88fe-905946122c9f@amd.com>
In-Reply-To: <bd4890a3-419c-463d-88fe-905946122c9f@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 18, 2023 at 4:58 AM EEST, Limonciello, Mario wrote:
>
>
> On 8/17/2023 5:33 PM, Jarkko Sakkinen wrote:
> > On Fri Aug 18, 2023 at 1:25 AM EEST, Todd Brandt wrote:
> >> On Fri, 2023-08-18 at 00:47 +0300, Jarkko Sakkinen wrote:
> >>> On Fri Aug 18, 2023 at 12:09 AM EEST, Todd Brandt wrote:
> >>>> While testing S3 on 6.5.0-rc6 we've found that 5 systems are seeing
> >>>> a
> >>>> crash and reboot situation when S3 suspend is initiated. To
> >>>> reproduce
> >>>> it, this call is all that's required "sudo sleepgraph -m mem
> >>>> -rtcwake
> >>>> 15".
> >>>
> >>> 1. Are there logs available?
> >>> 2. Is this the test case: https://pypi.org/project/sleepgraph/ (never
> >>> used it before).
> >>
> >> There are no dmesg logs because the S3 crash wipes them out. Sleepgrap=
h
> >> isn't actually necessary to activate it, just an S3 suspend "echo mem =
>
> >> /sys/power/state".
> >>
> >> So far it appears to only have affected test systems, not production
> >> hardware, and none of them have TPM chips, so I'm beginning to wonder
> >> if this patch just inadvertently activated a bug somewhere else in the
> >> kernel that happens to affect test hardware.
> >>
> >> I'll continue to debug it, this isn't an emergency as so far I haven't
> >> seen it in production hardware.
> >=20
> > OK, I'll still see if I could reproduce it just in case.
> >=20
> > BR, Jarkko
>
> I'd like to better understand what kind of TPM initialization path has=20
> run.  Does the machine have some sort of TPM that failed to fully=20
> initialize perhaps?
>
> If you can't share a full bootup dmesg, can you at least share
>
> # dmesg | grep -i tpm

It would be more useful perhaps to get full dmesg output after power on
and before going into suspend.

Also ftrace filter could be added to the kernel command-line:

ftrace=3Dfunction ftrace_filter=3Dtpm*

After bootup:

mount -t tracefs nodev /sys/kernel/tracing
cat /sys/kernel/tracing/trace

BR, Jarkko
