Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4E5755F25
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGQJXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGQJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F270C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689585780;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=DMM9NGYi5CLYRI4OkWOf5QjGfHcEFxvwN3b6CKFPSr0=;
        b=HaHP0X32h26OUJ5o7Sk4fNW2F9SMCHD7eTcRvEp7p3Tk+8sa8gb+kxItjbRvAdH1kHaH/O
        rDc8YbiJG1TDZQT6AfWR5Z80A6DvybKnwy8Ada0CuPAWUPc634n0diYXAehrqimESl4Vn0
        ybYx9l+Op55K3IQAJlctxu14iPXCc2Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-JJDxCNOUPFaoQ1kamyJf4g-1; Mon, 17 Jul 2023 05:22:57 -0400
X-MC-Unique: JJDxCNOUPFaoQ1kamyJf4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CDC71C06EC1;
        Mon, 17 Jul 2023 09:22:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 255351454142;
        Mon, 17 Jul 2023 09:22:54 +0000 (UTC)
Date:   Mon, 17 Jul 2023 10:22:51 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Luca Boccassi <bluca@debian.org>, Borislav Petkov <bp@alien8.de>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <ZLUIViihakhyPV1N@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <2023071226-crafty-deviator-12e2@gregkh>
 <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <2023071233-empirical-overturn-744c@gregkh>
 <CAMw=ZnRRviBNi_LK9VOSUV9PNHe3jurUcLfgLpbTOsp_eE4WyA@mail.gmail.com>
 <2023071350-specked-botanist-6ba8@gregkh>
 <CAMw=ZnQZ9ds3xsa2AZv_F13dB6rR4XzGPrBjJHSga1oU5xRezQ@mail.gmail.com>
 <2023071552-quilt-tranquil-b7bf@gregkh>
 <CAMw=ZnROWgDOiAr1iikTWa7Qm81HoE17NuEdLt8hwGnkKSnoCg@mail.gmail.com>
 <2023071643-broiler-level-afbf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023071643-broiler-level-afbf@gregkh>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 08:28:10PM +0200, Greg KH wrote:
> On Sun, Jul 16, 2023 at 06:41:04PM +0100, Luca Boccassi wrote:
> > On Sat, 15 Jul 2023 at 07:52, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > If you are not willing to take the time to determine how this proposed
> > > change will affect the kernel developers and infrastructure by doing
> > > some modeling based on our past history, then we have no reason to even
> > > consider accepting this change as you are stating that you have no idea
> > > how it will affect us.
> > 
> > There's no need for that to tell you how this will affect you: it will
> > not. Every now and then you'll receive a one-liner patch to apply.
> > What's so terrible about that?

I think that's not entirely accurate, as this *will* have an impact on
anyone involved in backporting fixes for the kernel stable trees, when
they need to resolve conflicts on the SBAT file. It shouldn't have a
big impact, but we should be honest that it will be a non-zero impact.

Lets say mainline branch has had 2 security vulnerabilities A and B,
each of which was associated with an increment of the SBAT version
number. The first flaw A changed SBAT from 7 to 8,and then the second
flaw B changed SBAT from 8 to 9.

If someone wants to backport the fix for bug "B" they will get a
conflict on the SBAT file when cherry-picking the patch. When that
happens they must decide:

  * It is acceptable to ignore issue A, because it didn't affect
    that branch. The conflict is resolved by having the backported
    patch increase SBAT version from 7 to 9 directly.

  * It is required to first backport issue A, because that also
    affects that branch. The conflict is resolved by first backporting
    the code fix & SBAT change for A, and then backporting the code
    fix and SBAT change for B. SBAT changes from 7 to 8 to 9 just
    like on master.

IOW whomever is doing backport patches for stable needs to understand
the semantics of SBAT and how to resolve conflicts on it. If they get
this wrong, then it breaks the protection offered by SBAT, which would
then require a 3rd SBAT change to fix the mistake.

This likely means that stable tree maintainers themselves need to
understand the SBAT change rules, so they can review conflict resolution
for any proposed changes, to sanity check what is being proposed.

> And who will be sending that to me?  For what releases?  For how long
> will they be agreeing to do this work for?  How will it be tracked?
> What will they be using to determine when the number will be changed?
> How will they know it should be changed?

Before we consider SBAT, there is the code bug & its patch.

Someone finds bug in the early boot process on EFI systems and cooks up
a patch for it. This is work that is already done today, whether entirely
upstream in the normal context of day-to-day kernel development, or
downstream with a vendor receiving a bug report and triaging a response
to it which eventually turns into an upstream submission.

Today there is the question of whether to assign a CVE to such fixes.

If upstream doesn't have an associated CVE identified when merging the
code patch, the downstream vendors act as a backstop and can decide to
assign a CVE after the fact. This is relatively easy as assigning a
CVE doesn't result in any code patches, it is just paperwork and does
not really impact upstream at that point.

In terms of triage, deciding to increment SBAT is little different
from deciding to assign a CVE. The analysis & decision can be done
upstream, but if not, downstream vendors can act as a backstop to
do the analysis after a code patch is already in upstream. I would
probably assume that any flaw serious enough to break SecureBoot
is likely going to arrive via an embargoed security report involving
downstream vendors, so SBT changes would be co-ordinated via the
vendor triage & response.

The key difference with SBAT is that if a downstream vendor identifies
needs for an SBAT version change, after a  patch is already merged in
upstream, this would typically trigger a 2nd followup patch to be sent
upstream from the vendor.

In terms of who will be sending SBAT changes. It could be the person
who first writes & submits the patch that addresses a EFI boot process
vulnerability. If not, it would likely be one of the various downstream
vendors, with their security/kernel team sending a change after the fact.


In terms of what branches would be impacted. The minimum bar would be
to only make SBAT changes in master. If that is all that is ever done
upstream, the mechanism would work as intended. There will inevitably
be backports to stable trees though, and people involved in this will
need to understand the rules for resolving conflicts when backporting
fixes that change SBAT as mentioned earlier.

I think the assumption would have to be that any stable branch is a
possible candidate for receiving backports that imply SBAT changes,
just like any stable branch might receive a backport for a regular
CVE fix. Whomever is interested in submitting changes to a particular
branch decides which particular patches get backported. The precense
of SBAT does constrain ordering of backports though, in the (hopefull)
unlikely case where multiple SBAT changes arrive close together

> None of this has been answered, and that's the real issue here.  This
> "magic number" is saying it is going to reflect some specific "security
> issue" yet no one is saying how those issues are going to be determined,
> or anything else about it.

Luca gave a (non-exhaustive) list of examples of areas of the code
which are most relevant earlier in the thread

[quote]
Kernel module signature enforcement, Lockdown LSM, ensuring
ExitBootServices is called at the right time, etc.
[/quote]

IIUC, your request here could potentially be satisfied if there was
first a patch that added a file 'Documentation/security/sbat.rst'
explaining in much more detail which set of kernel features are
relevant when considering SBAT, and how to evaluate bugs to decide
whether a SBAT change is justified or not.

That docs file also needs to explain the implications and criteria
for backporting patches to stable branches, and how to deal with SBAT
if upstream didn't make a change to it and it needs changing after
the fact.

> Again, as I've repeated numerous times, tell us how often this number
> would have changed in the past X years to give us an idea of how you
> will be changing it going forward.  To not provide any of this means
> this patch adding this magic number means nothing as no one knows what
> it actually means.

The SBAT concept was introduced after discussions with Microsoft
after the Grub BootHole[1] vulnerability was identified in 2021.

I'm not aware of any kernel CVEs since that point in time that
would have implied SBAT changes, but admittedly I've not paid
close enough attention to be entirely confident. Is going back
through 2 years of kernel CVEs (to the point where SBAT was
invented) a long enough timeframe to satisfy this request for
info on the frequency of changes ?

With regards,
Daniel

[1] https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
    https://eclypsium.com/research/theres-a-hole-in-the-boot/
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

