Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897D77CDF34
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbjJRORv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344973AbjJROR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:17:29 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B78C10EF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:14:11 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S9Xs95kx0zMqBDW;
        Wed, 18 Oct 2023 14:14:05 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S9Xs900CdzMppKm;
        Wed, 18 Oct 2023 16:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1697638445;
        bh=AJCppQD+bLjbEs7xewzXV45Zcp0SfH1Bhh+lWslfscM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n23hMfMY7BCeeWfC+vRX7uYp3N2pqK1TOOIKiCpU1sWaX5L85cu8QOJvf3HhcUjx0
         72e2daim6t3sKxX3Bjj93peawurco7/d809Ro3jVgn5rsGowPdzmA2GWt7hsyOmib4
         aVsI6v+B2mIOSlnfQgc3KKNanxmjtBWB5Sy7YNR0=
Date:   Wed, 18 Oct 2023 16:14:03 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: RFC: New LSM to control usage of x509 certificates
Message-ID: <20231018.heiju2Shexai@digikod.net>
References: <D0F16BFD-72EB-4BE2-BA3D-BAE1BCCDCB6F@oracle.com>
 <20230914.shah5al9Kaib@digikod.net>
 <20231005.dajohf2peiBu@digikod.net>
 <d3b51f26c14fd273d41da3432895fdce9f4d047c.camel@linux.ibm.com>
 <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com>
 <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
 <CAHC9VhS_Ttdy5ZB=jYdVfNyaJfn_7G1wztr5+g0g7uUDForXvA@mail.gmail.com>
 <5c795b4cf6d7460af205e85a36194fa188136c38.camel@linux.ibm.com>
 <CAHC9VhTug20M0ET=QojUPtjrGkeHfU=ADDNrKfXmLTQPG_i1vw@mail.gmail.com>
 <2512D2AE-4ACA-41B9-B9FB-C2B4802B9A10@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2512D2AE-4ACA-41B9-B9FB-C2B4802B9A10@oracle.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 07:34:25PM +0000, Eric Snowberg wrote:
> 
> 
> > On Oct 17, 2023, at 12:51 PM, Paul Moore <paul@paul-moore.com> wrote:
> > 
> > On Tue, Oct 17, 2023 at 1:59 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >> On Tue, 2023-10-17 at 13:29 -0400, Paul Moore wrote:
> >>> On Tue, Oct 17, 2023 at 1:09 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>> On Tue, 2023-10-17 at 11:45 -0400, Paul Moore wrote:
> >>>>> On Tue, Oct 17, 2023 at 9:48 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>>> On Thu, 2023-10-05 at 12:32 +0200, Mickaël Salaün wrote:
> >>>>>>>>>> A complementary approach would be to create an
> >>>>>>>>>> LSM (or a dedicated interface) to tie certificate properties to a set of
> >>>>>>>>>> kernel usages, while still letting users configure these constraints.
> >>>>>>>>> 
> >>>>>>>>> That is an interesting idea.  Would the other security maintainers be in
> >>>>>>>>> support of such an approach?  Would a LSM be the correct interface?
> >>>>>>>>> Some of the recent work I have done with introducing key usage and CA
> >>>>>>>>> enforcement is difficult for a distro to pick up, since these changes can be
> >>>>>>>>> viewed as a regression.  Each end-user has different signing procedures
> >>>>>>>>> and policies, so making something work for everyone is difficult.  Letting the
> >>>>>>>>> user configure these constraints would solve this problem.
> >>>>>> 
> >>>>>> Something definitely needs to be done about controlling the usage of
> >>>>>> x509 certificates.  My concern is the level of granularity.  Would this
> >>>>>> be at the LSM hook level or even finer granaularity?
> >>>>> 
> >>>>> You lost me, what do you mean by finer granularity than a LSM-based
> >>>>> access control?  Can you give an existing example in the Linux kernel
> >>>>> of access control granularity that is finer grained than what is
> >>>>> provided by the LSMs?
> >>>> 
> >>>> The current x509 certificate access control granularity is at the
> >>>> keyring level.  Any key on the keyring may be used to verify a
> >>>> signature.  Finer granularity could associate a set of certificates on
> >>>> a particular keyring with an LSM hook - kernel modules, BPRM, kexec,
> >>>> firmware, etc.  Even finer granularity could somehow limit a key's
> >>>> signature verification to files in particular software package(s) for
> >>>> example.
> >>>> 
> >>>> Perhaps Mickaël and Eric were thinking about a new LSM to control usage
> >>>> of x509 certificates from a totally different perspective.  I'd like to
> >>>> hear what they're thinking.
> >>>> 
> >>>> I hope this addressed your questions.
> >>> 
> >>> Okay, so you were talking about finer granularity when compared to the
> >>> *current* LSM keyring hooks.  Gotcha.
> >>> 
> >>> If we need additional, or modified, hooks that shouldn't be a problem.
> >>> Although I'm guessing the answer is going to be moving towards
> >>> purpose/operation specific keyrings which might fit in well with the
> >>> current keyring level controls.
> >> 
> >> I don't believe defining per purpose/operation specific keyrings will
> >> resolve the underlying problem of granularity.
> > 
> > Perhaps not completely, but for in-kernel operations I believe it is
> > an attractive idea.
> 
> Could the X.509 Extended Key Usage (EKU) extension [1], be used here?  
> Various OIDs would need to be defined or assigned for each purpose.  
> Once assigned, the kernel could parse this information and do the
> enforcement.  Then all keys could continue to remain in the .builtin, 
> .secondary, and .machine keyrings.   Only a subset of each keyring 
> would be used for verification based on what is contained in the EKU.
> 
> 1. https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.12

I was also thinking about this kind of use cases. Because it might be
difficult in practice to control all certificate properties, we might
want to let sysadmins configure these subset of keyring according to
various certificate properties. There are currently LSM hooks to control
interactions with kernel keys by user space, and keys are already tied
to LSM blobs. New LSM hooks could be added to dynamically filter
keyrings according to kernel usages (e.g. kernel module verification, a
subset of an authentication mechanism according to the checked object).
