Return-Path: <linux-kernel+bounces-94719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BC8874427
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E57B23873
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A585026A;
	Wed,  6 Mar 2024 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XvF4ivQV"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9E11B96E;
	Wed,  6 Mar 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768095; cv=none; b=rUIoFUomCsx3djizlwybntCtM/0UgqAdqmzuPDAO65rHKciUHu3aviLrpzTGu580JWLGhfJUAoUh3/6KnMCQR8tENmWQ7rO8rR5R899dR/VNRrmb/BuinoXVt3PCB/fq/u7zMHoDodiA5CRRr6E/+71mlF1io3ye3pmgHN1kFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768095; c=relaxed/simple;
	bh=7a8yBUcbbKVI1IRK4Bg2cEuvblaasaX48XYAIBSNyLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LOXOtaYNJcTXutrkRy4kq900RTKVWl+GLJ1GUa4Lpo+DRkxEFKWmtK63oIX36cqtsLrWIVEiOF1CAuJuJs+YF31HcKWrYiY+FejEMOGJ4f9aS98j5n3K1PRq6gBr7woI+Iu3K+CSfZHtnYHv5lxMPxu0gAh/mEdYYNFfH3vICps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XvF4ivQV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id DBB1A20B74C0; Wed,  6 Mar 2024 15:34:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBB1A20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709768091;
	bh=Kz7FfChWBEsFcW4+vT9tmqA1bz61MI4SgafyKt0p2h0=;
	h=From:To:Cc:Subject:Date:From;
	b=XvF4ivQVlurz9h/8KMjvs+QyEmeuKUCsFjs9DwOvij+l7hD92BZ4Ct/Tm1jrE45KW
	 V4D5IcHxaaOzNGDPTC+HbM+XjaXS3PwSIMjj+p8nuYUacc0MZ4LHLrpcAPmdfVMbAd
	 lR6A03LYTaMyFFT8dv+1OnXOnmPJG7tvzEeCEmSo=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [RFC PATCH v14 00/19] Integrity Policy Enforcement LSM (IPE)
Date: Wed,  6 Mar 2024 15:34:25 -0800
Message-Id: <1709768084-22539-1-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Overview:
---------

IPE is a Linux Security Module which takes a complimentary approach to
access control. Whereas existing mandatory access control mechanisms
base their decisions on labels and paths, IPE instead determines
whether or not an operation should be allowed based on immutable
security properties of the system component the operation is being
performed on.

IPE itself does not mandate how the security property should be
evaluated, but relies on an extensible set of external property providers
to evaluate the component. IPE makes its decision based on reference
values for the selected properties, specified in the IPE policy.

The reference values represent the value that the policy writer and the
local system administrator (based on the policy signature) trust for the
system to accomplish the desired tasks.

One such provider is for example dm-verity, which is able to represent
the integrity property of a partition (its immutable state) with a digest.

IPE is compiled under CONFIG_SECURITY_IPE.

Use Cases
---------

IPE works best in fixed-function devices: Devices in which their purpose
is clearly defined and not supposed to be changed (e.g. network firewall
device in a data center, an IoT device, etcetera), where all software and
configuration is built and provisioned by the system owner.

IPE is a long-way off for use in general-purpose computing: the Linux
community as a whole tends to follow a decentralized trust model,
known as the web of trust, which IPE has no support for as of  yet.
There are exceptions, such as the case where a Linux distribution
vendor trusts only their own keys, where IPE can successfully be used
to enforce the trust requirement.

Additionally, while most packages are signed today, the files inside
the packages (for instance, the executables), tend to be unsigned. This
makes it difficult to utilize IPE in systems where a package manager is
expected to be functional, without major changes to the package manager
and ecosystem behind it.

DIGLIM[1] is a system that when combined with IPE, could be used to
enable general purpose computing scenarios.

Policy:
-------

IPE policy is a plain-text policy composed of multiple statements
over several lines. There is one required line, at the top of the
policy, indicating the policy name, and the policy version, for
instance:

  policy_name=Ex_Policy policy_version=0.0.0

The policy version indicates the current version of the policy. This is
used to prevent roll-back of policy to potentially insecure previous
versions of the policy.

The next portion of IPE policy, are rules. Rules are formed by key=value
pairs, known as properties. IPE rules require two keys: "action", which
determines what IPE does when it encounters a match against the policy
and "op", which determines when that rule should be evaluated.

Thus, a minimal rule is:

  op=EXECUTE action=ALLOW

This example rule will allow any execution. A rule is required to have the
"op" property as the first token of a rule, and the "action" as the last
token of the rule.

Additional properties are used to restrict attributes about the files being
evaluated. These properties are intended to be deterministic attributes
that are resident in the kernel.

For example:

  op=EXECUTE dmverity_signature=FALSE action=DENY

This rule with property dmverity_signature will deny any file not from
a signed dmverity volume to be executed.

All available properties for IPE described in the documentation patch of
this series.

Rules are evaluated top-to-bottom. As a result, any revocation rules,
or denies should be placed early in the file to ensure that these rules
are evaluated before a rule with "action=ALLOW" is hit.

Any unknown syntax in IPE policy will result in a fatal error to parse
the policy.

Additionally, a DEFAULT operation must be set for all understood
operations within IPE. For policies to remain completely forwards
compatible, it is recommended that users add a "DEFAULT action=ALLOW"
and override the defaults on a per-operation basis.

For more information about the policy syntax, see the kernel
documentation page.

Early Usermode Protection:
--------------------------

IPE can be provided with a policy at startup to load and enforce.
This is intended to be a minimal policy to get the system to a state
where userspace is setup and ready to receive commands, at which
point a policy can be deployed via securityfs. This "boot policy" can be
specified via the config, SECURITY_IPE_BOOT_POLICY, which accepts a path
to a plain-text version of the IPE policy to apply. This policy will be
compiled into the kernel. If not specified, IPE will be disabled until a
policy is deployed and activated through the method above.

Policy Examples:
----------------

Allow all:

  policy_name=Allow_All policy_version=0.0.0
  DEFAULT action=ALLOW

Allow only initramfs:

  policy_name=Allow_All_Initramfs policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE boot_verified=TRUE action=ALLOW

Allow any signed dm-verity volume and the initramfs:

  policy_name=AllowSignedAndInitramfs policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE boot_verified=TRUE action=ALLOW
  op=EXECUTE dmverity_signature=TRUE action=ALLOW

Prohibit execution from a specific dm-verity volume, while allowing
all signed volumes and the initramfs:

  policy_name=ProhibitSingleVolume policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE dmverity_roothash=sha256:401fcec5944823ae12f62726e8184407a5fa9599783f030dec146938 action=DENY
  op=EXECUTE boot_verified=TRUE action=ALLOW
  op=EXECUTE dmverity_signature=TRUE action=ALLOW

Allow only a specific dm-verity volume:

  policy_name=AllowSpecific policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE dmverity_roothash=sha256:401fcec5944823ae12f62726e8184407a5fa9599783f030dec146938 action=ALLOW

Allow any signed fs-verity file

  policy_name=AllowSignedFSVerity policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE fsverity_signature=TRUE action=ALLOW

Deny a specific fs-verity file:

  policy_name=ProhibitSpecificFSVF policy_version=0.0.0
  DEFAULT action=DENY

  op=EXECUTE fsverity_digest=sha256:fd88f2b8824e197f850bf4c5109bea5cf0ee38104f710843bb72da796ba5af9e action=DENY
  op=EXECUTE boot_verified=TRUE action=ALLOW
  op=EXECUTE dmverity_signature=TRUE action=ALLOW

Deploying Policies:
-------------------

First sign a plain text policy, with a certificate that is present in
the SYSTEM_TRUSTED_KEYRING of your test machine. Through openssl, the
signing can be done via:

  openssl smime -sign -in "$MY_POLICY" -signer "$MY_CERTIFICATE" \
    -inkey "$MY_PRIVATE_KEY" -outform der -noattr -nodetach \
    -out "$MY_POLICY.p7s"

Then, simply cat the file into the IPE's "new_policy" securityfs node:

  cat "$MY_POLICY.p7s" > /sys/kernel/security/ipe/new_policy

The policy should now be present under the policies/ subdirectory, under
its "policy_name" attribute.

The policy is now present in the kernel and can be marked as active,
via the securityfs node:

  echo 1 > "/sys/kernel/security/ipe/$MY_POLICY_NAME/active"

This will now mark the policy as active and the system will be enforcing
$MY_POLICY_NAME.

There is one requirement when marking a policy as active, the policy_version
attribute must either increase, or remain the same as the currently running
policy.

Policies can be updated via:

  cat "$MY_UPDATED_POLICY.p7s" > \
    "/sys/kernel/security/ipe/policies/$MY_POLICY_NAME/update"

Additionally, policies can be deleted via the "delete" securityfs
node. Simply write "1" to the corresponding node in the policy folder:

  echo 1 > "/sys/kernel/security/ipe/policies/$MY_POLICY_NAME/delete"

There is only one requirement to delete policies, the policy being
deleted must not be the active policy.

NOTE: Any securityfs write to IPE's nodes will require CAP_MAC_ADMIN.

Integrations:
-------------

This patch series adds support for fsverity via digest and signature
(fsverity_signature and fsverity_digest), dm-verity by digest and
signature (dmverity_signature and dmverity_roothash), and trust for
the initramfs (boot_verified).

Please see the documentation patch for more information about the
integrations available.

Testing:
--------

KUnit Tests are available. Recommended kunitconfig:

    CONFIG_KUNIT=y
    CONFIG_SECURITY=y
    CONFIG_SECURITYFS=y
    CONFIG_PKCS7_MESSAGE_PARSER=y
    CONFIG_SYSTEM_DATA_VERIFICATION=y
    CONFIG_FS_VERITY=y
    CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
    CONFIG_BLOCK=y
    CONFIG_MD=y
    CONFIG_BLK_DEV_DM=y
    CONFIG_DM_VERITY=y
    CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
    CONFIG_NET=y
    CONFIG_AUDIT=y
    CONFIG_AUDITSYSCALL=y
    CONFIG_BLK_DEV_INITRD=y

    CONFIG_SECURITY_IPE=y
    CONFIG_IPE_PROP_DM_VERITY=y
    CONFIG_IPE_PROP_FS_VERITY=y
    CONFIG_SECURITY_IPE_KUNIT_TEST=y

Simply run:

    make ARCH=um mrproper
    ./tools/testing/kunit/kunit.py run --kunitconfig <path/to/config>

And the tests will execute and report the result.

In addition, IPE has a python based integration
test suite https://github.com/microsoft/ipe/tree/test-suite that
can test both user interfaces and enforcement functionalities.

Documentation:
--------------

There is both documentation available on github at
https://microsoft.github.io/ipe, and Documentation in this patch series,
to be added in-tree.

Known Gaps:
-----------

IPE has two known gaps:

1. IPE cannot verify the integrity of anonymous executable memory, such as
  the trampolines created by gcc closures and libffi (<3.4.2), or JIT'd code.
  Unfortunately, as this is dynamically generated code, there is no way
  for IPE to ensure the integrity of this code to form a trust basis. In all
  cases, the return result for these operations will be whatever the admin
  configures the DEFAULT action for "EXECUTE".

2. IPE cannot verify the integrity of interpreted languages' programs when
  these scripts invoked via ``<interpreter> <file>``. This is because the
  way interpreters execute these files, the scripts themselves are not
  evaluated as executable code through one of IPE's hooks. Interpreters
  can be enlightened to the usage of IPE by trying to mmap a file into
  executable memory (+X), after opening the file and responding to the
  error code appropriately. This also applies to included files, or high
  value files, such as configuration files of critical system components.

Appendix:
---------

A. IPE Github Repository: https://github.com/microsoft/ipe
B. IPE Users' Guide: Documentation/admin-guide/LSM/ipe.rst

References:
-----------

1: https://lore.kernel.org/bpf/4d6932e96d774227b42721d9f645ba51@huawei.com/

FAQ:
----

Q: What is the difference between IMA and IPE?

A: See the documentation patch for more on this topic.

Previous Postings
-----------------

v1: https://lore.kernel.org/all/20200406181045.1024164-1-deven.desai@linux.microsoft.com/
v2: https://lore.kernel.org/all/20200406221439.1469862-1-deven.desai@linux.microsoft.com/
v3: https://lore.kernel.org/all/20200415162550.2324-1-deven.desai@linux.microsoft.com/
v4: https://lore.kernel.org/all/20200717230941.1190744-1-deven.desai@linux.microsoft.com/
v5: https://lore.kernel.org/all/20200728213614.586312-1-deven.desai@linux.microsoft.com/
v6: https://lore.kernel.org/all/20200730003113.2561644-1-deven.desai@linux.microsoft.com/
v7: https://lore.kernel.org/all/1634151995-16266-1-git-send-email-deven.desai@linux.microsoft.com/
v8: https://lore.kernel.org/all/1654714889-26728-1-git-send-email-deven.desai@linux.microsoft.com/
v9: https://lore.kernel.org/lkml/1675119451-23180-1-git-send-email-wufan@linux.microsoft.com/
v10: https://lore.kernel.org/lkml/1687986571-16823-1-git-send-email-wufan@linux.microsoft.com/
v11: https://lore.kernel.org/lkml/1696457386-3010-1-git-send-email-wufan@linux.microsoft.com/
v12: https://lore.kernel.org/lkml/1706654228-17180-1-git-send-email-wufan@linux.microsoft.com/
v13: https://lore.kernel.org/lkml/1709168102-7677-1-git-send-email-wufan@linux.microsoft.com/

Changelog:
----------

v2:
  Split the second patch of the previous series into two.
  Minor corrections in the cover-letter and documentation
  comments regarding CAP_MAC_ADMIN checks in IPE.

v3:
  Address various comments by Jann Horn. Highlights:
    Switch various audit allocators to GFP_KERNEL.
    Utilize rcu_access_pointer() in various locations.
    Strip out the caching system for properties
    Strip comments from headers
    Move functions around in patches
    Remove kernel command line parameters
    Reconcile the race condition on the delete node for policy by
      expanding the policy critical section.

  Address a few comments by Jonathan Corbet around the documentation
    pages for IPE.

  Fix an issue with the initialization of IPE policy with a "-0"
    version, caused by not initializing the hlist entries before
    freeing.

v4:
  Address a concern around IPE's behavior with unknown syntax.
    Specifically, make any unknown syntax a fatal error instead of a
    warning, as suggested by Mickaël Salaün.
  Introduce a new securityfs node, $securityfs/ipe/property_config,
    which provides a listing of what properties are enabled by the
    kernel and their versions. This allows usermode to predict what
    policies should be allowed.
  Strip some comments from c files that I missed.
  Clarify some documentation comments around 'boot_verified'.
    While this currently does not functionally change the property
    itself, the distinction is important when IPE can enforce verified
    reads. Additionally, 'KERNEL_READ' was omitted from the documentation.
    This has been corrected.
  Change SecurityFS and SHA1 to a reverse dependency.
  Update the cover-letter with the updated behavior of unknown syntax.
  Remove all sysctls, making an equivalent function in securityfs.
  Rework the active/delete mechanism to be a node under the policy in
    $securityfs/ipe/policies.
  The kernel command line parameters ipe.enforce and ipe.success_audit
    have returned as this functionality is no longer exposed through
    sysfs.

v5:
  Correct some grammatical errors reported by Randy Dunlap.
  Fix some warnings reported by kernel test bot.
  Change convention around security_bdev_setsecurity. -ENOSYS
    is now expected if an LSM does not implement a particular @name,
    as suggested by Casey Schaufler.
  Minor string corrections related to the move from sysfs to securityfs
  Correct a spelling of an #ifdef for the permissive argument.
  Add the kernel parameters re-added to the documentation.
  Fix a minor bug where the mode being audited on permissive switch
    was the original mode, not the mode being swapped to.
  Cleanup doc comments, fix some whitespace alignment issues.

v6:
  Change if statement condition in security_bdev_setsecurity to be
    more concise, as suggested by Casey Schaufler and Al Viro
  Drop the 6th patch in the series, "dm-verity move signature check..."
    due to numerous issues, and it ultimately providing no real value.
  Fix the patch tree - the previous iteration appears to have been in a
    torn state (patches 8+9 were merged). This has since been corrected.

v7:
  * Reword cover letter to more accurate convey IPE's purpose
    and latest updates.
  * Refactor series to:
      1. Support a context structure, enabling:
          1. Easier Testing via KUNIT
          2. A better architecture for future designs
      2. Make parser code cleaner
  * Move patch 01/12 to [14/16] of the series
  * Split up patch 02/12 into four parts:
      1. context creation [01/16]
      2. audit [07/16]
      3. evaluation loop [03/16]
      4. access control hooks [05/16]
      5. permissive mode [08/16]
  * Split up patch 03/12 into two parts:
      1. parser [02/16]
      2. userspace interface [04/16]
  * Reword and refactor patch 04/12 to [09/16]
  * Squash patch 05/12, 07/12, 09/12 to [10/16]
  * Squash patch 08/12, 10/12 to [11/16]
  * Change audit records to MAC region (14XX) from Integrity region (18XX)
  * Add FSVerity Support
  * Interface changes:
      1. "raw" was renamed to "pkcs7" and made read only
      2. "raw"'s write functionality (update a policy) moved to "update"
      3. introduced "version", "policy_name" nodes.
      4. "content" renamed to "policy"
      5. The boot policy can now be updated like any other policy.
  * Add additional developer-level documentation
  * Update admin-guide docs to reflect changes.
  * Kunit tests
  * Dropped CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH - functionality can
    easily come later with a small patch.
  * Use partition0 for block_device for dm-verity patch

v8:
  * Add changelog information to individual commits
  * A large number of changes to the audit patch.
  * split fs/ & security/ changes to two separate patches.
  * split block/, security/ & drivers/md/ changes to separate patches.
  * Add some historical context to what lead to the creation of IPE
    in the documentation patch.
  * Cover-letter changes suggested by Roberto Sassu.

v9:
  * Rewrite IPE parser to use kernel match_table parser.
  * Adapt existing IPE properties to the new parser.
  * Remove ipe_context, quote policy syntax, kernel_read for simplicity.
  * Add new function in the security file system to delete IPE policy.
  * Make IPE audit builtin and change several audit formats.
  * Make boot_verified property builtin

v10:
  * Address various code style/format issues
  * Correct the rcu locking for active policy
  * Fix memleak bugs in the parser, optimize the parser per upstream feedback
  * Adding new audit events for IPE and update audit formats
  * Make the dmverity property auto selected
  * Adding more context in the commit messages

v11:
  * Address various code style/format issues
  * Add finalize hook to device mapper
  * move the security hook for dm-verity to the new device mapper finalize hook

v12:
  * Address locking issues
  * Change the implementation of boot_verified to trust initramfs only
  * Update audit format for IPE decision events
  * Refactor code for lsm_id
  * Add IPE test suite link

v13:
  * Rename the new security hook in initramfs
  * Make the policy grammar independent of kernel config
  * Correct IPE audit format
  * Refactor policy update code

v14:
  * Add more code comments/docs for dmverity/fsverity
  * Fix incorrect code usage and format in dmverity
  * Drop one accepted commit of dmverity

Deven Bowers (13):
  security: add ipe lsm
  ipe: add policy parser
  ipe: add evaluation loop
  ipe: add LSM hooks on execution and kernel read
  ipe: add userspace interface
  uapi|audit|ipe: add ipe auditing support
  ipe: add permissive toggle
  block|security: add LSM blob to block_device
  dm verity: consume root hash digest and signature data via LSM hook
  ipe: add support for dm-verity as a trust provider
  scripts: add boot policy generation program
  ipe: kunit test for parser
  documentation: add ipe documentation

Fan Wu (6):
  initramfs|security: Add a security hook to do_populate_rootfs()
  ipe: introduce 'boot_verified' as a trust provider
  security: add new securityfs delete function
  dm: add finalize hook to target_type
  fsverity: consume builtin signature via LSM hook
  ipe: enable support for fs-verity as a trust provider

 Documentation/admin-guide/LSM/index.rst       |   1 +
 Documentation/admin-guide/LSM/ipe.rst         | 761 ++++++++++++++++++
 .../admin-guide/kernel-parameters.txt         |  12 +
 Documentation/filesystems/fsverity.rst        |   4 +-
 Documentation/security/index.rst              |   1 +
 Documentation/security/ipe.rst                | 444 ++++++++++
 MAINTAINERS                                   |  10 +
 block/bdev.c                                  |   7 +
 drivers/md/dm-verity-target.c                 |  74 ++
 drivers/md/dm-verity.h                        |   6 +
 drivers/md/dm.c                               |  12 +
 fs/verity/fsverity_private.h                  |   2 +-
 fs/verity/open.c                              |  26 +-
 fs/verity/signature.c                         |   4 +-
 include/linux/blk_types.h                     |   3 +
 include/linux/device-mapper.h                 |   9 +
 include/linux/dm-verity.h                     |  19 +
 include/linux/fsverity.h                      |   2 +
 include/linux/lsm_hook_defs.h                 |   7 +
 include/linux/lsm_hooks.h                     |   1 +
 include/linux/security.h                      |  31 +
 include/uapi/linux/audit.h                    |   3 +
 include/uapi/linux/lsm.h                      |   1 +
 init/initramfs.c                              |   3 +
 scripts/Makefile                              |   1 +
 scripts/ipe/Makefile                          |   2 +
 scripts/ipe/polgen/.gitignore                 |   2 +
 scripts/ipe/polgen/Makefile                   |   5 +
 scripts/ipe/polgen/polgen.c                   | 145 ++++
 security/Kconfig                              |  11 +-
 security/Makefile                             |   1 +
 security/inode.c                              |  25 +
 security/ipe/.gitignore                       |   2 +
 security/ipe/Kconfig                          |  75 ++
 security/ipe/Makefile                         |  31 +
 security/ipe/audit.c                          | 279 +++++++
 security/ipe/audit.h                          |  19 +
 security/ipe/digest.c                         | 120 +++
 security/ipe/digest.h                         |  26 +
 security/ipe/eval.c                           | 375 +++++++++
 security/ipe/eval.h                           |  64 ++
 security/ipe/fs.c                             | 247 ++++++
 security/ipe/fs.h                             |  16 +
 security/ipe/hooks.c                          | 286 +++++++
 security/ipe/hooks.h                          |  53 ++
 security/ipe/ipe.c                            |  98 +++
 security/ipe/ipe.h                            |  26 +
 security/ipe/policy.c                         | 229 ++++++
 security/ipe/policy.h                         |  98 +++
 security/ipe/policy_fs.c                      | 468 +++++++++++
 security/ipe/policy_parser.c                  | 548 +++++++++++++
 security/ipe/policy_parser.h                  |  11 +
 security/ipe/policy_tests.c                   | 294 +++++++
 security/security.c                           | 112 ++-
 54 files changed, 5102 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/ipe.rst
 create mode 100644 Documentation/security/ipe.rst
 create mode 100644 include/linux/dm-verity.h
 create mode 100644 scripts/ipe/Makefile
 create mode 100644 scripts/ipe/polgen/.gitignore
 create mode 100644 scripts/ipe/polgen/Makefile
 create mode 100644 scripts/ipe/polgen/polgen.c
 create mode 100644 security/ipe/.gitignore
 create mode 100644 security/ipe/Kconfig
 create mode 100644 security/ipe/Makefile
 create mode 100644 security/ipe/audit.c
 create mode 100644 security/ipe/audit.h
 create mode 100644 security/ipe/digest.c
 create mode 100644 security/ipe/digest.h
 create mode 100644 security/ipe/eval.c
 create mode 100644 security/ipe/eval.h
 create mode 100644 security/ipe/fs.c
 create mode 100644 security/ipe/fs.h
 create mode 100644 security/ipe/hooks.c
 create mode 100644 security/ipe/hooks.h
 create mode 100644 security/ipe/ipe.c
 create mode 100644 security/ipe/ipe.h
 create mode 100644 security/ipe/policy.c
 create mode 100644 security/ipe/policy.h
 create mode 100644 security/ipe/policy_fs.c
 create mode 100644 security/ipe/policy_parser.c
 create mode 100644 security/ipe/policy_parser.h
 create mode 100644 security/ipe/policy_tests.c

--
2.43.1


