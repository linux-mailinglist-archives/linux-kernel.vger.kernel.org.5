Return-Path: <linux-kernel+bounces-19451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D50A826D14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A94283577
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8757E20B15;
	Mon,  8 Jan 2024 11:43:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E67C29416;
	Mon,  8 Jan 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 408BhPZQ004104;
	Mon, 8 Jan 2024 05:43:26 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 408BhPrc004103;
	Mon, 8 Jan 2024 05:43:25 -0600
Date: Mon, 8 Jan 2024 05:43:25 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH 2/13] Add TSEM specific documentation.
Message-ID: <20240108114324.GA4085@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230710102319.19716-3-greg@enjellic.com> <ffdd5e4d10865da5f767df53b12bb6db@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffdd5e4d10865da5f767df53b12bb6db@paul-moore.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 08 Jan 2024 05:43:26 -0600 (CST)

On Wed, Jan 03, 2024 at 11:00:33PM -0500, Paul Moore wrote:
> On Jul 10, 2023 "Dr. Greg" <greg@enjellic.com> wrote:
> > 
> > An entry was added to the ABI testing documentation to document
> > the files in the TSEM management filesystem.
> > 
> > The file documenting the kernel command-line parameters was
> > updated to document the TSEM specific command-line parameters
> > 
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

> Let me start by apologizing for the delay in responding, your patience
> was appreciated.  Comments below ...

In my previous reply I responded to what you considered to be your two
major concerns.

For clarification purposes I will follow up on the other issues you
raised so we can potentially make adjustments in V3.

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

> Just making sure you want to use uppercase here.  It's your call,
> but it tends to go against convention, and changing it after the
> code is in a tagged release it painful enough that it should be
> considered practically impossible.  This applies not just to this
> file, but all of the other mixed/upper case TSEM files under /sys.

There are only two files with mixed case, we will convert them to the
following:

/sys/kernel/security/tsem/external_tma
/sys/kernel/security/tsem/internal_tma

Let us know if you disagree.

> > +What:		/sys/kernel/security/tsem/aggregate
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The aggregate file contains the ASCII base 16
> > +		representation of the 256 bit hardware platform
> > +		aggregate that TSEM is modeling under.  The platform
> > +		aggregate is the linear extension measurement of the
> > +		Trusted Platform Module PCR registers 0 through 8.

> I believe we talked about hash agility previously, but just in case,
> you may want to reword the above to provide some flexibility around
> the hash algorithm used.  On the other hand, if you want to stick
> with a single hash algorithm and 256-bit digest length, you might as
> well specify the hash algorithm here.

TSEM should now have the maximum amount of hash agility available on
Linux.

From the V2 cover letter enhancements:

- Allow cryptographic hash function used for coefficient generation to
  be configured on a namespace by namespace basis.

Which may understate the issue a bit.

TSEM can now use any hash function availble in Linux as the
compression function for a security modeling namespace.  Different
namespaces can operate with different hash functions simultaneously.

In V3 we will re-word all of the references to SHA256 to indicate that
the output value will be the ASCII expression of the digest function
specified for the modeling namespace.

> I don't want to assume too much about the TSEM design, but I'm
> guessing the aggregate is intended to be a deterministic value based
> on the PCRs and therefore it seems like there is value in providing
> a clear explanation of how it is calculated.

The aggregate is the linear extension sum over PCR registers 0 through
8 using the namespace hash function, we will cook up a generic
description, although it should be a common enough concept for anyone
working on trusted system implementations.

> > +		On a platform without a TPM this value will be all
> > +		null bytes.

> Just to clarify, are you intending this to be NULL bytes (as
> written) or an ASCII base 16 zero value, padded out to the digest
> length, similar as to what you might see in the output of the
> `tpm2_pcrread` command for a zero-value PCR?  Once again, it's your
> call, I just wanted to clarify.

It will be what would constitute the expression of least surprise, a
sequence of ASCII 0's padded to the digest size, the same as a pcrread
of a zero-value PCR.

> > +What:		/sys/kernel/security/tsem/control
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The control file is the only writable file in the
> > +		filesystem and is used by the trust orchestrator's to
> > +		configure and control the behavior of the TSEM
> > +		implementation.

> I would drop the "only writable file ..." portion above; it may be the
> only writable file under /sys/kernel/security/tsem at the moment, but
> I imagine there is a good chance that will change over time and the
> comment doesn't really add anything important.

Will change.

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

> I assume whitespace is used as a delimiter?  That would be good to
> document, both between the key-value-pairs as well as the initial
> op/keyword.

Yes, arguments are white space delimited, we use argv_split for the
parsing of all the control plane directives.

> Also, do these key-value-pairs apply to both internal and external
> domains?  The text seems to indicate that they do, but the way the
> document is structured hints that they only apply to the external
> domain.  Perhaps a sentence in the internal domain description
> indicating that all of the external domain configuration parameters
> apply to internal domains as well, unless explicitly stated
> otherwise.

We will take a look at making this more clear.

> > +			nsref=initial|current
> > +				The nsref key specifies the namespace
> > +				that is to be referenced when
> > +				determining the UID/GID values that
> > +				define a COE or CELL identity.

> Are COE or CELL acronyms?  If so, it would be nice to expand them on
> first use in the document.

COE is an acronym for Context Of Execution, in TSEM the security
characteristics of what would be the equivalent of the subject in a
MAC.

CELL doesn't stand for anything other than CELL, it is a term to
reflect the collection of characteristics that describe a security
event being modeled, roughly the equivalent of an object in MAC.

We use CELL in respect to Turing computability theory in that TSEM is
based on the predicate that a unique identity can be generated for
each security event that an execution 'head' passes over.

The first contribution of wonkiness for today's e-mail... :-)

> > +				The initial keyword specifies that the
> > +				initial user namespace be used.  The
> > +				current keyword specifies that the
> > +				user namespace of the process that is
> > +				invoking a security event handler
> > +				(hook) is used.
> > +
> > +			digest=digestname
> > +				The digest key is used to specify the
> > +				cryptographic hash function that is to
> > +				be used in the namespace for the
> > +				creation of COE and CELL identities.
> > +
> > +				The digestname is the name used by the
> > +				Linux kernel cryptographic API to
> > +				identify the hash function.  Examples
> > +				would include sha256, sha3-256, sm3
> > +				etc.  The source files for the
> > +				cryptographic hash function in the crypto
> > +				directory of the kernel source has the
> > +				names for hash functions implemented
> > +				in the kernel.
> > +
> > +				The sha256 hash function is the
> > +				default function for the root modeling
> > +				domain.  This can be modified by the
> > +				tsem_digest command-line parameter.
> > +
> > +				A hash function, used by the root
> > +				modeling domain, must be built into
> > +				the kernel.
> > +
> > +			cache=NN
> > +				The cache key specifies the size of
> > +				the caches to be used for holding
> > +				pointers to structures used for the
> > +				modeling or export of security events
> > +				that are called while the invoking
> > +				process is in atomic context.
> > +
> > +				The value NN is the ASCII base 10
> > +				representation of the number of
> > +				entries in the cache.
> > +
> > +				By default, the root modeling
> > +				namespace and an externally modeled
> > +				namespace will have 96 entries.  An
> > +				internally modeled namespace will have
> > +				16 entries.
> > +
> > +			key=HEXID
> > +				The key argument is used to specify
> > +				the authentication key that will be
> > +				used by a trust orchestrator to
> > +				authenticate trust control requests to
> > +				a process running in the security
> > +				modeling namespace.
> > +
> > +				The HEXID value is the ASCII base16
> > +				encoded key that is to be used.  The
> > +				length of this key, in binary, must be
> > +				equal to the size of the digest
> > +				produced by the cryptographic hash
> > +				function that is being used in the
> > +				modeling namespace.
> > +
> > +		enforce
> > +			The enforce keyword causes the modeling
> > +			domain/namespace of the process to enter
> > +			enforcing mode.  In this mode, a value of
> > +			-EPERM will be returned for a security event
> > +			coefficient that does not map into the current
> > +			set of allowed coefficients for the security
> > +			model being implemented in the namespace.
> > +
> > +		seal
> > +			The seal keyword causes the security model
> > +			being implemented for the namespace to be
> > +			placed in a sealed state.  In this state, the
> > +			current set of security coefficients is
> > +			considered to be the only set of valid
> > +			coefficients for the model.  Any subsequent
> > +			events that map to a coefficient not in the
> > +			current model will be considered a violation
> > +			of the model.
> > +
> > +		trusted pid=PID key=HEXID
> > +			The trusted keyword is used by a trust
> > +			orchestrator to indicate that the process
> > +			identified by the PID argument should be
> > +			allowed to run in trusted status after the
> > +			modeling of a security event.

> I mentioned this quite a few times in my review of the previous
> patchset, PIDs are not a safe way to identify a process in the
> system.  PID reuse/recycling is a real danger and you need to
> account for this risk.

We will defer that discussion to our previous e-mail where we
discussed how this is addressed.

> > +			The HEXID argument is the authentication key
> > +			that has been configured by a trust
> > +			orchestrator for the namespace at the time of
> > +			its creation.
> > +
> > +		untrusted pid=PID key=HEXID
> > +			The untrusted keyword is used by a trust
> > +			orchestrator to indicate that the process
> > +			identified by the PID argument should be
> > +			designated as an untrusted process.
>
> See above, you can't use a PID to safely identify a process.
> 
> > +			The HEXID argument is the authentication key
> > +			that has been configured by a trust
> > +			orchestrator for the namespace at the time
> > +			its creation.
> > +
> > +		state value=HEXID
> > +			The state keyword is used to indicate that the
> > +			security state coefficient identified by the
> > +			ASCII base 16 encoded value specified by HEXID
> > +			should be loaded into the current security
> > +			model as a valid security event coefficient.
> > +
> > +		pseudonym valid=HEXID
> > +			The pseudonym keyword is used to indicate that
> > +			the pathname, identified by the ASCII base 16
> > +			encoded value HEXID, should be designated to
> > +			return a constant digest value for the
> > +			contents of the file named by the pseudonym.
> > +
> > +			The HEXID value is computed with the following
> > +			function:
> > +
> > +			HEXID = HF(PATHNAME_LENGTH || PATHNAME)
> > +
> > +			WHERE HF is the cryptographic hash function
> > +			that has been designated for use by the
> > +			security modeling namespace.

> How do you handle hash collisions?  Given that users will likely be
> able to create files with arbitrary names, it seems like identifying
> files by a hash of their pathname without any way to safely resolve
> digest collisions is a problem in waiting.

Also addressed in our first e-mail, we will stand by for your comments
there.

> > +		base value=HEXID
> > +			The base keyword is used to indicate that the
> > +			ASCII base 16 encoded value HEXID should be
> > +			registered as the value used to generate
> > +			security state coefficients for the model
> > +			implemented in the modeling namespace.
> > +
> > +			The binary length of the value specified by
> > +			HEXID must match the digest size of the
> > +			cryptographic hash function specified for use
> > +			in the security modeling namespace.
> > +
> > +			A model specific base value is designed to be
> > +			used as a 'freshness' nonce, similar to an
> > +			attestation nonce, to prove that a model state
> > +			value or measurement is current and not being
> > +			replayed.
> > +
> > +What:		/sys/kernel/security/tsem/InternalTMA
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +
> > +		This directory will contain directories that will be
> > +		used to hold files that surface model parameters for
> > +		Trusted Modeling Agents (TMA's) for internally modeled
> > +		security namespaces.
> > +
> > +		There is currently only one internal TMA that is
> > +		surfaced through the following directory:
> > +
> > +		/sys/kernel/security/tsem/InternalTMA/model0
> > +
> > +		The subsequent descriptions for the files implemented
> > +		in this directory will use ROOTDIR to represent the
> > +		above directory for space conservation purposes.
> > +
> > +What:		ROOTDIR/measurement
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The measurement file contains the ASCII base 16
> > +		representation of the time dependent linear extension
> > +		value of all the security state coefficients in the
> > +		model implemented by the namespace of the calling
> > +		process.

> If I remember correctly, one of the motivations for TSEM was to
> avoid the time/ordering aspect of traditional attestation approaches
> as it can be fragile.  Assuming that my memory is correct, and this
> still holds true in the revision of the patchset, why are you
> continuing to export time/order dependent measurements to userspace?
>
> Either the ordering is important, in which case TSEM's novelty isn't
> useful, or the ordering isn't important and we can remove this sysfs
> file.

We addressed that in the second e-mail we sent last Friday.

As we indicated in that e-mail, TSEM is about implementing
infrastructure for building arbitrary mandatory security models.  We
don't advocate for either a time dependent or time independent model,
we leave that up to whoever is implementing a security model to be
executed in a modeling namespace by TSEM.

Hopefully we have established that there is some small modicum of
novelty in TSEM beyond the notion of a time independent measurement of
the state state of a workload...

> > +What:		ROOTDIR/state
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The state file contains the ASCII base 16
> > +		representation of the functional value of a security
> > +		modeling namespace.
> > +
> > +		The state value is a time independent representation
> > +		of the measurement of a security model, and unlike the
> > +		measurement value, is a time independent
> > +		representation of the state.
> > +
> > +		This value is designed to be a single value that can
> > +		be attested to represent whether or not a workload has
> > +		deviated from a defined security behavior.

> Continuing the comment above regarding ROOTDIR/measurement, this
> file makes much more sense in the context of TSEM.

Once again, we offer both since TSEM is a general purpose security
modeling framework.

> > +What:		ROOTDIR/trajectory
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The trajectory file contains a description of the
> > +		security events that have occurred in a security
> > +		modeling namespace
> > +
> > +		Each entry in this file represents a single security
> > +		event and consists of a JSON encoded record with key
> > +		values that define the characteristics of the event.
> > +
> > +		Each line in a trajectory, or forensics, file will
> > +		always have the event and COE keys.  The event key
> > +		describes the characteristics of a security event
> > +		while the COE field describes the Context Of Execution
> > +		that is requesting execution of a security event.
> > +
> > +		The event key consists of the following
> > +		characteristic definitions:
> > +
> > +			process: COMM
> > +				Where COMM is the ASCII representation
> > +				of the name of the process executing
> > +				the event.

> What happens if a process, either innocently or maliciously, changes
> its name (see prctl(PR_SET_NAME))?  Would it result in a mismatch of
> the security state of a process?

The process name isn't incorporated into the security state
coefficient, it is included as an aid for developers or security
architects who are analysing security event description streams.

At the risk of injecting a bit more wonkiness, TSEM approaches
security from the perspective of Hegelian epistemology, roughly
translated, TSEM security decisions are exclusively experiential,
ie. derived from unit testing of a workload.

If the process name was included in the composition of a security
state coefficient, any subsequent execution of the workload would have
to use that name, otherwise it would generate a security model
violation.

Additionally, TSEM implements a handler for the task_prctl event.  If
a process in a workload would attempt to use prctl to change its
process name, and that was not a modeled event, a security event
coefficient would be generated which would be inconsistent with the
security model being enforced.

> > +			type: EVENT_TYPE
> > +				The value field for a type key is the
> > +				name of the security event that is
> > +				being modeled.  The list of EVENT_TYPE
> > +				names is defined in the following
> > +				source file:
> > +
> > +				security/tsem/tsem.c
> > +
> > +				If the security event is a generically
> > +				modeled event the EVENT_TYPE will be
> > +				generic_event.  In this case the CELL
> > +				characteristics for the event will be
> > +				described by a generic_event: key

> I'm guessing EVENT_TYPE is an ASCII string representation?  It would
> be good to clarify as you have in most (all?) of the other fields
> and the omission here raises a red flag.

We will clarify, but for future reference all of the control plane
output files emit ASCII exclusively.

> > +			task_id: HEXID
> > +				The value of the task_id key will the
> > +				ASCII base 16 representation of the
> > +				identity of the task that is executing
> > +				the security handler.  The length of
> > +				HEXID will match the size of the
> > +				digest value of the cryptographic hash
> > +				function selected for use by the
> > +				security modeling namespace.
> > +
> > +				The following documentation file:
> > +
> > +				Documentation/admin-guide/LSM/TSEM.rst

> It looks like the file is lowercase ".../tsem.rst".

Good catch, we missed that in the release review.

> > +				Describes how the TASK_ID value is
> > +				generated.

> I would suggest either moving or copying the TASK_ID definition here
> so that it is included in the TSEM ABI document.

As we mentioned in the first e-mail, we were considering putting a
disclaimer at the top of the ABI document that the tsem.rst file
should be consumed first as a primer for understanding the ABI.

> > +		The COE key has the following characteristic keys.
> > +		Keys that involve discretionary access values
> > +		(uids/gids) will have their numeric value computed
> > +		based on the user namespace reference value that is
> > +		being implemented in the security modeling namespace.
> > +
> > +			uid: NN
> > +				The ASCII base 10 representation of
> > +				the numeric value of the discretionary
> > +				user id of the process that is
> > +				executing the security event.
> > +
> > +			euid: NN
> > +				The ASCII base 10 representation of
> > +				the numeric value of the effective
> > +				discretionary user id of the process
> > +				that is executing the security event.
> > +
> > +			euid: NN
> > +				The ASCII base 10 representation of
> > +				the numeric value of the effective
> > +				discretionary user id of the process
> > +				that is executing the security event.
> > +
> > +			suid: NN
> > +				The ASCII base 10 representation of
> > +				the numeric value of the saved user id
> > +				of the process that is executing the
> > +				security event.
> > +
> > +			gid: NN
> > +				The ASCII base 10 representation of
> > +				the numeric value of the discretionary
> > +				group id of the process that is
> > +				executing the security event.
> > +
> > +			egid: NN
> > +				The ASCII base 10 representation of
> > +				the numeric value of the discretionary
> > +				effective group id of the process that
> > +				is executing the security event.
> > +
> > +			egid: NN
> > +				The ASCII base 10 representation of
> > +				the numeric value of the discretionary
> > +				effective group id of the process that
> > +				is executing the security event.
> > +
> > +			sgid: NN
> > +				The base 10 ASCII representation of
> > +				the numeric value of the saved
> > +				discretionary group id of the process
> > +				that is executing the security event.
> > +
> > +			fsuid: NN
> > +				The base 10 ASCII representation of
> > +				the numeric value of the discretionary
> > +				filesystem user id of the process that
> > +				is executing the security event.
> > +
> > +			fsgid: NN
> > +				The ASCII base 10 representation of
> > +				the numeric value of the discretionary
> > +				filesystem group id of the process
> > +				that is executing the security event.
> > +
> > +			capeff: 0xNNN
> > +				The ASCII base 16 representation of
> > +				the numeric value of effective
> > +				capabilities of the process that is
> > +				executing the security event.
> > +
> > +		If the CELL value for a security event includes the
> > +		definition of a file a file: key value will be
> > +		included.  The following characteristics will be
> > +		encoded in this field:
> > +
> > +			flags: NN
> > +				The ASCII base 10 representation of
> > +				the flags value of the 'struct file'
> > +				structure that is the source of the
> > +				file description.
> > +
> > +			uid: NN
> > +				The ASCII base 10 representation of
> > +				the discretionary user id of the file.
> > +
> > +			gid: NN
> > +				The base 10 ASCII representation of
> > +				the discretionary group id of the
> > +				file.
> > +
> > +			mode: 0NNN
> > +				The ASCII base 8 representation of the
> > +				mode bits of the file.

> Does the leading zero followed by three octets imply you don't
> record the setuid/setgid/sticky bits?

The full value of the mode variable is output, including the
setuid/setgid/sticky bits, the NNN is an arguably confusing
representation and we will figure out an alternative way to document
this.

> > +			name_length: NN
> > +				The ASCII base 10 representation of
> > +				the length of the pathname that will
> > +				be encoded in the name= characteristic.

> To clarify, this is the length of the pathname used during the file
> lookup and not the length of the hash digest of the previously
> mentioned pathname, yes?

As we mentioned previously, this no longer exists in V3.

> > +			name: NN
> > +				The ASCII hexadecimal representation
> > +				of the SHA256 checksum of the pathname
> > +				of the file that is pre-pended with
> > +				the little-endian binary value of the
> > +				length of the pathname.

> Hash agility?

Maximized in V3... :-)

> It isn't clear to me if the length is prepended before or after the
> hash, it would be good to clean this up.
> 
> Also, similar to some comments above, how are you handling hash
> collisions?  As pathnames can be influenced by unprivileged users, this
> would appear to be an issue.

Addressed in previous e-mail.

Succinctly, to our knowledge, there are no computationally feasible
2nd pre-image attacks against modern hash functions that would be used
for TSEM.

If you have information otherwise, we, and probably the rest of the
security industry, would be deeply interested if not concerned.

To extend a bit further.

The viability of a pathname or security coefficient stream collision
attack needs to be assessed with respect to the experiential nature of
the TSEM security models.

If an adversary was attempting to change pathnames in order to to
exploit a collision against an existing security state coefficient the
model under which the workload was running would need to reflect the
security states that would be needed for the pathname changes,
otherwise the workload would be in violation of its model.

Without digging too deep, at a minimum, a tsem_inode_create event
would be presumably triggered on the creation of a new candidate
filename to exploit the collision.

> > +			s_magic: 0xNN
> > +				The ASCII base 16 representation of the
> > +				magic number of the filesystem that
> > +				contains the file.
> > +
> > +			s_id: NAME
> > +				The ASCII name of the block device for
> > +				the filesystem that contains the file.
> > +
> > +			s_UUID: HEX
> > +				The ASCII base 16 representation of
> > +				the hexadecimal value of the UUID of
> > +				the filesystem that contains the file.
> > +
> > +			digest: HEX
> > +				The ASCII base 16 representation of
> > +				the SHA256 digest of the file.

> Hash agility?
> 
> Is TSEM running a hash over every file included in a file-related
> security event?

Yes, unless the model developer has tagged the file as having a
digest pseudonym.

> > +		If the event type is the memory mapping of a file a
> > +		mmap_file key value will be included with
> > +		the following characteristics:

> Still part of the CELL?  COE?  This doc could benefit from better
> explanations of the CELL and COE terms.

This would be the CELL, since it characterizes the security event.

> > +			type: N
> > +				Where N is an ASCII 0 or 1 to indicate
> > +				whether or not the mapping is file
> > +				backed or anonymous.  A value of 1 is
> > +				used to indicate an anonymous mapping.
> > +
> > +			reqprot: NN
> > +				Where N is ASCII base 10
> > +				representation of the protections
> > +				requested for the mapping.
> > +
> > +			prot: NN
> > +				Where N is the ASCII base 10
> > +				representation of the protections that
> > +				will be applied to the mapping.
> > +
> > +			flags: NN
> > +				Where N is the ASCII base 10
> > +				representation of the flags that will
> > +				be used for the memory mapping operation.

> You should specify the flags used in the fields above, or refer
> readers to the mmap(2) flag definitions if appropriate.

In V3 all of the security events are fully parameterized.  We will
include documentation that the CELL field for each event encodes the
arguments to the event.

In light of this we will be evaluating how to best express the ABI
documentation.

> > +		If the event type is a socket creation event a
> > +		socket_create key value will be included with the
> > +		following characteristics:
> > +
> > +			family: N
> > +				Where N is the ASCII base 10
> > +				representation of the family type of
> > +				the socket.
> > +
> > +			type: N
> > +				Where N is the ASCII base 10
> > +				representation of the type of socket
> > +				being created.
> > +
> > +			protocol: N
> > +				Where N is the ASCII base 10
> > +				representation of the protocol family
> > +				for the socket.

> Similar to the mmap flags above, I would refer people to where these
> values are defined.  The applies to the other socket family/type/proto
> fields described elsewhere in this document.

That will be part of the ABI review in V3.

> > +			kern: 0 | 1
> > +				Where 0 or 1 is used to indicate
> > +				whether or not the socket is kernel
> > +				based.  A value of 1 implies it is
> > +				kernel based.

> I'm curious how TSEM would distinguish between different kernel
> socket events.  I would expect most kernel sockets to share the same
> event key (COE/CELL/etc.), is that not the case?

In V3 all of the generation of security state coefficient that include
a struct sock * argument to the handler include the TASK_ID of the
task that created the socket, this causes the security state
coefficients to be tied to the corpus of executable code that created
the socket.

The same is being done with other resource types that are 'created' in
a modeling namespace, ie. ipc, inodes etc.

> > +		If the event type is a socket_connect or a
> > +		socket_bind, a socket_connect: or a socket_bind: key
> > +		value will be included that will be characterized
> > +		based on an encoding of either an IPV4, IPV6, AF_UNIX
> > +		or a generic socket description.
> > +
> > +			family: N
> > +				Where N is the ASCII base 10
> > +				representation of the family type of
> > +				the socket.
> > +
> > +			port: N
> > +				Where N is the base ASCII base 10
> > +				representation of the port number that
> > +				is being used for either an IPV4 or
> > +				IPV6 socket connection or bind.
> > +
> > +			addr: N | PATH | HEXID
> > +				In the case of an IPV4 socket the
> > +				value for the addr key will be the
> > +				ASCII base 10 representation of the 32
> > +				bit IPV4 address being bound or
> > +				connected to.
> > +
> > +				In the case of an IPV6 connection the
> > +				value to the key will be the ASCII
> > +				base 16 representation of the 128 bit
> > +				address being bound connected.
> > +
> > +				In the case of an AF_UNIX connection
> > +				the value will be the pathname of the
> > +				socket in the mount namespace that the
> > +				process is running in.
> > +
> > +				In the case of any other type of
> > +				socket the addr value will be the
> > +				ASCII base 16 representation of the
> > +				cryptographic digest value of the
> > +				entire length of the address
> > +				description.  The length of the
> > +				representation will be the size of the
> > +				digest produced by the cryptographic
> > +				hash function that has been specified
> > +				for the modeling namespace.
> > +
> > +			flow: N
> > +				For an IPV6 socket the value of the
> > +				flow key will be the ASCII base 10
> > +				representation of the flow identifier
> > +				assigned to the socket.
> > +
> > +			scope: N
> > +				For an IPV6 socket the value of the
> > +				scope key will be the ASCII base 10
> > +				representation of the scope identifier
> > +				assigned to the socket.

> What will "flow" and "scope" be for non-AF_INET6 sockets?  You need
> to specify that here.

There will be no 'flow' or 'scope' values for non-AF_INET6 sockets.

The JSON encoded security event descriptions are designed to be
self-expressive by whatever is interpreting the event stream, ie. if
the socket family is AF_INET the interpreter will not look for keys
that would express characteristics not expected in an IPV4 socket
description.

> > +		If the event type is a socket_accept a socket_accept
> > +		key value will be included that characterizes either
> > +		an IPV4, IPV6 or a generic socket description with the
> > +		following event descriptions:
> > +
> > +			family: N
> > +				Where N is the ASCII base 10
> > +				representation of the family type of
> > +				the socket.
> > +
> > +			type: N
> > +				Where N is the ASCII base 10
> > +				representation of the type of the
> > +				socket being created.
> > +
> > +			port: N
> > +				Where N is the base ASCII base 10
> > +				representation of the port number that
> > +				is being used for either an IPV4 or
> > +				IPV6 socket connection or bind.
> > +
> > +			addr: N | PATH | HEXID
> > +				In the case of an IPV4 socket the
> > +				value for the addr key will be the
> > +				ASCII base 10 representation of the 32
> > +				bit IPV4 address being bound or
> > +				connected to.
> > +
> > +				In the case of an IPV6 connection the
> > +				value to the key will be the ASCII
> > +				base 16 representation of the 128 bit
> > +				address being bound connected.
> > +
> > +				In the case of an AF_UNIX connection
> > +				the value will be the pathname of the
> > +				socket in the mount namespace that the
> > +				process is running in.
> > +
> > +				In the case of any other type of
> > +				socket the addr value will be the
> > +				ASCII base 16 representation of the
> > +				cryptographic digest value of the
> > +				entire length of the address
> > +				description.  The length of the
> > +				representation will be the size of the
> > +				digest produced by the cryptographic
> > +				hash function that has been specified
> > +				for the modeling namespace.
> > +
> > +What:		ROOTDIR/trajectory_coefficients
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The trajectory_coefficients file will output the ASCII
> > +		base16 representation of each security state
> > +		coefficient that has been generated by the security
> > +		modeling namespace of the calling process.
> > +
> > +		The length of each point will be the ASCII
> > +		representation of the size of the cryptographic hash
> > +		function that has been specified for the model.

> Is this just the ROOTDIR/trajectory JSON in ASCII hex, or something
> different?

These are the security state coefficients that each event in the
trajectory file encodes into under the current model.

> > +What:		ROOTDIR/trajectory_counts
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The trajectory_coefficients file will output the ASCII
> > +		base10 representation of the number of times each

> Unless I'm mistaken, I believe you defined it as base16 above ... ?

These are base 10 values that describe how many times each unique
security event has been experienced in the model.

> > +		security state coefficient has been generated by the
> > +		security modeling namespace of the calling process.
> 
> This looks like an old cut-n-paste error.  I'm guessing this file
> reports on the number of coefficients in ASCII base10?

Correct.

> > +What:		ROOTDIR/forensics
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The forensics file contains the descriptions of
> > +		security events that are inconsistent with the
> > +		security model that the security namespace is
> > +		implementing.  Forensics events are generated after a
> > +		security model is 'sealed' and the events represent
> > +		security state coefficients that have not already been
> > +		generated by the model.
> > +
> > +		The format of lines in this file are identical to the
> > +		output generated by the ROOTDIR/trajectory file
> > +		that is documented above.
> > +
> > +What:		ROOTDIR/forensics_coefficients
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The forensics_coefficients file will output the ASCII
> > +		base16 representation of each security state
> > +		coefficient that have been generated by forensics
> > +		events in the security modeling namespace of the
> > +		calling process.
> > +
> > +		The length of each point will be the ASCII
> > +		representation of the size of the cryptographic hash
> > +		function that has been specified for the model.
> > +
> > +What:		ROOTDIR/forensics_counts
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The forensics_counts file will output the ASCII base10
> > +		representation of the number of times each security
> > +		state coefficient, generated by a forensics event, has
> > +		been generated by the security modeling namespace of
> > +		the calling process.
> > +
> > +What:		/sys/kernel/security/tsem/ExternalTMA
> > +Date:		July 2023
> > +Contact:	Greg Wettstein <greg@enjellic.com>
> > +Description:
> > +		The ExternalTMA directory is a container directory
> > +		that hold files that will be used to export the
> > +		security events, and their associated parameters, for
> > +		externally modeled security modeling namespaces.
> > +
> > +		The files created in this directory will be named by
> > +		the base 10 ASCII representation of the id value
> > +		assigned to the security modeling namespace.  See the
> > +		documentation for the /sys/kernel/security/tsem/id
> > +		file in this documentation for more details on this
> > +		value.
> > +
> > +		This file will is a read-only file that can be polled
> > +		by a userspace trust orchestrator implementation to
> > +		process security events that are to be modeled by an
> > +		external Trusted Modeling Agent.
> > +
> > +		Each exported event is a JSON encoded record
> > +		describing the event that is to be processed.
> > +
> > +		Each record will have an 'export' key that has a
> > +		structure associated with it that has a 'type' key in
> > +		it.  The 'type' key has a string value associated with
> > +		it that defines the type of event that is being
> > +		processed.
> > +
> > +		The following export 'type' strings are defined:
> > +
> > +		aggregate:
> > +			The aggregate key has an associated structure
> > +			value that defines a key named 'value' that
> > +			has a string value associated with it that
> > +			represents the hardware aggregate for the
> > +			platform.

> You need to define "hardware aggregate" here, if you can't go into
> detail you need a good summary outlining its security relevant
> properties.

As noted above, will consider how to do this.

> > +			The hardware aggregate string is expressed as
> > +			the ASCII base16 representation of the
> > +			platform hardware aggregate value.  The length
> > +			of the string will be the size of the digest
> > +			produced by the cryptographic hash function
> > +			that has been specified for the security
> > +			modeling namespace of the process generating
> > +			the event.
> > +
> > +		async_event:
> > +			If the type of the export is async_event there
> > +			will be a key named 'event' that has a structure
> > +			value associated with it.
> > +
> > +			The structure associated with the 'event' key
> > +			will be identical to the structure generated
> > +			for the 'event' key that is described below.
> > +
> > +		event:
> > +			If the type of the export is event there will
> > +			be a key named 'event' that has a structure
> > +			value associated with it that contains the
> > +			follow key: value pairs.
> > +
> > +			pid: NNN
> > +				Where the NNN is the ASCII base 10
> > +				value of the id of the process that is
> > +				executing the security event that will
> > +				be modeled.

> Once more, you can't use a PID to safely identify a process.

As suggested previously, this was the subject of our first mail.

> paul-moore.com

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

