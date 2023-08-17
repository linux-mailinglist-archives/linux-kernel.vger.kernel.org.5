Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89650780114
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355781AbjHQWeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355805AbjHQWdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E92B3594;
        Thu, 17 Aug 2023 15:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1B9666015;
        Thu, 17 Aug 2023 22:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E076BC433C7;
        Thu, 17 Aug 2023 22:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692311607;
        bh=ZGTzwQ3FuoB9kR9/kS5fqKXW58o1c+R1mqlw0+t60CA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=mMcir37TQMzAtas+lv6PUW3yWejIKCYq5cUJNfXX52whshOxG6xOY7BwDpIsb6V/r
         g6mNQ+4FFzigfX9uCiILBIepJsyCirQzwMZFNfJkbWfDKV38l4me0+5+eVpm4QH11L
         0REPIjM9RPpNP2/r/Zfc96A9cWNl4MzlQWfCRtB9r1mzYZEjqIzY5XxYMeF79MblgH
         8pxMvBPQOjYUYAhkQdcFIIQcUbqiIBvBvBN5hzyKrZ115IfOgdgzQfH61JjebmjEFm
         bRU1mkX8PEUGpceOMYk48VAc9nnEzv6cWy90ZOu/njiN+KDeeZwJqqfAvQq9zmqcNx
         HzHgkZNUoWR4g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Aug 2023 01:33:23 +0300
Message-Id: <CUV6EA5WZ2O5.5G3IV9BQITOG@suppilovahvero>
Cc:     <linux-kernel@vger.kernel.org>, <len.brown@intel.com>,
        <charles.d.prestopine@intel.com>, <rafael.j.wysocki@intel.com>
Subject: Re: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some
 Intel systems
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     <todd.e.brandt@linux.intel.com>, <mario.limonciello@amd.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
 <CUV5EXGO425W.1RGBLDQJ8GK9W@suppilovahvero>
 <5a344d1ffa66fac828feb3d1c6abce010da94609.camel@linux.intel.com>
In-Reply-To: <5a344d1ffa66fac828feb3d1c6abce010da94609.camel@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 18, 2023 at 1:25 AM EEST, Todd Brandt wrote:
> On Fri, 2023-08-18 at 00:47 +0300, Jarkko Sakkinen wrote:
> > On Fri Aug 18, 2023 at 12:09 AM EEST, Todd Brandt wrote:
> > > While testing S3 on 6.5.0-rc6 we've found that 5 systems are seeing
> > > a
> > > crash and reboot situation when S3 suspend is initiated. To
> > > reproduce
> > > it, this call is all that's required "sudo sleepgraph -m mem
> > > -rtcwake
> > > 15".
> >=20
> > 1. Are there logs available?
> > 2. Is this the test case: https://pypi.org/project/sleepgraph/ (never
> > used it before).
>
> There are no dmesg logs because the S3 crash wipes them out. Sleepgraph
> isn't actually necessary to activate it, just an S3 suspend "echo mem >
> /sys/power/state".
>
> So far it appears to only have affected test systems, not production
> hardware, and none of them have TPM chips, so I'm beginning to wonder
> if this patch just inadvertently activated a bug somewhere else in the
> kernel that happens to affect test hardware.
>
> I'll continue to debug it, this isn't an emergency as so far I haven't
> seen it in production hardware.

OK, I'll still see if I could reproduce it just in case.

BR, Jarkko
