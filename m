Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B583E779882
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbjHKUYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjHKUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:24:15 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC2021AE;
        Fri, 11 Aug 2023 13:23:59 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 37BKMtQZ009553;
        Fri, 11 Aug 2023 15:22:55 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 37BKMsKd009552;
        Fri, 11 Aug 2023 15:22:54 -0500
Date:   Fri, 11 Aug 2023 15:22:54 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Serge Hallyn <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 02/13] Add TSEM specific documentation.
Message-ID: <20230811202254.GA9401@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com> <20230710102319.19716-3-greg@enjellic.com> <ZNKN+ZK6Lfbjb4GZ@jerom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNKN+ZK6Lfbjb4GZ@jerom>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 11 Aug 2023 15:22:55 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 01:48:25PM -0500, Serge Hallyn wrote:

Good afternoon Serge, thank you for the comments.

> On Mon, Jul 10, 2023 at 05:23:08AM -0500, Dr. Greg wrote:
> > An entry was added to the ABI testing documentation to document

> "Add an entry..." is the usual way to document this in commit msg.

Will modify the commit message when there is a need for it to
reappear.

> > the files in the TSEM management filesystem.
> > 
> > The file documenting the kernel command-line parameters was
> > updated to document the TSEM specific command-line parameters

> A commit's actions are more normally in present tens ("The file
> documenting the kernel command-line parameters is")

Will also correct the diction used here.

> > The primary TSEM documentation file was added to the LSM
> > administration guide and the file was linked to the index of LSM
> > documentation.
> > 
> > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > ---
> >  Documentation/ABI/testing/tsem                |  828 +++++++++
> >  Documentation/admin-guide/LSM/index.rst       |    1 +
> >  Documentation/admin-guide/LSM/tsem.rst        | 1526 +++++++++++++++++
> >  .../admin-guide/kernel-parameters.txt         |   18 +
> >  4 files changed, 2373 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/tsem
> >  create mode 100644 Documentation/admin-guide/LSM/tsem.rst
> > 
> > diff --git a/Documentation/ABI/testing/tsem b/Documentation/ABI/testing/tsem
> > new file mode 100644
> > index 000000000000..cfb013b5f1f4
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/tsem
> > @@ -0,0 +1,828 @@
> > +What:		/sys/kernel/security/tsem
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The /sys/kernel/security/tsem directory contains files
> > +		and directories that implement the control plane for
> > +		the Trusted Security Event Modeling (TSEM) LSM.
> > +
> > +		The files in this directory hierarchy, with the
> > +		exception of the aggregate file, when read, reflect
> > +		the values for the security modeling namespace that
> > +		the process reading the files is operating in.
> > +
> > +What:		/sys/kernel/security/tsem/id
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The id file contains the ASCII base 10 representation

> Why not use base 16 here?  Mixing bases amongst the files could get
> confusing.

No reason not to, the primary entities reading the file are external
trust orchestrators.

We will prefix it with 0x to make it easy for strtol running in '0'
mode.

> > +		of the model domain/namespace identifier that the
> > +		reading process is operating in.
> > +
> > +		The root security modeling namespace has a value of
> > +		zero, a non-zero value indicates a modeling namespace
> > +		subordinate to the root model.
> > +
> > +		Each externally modeled domain will have a file, with
> > +		this id number, created in the
> > +		/sys/kernel/security/tsem/ExternalTMA directory that
> > +		is documented below.
> > +
> > +What:		/sys/kernel/security/tsem/aggregate
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The aggregate file contains the ASCII base 16
> > +		representation of the 256 bit hardware platform
> > +		aggregate that TSEM is modeling under.  The platform
> > +		aggregate is the linear extension measurement of the
> > +		Trusted Platform Module PCR registers 0 through 8.
> > +
> > +		On a platform without a TPM this value will be all
> > +		null bytes.
> > +
> > +What:		/sys/kernel/security/tsem/control
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The control file is the only writable file in the
> > +		filesystem and is used by the trust orchestrator's to
> > +		configure and control the behavior of the TSEM
> > +		implementation.
> > +
> > +		The following keyword and arguments are recognized:
> > +
> > +		internal
> > +			The internal keyword causes an internally
> > +			modeled domain to be created for the calling
> > +			process.
> > +
> > +		external
> > +			The external keyword causes an externally
> > +			modeled domain to be created for the calling
> > +			process.
> > +
> > +			A modeling namespace created by these commands
> > +			accept the following set of key=value pairs
> > +			that configure the namespace:
> > +
> > +			nsref=initial|current
> > +				The nsref key specifies the namespace
> > +				that is to be referenced when
> > +				determining the UID/GID values that
> > +				define a COE or CELL identity.
> > +
> > +				The initial keyword specifies that the
> > +				initial user namespace be used.  The
> > +				current keyword specifies that the
> > +				user namespace of the process that is
> > +				invoking a security event handler
> > +				(hook) is used.

> Hm, does this allow a process in a container to escape the
> container's policy, by creating a new domain inheriting from the
> initial userns?

First, to seek some clarification.

When you write 'container policy', are you referring to a TSEM
security model or a uid/gid userns mapping or other OCI container
security policy?

Casey had commented, in an unrelated thread, that 'domain' is
over-used, so we have standardized on 'security modeling namespace'.
I see above that we missed a case where we used domain in the
document, so we will fix that and assume that by 'creating a new
domain' you mean a new security modeling namespace.

FWIW, for TSEM, we have standardized on 'security model' rather than
policy for similar reasons.

Security modeling namespaces are, by design, only one level deep.  The
trust orchestrators drop CAP_WHATEVER after setting up a modeling
namespace, this locks the workload into whatever security model was
specified for the security modeling namespace with no opportunity for
the workload to change model context.

> > +TSEM implements its equivalent of mandatory access controls, without a
> > +requirement for extended attributes, filesystem labeling or the need
> > +to protect filesystem metadata against offline attack.  A mathematical

> If the security policy is that no data from /dev/tty, because it is
> untrusted, may flow into high integrity files, then how do you track
> the files which are high integrity, without labeling high integrity
> files?  You're intending for the agent to track the files using
> inode number and fsid?

The CELL identity generative function for a file access encodes the
pathname to the file.  Access to the file will need to be through a
security event that generates a security state coefficient that
derives from a CELL identity referencing the file.

Moving forward, we will be adding support to include security labels
from extended attributes in the CELL identity generation function, in
order to allow security policies that are not dependent on pathnames.

Further, the generative function for the security state coefficient
includes the concept of a 'task id' that serves to restrict
information flow only through a specific corpus of executable code
that is anchored by a cryptographic digest of said code.

> > +The root security model extends each security state coefficient into a
> > +PCR.  The default PCR is 11 but is configurable through the kernel

> Note pcr 11 will conflict with systemd's usage
> 
> https://uapi-group.org/specifications/specs/linux_tpm_pcr_registry/

Thank you for providing the reference, we will choose the next
available PCR according to that document.

> > +It is up to the trust orchestrator and its security policy to
> > +determine how it handles events that violate the security model being
> > +enforced.  The Quixote trust orchestrators shut down the entire
> > +workload running in the security namespace if an asynchronously
> > +modeled event violates the security model being enforced and the model
> > +is running in enforcing mode.

> So instead of returning EPERM, you'll let the process speculatively
> continue until quixote has a chance to catch up and return a "no not
> allowed" message, after which the whole workload will be killed?

For an externally modeled namespace, that is currently the only option
available.

The trust orchestrator also has the ability to set the task trust
status to untrusted, if the process still exists, which would block
any subsequent attempts to invoke security sensitive operations.

We've received a fair amount of feedback, that even if the workload
doesn't get killed, people feel that it is useful to quickly find out,
with a high degree of precision, that a workload is in the process of
getting p0wned.

The latency to action time isn't a function of quixote 'catching up',
but rather a function of how long the TMA takes to run the security
coefficient generative function and determine the provenance of the
event in the context of the operative security model.  That varies
with the TMA implementation, with the stock userspace implementation
taking in the range of 400-700 micro-seconds.

The only way to fix this is to implement a completion callback LSM
hook that can be invoked after the initial LSM hook was called from
atomic context and asynchronously submits the security event
characteristics to the TMA.  We have patches for internal use to do
this, but hopefully from an understandable perspective, no appetite
for submitting something like that.

This limitation isn't inconsistent with how security is getting done
in the wild with agent based systems.  An example from what we have
the most experience and visibility into.

CrowdStrike's NGAV product advertises the use of 'Cloud based
artificial intelligence, behavioral detection and machine learning
algorithms for threat detection and exploit mitigation'.

I think it can be stated, with a reasonably high degree of confidence,
that all of that doesn't typically occur within ~500 micro-seconds
after an event occurs that is inconsistent with the desired security
state of a workload/platform.

Finally, if any delay in response is unacceptable, TSEM offers the
ability to run the TMA implementation in the kernel where it would not
suffer from this limitation.

> > +From a hardware perspective, this is important with respect to the
> > +notion of a TMA being a model for a successor to the TPM.  From a
> > +system trust or integrity perspective, a TPM is designed to provide a
> > +retrospective assessment of the actions that have occurred on a
> > +platform.  A verifying party uses the TPM event log and a PCR based
> > +summary measurement, to verify what actions have occurred on the host,
> > +in order to allow a determination of whether or not the platform
> > +should be 'trusted'.

> FWIW TPM EA policies also refuse access to secrets based on those
> and other data.  It's not purely for retrospective assessment.  But
> indeed TPM does not authorize actions as trusted.  Not because it
> fails to do so but because it's not part of its design.

No argument there and no criticism of TPM's at large implied by any of
what we are proposing.

Technology has changed significantly in the 23+ years since TPM's were
introduced and we believe that the concept of a TMA, regardless of
where it is implemented, introduces the possibility of a more useful
superset of TPM type security capabilities.

> > +In contrast, a TSEM/TMA based system enforces, on a real time basis,
> > +that a platform or workload remains in a trusted state.  Security
> > +relevant actions cannot be conducted unless the TMA authorizes the
> > +actions as being trusted.
> > +
> > +This is particularly important with respect to embedded systems.  A
> > +TPM based architecture would not prevent a system from having its
> > +trust status altered.  Maintaining the system in a trusted state would
> > +require attestation polling of the system, and presumably, executing
> > +actions if the platform has engaged in untrusted behavior.
> > +
> > +Conversely, a trust orchestrated software implementation enforces that
> > +a system or workload remain in a security/trust state that it's
> > +security model was unit tested to.

> To be convinced that there is *any* use case for this in the real
> world, you'd need to show me how any useful rule, like your above
> /etc/shadow set, could actually indicate a less trustworthy state in
> a robust way, without turning into an easy accidental-self-DOS.

TSEM in its essence embraces 'default deny, exception allow'; the same
concept that every firewall on the planet implements.  With the
exception of all the vendors that are now rapidly claiming to do 'AI'
on deep packet inspection.

A TSEM security model is the set of coefficients that represent, at a
very granular level, the allowed security states of a workload.  In an
enforcing model, only these actions are allowed.

Our trust predicate is that if the workload has not allowed a security
behavior inconsistent with its desired security model, it can be
considered trusted.

Tasks that depart from the model are considered untrusted and get
EPERM'ed.  It is unclear where the 'accidental-self-denial-of-service'
issue would arise, since the only events that would get denied are
those that should not be occurring.

We would certainly entertain an elaboration on this issue so we could
better understand any possible deficiencies in what we are proposing.

> I'm afraid the answer is going to be "AI"...

No, not if we understand correctly the issue you raise.

That being said, we do feel that TSEM opens the door to implementing
the most accurate 'AI' models possible, for environments where
deterministic or quasi-deterministic security modeling is infeasible.

We certainly do understand antipathy with respect to AI, but it seems
that it is going to be a fact of life in the security industry and
beyond for a significant period of time.

I even see that Cisco is doubling down from its 'Talos AI-driven
Threat Intelligence' with the June announcement of its 'AI-First
Security Cloud'.... :-)

We are trying to give Linux the best method, of any OS, to implement
security modeling, regardless of its type.

> > +Security model functional definitions
> > +-------------------------------------
> > +
> > +Previously, classic trusted system implementations supported the
> > +notion of the 'measurement' of the system.  The measurement is the
> > +value of a linear extension function of all the security relevant
> > +actions recorded by a trust measurement system such as IMA.
> > +
> > +In TPM based trust architectures, this measurement is maintained in a
> > +PCR.  A measurement value is submitted to the TPM that extends the
> > +current measurement using the following formula:
> > +
> > +MEASUREMENT = HASH(CURRENT || NEW)
> > +
> > +	Where:
> > +		MEASUREMENT = The new measurement value to be maintained
> > +			      in the register for the system.
> > +
> > +		||	    = Concatenation operator.
> > +
> > +		HASH	    = A cryptographic hash function supported
> > +			      by the TPM device.
> > +
> > +		CURRENT     = The current measurement value.
> > +
> > +		NEW	    = A new measurement value to be added to
> > +			      the current measurement.
> > +
> > +In TPM1 based systems, the HASH function was SHA1.  Due to well
> > +understood security concerns about the cryptographic vitality of this
> > +function, TPM2 based systems provide additional HASH functions with
> > +stronger integrity guarantees, most principally SHA related functions
> > +with longer digest values such as SHA256, SHA384 and SM3.

> This previous paragraph simply is not needed in this document.

Yes, not sure how that persisted through internal review, we will drop
it.

> > +The use of a cryptographic function produces a non-commutative sum
> > +that can be used to verify the integrity of a series of measurements.
> > +With respect to security modeling theory, this can be thought of as a
> > +'time-dependent' measurement of the system.  Stated more simply, the
> > +measurement value is sensitive to the order in which the measurements
> > +were made.
> > +
> > +In systems such as IMA, the measurement value reflects the sum of
> > +digest values of what are considered to be security critical entities,
> > +most principally, files that are accessed, based on various policies.
> > +
> > +In TSEM based TMA's, the measurement of a modeling namespace is the
> > +sum of the security state coefficients generated by the operative
> > +security model being enforced.  As previously noted, on systems with a
> > +TPM, the root modeling namespace measurement is maintained by default
> > +in PCR 11 or the PCR that was selected at kernel configuration time.
> > +
> > +The challenge associated with classic integrity measurements is the
> > +time dependent nature of using a non-commutative summing function.
> > +The almost universal embrace of SMP based hardware architectures, in
> > +addition to standard kernel task scheduling issues, makes the
> > +measurement values non-deterministic.  This requires a verifying party
> > +to evaluate an event log, verified by a measurement value, to
> > +determine whether or not the system is in a security appropriate
> > +state.
> > +
> > +TSEM addresses this issue by implementing a strategy designed to
> > +produce a single functional value that represents the security state

> You've spent a lot of space discussing the "time based" (I think
> "order dependent" might be better) nature of IMA and TPM
> measurements.  But after reading this section twice, I'm still not
> seeing what TMA does to work around it.

Time dependent vs. time independent models tends to be a lingua franca
in modeling theory.

We will see if we can work some prose in that relates this to
ordering.

> If a process normally reads files F1, F2, .. F10, then writes F11,
> but next time it reads F1, F3, F2, F4, .. F10, how will these two
> different vectors be used in TMA?

I believe this is discussed below and we will treat it further there.

> > +of a model.  This allows a TMA to attest to the trust/security status
> > +of a platform or workload by signing this singular value and
> > +presenting it to a verifying party.
> > +
> > +In TSEM nomenclature, this singular value is referred to as the
> > +'state' of the model.  The attestation model is to use trust
> > +orchestrators to generate the state value of a workload by unit
> > +testing.  This state value can be packaged with a utility or container
> > +to represent a summary trust characteristic that can be attested by a
> > +TMA, eliminating the need for a verifying partner to review and verify
> > +an event log.
> > +
> > +TMA's implement this architecture by maintaining a single instance
> > +vector of the set of security state coefficients that have been
> > +generated.  A state measurement is generated by sorting the vector in
> > +big-endian hash format and then generating a standard measurement
> > +digest over this new vector.

> Are you saying the TMA will keep every meaningful measurement for
> the duration of the workload, so that it can always sort them?

Correct, every unique security state coefficient.

The approach isn't unique and without precedent.  Roberto Sassu is
using a similar strategy in order generate a time/order independent
PCR value for unlocking TPM sealed keys by parsing RPM and .deb
distribution manifests.

Paul Moore, in his comments in February to the V1 series, even
seriously questioned why we would expose the classic linear extension
measurement from a TMA.

> > +Any security event that generates an associated state coefficient that
> > +is not in the model will resulted in a perturbed state function value.
> > +That perturbed value would be interpreted by a verifying party as an
> > +indication of an untrusted system.
> > +
> > +Since the TMA maintains the security event descriptions in time
> > +ordered form, the option to provide a classic event log and
> > +measurement are preserved and available.  Extensive experience in the
> > +development of TSEM modeled systems has demonstrated the superiority
> > +of state value interpretation over classic measurement schemes.

> I think you're saying that keeping the tens of thousands security
> relevant events instead of keeping a hash of those events gives you
> more information... which is true.  It also gives you more
> information.  In a presumably limited space and over a presumably
> limited link.  No performance impact?

Obviously everything we do with respect to security has an impact, as
always, it comes down to a cost/benefit analysis.

We would offer the following observations:

The use of a security modeling namespace reduces the number of
coefficients that need to be stored.  Any serious initiative involving
modeling, deterministic or ML, will demand the notion of the concept
of a 'namespace'.

Only unique coefficients are stored.  There is a surprising amount of
redundancy in security state coefficients that are generated by a
workload, to wit:

The boot of a basic Debian implementation to a shell prompt will
generate approximately 7,800 unique coefficients from a field of
57,800 events.

Executing a runc based workload, up to the point where you can do
something with a shell, yields 98 coefficients from a field of 478.

As will likely be the case with TPM's moving forward, it seems
unlikely that the future will consist of TMA's being discrete hardware
devices.  As we note in our documentation, the Quixote/TSEM userspace
tools demonstrate the viability of a number of different physical
modeling environments.

Quixote/TSEM may actually be the 'killer' application for SGX but it
seemed we were unable to communicate that effectively.

All of that being said.  If you download the source for the userspace
tools, it will build firmware for a TMA implementation that will run
on the Nordic NRF52840-DONGLE micro-controller (USB form factor and
comms, 32 bit ARM, 256K RAM), think Yubikey class and style device
that GOOGLE is using for its OpenSK initiative.

We use it to model a runc based workload consisting of a Java Log4J2
exploit demonstration.  Getting Java cranked up doesn't exactly blow
your hair back but the Tomcat application is surprisingly responsive
after that.

Finally, in order to support modeling of the root namespace anchored
by a TPM trust root we needed to implement asynchronous TPM updates.

Until we did that, boot performance on systems with discrete TPM's was
brutally slow, which underscores that classic TPM based trust models
are challenged when it comes to anchoring model based security
architectures.

> I'd really like to see what a conscise but useful policy looks like.

Given the above, what in your mind would be a 'useful' policy?

> -serge

Thanks for the comments.

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
