Return-Path: <linux-kernel+bounces-123569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DE2890B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0361F25206
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B26140E23;
	Thu, 28 Mar 2024 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IK9Y1slg"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4078013B293;
	Thu, 28 Mar 2024 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657059; cv=none; b=rqouSV483lXvUntoUBJnKx6ZfB3hbefhQ03fKcQ8D5IWI2uKyLqGHDaSiHsIyZy+FTE1LGaQ51aEg1Zz6El4moCclZKVCLncFMt8fa9nQwk2lwCb9j4yF2zyvwx2RBEvU2id8PDg/swbRLLpULZfmSGnZHHLrxOCHhAvcngzBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657059; c=relaxed/simple;
	bh=caP4bpaKqglPgXav4RnvcwvlAU1cMPCWzAxPUwPGpSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z5OQ+ccbK6LqREKsBlDPRjCX2TYkwesWF/t1SDkGmZrYdN4Quk+UGwn+t4zXNzICeu97ONmov8m4FERJ91Nud0Nq6tFOH78VLARguNk72/F9w+3LlKtXslZt9GawqS0uMqvfQY0fximkW7FLe2nES2xn5Uy5gaf23Yhz5QXRImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IK9Y1slg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 5304220E6F69; Thu, 28 Mar 2024 13:17:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5304220E6F69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711657049;
	bh=8jmgwxISKaQSGukG4xV/5fVhVS212zhpvhSeVEXEd2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IK9Y1slgBmokI2f3UVzZkhK/23aPhXaXE3iPqSYv9vDAukYYOcO98lkchmsdhYPHF
	 i+6UalvN1pBqR11v9cnt4ssYcsGV23YMVFfygE417xmT/BPSruGgPGTdFM4OT++nOF
	 1lq+CpoMXaeTu1YOpfz8Px9ccflDXZoIAzeknLxs=
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
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: [PATCH v16 16/20] fsverity: consume fsverity built-in signatures via LSM hook
Date: Thu, 28 Mar 2024 13:17:23 -0700
Message-Id: <1711657047-10526-17-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch enhances fsverity's capabilities to support both integrity and
authenticity protection by introducing the consumption of built-in
signatures through a new LSM hook. This functionality allows LSMs,
e.g. IPE, to enforce policies based on the authenticity and integrity of
files, specifically focusing on built-in fsverity signatures. It enables
a policy enforcement layer within LSMs for fsverity, offering granular
control over the usage of authenticity claims. For instance, a policy
could be established to permit the execution of all files with built-in
fsverity signatures while restricting kernel module loading to specified
hashes.

The introduction of a security_inode_setintegrity() hook call within
fsverity's workflow ensures that the verified built-in signature of a file
is stored in the inode's LSM blobs. This hook is invoked subsequent to
the fsverity_verify_signature() process, guaranteeing the signature's
verification against fsverity's keyring. This mechanism is crucial for
maintaining system security, as it operates in kernel space, effectively
thwarting attempts by malicious binaries to bypass user space stack
interactions.

The last commit in this patch set will add a link to the IPE
documentation in fsverity.rst.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v1-v6:
  + Not present

v7:
  Introduced

v8:
  + Split fs/verity/ changes and security/ changes into separate patches
  + Change signature of fsverity_create_info to accept non-const inode
  + Change signature of fsverity_verify_signature to accept non-const inode
  + Don't cast-away const from inode.
  + Digest functionality dropped in favor of:
    ("fs-verity: define a function to return the integrity protected
      file digest")
  + Reworded commit description and title to match changes.
  + Fix a bug wherein no LSM implements the particular fsverity @name
    (or LSM is disabled), and returns -EOPNOTSUPP, causing errors.

v9:
  + No changes

v10:
  + Rename the signature blob key
  + Cleanup redundant code
  + Make the hook call depends on CONFIG_FS_VERITY_BUILTIN_SIGNATURES

v11:
  + No changes

v12:
  + Add constification to the hook call

v13:
  + No changes

v14:
  + Add doc/comment to built-in signature verification

v15:
  + Add more docs related to IPE
  + Switch the hook call to security_inode_setintegrity()

v16:
  + Explicitly mention "fsverity builtin signatures" in the commit
    message
  + Amend documentation in fsverity.rst
  + Fix format issue
  + Change enum name
---
 Documentation/filesystems/fsverity.rst | 27 ++++++++++++++++++++++++--
 fs/verity/fsverity_private.h           |  2 +-
 fs/verity/open.c                       | 23 +++++++++++++++++++++-
 fs/verity/signature.c                  |  6 +++++-
 include/linux/security.h               |  1 +
 5 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 13e4b18e5dbb..e13cf10211c8 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -86,6 +86,19 @@ authenticating fs-verity file hashes include:
   signature in their "security.ima" extended attribute, as controlled
   by the IMA policy.  For more information, see the IMA documentation.
 
+- Integrity Policy Enforcement (IPE).  IPE supports enforcing access
+  control decisions based on immutable security properties of files,
+  including those protected by fs-verity's built-in signatures.
+  "IPE policy" specifically allows for the authorization of fs-verity
+  files using properties such as ``fsverity_digest`` for identifying
+  files by their verity digest, and ``fsverity_signature`` to validate
+  files signed with fs-verity's built-in signature mechanism. This
+  integration enhances security by ensuring the integrity and
+  authenticity of files on a per-file basis, leveraging fs-verity's
+  robust protection capabilities in conjunction with IPE's policy-driven
+  access control. For details on configuring IPE policies and
+  understanding its operational modes, see the IPE documentation.
+
 - Trusted userspace code in combination with `Built-in signature
   verification`_.  This approach should be used only with great care.
 
@@ -457,7 +470,10 @@ Enabling this option adds the following:
    On success, the ioctl persists the signature alongside the Merkle
    tree.  Then, any time the file is opened, the kernel verifies the
    file's actual digest against this signature, using the certificates
-   in the ".fs-verity" keyring.
+   in the ".fs-verity" keyring. This verification happens as long as the
+   file's signature exists, regardless of the state of the sysctl variable
+   "fs.verity.require_signatures" described in the next item. The IPE LSM
+   relies on this behavior to save verified signatures into LSM blobs.
 
 3. A new sysctl "fs.verity.require_signatures" is made available.
    When set to 1, the kernel requires that all verity files have a
@@ -481,7 +497,7 @@ be carefully considered before using them:
 
 - Builtin signature verification does *not* make the kernel enforce
   that any files actually have fs-verity enabled.  Thus, it is not a
-  complete authentication policy.  Currently, if it is used, the only
+  complete authentication policy.  Currently, if it is used, one
   way to complete the authentication policy is for trusted userspace
   code to explicitly check whether files have fs-verity enabled with a
   signature before they are accessed.  (With
@@ -490,6 +506,13 @@ be carefully considered before using them:
   could just store the signature alongside the file and verify it
   itself using a cryptographic library, instead of using this feature.
 
+- Another approach is to utilize fs-verity builtin signature
+  verification in conjunction with the IPE LSM, which supports defining
+  a kernel-enforced, system-wide authentication policy that allows only
+  files with an fs-verity builtin signature enabled to perform certain
+  operations, such as execution. Note that IPE doesn't require
+  fs.verity.require_signatures=1.
+
 - A file's builtin signature can only be set at the same time that
   fs-verity is being enabled on the file.  Changing or deleting the
   builtin signature later requires re-creating the file.
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index b3506f56e180..a0e786c611c9 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -117,7 +117,7 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 				     unsigned int log_blocksize,
 				     const u8 *salt, size_t salt_size);
 
-struct fsverity_info *fsverity_create_info(const struct inode *inode,
+struct fsverity_info *fsverity_create_info(struct inode *inode,
 					   struct fsverity_descriptor *desc);
 
 void fsverity_set_info(struct inode *inode, struct fsverity_info *vi);
diff --git a/fs/verity/open.c b/fs/verity/open.c
index fdeb95eca3af..dfe66b60b4ec 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -8,6 +8,7 @@
 #include "fsverity_private.h"
 
 #include <linux/mm.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 
 static struct kmem_cache *fsverity_info_cachep;
@@ -172,12 +173,28 @@ static int compute_file_digest(const struct fsverity_hash_alg *hash_alg,
 	return err;
 }
 
+#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
+static int fsverity_inode_setintegrity(struct inode *inode,
+				       const struct fsverity_descriptor *desc)
+{
+	return security_inode_setintegrity(inode, LSM_INT_FSVERITY_BUILTINSIG,
+					   desc->signature,
+					   le32_to_cpu(desc->sig_size));
+}
+#else
+static inline int fsverity_inode_setintegrity(struct inode *inode,
+					      const struct fsverity_descriptor *desc)
+{
+	return 0;
+}
+#endif /* CONFIG_FS_VERITY_BUILTIN_SIGNATURES */
+
 /*
  * Create a new fsverity_info from the given fsverity_descriptor (with optional
  * appended builtin signature), and check the signature if present.  The
  * fsverity_descriptor must have already undergone basic validation.
  */
-struct fsverity_info *fsverity_create_info(const struct inode *inode,
+struct fsverity_info *fsverity_create_info(struct inode *inode,
 					   struct fsverity_descriptor *desc)
 {
 	struct fsverity_info *vi;
@@ -241,6 +258,10 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 		}
 	}
 
+	err = fsverity_inode_setintegrity(inode, desc);
+	if (err)
+		goto fail;
+
 	return vi;
 
 fail:
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index 90c07573dd77..fd60e9704e78 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -41,7 +41,11 @@ static struct key *fsverity_keyring;
  * @sig_size: size of signature in bytes, or 0 if no signature
  *
  * If the file includes a signature of its fs-verity file digest, verify it
- * against the certificates in the fs-verity keyring.
+ * against the certificates in the fs-verity keyring. Note that signatures
+ * are verified regardless of the state of the 'fsverity_require_signatures'
+ * variable and the LSM subsystem relies on this behavior to help enforce
+ * file integrity policies. Please discuss changes with the LSM list
+ * (thank you!).
  *
  * Return: 0 on success (signature valid or not required); -errno on failure
  */
diff --git a/include/linux/security.h b/include/linux/security.h
index 22612058b903..3d4ff2c9a430 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -86,6 +86,7 @@ enum lsm_event {
 enum lsm_integrity_type {
 	LSM_INT_DMVERITY_SIG,
 	LSM_INT_DMVERITY_ROOTHASH,
+	LSM_INT_FSVERITY_BUILTINSIG,
 };
 
 /*
-- 
2.44.0


