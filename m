Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5BE7692C3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGaKJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjGaKJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6014EEC;
        Mon, 31 Jul 2023 03:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F241260D32;
        Mon, 31 Jul 2023 10:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980B5C433A9;
        Mon, 31 Jul 2023 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690798162;
        bh=ZlHoVLczUUX2/4R2QTveMknDNAnFLWJAugFEj5kWwcQ=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Ewi1LL6+Z+N4keF+Gb+OqvXLGtxRn1gpGNJcRUFmnYYv11rIP/RwWw9gt8ThOcJHV
         GA4728xkyCUS03PUtz902LQm9aFreU/SlbATyT9KLzoQz8iOJIPZQlS9tOa7o0AgZC
         QdRR6L+swDi6cqhBFHIYeuWnwlXRx1erhk29sKm+3x4oabNkVBVFl4Baf1JjQmbDs9
         hGX/rN2fni/bQGfrON07CHtMN6FgcCo+J24ySwWRvXsz+NpowDSV2tTzJt2LFqehsg
         uA741eRjUaCbT+0cIb0b1hYDeocIaJDmieBe57j/Lik6+KgM4XKDlZiwUS0wjvhSN4
         52pZpaQrnR16g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 Jul 2023 10:09:17 +0000
Message-Id: <CUG9XAK3RNFF.GWCYLXSTWX5E@seitikki>
Cc:     "Brijesh Singh" <brijesh.singh@amd.com>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Dionna Amalie Glaze" <dionnaglaze@google.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Samuel Ortiz" <sameo@rivosinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Dan Williams" <dan.j.williams@intel.com>, <dhowells@redhat.com>
X-Mailer: aerc 0.14.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com> <CUE22P5RYPH3.1K05T2OCK1CN1@seitikki> <64c41aa5ba9ac_a88b29494@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64c41aa5ba9ac_a88b29494@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jul 28, 2023 at 7:44 PM UTC, Dan Williams wrote:
> Jarkko Sakkinen wrote:
> > On Fri Jul 28, 2023 at 7:30 PM UTC, Dan Williams wrote:
> > > The bulk of the justification for this patch kit is in "[PATCH 1/4]
> >=20
> > /patch kit/patch set/
> >=20
> > > keys: Introduce tsm keys". The short summary is that the current
> > > approach of adding new char devs and new ioctls, for what amounts to =
the
> > > same functionality with minor formatting differences across vendors, =
is
> > > untenable. Common concepts and the community benefit from common
> > > infrastructure.
> > >
> > > Use Keys to build common infrastructure for confidential computing
> >=20
> > /Keys/Linux keyring/
> >=20
> > > attestation report blobs, convert sevguest to use it (leaving the
> > > deprecation question alone for now), and pave the way for tdx-guest a=
nd
> > > the eventual risc-v equivalent to use it in lieu of new ioctls.
> > >
> > > The sevguest conversion is only compile-tested.
> > >
> > > This submission is To:David since he needs to sign-off on the idea of=
 a
> > > new Keys type, the rest is up to the confidential-computing driver
> > > maintainers to adopt.
> > >
> > > Changes from / credit for internal review:
> > > - highlight copy_{to,from}_sockptr() as a common way to mix
> > >   copy_user() and memcpy() paths (Andy)
> > > - add MODULE_DESCRIPTION() (Andy)
> > > - clarify how the user-defined portion blob might be used (Elena)
> > > - clarify the key instantiation options (Sathya)
> > > - drop usage of a list for registering providers (Sathya)
> > > - drop list.h include from tsm.h (Andy)
> > > - add a comment for how TSM_DATA_MAX was derived (Andy)
> > > - stop open coding kmemdup_nul() (Andy)
> > > - add types.h to tsm.h (Andy)
> > > - fix punctuation in comment (Andy)
> > > - reorder security/keys/Makefile (Andy)
> > > - add some missing includes to tsm.c (Andy)
> > > - undo an 81 column clang-format line break (Andy)
> > > - manually reflow tsm_token indentation (Andy)
> > > - move allocations after input validation in tsm_instantiate() (Andy)
> > > - switch to bin2hex() in tsm_read() (Andy)
> > > - move init/exit declarations next to their functions (Andy)
> > >
> > >
> > > ---
> > >
> > > Dan Williams (4):
> > >       keys: Introduce tsm keys
> > >       virt: sevguest: Prep for kernel internal {get,get_ext}_report()
> > >       mm/slab: Add __free() support for kvfree
> > >       virt: sevguest: Add TSM key support for SNP_{GET,GET_EXT}_REPOR=
T
> > >
> > >
> > >  drivers/virt/coco/sev-guest/Kconfig     |    2=20
> > >  drivers/virt/coco/sev-guest/sev-guest.c |  135 ++++++++++++++-
> > >  include/keys/tsm.h                      |   71 ++++++++
> > >  include/linux/slab.h                    |    2=20
> > >  security/keys/Kconfig                   |   12 +
> > >  security/keys/Makefile                  |    1=20
> > >  security/keys/tsm.c                     |  282 +++++++++++++++++++++=
++++++++++
> > >  7 files changed, 494 insertions(+), 11 deletions(-)
> > >  create mode 100644 include/keys/tsm.h
> > >  create mode 100644 security/keys/tsm.c
> > >
> > > base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> >=20
> > So how does this scale? Does it scale to TDX, SGX, TPM's or even TEE's
> > (ARM SM, RISC-V Keystone etc.). I'm not sure about the scope but we wan=
t
> > of course something that adapts to multiple use cases, right?
>
> TPMs and TEEs are covered by trusted-keys. I do think a "TSM" flavor of
> trusted-keys is in scope for where some of these implementations are
> headed, but that comes later. I talk about that in the changelog that
> functionality like SNP_GET_DERIVED_KEY likely wants to have a
> trusted-keys frontend and not isolated behind a vendor-specific ioctl
> interface.

TEE's and TPM's are not the exact same thing. Are we sure that any
future ARM SMC like TEE interface what you say will hold?

Why do we need a new key type, when we have already trusted keys?

This whole territory should be better defined so that everything
will fit together.

> This facility is different, it is just aiming to unify this attestation
> report flow. It scales to any driver that can provide the ->auth_new()
> operation. I have the sev-guest conversion in this set, and Sathya has
> tested this with tdx-guest. I am hoping Samuel can evaluate it for
> cove-guest or whatever that driver ends up being called.

What about SGX without TDX?

BR, Jarkko
