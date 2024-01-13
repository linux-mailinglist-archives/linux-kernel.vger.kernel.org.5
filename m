Return-Path: <linux-kernel+bounces-25283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81A382CCA0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B0A1F22CF7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCF32135C;
	Sat, 13 Jan 2024 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="rBdODkxM"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3220DF7;
	Sat, 13 Jan 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id E84F740762E4;
	Sat, 13 Jan 2024 12:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E84F740762E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1705148175;
	bh=UXsO+FATYJuTPtjVESRdxfPqcMfgJ+Z5TRk9Ig/cU7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBdODkxMg1L5H2zTmGYLSPw2S0CURDXH1HU32selNRUiQC7bDtQiED74SYYfHrq+G
	 6qL+D97qMSSKzxcWDtVNeZCWKugYZ+eB4jMUvCaDc3TjBixl3RikLhIYO4YlSvIZt6
	 weSxaEwRWSQ3XwZdgAJK0FCQ2VOZhkjGb8zdm3yA=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: John Johansen <john.johansen@canonical.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 2/2] apparmor: fix namespace check in serialized stream headers from the same policy load
Date: Sat, 13 Jan 2024 15:15:52 +0300
Message-ID: <20240113121556.12948-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113121556.12948-1-pchelkin@ispras.ru>
References: <20240113121556.12948-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per commit 04dc715e24d0 ("apparmor: audit policy ns specified in policy
load"), profiles in a single load must specify the same namespace. It is
supposed to be detected inside aa_replace_profiles() and verify_header(),
but seems not to be implemented correctly in the second function.

Consider we have the following profile load

  profile :ns1:profile1 ... {}
  profile :ns2:profile2 ... {}

The profiles specify different policy namespaces but if they are loaded as
a single binary where the serialized stream headers contain different
namespace values, it eventually leads to the profiles specified with
different namespaces be included into the same one without any specific
indication to user.

*ns is assigned NULL in verify_header(), and the branch indicating an
"invalid ns change" message is a dead code.

Moreover, some of *ns strings is leaked as they are allocated every time
verify_header() reads a namespace string.

Actually, *ns is already assigned NULL in aa_unpack(), before the multiple
profiles unpacking loop. So make verify_header() check if every new
unpacked namespace declaration differs from the previous one in the same
load.

Note that similar to the namespace check in aa_replace_profiles(), if
one profile in the load specifies some namespace declaration in the header
and the other one doesn't specify any namespace in the header - it is also
considered invalid, e.g. the following multiple profiles load will fail
after this patch

  profile profile1 ... {}
  profile :ns:profile2 ... {}

Found by Linux Verification Center (linuxtesting.org).

Fixes: dd51c8485763 ("apparmor: provide base for multiple profiles to be replaced at once")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 security/apparmor/policy_unpack.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 54f7b4346506..5bd8ab7f1c88 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1120,7 +1120,6 @@ static int verify_header(struct aa_ext *e, int start, const char **ns)
 {
 	int error = -EPROTONOSUPPORT;
 	const char *name = NULL;
-	*ns = NULL;
 
 	/* get the interface version */
 	if (!aa_unpack_u32(e, &e->version, "version")) {
@@ -1142,20 +1141,35 @@ static int verify_header(struct aa_ext *e, int start, const char **ns)
 		return error;
 	}
 
-	/* read the namespace if present */
+	/* read the namespace if present and check it against policy load
+	 * namespace specified in the data start header
+	 */
 	if (aa_unpack_str(e, &name, "namespace")) {
 		if (*name == '\0') {
 			audit_iface(NULL, NULL, NULL, "invalid namespace name",
 				    e, error);
 			return error;
 		}
+
+		/* don't allow different namespaces be specified in the same
+		 * policy load set
+		 */
+		error = -EACCES;
 		if (*ns && strcmp(*ns, name)) {
-			audit_iface(NULL, NULL, NULL, "invalid ns change", e,
+			audit_iface(NULL, NULL, NULL,
+				    "policy load has mixed namespaces", e,
 				    error);
-		} else if (!*ns) {
+			return error;
+		} else if (!*ns && start) {
+			/* fill current policy load namespace at data start */
 			*ns = kstrdup(name, GFP_KERNEL);
 			if (!*ns)
 				return -ENOMEM;
+		} else if (!*ns) {
+			audit_iface(NULL, NULL, NULL,
+				    "policy load has mixed namespaces", e,
+				    error);
+			return error;
 		}
 	}
 
-- 
2.43.0


