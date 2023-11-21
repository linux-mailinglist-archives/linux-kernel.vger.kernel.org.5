Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5667F35DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjKUSVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjKUSVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:21:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCC318C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:21:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D59C433C8;
        Tue, 21 Nov 2023 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700590904;
        bh=uuSp4UF93Yu6TM00YqGBR4qOIe80QpXkm4wokphvd1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEBUPdjrYlsUWvimRMfCFE3WHRzscOhraRcrNbVFUR6mTLCbtLCntqo06sA1GuEvA
         l2pYNJuiPrLYgivEa+Ss49EjguoP0BAmwU/viDR4Akckk5W5xeFw8fNzESBGo7F0ug
         9K1uLJHb0SjNQZEufhUbFCf/QwocGl8n/QyXzRkzUGSokVKe64I7yc0qr/bvyErfbx
         MGA1L/FIE/4b0y6/6QJTGwvUKBeIzkCq/7rLHBmUAKiiu+0KJaJPgIlFuHdxc5inCg
         OQ0BF8vS+1kh/IgjNb0lUOYp+us+t6TUsrT8eA0+nARM/zuusZof3q92pa+pK1MRk+
         6JgSB/n4AC0LA==
Date:   Tue, 21 Nov 2023 18:21:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Message-ID: <ZVz1M9AYRepPRBxm@finisterre.sirena.org.uk>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-7-chengming.zhou@linux.dev>
 <4f3bc1bd-ea87-465d-b58a-0ed57b15187b@sirena.org.uk>
 <c8bb9dd9-ae18-4fab-a664-6ec4b0cb2e30@linux.dev>
 <ZVwIFNdABN1b+qWC@finisterre.sirena.org.uk>
 <b3bc868f-bf83-4b86-bcf0-13e99d0b7c7e@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ExGtKKkUwz4hb5lM"
Content-Disposition: inline
In-Reply-To: <b3bc868f-bf83-4b86-bcf0-13e99d0b7c7e@linux.dev>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ExGtKKkUwz4hb5lM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 21, 2023 at 11:47:26PM +0800, Chengming Zhou wrote:

> Ah yes, there is no NMI on ARM, so CPU 3 maybe running somewhere with
> interrupts disabled. I searched the full log, but still haven't a clue.
> And there is no any WARNING or BUG related to SLUB in the log.

Yeah, nor anything else particularly.  I tried turning on some debug
options:

CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_WQ_WATCHDOG=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_LOCKING=y
CONFIG_DEBUG_ATOMIC_SLEEP=y

https://validation.linaro.org/scheduler/job/4017828

which has some additional warnings related to clock changes but AFAICT
those come from today's -next rather than the debug stuff:

https://validation.linaro.org/scheduler/job/4017823

so that's not super helpful.

> I wonder how to reproduce it locally with a Qemu VM since I don't have
> the ARM machine.

There's sample qemu jobs available from for example KernelCI:

   https://storage.kernelci.org/next/master/next-20231120/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-qemu_arm-virt-gicv3.html

(includes the command line, though it's not using Debian testing like my
test was).  Note that I'm testing a bunch of platforms with the same
kernel/rootfs combination and it was only the Raspberry Pi 3 which blew
up.  It is a bit tight for memory which might have some influence?

I'm really suspecting this may have made some underlying platform bug
more obvious :/

--ExGtKKkUwz4hb5lM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVc9TIACgkQJNaLcl1U
h9Bhawf+OS9uDdyEyyKar5CBTjXlEF4S1z7TlKgi+GADx/qa8waOCJwrzBE07ro2
OticnnKATaKpYyX2QL1oLw4fyjklvi7xKyXl6/5bnROvXnHLRiTqS3Hvi9+Pp6MO
uutb44QpQfYqJUG40C0RyENJO+TkxgIR0OsEqS9CtAKLqx8dQqfiRZzy4pF33nqK
sxBTIld16BVKOSl8SJLTP/jHOVgGiH0Ug1uE+j+KDtpFO40xQNaJFcq5NLxZGSQF
cPQhJagc14fUB+juA0zwoBvFvwzHg6Q+IsKFuCuK0vW9i8UTow+vfcCWCgzsVg3T
T0TSQ2qrVibbUhsK7RQMMYYRi4txLg==
=K1+p
-----END PGP SIGNATURE-----

--ExGtKKkUwz4hb5lM--
