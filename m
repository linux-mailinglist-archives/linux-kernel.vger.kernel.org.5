Return-Path: <linux-kernel+bounces-17443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1BA824D51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E51286575
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE814428;
	Fri,  5 Jan 2024 03:07:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275AF20EE;
	Fri,  5 Jan 2024 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4052tmWu017700;
	Thu, 4 Jan 2024 20:55:48 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4052tlkl017699;
	Thu, 4 Jan 2024 20:55:47 -0600
Date: Thu, 4 Jan 2024 20:55:47 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH 2/13] Add TSEM specific documentation.
Message-ID: <20240105025547.GA17605@wind.enjellic.com>
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
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 04 Jan 2024 20:55:48 -0600 (CST)

On Wed, Jan 03, 2024 at 11:00:33PM -0500, Paul Moore wrote:

Good morning, I hope the year is starting well for everyone.

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

> Let me start by apologizing for the delay in responding, your
> patience was appreciated.  Comments below ...

No problem, you were sounding pretty jammed up before the holidays,
thank you for starting to find the time to look at this.

That being said, we have continued to advance TSEM over the last six
months based on input from our partners.  With the New Year behind us,
we were preparing for a V3 release sometime in mid-January if we can
stay on schedule.

Given that, and the value of your review time, you may want to hold
off on a more extensive review until we can get V3 out the door.

We have taken down all of your comments below and will incorporate
changes and improvement where still relevant.

You voiced two major concerns at the end of your e-mail that you
wanted clarified before you spent additional time on TSEM, I will skip
forward to those so we can reach a better understanding on those
fundamental issues.

> > diff --git a/Documentation/ABI/testing/tsem b/Documentation/ABI/testing/tsem
> > new file mode 100644
> > index 000000000000..cfb013b5f1f4

... [ Content elided ] ...

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

Correct, which is why we changed our approach.

> We discussed the PID reuse problem in the previous draft of TSEM and
> you seem confident that this revision would solve the problem,
> unfortunately I don't believe that to be the case.  Perhaps the code
> is sound and the documentation is lagging/incorrect, but the doc
> appears to be consistent enough in this area that I don't believe
> that to be the case.  Before I can spend any more time looking at
> TSEM I need to understand how it handles PID recycling.

We cover the threat model and addressed how we responded to it in the
TSEM documentation file.

We will put a header at the top of the ABI document advocating that
the TSEM documentation file be read before the ABI document is
consumed.

We use the PID infrastructure to locate the process that is waiting on
a response from an external trust orchestrator.  After that the kernel
uses an authentication process to verify that the task being acted on
has not been replaced by an alternate task outside the scope of
control of the orchestrator for the namespace.

In Documentation/admin-guide/LSM/tsem.rst, the discussion is under the
following sub-heading:

Trust Orchestrator/Process authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since it is an important issue, I will take the liberty of pasting
this documentation section in-line below, so that people don't have to
go digging for it and it becomes part of this documentation thread on
lore:

---------------------------------------------------------------------------
The process identifier values (PID's) that are exported in the
security event descriptions are the unique global PID values, not the
value as seen through the lens of a PID namespace.

PID values are, by default, not considered to be a stable identifier
between the kernel and userspace.  In the case of TSEM external
modeling, the threat model for a namespace is whether or not an
adversarial process, running in either the root modeling namespace or
another subordinate modeling namespace, can kill a process that is
being orchestrated and substitute an alternate process with an
identical PID value.

The trust orchestrator would then be deluded into setting the trust
status of the adversarial process rather than the one that had emitted
the security event characteristics that were evaluated.  The threat
interval is the latency time required for the processing of the
security event description by the trust orchestrator and its
associated TMA.

Exploiting this theoretical race is extremely complex and requires an
in depth understanding of the TSEM architecture.  Rather than discuss
the conditions that must be met and their implications, this
discussion will focus on the generic threat model and the mechanisms
that TSEM implements in order to mitigate this threat.

In short, a process in an adversarial security modeling namespace
would desire to execute security events that are barred from its
security model with the hope of having them approved by an alternate
namespace.

In order to exploit the race, an adversarial process would have to
force the termination of a process in the target namespace and then
fork and exit a process a sufficient number of times in order to have
a process under its control match the PID value of the process that
was waiting for an orchestration response.

Measured modeling latency times for a trust orchestrator running the
deterministic Quixote TMA in userspace, on current generation i3
x86_64 hardware, averages 170 micro-seconds.  From the perspective of
an adversary, there is a requirement to force the termination of the
target process and then fork and execute a sufficient number of times
to force the PID collision during this time interval.

As a generic protection, TSEM in the tsem_task_kill() handler, blocks
the notion of 'cross-model' signals, ie. a signal originating from an
external modeling namespace.  This would require the adversary to
reliably force a process termination through a mechanism other than
signaling, for example, through the OOM killer whose signal
transmission would not be blocked by this policy control.

In addition.

When a subordinate security modeling namespace is created, the id
number of the namespace is registered in the tsem_task structure of
the trust orchestrator that is creating the namespace.  The TSEM
implementation will refuse to honor control plane requests affecting
the trust status of a process whose trust orchestrator security
namespace id does not match the namespace id of the process that it is
being asked to act on.

As an additional protection, TSEM uses an authentication strategy that
requires a process running in a security modeling namespace to verify
that a control request is coming from the trust orchestrator that
initiated the namespace the process is running in.  As part of the
setup of a security modeling namespace, a trust orchestrator is
required to provide a hexadecimally encoded authentication key that
matches the length of the cryptographic hash function being used to
generate security state coefficients in the modeling namespace.  This
authentication key must be provided by the trust orchestrator for
every subsequent control plane request.

The lead process that is being transferred to a subordinate security
modeling namespace generates a second random key that is hashed with
the authentication key provided by the trust orchestrator, using the
hash function that has been defined for the security namespace.  The
resultant digest value is compared to a list of authentication keys
for all currently executing namespaces.  The selection of the second
random key is repeated until a globally unique key is generated.

This randomly generated authentication key is stored in the tsem_task
structure of the process and propagated to any subsequent processes
that are created in the namespace.  The hash product of this key and
the orchestration authentication key, ie. the globally unique key, is
placed in the tsem_task control structure of the orchestration
process.

When a control plane request is received, the authentication key
provided by the trust orchestrator is used to re-generate an
authentication key based on the randomly generated namespace key held
by the process whose trust status is being updated, this key is
compared to the key in the tsem_task structure of the process issuing
the orchestration request.  The control plane will refuse to honor a
control plane request if the call specific key generation process does
not produce a key that matches the one that was generated at the time
the security namespace was created.
---------------------------------------------------------------------------

This implementation remains the same between the V2 and V3 releases.

See the following code locations for details:

security/tsem/namespace.c:tsem_ns_event_key()
security/tsem/namespace.c:generate_task_key()
security/tsem/namespace.c:remove_task_key()

security/tsem/fs.c:control_COE()

> I'm also concerned that it appears pathname digests, as opposed to
> the pathnames themselves, are being used to help uniquely identify
> security events.  Relying on pathnames unique identification can
> already be a challenge, relying on a hashed pathname without any
> provisions to manage/mitigate collisions seems like an attack
> waiting to happen.  Please provide some additional explanations as
> to why this is not a concern.

The V3 release no longer uses the cryptographic digest of the pathname
length and path as an independent entity.  The V3 release also now
includes a device name specification as a component of any pathname
specification.

That being said, the pathname identification is a component of the
input stream that is fed to the namespace specific cryptographic
digest function that generates the security state coefficient for an
event.  So it would seem that your criticism would extend to the very
notion of the generation of security state coefficients.

To be clear, without getting overtly wonky, TSEM is rather firmly
ensconced on the following security predicate:

"Given a digest value of an input stream generated by a
cryptographically relevant hash function, it is computationally
infeasible for an adversary to create a second input stream, different
from the first, that generates the same digest value."

Is it an error to have operated under this assumption in the
construction of TSEM?

We can grind into much deeper detail as to why TSEM would make this
type of attack difficult, but obtaining agreement on the validity of
the above predicate would seem to be the most important first step.

> paul-moore.com

Thank you again for finding time for this.

Let us know if additional clarifications would be helpful.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

