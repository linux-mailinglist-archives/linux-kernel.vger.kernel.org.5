Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E333777B46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjHJOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjHJOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA03A2106;
        Thu, 10 Aug 2023 07:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E918627AD;
        Thu, 10 Aug 2023 14:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95E3C433C8;
        Thu, 10 Aug 2023 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691679018;
        bh=ZUepWYe2u0Gr/j1HHu7xFZqpFO5GqMQf82Cde8SnBr4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=duXL0/BF/2+qRmqh8Rj454zYzL+5HpHQ0a0CbbL7U7zcdzHQMc5Y3u0REBHBUCS56
         BAmI/wEazXeOMp2oFa+TGJhv8JpqJb/5XgvmyCj3LYQ3bYfBEBfeLo5ZjZ6+gHNTs5
         9eAQeLR1nZ4Pyz5uRpAlpmBpiz5kI9jJbDtwz4nzu2zdztVTdzuYY8tz8/axkfkBG7
         WhPNmbg3WlfycFHoIeKI1+bn6aw4y6/kbjMLbUVBk4QTlPFEAtit4TwI4CeMhyQQPM
         5iYnleurXB1k3p8SUHWFTY3nofAy7c+BdWgDJZRymfVhACAJM2r9ZvtohnWpKcBung
         APTmVEdx6SFzQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 17:50:10 +0300
Message-Id: <CUOY5SZYGRV4.1FN39XMJ2I3VP@wks-101042-mac.ad.tuni.fi>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Dan Williams" <dan.j.williams@intel.com>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        <dhowells@redhat.com>
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
X-Mailer: aerc 0.15.2
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com> <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com> <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch> <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com> <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch> <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com> <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 8, 2023 at 2:33 AM EEST, Dan Williams wrote:
> James Bottomley wrote:
> > On Fri, 2023-08-04 at 19:37 -0700, Dan Williams wrote:
> > > James Bottomley wrote:
> > > [..]
> > > > > This report interface on the other hand just needs a single ABI
> > > > > to retrieve all these vendor formats (until industry
> > > > > standardization steps in) and it needs to be flexible (within
> > > > > reason) for all the TSM-specific options to be conveyed. I do not
> > > > > trust my ioctl ABI minefield avoidance skills to get that right.
> > > > > Key blob instantiation feels up to the task.
> > > >=20
> > > > To repeat: there's nothing keylike about it.
> > >=20
> > > From that perspective there's nothing keylike about user-keys either.
> >=20
> > Whataboutism may be popular in politics at the moment, but it shouldn't
> > be a justification for API abuse: Just because you might be able to
> > argue something else is an abuse of an API doesn't give you the right
> > to abuse it further.
>
> That appears to be the disagreement, that the "user" key type is an
> abuse of the keyctl subsystem. Is that the general consensus that it was
> added as a mistake that is not be repeated?
>
> Otherwise there is significant amount of thought that has gone into
> keyctl including quotas, permissions, and instantiation flows.

I would focus on just fixing known obvious issues in the patch set and
improve the description what it does.

This looks like a discussion where the patch set is not advertised in
a way that it is understandable, not necessarily that it is all wrong.

E.g. why not name the key type as attestation key or something more
intuitive rather than three letter acronym?

I don't think this will converge to anything with argumentation in the
current state of where we are right now.

BR, Jarkko
