Return-Path: <linux-kernel+bounces-109643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E870881BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A542BB219BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32189C2FD;
	Thu, 21 Mar 2024 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvvwy3Vc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC04BA56;
	Thu, 21 Mar 2024 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994270; cv=none; b=fC/tnOq4kREYLEsjoIS8/cnWiPIxnzVBKxuL4ny6oQrKOzjuE+91rETViIkQ+ehd/7Cb72vVdla7Pit7yxkTO0L66lbjySNRDnVrAhpYpzWbUxUPDIAA4G5wuCc1WHrmcdv0Maw2NEJPnydncDADcQa0q1GboNy91BJEuqwG/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994270; c=relaxed/simple;
	bh=nUhN6swPTdLBPcD6e634txdLP2fFPv5dfLhySEmjXMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j0NR/ee31ShhCOQcKTFpaBiVLuQh2NXUNDESn0ppA8GHMoKeYOzcl2UVotTQnsXr7PbSANiM5mvIz1jg4pg6+kGWj8RJHU+pHVaquF50XT2y+3ZfvOE3z9+dJalYw0TlvFYLcdP8Cgg6Lnu79y4IZ9+NFZ0r7yj++RKFvQKV2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvvwy3Vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9F7C433C7;
	Thu, 21 Mar 2024 04:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710994269;
	bh=nUhN6swPTdLBPcD6e634txdLP2fFPv5dfLhySEmjXMQ=;
	h=Date:From:To:Cc:Subject:From;
	b=qvvwy3VcQ2w5PhNPSt/CZb0+WNKfNTTnrpzo3UPN776f7WuJe7SYMHaSZR6svGYJa
	 biYTZmPzYGqciKCxdG+oQLx0TK3cgFTvJxGxiSJJZuh8HT6UtXZ6SkEgEjctPkQdNk
	 +cVgwXCxFmX50dkJOW8wK2u3l64W3e86q7IcDA5JqOIw+DXnDoV1iglfmpTFkBYK5y
	 86fW3iHCqF+pm7kptxh1T9eGWVtQY8GikA5qFjrG+W30oXmyU4Rz4lGyo4cKmxT+H3
	 lYvFh3jB6EJqQEYxfhYDEkQZvUTNT6dEt2q+8ctNLUHyceaYdFTcBtuYS3l7a6xRie
	 7Lmr4v6BdjwyA==
Date: Wed, 20 Mar 2024 22:11:06 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] integrity: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZfuzWku+ip4fsZrb@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

There is currently an object (`hdr)` in `struct ima_max_digest_data`
that contains a flexible structure (`struct ima_digest_data`):

 struct ima_max_digest_data {
	struct ima_digest_data hdr;
        u8 digest[HASH_MAX_DIGESTSIZE];
 } __packed;

So, in order to avoid ending up with a flexible-array member in the
middle of a struct, we use the `__struct_group()` helper to separate
the flexible array from the rest of the members in the flexible
structure:

struct ima_digest_data {
        __struct_group(ima_digest_data_hdr, hdr, __packed,

	... the rest of the members

        );
        u8 digest[];
} __packed;

With the change described above, we can now declare an object of the
type of the tagged `struct ima_digest_data_hdr`, without embedding the
flexible array in the middle of another struct:

 struct ima_max_digest_data {
        struct ima_digest_data_hdr hdr;
        u8 digest[HASH_MAX_DIGESTSIZE];
 } __packed;

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure.

So, with these changes, fix the following warnings:

security/integrity/evm/evm.h:45:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
security/integrity/evm/evm.h:45:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
security/integrity/evm/evm.h:45:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - struct ima_digest_data is a packed structure. So, to keep things
   consistent, use the attribute __packed on the tagged struct 
   ima_digest_data_hdr. For this, we use __struct_group() instead of
   struct_group_tagged(). Update the changelog text, accordingly.

Changes in v2:
 - Include changes for `struct evm_digest` (Mimi Zohar)
 

 security/integrity/evm/evm.h              |  2 +-
 security/integrity/ima/ima_api.c          |  6 ++++--
 security/integrity/ima/ima_appraise.c     |  4 +++-
 security/integrity/ima/ima_init.c         |  6 ++++--
 security/integrity/ima/ima_main.c         |  6 ++++--
 security/integrity/ima/ima_template_lib.c | 10 ++++++----
 security/integrity/integrity.h            |  4 +++-
 7 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index eb1a2c343bd7..72e3341ae6f7 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -61,7 +61,7 @@ extern int evm_hmac_attrs;
 extern struct list_head evm_config_xattrnames;
 
 struct evm_digest {
-	struct ima_digest_data hdr;
+	struct ima_digest_data_hdr hdr;
 	char digest[IMA_MAX_DIGEST_SIZE];
 } __packed;
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index b37d043d5748..c7c8d1bffb17 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -247,6 +247,8 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	struct inode *real_inode = d_real_inode(file_dentry(file));
 	const char *filename = file->f_path.dentry->d_name.name;
 	struct ima_max_digest_data hash;
+	struct ima_digest_data *hash_hdr = container_of(&hash.hdr,
+						struct ima_digest_data, hdr);
 	struct kstat stat;
 	int result = 0;
 	int length;
@@ -286,9 +288,9 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 			result = -ENODATA;
 		}
 	} else if (buf) {
-		result = ima_calc_buffer_hash(buf, size, &hash.hdr);
+		result = ima_calc_buffer_hash(buf, size, hash_hdr);
 	} else {
-		result = ima_calc_file_hash(file, &hash.hdr);
+		result = ima_calc_file_hash(file, hash_hdr);
 	}
 
 	if (result && result != -EBADF && result != -EINVAL)
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 3497741caea9..656c709b974f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -378,7 +378,9 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 		}
 
 		rc = calc_file_id_hash(IMA_VERITY_DIGSIG, iint->ima_hash->algo,
-				       iint->ima_hash->digest, &hash.hdr);
+				       iint->ima_hash->digest,
+				       container_of(&hash.hdr,
+					       struct ima_digest_data, hdr));
 		if (rc) {
 			*cause = "sigv3-hashing-error";
 			*status = INTEGRITY_FAIL;
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 393f5c7912d5..4e208239a40e 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -48,12 +48,14 @@ static int __init ima_add_boot_aggregate(void)
 	struct ima_event_data event_data = { .iint = iint,
 					     .filename = boot_aggregate_name };
 	struct ima_max_digest_data hash;
+	struct ima_digest_data *hash_hdr = container_of(&hash.hdr,
+						struct ima_digest_data, hdr);
 	int result = -ENOMEM;
 	int violation = 0;
 
 	memset(iint, 0, sizeof(*iint));
 	memset(&hash, 0, sizeof(hash));
-	iint->ima_hash = &hash.hdr;
+	iint->ima_hash = hash_hdr;
 	iint->ima_hash->algo = ima_hash_algo;
 	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
 
@@ -70,7 +72,7 @@ static int __init ima_add_boot_aggregate(void)
 	 * is not found.
 	 */
 	if (ima_tpm_chip) {
-		result = ima_calc_boot_aggregate(&hash.hdr);
+		result = ima_calc_boot_aggregate(hash_hdr);
 		if (result < 0) {
 			audit_cause = "hashing_error";
 			goto err_out;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c84e8c55333d..0d3a7c864fd4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -941,6 +941,8 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 					    .buf_len = size};
 	struct ima_template_desc *template;
 	struct ima_max_digest_data hash;
+	struct ima_digest_data *hash_hdr = container_of(&hash.hdr,
+						struct ima_digest_data, hdr);
 	char digest_hash[IMA_MAX_DIGEST_SIZE];
 	int digest_hash_len = hash_digest_size[ima_hash_algo];
 	int violation = 0;
@@ -979,7 +981,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	if (!pcr)
 		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 
-	iint.ima_hash = &hash.hdr;
+	iint.ima_hash = hash_hdr;
 	iint.ima_hash->algo = ima_hash_algo;
 	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
 
@@ -990,7 +992,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
 	}
 
 	if (buf_hash) {
-		memcpy(digest_hash, hash.hdr.digest, digest_hash_len);
+		memcpy(digest_hash, hash_hdr->digest, digest_hash_len);
 
 		ret = ima_calc_buffer_hash(digest_hash, digest_hash_len,
 					   iint.ima_hash);
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 6cd0add524cd..74198d7619da 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -339,6 +339,8 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 			 struct ima_field_data *field_data)
 {
 	struct ima_max_digest_data hash;
+	struct ima_digest_data *hash_hdr = container_of(&hash.hdr,
+						struct ima_digest_data, hdr);
 	u8 *cur_digest = NULL;
 	u32 cur_digestsize = 0;
 	struct inode *inode;
@@ -358,7 +360,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 	if ((const char *)event_data->filename == boot_aggregate_name) {
 		if (ima_tpm_chip) {
 			hash.hdr.algo = HASH_ALGO_SHA1;
-			result = ima_calc_boot_aggregate(&hash.hdr);
+			result = ima_calc_boot_aggregate(hash_hdr);
 
 			/* algo can change depending on available PCR banks */
 			if (!result && hash.hdr.algo != HASH_ALGO_SHA1)
@@ -368,7 +370,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 				memset(&hash, 0, sizeof(hash));
 		}
 
-		cur_digest = hash.hdr.digest;
+		cur_digest = hash_hdr->digest;
 		cur_digestsize = hash_digest_size[HASH_ALGO_SHA1];
 		goto out;
 	}
@@ -379,14 +381,14 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 	inode = file_inode(event_data->file);
 	hash.hdr.algo = ima_template_hash_algo_allowed(ima_hash_algo) ?
 	    ima_hash_algo : HASH_ALGO_SHA1;
-	result = ima_calc_file_hash(event_data->file, &hash.hdr);
+	result = ima_calc_file_hash(event_data->file, hash_hdr);
 	if (result) {
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
 				    event_data->filename, "collect_data",
 				    "failed", result, 0);
 		return result;
 	}
-	cur_digest = hash.hdr.digest;
+	cur_digest = hash_hdr->digest;
 	cur_digestsize = hash.hdr.length;
 out:
 	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 50d6f798e613..3847a23509f1 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -44,6 +44,7 @@ struct evm_xattr {
 #define IMA_MAX_DIGEST_SIZE	HASH_MAX_DIGESTSIZE
 
 struct ima_digest_data {
+	__struct_group(ima_digest_data_hdr, hdr, __packed,
 	u8 algo;
 	u8 length;
 	union {
@@ -57,6 +58,7 @@ struct ima_digest_data {
 		} ng;
 		u8 data[2];
 	} xattr;
+	);
 	u8 digest[];
 } __packed;
 
@@ -65,7 +67,7 @@ struct ima_digest_data {
  * with the maximum hash size, define ima_max_digest_data struct.
  */
 struct ima_max_digest_data {
-	struct ima_digest_data hdr;
+	struct ima_digest_data_hdr hdr;
 	u8 digest[HASH_MAX_DIGESTSIZE];
 } __packed;
 
-- 
2.34.1


