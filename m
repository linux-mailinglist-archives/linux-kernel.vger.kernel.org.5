Return-Path: <linux-kernel+bounces-105060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A287D8A8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90ACB1C20E96
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484055B688;
	Sat, 16 Mar 2024 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a9xkYM03"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6DF134C6;
	Sat, 16 Mar 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710560162; cv=none; b=qlrGHhOXpHgG87S3noZe8zjLeZMYQdV5SU6bg4G0zYSKrWJh0XOO71U3JeTx8O6zkHv2pZzg6pOZmuDVx65oy8meBUzqX6IqIT4lZ5O9G011wyByiWam9PKqKMCVMdlWnxK4viZfjzscPh3wQ108GlX2Y2qWF64NOoxtmVl/eek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710560162; c=relaxed/simple;
	bh=uK/EA2cXyBycboD2hrHoBRROvmIomyU/pCR7WkDNDDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eRvWfx2O6SuJJNOK5TzyKB484n7besHDDh8GtVfgW+Ls4XU8/G+N04elhqND6i6QysbpvdjfUedqsc2e/TtU3SXJeXWE461D0l4Q7+AsNqf4hVyhmOayvXk8SDDjXpnmS1uhr77xKWjHa3HLe7XKpTMduPAeyg8ASppm8HTqYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a9xkYM03; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 2EDA820B74E0; Fri, 15 Mar 2024 20:35:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EDA820B74E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710560154;
	bh=VNGz5nXopP0RSlhdBYgrpXruCqTRfJFRYB1CgjMzYFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9xkYM03eS+wedP/JR3KQYY4wnoP448zmay3EzYliKtVNiqEeIufC3VcveQ3l7IGD
	 KKlnSjBQkdwr/G0fL6XFkuCvOaTes/vcpcsLN2hzOo5JDJhTwKN9gEvAB4p3qiWwDr
	 IvBj+6i/xkT8LoOgrp3VO1j6+7cF45TaoNHGNNlc=
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
Subject: [RFC PATCH v15 17/21] fsverity: consume builtin signature via LSM hook
Date: Fri, 15 Mar 2024 20:35:47 -0700
Message-Id: <1710560151-28904-18-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

fsverity represents a mechanism to support both integrity and
authenticity protection of a file, supporting both signed and unsigned
digests.

An LSM which controls access to a resource based on authenticity and
integrity of said resource, can then use this data to make an informed
decision on the authorization (provided by the LSM's policy) of said
claim.

This effectively allows the extension of a policy enforcement layer in
LSM for fsverity, allowing for more granular control of how a
particular authenticity claim can be used. For example, "all (built-in)
signed fsverity files should be allowed to execute, but only these
hashes are allowed to be loaded as kernel modules".

This enforcement must be done in kernel space, as a userspace only
solution would fail a simple litmus test: Download a self-contained
malicious binary that never touches the userspace stack. This
binary would still be able to execute.

This patch introduces a new security_inode_setintegrity() hook call in
fsverity to store the verified fsverity signature in the inode's LSM blobs.
The hook call is executed after fsverity_verify_signature(), ensuring that
the signature is verified against fsverity's keyring.

The last commit in this patch set will add a link to the IPE documentation in
fsverity.rst.

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
---
 Documentation/filesystems/fsverity.rst | 12 ++++++++++--
 fs/verity/fsverity_private.h           |  2 +-
 fs/verity/open.c                       | 24 +++++++++++++++++++++++-
 fs/verity/signature.c                  |  5 ++++-
 include/linux/security.h               |  1 +
 5 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 13e4b18e5dbb..708c79631f32 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -461,7 +461,10 @@ Enabling this option adds the following:
 
 3. A new sysctl "fs.verity.require_signatures" is made available.
    When set to 1, the kernel requires that all verity files have a
-   correctly signed digest as described in (2).
+   correctly signed digest as described in (2). Note that verification
+   happens as long as the file's signature exists regardless of the state of
+   "fs.verity.require_signatures", and the IPE LSM relies on this behavior
+   to save verified signature into LSM blobs.
 
 The data that the signature as described in (2) must be a signature of
 is the fs-verity file digest in the following format::
@@ -481,7 +484,7 @@ be carefully considered before using them:
 
 - Builtin signature verification does *not* make the kernel enforce
   that any files actually have fs-verity enabled.  Thus, it is not a
-  complete authentication policy.  Currently, if it is used, the only
+  complete authentication policy.  Currently, if it is used, one
   way to complete the authentication policy is for trusted userspace
   code to explicitly check whether files have fs-verity enabled with a
   signature before they are accessed.  (With
@@ -489,6 +492,11 @@ be carefully considered before using them:
   enabled suffices.)  But, in this case the trusted userspace code
   could just store the signature alongside the file and verify it
   itself using a cryptographic library, instead of using this feature.
+  Another approach is to utilize built-in signature verification in
+  conjunction with the IPE LSM, which supports defining
+  a kernel-enforced, system-wide authentication policy that allows only
+  files with an fs-verity signature enabled to perform certain operations,
+  such as execution. Note that IPE doesn't require fs.verity.require_signatures=1.
 
 - A file's builtin signature can only be set at the same time that
   fs-verity is being enabled on the file.  Changing or deleting the
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
index fdeb95eca3af..8ad9cb5d6666 100644
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
+	return security_inode_setintegrity(inode, LSM_INTGR_FSV_SIG,
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
@@ -241,6 +258,11 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 		}
 	}
 
+	err = fsverity_inode_setintegrity(inode, desc);
+
+	if (err)
+		goto fail;
+
 	return vi;
 
 fail:
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index 90c07573dd77..d4ed03a114e9 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -41,7 +41,10 @@ static struct key *fsverity_keyring;
  * @sig_size: size of signature in bytes, or 0 if no signature
  *
  * If the file includes a signature of its fs-verity file digest, verify it
- * against the certificates in the fs-verity keyring.
+ * against the certificates in the fs-verity keyring. Note that verification
+ * happens as long as the file's signature exists regardless of the state of
+ * fsverity_require_signatures, and the IPE LSM relies on this behavior
+ * to save the verified file signature of the file into security blobs.
  *
  * Return: 0 on success (signature valid or not required); -errno on failure
  */
diff --git a/include/linux/security.h b/include/linux/security.h
index 0885866b261e..edd12c0a673a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -86,6 +86,7 @@ enum lsm_event {
 enum lsm_intgr_type {
 	LSM_INTGR_DMV_SIG,
 	LSM_INTGR_DMV_ROOTHASH,
+	LSM_INTGR_FSV_SIG,
 	__LSM_INTGR_MAX
 };
 
-- 
2.44.0


