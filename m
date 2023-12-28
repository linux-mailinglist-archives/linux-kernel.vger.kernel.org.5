Return-Path: <linux-kernel+bounces-12769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D205881F9DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6B21C20ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC39F513;
	Thu, 28 Dec 2023 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="VuJ44Hnw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B1F4FF;
	Thu, 28 Dec 2023 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id F145540F1DDC;
	Thu, 28 Dec 2023 16:08:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F145540F1DDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1703779727;
	bh=m4hFkJIkWHBWbWm2n+Iu2CM6Wn9OdNelwblHQ1ILrho=;
	h=From:To:Cc:Subject:Date:From;
	b=VuJ44HnwE6nm2O4dqq4rP2phEMfTG7UJlJM90gH9y5L22OIfWbxHl9kBRmqKq0zh3
	 NPRxeHT7cD17WGEy5G8/3V4q+38wtK6AMFKBXRyFeg01p1s08Y+PqLEim1zaQzhvwI
	 jl7wvqWcGf52+xg07lFFYRzaiLnWA2AlNn71ROEc=
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
Subject: [PATCH] apparmor: avoid crash when parsed profile name is empty
Date: Thu, 28 Dec 2023 19:07:43 +0300
Message-ID: <20231228160744.1301-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing a packed profile in unpack_profile() described like

 "profile :ns::samba-dcerpcd /usr/lib*/samba/{,samba/}samba-dcerpcd {...}"

a string ":samba-dcerpcd" is unpacked as a fully-qualified name and then
passed to aa_splitn_fqname().

aa_splitn_fqname() treats ":samba-dcerpcd" as only containing a namespace.
Thus it returns NULL for tmpname, meanwhile tmpns is non-NULL. Later
aa_alloc_profile() crashes as the new profile name is NULL now.

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 6 PID: 1657 Comm: apparmor_parser Not tainted 6.7.0-rc2-dirty #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
RIP: 0010:strlen+0x1e/0xa0
Call Trace:
 <TASK>
 ? strlen+0x1e/0xa0
 aa_policy_init+0x1bb/0x230
 aa_alloc_profile+0xb1/0x480
 unpack_profile+0x3bc/0x4960
 aa_unpack+0x309/0x15e0
 aa_replace_profiles+0x213/0x33c0
 policy_update+0x261/0x370
 profile_replace+0x20e/0x2a0
 vfs_write+0x2af/0xe00
 ksys_write+0x126/0x250
 do_syscall_64+0x46/0xf0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
 </TASK>
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x1e/0xa0

It seems such behaviour of aa_splitn_fqname() is expected and checked in
other places where it is called (e.g. aa_remove_profiles). Well, there
is an explicit comment "a ns name without a following profile is allowed"
inside.

AFAICS, nothing can prevent unpacked "name" to be in form like
":samba-dcerpcd" - it is passed from userspace.

Deny the whole profile set replacement in such case and inform user with
EPROTO and an explaining message.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 04dc715e24d0 ("apparmor: audit policy ns specified in policy load")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 security/apparmor/policy_unpack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index e0af1e9f40ee..70d448048773 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -835,6 +835,10 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 
 	tmpname = aa_splitn_fqname(name, strlen(name), &tmpns, &ns_len);
 	if (tmpns) {
+		if (!tmpname) {
+			info = "empty profile name";
+			goto fail;
+		}
 		*ns_name = kstrndup(tmpns, ns_len, GFP_KERNEL);
 		if (!*ns_name) {
 			info = "out of memory";
-- 
2.43.0


