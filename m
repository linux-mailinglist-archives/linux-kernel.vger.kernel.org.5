Return-Path: <linux-kernel+bounces-143477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F988A39F7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAA9284BFE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA56D1D8;
	Sat, 13 Apr 2024 00:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Tcz746cu"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F314B1B978;
	Sat, 13 Apr 2024 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969773; cv=none; b=X/lL2hNCF73jVlvHfHKeTm1khh8lFOk30KIcrd3Oz0VN6zmPrMlFJYEsoTLPCVyQAS2nTAyhUiBYmgKcpaAKX2hSt4bAFCVB9ld684F3XwRC+DOi786OPjmy6cUO7sFYfGHiyIxvCgG6SuePtSXLLjLpgU4CrHGmQugq/haKXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969773; c=relaxed/simple;
	bh=QMznBQE7oyJQFYjL09OHjij3GoXneRiLsv5SZfImH7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fSK1GKwiL3WzrcpnUKWczTQxz6+d4+AyxrrNMJlaWNNbhASoTw7mqoTdmAquEZrGvC8N2huL3Qpi1vETGVC5WIKB2dCj59UVESFK8NXMLRr2TpXkR/EhTuyZqa07YSZ9gMVW7jbsXkselTJlpyGJE4tSJ9pgy+p4QWb9Eq9rZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Tcz746cu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 6659F20FC5F2; Fri, 12 Apr 2024 17:56:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6659F20FC5F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712969766;
	bh=i0QxcQperO3WcXX66bzTWacqGnj904SxCZMw/Ni9WmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tcz746cucHaVy4tXYOFhvxaB+w6ibuaspBuQMrxShyIQLClp7a7BwJSULCuGA4RUj
	 B/ZlcdMgknZDh6wkVxqmdKInMRNlDmv8RJnMSQKF7UjdOGP13F030e0xdcYDtaD7Jw
	 FDs3pAAWyU4vs4SqUf04HhaGiIewr6EYQQ/VaXW4=
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
Subject: [PATCH v17 16/21] fsverity: expose verified fsverity built-in signatures to LSMs
Date: Fri, 12 Apr 2024 17:55:59 -0700
Message-Id: <1712969764-31039-17-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
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
could be established to permit the execution of all files with verified
built-in fsverity signatures while restricting kernel module loading
from specified fsverity files via fsverity digets.

The introduction of a security_inode_setintegrity() hook call within
fsverity's workflow ensures that the verified built-in signature of a file
is exposed to LSMs, This enables LSMs to recognize and label fsverity files
that contain a verified built-in fsverity signature. This hook is invoked
subsequent to the fsverity_verify_signature() process, guaranteeing the
signature's verification against fsverity's keyring. This mechanism is
crucial for maintaining system security, as it operates in kernel space,
effectively thwarting attempts by malicious binaries to bypass user space
stack interactions.

The second to last commit in this patch set will add a link to the IPE
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

v17:
  + Fix various documentation issues
  + Use new enum name LSM_INT_FSVERITY_BUILTINSIG_VALID
---
 Documentation/filesystems/fsverity.rst | 23 +++++++++++++++++++++--
 fs/verity/fsverity_private.h           |  2 +-
 fs/verity/open.c                       | 24 +++++++++++++++++++++++-
 fs/verity/signature.c                  |  6 +++++-
 include/linux/security.h               |  1 +
 5 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 13e4b18e5dbb..362b7a5dc300 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -86,6 +86,14 @@ authenticating fs-verity file hashes include:
   signature in their "security.ima" extended attribute, as controlled
   by the IMA policy.  For more information, see the IMA documentation.
 
+- Integrity Policy Enforcement (IPE).  IPE supports enforcing access
+  control decisions based on immutable security properties of files,
+  including those protected by fs-verity's built-in signatures.
+  "IPE policy" specifically allows for the authorization of fs-verity
+  files using properties ``fsverity_digest`` for identifying
+  files by their verity digest, and ``fsverity_signature`` to authorize
+  files with a verified fs-verity's built-in signature.
+
 - Trusted userspace code in combination with `Built-in signature
   verification`_.  This approach should be used only with great care.
 
@@ -457,7 +465,11 @@ Enabling this option adds the following:
    On success, the ioctl persists the signature alongside the Merkle
    tree.  Then, any time the file is opened, the kernel verifies the
    file's actual digest against this signature, using the certificates
-   in the ".fs-verity" keyring.
+   in the ".fs-verity" keyring. This verification happens as long as the
+   file's signature exists, regardless of the state of the sysctl variable
+   "fs.verity.require_signatures" described in the next item. The IPE LSM
+   relies on this behavior to recognize and label fsverity files
+   that contain a verified built-in fsverity signature.
 
 3. A new sysctl "fs.verity.require_signatures" is made available.
    When set to 1, the kernel requires that all verity files have a
@@ -481,7 +493,7 @@ be carefully considered before using them:
 
 - Builtin signature verification does *not* make the kernel enforce
   that any files actually have fs-verity enabled.  Thus, it is not a
-  complete authentication policy.  Currently, if it is used, the only
+  complete authentication policy.  Currently, if it is used, one
   way to complete the authentication policy is for trusted userspace
   code to explicitly check whether files have fs-verity enabled with a
   signature before they are accessed.  (With
@@ -490,6 +502,13 @@ be carefully considered before using them:
   could just store the signature alongside the file and verify it
   itself using a cryptographic library, instead of using this feature.
 
+- Another approach is to utilize fs-verity builtin signature
+  verification in conjunction with the IPE LSM, which supports defining
+  a kernel-enforced, system-wide authentication policy that allows only
+  files with a verified fs-verity builtin signature to perform certain
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
index fdeb95eca3af..e04fffa6b274 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -8,6 +8,7 @@
 #include "fsverity_private.h"
 
 #include <linux/mm.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 
 static struct kmem_cache *fsverity_info_cachep;
@@ -172,12 +173,29 @@ static int compute_file_digest(const struct fsverity_hash_alg *hash_alg,
 	return err;
 }
 
+#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
+static int fsverity_inode_setintegrity(struct inode *inode,
+				       const struct fsverity_descriptor *desc)
+{
+	return security_inode_setintegrity(inode,
+					   LSM_INT_FSVERITY_BUILTINSIG_VALID,
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
@@ -241,6 +259,10 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
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
index 703762b0c4ad..2d6752333d6f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -86,6 +86,7 @@ enum lsm_event {
 enum lsm_integrity_type {
 	LSM_INT_DMVERITY_SIG_VALID,
 	LSM_INT_DMVERITY_ROOTHASH,
+	LSM_INT_FSVERITY_BUILTINSIG_VALID,
 };
 
 /*
-- 
2.44.0


