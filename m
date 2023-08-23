Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCAF7856B0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjHWLWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjHWLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:22:41 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16408E54;
        Wed, 23 Aug 2023 04:22:38 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 37NBL82T009557;
        Wed, 23 Aug 2023 06:21:08 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 37NBL7nF009556;
        Wed, 23 Aug 2023 06:21:07 -0500
Date:   Wed, 23 Aug 2023 06:21:07 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-coco@lists.linux.dev, Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/5] tsm: Attestation Report ABI
Message-ID: <20230823112107.GA9494@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com> <57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 23 Aug 2023 06:21:08 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:04:52AM +0200, Jeremi Piotrowski wrote:

Good morning, I hope the week is going well for everyone.

> On 8/14/2023 9:43 AM, Dan Williams wrote:
> > Changes since v1:
> > - Switch from Keyring to sysfs (James)
> > 
> > An attestation report is signed evidence of how a Trusted Virtual
> > Machine (TVM) was launched and its current state. A verifying party uses
> > the report to make judgements of the confidentiality and integrity of
> > that execution environment. Upon successful attestation the verifying
> > party may, for example, proceed to deploy secrets to the TVM to carry
> > out a workload. Multiple confidential computing platforms share this
> > similar flow.
> > 
> > The approach of adding adding new char devs and new ioctls, for what
> > amounts to the same logical functionality with minor formatting
> > differences across vendors [1], is untenable. Common concepts and the
> > community benefit from common infrastructure.
> > 
> > Use sysfs for this facility for maintainability compared to ioctl(). The
> > expectation is that this interface is a boot time, configure once, get
> > report, and done flow. I.e. not something that receives ongoing
> > transactions at runtime. However, runtime retrieval is not precluded and
> > a mechanism to detect potential configuration conflicts from
> > multiple-threads using this interface is included.
> > 

> I wanted to speak up to say that this does not align with the needs
> we have in the Confidential Containers project. We want to be able
> to perform attestation not just once during boot but during the
> lifecycle of the confidential VM. We may need to fetch a fresh
> attestation report from a trusted agent but also from arbitrary
> applications running in containers.
>
> The trusted agent might need attestation when launching a new
> container from an encrypted container image or when a new secret is
> being added to the VM - both of these events may happen at any time
> (also when containerized applications are already executing).
>
> Container applications have their own uses for attestation, such as
> when they need to fetch keys required to decrypt payloads. We also
> have things like performing attestation when establishing a TLS or
> ssh connection to provide an attested e2e encrypted communication
> channel.
>
> I don't think sysfs is suitable for such concurrent
> transactions. Also if you think about exposing the sysfs interface
> to an application in a container, this requires bind mounting rw
> part of the sysfs tree into the mount namespace - not ideal.

We don't have a dog in this fight regarding TDX [1], but we do have a
significant body of experience with the concepts and challenges
involved.

The issue at hand is that trust is a resource that needs to be
orchestrated, just like any other resource.  A concept, based on our
experiences, that seems to be significantly outside of mainstream
thought.

The notion of the need to orchestrate trust seems to be particularly
important with a concept such as Confidential Containers.

FWIW, we have pushed forward a second round of patches for the kernel
infrastructure that make the concepts of trust orchestration and
containerization tenable:

https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t

In addition, FWIW, we have actually built systems that implement these
principals, obviously not on TDX hardware, see [1], but we do have a
significant body of experience with using SGX as a trust root.  We
have even provided a substantial set of initial userspace tooling that
implement these concepts to support the proposed patches.

I only say all of this to convey the notion that we have actually done
work on all of these concepts and are not just waving our hands
around.

The notion of surfacing this information through /sysfs becomes less
problematic if one approaches the issue through the lens of having
trust orchestrators that are responsible for managing the security or
trust status of the execution platform at large and any subordinate
workloads.

This concept is true, even if the platform/VM is only hosting a single
workload.  Which may be a necessity for some security contracts, where
there is literally no trust in the fact that side-channel disclosure
threats can be properly mitigated, ie. there cannot be workloads with
possible adversarial intents.

From the outside looking in, unless there are some fundamental
conversations regarding how trusted systems and workloads can be
developed with the architectures being proposed, it is completely
unclear how durable API's, on the order of 20+ years are ever going to
be attained.

No criticism, just observation.

> Jeremi

Best wishes for continued progress on all of this, it is important
stuff, both in the cloud and on the edge.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity

[1]: TDX enabled hardware is difficult, if not impossible to obtain.
If there is any doubt, simply search for TDX hardware availability and
cringe at the conversations on the Intel forums about people trying to
get experience with the technology.

This is the same problem that plagued TXT and SGX and results in
enabling infrastructure development being done in an echo chamber.  A
concept that may have proven successful when all of this work was
expected to be implementated and enabled by OEM providers but seems
problematic in an ostensibly 'community' driven project such as Linux.
