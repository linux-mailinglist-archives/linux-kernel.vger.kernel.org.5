Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0137D74CF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjJYTv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjJYTvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:51:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B5E193
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rBV0nSZdE0vCEbKk3Yf9TUFnrefWidkNWcmqpKnwJq8=;
        t=1698263509; x=1699473109; b=HCCUHbSltL3OT0rl8giUu60iZYafzHPm/DrNFIq0/qSEbhx
        XMtFmphDfC0ntsWqnK80KkBLt78AeegHV8y5ebsv/JpV+mJ6fLKI1ZZKPxO/vNSO8uDfJNGukn+iL
        z+yF8z5m1K6NB1FxlL03xW/gCzzwaGcJwsUd8dr3EhJXT4mnzM7OEo4ga12IwxhHEyqiU+LH2DpUy
        Jl/pRLD93KiqoOoP1iin5Ub+3GDU+vFq8wFzfk4htGn7/94PO0u9iffPOzZ4zzoZ3uOXyKEmliro8
        FVoP/IwdZ3LvP2nbrSAEpse03x3fEXBnMjWPTnXzjjotw//ZLEKlvxrdF9U6gbOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvjus-00000002hQU-1l3m;
        Wed, 25 Oct 2023 21:51:46 +0200
Message-ID: <a2f6e0cc8e498f72dfe1fcd5f2233ada8548a4d1.camel@sipsolutions.net>
Subject: Re: [PATCH] um: time-travel: fix time going backwards
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "richard@nod.at" <richard@nod.at>
Cc:     "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Date:   Wed, 25 Oct 2023 21:51:45 +0200
In-Reply-To: <cc7d340e4e06e42cd67b46bfa95da6129b0010cb.camel@axis.com>
References: <20231020-uml-time-backwards-v1-1-90b776fc6dfd@axis.com>
         <4a75c40636be267163dc30b5a6a2442089628e57.camel@axis.com>
         <4dbed8896c94a347dcb58b3a83792c52fdc1c04a.camel@sipsolutions.net>
         <cc7d340e4e06e42cd67b46bfa95da6129b0010cb.camel@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-25 at 11:55 +0000, Vincent Whitchurch wrote:
> On Mon, 2023-10-23 at 09:33 +0200, Johannes Berg wrote:
> > Do you have a specific workload that tends to reproduce this?
>=20
> I've been seeing it when running roadtest, but it's easily reproducible
> without that by using the attached config and the following program as
> init.
>=20
>   cp repro.config .config
>   make ARCH=3Dum olddefconfig all
>   gcc -Wall -static -o repro repro.c
>   ./linux time-travel init=3D$PWD/repro rootfstype=3Dhostfs
>=20
> With the above commands I usually see the panic in a few seconds.  This
> is on an unmodified v6.6-rc7.
>=20

Yes, I can reproduce it with your test, thanks. I'm on 6.4-rc still for
$reasons (6.5 we skipped during vacations, and 6.6 EEVDF scheduler broke
everything for hwsim tests in hostap), but this code didn't really
change anyway.

I'll poke at this.

(And I'm still amazed that anyone other than me even uses this stuff :P)

johannes
