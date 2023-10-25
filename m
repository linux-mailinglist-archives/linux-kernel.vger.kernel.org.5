Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92AC7D75EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjJYUlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYUlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:41:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B536123
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=DsYdjSLqGrd7t0Y6Nn+QoZo/dHfV0hHOlcoK0gUrZCY=;
        t=1698266502; x=1699476102; b=VbXcNBxExPBtHf41XOudPWdtvXioFtTbThO3Nc6+gwCmbjg
        UbW/3yb6LZgWl6IEXuqM5nwjYaNIToem4HfsAuJHCPoYL0ws7eRYEtYSWbE0DvpjagRHpwWpBB14m
        SPfOnqmVXyp3Wz/ph1XG94/ykrQjmsJxNq4JQasdBMAAfOZB92sQS18c+V18ghU+zURa9NyG3SVED
        CSBr0u8paG0c23/kS53aUDB7KJIQm1mTh+BUcHRGIY3ThR+k5pQibeYhED2hbrP7eZWPY3H/ifhPY
        NLJXHnwgVm3waiPdv29jaCeM4A7bz8oVWiexehS1cwO5uOptdMVeO37K11IiUZuw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvkh9-00000002iVb-0Mrm;
        Wed, 25 Oct 2023 22:41:39 +0200
Message-ID: <1f38d92435cc4f3a5e8d17dff3da9e34be2e6f24.camel@sipsolutions.net>
Subject: Re: [PATCH] um: time-travel: fix time going backwards
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "richard@nod.at" <richard@nod.at>
Cc:     "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Date:   Wed, 25 Oct 2023 22:41:38 +0200
In-Reply-To: <68b18065d8be905c25522bd3f5a9b46dbe3a976d.camel@sipsolutions.net>
References: <20231020-uml-time-backwards-v1-1-90b776fc6dfd@axis.com>
         <4a75c40636be267163dc30b5a6a2442089628e57.camel@axis.com>
         <4dbed8896c94a347dcb58b3a83792c52fdc1c04a.camel@sipsolutions.net>
         <cc7d340e4e06e42cd67b46bfa95da6129b0010cb.camel@axis.com>
         <a2f6e0cc8e498f72dfe1fcd5f2233ada8548a4d1.camel@sipsolutions.net>
         <68b18065d8be905c25522bd3f5a9b46dbe3a976d.camel@sipsolutions.net>
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

On Wed, 2023-10-25 at 22:02 +0200, Johannes Berg wrote:
> On Wed, 2023-10-25 at 21:51 +0200, Johannes Berg wrote:
> > On Wed, 2023-10-25 at 11:55 +0000, Vincent Whitchurch wrote:
> > > On Mon, 2023-10-23 at 09:33 +0200, Johannes Berg wrote:
> > > > Do you have a specific workload that tends to reproduce this?
> > >=20
> > > I've been seeing it when running roadtest, but it's easily reproducib=
le
> > > without that by using the attached config and the following program a=
s
> > > init.
> > >=20
> > >   cp repro.config .config
> > >   make ARCH=3Dum olddefconfig all
> > >   gcc -Wall -static -o repro repro.c
> > >   ./linux time-travel init=3D$PWD/repro rootfstype=3Dhostfs
>=20
> Ohhh.
>=20
> Pure "time-travel" is actually something I hardly think about these
> days, we mostly use time-travel=3Dinf-cpu (or =3Dext).
>=20
> That makes sense, here you actually *can* get interrupted. I'll need to
> dig into what happens though.

I just sent a patch, please take a look. It does seem to fix it - at
least I got bored of waiting after running your test program for a few
minutes :)

johannes
