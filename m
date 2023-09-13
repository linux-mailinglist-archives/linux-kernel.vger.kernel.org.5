Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74D879EDCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjIMP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjIMP7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:59:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABFE92;
        Wed, 13 Sep 2023 08:58:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114FEC433C7;
        Wed, 13 Sep 2023 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694620737;
        bh=OBuLdZYhtqW9duG/3BeKvKGUdSBgTL3slH5X/g4fjwM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=de/SmuILmLafq3M8LKRDYntRlxwPHNKSXo+jO55fT6mw8uw5BTyXqbTAgjUi8o5Az
         4ExInWUCL4lhprhQzeavrkB6rPA+2mG4UzEV2bl/acI0+a33wAZuQGLB3Gr0tMSSw6
         r5lmn0Bmaqox2w5o7QloLJvWe6O8AtPzsGoWJcTEcEw0BgenttpEfmQl6DFfw9P6Ac
         d513s+LnFCXHg68lMueV851UhOI23qKeRhsUd/jVI+HtHYi85unKMcb4ek2y9xc/+U
         hicROU0KvR9BsjjvxqXXgxTRU/CfR4LBMB/D5BnaKeeyxHxb5/E5osSmes/s2EMdaL
         WhnUZ3MsteOOQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 18:58:53 +0300
Message-Id: <CVHWWXJJLNO5.25DGTKFOPD35Y@suppilovahvero>
Cc:     <kexec@lists.infradead.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <dhowells@redhat.com>, <vgoyal@redhat.com>,
        <keyrings@vger.kernel.org>, <akpm@linux-foundation.org>,
        "Baoquan He" <bhe@redhat.com>, <bhelgaas@google.com>,
        <lennart@poettering.net>, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jan Hendrik Farr" <kernel@jfarr.cc>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
 <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
 <CVH6NGLENMPH.271W6X80061M@suppilovahvero>
 <1c342231-7672-450e-b945-e57cd17b4ae7@app.fastmail.com>
 <CVHVCHYZT8KG.3L0IH30QYT0WH@suppilovahvero>
 <11e0aff9-0388-4a6c-8986-301d4edc482d@app.fastmail.com>
In-Reply-To: <11e0aff9-0388-4a6c-8986-301d4edc482d@app.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Sep 13, 2023 at 6:07 PM EEST, Jan Hendrik Farr wrote:
> On Wed, Sep 13, 2023, at 4:45 PM, Jarkko Sakkinen wrote:
> > On Tue Sep 12, 2023 at 11:49 PM EEST, Jan Hendrik Farr wrote:
> >>
> >> > These are sort of "tautological" arguments. There must be some
> >> > objective reasons why this architecture was chosen instead of other
> >> > (i.e. using what already pre-exists).
> >>
> >> I think I misunderstood you in my earlier reply. I do not understand
> >> in what way you think my arguments are tautological. Can you
> >> elaborate?
> >
> > current Linux kernel has these features *already* in place:
> >
> > 1. CONFIG_EFI_STUB
> > 2. CONFIG_CMDLINE
> > 3. CONFIG_INITRAMFS_SOURCE
> > 4. Secure boot with MOK keys and .machine keyring to manage them.
>
> Well, you also have to add
> 5. CONFIG_CMDLINE_OVERRIDE
> 6. CONFIG_INITRAMFS_FORCE
>
> Otherwise the bootloader can supply an unsinged initramfs/cmdline and
> the kernel will use them.
>
> And then you do not get all the features. One of your earlier responses
> asks how a user might change the cmdline with UKIs. With UKIs all they
> have to do is create a small addon file and sign that (with their MOK if
> they are using a generic distro with shim, instead of using their own
> secure boot keys). With the bzImage alternative they would have to
> recompile the kernel. This was reason #1.
>
> Also what about #3? How would you pass PCR signatures using the normal
> EFI stub / bzImage?

I did not notice anything in the description about PCRs but this
counter-question does really enlighten what I've been trying to say. You
should take time to explain where's the gain, and why it makes sense for
the users.

It does not really make sense for me to "defend" anything if I'm against
something that I don't understand what it is and is capable of and such
and so forth. I don't really care if e.g. systemd is using it, if it
does not make me understand the topic better. It is then just argument
by authority, which not a real argument in the first place.

Linking URL to the specification is good enough for *details* but it
does not save you from trouble of painting the picture what we are
looking at.

BR, Jarkko
