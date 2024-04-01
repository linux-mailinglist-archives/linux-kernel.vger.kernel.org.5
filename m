Return-Path: <linux-kernel+bounces-126607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DE1893A58
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC68B209CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A28219E2;
	Mon,  1 Apr 2024 10:50:42 +0000 (UTC)
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5C21F5FD;
	Mon,  1 Apr 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968641; cv=none; b=IMbfrCePerKGYO+CUaRRDQTZ7JlUeWmAVoe6Ssk4MniLxrLCvBcfy4uu574HaVW1y0LUpb7nNVsu3J42Tl315RyZmzuY4Ex6Qap9N8HTYkJi8RLkW74Fel8q9aN0C9XehRjPhubtMuhfEww1FL0zsQZUDS2KkjCo7cofnoikrdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968641; c=relaxed/simple;
	bh=9+mEVAVEuw6QT4jdVVwJlRp7oJgtCLu2vhv2AzdJnUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T3/i7lUbviAT5LZ06S4H0wejDizOPrIFAS/LUBwHuEdqh9AxwVEWOrL0kTR451SW3LUFlfM7pILYiW1Cg52Qka0xU3jFqsBEc17UqWbBFgMq4g1OAw5Lkoq4a92cayWQ5jYVQoI/+TkGDLAtoXcb1QdJnkZ4j3jIeb9TOxrHgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 431AoHNX027648;
	Mon, 1 Apr 2024 05:50:17 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 431AoFl7027646;
	Mon, 1 Apr 2024 05:50:15 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v3 00/12] Implement Trusted Security Event Modeling.
Date: Mon,  1 Apr 2024 05:50:03 -0500
Message-Id: <20240401105015.27614-1-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Good morning, I hope this note finds the week starting well for
everyone.

This is the third release of Trusted Security Event Modeling (TSEM) as
a new Linux Security Module (LSM) architecture.

TSEM provides kernel infrastructure that allows the implementation of
model based mandatory access controls.  TSEM is model agnostic and
provides infrastructure for implementing deterministic,
quasi-deterministic, probabilistic or machine learning (AI) based
models.

TSEM also provides a framework for generic security monitoring that
can be used to implement Host Based Intrusion Detection (HIDS) and/or
anomaly detection systems without the need to write kernel code,
implement kernel modules or attach BPF programs.

TSEM operates under the premise, that operating system security, like
all other physical phenomena in science and engineering, can be
mathematically modeled.  TSEM notionally treats the LSM security event
hooks/handlers as a basis set of parameters that can be used to
generate a functional value for the security state of a system.

TSEM uses generative functions, rather than static labels, to create
the positive accession elements of a multi-dimensional access vector
matrix.  In doing so, it provides for the highly precise attestation
of the trust status of a platform or workload.  In the case of a
security violation, it also provides very precise forensic
characterizations of the security event.

This approach provides very precise detection and characterization of
adversarial malware strategies such as Living Off The Land (LOTL).

TSEM is designed to support the concept of a Trust Orchestration
System (TOS).  Trust orchestration involves the process of
modeling the security behavior of a workload, or a platform at
large, and defining whether or not a process is to be trusted,
based on whether or not the security events produced are
consistent with a security model that the workload or platform has
been unit tested to.

TSEM, in and of itself, does not implement a security policy or model.
That capability is invested in an entity known as a Trusted Modeling
Agent (TMA).  A TMA can be implemented in the kernel itself or the
security event descriptions can be exported to userspace for
processing in a non-kernel based TMA.

To support this architecture, TSEM implements entirely within the
context of the LSM architecture, the concept of security modeling
namespaces that are similar in concept to other resource namespaces.
A security modeling namespace is paired with a TMA that implements the
root of trust for a namespace.

A TMA implementation uses the characteristics of the calling process
and the descriptive parameters of a security event to drive generative
functions that compute security state coefficients for each security
event.  The sum of these coefficients, represents the security 'state'
of a model.

TSEM supports any number of security modeling namespaces that act
independently of one another and of the root security modeling
namespace.  Each namespace can be configured with its own unique
security model definition that can be modeled internally or
externally.

Security models to be enforced by a trust orchestrator in a security
modeling namespace are developed by unit testing of a workload.  This
model increases model precision and thus decreases the risk of the
mandatory controls breaking applications or expected system behavior.

TSEM thus represents a security architecture that is designed to be
paired with modern software development strategies that embrace
resource containerization and Continuous Integration and Continuous
Delivery principles.  The objective of TSEM, along with the Quixote
TOS implementation, is to bring to Linux security architecture what
Docker brought to Linux resource namespaces.

Included with the implementation is an extensive documentation file
that can be found in the following location in the kernel sources
after application of the patch series.

Documentation/admin-guide/LSM/tsem.rst

TSEM formats security event descriptions into JSON encoded messages
that can be consumed and analyzed by any JSON consuming data
visualization, analysis, modeling or ingress systems.

The following documentation file documents the control plane interface
for TSEM including the JSON encoding format:

Documentation/ABI/testing/tsem

Reviewers, and others who are interested, are referred to these
documents for a more extensive discussion into the rationale, design
and implementation of the TSEM architecture.

Control of TSEM is surfaced entirely via the securityfs filesystem
through the following directory hierarchy:

/sys/kernel/security/tsem

TSEM is designed to be self-contained and independent of the kernel at
large and with other LSM's with which it stacks.  Since the security
guarantee resides in an externally created security model definition,
it operates without the need for filesystem labeling or cryptographic
integrity protection of filesystem metadata.

The Quixote userspace utilities that are needed to create, manage,
interrogate and model security modeling namespaces will be available
soon at the following project site:

https://github.com/Quixote-Project

Included in the userspace tools are implementations of trust
orchestrator's and TMA's for the following trust roots:

Kernel.

Userspace process.

SGX enclave.

Xen hypervisor stub-domain.

Hardware based security coprocessors.

An export only utility is also available that will simply
asynchronously export security event descriptions.  Included is an
MQTT based client for cloud based collection, analysis and modeling of
security behavior.

The Quixote project site also a GIT repositories for various TSEM
enabled kernel releases.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity

V1:
- Initial release.	  

V2:
- V1: https://lore.kernel.org/linux-security-module/20230204050954.11583-1-greg@enjellic.com/T/#t
- Allow compile time configuration of the Platform Configuration
  Register used to extend security coefficients in the root
  security modeling namespace.
- Allow both internal and external modeling of security events
  that are called in atomic context.
- Use JSON to encode security event characteristics.
- Use securityfs for TSEM control plane rooted at
  /sys/kernel/security/tsem.
- Use framework of separate directories for internal TMA's to
  protect ABI compatability.
- Use key=value arguments for control plane commands.
- Allow cryptographic hash function used for coefficient
  generation to be configured on a namespace by namespace basis.
- Allow selection of initial or current user namespace as the
  reference for UID/GID resolution to be configured on a namespace
  by namespace basis.
- Allow the size of modeling and export structures to be configured
  on a namespace by namespace basis.
- Extensively document all globally visible enumerations and structures.
- Use CAP_ML rather than CAP_TRUST for modeling capability bit.
- Implement orchestrator<->process mutual authentication.
- Implement occupancy counts for security state coefficients.
- Move TSEM to the first LSM in the LSM list.

V3:
- V2: https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t
- Require CAP_MAC_ADMIN capability for namespace creation and management.
- Implement full modeling for all TSEM captured LSM events.
- Implement export only namespaces.
- Support export only root security modeling namespaces.
- Support invariant models for namespaces that create files.
- Model all filesystem types.
- Include device types in path descriptions.
- Use bprm_committed_creds for TASK_ID generation.
- Implemented modeling for capget, capset and capable LSM calls.
- Use static keys to optimize control paths.
- Standardize all event handlers to use common format.
- Level tmpfs based filesystems to a common UUID.
- Implement security event timestamps.
- Implement parent event tracking.
- Update TASK_ID generative function to use parent TASK_ID.
- Multiple style and bug fixes.
- Update TSEM documentation including per file functional descriptions.
- Document JSON security event encoding.

Dr. Greg (12):
  Update MAINTAINERS file.
  Add TSEM specific documentation.
  TSEM global declarations.
  Add primary TSEM implementation file.
  Add root domain trust implementation.
  Implement TSEM control plane.
  Add namespace implementation.
  Add security event description export facility.
  Add event processing implementation.
  Implement security event mapping.
  Implement the internal Trusted Modeling Agent.
  Activate the configuration and build of the TSEM LSM.

 Documentation/ABI/testing/tsem                | 2386 ++++++++++++++++
 Documentation/admin-guide/LSM/index.rst       |    1 +
 Documentation/admin-guide/LSM/tsem.rst        | 1657 +++++++++++
 .../admin-guide/kernel-parameters.txt         |   24 +
 MAINTAINERS                                   |    8 +
 include/uapi/linux/lsm.h                      |    1 +
 security/Kconfig                              |   11 +-
 security/Makefile                             |    1 +
 security/security.c                           |    3 +-
 security/tsem/Kconfig                         |   36 +
 security/tsem/Makefile                        |    2 +
 security/tsem/event.c                         | 1815 ++++++++++++
 security/tsem/export.c                        |  432 +++
 security/tsem/fs.c                            | 2288 ++++++++++++++++
 security/tsem/map.c                           | 1778 ++++++++++++
 security/tsem/model.c                         |  757 ++++++
 security/tsem/namespace.c                     |  515 ++++
 security/tsem/trust.c                         |  261 ++
 security/tsem/tsem.c                          | 2422 +++++++++++++++++
 security/tsem/tsem.h                          | 2278 ++++++++++++++++
 20 files changed, 16670 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/tsem
 create mode 100644 Documentation/admin-guide/LSM/tsem.rst
 create mode 100644 security/tsem/Kconfig
 create mode 100644 security/tsem/Makefile
 create mode 100644 security/tsem/event.c
 create mode 100644 security/tsem/export.c
 create mode 100644 security/tsem/fs.c
 create mode 100644 security/tsem/map.c
 create mode 100644 security/tsem/model.c
 create mode 100644 security/tsem/namespace.c
 create mode 100644 security/tsem/trust.c
 create mode 100644 security/tsem/tsem.c
 create mode 100644 security/tsem/tsem.h

-- 
2.39.1


