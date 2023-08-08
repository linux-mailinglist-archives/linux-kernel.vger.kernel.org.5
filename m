Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DFE774A18
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbjHHUR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjHHURm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:17:42 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229D719405;
        Tue,  8 Aug 2023 11:48:31 -0700 (PDT)
Received: from jerom (unknown [128.107.241.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: serge)
        by mail.hallyn.com (Postfix) with ESMTPSA id 0EB6C883;
        Tue,  8 Aug 2023 13:48:27 -0500 (CDT)
Date:   Tue, 8 Aug 2023 13:48:25 -0500
From:   Serge Hallyn <serge@hallyn.com>
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 02/13] Add TSEM specific documentation.
Message-ID: <ZNKN+ZK6Lfbjb4GZ@jerom>
References: <20230710102319.19716-1-greg@enjellic.com>
 <20230710102319.19716-3-greg@enjellic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710102319.19716-3-greg@enjellic.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 05:23:08AM -0500, Dr. Greg wrote:
> An entry was added to the ABI testing documentation to document

"Add an entry..." is the usual way to document this in commit msg.

> the files in the TSEM management filesystem.
> 
> The file documenting the kernel command-line parameters was
> updated to document the TSEM specific command-line parameters

A commit's actions are more normally in present tens
("The file documenting the kernel command-line parameters is")

> The primary TSEM documentation file was added to the LSM
> administration guide and the file was linked to the index of LSM
> documentation.
> 
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  Documentation/ABI/testing/tsem                |  828 +++++++++
>  Documentation/admin-guide/LSM/index.rst       |    1 +
>  Documentation/admin-guide/LSM/tsem.rst        | 1526 +++++++++++++++++
>  .../admin-guide/kernel-parameters.txt         |   18 +
>  4 files changed, 2373 insertions(+)
>  create mode 100644 Documentation/ABI/testing/tsem
>  create mode 100644 Documentation/admin-guide/LSM/tsem.rst
> 
> diff --git a/Documentation/ABI/testing/tsem b/Documentation/ABI/testing/tsem
> new file mode 100644
> index 000000000000..cfb013b5f1f4
> --- /dev/null
> +++ b/Documentation/ABI/testing/tsem
> @@ -0,0 +1,828 @@
> +What:		/sys/kernel/security/tsem
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The /sys/kernel/security/tsem directory contains files
> +		and directories that implement the control plane for
> +		the Trusted Security Event Modeling (TSEM) LSM.
> +
> +		The files in this directory hierarchy, with the
> +		exception of the aggregate file, when read, reflect
> +		the values for the security modeling namespace that
> +		the process reading the files is operating in.
> +
> +What:		/sys/kernel/security/tsem/id
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The id file contains the ASCII base 10 representation

Why not use base 16 here?  Mixing bases amongst the files could get
confusing.

> +		of the model domain/namespace identifier that the
> +		reading process is operating in.
> +
> +		The root security modeling namespace has a value of
> +		zero, a non-zero value indicates a modeling namespace
> +		subordinate to the root model.
> +
> +		Each externally modeled domain will have a file, with
> +		this id number, created in the
> +		/sys/kernel/security/tsem/ExternalTMA directory that
> +		is documented below.
> +
> +What:		/sys/kernel/security/tsem/aggregate
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The aggregate file contains the ASCII base 16
> +		representation of the 256 bit hardware platform
> +		aggregate that TSEM is modeling under.  The platform
> +		aggregate is the linear extension measurement of the
> +		Trusted Platform Module PCR registers 0 through 8.
> +
> +		On a platform without a TPM this value will be all
> +		null bytes.
> +
> +What:		/sys/kernel/security/tsem/control
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The control file is the only writable file in the
> +		filesystem and is used by the trust orchestrator's to
> +		configure and control the behavior of the TSEM
> +		implementation.
> +
> +		The following keyword and arguments are recognized:
> +
> +		internal
> +			The internal keyword causes an internally
> +			modeled domain to be created for the calling
> +			process.
> +
> +		external
> +			The external keyword causes an externally
> +			modeled domain to be created for the calling
> +			process.
> +
> +			A modeling namespace created by these commands
> +			accept the following set of key=value pairs
> +			that configure the namespace:
> +
> +			nsref=initial|current
> +				The nsref key specifies the namespace
> +				that is to be referenced when
> +				determining the UID/GID values that
> +				define a COE or CELL identity.
> +
> +				The initial keyword specifies that the
> +				initial user namespace be used.  The
> +				current keyword specifies that the
> +				user namespace of the process that is
> +				invoking a security event handler
> +				(hook) is used.

Hm, does this allow a process in a container to escape the container's
policy, by creating a new domain inheriting from the initial userns?

> +TSEM implements its equivalent of mandatory access controls, without a
> +requirement for extended attributes, filesystem labeling or the need
> +to protect filesystem metadata against offline attack.  A mathematical

If the security policy is that no data from /dev/tty, because it is
untrusted, may flow into high integrity files, then how do you track
the files which are high integrity, without labeling high integrity
files?  You're intending for the agent to track the files using
inode number and fsid?

> +The root security model extends each security state coefficient into a
> +PCR.  The default PCR is 11 but is configurable through the kernel

Note pcr 11 will conflict with systemd's usage

https://uapi-group.org/specifications/specs/linux_tpm_pcr_registry/

> +It is up to the trust orchestrator and its security policy to
> +determine how it handles events that violate the security model being
> +enforced.  The Quixote trust orchestrators shut down the entire
> +workload running in the security namespace if an asynchronously
> +modeled event violates the security model being enforced and the model
> +is running in enforcing mode.

So instead of returning EPERM, you'll let the process speculatively
continue until quixote has a chance to catch up and return a "no not
allowed" message, after which the whole workload will be killed?

> +From a hardware perspective, this is important with respect to the
> +notion of a TMA being a model for a successor to the TPM.  From a
> +system trust or integrity perspective, a TPM is designed to provide a
> +retrospective assessment of the actions that have occurred on a
> +platform.  A verifying party uses the TPM event log and a PCR based
> +summary measurement, to verify what actions have occurred on the host,
> +in order to allow a determination of whether or not the platform
> +should be 'trusted'.

FWIW TPM EA policies also refuse access to secrets based on those and
other data.  It's not purely for retrospective assessment.  But indeed
TPM does not authorize actions as trusted.  Not because it fails to do
so but because it's not part of its design.

> +
> +In contrast, a TSEM/TMA based system enforces, on a real time basis,
> +that a platform or workload remains in a trusted state.  Security
> +relevant actions cannot be conducted unless the TMA authorizes the
> +actions as being trusted.
> +
> +This is particularly important with respect to embedded systems.  A
> +TPM based architecture would not prevent a system from having its
> +trust status altered.  Maintaining the system in a trusted state would
> +require attestation polling of the system, and presumably, executing
> +actions if the platform has engaged in untrusted behavior.
> +
> +Conversely, a trust orchestrated software implementation enforces that
> +a system or workload remain in a security/trust state that it's
> +security model was unit tested to.

To be convinced that there is *any* use case for this in the real world,
you'd need to show me how any useful rule, like your above /etc/shadow
set, could actually indicate a less trustworthy state in a robust way,
without turning into an easy accidental-self-DOS.

I'm afraid the answer is going to be "AI"...

> +Security model functional definitions
> +-------------------------------------
> +
> +Previously, classic trusted system implementations supported the
> +notion of the 'measurement' of the system.  The measurement is the
> +value of a linear extension function of all the security relevant
> +actions recorded by a trust measurement system such as IMA.
> +
> +In TPM based trust architectures, this measurement is maintained in a
> +PCR.  A measurement value is submitted to the TPM that extends the
> +current measurement using the following formula:
> +
> +MEASUREMENT = HASH(CURRENT || NEW)
> +
> +	Where:
> +		MEASUREMENT = The new measurement value to be maintained
> +			      in the register for the system.
> +
> +		||	    = Concatenation operator.
> +
> +		HASH	    = A cryptographic hash function supported
> +			      by the TPM device.
> +
> +		CURRENT     = The current measurement value.
> +
> +		NEW	    = A new measurement value to be added to
> +			      the current measurement.
> +
> +In TPM1 based systems, the HASH function was SHA1.  Due to well
> +understood security concerns about the cryptographic vitality of this
> +function, TPM2 based systems provide additional HASH functions with
> +stronger integrity guarantees, most principally SHA related functions
> +with longer digest values such as SHA256, SHA384 and SM3.

This previous paragraph simply is not needed in this document.

> +The use of a cryptographic function produces a non-commutative sum
> +that can be used to verify the integrity of a series of measurements.
> +With respect to security modeling theory, this can be thought of as a
> +'time-dependent' measurement of the system.  Stated more simply, the
> +measurement value is sensitive to the order in which the measurements
> +were made.
> +
> +In systems such as IMA, the measurement value reflects the sum of
> +digest values of what are considered to be security critical entities,
> +most principally, files that are accessed, based on various policies.
> +
> +In TSEM based TMA's, the measurement of a modeling namespace is the
> +sum of the security state coefficients generated by the operative
> +security model being enforced.  As previously noted, on systems with a
> +TPM, the root modeling namespace measurement is maintained by default
> +in PCR 11 or the PCR that was selected at kernel configuration time.
> +
> +The challenge associated with classic integrity measurements is the
> +time dependent nature of using a non-commutative summing function.
> +The almost universal embrace of SMP based hardware architectures, in
> +addition to standard kernel task scheduling issues, makes the
> +measurement values non-deterministic.  This requires a verifying party
> +to evaluate an event log, verified by a measurement value, to
> +determine whether or not the system is in a security appropriate
> +state.
> +
> +TSEM addresses this issue by implementing a strategy designed to
> +produce a single functional value that represents the security state

You've spent a lot of space discussing the "time based" (I think
"order dependent" might be better) nature of IMA and TPM measurements.
But after reading this section twice, I'm still not seeing what TMA
does to work around it.

If a process normally reads files F1, F2, .. F10, then writes F11,
but next time it reads F1, F3, F2, F4, .. F10, how will these two
different vectors be used in TMA?

> +of a model.  This allows a TMA to attest to the trust/security status
> +of a platform or workload by signing this singular value and
> +presenting it to a verifying party.
> +
> +In TSEM nomenclature, this singular value is referred to as the
> +'state' of the model.  The attestation model is to use trust
> +orchestrators to generate the state value of a workload by unit
> +testing.  This state value can be packaged with a utility or container
> +to represent a summary trust characteristic that can be attested by a
> +TMA, eliminating the need for a verifying partner to review and verify
> +an event log.
> +
> +TMA's implement this architecture by maintaining a single instance
> +vector of the set of security state coefficients that have been
> +generated.  A state measurement is generated by sorting the vector in
> +big-endian hash format and then generating a standard measurement
> +digest over this new vector.

Are you saying the TMA will keep every meaningful measurement for the
duration of the workload, so that it can always sort them?

> +Any security event that generates an associated state coefficient that
> +is not in the model will resulted in a perturbed state function value.
> +That perturbed value would be interpreted by a verifying party as an
> +indication of an untrusted system.
> +
> +Since the TMA maintains the security event descriptions in time
> +ordered form, the option to provide a classic event log and
> +measurement are preserved and available.  Extensive experience in the
> +development of TSEM modeled systems has demonstrated the superiority
> +of state value interpretation over classic measurement schemes.

I think you're saying that keeping the tens of thousands security
relevant events instead of keeping a hash of those events gives you
more information... which is true.  It also gives you more information.
In a presumably limited space and over a presumably limited link.  No
performance impact?

I'd really like to see what a conscise but useful policy looks like.

-serge
