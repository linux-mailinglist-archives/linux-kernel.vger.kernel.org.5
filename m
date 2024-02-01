Return-Path: <linux-kernel+bounces-48318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CDF845A41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C681F29F8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9C5F467;
	Thu,  1 Feb 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Y12xKooR"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35C5B69B;
	Thu,  1 Feb 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797537; cv=none; b=qGMtbYcuLbX6sd0qlD4tprmyXg6UUr94e6uaxdECILVr5gHDtwAl+PYWY8h9zufcheVSDwmsHvSE7vdqstEsUldRladlvhv9cX3YEznAFvoqE40atoO2M0x1jcxckayehTYyEL1bhrVPH1TzD3z6Up1lS/rBBCDiwXvjKnXkAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797537; c=relaxed/simple;
	bh=sF+G8ac5rJ6GBWZ7UGnOBa+TCEI+k8Sh7jK8bcRdt4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lr24SnGcDCo2tBCZ2DuD+TUIcT1xLMgyl4oLwGnEq4kvk+hudFBthSHzV6Oq30qKbU+U4LtrbqL3BF+5evF8LzACDb+0KynhAgyGdDYE/imwfA6KcOb31D7udZKIF0nNVYeK9kIhlBWRV/6uMNBMXNWmR7YdG4G+kuFLXYnqej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Y12xKooR; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [46.242.8.170])
	by mail.ispras.ru (Postfix) with ESMTPSA id A966D40737B5;
	Thu,  1 Feb 2024 14:25:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A966D40737B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1706797524;
	bh=EfXwutwttYNswqPhr1DI1HL9a39mqxWde2M9ylas6wE=;
	h=From:To:Cc:Subject:Date:From;
	b=Y12xKooRC1gohuym47VGPE7BZOR5fJOk4yOt3snNMmweJ0+EwkyTkgaBaAM0zbVUo
	 rLyykzqzbSrlb1JoW8+DDaVSYeUbNS4SNvfleXDxv2muqqTC7dVUMG7kTMChJqX1ox
	 8GUdYYj5E4KwthHbuLZW0+lOAcl2V95PFhXRu+Ko=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: John Johansen <john.johansen@canonical.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	William Hua <william.hua@canonical.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: use kvfree_sensitive to free data->data
Date: Thu,  1 Feb 2024 17:24:48 +0300
Message-ID: <20240201142450.30510-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inside unpack_profile() data->data is allocated using kvmemdup() so it
should be freed with the corresponding kvfree_sensitive().

Also add missing data->data release for rhashtable insertion failure path
in unpack_profile().

Found by Linux Verification Center (linuxtesting.org).

Fixes: e025be0f26d5 ("apparmor: support querying extended trusted helper extra data")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 security/apparmor/policy.c        | 2 +-
 security/apparmor/policy_unpack.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index 957654d253dd..14df15e35695 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -225,7 +225,7 @@ static void aa_free_data(void *ptr, void *arg)
 {
 	struct aa_data *data = ptr;
 
-	kfree_sensitive(data->data);
+	kvfree_sensitive(data->data, data->size);
 	kfree_sensitive(data->key);
 	kfree_sensitive(data);
 }
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 5e578ef0ddff..75452acd0e35 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1071,6 +1071,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 
 			if (rhashtable_insert_fast(profile->data, &data->head,
 						   profile->data->p)) {
+				kvfree_sensitive(data->data, data->size);
 				kfree_sensitive(data->key);
 				kfree_sensitive(data);
 				info = "failed to insert data to table";
-- 
2.43.0


