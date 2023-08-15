Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6536377CB19
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbjHOKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbjHOKUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:20:31 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4573115;
        Tue, 15 Aug 2023 03:20:27 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 37FAJnlt031412;
        Tue, 15 Aug 2023 05:19:49 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 37FAJlZF031411;
        Tue, 15 Aug 2023 05:19:47 -0500
Date:   Tue, 15 Aug 2023 05:19:47 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 03/13] Implement CAP_TRUST capability.
Message-ID: <20230815101947.GA31391@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com> <20230710102319.19716-4-greg@enjellic.com> <c5b07b78-f37e-6e95-9c2e-044afe1dd894@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b07b78-f37e-6e95-9c2e-044afe1dd894@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 15 Aug 2023 05:19:49 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 01:21:35PM -0700, Casey Schaufler wrote:

Good morning, I hope this note finds the day starting well for
everyone.

> On 7/10/2023 3:23 AM, Dr. Greg wrote:
> > TSEM was designed to support a Trust Orchestration System (TOS)
> > security architecture.  A TOS based system uses the concept of a
> > minimum Trusted Computing Base of utilities, referred to as trust
> > orchestrators, that maintain workloads in a trusted execution
> > state.  The trust orchestrators are thus, from a security
> > perspective, the most security privileged processes running on
> > the platform.
> >
> > The CAP_ML (machine modeling) capability is defined as a
> > capability that allows a process to alter the modeling and hence
> > the trust status of the platform.  In a fully orchestrated system
> > only the trust orchestrator carry this capability bit and then
> > drop the capability for the execution of the workload.  This is
> > designed to prevent a security vulnerability in workloads to be
> > leveraged to create an entity that could conduct adversarial
> > modifications to the trust status of the platform.
> >
> > With the introduction of TSEM there are three generic mechanisms
> > for implementing security contols, each with its own capability
> > bit for management, ie:
> >
> > DAC - CAP_DAC_ADMIN

> There is no CAP_DAC_ADMIN. There are several capabilities related to
> changing the DAC state of the system.

Our apologies, I believe we were thinking of CAP_DAC_OVERRIDE.

> > MAC - CAP_MAC_ADMIN

> Since your system implements a mandatory access control policy
> you should be using CAP_MAC_ADMIN.

See below.

> > Security modeling - CAP_ML

> First, the name you've chosen makes no sense at all. It isn't
> descriptive and fails even as an abbreviation. Second, you aren't
> doing anything that wouldn't be covered under CAP_MAC_ADMIN.

Apologies for the name, we choose it ad-hoc as an acronym for 'Machine
Learning' which is what TSEM uses, in potentially multiple forms, to
implement its security controls.  I wouldn't anticipate it to be
forthcoming from your corner, but feel free to suggest an alternative.

You note above that CAP_MAC_ADMIN should be used because TSEM ends up
implementing access control decsions that are mandatory in nature

As our documentation notes, with the introduction of TSEM there are
three mechanisms that are now available to implement security
controls: DAC, static MAC and dynamic controls based on
modeling/machine learning.

Our premise for proposing a separate capability is that different
methods of achieving security controls should use different
capabilities, so that the capability controls remain orthogonal and
independent of one another.

Additionally.

The mandatory controls implemented by TSEM are subtly different in
intent from those implemented by the incumbent LSM's, since TSEM's
controls can be generated and implemented by software developers or
users.  You had noted in other replies that classic mandatory controls
should only be implemented by system administrators or security
architects.

Finally.

TSEM brings with it the ability to allow the creation of security
control namespaces that do not conflict with other security
namespaces, with the exception that the non-namespaced controls will
also exert their authority if they are 'stacked' with TSEM.  If we
read user interest and expectations correctly, which I believe we do,
there will only be an increasing demand for this type of security
functionality.

Given that, it will be problematic, moving forward, if the capability
to create isolated security namespaces is not orthogonal with the
ability to modify how a policy can be configured or managed within an
isolated security namespace.

Given this latter issue, CAP_ML probably needs a different name,
once again, suggestions are welcome.

> > Having a separate capability bit for security modeling allows DAC
> > and classic label or path based MAC systems to be implemented in
> > the context of a security modeling namespace.  Looking forward it
> > is not unreasonable to consider the implementation of a modeling
> > policy that would verify the status of extended attributes being
> > used for label based MAC controls.

> It seems reasonable that being trusted with the privilege to change
> the modeling policy would imply sufficient trust to change other
> security states where allowed. As the Smack maintainer, and having
> introduced CAP_MAC_ADMIN, I say that there's insufficient grounds to
> introduce a new, single purpose capability.

First, no one, least of all our group, doubts your contributions to
the art.

We are also very confident, in the level of skills and experience in
the fields of modeling and security operations, of the team that is
bringing forward TSEM.

Based on these experiences, as we noted above, we believe it will be
unwise to not make the ability to control the creation, isolation and
protection of a security namespace from the ability to modify the
configuration of a security policy within a namespace.

Secondly.

With respect to the capability being 'single purpose'.  We haven't
seen a clear pathway or discussion regarding namespaces for other
security architectures, given the known structural issues involved
with classic labeling or pathname based implementations.  Paul
suggests that there is ongoing thinking on how to address this issue
and you've noted that the stacking work needs to go in before further
functionality can be considered.

The new capability bit will be available when those initiatives move
forward.  Kernel doctrine has been that at least a single use of
functionality must be present for a feature to be added, TSEM provides
that initial use.

Finally.

In his 'ANN' document, regarding LSM submission requirements, Paul
Moore noted that he did not want to require the need to demonstrate a
'community of support' around an LSM in order to avoid a 'chicken and
egg' problem.  He further noted that LSM authors need to be able to
guarantee that API's will be durable for 20+ years.

Within the security industry there is already a 'chicken and egg'
problem.  A new security architecture or scheme will not evolve
without the system, at a minimum, being in the Linux kernel.  New
security architectures do not organically appear and evolve, we can
state this fact with significant authority.

Without generic availability and use of a technology, it is difficult
to reason how correct 20+ year guesses on needed functionality can be
made.  So there needs to be a 'guess' on how to implement technology,
in the most generic form that does not lock the implementation into a
corner.

We've tried to make these 'guesses' with TSEM, based on, now 15+ years
of experience, with multiple implementations of security modeling and
namespacing.  Our advocacy for the new capability bit, whatever it is
named, is based on that body of experience.

We have proposed what we believe is the correct implementation and
API.  If the only way forward is an alternate implementation, we have
conducted our due diligence, which history will document if that
alternate implementation proves to be insufficient and constraining.

Best wishes for a productive remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
