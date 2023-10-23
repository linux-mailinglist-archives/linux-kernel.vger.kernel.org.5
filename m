Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353707D2B62
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjJWHdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:33:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379DEC5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=y2Sefgom75pAT7bOhfXGdVuxbfN9tmcYHupcK2cb/Ic=;
        t=1698046394; x=1699255994; b=tuYlQ5JLUzay+7her0ssNbIgbDh8pOu1H3Mhou8koO0LwxV
        Ag12L/0/0o2uj5ZO6PMcrfcgsITFJXscJtqtb+H6GH7atX1BQWTBwj2v9gQE4164QtCtt6IPsNLNV
        /gjE1tuGV85+RWKB2AND3eWA4tPDqgKq7zKWj6h+f9/2qcuu0O7vV49BPbPjsnROlvuhl+z73ByPj
        MXm5osorcjD7Bh6IliUB37Ex7ltBVVvEu/Wf+xYbg2y7+W7uv3kPyeJrppGBOtH5W1Ll8OSmz5JMN
        V21xqSB1x4LAq3EJlt4BvF/2/wYXMpQooPnV5iYM9i8sjM2dscVAAPN5xnZLsvOA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qupR0-000000009Al-0CE2;
        Mon, 23 Oct 2023 09:33:10 +0200
Message-ID: <4dbed8896c94a347dcb58b3a83792c52fdc1c04a.camel@sipsolutions.net>
Subject: Re: [PATCH] um: time-travel: fix time going backwards
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "richard@nod.at" <richard@nod.at>
Cc:     "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Date:   Mon, 23 Oct 2023 09:33:09 +0200
In-Reply-To: <4a75c40636be267163dc30b5a6a2442089628e57.camel@axis.com>
References: <20231020-uml-time-backwards-v1-1-90b776fc6dfd@axis.com>
         <4a75c40636be267163dc30b5a6a2442089628e57.camel@axis.com>
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

On Mon, 2023-10-23 at 07:08 +0000, Vincent Whitchurch wrote:
> On Fri, 2023-10-20 at 16:47 +0200, Vincent Whitchurch wrote:
> > In basic time travel mode, I sometimes see "time goes backwards" panics
> > like the one below:
> >=20
> > =C2=A0Kernel panic: time-travel: time goes backwards 161689340000492 ->=
 161689339869814

Ouch.

> > =C2=A0Call Trace:
> > =C2=A0=C2=A0panic+0x1a1/0x3d7
> > =C2=A0=C2=A0time_travel_update_time.cold+0xe9/0x133
> > =C2=A0=C2=A0timer_read+0xc1/0x100
> > =C2=A0=C2=A0ktime_get+0x10c/0x200
> > =C2=A0=C2=A0copy_process+0x1899/0x2230
> > =C2=A0=C2=A0kernel_clone+0x57/0x7a0
> > =C2=A0=C2=A0kernel_thread+0x4a/0x50
> > =C2=A0=C2=A0kthreadd+0x116/0x190
> >=20
> > The problem is a race between time_travel_handle_real_alarm() and
> > timer_read().  time_travel_handle_real_alarm() changes the time after
> > time_read() reads the current time but before time_travel_update_time()
> > has had a chance to add the end event.
> >=20
> > Fix this by doing the time read and event add atomically with respect t=
o
> > time_travel_handle_real_alarm().
>=20
> Further testing resulted in hitting the BUG_ON(time_travel_time !=3D
> e->time) so looks like this needs some more work. =20
>=20

Yeah this is a tricky area, I fought with it for quite a while too,
seems we're not done yet ;-)

We mostly use time-travel=3Dext mode these days, so our system may not be
as susceptible to it? But not sure, in some cases it runs with just a
single instance, and that should be pretty much the same due to the
free-until information.

Do you have a specific workload that tends to reproduce this?

johannes
