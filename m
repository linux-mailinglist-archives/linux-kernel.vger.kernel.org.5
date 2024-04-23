Return-Path: <linux-kernel+bounces-155970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6398AFC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECB2281BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17832D047;
	Tue, 23 Apr 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NdeX6Nh8"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507B1EA8D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912308; cv=none; b=CeRX7nmjaBEGCf2lX/eqvIOp7t/jx+CxRNXgRth5zJZQvgTJkxlJGudmbZX1a3WD/yqlFerJ5Avi8XT9dgP6cHBRC2R9munKFo+k/qxbeV3lUNSz56AQla9plkPv74IynmsIFGLdfuBgmeAiwShITvoObkPfCXIfuHdDanmTnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912308; c=relaxed/simple;
	bh=DBKgF3KOmNBDQ24car/w+P8kQlsuYQxd6kumEe/Hn6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ad7wZyDjC4jp4Qf8mP5LUEDMc02qesVggPUBIEsmSh5p5gsPCBQWJcjCDactRyd4u5zQtLPi/WHvSoCvR7yAcQRRGOppiqo5jeP1t12xQPP7peVLmSK/c7QHWxFH7w7Gsj8JKTQYcDEQ0iChVQc9ri2X5sG+ZwvJ5+HGDd3r9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NdeX6Nh8; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de45dba157cso5040211276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713912305; x=1714517105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wCxSV+Z5tSoaAjfH781SK78SuOpqAIKBjCyUSBhywuE=;
        b=NdeX6Nh8Dr5bul0HpiIfgCTJDlRSUs4wMPA5BEmeP0K1UdVVDrDdoM84CDoz1TeCnU
         TEgPSiAzYluLNitJbHcbWyqqUV3TLfyAJlXbFJxUgHz77SJLoNTFthnVGYJwZ7r+03fv
         owpIhkL4vv80Y2iKnBwfw5Vhe3Dz0kHpSrUv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713912305; x=1714517105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCxSV+Z5tSoaAjfH781SK78SuOpqAIKBjCyUSBhywuE=;
        b=KtQx4AhYPtKaSRumqk3lWJNxawu7pSyOh/dXBWBTQJ1+uwuBwWqetnEm4KWgYzyc6/
         KZuFmCc9NxnX6b8ku2+roVKwaMEaxLgG/upNSisWv6KfyLEf2jq4h/1QE9i/XzmDeK6R
         0CcDRUie2Rj7dpO+bQoD1QqhAuVW105bg+kr396kscLjBQ8IzzH/SHgCGOnzdCNJ5jbH
         tdD7TGB5ozSj9p2K8BX1ydr1R7sIKztx4zjXtZYnPJYj2tmzDlNQSWuyy3JqyYMIMeOc
         o/NBjHTI05MqjQGUfOvFc7qp0xEBL8UMXDWrR0S/xY0HhMS2j3WoVUjJN3v1gfUYcuZe
         9WSA==
X-Forwarded-Encrypted: i=1; AJvYcCXZZ0BRvEiY4ClfLGFm8dlFMqYIznGjjm7nhwjUiwrfyIvt5ioDaR5oYD5AcpcRsILybaX2IHWXuij5zVWDTBU4DBPjwvBELjMqjkcU
X-Gm-Message-State: AOJu0YyJfzMAMdAVJKr0nGE15xACEYxvvIMo6PJ8BQnoSoKg0UOiFrGe
	FvfRR3bRUzt8NcazlWGGB3acNOQ8adMIWJEse+B8vZRYzuztHS9DUs7LBj9z5Lg5j+KwgrEcNQZ
	9fB4+lt5UxAwRr+ze7YeBeHKj8qOiLmSwnzP/jNeBTjpUlaqF5/SYn1gswvgk1BT41G79ShmobZ
	/xP80cjqMfmEGX78OYmW4T2yuz9nGlf013uSq9
X-Google-Smtp-Source: AGHT+IEYABIoVNWUcOOM3GcdkR+LEHPT9RkP0ZzG0FwwMpoCKfaGvzCkaBSnv9pyMoajOwwtDKIHZIgboErHRkqMu+A=
X-Received: by 2002:a25:acc3:0:b0:dc7:4859:6f1 with SMTP id
 x3-20020a25acc3000000b00dc7485906f1mr1129152ybd.33.1713912304864; Tue, 23 Apr
 2024 15:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321174423.00007e0d@Huawei.com> <66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
 <20240410124517.000075f2@Huawei.com> <CACX_a4XGLgmQC3cqCmDJnrcnfjQRW4EmV8BZTCC=MgzwYwdhXA@mail.gmail.com>
In-Reply-To: <CACX_a4XGLgmQC3cqCmDJnrcnfjQRW4EmV8BZTCC=MgzwYwdhXA@mail.gmail.com>
From: Sreenivas Bagalkote <sreenivas.bagalkote@broadcom.com>
Date: Tue, 23 Apr 2024 16:44:37 -0600
Message-ID: <CACX_a4UM7wqb_eGSP2m2f2ytQGB3j+3Y4iP2H1UfMdVmm2a+=w@mail.gmail.com>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Brett Henning <brett.henning@broadcom.com>, 
	Harold Johnson <harold.johnson@broadcom.com>, 
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>, linux-kernel@vger.kernel.org, 
	Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linuxarm@huawei.com, linux-api@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000027742d0616cb4e2a"

--00000000000027742d0616cb4e2a
Content-Type: multipart/alternative; boundary="0000000000001bbc3b0616cb4e6d"

--0000000000001bbc3b0616cb4e6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can somebody please at least acknowledge that you are getting my emails?

Thank you
Sreeni
Sreenivas Bagalkote <Sreenivas.Bagalkote@broadcom.com>
Product Planning & Management
Broadcom Datacenter Solutions Group

On Mon, Apr 15, 2024 at 2:09=E2=80=AFPM Sreenivas Bagalkote <
sreenivas.bagalkote@broadcom.com> wrote:

> Hello,
>
> >> We need guidance from the community.
>
> >> 1. Datacenter customers must be able to manage PCIe switches in-band.>=
> 2. Management of switches includes getting health, performance, and error=
 telemetry.>> 3. These telemetry functions are not yet part of the CXL stan=
dard>> 4. We built the CCI mailboxes into our PCIe switches per CXL spec an=
d developed our management scheme around them.>> >> If the Linux community =
does not allow a CXL spec-compliant switch to be>> managed via the CXL spec=
-defined CCI mailbox, then please guide us on>> the right approach. Please =
tell us how you propose we manage our switches>> in-band.
>
> I am still looking for your guidance. We need to be able to manage our
> switch via the CCI mailbox. We need to use vendor-defined commands per CX=
L
> spec.
>
> You talked about whitelisting commands (allow-list) which we agreed to.
> Would you please confirm that you will allow the vendor-defined allow-lis=
t
> of commands?
>
> Thank you
> Sreeni
>
> On Wed, Apr 10, 2024 at 5:45=E2=80=AFAM Jonathan Cameron <
> Jonathan.Cameron@huawei.com> wrote:
>
>> On Fri, 5 Apr 2024 17:04:34 -0700
>> Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> Hi Dan,
>>
>> > Jonathan Cameron wrote:
>> > > Hi All,
>> > >
>> > > This is has come up in a number of discussions both on list and in
>> private,
>> > > so I wanted to lay out a potential set of rules when deciding whethe=
r
>> or not
>> > > to provide a user space interface for a particular feature of CXL
>> Fabric
>> > > Management.  The intent is to drive discussion, not to simply tell
>> people
>> > > a set of rules.  I've brought this to the public lists as it's a
>> Linux kernel
>> > > policy discussion, not a standards one.
>> > >
>> > > Whilst I'm writing the RFC this my attempt to summarize a possible
>> > > position rather than necessarily being my personal view.
>> > >
>> > > It's a straw man - shoot at it!
>> > >
>> > > Not everyone in this discussion is familiar with relevant kernel or
>> CXL concepts
>> > > so I've provided more info than I normally would.
>> >
>> > Thanks for writing this up Jonathan!
>> >
>> > [..]
>> > > 2) Unfiltered userspace use of mailbox for Fabric Management - BMC
>> kernels
>> > >
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >
>> > > (This would just be a kernel option that we'd advise normal server
>> > > distributions not to turn on. Would be enabled by openBMC etc)
>> > >
>> > > This is fine - there is some work to do, but the switch-cci PCI driv=
er
>> > > will hopefully be ready for upstream merge soon. There is no
>> filtering of
>> > > accesses. Think of this as similar to all the damage you can do via
>> > > MCTP from a BMC. Similarly it is likely that much of the complexity
>> > > of the actual commands will be left to user space tooling:
>> > > https://gitlab.com/jic23/cxl-fmapi-tests has some test examples.
>> > >
>> > > Whether Kconfig help text is strong enough to ensure this only gets
>> > > enabled for BMC targeted distros is an open question we can address
>> > > alongside an updated patch set.
>> >
>> > It is not clear to me that this material makes sense to house in
>> > drivers/ vs tools/ or even out-of-tree just for maintenance burden
>> > relief of keeping the universes separated. What does the Linux kernel
>> > project get out of carrying this in mainline alongside the inband code=
?
>>
>> I'm not sure what you mean by in band.  Aim here was to discuss
>> in-band drivers for switch CCI etc. Same reason from a kernel point of
>> view for why we include embedded drivers.  I'll interpret in band
>> as host driven and not inband as FM-API stuff.
>>
>> > I do think the mailbox refactoring to support non-CXL use cases is
>> > interesting, but only so far as refactoring is consumed for inband use
>> > cases like RAS API.
>>
>> If I read this right, I disagree with the 'only so far' bit.
>>
>> In all substantial ways we should support BMC use case of the Linux Kern=
el
>> at a similar level to how we support forms of Linux Distros.  It may
>> not be our target market as developers for particular parts of our
>> companies,
>> but we should not block those who want to support it.
>>
>> We should support them in drivers/ - maybe with example userspace code
>> in tools.  Linux distros on BMCs is a big market, there are a number
>> of different distros using (and in some cases contributing to) the
>> upstream kernel. Not everyone is using openBMC so there is not one
>> common place where downstream patches could be carried.
>> From a personal point of view, I like that for the same reasons that
>> I like there being multiple Linux sever focused distros. It's a sign
>> of a healthy ecosystem to have diverse options taking the mainline
>> kernel as their starting point.
>>
>> BMCs are just another embedded market, and like other embedded markets
>> we want to encourage upstream first etc.
>> openBMC has a policy on this:
>> https://github.com/openbmc/docs/blob/master/kernel-development.md
>> "The OpenBMC project maintains a kernel tree for use by the project.
>> The tree's general development policy is that code must be upstream
>> first." There are paths to bypass that for openBMC so it's a little
>> more relaxed than some enterprise distros (today, their policies used
>> to look very similar to this) but we should not be telling
>> them they need to carry support downstream.  If we are
>> going to tell them that, we need to be able to point at a major
>> sticking point for maintenance burden.  So far I don't see the
>> additional complexity as remotely close reaching that bar.
>>
>> So I think we do want switch-cci support and for that matter the
>> equivalent
>> for MHDs in the upstream kernel.
>>
>> One place I think there is some wiggle room is the taint on use of raw
>> commands.  Leaving removal of that for BMC kernels as a patch they need
>> to carry downstream doesn't seem too burdensome. I'm sure they'll push
>> back if it is a problem for them!  So I think we can kick that question
>> into the future.
>>
>> Addressing maintenance burden, there is a question of where we split
>> the stack.  Ignore MHDs for now (I won't go into why in this forum...)
>>
>> The current proposal is (simplified to ignore some sharing in lookup cod=
e
>> etc
>> that I can rip out if we think it might be a long term problem)
>>
>>      _____________          _____________________
>>     |             |        |                     |
>>     | Switch CCI  |        |  Type 3 Driver stack|
>>     |_____________|        |_____________________|
>>            |___________________________|              Whatever GPU etc
>>                   _______|_______                   _______|______
>>                  |               |                 |              |
>>                  |  CXL MBOX     |                 | RAS API etc  |
>>                  |_______________|                 |______________|
>>                              |_____________________________|
>>                                            |
>>                                   _________|______
>>                                  |                |
>>                                  |   MMPT mbox    |
>>                                  |________________|
>>
>> Switch CCI Driver: PCI driver doing everything beyond the CXL mbox
>> specific bit.
>> Type 3 Stack: All the normal stack just with the CXL Mailbox specific
>> stuff factored
>>               out. Note we can move different amounts of shared logic in
>> here, but
>>               in essence it deals with the extra layer on top of the raw
>> MMPT mbox.
>> MMPT Mbox: Mailbox as per the PCI spec.
>> RAS API:   Shared RAS API specific infrastructure used by other drivers.
>>
>> If we see a significant maintenance burden, maybe we duplicate the CXL
>> specific
>> MBOX layer - I can see advantages in that as there is some stuff not
>> relevant
>> to the Switch CCI.  There will be some duplication of logic however such
>> as background command support (which is CXL only IIUC)  We can even use
>> a difference IOCTL number so the two can diverge if needed in the long
>> run.
>>
>> e.g. If it makes it easier to get upstream, we can merrily duplicated co=
de
>> so that only the bit common with RAS API etc is shared (assuming the
>> actually end up with MMPT, not the CXL mailbox which is what their curre=
nt
>> publicly available spec talks about and I assume is a pref MMPT left
>> over?)
>>
>>      _____________          _____________________
>>     |             |        |                     |
>>     | Switch CCI  |        |  Type 3 Driver stack|
>>     |_____________|        |_____________________|
>>            |                           |              Whatever GPU etc
>>     _______|_______             _______|_______        ______|_______
>>    |               |           |               |      |              |
>>    |  CXL MBOX     |           |  CXL MBOX     |      | RAS API etc  |
>>    |_______________|           |_______________|      |______________|
>>            |_____________________________|____________________|
>>                                          |
>>                                  ________|______
>>                                 |               |
>>                                 |   MMPT mbox   |
>>                                 |_______________|
>>
>>
>> > > (On to the one that the "debate" is about)
>> > >
>> > > 3) Unfiltered user space use of mailbox for Fabric Management -
>> Distro kernels
>> > >
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> > > (General purpose Linux Server Distro (Redhat, Suse etc))
>> > >
>> > > This is equivalent of RAW command support on CXL Type 3 memory
>> devices.
>> > > You can enable those in a distro kernel build despite the scary conf=
ig
>> > > help text, but if you use it the kernel is tainted. The result
>> > > of the taint is to add a flag to bug reports and print a big message
>> to say
>> > > that you've used a feature that might result in you shooting yoursel=
f
>> > > in the foot.
>> > >
>> > > The taint is there because software is not at first written to deal
>> with
>> > > everything that can happen smoothly (e.g. surprise removal) It's har=
d
>> > > to survive some of these events, so is never on the initial feature
>> list
>> > > for any bus, so this flag is just to indicate we have entered a worl=
d
>> > > where almost all bets are off wrt to stability.  We might not know
>> what
>> > > a command does so we can't assess the impact (and no one trusts vend=
or
>> > > commands to report affects right in the Command Effects Log - which
>> > > in theory tells you if a command can result problems).
>> >
>> > That is a secondary reason that the taint is there. Yes, it helps
>> > upstream not waste their time on bug reports from proprietary use case=
s,
>> > but the effect of that is to make "raw" command mode unattractive for
>> > deploying solutions at scale. It clarifies that this interface is a
>> > debug-tool that enterprise environment need not worry about.
>> >
>> > The more salient reason for the taint, speaking only for myself as a
>> > Linux kernel community member not for $employer, is to encourage open
>> > collaboration. Take firmware-update for example that is a standard
>> > command with known side effects that is inaccessible via the ioctl()
>> > path. It is placed behind an ABI that is easier to maintain and reason
>> > about. Everyone has the firmware update tool if they have the 'cat'
>> > command. Distros appreciate the fact that they do not need ship yet
>> > another vendor device-update tool, vendors get free tooling and end
>> > users also appreciate one flow for all devices.
>> >
>> > As I alluded here [1], I am not against innovation outside of the
>> > specification, but it needs to be open, and it needs to plausibly beco=
me
>> > if not a de jure standard at least a de facto standard.
>> >
>> > [1]:
>> https://lore.kernel.org/all/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8ZkcmHn=
Pp3B0cw@mail.gmail.com/
>>
>> Agree with all this.
>>
>> >
>> > > A concern was raised about GAE/FAST/LDST tables for CXL Fabrics
>> > > (a r3.1 feature) but, as I understand it, these are intended for a
>> > > host to configure and should not have side effects on other hosts?
>> > > My working assumption is that the kernel driver stack will handle
>> > > these (once we catch up with the current feature backlog!) Currently
>> > > we have no visibility of what the OS driver stack for a fabrics will
>> > > actually look like - the spec is just the starting point for that.
>> > > (patches welcome ;)
>> > >
>> > > The various CXL upstream developers and maintainers may have
>> > > differing views of course, but my current understanding is we want
>> > > to support 1 and 2, but are very resistant to 3!
>> >
>> > 1, yes, 2, need to see the patches, and agree on 3.
>>
>> If we end up with top architecture of the diagrams above, 2 will look
>> pretty
>> similar to last version of the switch-cci patches.  So raw commands only
>> + taint.
>> Factoring out MMPT is another layer that doesn't make that much
>> difference in
>> practice to this discussion. Good to have, but the reuse here would be
>> one layer
>> above that.
>>
>> Or we just say go for second proposed architecture and 0 impact on the
>> CXL specific code, just reuse of the MMPT layer.  I'd imagine people wil=
l
>> get
>> grumpy on code duplication (and we'll spend years rejecting patch sets
>> that
>> try to share the cdoe) but there should be no maintenance burden as
>> a result.
>>
>> >
>> > > General Notes
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >
>> > > One side aspect of why we really don't like unfiltered userspace
>> access to any
>> > > of these devices is that people start building non standard hacks in
>> and we
>> > > lose the ecosystem advantages. Forcing a considered discussion +
>> patches
>> > > to let a particular command be supported, drives standardization.
>> >
>> > Like I said above, I think this is not a side aspect. It is fundamenta=
l
>> > to the viability Linux as a project. This project only works because
>> > organizations with competing goals realize they need some common
>> > infrastructure and that there is little to be gained by competing on t=
he
>> > commons.
>> >
>> > >
>> https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8=
ZkcmHnPp3B0cw@mail.gmail.com/
>> > > provides some history on vendor specific extensions and why in
>> general we
>> > > won't support them upstream.
>> >
>> > Oh, you linked my writeup... I will leave the commentary I added here
>> in case
>> > restating it helps.
>> >
>> > > To address another question raised in an earlier discussion:
>> > > Putting these Fabric Management interfaces behind guard rails of som=
e
>> type
>> > > (e.g. CONFIG_IM_A_BMC_AND_CAN_MAKE_A_MESS) does not encourage the ri=
sk
>> > > of non standard interfaces, because we will be even less likely to
>> accept
>> > > those upstream!
>> > >
>> > > If anyone needs more details on any aspect of this please ask.
>> > > There are a lot of things involved and I've only tried to give a
>> fairly
>> > > minimal illustration to drive the discussion. I may well have missed
>> > > something crucial.
>> >
>> > You captured it well, and this is open source so I may have missed
>> > something crucial as well.
>> >
>>
>> Thanks for detailed reply!
>>
>> Jonathan
>>
>>
>>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000001bbc3b0616cb4e6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small"><fo=
nt face=3D"monospace">Can somebody please at least acknowledge that you are=
 getting my emails?</font></div><div class=3D"gmail_default" style=3D"font-=
size:small"><font face=3D"monospace"><br></font></div><div class=3D"gmail_d=
efault" style=3D"font-size:small"><font face=3D"monospace">Thank you</font>=
</div><div class=3D"gmail_default" style=3D"font-size:small"><font face=3D"=
monospace">Sreeni</font></div><div><div dir=3D"ltr" class=3D"gmail_signatur=
e" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><font size=3D"1=
" color=3D"#666666" face=3D"trebuchet ms, sans-serif"><a href=3D"mailto:Sre=
enivas.Bagalkote@broadcom.com" target=3D"_blank">Sreenivas Bagalkote</a></f=
ont></div><font size=3D"1" color=3D"#666666" face=3D"trebuchet ms, sans-ser=
if">Product Planning &amp; Management</font><div><font size=3D"1" color=3D"=
#666666" face=3D"trebuchet ms, sans-serif">Broadcom Datacenter Solutions Gr=
oup</font></div></div></div></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 15, 2024 at 2:09=E2=80=AFPM S=
reenivas Bagalkote &lt;<a href=3D"mailto:sreenivas.bagalkote@broadcom.com">=
sreenivas.bagalkote@broadcom.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_defau=
lt"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small"=
><font face=3D"monospace">Hello,</font></div><div class=3D"gmail_default"><=
span style=3D"color:rgb(0,0,51)"><br></span></div><div class=3D"gmail_defau=
lt"><span style=3D"color:rgb(0,0,51)">&gt;&gt; We need guidance from the co=
mmunity.</span></div><div class=3D"gmail_default"><pre style=3D"background-=
image:initial;background-position:initial;background-size:initial;backgroun=
d-repeat:initial;background-origin:initial;background-clip:initial;color:rg=
b(0,0,51)"><span style=3D"font-family:Arial,Helvetica,sans-serif">&gt;&gt;<=
/span><span style=3D"font-family:Arial,Helvetica,sans-serif">=C2=A0</span>1=
 Datacenter customers must be able to manage PCIe switches in-band.
<span style=3D"font-family:Arial,Helvetica,sans-serif">&gt;&gt;=C2=A0</span=
>2. Management of switches includes getting health, performance, and error =
telemetry.
<span style=3D"font-family:Arial,Helvetica,sans-serif">&gt;&gt;=C2=A0</span=
>3. These telemetry functions are not yet part of the CXL standard
<span style=3D"font-family:Arial,Helvetica,sans-serif">&gt;&gt;=C2=A0</span=
>4. We built the CCI mailboxes into our PCIe switches per CXL spec and deve=
loped our management scheme around them.
<span style=3D"font-family:Arial,Helvetica,sans-serif">&gt;&gt;=C2=A0</span=
>
<span style=3D"font-family:Arial,Helvetica,sans-serif">&gt;&gt;=C2=A0</span=
>If the Linux community does not allow a CXL spec-compliant switch to be
<span style=3D"font-family:Arial,Helvetica,sans-serif">&gt;&gt;=C2=A0</span=
>managed via the CXL spec-defined CCI mailbox, then please guide us on
<span style=3D"font-family:Arial,Helvetica,sans-serif">&gt;&gt;=C2=A0</span=
>the right approach. Please tell us how you propose we manage our switches
<span style=3D"font-family:Arial,Helvetica,sans-serif">&gt;&gt;=C2=A0</span=
>in-band.</pre></div><div class=3D"gmail_default" style=3D"font-size:small"=
><font face=3D"monospace">I am still looking for your guidance. We need to =
be able to manage our switch via the CCI mailbox. We need to use vendor-def=
ined commands per CXL spec.</font></div><div class=3D"gmail_default" style=
=3D"font-size:small"><font face=3D"monospace"><br></font></div><div class=
=3D"gmail_default" style=3D"font-size:small"><font face=3D"monospace">You t=
alked about whitelisting commands (allow-list) which we agreed to. Would yo=
u please confirm that you will allow the vendor-defined allow-list of comma=
nds?</font></div><div class=3D"gmail_default" style=3D"font-size:small"><fo=
nt face=3D"monospace"><br></font></div><div class=3D"gmail_default" style=
=3D"font-size:small"><font face=3D"monospace">Thank you</font></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><font face=3D"monospace">Sr=
eeni</font></div></div></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Apr 10, 2024 at 5:45=E2=80=AFAM Jonat=
han Cameron &lt;<a href=3D"mailto:Jonathan.Cameron@huawei.com" target=3D"_b=
lank">Jonathan.Cameron@huawei.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Fri, 5 Apr 2024 17:04:34 -0700<br>
Dan Williams &lt;<a href=3D"mailto:dan.j.williams@intel.com" target=3D"_bla=
nk">dan.j.williams@intel.com</a>&gt; wrote:<br>
<br>
Hi Dan,<br>
<br>
&gt; Jonathan Cameron wrote:<br>
&gt; &gt; Hi All,<br>
&gt; &gt; <br>
&gt; &gt; This is has come up in a number of discussions both on list and i=
n private,<br>
&gt; &gt; so I wanted to lay out a potential set of rules when deciding whe=
ther or not<br>
&gt; &gt; to provide a user space interface for a particular feature of CXL=
 Fabric<br>
&gt; &gt; Management.=C2=A0 The intent is to drive discussion, not to simpl=
y tell people<br>
&gt; &gt; a set of rules.=C2=A0 I&#39;ve brought this to the public lists a=
s it&#39;s a Linux kernel<br>
&gt; &gt; policy discussion, not a standards one.<br>
&gt; &gt; <br>
&gt; &gt; Whilst I&#39;m writing the RFC this my attempt to summarize a pos=
sible<br>
&gt; &gt; position rather than necessarily being my personal view.<br>
&gt; &gt; <br>
&gt; &gt; It&#39;s a straw man - shoot at it!<br>
&gt; &gt; <br>
&gt; &gt; Not everyone in this discussion is familiar with relevant kernel =
or CXL concepts<br>
&gt; &gt; so I&#39;ve provided more info than I normally would.=C2=A0 <br>
&gt; <br>
&gt; Thanks for writing this up Jonathan!<br>
&gt; <br>
&gt; [..]<br>
&gt; &gt; 2) Unfiltered userspace use of mailbox for Fabric Management - BM=
C kernels<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
&gt; &gt; <br>
&gt; &gt; (This would just be a kernel option that we&#39;d advise normal s=
erver<br>
&gt; &gt; distributions not to turn on. Would be enabled by openBMC etc)<br=
>
&gt; &gt; <br>
&gt; &gt; This is fine - there is some work to do, but the switch-cci PCI d=
river<br>
&gt; &gt; will hopefully be ready for upstream merge soon. There is no filt=
ering of<br>
&gt; &gt; accesses. Think of this as similar to all the damage you can do v=
ia<br>
&gt; &gt; MCTP from a BMC. Similarly it is likely that much of the complexi=
ty<br>
&gt; &gt; of the actual commands will be left to user space tooling: <br>
&gt; &gt; <a href=3D"https://gitlab.com/jic23/cxl-fmapi-tests" rel=3D"noref=
errer" target=3D"_blank">https://gitlab.com/jic23/cxl-fmapi-tests</a> has s=
ome test examples.<br>
&gt; &gt; <br>
&gt; &gt; Whether Kconfig help text is strong enough to ensure this only ge=
ts<br>
&gt; &gt; enabled for BMC targeted distros is an open question we can addre=
ss<br>
&gt; &gt; alongside an updated patch set.=C2=A0 <br>
&gt; <br>
&gt; It is not clear to me that this material makes sense to house in<br>
&gt; drivers/ vs tools/ or even out-of-tree just for maintenance burden<br>
&gt; relief of keeping the universes separated. What does the Linux kernel<=
br>
&gt; project get out of carrying this in mainline alongside the inband code=
?<br>
<br>
I&#39;m not sure what you mean by in band.=C2=A0 Aim here was to discuss<br=
>
in-band drivers for switch CCI etc. Same reason from a kernel point of<br>
view for why we include embedded drivers.=C2=A0 I&#39;ll interpret in band<=
br>
as host driven and not inband as FM-API stuff.<br>
<br>
&gt; I do think the mailbox refactoring to support non-CXL use cases is<br>
&gt; interesting, but only so far as refactoring is consumed for inband use=
<br>
&gt; cases like RAS API.<br>
<br>
If I read this right, I disagree with the &#39;only so far&#39; bit.<br>
<br>
In all substantial ways we should support BMC use case of the Linux Kernel<=
br>
at a similar level to how we support forms of Linux Distros.=C2=A0 It may<b=
r>
not be our target market as developers for particular parts of our companie=
s,<br>
but we should not block those who want to support it.<br>
<br>
We should support them in drivers/ - maybe with example userspace code<br>
in tools.=C2=A0 Linux distros on BMCs is a big market, there are a number<b=
r>
of different distros using (and in some cases contributing to) the<br>
upstream kernel. Not everyone is using openBMC so there is not one<br>
common place where downstream patches could be carried.<br>
From a personal point of view, I like that for the same reasons that<br>
I like there being multiple Linux sever focused distros. It&#39;s a sign<br=
>
of a healthy ecosystem to have diverse options taking the mainline<br>
kernel as their starting point.<br>
<br>
BMCs are just another embedded market, and like other embedded markets<br>
we want to encourage upstream first etc. <br>
openBMC has a policy on this:<br>
<a href=3D"https://github.com/openbmc/docs/blob/master/kernel-development.m=
d" rel=3D"noreferrer" target=3D"_blank">https://github.com/openbmc/docs/blo=
b/master/kernel-development.md</a><br>
&quot;The OpenBMC project maintains a kernel tree for use by the project.<b=
r>
The tree&#39;s general development policy is that code must be upstream<br>
first.&quot; There are paths to bypass that for openBMC so it&#39;s a littl=
e<br>
more relaxed than some enterprise distros (today, their policies used<br>
to look very similar to this) but we should not be telling<br>
them they need to carry support downstream.=C2=A0 If we are<br>
going to tell them that, we need to be able to point at a major<br>
sticking point for maintenance burden.=C2=A0 So far I don&#39;t see the<br>
additional complexity as remotely close reaching that bar.<br>
<br>
So I think we do want switch-cci support and for that matter the equivalent=
<br>
for MHDs in the upstream kernel.<br>
<br>
One place I think there is some wiggle room is the taint on use of raw<br>
commands.=C2=A0 Leaving removal of that for BMC kernels as a patch they nee=
d<br>
to carry downstream doesn&#39;t seem too burdensome. I&#39;m sure they&#39;=
ll push<br>
back if it is a problem for them!=C2=A0 So I think we can kick that questio=
n<br>
into the future.<br>
<br>
Addressing maintenance burden, there is a question of where we split<br>
the stack.=C2=A0 Ignore MHDs for now (I won&#39;t go into why in this forum=
..)<br>
<br>
The current proposal is (simplified to ignore some sharing in lookup code e=
tc<br>
that I can rip out if we think it might be a long term problem)<br>
<br>
=C2=A0 =C2=A0 =C2=A0_____________=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _______=
______________<br>
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|<br>
=C2=A0 =C2=A0 | Switch CCI=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 Type =
3 Driver stack| <br>
=C2=A0 =C2=A0 |_____________|=C2=A0 =C2=A0 =C2=A0 =C2=A0 |_________________=
____|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|___________________________|=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Whatever GPU etc<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _______|____=
___=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0___=
____|______<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 CXL M=
BOX=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| RAS API etc=C2=A0 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|____________=
___|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|________=
______|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|_____________________________|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _________|______<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0MMPT mbox=C2=A0 =
=C2=A0 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|________________|<br>
<br>
Switch CCI Driver: PCI driver doing everything beyond the CXL mbox specific=
 bit.<br>
Type 3 Stack: All the normal stack just with the CXL Mailbox specific stuff=
 factored<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out. Note we can move diff=
erent amounts of shared logic in here, but<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in essence it deals with t=
he extra layer on top of the raw MMPT mbox.<br>
MMPT Mbox: Mailbox as per the PCI spec.<br>
RAS API:=C2=A0 =C2=A0Shared RAS API specific infrastructure used by other d=
rivers.<br>
<br>
If we see a significant maintenance burden, maybe we duplicate the CXL spec=
ific<br>
MBOX layer - I can see advantages in that as there is some stuff not releva=
nt<br>
to the Switch CCI.=C2=A0 There will be some duplication of logic however su=
ch<br>
as background command support (which is CXL only IIUC)=C2=A0 We can even us=
e<br>
a difference IOCTL number so the two can diverge if needed in the long run.=
<br>
<br>
e.g. If it makes it easier to get upstream, we can merrily duplicated code<=
br>
so that only the bit common with RAS API etc is shared (assuming the<br>
actually end up with MMPT, not the CXL mailbox which is what their current<=
br>
publicly available spec talks about and I assume is a pref MMPT left over?)=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0_____________=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _______=
______________<br>
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|<br>
=C2=A0 =C2=A0 | Switch CCI=C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 Type =
3 Driver stack| <br>
=C2=A0 =C2=A0 |_____________|=C2=A0 =C2=A0 =C2=A0 =C2=A0 |_________________=
____|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Whatever GPU etc<br>
=C2=A0 =C2=A0 _______|_______=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0_______|_______=C2=A0 =C2=A0 =C2=A0 =C2=A0 ______|_______<br>
=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |<br>
=C2=A0 =C2=A0|=C2=A0 CXL MBOX=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 CXL MBOX=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =
| RAS API etc=C2=A0 |<br>
=C2=A0 =C2=A0|_______________|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|___=
____________|=C2=A0 =C2=A0 =C2=A0 |______________|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|_____________________________|___=
_________________|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0________|______<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0MMPT mbox=C2=A0 =C2=A0=
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |_______________|<br>
<br>
<br>
&gt; &gt; (On to the one that the &quot;debate&quot; is about)<br>
&gt; &gt; <br>
&gt; &gt; 3) Unfiltered user space use of mailbox for Fabric Management - D=
istro kernels<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; (General purpose Linux Server Distro (Redhat, Suse etc))<br>
&gt; &gt; <br>
&gt; &gt; This is equivalent of RAW command support on CXL Type 3 memory de=
vices.<br>
&gt; &gt; You can enable those in a distro kernel build despite the scary c=
onfig<br>
&gt; &gt; help text, but if you use it the kernel is tainted. The result<br=
>
&gt; &gt; of the taint is to add a flag to bug reports and print a big mess=
age to say<br>
&gt; &gt; that you&#39;ve used a feature that might result in you shooting =
yourself<br>
&gt; &gt; in the foot.<br>
&gt; &gt; <br>
&gt; &gt; The taint is there because software is not at first written to de=
al with<br>
&gt; &gt; everything that can happen smoothly (e.g. surprise removal) It&#3=
9;s hard<br>
&gt; &gt; to survive some of these events, so is never on the initial featu=
re list<br>
&gt; &gt; for any bus, so this flag is just to indicate we have entered a w=
orld<br>
&gt; &gt; where almost all bets are off wrt to stability.=C2=A0 We might no=
t know what<br>
&gt; &gt; a command does so we can&#39;t assess the impact (and no one trus=
ts vendor<br>
&gt; &gt; commands to report affects right in the Command Effects Log - whi=
ch<br>
&gt; &gt; in theory tells you if a command can result problems).=C2=A0 <br>
&gt; <br>
&gt; That is a secondary reason that the taint is there. Yes, it helps<br>
&gt; upstream not waste their time on bug reports from proprietary use case=
s,<br>
&gt; but the effect of that is to make &quot;raw&quot; command mode unattra=
ctive for<br>
&gt; deploying solutions at scale. It clarifies that this interface is a<br=
>
&gt; debug-tool that enterprise environment need not worry about.<br>
&gt; <br>
&gt; The more salient reason for the taint, speaking only for myself as a<b=
r>
&gt; Linux kernel community member not for $employer, is to encourage open<=
br>
&gt; collaboration. Take firmware-update for example that is a standard<br>
&gt; command with known side effects that is inaccessible via the ioctl()<b=
r>
&gt; path. It is placed behind an ABI that is easier to maintain and reason=
<br>
&gt; about. Everyone has the firmware update tool if they have the &#39;cat=
&#39;<br>
&gt; command. Distros appreciate the fact that they do not need ship yet<br=
>
&gt; another vendor device-update tool, vendors get free tooling and end<br=
>
&gt; users also appreciate one flow for all devices.<br>
&gt; <br>
&gt; As I alluded here [1], I am not against innovation outside of the<br>
&gt; specification, but it needs to be open, and it needs to plausibly beco=
me<br>
&gt; if not a de jure standard at least a de facto standard.<br>
&gt; <br>
&gt; [1]: <a href=3D"https://lore.kernel.org/all/CAPcyv4gDShAYih5iWabKg_eTH=
huHm54vEAei8ZkcmHnPp3B0cw@mail.gmail.com/" rel=3D"noreferrer" target=3D"_bl=
ank">https://lore.kernel.org/all/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8Zkcm=
HnPp3B0cw@mail.gmail.com/</a><br>
<br>
Agree with all this.<br>
<br>
&gt; <br>
&gt; &gt; A concern was raised about GAE/FAST/LDST tables for CXL Fabrics<b=
r>
&gt; &gt; (a r3.1 feature) but, as I understand it, these are intended for =
a<br>
&gt; &gt; host to configure and should not have side effects on other hosts=
?<br>
&gt; &gt; My working assumption is that the kernel driver stack will handle=
<br>
&gt; &gt; these (once we catch up with the current feature backlog!) Curren=
tly<br>
&gt; &gt; we have no visibility of what the OS driver stack for a fabrics w=
ill<br>
&gt; &gt; actually look like - the spec is just the starting point for that=
<br>
&gt; &gt; (patches welcome ;)<br>
&gt; &gt; <br>
&gt; &gt; The various CXL upstream developers and maintainers may have<br>
&gt; &gt; differing views of course, but my current understanding is we wan=
t<br>
&gt; &gt; to support 1 and 2, but are very resistant to 3!=C2=A0 <br>
&gt; <br>
&gt; 1, yes, 2, need to see the patches, and agree on 3.<br>
<br>
If we end up with top architecture of the diagrams above, 2 will look prett=
y<br>
similar to last version of the switch-cci patches.=C2=A0 So raw commands on=
ly + taint.<br>
Factoring out MMPT is another layer that doesn&#39;t make that much differe=
nce in<br>
practice to this discussion. Good to have, but the reuse here would be one =
layer<br>
above that.<br>
<br>
Or we just say go for second proposed architecture and 0 impact on the<br>
CXL specific code, just reuse of the MMPT layer.=C2=A0 I&#39;d imagine peop=
le will get<br>
grumpy on code duplication (and we&#39;ll spend years rejecting patch sets =
that<br>
try to share the cdoe) but there should be no maintenance burden as<br>
a result.<br>
<br>
&gt; <br>
&gt; &gt; General Notes<br>
&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt; <br>
&gt; &gt; One side aspect of why we really don&#39;t like unfiltered usersp=
ace access to any<br>
&gt; &gt; of these devices is that people start building non standard hacks=
 in and we<br>
&gt; &gt; lose the ecosystem advantages. Forcing a considered discussion + =
patches<br>
&gt; &gt; to let a particular command be supported, drives standardization.=
=C2=A0 <br>
&gt; <br>
&gt; Like I said above, I think this is not a side aspect. It is fundamenta=
l<br>
&gt; to the viability Linux as a project. This project only works because<b=
r>
&gt; organizations with competing goals realize they need some common<br>
&gt; infrastructure and that there is little to be gained by competing on t=
he<br>
&gt; commons.<br>
&gt; <br>
&gt; &gt; <a href=3D"https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWab=
Kg_eTHhuHm54vEAei8ZkcmHnPp3B0cw@mail.gmail.com/" rel=3D"noreferrer" target=
=3D"_blank">https://lore.kernel.org/linux-cxl/CAPcyv4gDShAYih5iWabKg_eTHhuH=
m54vEAei8ZkcmHnPp3B0cw@mail.gmail.com/</a><br>
&gt; &gt; provides some history on vendor specific extensions and why in ge=
neral we<br>
&gt; &gt; won&#39;t support them upstream.=C2=A0 <br>
&gt; <br>
&gt; Oh, you linked my writeup... I will leave the commentary I added here =
in case<br>
&gt; restating it helps.<br>
&gt; <br>
&gt; &gt; To address another question raised in an earlier discussion:<br>
&gt; &gt; Putting these Fabric Management interfaces behind guard rails of =
some type<br>
&gt; &gt; (e.g. CONFIG_IM_A_BMC_AND_CAN_MAKE_A_MESS) does not encourage the=
 risk<br>
&gt; &gt; of non standard interfaces, because we will be even less likely t=
o accept<br>
&gt; &gt; those upstream!<br>
&gt; &gt; <br>
&gt; &gt; If anyone needs more details on any aspect of this please ask.<br=
>
&gt; &gt; There are a lot of things involved and I&#39;ve only tried to giv=
e a fairly<br>
&gt; &gt; minimal illustration to drive the discussion. I may well have mis=
sed<br>
&gt; &gt; something crucial.=C2=A0 <br>
&gt; <br>
&gt; You captured it well, and this is open source so I may have missed<br>
&gt; something crucial as well.<br>
&gt; <br>
<br>
Thanks for detailed reply!<br>
<br>
Jonathan<br>
<br>
<br>
</blockquote></div>
</blockquote></div>

<br>
<span style=3D"background-color:rgb(255,255,255)"><font size=3D"2">This ele=
ctronic communication and the information and any files transmitted with it=
, or attached to it, are confidential and are intended solely for the use o=
f the individual or entity to whom it is addressed and may contain informat=
ion that is confidential, legally privileged, protected by privacy laws, or=
 otherwise restricted from disclosure to anyone else. If you are not the in=
tended recipient or the person responsible for delivering the e-mail to the=
 intended recipient, you are hereby notified that any use, copying, distrib=
uting, dissemination, forwarding, printing, or copying of this e-mail is st=
rictly prohibited. If you received this e-mail in error, please return the =
e-mail to the sender, delete it from your computer, and destroy any printed=
 copy of it.</font></span>
--0000000000001bbc3b0616cb4e6d--

--00000000000027742d0616cb4e2a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWEwggRJoAMCAQICDFYaRLSTNnawblU3yzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTI0MjNaFw0yNTA5MTAwOTI0MjNaMIGc
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHDAaBgNVBAMTE1NyZWVuaXZhcyBCYWdhbGtvdGUxLzAtBgkq
hkiG9w0BCQEWIHNyZWVuaXZhcy5iYWdhbGtvdGVAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAuuAqYt2XMpXqqYrSYVv64PlRiKuXJ1Hesi3rmZm4+g8EIZRtyETO
RWiFc6q59aDOqgjp94efpIVthPgLGM5Uv2iBj+XGsZzaiJn4ZasS5UNh0N6Rpj6dLHXBwRGaQsld
e5WvrXWFBwSZWVNj241paUqCIV+ybg8DS6/tCwEetzOgmjs4LgYlpj957G5EryaCzH5ncDrHz2Kj
q98WQ9dndZnpUpaPV2hP60IVspaStey0I6WjPBy7qNhbZV4J4ZN71tnZ7CrNkXy5KhwKEs+MiegU
OQvZ9yJQdMq9Ry3cO3DNfLXNGHuM2IKh6YPPScUnfGbmK/wkpXthxhJx+kn1IQIDAQABo4IB4TCC
Ad0wDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDArBgNVHREEJDAigSBzcmVlbml2YXMuYmFnYWxrb3RlQGJyb2FkY29tLmNvbTATBgNV
HSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4E
FgQU08YdPZld7W8H+uK8S2EPeYqBn20wDQYJKoZIhvcNAQELBQADggEBAGUBviL4v9e/8GOQBEZO
mm5a/OZCkJ6COPgkQ4TEHxWWx7iYG+TVkJ2qxNS1fXQUPnAC/TBfb37wLVynlBBRTb4PYzKIfaHW
bH9AscUsus4kEUyzYSLHYqQilComzpGFxor1x2fbLYpHMCU950wueyUHPHA3jwpWrluCE7283dWT
rz/VNFx2cjW+y8+T+lVxO44XmrQoa8lnz3fb+QCVvRyH8sUqAYjfkscFkknlkF0NobKXFSKwK1zZ
4ZQOk9tT7FYGWvy0nhOEUt/uKZNncumowkhquxqJve0HiOF6Z6R0eKybmGDGaWDYE11aHV62bKTn
/SH9BOZuA2GG8ZiNR08xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBD
QSAyMDIwAgxWGkS0kzZ2sG5VN8swDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIE8N
hWXlCPMiRPDbFI5Q+1N88m3mQJxrXmW2dbezoYj2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI0MDQyMzIyNDUwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJ
KoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBvFdcfY/wtUx4nqVbCLkbC
vu/qGXan+26OzCOk6X+EJQZlPuhl3lPL3L2lTo12n8nV24W48x6kGj4N9qF1WDQg8MmKmqbAsJt/
XW9nA3eBROrQjf6jzIP/g++DRoKn4porpLjbwFeMJsvBxQjJRT/AnVmcBv8vZ2jz1DEqNXg7BzM8
3Rvdf0vlLZogZ+9eJAelMxkfhw879xIi0SQZ40MJ1TZFB3wixFFDWAHciJkD/l9C7rwBgcIkwCix
mCo2akqgGPagPjFljE91cdJTyttmnRYRBch+FootgqnYs0gd37ZJiLnZuWKGHt6WTvkXQqTuCP9Q
oGirmqr7Dta1zSd0
--00000000000027742d0616cb4e2a--

