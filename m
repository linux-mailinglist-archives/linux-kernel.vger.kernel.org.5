Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9C78AD73
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjH1Ksb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjH1KsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:48:12 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 482F5A0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:48:08 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 37SAkaqD010074;
        Mon, 28 Aug 2023 05:46:36 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 37SAkZ3g010073;
        Mon, 28 Aug 2023 05:46:35 -0500
Date:   Mon, 28 Aug 2023 05:46:35 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Samuel Ortiz <sameo@rivosinc.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-coco@lists.linux.dev,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tsm: Introduce a shared ABI for attestation reports
Message-ID: <20230828104635.GA10014@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com> <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com> <ZOYOXTsveEhPCHq2@vermeer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOYOXTsveEhPCHq2@vermeer>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 28 Aug 2023 05:46:37 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 03:49:17PM +0200, Samuel Ortiz wrote:

Good morning, I hope the week is starting well for everyone.

Some further background to hopefully assist decision making on how to
handle the export of attestation information for COCO TSM's.

> Hi Dan,
> 
> On Mon, Aug 14, 2023 at 12:43:21AM -0700, Dan Williams wrote:
> > One of the common operations of a TSM (Trusted Security Module) is to
> > provide a way for a TVM (confidential computing guest execution
> > environment) to take a measurement of its launch state, sign it and
> > submit it to a verifying party. Upon successful attestation that
> > verifies the integrity of the TVM additional secrets may be deployed.
> > The concept is common across TSMs, but the implementations are
> > unfortunately vendor specific. While the industry grapples with a common
> > definition of this attestation format [1], Linux need not make this
> > problem worse by defining a new ABI per TSM that wants to perform a
> > similar operation. The current momentum has been to invent new ioctl-ABI
> > per TSM per function which at best is an abdication of the kernel's
> > responsibility to make common infrastructure concepts share common ABI.
> > 
> > The proposal, targeted to conceptually work with TDX, SEV, COVE if not
> > more, is to define a sysfs interface to retrieve the TSM-specific blob.
> > 
> >     echo $hex_encoded_userdata_plus_nonce > /sys/class/tsm/tsm0/inhex
> >     hexdump /sys/class/tsm/tsm0/outblob

> My concern with that interface is that one could easily get an
> attestation report with a nonce set by another userspace component
> or thread. I realize there is a generation counter to detect if a
> configuration changed between the caller's last config setting and
> the report it got, but I think that this shows that this may not be
> the best interface. IMHO an attestation report request from
> userspace should be an atomic call that includes multiple platform
> independent attibutes like e.g. an attestation nonce.

The challenge in all of this would seem to be the need to get a 20+
year ABI 'right' on the first try, so some issues to consider based on
our experiences building trusted systems, albeit with a focus on
endpoint devices.

The issue about needing to implement attestation atomically is on
point.  This requirement would seem to suggest that the optimum path
forward for confidential computing will be to have attestation support
implemented in the resource orchestration infrastructure inside the
TVM.

Since the goal is confidentiality, you need to trust everything that
executes inside the execution domain/VM.  This is particularly true
given the reality of micro-architectural side channel issues, which
don't seem to be going away and which Intel explicitly documents that
you must address with TDX.

Given that, there would seem to be no reason not to have the
attestation support all in one place and then provide access to that
functionality to anything in the TVM that would want to make
an integrity statement to a relying party.

A sysfs interface is perfectly suited to the this model, since the
trust orchestrator, if we use our terminology, can address the
concurrency and atomicity issues presented by a sysfs interface.

From an Intel/SGX centric perspective, which is our area of expertise
when it comes to the notion of a TSM, the attestation process is
reasonably complex, even more so in a TDX environment, since you need
to go outside the trusted execution domain in order to conduct the
full attestation process.  I don't know how many people have direct
experience with all of this, but we can offer it on good authority
that the COCO model will benefit from having all the necessary
procedures done correctly and in one place

> > This approach later allows for the standardization of the
> > attestation blob format without needing to change the Linux
> > ABI. Until then, the format of 'outblob' is determined by the
> > parent device for 'tsm0'.
> >
> > The expectation is that this is a boot time exchange that need not
> > be regenerated,

> This works well with the encrypted boot disk that's decrypted
> through attestation use-case, but this is just one use
> case. Although I don't expect attestation requests to be frequent,
> we should not assume this is only a boot time operation. Not only it
> can happen after the guest is fully booted, but it can also happen
> multiple times. An attestation flow where a guest gets an
> attestation token back from a validated report is something we'd
> want to support. Those token's validity are time limited, and
> userspace would want to regenerate a report, with a fresh,
> attestation service provided nonce.

There would certainly seem to be no argument that a trusted execution
domain may want to conduct multiple attestations, Jeremi suggested
this is something the Confidential Containers initiative would want as
well.

The model of having attestation support centralized in the resource
orchestration infrastructure is not only consistent with that need but
would also appear to be the optimal approach.

Let us consider TDX as an example, since it will undoubtedly be a
major player in COCO.

In the Data Center Attestation Primitives (DCAP) model, one needs to
choregraph a dance between the Provisioning Certification Enclave
(PCE) and the Quoting Enclave (QE) in order to conduct the attestation
process.  That requires access to SGX functionality, something that is
not supported by Intel in a TDX mediated virtual machine.

This imposes a need to go outside of the TD guest, to the host, in
order to get access to SGX in order to load and run the PCE and QE
enclaves.

The call into the kernel to access the hypervisor interface is simply
the starting point for the attestation process.  The purpose is to
have the TDX module generate a CPU specific report (SEAMREPORT) that
will ultimately authenticate material, usually ECDH key exchange
components, as coming from an execution domain with known provenance.

That report then needs to be processed through the PCE and QE enclave
infrastructure in order to fully prove the identity of the report and
thus authenticate its contents.  Mixed into all of this is a need to
verify the MROWNER and MRSIGNER signatures on the involved enclaves as
well as the Security Version Numbers (SVN's) on the enclaves and the
TDX infrastructure.  This process ends up authenticating a certificate
chain which proves that a secret to be conveyed into the TD is
actually being injected into a valid TD, with known provenance and one
that is 'Genuine Intel' in origin.

All of this doesn't seem to speak of infrastructure you would want to
replicate multiple times over.

> Another thing to keep in mind is that an attestation report could be
> amended by userspace itself, for TEE that support runtime
> measurement (The RTMR things...). So the TVM measurement itself
> could change during the lifecycle of a TVM.

Once again, speaking only to TDX, it isn't apparent that the RTMR
registers are going to be useful for the task of confirming general
application level integrity once the OS is started.  Their primary
utility will be to provide a root of trust for the resource
orchestration infrastructure and in turn VTPM's, or something like
TSEM's root security modeling namespace, if the goal is to provide a
foundation for generalized trust/integrity mechanisms inside of the
TVM.

To wit:

The formal usage recommendations for the TDX RTMR registers are as follows:

RTMR[0]: PCR[1,7]
RTMR[1]: PCR[4,5]
RTMR[2]: PCR[8,15]
RTMR[3]: Special use

Where RTMR[2] is specified for usage by the OS/application for
measurement purposes, so only the equivalent of one PCR is available.

This would automatically preclude the use of systemd in a 'trusted' VM
implementation, given that the latest Linux TPM PCR registry has
systemd consuming PCR registers 11-15 for its own use.  Once again, if
you are really serious about confidentiality, you need to have an
attestable integrity guarantee for everything that happens inside the
trusted VM.  IMA uses register 10 if you go that route and we will be
using a register above what systemd is using for the TSEM root
namespace.

So we believe the lone trusted virtual machine measurement register
will need to stay constant, in order to easily validate whatever root
of trust that is in turn designated to guarantee the integrity of what
goes on inside of the TVM from an OS/application perspective.

A functional attestation scheme is thus going to require not only
attestation of the state of the TVM but also what has gone on inside
of the VM after it has booted.  Another reason for having a single
shopping site for the attestation needs of whatever runs inside of the
trusted VM.

FWIW, since we copied the LSM list on this, we haven't come by the
design and implementation of TSEM and the notion of trust
orchestration idly.  If COCO is going to become a relevant reality
there needs to be consideration given to the concept of trust
orchestraton and management.

Once gain, FWIW, and something that Jeremi from Microsoft might be
able to comment on.  It is unclear how COCO based Confidential
Containers fits into the standard IMA attestation model, where one has
to review an event log documented by a linear extension trust
measurement to determine whether or not the system is to be trusted.

At a minimum, this would require that a relying party for attestation
of one container be able to verify what has gone on in all other
container invocations.  Unless the containers are being run for only a
single entity, this would seem to imply a violation of the notion of
privacy and confidentiality.

> Cheers,
> Samuel.

Hopefully all of the above is of assistance in getting the ABI right
and the scope of issues involved.

Best wishes for a productive week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
