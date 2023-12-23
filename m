Return-Path: <linux-kernel+bounces-10367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021C781D36C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4052842FF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703199466;
	Sat, 23 Dec 2023 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lI8LsCiL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA27944F;
	Sat, 23 Dec 2023 09:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340A3C433C8;
	Sat, 23 Dec 2023 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703325450;
	bh=w8CkgvRhOPDmU8QZ8Pc8xJZqcVtv0mj3Sq4jL+1ULlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lI8LsCiL7RgjOkV4Urb+16rrNq0Tp+2prWpUZjaz/qF4HI9bhVnqRozb1mtndazlH
	 zAXRyvmND/TGoaUo5gVi4yuUp4eIWi1rfYxSmL7pwHukOwpgxSnvfGEWrtBUxXKwLB
	 KuhpRNcG8+4rbicxBpHnGBbUVE4gb0/V8c67T/x0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.145
Date: Sat, 23 Dec 2023 10:56:27 +0100
Message-ID: <2023122325-smartly-carpentry-d0c0@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023122324-graceless-unsuited-6ae6@gregkh>
References: <2023122324-graceless-unsuited-6ae6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 992cf6a636af..d46825496e8e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 144
+SUBLEVEL = 145
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 2a848e14181b..c4454d0f6cad 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -258,18 +258,17 @@ static struct mipi_dsi_device *lt9611uxc_attach_dsi(struct lt9611uxc *lt9611uxc,
 	const struct mipi_dsi_device_info info = { "lt9611uxc", 0, NULL };
 	struct mipi_dsi_device *dsi;
 	struct mipi_dsi_host *host;
-	struct device *dev = lt9611uxc->dev;
 	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dsi_node);
 	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
+		dev_err(lt9611uxc->dev, "failed to find dsi host\n");
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
+	dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(dsi)) {
-		dev_err(dev, "failed to create dsi device\n");
+		dev_err(lt9611uxc->dev, "failed to create dsi device\n");
 		return dsi;
 	}
 
@@ -278,9 +277,10 @@ static struct mipi_dsi_device *lt9611uxc_attach_dsi(struct lt9611uxc *lt9611uxc,
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 			  MIPI_DSI_MODE_VIDEO_HSE;
 
-	ret = devm_mipi_dsi_attach(dev, dsi);
+	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
-		dev_err(dev, "failed to attach dsi to host\n");
+		dev_err(lt9611uxc->dev, "failed to attach dsi to host\n");
+		mipi_dsi_device_unregister(dsi);
 		return ERR_PTR(ret);
 	}
 
@@ -355,6 +355,19 @@ static int lt9611uxc_connector_init(struct drm_bridge *bridge, struct lt9611uxc
 	return drm_connector_attach_encoder(&lt9611uxc->connector, bridge->encoder);
 }
 
+static void lt9611uxc_bridge_detach(struct drm_bridge *bridge)
+{
+	struct lt9611uxc *lt9611uxc = bridge_to_lt9611uxc(bridge);
+
+	if (lt9611uxc->dsi1) {
+		mipi_dsi_detach(lt9611uxc->dsi1);
+		mipi_dsi_device_unregister(lt9611uxc->dsi1);
+	}
+
+	mipi_dsi_detach(lt9611uxc->dsi0);
+	mipi_dsi_device_unregister(lt9611uxc->dsi0);
+}
+
 static int lt9611uxc_bridge_attach(struct drm_bridge *bridge,
 				   enum drm_bridge_attach_flags flags)
 {
@@ -367,7 +380,27 @@ static int lt9611uxc_bridge_attach(struct drm_bridge *bridge,
 			return ret;
 	}
 
+	/* Attach primary DSI */
+	lt9611uxc->dsi0 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi0_node);
+	if (IS_ERR(lt9611uxc->dsi0))
+		return PTR_ERR(lt9611uxc->dsi0);
+
+	/* Attach secondary DSI, if specified */
+	if (lt9611uxc->dsi1_node) {
+		lt9611uxc->dsi1 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi1_node);
+		if (IS_ERR(lt9611uxc->dsi1)) {
+			ret = PTR_ERR(lt9611uxc->dsi1);
+			goto err_unregister_dsi0;
+		}
+	}
+
 	return 0;
+
+err_unregister_dsi0:
+	mipi_dsi_detach(lt9611uxc->dsi0);
+	mipi_dsi_device_unregister(lt9611uxc->dsi0);
+
+	return ret;
 }
 
 static enum drm_mode_status
@@ -511,6 +544,7 @@ static struct edid *lt9611uxc_bridge_get_edid(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs lt9611uxc_bridge_funcs = {
 	.attach = lt9611uxc_bridge_attach,
+	.detach = lt9611uxc_bridge_detach,
 	.mode_valid = lt9611uxc_bridge_mode_valid,
 	.mode_set = lt9611uxc_bridge_mode_set,
 	.detect = lt9611uxc_bridge_detect,
@@ -927,9 +961,9 @@ static int lt9611uxc_probe(struct i2c_client *client,
 	init_waitqueue_head(&lt9611uxc->wq);
 	INIT_WORK(&lt9611uxc->work, lt9611uxc_hpd_work);
 
-	ret = request_threaded_irq(client->irq, NULL,
-				   lt9611uxc_irq_thread_handler,
-				   IRQF_ONESHOT, "lt9611uxc", lt9611uxc);
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					lt9611uxc_irq_thread_handler,
+					IRQF_ONESHOT, "lt9611uxc", lt9611uxc);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		goto err_disable_regulators;
@@ -946,29 +980,8 @@ static int lt9611uxc_probe(struct i2c_client *client,
 
 	drm_bridge_add(&lt9611uxc->bridge);
 
-	/* Attach primary DSI */
-	lt9611uxc->dsi0 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi0_node);
-	if (IS_ERR(lt9611uxc->dsi0)) {
-		ret = PTR_ERR(lt9611uxc->dsi0);
-		goto err_remove_bridge;
-	}
-
-	/* Attach secondary DSI, if specified */
-	if (lt9611uxc->dsi1_node) {
-		lt9611uxc->dsi1 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi1_node);
-		if (IS_ERR(lt9611uxc->dsi1)) {
-			ret = PTR_ERR(lt9611uxc->dsi1);
-			goto err_remove_bridge;
-		}
-	}
-
 	return lt9611uxc_audio_init(dev, lt9611uxc);
 
-err_remove_bridge:
-	free_irq(client->irq, lt9611uxc);
-	cancel_work_sync(&lt9611uxc->work);
-	drm_bridge_remove(&lt9611uxc->bridge);
-
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(lt9611uxc->supplies), lt9611uxc->supplies);
 
@@ -983,7 +996,7 @@ static int lt9611uxc_remove(struct i2c_client *client)
 {
 	struct lt9611uxc *lt9611uxc = i2c_get_clientdata(client);
 
-	free_irq(client->irq, lt9611uxc);
+	disable_irq(client->irq);
 	cancel_work_sync(&lt9611uxc->work);
 	lt9611uxc_audio_exit(lt9611uxc);
 	drm_bridge_remove(&lt9611uxc->bridge);
diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
index 6af339cfdc04..d036ab80fec3 100644
--- a/fs/ksmbd/Kconfig
+++ b/fs/ksmbd/Kconfig
@@ -1,12 +1,11 @@
 config SMB_SERVER
-	tristate "SMB3 server support (EXPERIMENTAL)"
+	tristate "SMB3 server support"
 	depends on INET
 	depends on MULTIUSER
 	depends on FILE_LOCKING
 	select NLS
 	select NLS_UTF8
 	select CRYPTO
-	select CRYPTO_MD4
 	select CRYPTO_MD5
 	select CRYPTO_HMAC
 	select CRYPTO_ECB
@@ -34,14 +33,16 @@ config SMB_SERVER
 	  in ksmbd-tools, available from
 	  https://github.com/cifsd-team/ksmbd-tools.
 	  More detail about how to run the ksmbd kernel server is
-	  available via README file
+	  available via the README file
 	  (https://github.com/cifsd-team/ksmbd-tools/blob/master/README).
 
 	  ksmbd kernel server includes support for auto-negotiation,
 	  Secure negotiate, Pre-authentication integrity, oplock/lease,
 	  compound requests, multi-credit, packet signing, RDMA(smbdirect),
 	  smb3 encryption, copy-offload, secure per-user session
-	  establishment via NTLM or NTLMv2.
+	  establishment via Kerberos or NTLMv2.
+
+if SMB_SERVER
 
 config SMB_SERVER_SMBDIRECT
 	bool "Support for SMB Direct protocol"
@@ -55,6 +56,8 @@ config SMB_SERVER_SMBDIRECT
 	  SMB Direct allows transferring SMB packets over RDMA. If unsure,
 	  say N.
 
+endif
+
 config SMB_SERVER_CHECK_CAP_NET_ADMIN
 	bool "Enable check network administration capability"
 	depends on SMB_SERVER
diff --git a/fs/ksmbd/asn1.c b/fs/ksmbd/asn1.c
index b014f4638610..4a4b2b03ff33 100644
--- a/fs/ksmbd/asn1.c
+++ b/fs/ksmbd/asn1.c
@@ -21,101 +21,11 @@
 #include "ksmbd_spnego_negtokeninit.asn1.h"
 #include "ksmbd_spnego_negtokentarg.asn1.h"
 
-#define SPNEGO_OID_LEN 7
 #define NTLMSSP_OID_LEN  10
-#define KRB5_OID_LEN  7
-#define KRB5U2U_OID_LEN  8
-#define MSKRB5_OID_LEN  7
-static unsigned long SPNEGO_OID[7] = { 1, 3, 6, 1, 5, 5, 2 };
-static unsigned long NTLMSSP_OID[10] = { 1, 3, 6, 1, 4, 1, 311, 2, 2, 10 };
-static unsigned long KRB5_OID[7] = { 1, 2, 840, 113554, 1, 2, 2 };
-static unsigned long KRB5U2U_OID[8] = { 1, 2, 840, 113554, 1, 2, 2, 3 };
-static unsigned long MSKRB5_OID[7] = { 1, 2, 840, 48018, 1, 2, 2 };
 
 static char NTLMSSP_OID_STR[NTLMSSP_OID_LEN] = { 0x2b, 0x06, 0x01, 0x04, 0x01,
 	0x82, 0x37, 0x02, 0x02, 0x0a };
 
-static bool
-asn1_subid_decode(const unsigned char **begin, const unsigned char *end,
-		  unsigned long *subid)
-{
-	const unsigned char *ptr = *begin;
-	unsigned char ch;
-
-	*subid = 0;
-
-	do {
-		if (ptr >= end)
-			return false;
-
-		ch = *ptr++;
-		*subid <<= 7;
-		*subid |= ch & 0x7F;
-	} while ((ch & 0x80) == 0x80);
-
-	*begin = ptr;
-	return true;
-}
-
-static bool asn1_oid_decode(const unsigned char *value, size_t vlen,
-			    unsigned long **oid, size_t *oidlen)
-{
-	const unsigned char *iptr = value, *end = value + vlen;
-	unsigned long *optr;
-	unsigned long subid;
-
-	vlen += 1;
-	if (vlen < 2 || vlen > UINT_MAX / sizeof(unsigned long))
-		goto fail_nullify;
-
-	*oid = kmalloc(vlen * sizeof(unsigned long), GFP_KERNEL);
-	if (!*oid)
-		return false;
-
-	optr = *oid;
-
-	if (!asn1_subid_decode(&iptr, end, &subid))
-		goto fail;
-
-	if (subid < 40) {
-		optr[0] = 0;
-		optr[1] = subid;
-	} else if (subid < 80) {
-		optr[0] = 1;
-		optr[1] = subid - 40;
-	} else {
-		optr[0] = 2;
-		optr[1] = subid - 80;
-	}
-
-	*oidlen = 2;
-	optr += 2;
-
-	while (iptr < end) {
-		if (++(*oidlen) > vlen)
-			goto fail;
-
-		if (!asn1_subid_decode(&iptr, end, optr++))
-			goto fail;
-	}
-	return true;
-
-fail:
-	kfree(*oid);
-fail_nullify:
-	*oid = NULL;
-	return false;
-}
-
-static bool oid_eq(unsigned long *oid1, unsigned int oid1len,
-		   unsigned long *oid2, unsigned int oid2len)
-{
-	if (oid1len != oid2len)
-		return false;
-
-	return memcmp(oid1, oid2, oid1len) == 0;
-}
-
 int
 ksmbd_decode_negTokenInit(unsigned char *security_blob, int length,
 			  struct ksmbd_conn *conn)
@@ -252,26 +162,18 @@ int build_spnego_ntlmssp_auth_blob(unsigned char **pbuffer, u16 *buflen,
 int ksmbd_gssapi_this_mech(void *context, size_t hdrlen, unsigned char tag,
 			   const void *value, size_t vlen)
 {
-	unsigned long *oid;
-	size_t oidlen;
-	int err = 0;
-
-	if (!asn1_oid_decode(value, vlen, &oid, &oidlen)) {
-		err = -EBADMSG;
-		goto out;
-	}
+	enum OID oid;
 
-	if (!oid_eq(oid, oidlen, SPNEGO_OID, SPNEGO_OID_LEN))
-		err = -EBADMSG;
-	kfree(oid);
-out:
-	if (err) {
+	oid = look_up_OID(value, vlen);
+	if (oid != OID_spnego) {
 		char buf[50];
 
 		sprint_oid(value, vlen, buf, sizeof(buf));
 		ksmbd_debug(AUTH, "Unexpected OID: %s\n", buf);
+		return -EBADMSG;
 	}
-	return err;
+
+	return 0;
 }
 
 int ksmbd_neg_token_init_mech_type(void *context, size_t hdrlen,
@@ -279,65 +181,56 @@ int ksmbd_neg_token_init_mech_type(void *context, size_t hdrlen,
 				   size_t vlen)
 {
 	struct ksmbd_conn *conn = context;
-	unsigned long *oid;
-	size_t oidlen;
+	enum OID oid;
 	int mech_type;
-	char buf[50];
-
-	if (!asn1_oid_decode(value, vlen, &oid, &oidlen))
-		goto fail;
 
-	if (oid_eq(oid, oidlen, NTLMSSP_OID, NTLMSSP_OID_LEN))
+	oid = look_up_OID(value, vlen);
+	if (oid == OID_ntlmssp) {
 		mech_type = KSMBD_AUTH_NTLMSSP;
-	else if (oid_eq(oid, oidlen, MSKRB5_OID, MSKRB5_OID_LEN))
+	} else if (oid == OID_mskrb5) {
 		mech_type = KSMBD_AUTH_MSKRB5;
-	else if (oid_eq(oid, oidlen, KRB5_OID, KRB5_OID_LEN))
+	} else if (oid == OID_krb5) {
 		mech_type = KSMBD_AUTH_KRB5;
-	else if (oid_eq(oid, oidlen, KRB5U2U_OID, KRB5U2U_OID_LEN))
+	} else if (oid == OID_krb5u2u) {
 		mech_type = KSMBD_AUTH_KRB5U2U;
-	else
-		goto fail;
+	} else {
+		char buf[50];
+
+		sprint_oid(value, vlen, buf, sizeof(buf));
+		ksmbd_debug(AUTH, "Unexpected OID: %s\n", buf);
+		return -EBADMSG;
+	}
 
 	conn->auth_mechs |= mech_type;
 	if (conn->preferred_auth_mech == 0)
 		conn->preferred_auth_mech = mech_type;
 
-	kfree(oid);
 	return 0;
-
-fail:
-	kfree(oid);
-	sprint_oid(value, vlen, buf, sizeof(buf));
-	ksmbd_debug(AUTH, "Unexpected OID: %s\n", buf);
-	return -EBADMSG;
 }
 
-int ksmbd_neg_token_init_mech_token(void *context, size_t hdrlen,
-				    unsigned char tag, const void *value,
-				    size_t vlen)
+static int ksmbd_neg_token_alloc(void *context, size_t hdrlen,
+				 unsigned char tag, const void *value,
+				 size_t vlen)
 {
 	struct ksmbd_conn *conn = context;
 
-	conn->mechToken = kmalloc(vlen + 1, GFP_KERNEL);
+	conn->mechToken = kmemdup_nul(value, vlen, GFP_KERNEL);
 	if (!conn->mechToken)
 		return -ENOMEM;
 
-	memcpy(conn->mechToken, value, vlen);
-	conn->mechToken[vlen] = '\0';
 	return 0;
 }
 
-int ksmbd_neg_token_targ_resp_token(void *context, size_t hdrlen,
+int ksmbd_neg_token_init_mech_token(void *context, size_t hdrlen,
 				    unsigned char tag, const void *value,
 				    size_t vlen)
 {
-	struct ksmbd_conn *conn = context;
-
-	conn->mechToken = kmalloc(vlen + 1, GFP_KERNEL);
-	if (!conn->mechToken)
-		return -ENOMEM;
+	return ksmbd_neg_token_alloc(context, hdrlen, tag, value, vlen);
+}
 
-	memcpy(conn->mechToken, value, vlen);
-	conn->mechToken[vlen] = '\0';
-	return 0;
+int ksmbd_neg_token_targ_resp_token(void *context, size_t hdrlen,
+				    unsigned char tag, const void *value,
+				    size_t vlen)
+{
+	return ksmbd_neg_token_alloc(context, hdrlen, tag, value, vlen);
 }
diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 59d205946746..9a08e6a90b94 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -29,6 +29,7 @@
 #include "mgmt/user_config.h"
 #include "crypto_ctx.h"
 #include "transport_ipc.h"
+#include "../smbfs_common/arc4.h"
 
 /*
  * Fixed format data defining GSS header and fixed string
@@ -342,6 +343,32 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 				nt_len - CIFS_ENCPWD_SIZE,
 				domain_name, conn->ntlmssp.cryptkey);
 	kfree(domain_name);
+
+	/* The recovered secondary session key */
+	if (conn->ntlmssp.client_flags & NTLMSSP_NEGOTIATE_KEY_XCH) {
+		struct arc4_ctx *ctx_arc4;
+		unsigned int sess_key_off, sess_key_len;
+
+		sess_key_off = le32_to_cpu(authblob->SessionKey.BufferOffset);
+		sess_key_len = le16_to_cpu(authblob->SessionKey.Length);
+
+		if (blob_len < (u64)sess_key_off + sess_key_len)
+			return -EINVAL;
+
+		if (sess_key_len > CIFS_KEY_SIZE)
+			return -EINVAL;
+
+		ctx_arc4 = kmalloc(sizeof(*ctx_arc4), GFP_KERNEL);
+		if (!ctx_arc4)
+			return -ENOMEM;
+
+		cifs_arc4_setkey(ctx_arc4, sess->sess_key,
+				 SMB2_NTLMV2_SESSKEY_SIZE);
+		cifs_arc4_crypt(ctx_arc4, sess->sess_key,
+				(char *)authblob + sess_key_off, sess_key_len);
+		kfree_sensitive(ctx_arc4);
+	}
+
 	return ret;
 }
 
@@ -404,6 +431,9 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 				   NTLMSSP_NEGOTIATE_56);
 	}
 
+	if (cflags & NTLMSSP_NEGOTIATE_SEAL && smb3_encryption_negotiated(conn))
+		flags |= NTLMSSP_NEGOTIATE_SEAL;
+
 	if (cflags & NTLMSSP_NEGOTIATE_ALWAYS_SIGN)
 		flags |= NTLMSSP_NEGOTIATE_ALWAYS_SIGN;
 
@@ -414,6 +444,9 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 	    (cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC))
 		flags |= NTLMSSP_NEGOTIATE_EXTENDED_SEC;
 
+	if (cflags & NTLMSSP_NEGOTIATE_KEY_XCH)
+		flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
+
 	chgblob->NegotiateFlags = cpu_to_le32(flags);
 	len = strlen(ksmbd_netbios_name());
 	name = kmalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
@@ -700,8 +733,9 @@ static int generate_key(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 		goto smb3signkey_ret;
 	}
 
-	if (conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
-	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
+	if (key_size == SMB3_ENC_DEC_KEY_SIZE &&
+	    (conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
+	     conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
 		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L256, 4);
 	else
 		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L128, 4);
@@ -884,9 +918,9 @@ int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
 				     __u8 *pi_hash)
 {
 	int rc;
-	struct smb2_hdr *rcv_hdr = (struct smb2_hdr *)buf;
+	struct smb2_hdr *rcv_hdr = smb2_get_msg(buf);
 	char *all_bytes_msg = (char *)&rcv_hdr->ProtocolId;
-	int msg_size = be32_to_cpu(rcv_hdr->smb2_buf_length);
+	int msg_size = get_rfc1002_len(buf);
 	struct ksmbd_crypto_ctx *ctx = NULL;
 
 	if (conn->preauth_info->Preauth_HashId !=
@@ -961,13 +995,16 @@ int ksmbd_gen_sd_hash(struct ksmbd_conn *conn, char *sd_buf, int len,
 	return rc;
 }
 
-static int ksmbd_get_encryption_key(struct ksmbd_conn *conn, __u64 ses_id,
+static int ksmbd_get_encryption_key(struct ksmbd_work *work, __u64 ses_id,
 				    int enc, u8 *key)
 {
 	struct ksmbd_session *sess;
 	u8 *ses_enc_key;
 
-	sess = ksmbd_session_lookup_all(conn, ses_id);
+	if (enc)
+		sess = work->sess;
+	else
+		sess = ksmbd_session_lookup_all(work->conn, ses_id);
 	if (!sess)
 		return -EINVAL;
 
@@ -994,12 +1031,16 @@ static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
 					 u8 *sign)
 {
 	struct scatterlist *sg;
-	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 24;
-	int i, nr_entries[3] = {0}, total_entries = 0, sg_idx = 0;
+	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
+	int i, *nr_entries, total_entries = 0, sg_idx = 0;
 
 	if (!nvec)
 		return NULL;
 
+	nr_entries = kcalloc(nvec, sizeof(int), GFP_KERNEL);
+	if (!nr_entries)
+		return NULL;
+
 	for (i = 0; i < nvec - 1; i++) {
 		unsigned long kaddr = (unsigned long)iov[i + 1].iov_base;
 
@@ -1017,8 +1058,10 @@ static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
 	total_entries += 2;
 
 	sg = kmalloc_array(total_entries, sizeof(struct scatterlist), GFP_KERNEL);
-	if (!sg)
+	if (!sg) {
+		kfree(nr_entries);
 		return NULL;
+	}
 
 	sg_init_table(sg, total_entries);
 	smb2_sg_set_buf(&sg[sg_idx++], iov[0].iov_base + 24, assoc_data_len);
@@ -1052,15 +1095,16 @@ static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
 		}
 	}
 	smb2_sg_set_buf(&sg[sg_idx], sign, SMB2_SIGNATURE_SIZE);
+	kfree(nr_entries);
 	return sg;
 }
 
-int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
+int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 			unsigned int nvec, int enc)
 {
-	struct smb2_transform_hdr *tr_hdr =
-		(struct smb2_transform_hdr *)iov[0].iov_base;
-	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 24;
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(iov[0].iov_base);
+	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
 	int rc;
 	struct scatterlist *sg;
 	u8 sign[SMB2_SIGNATURE_SIZE] = {};
@@ -1072,7 +1116,7 @@ int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	struct ksmbd_crypto_ctx *ctx;
 
-	rc = ksmbd_get_encryption_key(conn,
+	rc = ksmbd_get_encryption_key(work,
 				      le64_to_cpu(tr_hdr->SessionId),
 				      enc,
 				      key);
diff --git a/fs/ksmbd/auth.h b/fs/ksmbd/auth.h
index 25b772653de0..362b6159a6cf 100644
--- a/fs/ksmbd/auth.h
+++ b/fs/ksmbd/auth.h
@@ -33,9 +33,10 @@
 
 struct ksmbd_session;
 struct ksmbd_conn;
+struct ksmbd_work;
 struct kvec;
 
-int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
+int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 			unsigned int nvec, int enc);
 void ksmbd_copy_gss_neg_header(void *buf);
 int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index cab274b77727..0a7a30bd531f 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -20,7 +20,7 @@ static DEFINE_MUTEX(init_lock);
 static struct ksmbd_conn_ops default_conn_ops;
 
 LIST_HEAD(conn_list);
-DEFINE_RWLOCK(conn_list_lock);
+DECLARE_RWSEM(conn_list_lock);
 
 /**
  * ksmbd_conn_free() - free resources of the connection instance
@@ -32,9 +32,9 @@ DEFINE_RWLOCK(conn_list_lock);
  */
 void ksmbd_conn_free(struct ksmbd_conn *conn)
 {
-	write_lock(&conn_list_lock);
+	down_write(&conn_list_lock);
 	list_del(&conn->conns_list);
-	write_unlock(&conn_list_lock);
+	up_write(&conn_list_lock);
 
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
@@ -56,16 +56,23 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 		return NULL;
 
 	conn->need_neg = true;
-	conn->status = KSMBD_SESS_NEW;
+	ksmbd_conn_set_new(conn);
 	conn->local_nls = load_nls("utf8");
 	if (!conn->local_nls)
 		conn->local_nls = load_nls_default();
+	if (IS_ENABLED(CONFIG_UNICODE))
+		conn->um = utf8_load("12.1.0");
+	else
+		conn->um = ERR_PTR(-EOPNOTSUPP);
+	if (IS_ERR(conn->um))
+		conn->um = NULL;
 	atomic_set(&conn->req_running, 0);
 	atomic_set(&conn->r_count, 0);
 	conn->total_credits = 1;
 	conn->outstanding_credits = 0;
 
 	init_waitqueue_head(&conn->req_running_q);
+	init_waitqueue_head(&conn->r_count_q);
 	INIT_LIST_HEAD(&conn->conns_list);
 	INIT_LIST_HEAD(&conn->requests);
 	INIT_LIST_HEAD(&conn->async_requests);
@@ -77,9 +84,11 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 	spin_lock_init(&conn->llist_lock);
 	INIT_LIST_HEAD(&conn->lock_list);
 
-	write_lock(&conn_list_lock);
+	init_rwsem(&conn->session_lock);
+
+	down_write(&conn_list_lock);
 	list_add(&conn->conns_list, &conn_list);
-	write_unlock(&conn_list_lock);
+	up_write(&conn_list_lock);
 	return conn;
 }
 
@@ -88,7 +97,7 @@ bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c)
 	struct ksmbd_conn *t;
 	bool ret = false;
 
-	read_lock(&conn_list_lock);
+	down_read(&conn_list_lock);
 	list_for_each_entry(t, &conn_list, conns_list) {
 		if (memcmp(t->ClientGUID, c->ClientGUID, SMB2_CLIENT_GUID_SIZE))
 			continue;
@@ -96,7 +105,7 @@ bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c)
 		ret = true;
 		break;
 	}
-	read_unlock(&conn_list_lock);
+	up_read(&conn_list_lock);
 	return ret;
 }
 
@@ -105,10 +114,8 @@ void ksmbd_conn_enqueue_request(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	struct list_head *requests_queue = NULL;
 
-	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE) {
+	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE)
 		requests_queue = &conn->requests;
-		work->syncronous = true;
-	}
 
 	if (requests_queue) {
 		atomic_inc(&conn->req_running);
@@ -118,41 +125,47 @@ void ksmbd_conn_enqueue_request(struct ksmbd_work *work)
 	}
 }
 
-int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
+void ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	int ret = 1;
 
 	if (list_empty(&work->request_entry) &&
 	    list_empty(&work->async_request_entry))
-		return 0;
+		return;
 
-	if (!work->multiRsp)
-		atomic_dec(&conn->req_running);
+	atomic_dec(&conn->req_running);
 	spin_lock(&conn->request_lock);
-	if (!work->multiRsp) {
-		list_del_init(&work->request_entry);
-		if (work->syncronous == false)
-			list_del_init(&work->async_request_entry);
-		ret = 0;
-	}
+	list_del_init(&work->request_entry);
 	spin_unlock(&conn->request_lock);
+	if (work->asynchronous)
+		release_async_work(work);
 
 	wake_up_all(&conn->req_running_q);
-	return ret;
 }
 
-static void ksmbd_conn_lock(struct ksmbd_conn *conn)
+void ksmbd_conn_lock(struct ksmbd_conn *conn)
 {
 	mutex_lock(&conn->srv_mutex);
 }
 
-static void ksmbd_conn_unlock(struct ksmbd_conn *conn)
+void ksmbd_conn_unlock(struct ksmbd_conn *conn)
 {
 	mutex_unlock(&conn->srv_mutex);
 }
 
-void ksmbd_conn_wait_idle(struct ksmbd_conn *conn)
+void ksmbd_all_conn_set_status(u64 sess_id, u32 status)
+{
+	struct ksmbd_conn *conn;
+
+	down_read(&conn_list_lock);
+	list_for_each_entry(conn, &conn_list, conns_list) {
+		if (conn->binding || xa_load(&conn->sessions, sess_id))
+			WRITE_ONCE(conn->status, status);
+	}
+	up_read(&conn_list_lock);
+}
+
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id)
 {
 	wait_event(conn->req_running_q, atomic_read(&conn->req_running) < 2);
 }
@@ -160,43 +173,25 @@ void ksmbd_conn_wait_idle(struct ksmbd_conn *conn)
 int ksmbd_conn_write(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb_hdr *rsp_hdr = work->response_buf;
-	size_t len = 0;
 	int sent;
-	struct kvec iov[3];
-	int iov_idx = 0;
 
-	ksmbd_conn_try_dequeue_request(work);
-	if (!rsp_hdr) {
+	if (!work->response_buf) {
 		pr_err("NULL response header\n");
 		return -EINVAL;
 	}
 
-	if (work->tr_buf) {
-		iov[iov_idx] = (struct kvec) { work->tr_buf,
-				sizeof(struct smb2_transform_hdr) };
-		len += iov[iov_idx++].iov_len;
-	}
+	if (work->send_no_response)
+		return 0;
 
-	if (work->aux_payload_sz) {
-		iov[iov_idx] = (struct kvec) { rsp_hdr, work->resp_hdr_sz };
-		len += iov[iov_idx++].iov_len;
-		iov[iov_idx] = (struct kvec) { work->aux_payload_buf, work->aux_payload_sz };
-		len += iov[iov_idx++].iov_len;
-	} else {
-		if (work->tr_buf)
-			iov[iov_idx].iov_len = work->resp_hdr_sz;
-		else
-			iov[iov_idx].iov_len = get_rfc1002_len(rsp_hdr) + 4;
-		iov[iov_idx].iov_base = rsp_hdr;
-		len += iov[iov_idx++].iov_len;
-	}
+	if (!work->iov_idx)
+		return -EINVAL;
 
 	ksmbd_conn_lock(conn);
-	sent = conn->transport->ops->writev(conn->transport, &iov[0],
-					iov_idx, len,
-					work->need_invalidate_rkey,
-					work->remote_key);
+	sent = conn->transport->ops->writev(conn->transport, work->iov,
+			work->iov_cnt,
+			get_rfc1002_len(work->iov[0].iov_base) + 4,
+			work->need_invalidate_rkey,
+			work->remote_key);
 	ksmbd_conn_unlock(conn);
 
 	if (sent < 0) {
@@ -207,31 +202,31 @@ int ksmbd_conn_write(struct ksmbd_work *work)
 	return 0;
 }
 
-int ksmbd_conn_rdma_read(struct ksmbd_conn *conn, void *buf,
-			 unsigned int buflen, u32 remote_key, u64 remote_offset,
-			 u32 remote_len)
+int ksmbd_conn_rdma_read(struct ksmbd_conn *conn,
+			 void *buf, unsigned int buflen,
+			 struct smb2_buffer_desc_v1 *desc,
+			 unsigned int desc_len)
 {
 	int ret = -EINVAL;
 
 	if (conn->transport->ops->rdma_read)
 		ret = conn->transport->ops->rdma_read(conn->transport,
 						      buf, buflen,
-						      remote_key, remote_offset,
-						      remote_len);
+						      desc, desc_len);
 	return ret;
 }
 
-int ksmbd_conn_rdma_write(struct ksmbd_conn *conn, void *buf,
-			  unsigned int buflen, u32 remote_key,
-			  u64 remote_offset, u32 remote_len)
+int ksmbd_conn_rdma_write(struct ksmbd_conn *conn,
+			  void *buf, unsigned int buflen,
+			  struct smb2_buffer_desc_v1 *desc,
+			  unsigned int desc_len)
 {
 	int ret = -EINVAL;
 
 	if (conn->transport->ops->rdma_write)
 		ret = conn->transport->ops->rdma_write(conn->transport,
 						       buf, buflen,
-						       remote_key, remote_offset,
-						       remote_len);
+						       desc, desc_len);
 	return ret;
 }
 
@@ -240,7 +235,7 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	if (!ksmbd_server_running())
 		return false;
 
-	if (conn->status == KSMBD_SESS_EXITING)
+	if (ksmbd_conn_exiting(conn))
 		return false;
 
 	if (kthread_should_stop())
@@ -263,6 +258,9 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	return true;
 }
 
+#define SMB1_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb_hdr))
+#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)
+
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
  * @p:		connection instance
@@ -300,16 +298,16 @@ int ksmbd_conn_handler_loop(void *p)
 		pdu_size = get_rfc1002_len(hdr_buf);
 		ksmbd_debug(CONN, "RFC1002 header %u bytes\n", pdu_size);
 
-		if (conn->status == KSMBD_SESS_GOOD)
+		if (ksmbd_conn_good(conn))
 			max_allowed_pdu_size =
 				SMB3_MAX_MSGSIZE + conn->vals->max_write_size;
 		else
 			max_allowed_pdu_size = SMB3_MAX_MSGSIZE;
 
 		if (pdu_size > max_allowed_pdu_size) {
-			pr_err_ratelimited("PDU length(%u) excceed maximum allowed pdu size(%u) on connection(%d)\n",
+			pr_err_ratelimited("PDU length(%u) exceeded maximum allowed pdu size(%u) on connection(%d)\n",
 					pdu_size, max_allowed_pdu_size,
-					conn->status);
+					READ_ONCE(conn->status));
 			break;
 		}
 
@@ -319,6 +317,9 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > MAX_STREAM_PROT_LEN)
 			break;
 
+		if (pdu_size < SMB1_MIN_SUPPORTED_HEADER_SIZE)
+			break;
+
 		/* 4 for rfc1002 length field */
 		/* 1 for implied bcc[0] */
 		size = pdu_size + 4 + 1;
@@ -327,8 +328,6 @@ int ksmbd_conn_handler_loop(void *p)
 			break;
 
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
-		if (!ksmbd_smb_request(conn))
-			break;
 
 		/*
 		 * We already read 4 bytes to find out PDU size, now
@@ -346,6 +345,15 @@ int ksmbd_conn_handler_loop(void *p)
 			continue;
 		}
 
+		if (!ksmbd_smb_request(conn))
+			break;
+
+		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
+		    SMB2_PROTO_NUMBER) {
+			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
+				break;
+		}
+
 		if (!default_conn_ops.process_fn) {
 			pr_err("No connection request callback\n");
 			break;
@@ -358,10 +366,12 @@ int ksmbd_conn_handler_loop(void *p)
 	}
 
 out:
+	ksmbd_conn_set_releasing(conn);
 	/* Wait till all reference dropped to the Server object*/
-	while (atomic_read(&conn->r_count) > 0)
-		schedule_timeout(HZ);
+	wait_event(conn->r_count_q, atomic_read(&conn->r_count) == 0);
 
+	if (IS_ENABLED(CONFIG_UNICODE))
+		utf8_unload(conn->um);
 	unload_nls(conn->local_nls);
 	if (default_conn_ops.terminate_fn)
 		default_conn_ops.terminate_fn(conn);
@@ -400,19 +410,26 @@ int ksmbd_conn_transport_init(void)
 static void stop_sessions(void)
 {
 	struct ksmbd_conn *conn;
+	struct ksmbd_transport *t;
 
 again:
-	read_lock(&conn_list_lock);
+	down_read(&conn_list_lock);
 	list_for_each_entry(conn, &conn_list, conns_list) {
 		struct task_struct *task;
 
-		task = conn->transport->handler;
+		t = conn->transport;
+		task = t->handler;
 		if (task)
 			ksmbd_debug(CONN, "Stop session handler %s/%d\n",
 				    task->comm, task_pid_nr(task));
-		conn->status = KSMBD_SESS_EXITING;
+		ksmbd_conn_set_exiting(conn);
+		if (t->ops->shutdown) {
+			up_read(&conn_list_lock);
+			t->ops->shutdown(t);
+			down_read(&conn_list_lock);
+		}
 	}
-	read_unlock(&conn_list_lock);
+	up_read(&conn_list_lock);
 
 	if (!list_empty(&conn_list)) {
 		schedule_timeout_interruptible(HZ / 10); /* 100ms */
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 89eb41bbd160..3c005246a32e 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -14,6 +14,7 @@
 #include <net/request_sock.h>
 #include <linux/kthread.h>
 #include <linux/nls.h>
+#include <linux/unicode.h>
 
 #include "smb_common.h"
 #include "ksmbd_work.h"
@@ -25,7 +26,8 @@ enum {
 	KSMBD_SESS_GOOD,
 	KSMBD_SESS_EXITING,
 	KSMBD_SESS_NEED_RECONNECT,
-	KSMBD_SESS_NEED_NEGOTIATE
+	KSMBD_SESS_NEED_NEGOTIATE,
+	KSMBD_SESS_RELEASING
 };
 
 struct ksmbd_stats {
@@ -46,7 +48,9 @@ struct ksmbd_conn {
 	char				*request_buf;
 	struct ksmbd_transport		*transport;
 	struct nls_table		*local_nls;
+	struct unicode_map		*um;
 	struct list_head		conns_list;
+	struct rw_semaphore		session_lock;
 	/* smb session 1 per user */
 	struct xarray			sessions;
 	unsigned long			last_active;
@@ -58,6 +62,7 @@ struct ksmbd_conn {
 	unsigned int			outstanding_credits;
 	spinlock_t			credits_lock;
 	wait_queue_head_t		req_running_q;
+	wait_queue_head_t		r_count_q;
 	/* Lock to protect requests list*/
 	spinlock_t			request_lock;
 	struct list_head		requests;
@@ -110,16 +115,20 @@ struct ksmbd_conn_ops {
 struct ksmbd_transport_ops {
 	int (*prepare)(struct ksmbd_transport *t);
 	void (*disconnect)(struct ksmbd_transport *t);
+	void (*shutdown)(struct ksmbd_transport *t);
 	int (*read)(struct ksmbd_transport *t, char *buf,
 		    unsigned int size, int max_retries);
 	int (*writev)(struct ksmbd_transport *t, struct kvec *iovs, int niov,
 		      int size, bool need_invalidate_rkey,
 		      unsigned int remote_key);
-	int (*rdma_read)(struct ksmbd_transport *t, void *buf, unsigned int len,
-			 u32 remote_key, u64 remote_offset, u32 remote_len);
-	int (*rdma_write)(struct ksmbd_transport *t, void *buf,
-			  unsigned int len, u32 remote_key, u64 remote_offset,
-			  u32 remote_len);
+	int (*rdma_read)(struct ksmbd_transport *t,
+			 void *buf, unsigned int len,
+			 struct smb2_buffer_desc_v1 *desc,
+			 unsigned int desc_len);
+	int (*rdma_write)(struct ksmbd_transport *t,
+			  void *buf, unsigned int len,
+			  struct smb2_buffer_desc_v1 *desc,
+			  unsigned int desc_len);
 };
 
 struct ksmbd_transport {
@@ -133,26 +142,30 @@ struct ksmbd_transport {
 #define KSMBD_TCP_PEER_SOCKADDR(c)	((struct sockaddr *)&((c)->peer_addr))
 
 extern struct list_head conn_list;
-extern rwlock_t conn_list_lock;
+extern struct rw_semaphore conn_list_lock;
 
 bool ksmbd_conn_alive(struct ksmbd_conn *conn);
-void ksmbd_conn_wait_idle(struct ksmbd_conn *conn);
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id);
 struct ksmbd_conn *ksmbd_conn_alloc(void);
 void ksmbd_conn_free(struct ksmbd_conn *conn);
 bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c);
 int ksmbd_conn_write(struct ksmbd_work *work);
-int ksmbd_conn_rdma_read(struct ksmbd_conn *conn, void *buf,
-			 unsigned int buflen, u32 remote_key, u64 remote_offset,
-			 u32 remote_len);
-int ksmbd_conn_rdma_write(struct ksmbd_conn *conn, void *buf,
-			  unsigned int buflen, u32 remote_key, u64 remote_offset,
-			  u32 remote_len);
+int ksmbd_conn_rdma_read(struct ksmbd_conn *conn,
+			 void *buf, unsigned int buflen,
+			 struct smb2_buffer_desc_v1 *desc,
+			 unsigned int desc_len);
+int ksmbd_conn_rdma_write(struct ksmbd_conn *conn,
+			  void *buf, unsigned int buflen,
+			  struct smb2_buffer_desc_v1 *desc,
+			  unsigned int desc_len);
 void ksmbd_conn_enqueue_request(struct ksmbd_work *work);
-int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work);
+void ksmbd_conn_try_dequeue_request(struct ksmbd_work *work);
 void ksmbd_conn_init_server_callbacks(struct ksmbd_conn_ops *ops);
 int ksmbd_conn_handler_loop(void *p);
 int ksmbd_conn_transport_init(void);
 void ksmbd_conn_transport_destroy(void);
+void ksmbd_conn_lock(struct ksmbd_conn *conn);
+void ksmbd_conn_unlock(struct ksmbd_conn *conn);
 
 /*
  * WARNING
@@ -160,43 +173,60 @@ void ksmbd_conn_transport_destroy(void);
  * This is a hack. We will move status to a proper place once we land
  * a multi-sessions support.
  */
-static inline bool ksmbd_conn_good(struct ksmbd_work *work)
+static inline bool ksmbd_conn_good(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_GOOD;
+	return READ_ONCE(conn->status) == KSMBD_SESS_GOOD;
 }
 
-static inline bool ksmbd_conn_need_negotiate(struct ksmbd_work *work)
+static inline bool ksmbd_conn_need_negotiate(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_NEED_NEGOTIATE;
+	return READ_ONCE(conn->status) == KSMBD_SESS_NEED_NEGOTIATE;
 }
 
-static inline bool ksmbd_conn_need_reconnect(struct ksmbd_work *work)
+static inline bool ksmbd_conn_need_reconnect(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_NEED_RECONNECT;
+	return READ_ONCE(conn->status) == KSMBD_SESS_NEED_RECONNECT;
 }
 
-static inline bool ksmbd_conn_exiting(struct ksmbd_work *work)
+static inline bool ksmbd_conn_exiting(struct ksmbd_conn *conn)
 {
-	return work->conn->status == KSMBD_SESS_EXITING;
+	return READ_ONCE(conn->status) == KSMBD_SESS_EXITING;
 }
 
-static inline void ksmbd_conn_set_good(struct ksmbd_work *work)
+static inline bool ksmbd_conn_releasing(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_GOOD;
+	return READ_ONCE(conn->status) == KSMBD_SESS_RELEASING;
 }
 
-static inline void ksmbd_conn_set_need_negotiate(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_new(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_NEED_NEGOTIATE;
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEW);
 }
 
-static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_good(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_NEED_RECONNECT;
+	WRITE_ONCE(conn->status, KSMBD_SESS_GOOD);
 }
 
-static inline void ksmbd_conn_set_exiting(struct ksmbd_work *work)
+static inline void ksmbd_conn_set_need_negotiate(struct ksmbd_conn *conn)
 {
-	work->conn->status = KSMBD_SESS_EXITING;
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_NEGOTIATE);
 }
+
+static inline void ksmbd_conn_set_need_reconnect(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_NEED_RECONNECT);
+}
+
+static inline void ksmbd_conn_set_exiting(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_EXITING);
+}
+
+static inline void ksmbd_conn_set_releasing(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_RELEASING);
+}
+
+void ksmbd_all_conn_set_status(u64 sess_id, u32 status);
 #endif /* __CONNECTION_H__ */
diff --git a/fs/ksmbd/ksmbd_netlink.h b/fs/ksmbd/ksmbd_netlink.h
index fae859d59c79..821ed8e3cbee 100644
--- a/fs/ksmbd/ksmbd_netlink.h
+++ b/fs/ksmbd/ksmbd_netlink.h
@@ -74,6 +74,7 @@ struct ksmbd_heartbeat {
 #define KSMBD_GLOBAL_FLAG_SMB2_LEASES		BIT(0)
 #define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION	BIT(1)
 #define KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL	BIT(2)
+#define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF	BIT(3)
 
 /*
  * IPC request for ksmbd server startup
@@ -164,7 +165,8 @@ struct ksmbd_share_config_response {
 	__u16	force_directory_mode;
 	__u16	force_uid;
 	__u16	force_gid;
-	__u32	reserved[128];		/* Reserved room */
+	__s8	share_name[KSMBD_REQ_MAX_SHARE_NAME];
+	__u32	reserved[112];		/* Reserved room */
 	__u32	veto_list_sz;
 	__s8	____payload[];
 };
@@ -350,6 +352,8 @@ enum KSMBD_TREE_CONN_STATUS {
 #define KSMBD_SHARE_FLAG_STREAMS		BIT(11)
 #define KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS	BIT(12)
 #define KSMBD_SHARE_FLAG_ACL_XATTR		BIT(13)
+#define KSMBD_SHARE_FLAG_UPDATE			BIT(14)
+#define KSMBD_SHARE_FLAG_CROSSMNT		BIT(15)
 
 /*
  * Tree connect request flags.
@@ -365,6 +369,7 @@ enum KSMBD_TREE_CONN_STATUS {
 #define KSMBD_TREE_CONN_FLAG_READ_ONLY		BIT(1)
 #define KSMBD_TREE_CONN_FLAG_WRITABLE		BIT(2)
 #define KSMBD_TREE_CONN_FLAG_ADMIN_ACCOUNT	BIT(3)
+#define KSMBD_TREE_CONN_FLAG_UPDATE		BIT(4)
 
 /*
  * RPC over IPC.
diff --git a/fs/ksmbd/ksmbd_work.c b/fs/ksmbd/ksmbd_work.c
index fd58eb4809f6..d7c676c151e2 100644
--- a/fs/ksmbd/ksmbd_work.c
+++ b/fs/ksmbd/ksmbd_work.c
@@ -27,18 +27,38 @@ struct ksmbd_work *ksmbd_alloc_work_struct(void)
 		INIT_LIST_HEAD(&work->async_request_entry);
 		INIT_LIST_HEAD(&work->fp_entry);
 		INIT_LIST_HEAD(&work->interim_entry);
+		INIT_LIST_HEAD(&work->aux_read_list);
+		work->iov_alloc_cnt = 4;
+		work->iov = kcalloc(work->iov_alloc_cnt, sizeof(struct kvec),
+				    GFP_KERNEL);
+		if (!work->iov) {
+			kmem_cache_free(work_cache, work);
+			work = NULL;
+		}
 	}
 	return work;
 }
 
 void ksmbd_free_work_struct(struct ksmbd_work *work)
 {
+	struct aux_read *ar, *tmp;
+
 	WARN_ON(work->saved_cred != NULL);
 
 	kvfree(work->response_buf);
-	kvfree(work->aux_payload_buf);
+
+	list_for_each_entry_safe(ar, tmp, &work->aux_read_list, entry) {
+		kvfree(ar->buf);
+		list_del(&ar->entry);
+		kfree(ar);
+	}
+
 	kfree(work->tr_buf);
 	kvfree(work->request_buf);
+	kfree(work->iov);
+	if (!list_empty(&work->interim_entry))
+		list_del(&work->interim_entry);
+
 	if (work->async_id)
 		ksmbd_release_id(&work->conn->async_ida, work->async_id);
 	kmem_cache_free(work_cache, work);
@@ -69,7 +89,6 @@ int ksmbd_workqueue_init(void)
 
 void ksmbd_workqueue_destroy(void)
 {
-	flush_workqueue(ksmbd_wq);
 	destroy_workqueue(ksmbd_wq);
 	ksmbd_wq = NULL;
 }
@@ -78,3 +97,81 @@ bool ksmbd_queue_work(struct ksmbd_work *work)
 {
 	return queue_work(ksmbd_wq, &work->work);
 }
+
+static inline void __ksmbd_iov_pin(struct ksmbd_work *work, void *ib,
+				   unsigned int ib_len)
+{
+	work->iov[++work->iov_idx].iov_base = ib;
+	work->iov[work->iov_idx].iov_len = ib_len;
+	work->iov_cnt++;
+}
+
+static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
+			       void *aux_buf, unsigned int aux_size)
+{
+	struct aux_read *ar = NULL;
+	int need_iov_cnt = 1;
+
+	if (aux_size) {
+		need_iov_cnt++;
+		ar = kmalloc(sizeof(struct aux_read), GFP_KERNEL);
+		if (!ar)
+			return -ENOMEM;
+	}
+
+	if (work->iov_alloc_cnt < work->iov_cnt + need_iov_cnt) {
+		struct kvec *new;
+
+		work->iov_alloc_cnt += 4;
+		new = krealloc(work->iov,
+			       sizeof(struct kvec) * work->iov_alloc_cnt,
+			       GFP_KERNEL | __GFP_ZERO);
+		if (!new) {
+			kfree(ar);
+			work->iov_alloc_cnt -= 4;
+			return -ENOMEM;
+		}
+		work->iov = new;
+	}
+
+	/* Plus rfc_length size on first iov */
+	if (!work->iov_idx) {
+		work->iov[work->iov_idx].iov_base = work->response_buf;
+		*(__be32 *)work->iov[0].iov_base = 0;
+		work->iov[work->iov_idx].iov_len = 4;
+		work->iov_cnt++;
+	}
+
+	__ksmbd_iov_pin(work, ib, len);
+	inc_rfc1001_len(work->iov[0].iov_base, len);
+
+	if (aux_size) {
+		__ksmbd_iov_pin(work, aux_buf, aux_size);
+		inc_rfc1001_len(work->iov[0].iov_base, aux_size);
+
+		ar->buf = aux_buf;
+		list_add(&ar->entry, &work->aux_read_list);
+	}
+
+	return 0;
+}
+
+int ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len)
+{
+	return __ksmbd_iov_pin_rsp(work, ib, len, NULL, 0);
+}
+
+int ksmbd_iov_pin_rsp_read(struct ksmbd_work *work, void *ib, int len,
+			   void *aux_buf, unsigned int aux_size)
+{
+	return __ksmbd_iov_pin_rsp(work, ib, len, aux_buf, aux_size);
+}
+
+int allocate_interim_rsp_buf(struct ksmbd_work *work)
+{
+	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE, GFP_KERNEL);
+	if (!work->response_buf)
+		return -ENOMEM;
+	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
+	return 0;
+}
diff --git a/fs/ksmbd/ksmbd_work.h b/fs/ksmbd/ksmbd_work.h
index f7156bc50049..8ca2c813246e 100644
--- a/fs/ksmbd/ksmbd_work.h
+++ b/fs/ksmbd/ksmbd_work.h
@@ -19,6 +19,11 @@ enum {
 	KSMBD_WORK_CLOSED,
 };
 
+struct aux_read {
+	void *buf;
+	struct list_head entry;
+};
+
 /* one of these for every pending CIFS request at the connection */
 struct ksmbd_work {
 	/* Server corresponding to this mid */
@@ -31,13 +36,19 @@ struct ksmbd_work {
 	/* Response buffer */
 	void                            *response_buf;
 
-	/* Read data buffer */
-	void                            *aux_payload_buf;
+	struct list_head		aux_read_list;
+
+	struct kvec			*iov;
+	int				iov_alloc_cnt;
+	int				iov_cnt;
+	int				iov_idx;
 
 	/* Next cmd hdr in compound req buf*/
 	int                             next_smb2_rcv_hdr_off;
 	/* Next cmd hdr in compound rsp buf*/
 	int                             next_smb2_rsp_hdr_off;
+	/* Current cmd hdr in compound rsp buf*/
+	int                             curr_smb2_rsp_hdr_off;
 
 	/*
 	 * Current Local FID assigned compound response if SMB2 CREATE
@@ -53,22 +64,17 @@ struct ksmbd_work {
 	unsigned int			credits_granted;
 
 	/* response smb header size */
-	unsigned int                    resp_hdr_sz;
 	unsigned int                    response_sz;
-	/* Read data count */
-	unsigned int                    aux_payload_sz;
 
 	void				*tr_buf;
 
 	unsigned char			state;
-	/* Multiple responses for one request e.g. SMB ECHO */
-	bool                            multiRsp:1;
 	/* No response for cancelled request */
 	bool                            send_no_response:1;
 	/* Request is encrypted */
 	bool                            encrypted:1;
 	/* Is this SYNC or ASYNC ksmbd_work */
-	bool                            syncronous:1;
+	bool                            asynchronous:1;
 	bool                            need_invalidate_rkey:1;
 
 	unsigned int                    remote_key;
@@ -92,7 +98,16 @@ struct ksmbd_work {
  */
 static inline void *ksmbd_resp_buf_next(struct ksmbd_work *work)
 {
-	return work->response_buf + work->next_smb2_rsp_hdr_off;
+	return work->response_buf + work->next_smb2_rsp_hdr_off + 4;
+}
+
+/**
+ * ksmbd_resp_buf_curr - Get current buffer on compound response.
+ * @work: smb work containing response buffer
+ */
+static inline void *ksmbd_resp_buf_curr(struct ksmbd_work *work)
+{
+	return work->response_buf + work->curr_smb2_rsp_hdr_off + 4;
 }
 
 /**
@@ -101,7 +116,7 @@ static inline void *ksmbd_resp_buf_next(struct ksmbd_work *work)
  */
 static inline void *ksmbd_req_buf_next(struct ksmbd_work *work)
 {
-	return work->request_buf + work->next_smb2_rcv_hdr_off;
+	return work->request_buf + work->next_smb2_rcv_hdr_off + 4;
 }
 
 struct ksmbd_work *ksmbd_alloc_work_struct(void);
@@ -113,5 +128,8 @@ int ksmbd_work_pool_init(void);
 int ksmbd_workqueue_init(void);
 void ksmbd_workqueue_destroy(void);
 bool ksmbd_queue_work(struct ksmbd_work *work);
-
+int ksmbd_iov_pin_rsp_read(struct ksmbd_work *work, void *ib, int len,
+			   void *aux_buf, unsigned int aux_size);
+int ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len);
+int allocate_interim_rsp_buf(struct ksmbd_work *work);
 #endif /* __KSMBD_WORK_H__ */
diff --git a/fs/ksmbd/mgmt/share_config.c b/fs/ksmbd/mgmt/share_config.c
index cb72d30f5b71..328a412259dc 100644
--- a/fs/ksmbd/mgmt/share_config.c
+++ b/fs/ksmbd/mgmt/share_config.c
@@ -16,6 +16,7 @@
 #include "user_config.h"
 #include "user_session.h"
 #include "../transport_ipc.h"
+#include "../misc.h"
 
 #define SHARE_HASH_BITS		3
 static DEFINE_HASHTABLE(shares_table, SHARE_HASH_BITS);
@@ -26,7 +27,7 @@ struct ksmbd_veto_pattern {
 	struct list_head	list;
 };
 
-static unsigned int share_name_hash(char *name)
+static unsigned int share_name_hash(const char *name)
 {
 	return jhash(name, strlen(name), 0);
 }
@@ -51,12 +52,16 @@ static void kill_share(struct ksmbd_share_config *share)
 	kfree(share);
 }
 
-void __ksmbd_share_config_put(struct ksmbd_share_config *share)
+void ksmbd_share_config_del(struct ksmbd_share_config *share)
 {
 	down_write(&shares_table_lock);
 	hash_del(&share->hlist);
 	up_write(&shares_table_lock);
+}
 
+void __ksmbd_share_config_put(struct ksmbd_share_config *share)
+{
+	ksmbd_share_config_del(share);
 	kill_share(share);
 }
 
@@ -68,7 +73,7 @@ __get_share_config(struct ksmbd_share_config *share)
 	return share;
 }
 
-static struct ksmbd_share_config *__share_lookup(char *name)
+static struct ksmbd_share_config *__share_lookup(const char *name)
 {
 	struct ksmbd_share_config *share;
 	unsigned int key = share_name_hash(name);
@@ -115,7 +120,8 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 	return 0;
 }
 
-static struct ksmbd_share_config *share_config_request(char *name)
+static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
+						       const char *name)
 {
 	struct ksmbd_share_config_response *resp;
 	struct ksmbd_share_config *share = NULL;
@@ -129,6 +135,19 @@ static struct ksmbd_share_config *share_config_request(char *name)
 	if (resp->flags == KSMBD_SHARE_FLAG_INVALID)
 		goto out;
 
+	if (*resp->share_name) {
+		char *cf_resp_name;
+		bool equal;
+
+		cf_resp_name = ksmbd_casefold_sharename(um, resp->share_name);
+		if (IS_ERR(cf_resp_name))
+			goto out;
+		equal = !strcmp(cf_resp_name, name);
+		kfree(cf_resp_name);
+		if (!equal)
+			goto out;
+	}
+
 	share = kzalloc(sizeof(struct ksmbd_share_config), GFP_KERNEL);
 	if (!share)
 		goto out;
@@ -186,20 +205,11 @@ static struct ksmbd_share_config *share_config_request(char *name)
 	return share;
 }
 
-static void strtolower(char *share_name)
-{
-	while (*share_name) {
-		*share_name = tolower(*share_name);
-		share_name++;
-	}
-}
-
-struct ksmbd_share_config *ksmbd_share_config_get(char *name)
+struct ksmbd_share_config *ksmbd_share_config_get(struct unicode_map *um,
+						  const char *name)
 {
 	struct ksmbd_share_config *share;
 
-	strtolower(name);
-
 	down_read(&shares_table_lock);
 	share = __share_lookup(name);
 	if (share)
@@ -208,7 +218,7 @@ struct ksmbd_share_config *ksmbd_share_config_get(char *name)
 
 	if (share)
 		return share;
-	return share_config_request(name);
+	return share_config_request(um, name);
 }
 
 bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
@@ -222,17 +232,3 @@ bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
 	}
 	return false;
 }
-
-void ksmbd_share_configs_cleanup(void)
-{
-	struct ksmbd_share_config *share;
-	struct hlist_node *tmp;
-	int i;
-
-	down_write(&shares_table_lock);
-	hash_for_each_safe(shares_table, i, tmp, share, hlist) {
-		hash_del(&share->hlist);
-		kill_share(share);
-	}
-	up_write(&shares_table_lock);
-}
diff --git a/fs/ksmbd/mgmt/share_config.h b/fs/ksmbd/mgmt/share_config.h
index 953befc94e84..5f591751b923 100644
--- a/fs/ksmbd/mgmt/share_config.h
+++ b/fs/ksmbd/mgmt/share_config.h
@@ -9,6 +9,7 @@
 #include <linux/workqueue.h>
 #include <linux/hashtable.h>
 #include <linux/path.h>
+#include <linux/unicode.h>
 
 struct ksmbd_share_config {
 	char			*name;
@@ -33,29 +34,22 @@ struct ksmbd_share_config {
 #define KSMBD_SHARE_INVALID_UID	((__u16)-1)
 #define KSMBD_SHARE_INVALID_GID	((__u16)-1)
 
-static inline int share_config_create_mode(struct ksmbd_share_config *share,
-					   umode_t posix_mode)
+static inline umode_t
+share_config_create_mode(struct ksmbd_share_config *share,
+			 umode_t posix_mode)
 {
-	if (!share->force_create_mode) {
-		if (!posix_mode)
-			return share->create_mask;
-		else
-			return posix_mode & share->create_mask;
-	}
-	return share->force_create_mode & share->create_mask;
+	umode_t mode = (posix_mode ?: (umode_t)-1) & share->create_mask;
+
+	return mode | share->force_create_mode;
 }
 
-static inline int share_config_directory_mode(struct ksmbd_share_config *share,
-					      umode_t posix_mode)
+static inline umode_t
+share_config_directory_mode(struct ksmbd_share_config *share,
+			    umode_t posix_mode)
 {
-	if (!share->force_directory_mode) {
-		if (!posix_mode)
-			return share->directory_mask;
-		else
-			return posix_mode & share->directory_mask;
-	}
+	umode_t mode = (posix_mode ?: (umode_t)-1) & share->directory_mask;
 
-	return share->force_directory_mode & share->directory_mask;
+	return mode | share->force_directory_mode;
 }
 
 static inline int test_share_config_flag(struct ksmbd_share_config *share,
@@ -64,6 +58,7 @@ static inline int test_share_config_flag(struct ksmbd_share_config *share,
 	return share->flags & flag;
 }
 
+void ksmbd_share_config_del(struct ksmbd_share_config *share);
 void __ksmbd_share_config_put(struct ksmbd_share_config *share);
 
 static inline void ksmbd_share_config_put(struct ksmbd_share_config *share)
@@ -73,9 +68,8 @@ static inline void ksmbd_share_config_put(struct ksmbd_share_config *share)
 	__ksmbd_share_config_put(share);
 }
 
-struct ksmbd_share_config *ksmbd_share_config_get(char *name);
+struct ksmbd_share_config *ksmbd_share_config_get(struct unicode_map *um,
+						  const char *name);
 bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
 			       const char *filename);
-void ksmbd_share_configs_cleanup(void);
-
 #endif /* __SHARE_CONFIG_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
index dd262daa2c4a..d2c81a8a11dd 100644
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -17,7 +17,7 @@
 
 struct ksmbd_tree_conn_status
 ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
-			char *share_name)
+			const char *share_name)
 {
 	struct ksmbd_tree_conn_status status = {-ENOENT, NULL};
 	struct ksmbd_tree_connect_response *resp = NULL;
@@ -26,7 +26,7 @@ ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 	struct sockaddr *peer_addr;
 	int ret;
 
-	sc = ksmbd_share_config_get(share_name);
+	sc = ksmbd_share_config_get(conn->um, share_name);
 	if (!sc)
 		return status;
 
@@ -57,9 +57,26 @@ ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 		goto out_error;
 
 	tree_conn->flags = resp->connection_flags;
+	if (test_tree_conn_flag(tree_conn, KSMBD_TREE_CONN_FLAG_UPDATE)) {
+		struct ksmbd_share_config *new_sc;
+
+		ksmbd_share_config_del(sc);
+		new_sc = ksmbd_share_config_get(conn->um, share_name);
+		if (!new_sc) {
+			pr_err("Failed to update stale share config\n");
+			status.ret = -ESTALE;
+			goto out_error;
+		}
+		ksmbd_share_config_put(sc);
+		sc = new_sc;
+	}
+
 	tree_conn->user = sess->user;
 	tree_conn->share_conf = sc;
+	tree_conn->t_state = TREE_NEW;
 	status.tree_conn = tree_conn;
+	atomic_set(&tree_conn->refcount, 1);
+	init_waitqueue_head(&tree_conn->refcount_q);
 
 	ret = xa_err(xa_store(&sess->tree_conns, tree_conn->id, tree_conn,
 			      GFP_KERNEL));
@@ -79,14 +96,33 @@ ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 	return status;
 }
 
+void ksmbd_tree_connect_put(struct ksmbd_tree_connect *tcon)
+{
+	/*
+	 * Checking waitqueue to releasing tree connect on
+	 * tree disconnect. waitqueue_active is safe because it
+	 * uses atomic operation for condition.
+	 */
+	if (!atomic_dec_return(&tcon->refcount) &&
+	    waitqueue_active(&tcon->refcount_q))
+		wake_up(&tcon->refcount_q);
+}
+
 int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 			       struct ksmbd_tree_connect *tree_conn)
 {
 	int ret;
 
+	write_lock(&sess->tree_conns_lock);
+	xa_erase(&sess->tree_conns, tree_conn->id);
+	write_unlock(&sess->tree_conns_lock);
+
+	if (!atomic_dec_and_test(&tree_conn->refcount))
+		wait_event(tree_conn->refcount_q,
+			   atomic_read(&tree_conn->refcount) == 0);
+
 	ret = ksmbd_ipc_tree_disconnect_request(sess->id, tree_conn->id);
 	ksmbd_release_tree_conn_id(sess, tree_conn->id);
-	xa_erase(&sess->tree_conns, tree_conn->id);
 	ksmbd_share_config_put(tree_conn->share_conf);
 	kfree(tree_conn);
 	return ret;
@@ -95,18 +131,19 @@ int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
 						  unsigned int id)
 {
-	return xa_load(&sess->tree_conns, id);
-}
-
-struct ksmbd_share_config *ksmbd_tree_conn_share(struct ksmbd_session *sess,
-						 unsigned int id)
-{
-	struct ksmbd_tree_connect *tc;
+	struct ksmbd_tree_connect *tcon;
+
+	read_lock(&sess->tree_conns_lock);
+	tcon = xa_load(&sess->tree_conns, id);
+	if (tcon) {
+		if (tcon->t_state != TREE_CONNECTED)
+			tcon = NULL;
+		else if (!atomic_inc_not_zero(&tcon->refcount))
+			tcon = NULL;
+	}
+	read_unlock(&sess->tree_conns_lock);
 
-	tc = ksmbd_tree_conn_lookup(sess, id);
-	if (tc)
-		return tc->share_conf;
-	return NULL;
+	return tcon;
 }
 
 int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess)
@@ -115,8 +152,21 @@ int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess)
 	struct ksmbd_tree_connect *tc;
 	unsigned long id;
 
-	xa_for_each(&sess->tree_conns, id, tc)
+	if (!sess)
+		return -EINVAL;
+
+	xa_for_each(&sess->tree_conns, id, tc) {
+		write_lock(&sess->tree_conns_lock);
+		if (tc->t_state == TREE_DISCONNECTED) {
+			write_unlock(&sess->tree_conns_lock);
+			ret = -ENOENT;
+			continue;
+		}
+		tc->t_state = TREE_DISCONNECTED;
+		write_unlock(&sess->tree_conns_lock);
+
 		ret |= ksmbd_tree_conn_disconnect(sess, tc);
+	}
 	xa_destroy(&sess->tree_conns);
 	return ret;
 }
diff --git a/fs/ksmbd/mgmt/tree_connect.h b/fs/ksmbd/mgmt/tree_connect.h
index 71e50271dccf..6377a70b811c 100644
--- a/fs/ksmbd/mgmt/tree_connect.h
+++ b/fs/ksmbd/mgmt/tree_connect.h
@@ -14,6 +14,12 @@ struct ksmbd_share_config;
 struct ksmbd_user;
 struct ksmbd_conn;
 
+enum {
+	TREE_NEW = 0,
+	TREE_CONNECTED,
+	TREE_DISCONNECTED
+};
+
 struct ksmbd_tree_connect {
 	int				id;
 
@@ -25,6 +31,9 @@ struct ksmbd_tree_connect {
 
 	int				maximal_access;
 	bool				posix_extensions;
+	atomic_t			refcount;
+	wait_queue_head_t		refcount_q;
+	unsigned int			t_state;
 };
 
 struct ksmbd_tree_conn_status {
@@ -42,7 +51,8 @@ struct ksmbd_session;
 
 struct ksmbd_tree_conn_status
 ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
-			char *share_name);
+			const char *share_name);
+void ksmbd_tree_connect_put(struct ksmbd_tree_connect *tcon);
 
 int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 			       struct ksmbd_tree_connect *tree_conn);
@@ -50,9 +60,6 @@ int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
 						  unsigned int id);
 
-struct ksmbd_share_config *ksmbd_tree_conn_share(struct ksmbd_session *sess,
-						 unsigned int id);
-
 int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess);
 
 #endif /* __TREE_CONNECT_MANAGEMENT_H__ */
diff --git a/fs/ksmbd/mgmt/user_config.h b/fs/ksmbd/mgmt/user_config.h
index 6a44109617f1..e068a19fd904 100644
--- a/fs/ksmbd/mgmt/user_config.h
+++ b/fs/ksmbd/mgmt/user_config.h
@@ -18,7 +18,6 @@ struct ksmbd_user {
 
 	size_t			passkey_sz;
 	char			*passkey;
-	unsigned int		failed_login_count;
 };
 
 static inline bool user_guest(struct ksmbd_user *user)
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 92b1603b5abe..15f68ee05089 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -25,20 +25,19 @@ static DECLARE_RWSEM(sessions_table_lock);
 struct ksmbd_session_rpc {
 	int			id;
 	unsigned int		method;
-	struct list_head	list;
 };
 
 static void free_channel_list(struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
+	struct channel *chann;
+	unsigned long index;
 
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		list_del(&chann->chann_list);
+	xa_for_each(&sess->ksmbd_chann_list, index, chann) {
+		xa_erase(&sess->ksmbd_chann_list, index);
 		kfree(chann);
 	}
-	write_unlock(&sess->chann_lock);
+
+	xa_destroy(&sess->ksmbd_chann_list);
 }
 
 static void __session_rpc_close(struct ksmbd_session *sess,
@@ -58,15 +57,14 @@ static void __session_rpc_close(struct ksmbd_session *sess,
 static void ksmbd_session_rpc_clear_list(struct ksmbd_session *sess)
 {
 	struct ksmbd_session_rpc *entry;
+	long index;
 
-	while (!list_empty(&sess->rpc_handle_list)) {
-		entry = list_entry(sess->rpc_handle_list.next,
-				   struct ksmbd_session_rpc,
-				   list);
-
-		list_del(&entry->list);
+	xa_for_each(&sess->rpc_handle_list, index, entry) {
+		xa_erase(&sess->rpc_handle_list, index);
 		__session_rpc_close(sess, entry);
 	}
+
+	xa_destroy(&sess->rpc_handle_list);
 }
 
 static int __rpc_method(char *rpc_name)
@@ -102,13 +100,13 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 
 	entry = kzalloc(sizeof(struct ksmbd_session_rpc), GFP_KERNEL);
 	if (!entry)
-		return -EINVAL;
+		return -ENOMEM;
 
-	list_add(&entry->list, &sess->rpc_handle_list);
 	entry->method = method;
 	entry->id = ksmbd_ipc_id_alloc();
 	if (entry->id < 0)
 		goto free_entry;
+	xa_store(&sess->rpc_handle_list, entry->id, entry, GFP_KERNEL);
 
 	resp = ksmbd_rpc_open(sess, entry->id);
 	if (!resp)
@@ -117,9 +115,9 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	kvfree(resp);
 	return entry->id;
 free_id:
+	xa_erase(&sess->rpc_handle_list, entry->id);
 	ksmbd_rpc_id_free(entry->id);
 free_entry:
-	list_del(&entry->list);
 	kfree(entry);
 	return -EINVAL;
 }
@@ -128,24 +126,17 @@ void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
 
-	list_for_each_entry(entry, &sess->rpc_handle_list, list) {
-		if (entry->id == id) {
-			list_del(&entry->list);
-			__session_rpc_close(sess, entry);
-			break;
-		}
-	}
+	entry = xa_erase(&sess->rpc_handle_list, id);
+	if (entry)
+		__session_rpc_close(sess, entry);
 }
 
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
 
-	list_for_each_entry(entry, &sess->rpc_handle_list, list) {
-		if (entry->id == id)
-			return entry->method;
-	}
-	return 0;
+	entry = xa_load(&sess->rpc_handle_list, id);
+	return entry ? entry->method : 0;
 }
 
 void ksmbd_session_destroy(struct ksmbd_session *sess)
@@ -153,10 +144,6 @@ void ksmbd_session_destroy(struct ksmbd_session *sess)
 	if (!sess)
 		return;
 
-	down_write(&sessions_table_lock);
-	hash_del(&sess->hlist);
-	up_write(&sessions_table_lock);
-
 	if (sess->user)
 		ksmbd_free_user(sess->user);
 
@@ -174,76 +161,105 @@ static struct ksmbd_session *__session_lookup(unsigned long long id)
 	struct ksmbd_session *sess;
 
 	hash_for_each_possible(sessions_table, sess, hlist, id) {
-		if (id == sess->id)
+		if (id == sess->id) {
+			sess->last_active = jiffies;
 			return sess;
+		}
 	}
 	return NULL;
 }
 
+static void ksmbd_expire_session(struct ksmbd_conn *conn)
+{
+	unsigned long id;
+	struct ksmbd_session *sess;
+
+	down_write(&conn->session_lock);
+	xa_for_each(&conn->sessions, id, sess) {
+		if (sess->state != SMB2_SESSION_VALID ||
+		    time_after(jiffies,
+			       sess->last_active + SMB2_SESSION_TIMEOUT)) {
+			xa_erase(&conn->sessions, sess->id);
+			hash_del(&sess->hlist);
+			ksmbd_session_destroy(sess);
+			continue;
+		}
+	}
+	up_write(&conn->session_lock);
+}
+
 int ksmbd_session_register(struct ksmbd_conn *conn,
 			   struct ksmbd_session *sess)
 {
 	sess->dialect = conn->dialect;
 	memcpy(sess->ClientGUID, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
+	ksmbd_expire_session(conn);
 	return xa_err(xa_store(&conn->sessions, sess->id, sess, GFP_KERNEL));
 }
 
 static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
-
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		if (chann->conn == conn) {
-			list_del(&chann->chann_list);
-			kfree(chann);
-			write_unlock(&sess->chann_lock);
-			return 0;
-		}
-	}
-	write_unlock(&sess->chann_lock);
+	struct channel *chann;
+
+	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
+	if (!chann)
+		return -ENOENT;
 
-	return -ENOENT;
+	kfree(chann);
+	return 0;
 }
 
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 {
 	struct ksmbd_session *sess;
+	unsigned long id;
 
+	down_write(&sessions_table_lock);
 	if (conn->binding) {
 		int bkt;
+		struct hlist_node *tmp;
 
-		down_write(&sessions_table_lock);
-		hash_for_each(sessions_table, bkt, sess, hlist) {
-			if (!ksmbd_chann_del(conn, sess)) {
-				up_write(&sessions_table_lock);
-				goto sess_destroy;
+		hash_for_each_safe(sessions_table, bkt, tmp, sess, hlist) {
+			if (!ksmbd_chann_del(conn, sess) &&
+			    xa_empty(&sess->ksmbd_chann_list)) {
+				hash_del(&sess->hlist);
+				ksmbd_session_destroy(sess);
 			}
 		}
-		up_write(&sessions_table_lock);
-	} else {
-		unsigned long id;
-
-		xa_for_each(&conn->sessions, id, sess) {
-			if (!ksmbd_chann_del(conn, sess))
-				goto sess_destroy;
-		}
 	}
+	up_write(&sessions_table_lock);
 
-	return;
+	down_write(&conn->session_lock);
+	xa_for_each(&conn->sessions, id, sess) {
+		unsigned long chann_id;
+		struct channel *chann;
 
-sess_destroy:
-	if (list_empty(&sess->ksmbd_chann_list)) {
-		xa_erase(&conn->sessions, sess->id);
-		ksmbd_session_destroy(sess);
+		xa_for_each(&sess->ksmbd_chann_list, chann_id, chann) {
+			if (chann->conn != conn)
+				ksmbd_conn_set_exiting(chann->conn);
+		}
+
+		ksmbd_chann_del(conn, sess);
+		if (xa_empty(&sess->ksmbd_chann_list)) {
+			xa_erase(&conn->sessions, sess->id);
+			hash_del(&sess->hlist);
+			ksmbd_session_destroy(sess);
+		}
 	}
+	up_write(&conn->session_lock);
 }
 
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
 					   unsigned long long id)
 {
-	return xa_load(&conn->sessions, id);
+	struct ksmbd_session *sess;
+
+	down_read(&conn->session_lock);
+	sess = xa_load(&conn->sessions, id);
+	if (sess)
+		sess->last_active = jiffies;
+	up_read(&conn->session_lock);
+	return sess;
 }
 
 struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
@@ -252,6 +268,8 @@ struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
 
 	down_read(&sessions_table_lock);
 	sess = __session_lookup(id);
+	if (sess)
+		sess->last_active = jiffies;
 	up_read(&sessions_table_lock);
 
 	return sess;
@@ -320,6 +338,9 @@ static struct ksmbd_session *__session_create(int protocol)
 	struct ksmbd_session *sess;
 	int ret;
 
+	if (protocol != CIFDS_SESSION_FLAG_SMB2)
+		return NULL;
+
 	sess = kzalloc(sizeof(struct ksmbd_session), GFP_KERNEL);
 	if (!sess)
 		return NULL;
@@ -327,32 +348,25 @@ static struct ksmbd_session *__session_create(int protocol)
 	if (ksmbd_init_file_table(&sess->file_table))
 		goto error;
 
+	sess->last_active = jiffies;
+	sess->state = SMB2_SESSION_IN_PROGRESS;
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
-	INIT_LIST_HEAD(&sess->ksmbd_chann_list);
-	INIT_LIST_HEAD(&sess->rpc_handle_list);
+	xa_init(&sess->ksmbd_chann_list);
+	xa_init(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
-	rwlock_init(&sess->chann_lock);
-
-	switch (protocol) {
-	case CIFDS_SESSION_FLAG_SMB2:
-		ret = __init_smb2_session(sess);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
+	rwlock_init(&sess->tree_conns_lock);
 
+	ret = __init_smb2_session(sess);
 	if (ret)
 		goto error;
 
 	ida_init(&sess->tree_conn_ida);
 
-	if (protocol == CIFDS_SESSION_FLAG_SMB2) {
-		down_write(&sessions_table_lock);
-		hash_add(sessions_table, &sess->hlist, sess->id);
-		up_write(&sessions_table_lock);
-	}
+	down_write(&sessions_table_lock);
+	hash_add(sessions_table, &sess->hlist, sess->id);
+	up_write(&sessions_table_lock);
+
 	return sess;
 
 error:
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 8934b8ee275b..63cb08fffde8 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -21,7 +21,6 @@ struct ksmbd_file_table;
 struct channel {
 	__u8			smb3signingkey[SMB3_SIGN_KEY_SIZE];
 	struct ksmbd_conn	*conn;
-	struct list_head	chann_list;
 };
 
 struct preauth_session {
@@ -50,17 +49,18 @@ struct ksmbd_session {
 	char				sess_key[CIFS_KEY_SIZE];
 
 	struct hlist_node		hlist;
-	rwlock_t			chann_lock;
-	struct list_head		ksmbd_chann_list;
+	struct xarray			ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
-	struct list_head		rpc_handle_list;
+	struct xarray			rpc_handle_list;
 
 	__u8				smb3encryptionkey[SMB3_ENC_DEC_KEY_SIZE];
 	__u8				smb3decryptionkey[SMB3_ENC_DEC_KEY_SIZE];
 	__u8				smb3signingkey[SMB3_SIGN_KEY_SIZE];
 
 	struct ksmbd_file_table		file_table;
+	unsigned long			last_active;
+	rwlock_t			tree_conns_lock;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
diff --git a/fs/ksmbd/misc.c b/fs/ksmbd/misc.c
index 60e7ac62c917..9e8afaa686e3 100644
--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/xattr.h>
 #include <linux/fs.h>
+#include <linux/unicode.h>
 
 #include "misc.h"
 #include "smb_common.h"
@@ -20,7 +21,7 @@
  * wildcard '*' and '?'
  * TODO : implement consideration about DOS_DOT, DOS_QM and DOS_STAR
  *
- * @string:	string to compare with a pattern
+ * @str:	string to compare with a pattern
  * @len:	string length
  * @pattern:	pattern string which might include wildcard '*' and '?'
  *
@@ -152,25 +153,47 @@ int parse_stream_name(char *filename, char **stream_name, int *s_type)
 /**
  * convert_to_nt_pathname() - extract and return windows path string
  *      whose share directory prefix was removed from file path
- * @filename : unix filename
- * @sharepath: share path string
+ * @share: ksmbd_share_config pointer
+ * @path: path to report
  *
  * Return : windows path string or error
  */
 
-char *convert_to_nt_pathname(char *filename)
+char *convert_to_nt_pathname(struct ksmbd_share_config *share,
+			     const struct path *path)
 {
-	char *ab_pathname;
+	char *pathname, *ab_pathname, *nt_pathname;
+	int share_path_len = share->path_sz;
 
-	if (strlen(filename) == 0)
-		filename = "\\";
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathname)
+		return ERR_PTR(-EACCES);
 
-	ab_pathname = kstrdup(filename, GFP_KERNEL);
-	if (!ab_pathname)
-		return NULL;
+	ab_pathname = d_path(path, pathname, PATH_MAX);
+	if (IS_ERR(ab_pathname)) {
+		nt_pathname = ERR_PTR(-EACCES);
+		goto free_pathname;
+	}
+
+	if (strncmp(ab_pathname, share->path, share_path_len)) {
+		nt_pathname = ERR_PTR(-EACCES);
+		goto free_pathname;
+	}
+
+	nt_pathname = kzalloc(strlen(&ab_pathname[share_path_len]) + 2, GFP_KERNEL);
+	if (!nt_pathname) {
+		nt_pathname = ERR_PTR(-ENOMEM);
+		goto free_pathname;
+	}
+	if (ab_pathname[share_path_len] == '\0')
+		strcpy(nt_pathname, "/");
+	strcat(nt_pathname, &ab_pathname[share_path_len]);
+
+	ksmbd_conv_path_to_windows(nt_pathname);
 
-	ksmbd_conv_path_to_windows(ab_pathname);
-	return ab_pathname;
+free_pathname:
+	kfree(pathname);
+	return nt_pathname;
 }
 
 int get_nlink(struct kstat *st)
@@ -204,32 +227,59 @@ void ksmbd_conv_path_to_windows(char *path)
 	strreplace(path, '/', '\\');
 }
 
+char *ksmbd_casefold_sharename(struct unicode_map *um, const char *name)
+{
+	char *cf_name;
+	int cf_len;
+
+	cf_name = kzalloc(KSMBD_REQ_MAX_SHARE_NAME, GFP_KERNEL);
+	if (!cf_name)
+		return ERR_PTR(-ENOMEM);
+
+	if (IS_ENABLED(CONFIG_UNICODE) && um) {
+		const struct qstr q_name = {.name = name, .len = strlen(name)};
+
+		cf_len = utf8_casefold(um, &q_name, cf_name,
+				       KSMBD_REQ_MAX_SHARE_NAME);
+		if (cf_len < 0)
+			goto out_ascii;
+
+		return cf_name;
+	}
+
+out_ascii:
+	cf_len = strscpy(cf_name, name, KSMBD_REQ_MAX_SHARE_NAME);
+	if (cf_len < 0) {
+		kfree(cf_name);
+		return ERR_PTR(-E2BIG);
+	}
+
+	for (; *cf_name; ++cf_name)
+		*cf_name = isascii(*cf_name) ? tolower(*cf_name) : *cf_name;
+	return cf_name - cf_len;
+}
+
 /**
  * ksmbd_extract_sharename() - get share name from tree connect request
  * @treename:	buffer containing tree name and share name
  *
  * Return:      share name on success, otherwise error
  */
-char *ksmbd_extract_sharename(char *treename)
+char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename)
 {
-	char *name = treename;
-	char *dst;
-	char *pos = strrchr(name, '\\');
+	const char *name = treename, *pos = strrchr(name, '\\');
 
 	if (pos)
 		name = (pos + 1);
 
 	/* caller has to free the memory */
-	dst = kstrdup(name, GFP_KERNEL);
-	if (!dst)
-		return ERR_PTR(-ENOMEM);
-	return dst;
+	return ksmbd_casefold_sharename(um, name);
 }
 
 /**
  * convert_to_unix_name() - convert windows name to unix format
- * @path:	name to be converted
- * @tid:	tree id of mathing share
+ * @share:	ksmbd_share_config pointer
+ * @name:	file name that is relative to share
  *
  * Return:	converted name on success, otherwise NULL
  */
diff --git a/fs/ksmbd/misc.h b/fs/ksmbd/misc.h
index 253366bd0951..1facfcd21200 100644
--- a/fs/ksmbd/misc.h
+++ b/fs/ksmbd/misc.h
@@ -14,12 +14,14 @@ struct ksmbd_file;
 int match_pattern(const char *str, size_t len, const char *pattern);
 int ksmbd_validate_filename(char *filename);
 int parse_stream_name(char *filename, char **stream_name, int *s_type);
-char *convert_to_nt_pathname(char *filename);
+char *convert_to_nt_pathname(struct ksmbd_share_config *share,
+			     const struct path *path);
 int get_nlink(struct kstat *st);
 void ksmbd_conv_path_to_unix(char *path);
 void ksmbd_strip_last_slash(char *path);
 void ksmbd_conv_path_to_windows(char *path);
-char *ksmbd_extract_sharename(char *treename);
+char *ksmbd_casefold_sharename(struct unicode_map *um, const char *name);
+char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename);
 char *convert_to_unix_name(struct ksmbd_share_config *share, const char *name);
 
 #define KSMBD_DIR_INFO_ALIGNMENT	8
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 9722e5237799..1cf2d2a3746a 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -157,13 +157,42 @@ static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
 	rcu_read_lock();
 	opinfo = list_first_or_null_rcu(&ci->m_op_list, struct oplock_info,
 					op_entry);
-	if (opinfo && !atomic_inc_not_zero(&opinfo->refcount))
-		opinfo = NULL;
+	if (opinfo) {
+		if (!atomic_inc_not_zero(&opinfo->refcount))
+			opinfo = NULL;
+		else {
+			atomic_inc(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				atomic_dec(&opinfo->conn->r_count);
+				atomic_dec(&opinfo->refcount);
+				opinfo = NULL;
+			}
+		}
+	}
+
 	rcu_read_unlock();
 
 	return opinfo;
 }
 
+static void opinfo_conn_put(struct oplock_info *opinfo)
+{
+	struct ksmbd_conn *conn;
+
+	if (!opinfo)
+		return;
+
+	conn = opinfo->conn;
+	/*
+	 * Checking waitqueue to dropping pending requests on
+	 * disconnection. waitqueue_active is safe because it
+	 * uses atomic operation for condition.
+	 */
+	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
+		wake_up(&conn->r_count_q);
+	opinfo_put(opinfo);
+}
+
 void opinfo_put(struct oplock_info *opinfo)
 {
 	if (!atomic_dec_and_test(&opinfo->refcount))
@@ -587,15 +616,6 @@ static int oplock_break_pending(struct oplock_info *opinfo, int req_op_level)
 	return 0;
 }
 
-static inline int allocate_oplock_break_buf(struct ksmbd_work *work)
-{
-	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE, GFP_KERNEL);
-	if (!work->response_buf)
-		return -ENOMEM;
-	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
-	return 0;
-}
-
 /**
  * __smb2_oplock_break_noti() - send smb2 oplock break cmd from conn
  * to client
@@ -610,30 +630,22 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 {
 	struct smb2_oplock_break *rsp = NULL;
 	struct ksmbd_work *work = container_of(wk, struct ksmbd_work, work);
-	struct ksmbd_conn *conn = work->conn;
 	struct oplock_break_info *br_info = work->request_buf;
 	struct smb2_hdr *rsp_hdr;
 	struct ksmbd_file *fp;
 
 	fp = ksmbd_lookup_durable_fd(br_info->fid);
-	if (!fp) {
-		atomic_dec(&conn->r_count);
-		ksmbd_free_work_struct(work);
-		return;
-	}
+	if (!fp)
+		goto out;
 
-	if (allocate_oplock_break_buf(work)) {
+	if (allocate_interim_rsp_buf(work)) {
 		pr_err("smb2_allocate_rsp_buf failed! ");
-		atomic_dec(&conn->r_count);
 		ksmbd_fd_put(work, fp);
-		ksmbd_free_work_struct(work);
-		return;
+		goto out;
 	}
 
-	rsp_hdr = work->response_buf;
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
@@ -646,7 +658,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = work->response_buf;
+	rsp = smb2_get_msg(work->response_buf);
 
 	rsp->StructureSize = cpu_to_le16(24);
 	if (!br_info->open_trunc &&
@@ -657,19 +669,22 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 		rsp->OplockLevel = SMB2_OPLOCK_LEVEL_NONE;
 	rsp->Reserved = 0;
 	rsp->Reserved2 = 0;
-	rsp->PersistentFid = cpu_to_le64(fp->persistent_id);
-	rsp->VolatileFid = cpu_to_le64(fp->volatile_id);
+	rsp->PersistentFid = fp->persistent_id;
+	rsp->VolatileFid = fp->volatile_id;
 
-	inc_rfc1001_len(rsp, 24);
+	ksmbd_fd_put(work, fp);
+	if (ksmbd_iov_pin_rsp(work, (void *)rsp,
+			      sizeof(struct smb2_oplock_break)))
+		goto out;
 
 	ksmbd_debug(OPLOCK,
 		    "sending oplock break v_id %llu p_id = %llu lock level = %d\n",
 		    rsp->VolatileFid, rsp->PersistentFid, rsp->OplockLevel);
 
-	ksmbd_fd_put(work, fp);
 	ksmbd_conn_write(work);
+
+out:
 	ksmbd_free_work_struct(work);
-	atomic_dec(&conn->r_count);
 }
 
 /**
@@ -703,7 +718,6 @@ static int smb2_oplock_break_noti(struct oplock_info *opinfo)
 	work->conn = conn;
 	work->sess = opinfo->sess;
 
-	atomic_inc(&conn->r_count);
 	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
 		INIT_WORK(&work->work, __smb2_oplock_break_noti);
 		ksmbd_queue_work(work);
@@ -727,20 +741,15 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	struct smb2_lease_break *rsp = NULL;
 	struct ksmbd_work *work = container_of(wk, struct ksmbd_work, work);
 	struct lease_break_info *br_info = work->request_buf;
-	struct ksmbd_conn *conn = work->conn;
 	struct smb2_hdr *rsp_hdr;
 
-	if (allocate_oplock_break_buf(work)) {
+	if (allocate_interim_rsp_buf(work)) {
 		ksmbd_debug(OPLOCK, "smb2_allocate_rsp_buf failed! ");
-		ksmbd_free_work_struct(work);
-		atomic_dec(&conn->r_count);
-		return;
+		goto out;
 	}
 
-	rsp_hdr = work->response_buf;
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
@@ -753,7 +762,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = work->response_buf;
+	rsp = smb2_get_msg(work->response_buf);
 	rsp->StructureSize = cpu_to_le16(44);
 	rsp->Epoch = br_info->epoch;
 	rsp->Flags = 0;
@@ -769,11 +778,14 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	rsp->AccessMaskHint = 0;
 	rsp->ShareMaskHint = 0;
 
-	inc_rfc1001_len(rsp, 44);
+	if (ksmbd_iov_pin_rsp(work, (void *)rsp,
+			      sizeof(struct smb2_lease_break)))
+		goto out;
 
 	ksmbd_conn_write(work);
+
+out:
 	ksmbd_free_work_struct(work);
-	atomic_dec(&conn->r_count);
 }
 
 /**
@@ -813,7 +825,6 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 	work->conn = conn;
 	work->sess = opinfo->sess;
 
-	atomic_inc(&conn->r_count);
 	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
 		list_for_each_safe(tmp, t, &opinfo->interim_list) {
 			struct ksmbd_work *in_work;
@@ -822,7 +833,8 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 					     interim_entry);
 			setup_async_work(in_work, NULL, NULL);
 			smb2_send_interim_resp(in_work, STATUS_PENDING);
-			list_del(&in_work->interim_entry);
+			list_del_init(&in_work->interim_entry);
+			release_async_work(in_work);
 		}
 		INIT_WORK(&work->work, __smb2_lease_break_noti);
 		ksmbd_queue_work(work);
@@ -1135,8 +1147,10 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	}
 	prev_opinfo = opinfo_get_list(ci);
 	if (!prev_opinfo ||
-	    (prev_opinfo->level == SMB2_OPLOCK_LEVEL_NONE && lctx))
+	    (prev_opinfo->level == SMB2_OPLOCK_LEVEL_NONE && lctx)) {
+		opinfo_conn_put(prev_opinfo);
 		goto set_lev;
+	}
 	prev_op_has_lease = prev_opinfo->is_lease;
 	if (prev_op_has_lease)
 		prev_op_state = prev_opinfo->o_lease->state;
@@ -1144,19 +1158,19 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	if (share_ret < 0 &&
 	    prev_opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
 		err = share_ret;
-		opinfo_put(prev_opinfo);
+		opinfo_conn_put(prev_opinfo);
 		goto err_out;
 	}
 
 	if (prev_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
 	    prev_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
-		opinfo_put(prev_opinfo);
+		opinfo_conn_put(prev_opinfo);
 		goto op_break_not_needed;
 	}
 
 	list_add(&work->interim_entry, &prev_opinfo->interim_list);
 	err = oplock_break(prev_opinfo, SMB2_OPLOCK_LEVEL_II);
-	opinfo_put(prev_opinfo);
+	opinfo_conn_put(prev_opinfo);
 	if (err == -ENOENT)
 		goto set_lev;
 	/* Check all oplock was freed by close */
@@ -1219,14 +1233,14 @@ static void smb_break_all_write_oplock(struct ksmbd_work *work,
 		return;
 	if (brk_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
 	    brk_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
-		opinfo_put(brk_opinfo);
+		opinfo_conn_put(brk_opinfo);
 		return;
 	}
 
 	brk_opinfo->open_trunc = is_trunc;
 	list_add(&work->interim_entry, &brk_opinfo->interim_list);
 	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II);
-	opinfo_put(brk_opinfo);
+	opinfo_conn_put(brk_opinfo);
 }
 
 /**
@@ -1254,6 +1268,13 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 	list_for_each_entry_rcu(brk_op, &ci->m_op_list, op_entry) {
 		if (!atomic_inc_not_zero(&brk_op->refcount))
 			continue;
+
+		atomic_inc(&brk_op->conn->r_count);
+		if (ksmbd_conn_releasing(brk_op->conn)) {
+			atomic_dec(&brk_op->conn->r_count);
+			continue;
+		}
+
 		rcu_read_unlock();
 		if (brk_op->is_lease && (brk_op->o_lease->state &
 		    (~(SMB2_LEASE_READ_CACHING_LE |
@@ -1283,7 +1304,7 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 		brk_op->open_trunc = is_trunc;
 		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE);
 next:
-		opinfo_put(brk_op);
+		opinfo_conn_put(brk_op);
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
@@ -1336,19 +1357,16 @@ __u8 smb2_map_lease_to_oplock(__le32 lease_state)
  */
 void create_lease_buf(u8 *rbuf, struct lease *lease)
 {
-	char *LeaseKey = (char *)&lease->lease_key;
-
 	if (lease->version == 2) {
 		struct create_lease_v2 *buf = (struct create_lease_v2 *)rbuf;
-		char *ParentLeaseKey = (char *)&lease->parent_lease_key;
 
 		memset(buf, 0, sizeof(struct create_lease_v2));
-		buf->lcontext.LeaseKeyLow = *((__le64 *)LeaseKey);
-		buf->lcontext.LeaseKeyHigh = *((__le64 *)(LeaseKey + 8));
+		memcpy(buf->lcontext.LeaseKey, lease->lease_key,
+		       SMB2_LEASE_KEY_SIZE);
 		buf->lcontext.LeaseFlags = lease->flags;
 		buf->lcontext.LeaseState = lease->state;
-		buf->lcontext.ParentLeaseKeyLow = *((__le64 *)ParentLeaseKey);
-		buf->lcontext.ParentLeaseKeyHigh = *((__le64 *)(ParentLeaseKey + 8));
+		memcpy(buf->lcontext.ParentLeaseKey, lease->parent_lease_key,
+		       SMB2_LEASE_KEY_SIZE);
 		buf->ccontext.DataOffset = cpu_to_le16(offsetof
 				(struct create_lease_v2, lcontext));
 		buf->ccontext.DataLength = cpu_to_le32(sizeof(struct lease_context_v2));
@@ -1363,8 +1381,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 		struct create_lease *buf = (struct create_lease *)rbuf;
 
 		memset(buf, 0, sizeof(struct create_lease));
-		buf->lcontext.LeaseKeyLow = *((__le64 *)LeaseKey);
-		buf->lcontext.LeaseKeyHigh = *((__le64 *)(LeaseKey + 8));
+		memcpy(buf->lcontext.LeaseKey, lease->lease_key, SMB2_LEASE_KEY_SIZE);
 		buf->lcontext.LeaseFlags = lease->flags;
 		buf->lcontext.LeaseState = lease->state;
 		buf->ccontext.DataOffset = cpu_to_le16(offsetof
@@ -1388,58 +1405,38 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
  */
 struct lease_ctx_info *parse_lease_state(void *open_req)
 {
-	char *data_offset;
 	struct create_context *cc;
-	unsigned int next = 0;
-	char *name;
-	bool found = false;
 	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
-	struct lease_ctx_info *lreq = kzalloc(sizeof(struct lease_ctx_info),
-		GFP_KERNEL);
+	struct lease_ctx_info *lreq;
+
+	cc = smb2_find_context_vals(req, SMB2_CREATE_REQUEST_LEASE, 4);
+	if (IS_ERR_OR_NULL(cc))
+		return NULL;
+
+	lreq = kzalloc(sizeof(struct lease_ctx_info), GFP_KERNEL);
 	if (!lreq)
 		return NULL;
 
-	data_offset = (char *)req + 4 + le32_to_cpu(req->CreateContextsOffset);
-	cc = (struct create_context *)data_offset;
-	do {
-		cc = (struct create_context *)((char *)cc + next);
-		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
-		if (le16_to_cpu(cc->NameLength) != 4 ||
-		    strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
-			next = le32_to_cpu(cc->Next);
-			continue;
-		}
-		found = true;
-		break;
-	} while (next != 0);
+	if (sizeof(struct lease_context_v2) == le32_to_cpu(cc->DataLength)) {
+		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
-	if (found) {
-		if (sizeof(struct lease_context_v2) == le32_to_cpu(cc->DataLength)) {
-			struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
-
-			*((__le64 *)lreq->lease_key) = lc->lcontext.LeaseKeyLow;
-			*((__le64 *)(lreq->lease_key + 8)) = lc->lcontext.LeaseKeyHigh;
-			lreq->req_state = lc->lcontext.LeaseState;
-			lreq->flags = lc->lcontext.LeaseFlags;
-			lreq->duration = lc->lcontext.LeaseDuration;
-			*((__le64 *)lreq->parent_lease_key) = lc->lcontext.ParentLeaseKeyLow;
-			*((__le64 *)(lreq->parent_lease_key + 8)) = lc->lcontext.ParentLeaseKeyHigh;
-			lreq->version = 2;
-		} else {
-			struct create_lease *lc = (struct create_lease *)cc;
-
-			*((__le64 *)lreq->lease_key) = lc->lcontext.LeaseKeyLow;
-			*((__le64 *)(lreq->lease_key + 8)) = lc->lcontext.LeaseKeyHigh;
-			lreq->req_state = lc->lcontext.LeaseState;
-			lreq->flags = lc->lcontext.LeaseFlags;
-			lreq->duration = lc->lcontext.LeaseDuration;
-			lreq->version = 1;
-		}
-		return lreq;
-	}
+		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
+		lreq->req_state = lc->lcontext.LeaseState;
+		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->duration = lc->lcontext.LeaseDuration;
+		memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
+				SMB2_LEASE_KEY_SIZE);
+		lreq->version = 2;
+	} else {
+		struct create_lease *lc = (struct create_lease *)cc;
 
-	kfree(lreq);
-	return NULL;
+		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
+		lreq->req_state = lc->lcontext.LeaseState;
+		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->duration = lc->lcontext.LeaseDuration;
+		lreq->version = 1;
+	}
+	return lreq;
 }
 
 /**
@@ -1464,7 +1461,7 @@ struct create_context *smb2_find_context_vals(void *open_req, const char *tag, i
 	 * CreateContextsOffset and CreateContextsLength are guaranteed to
 	 * be valid because of ksmbd_smb2_check_message().
 	 */
-	cc = (struct create_context *)((char *)req + 4 +
+	cc = (struct create_context *)((char *)req +
 				       le32_to_cpu(req->CreateContextsOffset));
 	remain_len = le32_to_cpu(req->CreateContextsLength);
 	do {
@@ -1612,7 +1609,11 @@ void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp)
 	memset(buf, 0, sizeof(struct create_posix_rsp));
 	buf->ccontext.DataOffset = cpu_to_le16(offsetof
 			(struct create_posix_rsp, nlink));
-	buf->ccontext.DataLength = cpu_to_le32(52);
+	/*
+	 * DataLength = nlink(4) + reparse_tag(4) + mode(4) +
+	 * domain sid(28) + unix group sid(16).
+	 */
+	buf->ccontext.DataLength = cpu_to_le32(56);
 	buf->ccontext.NameOffset = cpu_to_le16(offsetof
 			(struct create_posix_rsp, Name));
 	buf->ccontext.NameLength = cpu_to_le16(POSIX_CTXT_DATA_LEN);
@@ -1636,13 +1637,20 @@ void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp)
 
 	buf->nlink = cpu_to_le32(inode->i_nlink);
 	buf->reparse_tag = cpu_to_le32(fp->volatile_id);
-	buf->mode = cpu_to_le32(inode->i_mode);
+	buf->mode = cpu_to_le32(inode->i_mode & 0777);
+	/*
+	 * SidBuffer(44) contain two sids(Domain sid(28), UNIX group sid(16)).
+	 * Domain sid(28) = revision(1) + num_subauth(1) + authority(6) +
+	 *		    sub_auth(4 * 4(num_subauth)) + RID(4).
+	 * UNIX group id(16) = revision(1) + num_subauth(1) + authority(6) +
+	 *		       sub_auth(4 * 1(num_subauth)) + RID(4).
+	 */
 	id_to_sid(from_kuid_munged(&init_user_ns,
 				   i_uid_into_mnt(user_ns, inode)),
-		  SIDNFS_USER, (struct smb_sid *)&buf->SidBuffer[0]);
+		  SIDOWNER, (struct smb_sid *)&buf->SidBuffer[0]);
 	id_to_sid(from_kgid_munged(&init_user_ns,
 				   i_gid_into_mnt(user_ns, inode)),
-		  SIDNFS_GROUP, (struct smb_sid *)&buf->SidBuffer[20]);
+		  SIDUNIX_GROUP, (struct smb_sid *)&buf->SidBuffer[28]);
 }
 
 /*
@@ -1702,33 +1710,3 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 	read_unlock(&lease_list_lock);
 	return ret_op;
 }
-
-int smb2_check_durable_oplock(struct ksmbd_file *fp,
-			      struct lease_ctx_info *lctx, char *name)
-{
-	struct oplock_info *opinfo = opinfo_get(fp);
-	int ret = 0;
-
-	if (opinfo && opinfo->is_lease) {
-		if (!lctx) {
-			pr_err("open does not include lease\n");
-			ret = -EBADF;
-			goto out;
-		}
-		if (memcmp(opinfo->o_lease->lease_key, lctx->lease_key,
-			   SMB2_LEASE_KEY_SIZE)) {
-			pr_err("invalid lease key\n");
-			ret = -EBADF;
-			goto out;
-		}
-		if (name && strcmp(fp->filename, name)) {
-			pr_err("invalid name reconnect %s\n", name);
-			ret = -EINVAL;
-			goto out;
-		}
-	}
-out:
-	if (opinfo)
-		opinfo_put(opinfo);
-	return ret;
-}
diff --git a/fs/ksmbd/oplock.h b/fs/ksmbd/oplock.h
index 2c4f4a0512b7..4b0fe6da7694 100644
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -28,8 +28,6 @@
 #define OPLOCK_WRITE_TO_NONE		0x04
 #define OPLOCK_READ_TO_NONE		0x08
 
-#define SMB2_LEASE_KEY_SIZE		16
-
 struct lease_ctx_info {
 	__u8			lease_key[SMB2_LEASE_KEY_SIZE];
 	__le32			req_state;
@@ -126,6 +124,4 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 			struct lease_ctx_info *lctx);
 void destroy_lease_table(struct ksmbd_conn *conn);
-int smb2_check_durable_oplock(struct ksmbd_file *fp,
-			      struct lease_ctx_info *lctx, char *name);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index eb45d56b3577..11b201e6ee44 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -93,7 +93,8 @@ static inline int check_conn_state(struct ksmbd_work *work)
 {
 	struct smb_hdr *rsp_hdr;
 
-	if (ksmbd_conn_exiting(work) || ksmbd_conn_need_reconnect(work)) {
+	if (ksmbd_conn_exiting(work->conn) ||
+	    ksmbd_conn_need_reconnect(work->conn)) {
 		rsp_hdr = work->response_buf;
 		rsp_hdr->Status.CifsError = STATUS_CONNECTION_DISCONNECTED;
 		return 1;
@@ -114,8 +115,10 @@ static int __process_request(struct ksmbd_work *work, struct ksmbd_conn *conn,
 	if (check_conn_state(work))
 		return SERVER_HANDLER_CONTINUE;
 
-	if (ksmbd_verify_smb_message(work))
+	if (ksmbd_verify_smb_message(work)) {
+		conn->ops->set_rsp_status(work, STATUS_INVALID_PARAMETER);
 		return SERVER_HANDLER_ABORT;
+	}
 
 	command = conn->ops->get_cmd_val(work);
 	*cmd = command;
@@ -162,6 +165,7 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 {
 	u16 command = 0;
 	int rc;
+	bool is_chained = false;
 
 	if (conn->ops->allocate_rsp_buf(work))
 		return;
@@ -228,16 +232,17 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 			}
 		}
 
+		is_chained = is_chained_smb2_message(work);
+
 		if (work->sess &&
 		    (work->sess->sign || smb3_11_final_sess_setup_resp(work) ||
 		     conn->ops->is_sign_req(work, command)))
 			conn->ops->set_sign_rsp(work);
-	} while (is_chained_smb2_message(work));
-
-	if (work->send_no_response)
-		return;
+	} while (is_chained == true);
 
 send:
+	if (work->tcon)
+		ksmbd_tree_connect_put(work->tcon);
 	smb3_preauth_hash_rsp(work);
 	if (work->sess && work->sess->enc && work->encrypted &&
 	    conn->ops->encrypt_resp) {
@@ -266,7 +271,13 @@ static void handle_ksmbd_work(struct work_struct *wk)
 
 	ksmbd_conn_try_dequeue_request(work);
 	ksmbd_free_work_struct(work);
-	atomic_dec(&conn->r_count);
+	/*
+	 * Checking waitqueue to dropping pending requests on
+	 * disconnection. waitqueue_active is safe because it
+	 * uses atomic operation for condition.
+	 */
+	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
+		wake_up(&conn->r_count_q);
 }
 
 /**
@@ -279,6 +290,7 @@ static void handle_ksmbd_work(struct work_struct *wk)
 static int queue_ksmbd_work(struct ksmbd_conn *conn)
 {
 	struct ksmbd_work *work;
+	int err;
 
 	work = ksmbd_alloc_work_struct();
 	if (!work) {
@@ -290,9 +302,10 @@ static int queue_ksmbd_work(struct ksmbd_conn *conn)
 	work->request_buf = conn->request_buf;
 	conn->request_buf = NULL;
 
-	if (ksmbd_init_smb_server(work)) {
+	err = ksmbd_init_smb_server(work);
+	if (err) {
 		ksmbd_free_work_struct(work);
-		return -EINVAL;
+		return 0;
 	}
 
 	ksmbd_conn_enqueue_request(work);
@@ -433,11 +446,9 @@ static ssize_t stats_show(struct class *class, struct class_attribute *attr,
 		"reset",
 		"shutdown"
 	};
-
-	ssize_t sz = scnprintf(buf, PAGE_SIZE, "%d %s %d %lu\n", stats_version,
-			       state[server_conf.state], server_conf.tcp_port,
-			       server_conf.ipc_last_active / HZ);
-	return sz;
+	return sysfs_emit(buf, "%d %s %d %lu\n", stats_version,
+			  state[server_conf.state], server_conf.tcp_port,
+			  server_conf.ipc_last_active / HZ);
 }
 
 static ssize_t kill_server_store(struct class *class,
@@ -469,19 +480,13 @@ static ssize_t debug_show(struct class *class, struct class_attribute *attr,
 
 	for (i = 0; i < ARRAY_SIZE(debug_type_strings); i++) {
 		if ((ksmbd_debug_types >> i) & 1) {
-			pos = scnprintf(buf + sz,
-					PAGE_SIZE - sz,
-					"[%s] ",
-					debug_type_strings[i]);
+			pos = sysfs_emit_at(buf, sz, "[%s] ", debug_type_strings[i]);
 		} else {
-			pos = scnprintf(buf + sz,
-					PAGE_SIZE - sz,
-					"%s ",
-					debug_type_strings[i]);
+			pos = sysfs_emit_at(buf, sz, "%s ", debug_type_strings[i]);
 		}
 		sz += pos;
 	}
-	sz += scnprintf(buf + sz, PAGE_SIZE - sz, "\n");
+	sz += sysfs_emit_at(buf, sz, "\n");
 	return sz;
 }
 
@@ -590,8 +595,6 @@ static int __init ksmbd_server_init(void)
 	if (ret)
 		goto err_crypto_destroy;
 
-	pr_warn_once("The ksmbd server is experimental, use at your own risk.\n");
-
 	return 0;
 
 err_crypto_destroy:
@@ -628,7 +631,6 @@ MODULE_DESCRIPTION("Linux kernel CIFS/SMB SERVER");
 MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: ecb");
 MODULE_SOFTDEP("pre: hmac");
-MODULE_SOFTDEP("pre: md4");
 MODULE_SOFTDEP("pre: md5");
 MODULE_SOFTDEP("pre: nls");
 MODULE_SOFTDEP("pre: aes");
diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index 8ef9503c4ab9..39e523f115d2 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -441,10 +441,8 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 
 validate_credit:
 	if ((work->conn->vals->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU) &&
-	    smb2_validate_credit_charge(work->conn, hdr)) {
-		work->conn->ops->set_rsp_status(work, STATUS_INVALID_PARAMETER);
+	    smb2_validate_credit_charge(work->conn, hdr))
 		return 1;
-	}
 
 	return 0;
 }
diff --git a/fs/ksmbd/smb2ops.c b/fs/ksmbd/smb2ops.c
index f0a5b704f301..9138e1c29b22 100644
--- a/fs/ksmbd/smb2ops.c
+++ b/fs/ksmbd/smb2ops.c
@@ -248,8 +248,9 @@ void init_smb3_02_server(struct ksmbd_conn *conn)
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
 
-	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
-	    conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
+	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
+	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
@@ -272,6 +273,11 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
 
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION ||
+	    (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF) &&
+	     conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION))
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index a7973b7012e9..7ce5746f9167 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -45,8 +45,8 @@ static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
 		*req = ksmbd_req_buf_next(work);
 		*rsp = ksmbd_resp_buf_next(work);
 	} else {
-		*req = work->request_buf;
-		*rsp = work->response_buf;
+		*req = smb2_get_msg(work->request_buf);
+		*rsp = smb2_get_msg(work->response_buf);
 	}
 }
 
@@ -75,14 +75,7 @@ static inline bool check_session_id(struct ksmbd_conn *conn, u64 id)
 
 struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn *conn)
 {
-	struct channel *chann;
-
-	list_for_each_entry(chann, &sess->ksmbd_chann_list, chann_list) {
-		if (chann->conn == conn)
-			return chann;
-	}
-
-	return NULL;
+	return xa_load(&sess->ksmbd_chann_list, (long)conn);
 }
 
 /**
@@ -94,12 +87,13 @@ struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn
  */
 int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = work->request_buf;
-	int tree_id;
+	struct smb2_hdr *req_hdr = ksmbd_req_buf_next(work);
+	unsigned int cmd = le16_to_cpu(req_hdr->Command);
+	unsigned int tree_id;
 
-	if (work->conn->ops->get_cmd_val(work) == SMB2_TREE_CONNECT_HE ||
-	    work->conn->ops->get_cmd_val(work) ==  SMB2_CANCEL_HE ||
-	    work->conn->ops->get_cmd_val(work) ==  SMB2_LOGOFF_HE) {
+	if (cmd == SMB2_TREE_CONNECT_HE ||
+	    cmd ==  SMB2_CANCEL_HE ||
+	    cmd ==  SMB2_LOGOFF_HE) {
 		ksmbd_debug(SMB, "skip to check tree connect request\n");
 		return 0;
 	}
@@ -120,7 +114,7 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 			pr_err("The first operation in the compound does not have tcon\n");
 			return -EINVAL;
 		}
-		if (work->tcon->id != tree_id) {
+		if (tree_id != UINT_MAX && work->tcon->id != tree_id) {
 			pr_err("tree id(%u) is different with id(%u) in first operation\n",
 					tree_id, work->tcon->id);
 			return -EINVAL;
@@ -148,15 +142,21 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		err_rsp = ksmbd_resp_buf_next(work);
 	else
-		err_rsp = work->response_buf;
+		err_rsp = smb2_get_msg(work->response_buf);
 
 	if (err_rsp->hdr.Status != STATUS_STOPPED_ON_SYMLINK) {
+		int err;
+
 		err_rsp->StructureSize = SMB2_ERROR_STRUCTURE_SIZE2_LE;
 		err_rsp->ErrorContextCount = 0;
 		err_rsp->Reserved = 0;
 		err_rsp->ByteCount = 0;
 		err_rsp->ErrorData[0] = 0;
-		inc_rfc1001_len(work->response_buf, SMB2_ERROR_STRUCTURE_SIZE2);
+		err = ksmbd_iov_pin_rsp(work, (void *)err_rsp,
+					__SMB2_HEADER_STRUCTURE_SIZE +
+						SMB2_ERROR_STRUCTURE_SIZE2);
+		if (err)
+			work->send_no_response = 1;
 	}
 }
 
@@ -168,7 +168,7 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
  */
 bool is_smb2_neg_cmd(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -192,7 +192,7 @@ bool is_smb2_neg_cmd(struct ksmbd_work *work)
  */
 bool is_smb2_rsp(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->response_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->response_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -218,7 +218,7 @@ u16 get_smb2_cmd_val(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		rcv_hdr = ksmbd_req_buf_next(work);
 	else
-		rcv_hdr = work->request_buf;
+		rcv_hdr = smb2_get_msg(work->request_buf);
 	return le16_to_cpu(rcv_hdr->Command);
 }
 
@@ -231,11 +231,12 @@ void set_smb2_rsp_status(struct ksmbd_work *work, __le32 err)
 {
 	struct smb2_hdr *rsp_hdr;
 
-	if (work->next_smb2_rcv_hdr_off)
-		rsp_hdr = ksmbd_resp_buf_next(work);
-	else
-		rsp_hdr = work->response_buf;
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	rsp_hdr->Status = err;
+
+	work->iov_idx = 0;
+	work->iov_cnt = 0;
+	work->next_smb2_rcv_hdr_off = 0;
 	smb2_set_err_rsp(work);
 }
 
@@ -251,17 +252,10 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	struct smb2_hdr *rsp_hdr;
 	struct smb2_negotiate_rsp *rsp;
 	struct ksmbd_conn *conn = work->conn;
+	int err;
 
-	if (conn->need_neg == false)
-		return -EINVAL;
-
-	rsp_hdr = work->response_buf;
-
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
-
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(2);
@@ -274,9 +268,9 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = work->response_buf;
+	rsp = smb2_get_msg(work->response_buf);
 
-	WARN_ON(ksmbd_conn_good(work));
+	WARN_ON(ksmbd_conn_good(conn));
 
 	rsp->StructureSize = cpu_to_le16(65);
 	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
@@ -295,18 +289,19 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 
 	rsp->SecurityBufferOffset = cpu_to_le16(128);
 	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
-	ksmbd_copy_gss_neg_header(((char *)(&rsp->hdr) +
-		sizeof(rsp->hdr.smb2_buf_length)) +
+	ksmbd_copy_gss_neg_header((char *)(&rsp->hdr) +
 		le16_to_cpu(rsp->SecurityBufferOffset));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_negotiate_rsp) -
-		sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
-		AUTH_GSS_LENGTH);
 	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
 	if (server_conf.signing == KSMBD_CONFIG_OPT_MANDATORY)
 		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
+	err = ksmbd_iov_pin_rsp(work, rsp,
+				sizeof(struct smb2_negotiate_rsp) -
+				sizeof(rsp->Buffer) + AUTH_GSS_LENGTH);
+	if (err)
+		return err;
 	conn->use_spnego = true;
 
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 	return 0;
 }
 
@@ -393,12 +388,8 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
 	 * command in the compound request
 	 */
 	if (req->Command == SMB2_CREATE && rsp->Status == STATUS_SUCCESS) {
-		work->compound_fid =
-			le64_to_cpu(((struct smb2_create_rsp *)rsp)->
-				VolatileFileId);
-		work->compound_pfid =
-			le64_to_cpu(((struct smb2_create_rsp *)rsp)->
-				PersistentFileId);
+		work->compound_fid = ((struct smb2_create_rsp *)rsp)->VolatileFileId;
+		work->compound_pfid = ((struct smb2_create_rsp *)rsp)->PersistentFileId;
 		work->compound_sid = le64_to_cpu(rsp->SessionId);
 	}
 
@@ -406,11 +397,12 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
 	next_hdr_offset = le32_to_cpu(req->NextCommand);
 
 	new_len = ALIGN(len, 8);
-	inc_rfc1001_len(work->response_buf, ((sizeof(struct smb2_hdr) - 4)
-			+ new_len - len));
+	work->iov[work->iov_idx].iov_len += (new_len - len);
+	inc_rfc1001_len(work->response_buf, new_len - len);
 	rsp->NextCommand = cpu_to_le32(new_len);
 
 	work->next_smb2_rcv_hdr_off += next_hdr_offset;
+	work->curr_smb2_rsp_hdr_off = work->next_smb2_rsp_hdr_off;
 	work->next_smb2_rsp_hdr_off += new_len;
 	ksmbd_debug(SMB,
 		    "Compound req new_len = %d rcv off = %d rsp off = %d\n",
@@ -425,7 +417,7 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
 		work->compound_fid = KSMBD_NO_FID;
 		work->compound_pfid = KSMBD_NO_FID;
 	}
-	memset((char *)rsp_hdr + 4, 0, sizeof(struct smb2_hdr) + 2);
+	memset((char *)rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->Command = rcv_hdr->Command;
@@ -451,7 +443,7 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
  */
 bool is_chained_smb2_message(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	unsigned int len, next_cmd;
 
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -486,10 +478,10 @@ bool is_chained_smb2_message(struct ksmbd_work *work)
 		len = len - get_rfc1002_len(work->response_buf);
 		if (len) {
 			ksmbd_debug(SMB, "padding len %u\n", len);
+			work->iov[work->iov_idx].iov_len += len;
 			inc_rfc1001_len(work->response_buf, len);
-			if (work->aux_payload_sz)
-				work->aux_payload_sz += len;
 		}
+		work->curr_smb2_rsp_hdr_off = work->next_smb2_rsp_hdr_off;
 	}
 	return false;
 }
@@ -502,13 +494,10 @@ bool is_chained_smb2_message(struct ksmbd_work *work)
  */
 int init_smb2_rsp_hdr(struct ksmbd_work *work)
 {
-	struct smb2_hdr *rsp_hdr = work->response_buf;
-	struct smb2_hdr *rcv_hdr = work->request_buf;
-	struct ksmbd_conn *conn = work->conn;
+	struct smb2_hdr *rsp_hdr = smb2_get_msg(work->response_buf);
+	struct smb2_hdr *rcv_hdr = smb2_get_msg(work->request_buf);
 
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
 	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->Command = rcv_hdr->Command;
@@ -524,12 +513,6 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
 	rsp_hdr->SessionId = rcv_hdr->SessionId;
 	memcpy(rsp_hdr->Signature, rcv_hdr->Signature, 16);
 
-	work->syncronous = true;
-	if (work->async_id) {
-		ksmbd_release_id(&conn->async_ida, work->async_id);
-		work->async_id = 0;
-	}
-
 	return 0;
 }
 
@@ -541,7 +524,7 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
  */
 int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + work->conn->vals->max_trans_size;
 	size_t sz = small_sz;
@@ -553,7 +536,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	if (cmd == SMB2_QUERY_INFO_HE) {
 		struct smb2_query_info_req *req;
 
-		req = work->request_buf;
+		req = smb2_get_msg(work->request_buf);
 		if ((req->InfoType == SMB2_O_INFO_FILE &&
 		     (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
 		      req->FileInfoClass == FILE_ALL_INFORMATION)) ||
@@ -565,7 +548,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	if (le32_to_cpu(hdr->NextCommand) > 0)
 		sz = large_sz;
 
-	work->response_buf = kvmalloc(sz, GFP_KERNEL | __GFP_ZERO);
+	work->response_buf = kvzalloc(sz, GFP_KERNEL);
 	if (!work->response_buf)
 		return -ENOMEM;
 
@@ -581,9 +564,9 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
  */
 int smb2_check_user_session(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = work->request_buf;
+	struct smb2_hdr *req_hdr = ksmbd_req_buf_next(work);
 	struct ksmbd_conn *conn = work->conn;
-	unsigned int cmd = conn->ops->get_cmd_val(work);
+	unsigned int cmd = le16_to_cpu(req_hdr->Command);
 	unsigned long long sess_id;
 
 	/*
@@ -595,7 +578,7 @@ int smb2_check_user_session(struct ksmbd_work *work)
 	    cmd == SMB2_SESSION_SETUP_HE)
 		return 0;
 
-	if (!ksmbd_conn_good(work))
+	if (!ksmbd_conn_good(conn))
 		return -EIO;
 
 	sess_id = le64_to_cpu(req_hdr->SessionId);
@@ -609,7 +592,7 @@ int smb2_check_user_session(struct ksmbd_work *work)
 			pr_err("The first operation in the compound does not have sess\n");
 			return -EINVAL;
 		}
-		if (work->sess->id != sess_id) {
+		if (sess_id != ULLONG_MAX && work->sess->id != sess_id) {
 			pr_err("session id(%llu) is different with the first operation(%lld)\n",
 					sess_id, work->sess->id);
 			return -EINVAL;
@@ -631,6 +614,7 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
 	struct ksmbd_user *prev_user;
 	struct channel *chann;
+	long index;
 
 	if (!prev_sess)
 		return;
@@ -644,24 +628,20 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 		return;
 
 	prev_sess->state = SMB2_SESSION_EXPIRED;
-	write_lock(&prev_sess->chann_lock);
-	list_for_each_entry(chann, &prev_sess->ksmbd_chann_list, chann_list)
-		chann->conn->status = KSMBD_SESS_EXITING;
-	write_unlock(&prev_sess->chann_lock);
+	xa_for_each(&prev_sess->ksmbd_chann_list, index, chann)
+		ksmbd_conn_set_exiting(chann->conn);
 }
 
 /**
  * smb2_get_name() - get filename string from on the wire smb format
- * @share:	ksmbd_share_config pointer
  * @src:	source buffer
  * @maxlen:	maxlen of source string
- * @nls_table:	nls_table pointer
+ * @local_nls:	nls_table pointer
  *
  * Return:      matching converted filename on success, otherwise error ptr
  */
 static char *
-smb2_get_name(struct ksmbd_share_config *share, const char *src,
-	      const int maxlen, struct nls_table *local_nls)
+smb2_get_name(const char *src, const int maxlen, struct nls_table *local_nls)
 {
 	char *name;
 
@@ -678,21 +658,16 @@ smb2_get_name(struct ksmbd_share_config *share, const char *src,
 
 int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 {
-	struct smb2_hdr *rsp_hdr;
 	struct ksmbd_conn *conn = work->conn;
 	int id;
 
-	rsp_hdr = work->response_buf;
-	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
-
 	id = ksmbd_acquire_async_msg_id(&conn->async_ida);
 	if (id < 0) {
 		pr_err("Failed to alloc async message id\n");
 		return id;
 	}
-	work->syncronous = false;
+	work->asynchronous = true;
 	work->async_id = id;
-	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
 
 	ksmbd_debug(SMB,
 		    "Send interim Response to inform async request id : %d\n",
@@ -710,18 +685,47 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 	return 0;
 }
 
+void release_async_work(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+
+	spin_lock(&conn->request_lock);
+	list_del_init(&work->async_request_entry);
+	spin_unlock(&conn->request_lock);
+
+	work->asynchronous = 0;
+	work->cancel_fn = NULL;
+	kfree(work->cancel_argv);
+	work->cancel_argv = NULL;
+	if (work->async_id) {
+		ksmbd_release_id(&conn->async_ida, work->async_id);
+		work->async_id = 0;
+	}
+}
+
 void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 {
 	struct smb2_hdr *rsp_hdr;
+	struct ksmbd_work *in_work = ksmbd_alloc_work_struct();
 
-	rsp_hdr = work->response_buf;
-	smb2_set_err_rsp(work);
+	if (allocate_interim_rsp_buf(in_work)) {
+		pr_err("smb_allocate_rsp_buf failed!\n");
+		ksmbd_free_work_struct(in_work);
+		return;
+	}
+
+	in_work->conn = work->conn;
+	memcpy(smb2_get_msg(in_work->response_buf), ksmbd_resp_buf_next(work),
+	       __SMB2_HEADER_STRUCTURE_SIZE);
+
+	rsp_hdr = smb2_get_msg(in_work->response_buf);
+	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
+	rsp_hdr->Id.AsyncId = cpu_to_le64(work->async_id);
+	smb2_set_err_rsp(in_work);
 	rsp_hdr->Status = status;
 
-	work->multiRsp = 1;
-	ksmbd_conn_write(work);
-	rsp_hdr->Status = 0;
-	work->multiRsp = 0;
+	ksmbd_conn_write(in_work);
+	ksmbd_free_work_struct(in_work);
 }
 
 static __le32 smb2_get_reparse_tag_special_file(umode_t mode)
@@ -793,19 +797,6 @@ static void build_encrypt_ctxt(struct smb2_encryption_neg_context *pneg_ctxt,
 	pneg_ctxt->Ciphers[0] = cipher_type;
 }
 
-static void build_compression_ctxt(struct smb2_compression_ctx *pneg_ctxt,
-				   __le16 comp_algo)
-{
-	pneg_ctxt->ContextType = SMB2_COMPRESSION_CAPABILITIES;
-	pneg_ctxt->DataLength =
-		cpu_to_le16(sizeof(struct smb2_compression_ctx)
-			- sizeof(struct smb2_neg_context));
-	pneg_ctxt->Reserved = cpu_to_le32(0);
-	pneg_ctxt->CompressionAlgorithmCount = cpu_to_le16(1);
-	pneg_ctxt->Reserved1 = cpu_to_le32(0);
-	pneg_ctxt->CompressionAlgorithms[0] = comp_algo;
-}
-
 static void build_sign_cap_ctxt(struct smb2_signing_capabilities *pneg_ctxt,
 				__le16 sign_algo)
 {
@@ -841,12 +832,11 @@ static void build_posix_ctxt(struct smb2_posix_neg_context *pneg_ctxt)
 	pneg_ctxt->Name[15] = 0x7C;
 }
 
-static void assemble_neg_contexts(struct ksmbd_conn *conn,
+static unsigned int assemble_neg_contexts(struct ksmbd_conn *conn,
 				  struct smb2_negotiate_rsp *rsp)
 {
-	/* +4 is to account for the RFC1001 len field */
-	char *pneg_ctxt = (char *)rsp +
-			le32_to_cpu(rsp->NegotiateContextOffset) + 4;
+	char * const pneg_ctxt = (char *)rsp +
+			le32_to_cpu(rsp->NegotiateContextOffset);
 	int neg_ctxt_cnt = 1;
 	int ctxt_size;
 
@@ -854,94 +844,90 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		    "assemble SMB2_PREAUTH_INTEGRITY_CAPABILITIES context\n");
 	build_preauth_ctxt((struct smb2_preauth_neg_context *)pneg_ctxt,
 			   conn->preauth_info->Preauth_HashId);
-	rsp->NegotiateContextCount = cpu_to_le16(neg_ctxt_cnt);
-	inc_rfc1001_len(rsp, AUTH_GSS_PADDING);
 	ctxt_size = sizeof(struct smb2_preauth_neg_context);
-	/* Round to 8 byte boundary */
-	pneg_ctxt += round_up(sizeof(struct smb2_preauth_neg_context), 8);
 
 	if (conn->cipher_type) {
+		/* Round to 8 byte boundary */
 		ctxt_size = round_up(ctxt_size, 8);
 		ksmbd_debug(SMB,
 			    "assemble SMB2_ENCRYPTION_CAPABILITIES context\n");
-		build_encrypt_ctxt((struct smb2_encryption_neg_context *)pneg_ctxt,
+		build_encrypt_ctxt((struct smb2_encryption_neg_context *)
+				   (pneg_ctxt + ctxt_size),
 				   conn->cipher_type);
-		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_encryption_neg_context) + 2;
-		/* Round to 8 byte boundary */
-		pneg_ctxt +=
-			round_up(sizeof(struct smb2_encryption_neg_context) + 2,
-				 8);
-	}
-
-	if (conn->compress_algorithm) {
-		ctxt_size = round_up(ctxt_size, 8);
-		ksmbd_debug(SMB,
-			    "assemble SMB2_COMPRESSION_CAPABILITIES context\n");
-		/* Temporarily set to SMB3_COMPRESS_NONE */
-		build_compression_ctxt((struct smb2_compression_ctx *)pneg_ctxt,
-				       conn->compress_algorithm);
-		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
-		ctxt_size += sizeof(struct smb2_compression_ctx) + 2;
-		/* Round to 8 byte boundary */
-		pneg_ctxt += round_up(sizeof(struct smb2_compression_ctx) + 2,
-				      8);
 	}
+	/* compression context not yet supported */
+	WARN_ON(conn->compress_algorithm != SMB3_COMPRESS_NONE);
 
 	if (conn->posix_ext_supported) {
 		ctxt_size = round_up(ctxt_size, 8);
 		ksmbd_debug(SMB,
 			    "assemble SMB2_POSIX_EXTENSIONS_AVAILABLE context\n");
-		build_posix_ctxt((struct smb2_posix_neg_context *)pneg_ctxt);
-		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		build_posix_ctxt((struct smb2_posix_neg_context *)
+				 (pneg_ctxt + ctxt_size));
+		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_posix_neg_context);
-		/* Round to 8 byte boundary */
-		pneg_ctxt += round_up(sizeof(struct smb2_posix_neg_context), 8);
 	}
 
 	if (conn->signing_negotiated) {
 		ctxt_size = round_up(ctxt_size, 8);
 		ksmbd_debug(SMB,
 			    "assemble SMB2_SIGNING_CAPABILITIES context\n");
-		build_sign_cap_ctxt((struct smb2_signing_capabilities *)pneg_ctxt,
+		build_sign_cap_ctxt((struct smb2_signing_capabilities *)
+				    (pneg_ctxt + ctxt_size),
 				    conn->signing_algorithm);
-		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		neg_ctxt_cnt++;
 		ctxt_size += sizeof(struct smb2_signing_capabilities) + 2;
 	}
 
-	inc_rfc1001_len(rsp, ctxt_size);
+	rsp->NegotiateContextCount = cpu_to_le16(neg_ctxt_cnt);
+	return ctxt_size + AUTH_GSS_PADDING;
 }
 
 static __le32 decode_preauth_ctxt(struct ksmbd_conn *conn,
-				  struct smb2_preauth_neg_context *pneg_ctxt)
+				  struct smb2_preauth_neg_context *pneg_ctxt,
+				  int ctxt_len)
 {
-	__le32 err = STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP;
+	/*
+	 * sizeof(smb2_preauth_neg_context) assumes SMB311_SALT_SIZE Salt,
+	 * which may not be present. Only check for used HashAlgorithms[1].
+	 */
+	if (ctxt_len <
+	    sizeof(struct smb2_neg_context) + 6)
+		return STATUS_INVALID_PARAMETER;
 
-	if (pneg_ctxt->HashAlgorithms == SMB2_PREAUTH_INTEGRITY_SHA512) {
-		conn->preauth_info->Preauth_HashId =
-			SMB2_PREAUTH_INTEGRITY_SHA512;
-		err = STATUS_SUCCESS;
-	}
+	if (pneg_ctxt->HashAlgorithms != SMB2_PREAUTH_INTEGRITY_SHA512)
+		return STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP;
 
-	return err;
+	conn->preauth_info->Preauth_HashId = SMB2_PREAUTH_INTEGRITY_SHA512;
+	return STATUS_SUCCESS;
 }
 
 static void decode_encrypt_ctxt(struct ksmbd_conn *conn,
 				struct smb2_encryption_neg_context *pneg_ctxt,
-				int len_of_ctxts)
+				int ctxt_len)
 {
-	int cph_cnt = le16_to_cpu(pneg_ctxt->CipherCount);
-	int i, cphs_size = cph_cnt * sizeof(__le16);
+	int cph_cnt;
+	int i, cphs_size;
+
+	if (sizeof(struct smb2_encryption_neg_context) > ctxt_len) {
+		pr_err("Invalid SMB2_ENCRYPTION_CAPABILITIES context size\n");
+		return;
+	}
 
 	conn->cipher_type = 0;
 
+	cph_cnt = le16_to_cpu(pneg_ctxt->CipherCount);
+	cphs_size = cph_cnt * sizeof(__le16);
+
 	if (sizeof(struct smb2_encryption_neg_context) + cphs_size >
-	    len_of_ctxts) {
+	    ctxt_len) {
 		pr_err("Invalid cipher count(%d)\n", cph_cnt);
 		return;
 	}
 
-	if (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION))
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF)
 		return;
 
 	for (i = 0; i < cph_cnt; i++) {
@@ -963,7 +949,7 @@ static void decode_encrypt_ctxt(struct ksmbd_conn *conn,
  *
  * Return:	true if connection should be encrypted, else false
  */
-static bool smb3_encryption_negotiated(struct ksmbd_conn *conn)
+bool smb3_encryption_negotiated(struct ksmbd_conn *conn)
 {
 	if (!conn->ops->generate_encryptionkey)
 		return false;
@@ -984,15 +970,22 @@ static void decode_compress_ctxt(struct ksmbd_conn *conn,
 
 static void decode_sign_cap_ctxt(struct ksmbd_conn *conn,
 				 struct smb2_signing_capabilities *pneg_ctxt,
-				 int len_of_ctxts)
+				 int ctxt_len)
 {
-	int sign_algo_cnt = le16_to_cpu(pneg_ctxt->SigningAlgorithmCount);
-	int i, sign_alos_size = sign_algo_cnt * sizeof(__le16);
+	int sign_algo_cnt;
+	int i, sign_alos_size;
+
+	if (sizeof(struct smb2_signing_capabilities) > ctxt_len) {
+		pr_err("Invalid SMB2_SIGNING_CAPABILITIES context length\n");
+		return;
+	}
 
 	conn->signing_negotiated = false;
+	sign_algo_cnt = le16_to_cpu(pneg_ctxt->SigningAlgorithmCount);
+	sign_alos_size = sign_algo_cnt * sizeof(__le16);
 
 	if (sizeof(struct smb2_signing_capabilities) + sign_alos_size >
-	    len_of_ctxts) {
+	    ctxt_len) {
 		pr_err("Invalid signing algorithm count(%d)\n", sign_algo_cnt);
 		return;
 	}
@@ -1011,14 +1004,14 @@ static void decode_sign_cap_ctxt(struct ksmbd_conn *conn,
 }
 
 static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
-				      struct smb2_negotiate_req *req)
+				      struct smb2_negotiate_req *req,
+				      unsigned int len_of_smb)
 {
 	/* +4 is to account for the RFC1001 len field */
-	struct smb2_neg_context *pctx = (struct smb2_neg_context *)((char *)req + 4);
+	struct smb2_neg_context *pctx = (struct smb2_neg_context *)req;
 	int i = 0, len_of_ctxts;
-	int offset = le32_to_cpu(req->NegotiateContextOffset);
-	int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
-	int len_of_smb = be32_to_cpu(req->hdr.smb2_buf_length);
+	unsigned int offset = le32_to_cpu(req->NegotiateContextOffset);
+	unsigned int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
 	__le32 status = STATUS_INVALID_PARAMETER;
 
 	ksmbd_debug(SMB, "decoding %d negotiate contexts\n", neg_ctxt_cnt);
@@ -1030,18 +1023,16 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 	len_of_ctxts = len_of_smb - offset;
 
 	while (i++ < neg_ctxt_cnt) {
-		int clen;
+		int clen, ctxt_len;
 
-		/* check that offset is not beyond end of SMB */
-		if (len_of_ctxts == 0)
-			break;
-
-		if (len_of_ctxts < sizeof(struct smb2_neg_context))
+		if (len_of_ctxts < (int)sizeof(struct smb2_neg_context))
 			break;
 
 		pctx = (struct smb2_neg_context *)((char *)pctx + offset);
 		clen = le16_to_cpu(pctx->DataLength);
-		if (clen + sizeof(struct smb2_neg_context) > len_of_ctxts)
+		ctxt_len = clen + sizeof(struct smb2_neg_context);
+
+		if (ctxt_len > len_of_ctxts)
 			break;
 
 		if (pctx->ContextType == SMB2_PREAUTH_INTEGRITY_CAPABILITIES) {
@@ -1051,7 +1042,8 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 				break;
 
 			status = decode_preauth_ctxt(conn,
-						     (struct smb2_preauth_neg_context *)pctx);
+						     (struct smb2_preauth_neg_context *)pctx,
+						     ctxt_len);
 			if (status != STATUS_SUCCESS)
 				break;
 		} else if (pctx->ContextType == SMB2_ENCRYPTION_CAPABILITIES) {
@@ -1062,7 +1054,7 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 
 			decode_encrypt_ctxt(conn,
 					    (struct smb2_encryption_neg_context *)pctx,
-					    len_of_ctxts);
+					    ctxt_len);
 		} else if (pctx->ContextType == SMB2_COMPRESSION_CAPABILITIES) {
 			ksmbd_debug(SMB,
 				    "deassemble SMB2_COMPRESSION_CAPABILITIES context\n");
@@ -1081,15 +1073,15 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 		} else if (pctx->ContextType == SMB2_SIGNING_CAPABILITIES) {
 			ksmbd_debug(SMB,
 				    "deassemble SMB2_SIGNING_CAPABILITIES context\n");
+
 			decode_sign_cap_ctxt(conn,
 					     (struct smb2_signing_capabilities *)pctx,
-					     len_of_ctxts);
+					     ctxt_len);
 		}
 
 		/* offsets must be 8 byte aligned */
-		clen = (clen + 7) & ~0x7;
-		offset = clen + sizeof(struct smb2_neg_context);
-		len_of_ctxts -= clen + sizeof(struct smb2_neg_context);
+		offset = (ctxt_len + 7) & ~0x7;
+		len_of_ctxts -= offset;
 	}
 	return status;
 }
@@ -1103,22 +1095,22 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 int smb2_handle_negotiate(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_negotiate_req *req = work->request_buf;
-	struct smb2_negotiate_rsp *rsp = work->response_buf;
+	struct smb2_negotiate_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_negotiate_rsp *rsp = smb2_get_msg(work->response_buf);
 	int rc = 0;
-	unsigned int smb2_buf_len, smb2_neg_size;
+	unsigned int smb2_buf_len, smb2_neg_size, neg_ctxt_len = 0;
 	__le32 status;
 
 	ksmbd_debug(SMB, "Received negotiate request\n");
 	conn->need_neg = false;
-	if (ksmbd_conn_good(work)) {
+	if (ksmbd_conn_good(conn)) {
 		pr_err("conn->tcp_status is already in CifsGood State\n");
 		work->send_no_response = 1;
 		return rc;
 	}
 
 	smb2_buf_len = get_rfc1002_len(work->request_buf);
-	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects) - 4;
+	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
 	if (smb2_neg_size > smb2_buf_len) {
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		rc = -EINVAL;
@@ -1174,7 +1166,8 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 			goto err_out;
 		}
 
-		status = deassemble_neg_contexts(conn, req);
+		status = deassemble_neg_contexts(conn, req,
+						 get_rfc1002_len(work->request_buf));
 		if (status != STATUS_SUCCESS) {
 			pr_err("deassemble_neg_contexts error(0x%x)\n",
 			       status);
@@ -1198,7 +1191,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 						 conn->preauth_info->Preauth_HashValue);
 		rsp->NegotiateContextOffset =
 				cpu_to_le32(OFFSET_OF_NEG_CONTEXT);
-		assemble_neg_contexts(conn, rsp);
+		neg_ctxt_len = assemble_neg_contexts(conn, rsp);
 		break;
 	case SMB302_PROT_ID:
 		init_smb3_02_server(conn);
@@ -1246,12 +1239,8 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 
 	rsp->SecurityBufferOffset = cpu_to_le16(128);
 	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
-	ksmbd_copy_gss_neg_header(((char *)(&rsp->hdr) +
-				  sizeof(rsp->hdr.smb2_buf_length)) +
-				   le16_to_cpu(rsp->SecurityBufferOffset));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_negotiate_rsp) -
-			sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
-			 AUTH_GSS_LENGTH);
+	ksmbd_copy_gss_neg_header((char *)(&rsp->hdr) +
+				  le16_to_cpu(rsp->SecurityBufferOffset));
 	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
 	conn->use_spnego = true;
 
@@ -1266,12 +1255,19 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	}
 
 	conn->srv_sec_mode = le16_to_cpu(rsp->SecurityMode);
-	ksmbd_conn_set_need_negotiate(work);
+	ksmbd_conn_set_need_negotiate(conn);
 
 err_out:
+	if (rc)
+		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+
+	if (!rc)
+		rc = ksmbd_iov_pin_rsp(work, rsp,
+				       sizeof(struct smb2_negotiate_rsp) -
+				        sizeof(rsp->Buffer) +
+					AUTH_GSS_LENGTH + neg_ctxt_len);
 	if (rc < 0)
 		smb2_set_err_rsp(work);
-
 	return rc;
 }
 
@@ -1339,9 +1335,8 @@ static int decode_negotiation_token(struct ksmbd_conn *conn,
 
 static int ntlm_negotiate(struct ksmbd_work *work,
 			  struct negotiate_message *negblob,
-			  size_t negblob_len)
+			  size_t negblob_len, struct smb2_sess_setup_rsp *rsp)
 {
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
 	struct challenge_message *chgblob;
 	unsigned char *spnego_blob = NULL;
 	u16 spnego_blob_len;
@@ -1446,10 +1441,10 @@ static struct ksmbd_user *session_user(struct ksmbd_conn *conn,
 	return user;
 }
 
-static int ntlm_authenticate(struct ksmbd_work *work)
+static int ntlm_authenticate(struct ksmbd_work *work,
+			     struct smb2_sess_setup_req *req,
+			     struct smb2_sess_setup_rsp *rsp)
 {
-	struct smb2_sess_setup_req *req = work->request_buf;
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	struct channel *chann = NULL;
@@ -1472,7 +1467,6 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 		memcpy((char *)&rsp->hdr.ProtocolId + sz, spnego_blob, spnego_blob_len);
 		rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
 		kfree(spnego_blob);
-		inc_rfc1001_len(rsp, spnego_blob_len - 1);
 	}
 
 	user = session_user(conn, req);
@@ -1545,7 +1539,8 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 			return -EINVAL;
 		}
 		sess->enc = true;
-		rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
+		if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION)
+			rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
 		/*
 		 * signing is disable if encryption is enable
 		 * on this session
@@ -1555,19 +1550,14 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
 binding_session:
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -1587,10 +1577,10 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 }
 
 #ifdef CONFIG_SMB_SERVER_KERBEROS5
-static int krb5_authenticate(struct ksmbd_work *work)
+static int krb5_authenticate(struct ksmbd_work *work,
+			     struct smb2_sess_setup_req *req,
+			     struct smb2_sess_setup_rsp *rsp)
 {
-	struct smb2_sess_setup_req *req = work->request_buf;
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	char *in_blob, *out_blob;
@@ -1605,8 +1595,7 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	out_blob = (char *)&rsp->hdr.ProtocolId +
 		le16_to_cpu(rsp->SecurityBufferOffset);
 	out_len = work->response_sz -
-		offsetof(struct smb2_hdr, smb2_buf_length) -
-		le16_to_cpu(rsp->SecurityBufferOffset);
+		(le16_to_cpu(rsp->SecurityBufferOffset) + 4);
 
 	/* Check previous session */
 	prev_sess_id = le64_to_cpu(req->PreviousSessionId);
@@ -1623,7 +1612,6 @@ static int krb5_authenticate(struct ksmbd_work *work)
 		return -EINVAL;
 	}
 	rsp->SecurityBufferLength = cpu_to_le16(out_len);
-	inc_rfc1001_len(rsp, out_len - 1);
 
 	if ((conn->sign || server_conf.enforced_signing) ||
 	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
@@ -1637,24 +1625,20 @@ static int krb5_authenticate(struct ksmbd_work *work)
 			return -EINVAL;
 		}
 		sess->enc = true;
-		rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
+		if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION)
+			rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
 		sess->sign = false;
 	}
 
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -1673,7 +1657,9 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	return 0;
 }
 #else
-static int krb5_authenticate(struct ksmbd_work *work)
+static int krb5_authenticate(struct ksmbd_work *work,
+			     struct smb2_sess_setup_req *req,
+			     struct smb2_sess_setup_rsp *rsp)
 {
 	return -EOPNOTSUPP;
 }
@@ -1682,8 +1668,8 @@ static int krb5_authenticate(struct ksmbd_work *work)
 int smb2_sess_setup(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_sess_setup_req *req = work->request_buf;
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct smb2_sess_setup_req *req;
+	struct smb2_sess_setup_rsp *rsp;
 	struct ksmbd_session *sess;
 	struct negotiate_message *negblob;
 	unsigned int negblob_len, negblob_off;
@@ -1691,12 +1677,14 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "Received request for session setup\n");
 
+	WORK_BUFFERS(work, req, rsp);
+
 	rsp->StructureSize = cpu_to_le16(9);
 	rsp->SessionFlags = 0;
 	rsp->SecurityBufferOffset = cpu_to_le16(72);
 	rsp->SecurityBufferLength = 0;
-	inc_rfc1001_len(rsp, 9);
 
+	ksmbd_conn_lock(conn);
 	if (!req->hdr.SessionId) {
 		sess = ksmbd_smb2_session_create();
 		if (!sess) {
@@ -1744,6 +1732,12 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
+		if (ksmbd_conn_need_reconnect(conn)) {
+			rc = -EFAULT;
+			sess = NULL;
+			goto out_err;
+		}
+
 		if (ksmbd_session_lookup(conn, sess_id)) {
 			rc = -EACCES;
 			goto out_err;
@@ -1768,15 +1762,23 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			rc = -ENOENT;
 			goto out_err;
 		}
+
+		if (sess->state == SMB2_SESSION_EXPIRED) {
+			rc = -EFAULT;
+			goto out_err;
+		}
+
+		if (ksmbd_conn_need_reconnect(conn)) {
+			rc = -EFAULT;
+			sess = NULL;
+			goto out_err;
+		}
 	}
 	work->sess = sess;
 
-	if (sess->state == SMB2_SESSION_EXPIRED)
-		sess->state = SMB2_SESSION_IN_PROGRESS;
-
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
-	if (negblob_off < (offsetof(struct smb2_sess_setup_req, Buffer) - 4) ||
+	if (negblob_off < offsetof(struct smb2_sess_setup_req, Buffer) ||
 	    negblob_len < offsetof(struct negotiate_message, NegotiateFlags)) {
 		rc = -EINVAL;
 		goto out_err;
@@ -1797,36 +1799,34 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 		if (conn->preferred_auth_mech &
 				(KSMBD_AUTH_KRB5 | KSMBD_AUTH_MSKRB5)) {
-			rc = krb5_authenticate(work);
+			rc = krb5_authenticate(work, req, rsp);
 			if (rc) {
 				rc = -EINVAL;
 				goto out_err;
 			}
 
-			ksmbd_conn_set_good(work);
-			sess->state = SMB2_SESSION_VALID;
+			if (!ksmbd_conn_need_reconnect(conn)) {
+				ksmbd_conn_set_good(conn);
+				sess->state = SMB2_SESSION_VALID;
+			}
 			kfree(sess->Preauth_HashValue);
 			sess->Preauth_HashValue = NULL;
 		} else if (conn->preferred_auth_mech == KSMBD_AUTH_NTLMSSP) {
 			if (negblob->MessageType == NtLmNegotiate) {
-				rc = ntlm_negotiate(work, negblob, negblob_len);
+				rc = ntlm_negotiate(work, negblob, negblob_len, rsp);
 				if (rc)
 					goto out_err;
 				rsp->hdr.Status =
 					STATUS_MORE_PROCESSING_REQUIRED;
-				/*
-				 * Note: here total size -1 is done as an
-				 * adjustment for 0 size blob
-				 */
-				inc_rfc1001_len(rsp, le16_to_cpu(rsp->SecurityBufferLength) - 1);
-
 			} else if (negblob->MessageType == NtLmAuthenticate) {
-				rc = ntlm_authenticate(work);
+				rc = ntlm_authenticate(work, req, rsp);
 				if (rc)
 					goto out_err;
 
-				ksmbd_conn_set_good(work);
-				sess->state = SMB2_SESSION_VALID;
+				if (!ksmbd_conn_need_reconnect(conn)) {
+					ksmbd_conn_set_good(conn);
+					sess->state = SMB2_SESSION_VALID;
+				}
 				if (conn->binding) {
 					struct preauth_session *preauth_sess;
 
@@ -1894,14 +1894,29 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			if (sess->user && sess->user->flags & KSMBD_USER_FLAG_DELAY_SESSION)
 				try_delay = true;
 
-			xa_erase(&conn->sessions, sess->id);
-			ksmbd_session_destroy(sess);
-			work->sess = NULL;
-			if (try_delay)
+			sess->last_active = jiffies;
+			sess->state = SMB2_SESSION_EXPIRED;
+			if (try_delay) {
+				ksmbd_conn_set_need_reconnect(conn);
 				ssleep(5);
+				ksmbd_conn_set_need_negotiate(conn);
+			}
 		}
+		smb2_set_err_rsp(work);
+	} else {
+		unsigned int iov_len;
+
+		if (rsp->SecurityBufferLength)
+			iov_len = offsetof(struct smb2_sess_setup_rsp, Buffer) +
+				le16_to_cpu(rsp->SecurityBufferLength);
+		else
+			iov_len = sizeof(struct smb2_sess_setup_rsp);
+		rc = ksmbd_iov_pin_rsp(work, rsp, iov_len);
+		if (rc)
+			rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
 	}
 
+	ksmbd_conn_unlock(conn);
 	return rc;
 }
 
@@ -1914,14 +1929,16 @@ int smb2_sess_setup(struct ksmbd_work *work)
 int smb2_tree_connect(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_tree_connect_req *req = work->request_buf;
-	struct smb2_tree_connect_rsp *rsp = work->response_buf;
+	struct smb2_tree_connect_req *req;
+	struct smb2_tree_connect_rsp *rsp;
 	struct ksmbd_session *sess = work->sess;
 	char *treename = NULL, *name = NULL;
 	struct ksmbd_tree_conn_status status;
 	struct ksmbd_share_config *share;
 	int rc = -EINVAL;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	treename = smb_strndup_from_utf16(req->Buffer,
 					  le16_to_cpu(req->PathLength), true,
 					  conn->local_nls);
@@ -1931,7 +1948,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 		goto out_err1;
 	}
 
-	name = ksmbd_extract_sharename(treename);
+	name = ksmbd_extract_sharename(conn->um, treename);
 	if (IS_ERR(name)) {
 		status.ret = KSMBD_TREE_CONN_STATUS_ERROR;
 		goto out_err1;
@@ -1974,13 +1991,19 @@ int smb2_tree_connect(struct ksmbd_work *work)
 	if (conn->posix_ext_supported)
 		status.tree_conn->posix_extensions = true;
 
-out_err1:
+	write_lock(&sess->tree_conns_lock);
+	status.tree_conn->t_state = TREE_CONNECTED;
+	write_unlock(&sess->tree_conns_lock);
 	rsp->StructureSize = cpu_to_le16(16);
+out_err1:
 	rsp->Capabilities = 0;
 	rsp->Reserved = 0;
 	/* default manual caching */
 	rsp->ShareFlags = SMB2_SHAREFLAG_MANUAL_CACHING;
-	inc_rfc1001_len(rsp, 16);
+
+	rc = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_tree_connect_rsp));
+	if (rc)
+		status.ret = KSMBD_TREE_CONN_STATUS_NOMEM;
 
 	if (!IS_ERR(treename))
 		kfree(treename);
@@ -1992,6 +2015,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 		rsp->hdr.Status = STATUS_SUCCESS;
 		rc = 0;
 		break;
+	case -ESTALE:
 	case -ENOENT:
 	case KSMBD_TREE_CONN_STATUS_NO_SHARE:
 		rsp->hdr.Status = STATUS_BAD_NETWORK_NAME;
@@ -2012,6 +2036,9 @@ int smb2_tree_connect(struct ksmbd_work *work)
 		rsp->hdr.Status = STATUS_ACCESS_DENIED;
 	}
 
+	if (status.ret != KSMBD_TREE_CONN_STATUS_OK)
+		smb2_set_err_rsp(work);
+
 	return rc;
 }
 
@@ -2086,28 +2113,60 @@ static int smb2_create_open_flags(bool file_present, __le32 access,
  */
 int smb2_tree_disconnect(struct ksmbd_work *work)
 {
-	struct smb2_tree_disconnect_rsp *rsp = work->response_buf;
+	struct smb2_tree_disconnect_rsp *rsp;
+	struct smb2_tree_disconnect_req *req;
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_tree_connect *tcon = work->tcon;
+	int err;
 
-	rsp->StructureSize = cpu_to_le16(4);
-	inc_rfc1001_len(rsp, 4);
+	WORK_BUFFERS(work, req, rsp);
 
 	ksmbd_debug(SMB, "request\n");
 
 	if (!tcon) {
-		struct smb2_tree_disconnect_req *req = work->request_buf;
-
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
+
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
-		smb2_set_err_rsp(work);
-		return 0;
+		err = -ENOENT;
+		goto err_out;
 	}
 
 	ksmbd_close_tree_conn_fds(work);
-	ksmbd_tree_conn_disconnect(sess, tcon);
+
+	write_lock(&sess->tree_conns_lock);
+	if (tcon->t_state == TREE_DISCONNECTED) {
+		write_unlock(&sess->tree_conns_lock);
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	WARN_ON_ONCE(atomic_dec_and_test(&tcon->refcount));
+	tcon->t_state = TREE_DISCONNECTED;
+	write_unlock(&sess->tree_conns_lock);
+
+	err = ksmbd_tree_conn_disconnect(sess, tcon);
+	if (err) {
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
+		goto err_out;
+	}
+
 	work->tcon = NULL;
+
+	rsp->StructureSize = cpu_to_le16(4);
+	err = ksmbd_iov_pin_rsp(work, rsp,
+				sizeof(struct smb2_tree_disconnect_rsp));
+	if (err) {
+		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+		goto err_out;
+	}
+
 	return 0;
+
+err_out:
+	smb2_set_err_rsp(work);
+	return err;
+
 }
 
 /**
@@ -2119,26 +2178,40 @@ int smb2_tree_disconnect(struct ksmbd_work *work)
 int smb2_session_logoff(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_logoff_rsp *rsp = work->response_buf;
-	struct ksmbd_session *sess = work->sess;
+	struct smb2_logoff_req *req;
+	struct smb2_logoff_rsp *rsp;
+	struct ksmbd_session *sess;
+	u64 sess_id;
+	int err;
 
-	rsp->StructureSize = cpu_to_le16(4);
-	inc_rfc1001_len(rsp, 4);
+	WORK_BUFFERS(work, req, rsp);
 
 	ksmbd_debug(SMB, "request\n");
 
-	/* setting CifsExiting here may race with start_tcp_sess */
-	ksmbd_conn_set_need_reconnect(work);
+	ksmbd_conn_lock(conn);
+	if (!ksmbd_conn_good(conn)) {
+		ksmbd_conn_unlock(conn);
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
+		smb2_set_err_rsp(work);
+		return -ENOENT;
+	}
+	sess_id = le64_to_cpu(req->hdr.SessionId);
+	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_RECONNECT);
+	ksmbd_conn_unlock(conn);
+
 	ksmbd_close_session_fds(work);
-	ksmbd_conn_wait_idle(conn);
+	ksmbd_conn_wait_idle(conn, sess_id);
 
+	/*
+	 * Re-lookup session to validate if session is deleted
+	 * while waiting request complete
+	 */
+	sess = ksmbd_session_lookup_all(conn, sess_id);
 	if (ksmbd_tree_conn_session_logoff(sess)) {
-		struct smb2_logoff_req *req = work->request_buf;
-
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
 		smb2_set_err_rsp(work);
-		return 0;
+		return -ENOENT;
 	}
 
 	ksmbd_destroy_file_table(&sess->file_table);
@@ -2146,9 +2219,15 @@ int smb2_session_logoff(struct ksmbd_work *work)
 
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;
+	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);
 
-	/* let start_tcp_sess free connection info now */
-	ksmbd_conn_set_need_negotiate(work);
+	rsp->StructureSize = cpu_to_le16(4);
+	err = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_logoff_rsp));
+	if (err) {
+		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+		smb2_set_err_rsp(work);
+		return err;
+	}
 	return 0;
 }
 
@@ -2160,12 +2239,14 @@ int smb2_session_logoff(struct ksmbd_work *work)
  */
 static noinline int create_smb2_pipe(struct ksmbd_work *work)
 {
-	struct smb2_create_rsp *rsp = work->response_buf;
-	struct smb2_create_req *req = work->request_buf;
+	struct smb2_create_rsp *rsp;
+	struct smb2_create_req *req;
 	int id;
 	int err;
 	char *name;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	name = smb_strndup_from_utf16(req->Buffer, le16_to_cpu(req->NameLength),
 				      1, work->conn->local_nls);
 	if (IS_ERR(name)) {
@@ -2194,12 +2275,15 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
 	rsp->EndofFile = cpu_to_le64(0);
 	rsp->FileAttributes = ATTR_NORMAL_LE;
 	rsp->Reserved2 = 0;
-	rsp->VolatileFileId = cpu_to_le64(id);
+	rsp->VolatileFileId = id;
 	rsp->PersistentFileId = 0;
 	rsp->CreateContextsOffset = 0;
 	rsp->CreateContextsLength = 0;
 
-	inc_rfc1001_len(rsp, 88); /* StructureSize - 1*/
+	err = ksmbd_iov_pin_rsp(work, rsp, offsetof(struct smb2_create_rsp, Buffer));
+	if (err)
+		goto out;
+
 	kfree(name);
 	return 0;
 
@@ -2231,7 +2315,7 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
  * Return:	0 on success, otherwise error
  */
 static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
-		       struct path *path)
+		       const struct path *path)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *attr_name = NULL, *value;
@@ -2278,7 +2362,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			/* delete the EA only when it exits */
 			if (rc > 0) {
 				rc = ksmbd_vfs_remove_xattr(user_ns,
-							    path->dentry,
+							    path,
 							    attr_name);
 
 				if (rc < 0) {
@@ -2292,9 +2376,9 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			/* if the EA doesn't exist, just do nothing. */
 			rc = 0;
 		} else {
-			rc = ksmbd_vfs_setxattr(user_ns,
-						path->dentry, attr_name, value,
-						le16_to_cpu(eabuf->EaValueLength), 0);
+			rc = ksmbd_vfs_setxattr(user_ns, path, attr_name, value,
+						le16_to_cpu(eabuf->EaValueLength),
+						0, true);
 			if (rc < 0) {
 				ksmbd_debug(SMB,
 					    "ksmbd_vfs_setxattr is failed(%d)\n",
@@ -2325,7 +2409,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 	return rc;
 }
 
-static noinline int smb2_set_stream_name_xattr(struct path *path,
+static noinline int smb2_set_stream_name_xattr(const struct path *path,
 					       struct ksmbd_file *fp,
 					       char *stream_name, int s_type)
 {
@@ -2357,14 +2441,13 @@ static noinline int smb2_set_stream_name_xattr(struct path *path,
 		return -EBADF;
 	}
 
-	rc = ksmbd_vfs_setxattr(user_ns, path->dentry,
-				xattr_stream_name, NULL, 0, 0);
+	rc = ksmbd_vfs_setxattr(user_ns, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
 	return 0;
 }
 
-static int smb2_remove_smb_xattrs(struct path *path)
+static int smb2_remove_smb_xattrs(const struct path *path)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *name, *xattr_list = NULL;
@@ -2386,7 +2469,7 @@ static int smb2_remove_smb_xattrs(struct path *path)
 		if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
 		    !strncmp(&name[XATTR_USER_PREFIX_LEN], STREAM_PREFIX,
 			     STREAM_PREFIX_LEN)) {
-			err = ksmbd_vfs_remove_xattr(user_ns, path->dentry,
+			err = ksmbd_vfs_remove_xattr(user_ns, path,
 						     name);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n",
@@ -2398,7 +2481,7 @@ static int smb2_remove_smb_xattrs(struct path *path)
 	return err;
 }
 
-static int smb2_create_truncate(struct path *path)
+static int smb2_create_truncate(const struct path *path)
 {
 	int rc = vfs_truncate(path, 0);
 
@@ -2417,7 +2500,7 @@ static int smb2_create_truncate(struct path *path)
 	return rc;
 }
 
-static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, struct path *path,
+static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *path,
 			    struct ksmbd_file *fp)
 {
 	struct xattr_dos_attrib da = {0};
@@ -2433,14 +2516,13 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, struct path *path,
 	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 		XATTR_DOSINFO_ITIME;
 
-	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt),
-					    path->dentry, &da);
+	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_user_ns(path->mnt), path, &da, false);
 	if (rc)
 		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
 }
 
 static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
-			       struct path *path, struct ksmbd_file *fp)
+			       const struct path *path, struct ksmbd_file *fp)
 {
 	struct xattr_dos_attrib da;
 	int rc;
@@ -2461,8 +2543,9 @@ static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
 	}
 }
 
-static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
-		      int open_flags, umode_t posix_mode, bool is_dir)
+static int smb2_creat(struct ksmbd_work *work, struct path *parent_path,
+		      struct path *path, char *name, int open_flags,
+		      umode_t posix_mode, bool is_dir)
 {
 	struct ksmbd_tree_connect *tcon = work->tcon;
 	struct ksmbd_share_config *share = tcon->share_conf;
@@ -2489,7 +2572,7 @@ static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
 			return rc;
 	}
 
-	rc = ksmbd_vfs_kern_path(work, name, 0, path, 0);
+	rc = ksmbd_vfs_kern_path_locked(work, name, 0, parent_path, path, 0);
 	if (rc) {
 		pr_err("cannot get linux path (%s), err = %d\n",
 		       name, rc);
@@ -2500,7 +2583,7 @@ static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
 
 static int smb2_create_sd_buffer(struct ksmbd_work *work,
 				 struct smb2_create_req *req,
-				 struct path *path)
+				 const struct path *path)
 {
 	struct create_context *context;
 	struct create_sd_buf_req *sd_buf;
@@ -2523,7 +2606,7 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
 	    sizeof(struct create_sd_buf_req))
 		return -EINVAL;
 	return set_info_sec(work->conn, work->tcon, path, &sd_buf->ntsd,
-			    le32_to_cpu(sd_buf->ccontext.DataLength), true);
+			    le32_to_cpu(sd_buf->ccontext.DataLength), true, false);
 }
 
 static void ksmbd_acls_fattr(struct smb_fattr *fattr,
@@ -2555,8 +2638,8 @@ int smb2_open(struct ksmbd_work *work)
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_tree_connect *tcon = work->tcon;
 	struct smb2_create_req *req;
-	struct smb2_create_rsp *rsp, *rsp_org;
-	struct path path;
+	struct smb2_create_rsp *rsp;
+	struct path path, parent_path;
 	struct ksmbd_share_config *share = tcon->share_conf;
 	struct ksmbd_file *fp = NULL;
 	struct file *filp = NULL;
@@ -2580,8 +2663,8 @@ int smb2_open(struct ksmbd_work *work)
 	u64 time;
 	umode_t posix_mode = 0;
 	__le32 daccess, maximal_access = 0;
+	int iov_len = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (req->hdr.NextCommand && !work->next_smb2_rcv_hdr_off &&
@@ -2602,11 +2685,10 @@ int smb2_open(struct ksmbd_work *work)
 		    *(char *)req->Buffer == '\\') {
 			pr_err("not allow directory name included leading slash\n");
 			rc = -EINVAL;
-			goto err_out1;
+			goto err_out2;
 		}
 
-		name = smb2_get_name(share,
-				     req->Buffer,
+		name = smb2_get_name(req->Buffer,
 				     le16_to_cpu(req->NameLength),
 				     work->conn->local_nls);
 		if (IS_ERR(name)) {
@@ -2614,7 +2696,7 @@ int smb2_open(struct ksmbd_work *work)
 			if (rc != -ENOMEM)
 				rc = -ENOENT;
 			name = NULL;
-			goto err_out1;
+			goto err_out2;
 		}
 
 		ksmbd_debug(SMB, "converted name = %s\n", name);
@@ -2622,28 +2704,28 @@ int smb2_open(struct ksmbd_work *work)
 			if (!test_share_config_flag(work->tcon->share_conf,
 						    KSMBD_SHARE_FLAG_STREAMS)) {
 				rc = -EBADF;
-				goto err_out1;
+				goto err_out2;
 			}
 			rc = parse_stream_name(name, &stream_name, &s_type);
 			if (rc < 0)
-				goto err_out1;
+				goto err_out2;
 		}
 
 		rc = ksmbd_validate_filename(name);
 		if (rc < 0)
-			goto err_out1;
+			goto err_out2;
 
 		if (ksmbd_share_veto_filename(share, name)) {
 			rc = -ENOENT;
 			ksmbd_debug(SMB, "Reject open(), vetoed file: %s\n",
 				    name);
-			goto err_out1;
+			goto err_out2;
 		}
 	} else {
 		name = kstrdup("", GFP_KERNEL);
 		if (!name) {
 			rc = -ENOMEM;
-			goto err_out1;
+			goto err_out2;
 		}
 	}
 
@@ -2656,14 +2738,14 @@ int smb2_open(struct ksmbd_work *work)
 		       le32_to_cpu(req->ImpersonationLevel));
 		rc = -EIO;
 		rsp->hdr.Status = STATUS_BAD_IMPERSONATION_LEVEL;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (req->CreateOptions && !(req->CreateOptions & CREATE_OPTIONS_MASK)) {
 		pr_err("Invalid create options : 0x%x\n",
 		       le32_to_cpu(req->CreateOptions));
 		rc = -EINVAL;
-		goto err_out1;
+		goto err_out2;
 	} else {
 		if (req->CreateOptions & FILE_SEQUENTIAL_ONLY_LE &&
 		    req->CreateOptions & FILE_RANDOM_ACCESS_LE)
@@ -2673,13 +2755,13 @@ int smb2_open(struct ksmbd_work *work)
 		    (FILE_OPEN_BY_FILE_ID_LE | CREATE_TREE_CONNECTION |
 		     FILE_RESERVE_OPFILTER_LE)) {
 			rc = -EOPNOTSUPP;
-			goto err_out1;
+			goto err_out2;
 		}
 
 		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
 			if (req->CreateOptions & FILE_NON_DIRECTORY_FILE_LE) {
 				rc = -EINVAL;
-				goto err_out1;
+				goto err_out2;
 			} else if (req->CreateOptions & FILE_NO_COMPRESSION_LE) {
 				req->CreateOptions = ~(FILE_NO_COMPRESSION_LE);
 			}
@@ -2691,21 +2773,21 @@ int smb2_open(struct ksmbd_work *work)
 		pr_err("Invalid create disposition : 0x%x\n",
 		       le32_to_cpu(req->CreateDisposition));
 		rc = -EINVAL;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (!(req->DesiredAccess & DESIRED_ACCESS_MASK)) {
 		pr_err("Invalid desired access : 0x%x\n",
 		       le32_to_cpu(req->DesiredAccess));
 		rc = -EACCES;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (req->FileAttributes && !(req->FileAttributes & ATTR_MASK_LE)) {
 		pr_err("Invalid file attribute : 0x%x\n",
 		       le32_to_cpu(req->FileAttributes));
 		rc = -EINVAL;
-		goto err_out1;
+		goto err_out2;
 	}
 
 	if (req->CreateContextsOffset) {
@@ -2713,19 +2795,19 @@ int smb2_open(struct ksmbd_work *work)
 		context = smb2_find_context_vals(req, SMB2_CREATE_EA_BUFFER, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out1;
+			goto err_out2;
 		} else if (context) {
 			ea_buf = (struct create_ea_buf_req *)context;
 			if (le16_to_cpu(context->DataOffset) +
 			    le32_to_cpu(context->DataLength) <
 			    sizeof(struct create_ea_buf_req)) {
 				rc = -EINVAL;
-				goto err_out1;
+				goto err_out2;
 			}
 			if (req->CreateOptions & FILE_NO_EA_KNOWLEDGE_LE) {
 				rsp->hdr.Status = STATUS_ACCESS_DENIED;
 				rc = -EACCES;
-				goto err_out1;
+				goto err_out2;
 			}
 		}
 
@@ -2733,7 +2815,7 @@ int smb2_open(struct ksmbd_work *work)
 						 SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out1;
+			goto err_out2;
 		} else if (context) {
 			ksmbd_debug(SMB,
 				    "get query maximal access context\n");
@@ -2744,11 +2826,11 @@ int smb2_open(struct ksmbd_work *work)
 						 SMB2_CREATE_TIMEWARP_REQUEST, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out1;
+			goto err_out2;
 		} else if (context) {
 			ksmbd_debug(SMB, "get timewarp context\n");
 			rc = -EBADF;
-			goto err_out1;
+			goto err_out2;
 		}
 
 		if (tcon->posix_extensions) {
@@ -2756,7 +2838,7 @@ int smb2_open(struct ksmbd_work *work)
 							 SMB2_CREATE_TAG_POSIX, 16);
 			if (IS_ERR(context)) {
 				rc = PTR_ERR(context);
-				goto err_out1;
+				goto err_out2;
 			} else if (context) {
 				struct create_posix *posix =
 					(struct create_posix *)context;
@@ -2764,7 +2846,7 @@ int smb2_open(struct ksmbd_work *work)
 				    le32_to_cpu(context->DataLength) <
 				    sizeof(struct create_posix) - 4) {
 					rc = -EINVAL;
-					goto err_out1;
+					goto err_out2;
 				}
 				ksmbd_debug(SMB, "get posix context\n");
 
@@ -2776,11 +2858,14 @@ int smb2_open(struct ksmbd_work *work)
 
 	if (ksmbd_override_fsids(work)) {
 		rc = -ENOMEM;
-		goto err_out1;
+		goto err_out2;
 	}
 
-	rc = ksmbd_vfs_kern_path(work, name, LOOKUP_NO_SYMLINKS, &path, 1);
+	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS,
+					&parent_path, &path, 1);
 	if (!rc) {
+		file_present = true;
+
 		if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE) {
 			/*
 			 * If file exists with under flags, return access
@@ -2789,7 +2874,6 @@ int smb2_open(struct ksmbd_work *work)
 			if (req->CreateDisposition == FILE_OVERWRITE_IF_LE ||
 			    req->CreateDisposition == FILE_OPEN_IF_LE) {
 				rc = -EACCES;
-				path_put(&path);
 				goto err_out;
 			}
 
@@ -2797,27 +2881,23 @@ int smb2_open(struct ksmbd_work *work)
 				ksmbd_debug(SMB,
 					    "User does not have write permission\n");
 				rc = -EACCES;
-				path_put(&path);
 				goto err_out;
 			}
 		} else if (d_is_symlink(path.dentry)) {
 			rc = -EACCES;
-			path_put(&path);
 			goto err_out;
 		}
-	}
 
-	if (rc) {
+		file_present = true;
+		user_ns = mnt_user_ns(path.mnt);
+	} else {
 		if (rc != -ENOENT)
 			goto err_out;
 		ksmbd_debug(SMB, "can not get linux path for %s, rc = %d\n",
 			    name, rc);
 		rc = 0;
-	} else {
-		file_present = true;
-		user_ns = mnt_user_ns(path.mnt);
-		generic_fillattr(user_ns, d_inode(path.dentry), &stat);
 	}
+
 	if (stream_name) {
 		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
 			if (s_type == DATA_STREAM) {
@@ -2825,7 +2905,8 @@ int smb2_open(struct ksmbd_work *work)
 				rsp->hdr.Status = STATUS_NOT_A_DIRECTORY;
 			}
 		} else {
-			if (S_ISDIR(stat.mode) && s_type == DATA_STREAM) {
+			if (file_present && S_ISDIR(d_inode(path.dentry)->i_mode) &&
+			    s_type == DATA_STREAM) {
 				rc = -EIO;
 				rsp->hdr.Status = STATUS_FILE_IS_A_DIRECTORY;
 			}
@@ -2842,7 +2923,8 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 	if (file_present && req->CreateOptions & FILE_NON_DIRECTORY_FILE_LE &&
-	    S_ISDIR(stat.mode) && !(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
+	    S_ISDIR(d_inode(path.dentry)->i_mode) &&
+	    !(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
 		ksmbd_debug(SMB, "open() argument is a directory: %s, %x\n",
 			    name, req->CreateOptions);
 		rsp->hdr.Status = STATUS_FILE_IS_A_DIRECTORY;
@@ -2852,7 +2934,7 @@ int smb2_open(struct ksmbd_work *work)
 
 	if (file_present && (req->CreateOptions & FILE_DIRECTORY_FILE_LE) &&
 	    !(req->CreateDisposition == FILE_CREATE_LE) &&
-	    !S_ISDIR(stat.mode)) {
+	    !S_ISDIR(d_inode(path.dentry)->i_mode)) {
 		rsp->hdr.Status = STATUS_NOT_A_DIRECTORY;
 		rc = -EIO;
 		goto err_out;
@@ -2877,11 +2959,9 @@ int smb2_open(struct ksmbd_work *work)
 		if (!file_present) {
 			daccess = cpu_to_le32(GENERIC_ALL_FLAGS);
 		} else {
-			rc = ksmbd_vfs_query_maximal_access(user_ns,
+			ksmbd_vfs_query_maximal_access(user_ns,
 							    path.dentry,
 							    &daccess);
-			if (rc)
-				goto err_out;
 			already_permitted = true;
 		}
 		maximal_access = daccess;
@@ -2902,7 +2982,8 @@ int smb2_open(struct ksmbd_work *work)
 
 	/*create file if not present */
 	if (!file_present) {
-		rc = smb2_creat(work, &path, name, open_flags, posix_mode,
+		rc = smb2_creat(work, &parent_path, &path, name, open_flags,
+				posix_mode,
 				req->CreateOptions & FILE_DIRECTORY_FILE_LE);
 		if (rc) {
 			if (rc == -ENOENT) {
@@ -2943,15 +3024,16 @@ int smb2_open(struct ksmbd_work *work)
 
 			if ((daccess & FILE_DELETE_LE) ||
 			    (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
-				rc = ksmbd_vfs_may_delete(user_ns,
-							  path.dentry);
+				rc = inode_permission(user_ns,
+						      d_inode(path.dentry->d_parent),
+						      MAY_EXEC | MAY_WRITE);
 				if (rc)
 					goto err_out;
 			}
 		}
 	}
 
-	rc = ksmbd_query_inode_status(d_inode(path.dentry->d_parent));
+	rc = ksmbd_query_inode_status(path.dentry->d_parent);
 	if (rc == KSMBD_INODE_STATUS_PENDING_DELETE) {
 		rc = -EBUSY;
 		goto err_out;
@@ -2996,7 +3078,6 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out;
 	}
 
-	fp->filename = name;
 	fp->cdoption = req->CreateDisposition;
 	fp->daccess = daccess;
 	fp->saccess = req->ShareAccess;
@@ -3008,7 +3089,7 @@ int smb2_open(struct ksmbd_work *work)
 		struct inode *inode = d_inode(path.dentry);
 
 		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(user_ns,
-							   inode,
+							   &path,
 							   d_inode(path.dentry->d_parent));
 		if (posix_acl_rc)
 			ksmbd_debug(SMB, "inherit posix acl failed : %d\n", posix_acl_rc);
@@ -3024,7 +3105,7 @@ int smb2_open(struct ksmbd_work *work)
 			if (rc) {
 				if (posix_acl_rc)
 					ksmbd_vfs_set_init_posix_acl(user_ns,
-								     inode);
+								     &path);
 
 				if (test_share_config_flag(work->tcon->share_conf,
 							   KSMBD_SHARE_FLAG_ACL_XATTR)) {
@@ -3064,9 +3145,10 @@ int smb2_open(struct ksmbd_work *work)
 
 					rc = ksmbd_vfs_set_sd_xattr(conn,
 								    user_ns,
-								    path.dentry,
+								    &path,
 								    pntsd,
-								    pntsd_size);
+								    pntsd_size,
+								    false);
 					kfree(pntsd);
 					if (rc)
 						pr_err("failed to store ntacl in xattr : %d\n",
@@ -3089,11 +3171,6 @@ int smb2_open(struct ksmbd_work *work)
 
 	fp->attrib_only = !(req->DesiredAccess & ~(FILE_READ_ATTRIBUTES_LE |
 			FILE_WRITE_ATTRIBUTES_LE | FILE_SYNCHRONIZE_LE));
-	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC &&
-	    !fp->attrib_only && !stream_name) {
-		smb_break_all_oplock(work, fp);
-		need_truncate = 1;
-	}
 
 	/* fp should be searchable through ksmbd_inode.m_fp_list
 	 * after daccess, saccess, attrib_only, and stream are
@@ -3103,25 +3180,45 @@ int smb2_open(struct ksmbd_work *work)
 	list_add(&fp->node, &fp->f_ci->m_fp_list);
 	write_unlock(&fp->f_ci->m_lock);
 
-	rc = ksmbd_vfs_getattr(&path, &stat);
-	if (rc) {
-		generic_fillattr(user_ns, d_inode(path.dentry), &stat);
-		rc = 0;
-	}
-
 	/* Check delete pending among previous fp before oplock break */
 	if (ksmbd_inode_pending_delete(fp)) {
 		rc = -EBUSY;
 		goto err_out;
 	}
 
+	rc = ksmbd_vfs_getattr(&path, &stat);
+	if (rc)
+		goto err_out;
+
+	if (stat.result_mask & STATX_BTIME)
+		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
+	else
+		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
+	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
+		fp->f_ci->m_fattr =
+			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
+
+	if (!created)
+		smb2_update_xattrs(tcon, &path, fp);
+	else
+		smb2_new_xattrs(tcon, &path, fp);
+
+	if (file_present || created)
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+
+	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC &&
+	    !fp->attrib_only && !stream_name) {
+		smb_break_all_oplock(work, fp);
+		need_truncate = 1;
+	}
+
 	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
 	if (!test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_OPLOCKS) ||
 	    (req_op_level == SMB2_OPLOCK_LEVEL_LEASE &&
 	     !(conn->vals->capabilities & SMB2_GLOBAL_CAP_LEASING))) {
 		if (share_ret < 0 && !S_ISDIR(file_inode(fp->filp)->i_mode)) {
 			rc = share_ret;
-			goto err_out;
+			goto err_out1;
 		}
 	} else {
 		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
@@ -3131,7 +3228,7 @@ int smb2_open(struct ksmbd_work *work)
 				    name, req_op_level, lc->req_state);
 			rc = find_same_lease_key(sess, fp->f_ci, lc);
 			if (rc)
-				goto err_out;
+				goto err_out1;
 		} else if (open_flags == O_RDONLY &&
 			   (req_op_level == SMB2_OPLOCK_LEVEL_BATCH ||
 			    req_op_level == SMB2_OPLOCK_LEVEL_EXCLUSIVE))
@@ -3142,16 +3239,16 @@ int smb2_open(struct ksmbd_work *work)
 				      le32_to_cpu(req->hdr.Id.SyncId.TreeId),
 				      lc, share_ret);
 		if (rc < 0)
-			goto err_out;
+			goto err_out1;
 	}
 
 	if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)
 		ksmbd_fd_set_delete_on_close(fp, file_info);
 
 	if (need_truncate) {
-		rc = smb2_create_truncate(&path);
+		rc = smb2_create_truncate(&fp->filp->f_path);
 		if (rc)
-			goto err_out;
+			goto err_out1;
 	}
 
 	if (req->CreateContextsOffset) {
@@ -3161,7 +3258,7 @@ int smb2_open(struct ksmbd_work *work)
 					SMB2_CREATE_ALLOCATION_SIZE, 4);
 		if (IS_ERR(az_req)) {
 			rc = PTR_ERR(az_req);
-			goto err_out;
+			goto err_out1;
 		} else if (az_req) {
 			loff_t alloc_size;
 			int err;
@@ -3170,7 +3267,7 @@ int smb2_open(struct ksmbd_work *work)
 			    le32_to_cpu(az_req->ccontext.DataLength) <
 			    sizeof(struct create_alloc_size_req)) {
 				rc = -EINVAL;
-				goto err_out;
+				goto err_out1;
 			}
 			alloc_size = le64_to_cpu(az_req->AllocationSize);
 			ksmbd_debug(SMB,
@@ -3188,31 +3285,15 @@ int smb2_open(struct ksmbd_work *work)
 		context = smb2_find_context_vals(req, SMB2_CREATE_QUERY_ON_DISK_ID, 4);
 		if (IS_ERR(context)) {
 			rc = PTR_ERR(context);
-			goto err_out;
+			goto err_out1;
 		} else if (context) {
 			ksmbd_debug(SMB, "get query on disk id context\n");
 			query_disk_id = 1;
 		}
 	}
 
-	if (stat.result_mask & STATX_BTIME)
-		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
-	else
-		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
-	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
-		fp->f_ci->m_fattr =
-			cpu_to_le32(smb2_get_dos_mode(&stat, le32_to_cpu(req->FileAttributes)));
-
-	if (!created)
-		smb2_update_xattrs(tcon, &path, fp);
-	else
-		smb2_new_xattrs(tcon, &path, fp);
-
 	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 
-	generic_fillattr(user_ns, file_inode(fp->filp),
-			 &stat);
-
 	rsp->StructureSize = cpu_to_le16(89);
 	rcu_read_lock();
 	opinfo = rcu_dereference(fp->f_opinfo);
@@ -3234,12 +3315,12 @@ int smb2_open(struct ksmbd_work *work)
 
 	rsp->Reserved2 = 0;
 
-	rsp->PersistentFileId = cpu_to_le64(fp->persistent_id);
-	rsp->VolatileFileId = cpu_to_le64(fp->volatile_id);
+	rsp->PersistentFileId = fp->persistent_id;
+	rsp->VolatileFileId = fp->volatile_id;
 
 	rsp->CreateContextsOffset = 0;
 	rsp->CreateContextsLength = 0;
-	inc_rfc1001_len(rsp_org, 88); /* StructureSize - 1*/
+	iov_len = offsetof(struct smb2_create_rsp, Buffer);
 
 	/* If lease is request send lease context response */
 	if (opinfo && opinfo->is_lease) {
@@ -3254,7 +3335,7 @@ int smb2_open(struct ksmbd_work *work)
 		create_lease_buf(rsp->Buffer, opinfo->o_lease);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_lease_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_lease_size);
+		iov_len += conn->vals->create_lease_size;
 		next_ptr = &lease_ccontext->Next;
 		next_off = conn->vals->create_lease_size;
 	}
@@ -3274,7 +3355,7 @@ int smb2_open(struct ksmbd_work *work)
 				le32_to_cpu(maximal_access));
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_mxac_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_mxac_size);
+		iov_len += conn->vals->create_mxac_size;
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 		next_ptr = &mxac_ccontext->Next;
@@ -3292,7 +3373,7 @@ int smb2_open(struct ksmbd_work *work)
 				stat.ino, tcon->id);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_disk_id_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_disk_id_size);
+		iov_len += conn->vals->create_disk_id_size;
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 		next_ptr = &disk_id_ccontext->Next;
@@ -3306,22 +3387,28 @@ int smb2_open(struct ksmbd_work *work)
 				fp);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_posix_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_posix_size);
+		iov_len += conn->vals->create_posix_size;
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 	}
 
 	if (contxt_cnt > 0) {
 		rsp->CreateContextsOffset =
-			cpu_to_le32(offsetof(struct smb2_create_rsp, Buffer)
-			- 4);
+			cpu_to_le32(offsetof(struct smb2_create_rsp, Buffer));
 	}
 
 err_out:
-	if (file_present || created)
-		path_put(&path);
-	ksmbd_revert_fsids(work);
+	if (rc && (file_present || created))
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+
 err_out1:
+	ksmbd_revert_fsids(work);
+
+err_out2:
+	if (!rc) {
+		ksmbd_update_fstate(&work->sess->file_table, fp, FP_INITED);
+		rc = ksmbd_iov_pin_rsp(work, (void *)rsp, iov_len);
+	}
 	if (rc) {
 		if (rc == -EINVAL)
 			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
@@ -3348,14 +3435,13 @@ int smb2_open(struct ksmbd_work *work)
 		if (!rsp->hdr.Status)
 			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
 
-		if (!fp || !fp->filename)
-			kfree(name);
 		if (fp)
 			ksmbd_fd_put(work, fp);
 		smb2_set_err_rsp(work);
 		ksmbd_debug(SMB, "Error response: %x\n", rsp->hdr.Status);
 	}
 
+	kfree(name);
 	kfree(lc);
 
 	return 0;
@@ -3467,7 +3553,6 @@ static int dentry_name(struct ksmbd_dir_info *d_info, int info_level)
  * @conn:	connection instance
  * @info_level:	smb information level
  * @d_info:	structure included variables for query dir
- * @user_ns:	user namespace
  * @ksmbd_kstat:	ksmbd wrapper of dirent stat information
  *
  * if directory has many entries, find first can't read it fully.
@@ -3497,7 +3582,7 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		goto free_conv_name;
 	}
 
-	struct_sz = readdir_info_level_struct_sz(info_level) - 1 + conv_len;
+	struct_sz = readdir_info_level_struct_sz(info_level) + conv_len;
 	next_entry_offset = ALIGN(struct_sz, KSMBD_DIR_INFO_ALIGNMENT);
 	d_info->last_entry_off_align = next_entry_offset - struct_sz;
 
@@ -3624,16 +3709,21 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		posix_info->AllocationSize = cpu_to_le64(ksmbd_kstat->kstat->blocks << 9);
 		posix_info->DeviceId = cpu_to_le32(ksmbd_kstat->kstat->rdev);
 		posix_info->HardLinks = cpu_to_le32(ksmbd_kstat->kstat->nlink);
-		posix_info->Mode = cpu_to_le32(ksmbd_kstat->kstat->mode);
+		posix_info->Mode = cpu_to_le32(ksmbd_kstat->kstat->mode & 0777);
 		posix_info->Inode = cpu_to_le64(ksmbd_kstat->kstat->ino);
 		posix_info->DosAttributes =
 			S_ISDIR(ksmbd_kstat->kstat->mode) ? ATTR_DIRECTORY_LE : ATTR_ARCHIVE_LE;
 		if (d_info->hide_dot_file && d_info->name[0] == '.')
 			posix_info->DosAttributes |= ATTR_HIDDEN_LE;
+		/*
+		 * SidBuffer(32) contain two sids(Domain sid(16), UNIX group sid(16)).
+		 * UNIX sid(16) = revision(1) + num_subauth(1) + authority(6) +
+		 *		  sub_auth(4 * 1(num_subauth)) + RID(4).
+		 */
 		id_to_sid(from_kuid_munged(&init_user_ns, ksmbd_kstat->kstat->uid),
-			  SIDNFS_USER, (struct smb_sid *)&posix_info->SidBuffer[0]);
+			  SIDUNIX_USER, (struct smb_sid *)&posix_info->SidBuffer[0]);
 		id_to_sid(from_kgid_munged(&init_user_ns, ksmbd_kstat->kstat->gid),
-			  SIDNFS_GROUP, (struct smb_sid *)&posix_info->SidBuffer[20]);
+			  SIDUNIX_GROUP, (struct smb_sid *)&posix_info->SidBuffer[16]);
 		memcpy(posix_info->name, conv_name, conv_len);
 		posix_info->name_len = cpu_to_le32(conv_len);
 		posix_info->NextEntryOffset = cpu_to_le32(next_entry_offset);
@@ -3743,7 +3833,7 @@ static int reserve_populate_dentry(struct ksmbd_dir_info *d_info,
 		return -EOPNOTSUPP;
 
 	conv_len = (d_info->name_len + 1) * 2;
-	next_entry_offset = ALIGN(struct_sz - 1 + conv_len,
+	next_entry_offset = ALIGN(struct_sz + conv_len,
 				  KSMBD_DIR_INFO_ALIGNMENT);
 
 	if (next_entry_offset > d_info->out_buf_len) {
@@ -3917,7 +4007,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_query_directory_req *req;
-	struct smb2_query_directory_rsp *rsp, *rsp_org;
+	struct smb2_query_directory_rsp *rsp;
 	struct ksmbd_share_config *share = work->tcon->share_conf;
 	struct ksmbd_file *dir_fp = NULL;
 	struct ksmbd_dir_info d_info;
@@ -3927,7 +4017,6 @@ int smb2_query_dir(struct ksmbd_work *work)
 	int buffer_sz;
 	struct smb2_query_dir_private query_dir_private = {NULL, };
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (ksmbd_override_fsids(work)) {
@@ -3942,9 +4031,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 		goto err_out2;
 	}
 
-	dir_fp = ksmbd_lookup_fd_slow(work,
-				      le64_to_cpu(req->VolatileFileId),
-				      le64_to_cpu(req->PersistentFileId));
+	dir_fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!dir_fp) {
 		rc = -EBADF;
 		goto err_out2;
@@ -3954,8 +4041,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 	    inode_permission(file_mnt_user_ns(dir_fp->filp),
 			     file_inode(dir_fp->filp),
 			     MAY_READ | MAY_EXEC)) {
-		pr_err("no right to enumerate directory (%pd)\n",
-		       dir_fp->filp->f_path.dentry);
+		pr_err("no right to enumerate directory (%pD)\n", dir_fp->filp);
 		rc = -EACCES;
 		goto err_out2;
 	}
@@ -3978,8 +4064,6 @@ int smb2_query_dir(struct ksmbd_work *work)
 		ksmbd_debug(SMB, "Search pattern is %s\n", srch_ptr);
 	}
 
-	ksmbd_debug(SMB, "Directory name is %s\n", dir_fp->filename);
-
 	if (srch_flag & SMB2_REOPEN || srch_flag & SMB2_RESTART_SCANS) {
 		ksmbd_debug(SMB, "Restart directory scan\n");
 		generic_file_llseek(dir_fp->filp, 0, SEEK_SET);
@@ -4051,7 +4135,10 @@ int smb2_query_dir(struct ksmbd_work *work)
 		rsp->OutputBufferOffset = cpu_to_le16(0);
 		rsp->OutputBufferLength = cpu_to_le32(0);
 		rsp->Buffer[0] = 0;
-		inc_rfc1001_len(rsp_org, 9);
+		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
+				       sizeof(struct smb2_query_directory_rsp));
+		if (rc)
+			goto err_out;
 	} else {
 no_buf_len:
 		((struct file_directory_info *)
@@ -4063,7 +4150,11 @@ int smb2_query_dir(struct ksmbd_work *work)
 		rsp->StructureSize = cpu_to_le16(9);
 		rsp->OutputBufferOffset = cpu_to_le16(72);
 		rsp->OutputBufferLength = cpu_to_le32(d_info.data_count);
-		inc_rfc1001_len(rsp_org, 8 + d_info.data_count);
+		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
+				       offsetof(struct smb2_query_directory_rsp, Buffer) +
+				       d_info.data_count);
+		if (rc)
+			goto err_out;
 	}
 
 	kfree(srch_ptr);
@@ -4103,31 +4194,25 @@ int smb2_query_dir(struct ksmbd_work *work)
  * buffer_check_err() - helper function to check buffer errors
  * @reqOutputBufferLength:	max buffer length expected in command response
  * @rsp:		query info response buffer contains output buffer length
- * @infoclass_size:	query info class response buffer size
+ * @rsp_org:		base response buffer pointer in case of chained response
  *
  * Return:	0 on success, otherwise error
  */
 static int buffer_check_err(int reqOutputBufferLength,
-			    struct smb2_query_info_rsp *rsp, int infoclass_size)
+			    struct smb2_query_info_rsp *rsp,
+			    void *rsp_org)
 {
 	if (reqOutputBufferLength < le32_to_cpu(rsp->OutputBufferLength)) {
-		if (reqOutputBufferLength < infoclass_size) {
-			pr_err("Invalid Buffer Size Requested\n");
-			rsp->hdr.Status = STATUS_INFO_LENGTH_MISMATCH;
-			rsp->hdr.smb2_buf_length = cpu_to_be32(sizeof(struct smb2_hdr) - 4);
-			return -EINVAL;
-		}
-
-		ksmbd_debug(SMB, "Buffer Overflow\n");
-		rsp->hdr.Status = STATUS_BUFFER_OVERFLOW;
-		rsp->hdr.smb2_buf_length = cpu_to_be32(sizeof(struct smb2_hdr) - 4 +
-				reqOutputBufferLength);
-		rsp->OutputBufferLength = cpu_to_le32(reqOutputBufferLength);
+		pr_err("Invalid Buffer Size Requested\n");
+		rsp->hdr.Status = STATUS_INFO_LENGTH_MISMATCH;
+		*(__be32 *)rsp_org = cpu_to_be32(sizeof(struct smb2_hdr));
+		return -EINVAL;
 	}
 	return 0;
 }
 
-static void get_standard_info_pipe(struct smb2_query_info_rsp *rsp)
+static void get_standard_info_pipe(struct smb2_query_info_rsp *rsp,
+				   void *rsp_org)
 {
 	struct smb2_file_standard_info *sinfo;
 
@@ -4140,10 +4225,10 @@ static void get_standard_info_pipe(struct smb2_query_info_rsp *rsp)
 	sinfo->Directory = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_standard_info));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_file_standard_info));
 }
 
-static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp, u64 num)
+static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp, u64 num,
+				   void *rsp_org)
 {
 	struct smb2_file_internal_info *file_info;
 
@@ -4153,12 +4238,12 @@ static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp, u64 num)
 	file_info->IndexNumber = cpu_to_le64(num | (1ULL << 63));
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_internal_info));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_file_internal_info));
 }
 
 static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
 				   struct smb2_query_info_req *req,
-				   struct smb2_query_info_rsp *rsp)
+				   struct smb2_query_info_rsp *rsp,
+				   void *rsp_org)
 {
 	u64 id;
 	int rc;
@@ -4167,23 +4252,23 @@ static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
 	 * Windows can sometime send query file info request on
 	 * pipe without opening it, checking error condition here
 	 */
-	id = le64_to_cpu(req->VolatileFileId);
+	id = req->VolatileFileId;
 	if (!ksmbd_session_rpc_method(sess, id))
 		return -ENOENT;
 
 	ksmbd_debug(SMB, "FileInfoClass %u, FileId 0x%llx\n",
-		    req->FileInfoClass, le64_to_cpu(req->VolatileFileId));
+		    req->FileInfoClass, req->VolatileFileId);
 
 	switch (req->FileInfoClass) {
 	case FILE_STANDARD_INFORMATION:
-		get_standard_info_pipe(rsp);
+		get_standard_info_pipe(rsp, rsp_org);
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp, FILE_STANDARD_INFORMATION_SIZE);
+				      rsp, rsp_org);
 		break;
 	case FILE_INTERNAL_INFORMATION:
-		get_internal_info_pipe(rsp, id);
+		get_internal_info_pipe(rsp, id, rsp_org);
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp, FILE_INTERNAL_INFORMATION_SIZE);
+				      rsp, rsp_org);
 		break;
 	default:
 		ksmbd_debug(SMB, "smb2_info_file_pipe for %u not supported\n",
@@ -4212,7 +4297,7 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 	int rc, name_len, value_len, xattr_list_len, idx;
 	ssize_t buf_free_len, alignment_bytes, next_offset, rsp_data_cnt = 0;
 	struct smb2_ea_info_req *ea_req = NULL;
-	struct path *path;
+	const struct path *path;
 	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
 
 	if (!(fp->daccess & FILE_READ_EA_LE)) {
@@ -4351,7 +4436,6 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 	if (rsp_data_cnt == 0)
 		rsp->hdr.Status = STATUS_NO_EAS_ON_FILE;
 	rsp->OutputBufferLength = cpu_to_le32(rsp_data_cnt);
-	inc_rfc1001_len(rsp_org, rsp_data_cnt);
 out:
 	kvfree(xattr_list);
 	return rc;
@@ -4366,7 +4450,6 @@ static void get_file_access_info(struct smb2_query_info_rsp *rsp,
 	file_info->AccessFlags = fp->daccess;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_access_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_access_info));
 }
 
 static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
@@ -4396,7 +4479,6 @@ static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
 	basic_info->Pad1 = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_basic_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_basic_info));
 	return 0;
 }
 
@@ -4421,8 +4503,6 @@ static void get_file_standard_info(struct smb2_query_info_rsp *rsp,
 	sinfo->Directory = S_ISDIR(stat.mode) ? 1 : 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_standard_info));
-	inc_rfc1001_len(rsp_org,
-			sizeof(struct smb2_file_standard_info));
 }
 
 static void get_file_alignment_info(struct smb2_query_info_rsp *rsp,
@@ -4434,8 +4514,6 @@ static void get_file_alignment_info(struct smb2_query_info_rsp *rsp,
 	file_info->AlignmentRequirement = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_alignment_info));
-	inc_rfc1001_len(rsp_org,
-			sizeof(struct smb2_file_alignment_info));
 }
 
 static int get_file_all_info(struct ksmbd_work *work,
@@ -4458,9 +4536,9 @@ static int get_file_all_info(struct ksmbd_work *work,
 		return -EACCES;
 	}
 
-	filename = convert_to_nt_pathname(fp->filename);
-	if (!filename)
-		return -ENOMEM;
+	filename = convert_to_nt_pathname(work->tcon->share_conf, &fp->filp->f_path);
+	if (IS_ERR(filename))
+		return PTR_ERR(filename);
 
 	inode = file_inode(fp->filp);
 	generic_fillattr(file_mnt_user_ns(fp->filp), inode, &stat);
@@ -4499,7 +4577,6 @@ static int get_file_all_info(struct ksmbd_work *work,
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_all_info) + conv_len - 1);
 	kfree(filename);
-	inc_rfc1001_len(rsp_org, le32_to_cpu(rsp->OutputBufferLength));
 	return 0;
 }
 
@@ -4522,7 +4599,6 @@ static void get_file_alternate_info(struct ksmbd_work *work,
 	file_info->FileNameLength = cpu_to_le32(conv_len);
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_alt_name_info) + conv_len);
-	inc_rfc1001_len(rsp_org, le32_to_cpu(rsp->OutputBufferLength));
 }
 
 static void get_file_stream_info(struct ksmbd_work *work,
@@ -4534,7 +4610,7 @@ static void get_file_stream_info(struct ksmbd_work *work,
 	struct smb2_file_stream_info *file_info;
 	char *stream_name, *xattr_list = NULL, *stream_buf;
 	struct kstat stat;
-	struct path *path = &fp->filp->f_path;
+	const struct path *path = &fp->filp->f_path;
 	ssize_t xattr_list_len;
 	int nbytes = 0, streamlen, stream_name_len, next, idx = 0;
 	int buf_free_len;
@@ -4622,7 +4698,6 @@ static void get_file_stream_info(struct ksmbd_work *work,
 	kvfree(xattr_list);
 
 	rsp->OutputBufferLength = cpu_to_le32(nbytes);
-	inc_rfc1001_len(rsp_org, nbytes);
 }
 
 static void get_file_internal_info(struct smb2_query_info_rsp *rsp,
@@ -4637,7 +4712,6 @@ static void get_file_internal_info(struct smb2_query_info_rsp *rsp,
 	file_info->IndexNumber = cpu_to_le64(stat.ino);
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_internal_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_internal_info));
 }
 
 static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
@@ -4673,7 +4747,6 @@ static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
 	file_info->Reserved = cpu_to_le32(0);
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_ntwrk_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_ntwrk_info));
 	return 0;
 }
 
@@ -4685,7 +4758,6 @@ static void get_file_ea_info(struct smb2_query_info_rsp *rsp, void *rsp_org)
 	file_info->EASize = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_ea_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_ea_info));
 }
 
 static void get_file_position_info(struct smb2_query_info_rsp *rsp,
@@ -4697,7 +4769,6 @@ static void get_file_position_info(struct smb2_query_info_rsp *rsp,
 	file_info->CurrentByteOffset = cpu_to_le64(fp->filp->f_pos);
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_pos_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_pos_info));
 }
 
 static void get_file_mode_info(struct smb2_query_info_rsp *rsp,
@@ -4709,7 +4780,6 @@ static void get_file_mode_info(struct smb2_query_info_rsp *rsp,
 	file_info->Mode = fp->coption & FILE_MODE_INFO_MASK;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_mode_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_mode_info));
 }
 
 static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
@@ -4731,7 +4801,6 @@ static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
 
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_comp_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_comp_info));
 }
 
 static int get_file_attribute_tag_info(struct smb2_query_info_rsp *rsp,
@@ -4750,16 +4819,17 @@ static int get_file_attribute_tag_info(struct smb2_query_info_rsp *rsp,
 	file_info->ReparseTag = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_attr_tag_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_attr_tag_info));
 	return 0;
 }
 
-static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
+static void find_file_posix_info(struct smb2_query_info_rsp *rsp,
 				struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb311_posix_qinfo *file_info;
 	struct inode *inode = file_inode(fp->filp);
+	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
 	u64 time;
+	int out_buf_len = sizeof(struct smb311_posix_qinfo) + 32;
 
 	file_info = (struct smb311_posix_qinfo *)rsp->Buffer;
 	file_info->CreationTime = cpu_to_le64(fp->create_time);
@@ -4774,32 +4844,44 @@ static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 	file_info->EndOfFile = cpu_to_le64(inode->i_size);
 	file_info->AllocationSize = cpu_to_le64(inode->i_blocks << 9);
 	file_info->HardLinks = cpu_to_le32(inode->i_nlink);
-	file_info->Mode = cpu_to_le32(inode->i_mode);
+	file_info->Mode = cpu_to_le32(inode->i_mode & 0777);
 	file_info->DeviceId = cpu_to_le32(inode->i_rdev);
-	rsp->OutputBufferLength =
-		cpu_to_le32(sizeof(struct smb311_posix_qinfo));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb311_posix_qinfo));
-	return 0;
+
+	/*
+	 * Sids(32) contain two sids(Domain sid(16), UNIX group sid(16)).
+	 * UNIX sid(16) = revision(1) + num_subauth(1) + authority(6) +
+	 *		  sub_auth(4 * 1(num_subauth)) + RID(4).
+	 */
+	id_to_sid(from_kuid_munged(&init_user_ns,
+				   i_uid_into_mnt(user_ns, inode)),
+				   SIDUNIX_USER,
+				   (struct smb_sid *)&file_info->Sids[0]);
+	id_to_sid(from_kgid_munged(&init_user_ns,
+				   i_gid_into_mnt(user_ns, inode)),
+				   SIDUNIX_GROUP,
+				   (struct smb_sid *)&file_info->Sids[16]);
+
+	rsp->OutputBufferLength = cpu_to_le32(out_buf_len);
 }
 
 static int smb2_get_info_file(struct ksmbd_work *work,
 			      struct smb2_query_info_req *req,
-			      struct smb2_query_info_rsp *rsp, void *rsp_org)
+			      struct smb2_query_info_rsp *rsp)
 {
 	struct ksmbd_file *fp;
 	int fileinfoclass = 0;
 	int rc = 0;
-	int file_infoclass_size;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_PIPE)) {
 		/* smb2 info file called for pipe */
-		return smb2_get_info_file_pipe(work->sess, req, rsp);
+		return smb2_get_info_file_pipe(work->sess, req, rsp,
+					       work->response_buf);
 	}
 
 	if (work->next_smb2_rcv_hdr_off) {
-		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+		if (!has_file_id(req->VolatileFileId)) {
 			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
 				    work->compound_fid);
 			id = work->compound_fid;
@@ -4808,8 +4890,8 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 	}
 
 	if (!has_file_id(id)) {
-		id = le64_to_cpu(req->VolatileFileId);
-		pid = le64_to_cpu(req->PersistentFileId);
+		id = req->VolatileFileId;
+		pid = req->PersistentFileId;
 	}
 
 	fp = ksmbd_lookup_fd_slow(work, id, pid);
@@ -4820,86 +4902,70 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 
 	switch (fileinfoclass) {
 	case FILE_ACCESS_INFORMATION:
-		get_file_access_info(rsp, fp, rsp_org);
-		file_infoclass_size = FILE_ACCESS_INFORMATION_SIZE;
+		get_file_access_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_BASIC_INFORMATION:
-		rc = get_file_basic_info(rsp, fp, rsp_org);
-		file_infoclass_size = FILE_BASIC_INFORMATION_SIZE;
+		rc = get_file_basic_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_STANDARD_INFORMATION:
-		get_file_standard_info(rsp, fp, rsp_org);
-		file_infoclass_size = FILE_STANDARD_INFORMATION_SIZE;
+		get_file_standard_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_ALIGNMENT_INFORMATION:
-		get_file_alignment_info(rsp, rsp_org);
-		file_infoclass_size = FILE_ALIGNMENT_INFORMATION_SIZE;
+		get_file_alignment_info(rsp, work->response_buf);
 		break;
 
 	case FILE_ALL_INFORMATION:
-		rc = get_file_all_info(work, rsp, fp, rsp_org);
-		file_infoclass_size = FILE_ALL_INFORMATION_SIZE;
+		rc = get_file_all_info(work, rsp, fp, work->response_buf);
 		break;
 
 	case FILE_ALTERNATE_NAME_INFORMATION:
-		get_file_alternate_info(work, rsp, fp, rsp_org);
-		file_infoclass_size = FILE_ALTERNATE_NAME_INFORMATION_SIZE;
+		get_file_alternate_info(work, rsp, fp, work->response_buf);
 		break;
 
 	case FILE_STREAM_INFORMATION:
-		get_file_stream_info(work, rsp, fp, rsp_org);
-		file_infoclass_size = FILE_STREAM_INFORMATION_SIZE;
+		get_file_stream_info(work, rsp, fp, work->response_buf);
 		break;
 
 	case FILE_INTERNAL_INFORMATION:
-		get_file_internal_info(rsp, fp, rsp_org);
-		file_infoclass_size = FILE_INTERNAL_INFORMATION_SIZE;
+		get_file_internal_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_NETWORK_OPEN_INFORMATION:
-		rc = get_file_network_open_info(rsp, fp, rsp_org);
-		file_infoclass_size = FILE_NETWORK_OPEN_INFORMATION_SIZE;
+		rc = get_file_network_open_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_EA_INFORMATION:
-		get_file_ea_info(rsp, rsp_org);
-		file_infoclass_size = FILE_EA_INFORMATION_SIZE;
+		get_file_ea_info(rsp, work->response_buf);
 		break;
 
 	case FILE_FULL_EA_INFORMATION:
-		rc = smb2_get_ea(work, fp, req, rsp, rsp_org);
-		file_infoclass_size = FILE_FULL_EA_INFORMATION_SIZE;
+		rc = smb2_get_ea(work, fp, req, rsp, work->response_buf);
 		break;
 
 	case FILE_POSITION_INFORMATION:
-		get_file_position_info(rsp, fp, rsp_org);
-		file_infoclass_size = FILE_POSITION_INFORMATION_SIZE;
+		get_file_position_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_MODE_INFORMATION:
-		get_file_mode_info(rsp, fp, rsp_org);
-		file_infoclass_size = FILE_MODE_INFORMATION_SIZE;
+		get_file_mode_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_COMPRESSION_INFORMATION:
-		get_file_compression_info(rsp, fp, rsp_org);
-		file_infoclass_size = FILE_COMPRESSION_INFORMATION_SIZE;
+		get_file_compression_info(rsp, fp, work->response_buf);
 		break;
 
 	case FILE_ATTRIBUTE_TAG_INFORMATION:
-		rc = get_file_attribute_tag_info(rsp, fp, rsp_org);
-		file_infoclass_size = FILE_ATTRIBUTE_TAG_INFORMATION_SIZE;
+		rc = get_file_attribute_tag_info(rsp, fp, work->response_buf);
 		break;
 	case SMB_FIND_FILE_POSIX_INFO:
 		if (!work->tcon->posix_extensions) {
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
 			rc = -EOPNOTSUPP;
 		} else {
-			rc = find_file_posix_info(rsp, fp, rsp_org);
-			file_infoclass_size = sizeof(struct smb311_posix_qinfo);
+			find_file_posix_info(rsp, fp, work->response_buf);
 		}
 		break;
 	default:
@@ -4909,15 +4975,14 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 	}
 	if (!rc)
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp,
-				      file_infoclass_size);
+				      rsp, work->response_buf);
 	ksmbd_fd_put(work, fp);
 	return rc;
 }
 
 static int smb2_get_info_filesystem(struct ksmbd_work *work,
 				    struct smb2_query_info_req *req,
-				    struct smb2_query_info_rsp *rsp, void *rsp_org)
+				    struct smb2_query_info_rsp *rsp)
 {
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_conn *conn = work->conn;
@@ -4926,7 +4991,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	struct kstatfs stfs;
 	struct path path;
 	int rc = 0, len;
-	int fs_infoclass_size = 0;
 
 	if (!share->path)
 		return -EIO;
@@ -4956,8 +5020,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->DeviceType = cpu_to_le32(stfs.f_type);
 		info->DeviceCharacteristics = cpu_to_le32(0x00000020);
 		rsp->OutputBufferLength = cpu_to_le32(8);
-		inc_rfc1001_len(rsp_org, 8);
-		fs_infoclass_size = FS_DEVICE_INFORMATION_SIZE;
 		break;
 	}
 	case FS_ATTRIBUTE_INFORMATION:
@@ -4986,8 +5048,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->FileSystemNameLen = cpu_to_le32(len);
 		sz = sizeof(struct filesystem_attribute_info) - 2 + len;
 		rsp->OutputBufferLength = cpu_to_le32(sz);
-		inc_rfc1001_len(rsp_org, sz);
-		fs_infoclass_size = FS_ATTRIBUTE_INFORMATION_SIZE;
 		break;
 	}
 	case FS_VOLUME_INFORMATION:
@@ -5014,8 +5074,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->Reserved = 0;
 		sz = sizeof(struct filesystem_vol_info) - 2 + len;
 		rsp->OutputBufferLength = cpu_to_le32(sz);
-		inc_rfc1001_len(rsp_org, sz);
-		fs_infoclass_size = FS_VOLUME_INFORMATION_SIZE;
 		break;
 	}
 	case FS_SIZE_INFORMATION:
@@ -5028,8 +5086,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->SectorsPerAllocationUnit = cpu_to_le32(1);
 		info->BytesPerSector = cpu_to_le32(stfs.f_bsize);
 		rsp->OutputBufferLength = cpu_to_le32(24);
-		inc_rfc1001_len(rsp_org, 24);
-		fs_infoclass_size = FS_SIZE_INFORMATION_SIZE;
 		break;
 	}
 	case FS_FULL_SIZE_INFORMATION:
@@ -5045,8 +5101,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->SectorsPerAllocationUnit = cpu_to_le32(1);
 		info->BytesPerSector = cpu_to_le32(stfs.f_bsize);
 		rsp->OutputBufferLength = cpu_to_le32(32);
-		inc_rfc1001_len(rsp_org, 32);
-		fs_infoclass_size = FS_FULL_SIZE_INFORMATION_SIZE;
 		break;
 	}
 	case FS_OBJECT_ID_INFORMATION:
@@ -5066,8 +5120,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->extended_info.rel_date = 0;
 		memcpy(info->extended_info.version_string, "1.1.0", strlen("1.1.0"));
 		rsp->OutputBufferLength = cpu_to_le32(64);
-		inc_rfc1001_len(rsp_org, 64);
-		fs_infoclass_size = FS_OBJECT_ID_INFORMATION_SIZE;
 		break;
 	}
 	case FS_SECTOR_SIZE_INFORMATION:
@@ -5089,8 +5141,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->ByteOffsetForSectorAlignment = 0;
 		info->ByteOffsetForPartitionAlignment = 0;
 		rsp->OutputBufferLength = cpu_to_le32(28);
-		inc_rfc1001_len(rsp_org, 28);
-		fs_infoclass_size = FS_SECTOR_SIZE_INFORMATION_SIZE;
 		break;
 	}
 	case FS_CONTROL_INFORMATION:
@@ -5111,8 +5161,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->DefaultQuotaLimit = cpu_to_le64(SMB2_NO_FID);
 		info->Padding = 0;
 		rsp->OutputBufferLength = cpu_to_le32(48);
-		inc_rfc1001_len(rsp_org, 48);
-		fs_infoclass_size = FS_CONTROL_INFORMATION_SIZE;
 		break;
 	}
 	case FS_POSIX_INFORMATION:
@@ -5132,8 +5180,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 			info->TotalFileNodes = cpu_to_le64(stfs.f_files);
 			info->FreeFileNodes = cpu_to_le64(stfs.f_ffree);
 			rsp->OutputBufferLength = cpu_to_le32(56);
-			inc_rfc1001_len(rsp_org, 56);
-			fs_infoclass_size = FS_POSIX_INFORMATION_SIZE;
 		}
 		break;
 	}
@@ -5142,15 +5188,14 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		return -EOPNOTSUPP;
 	}
 	rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-			      rsp,
-			      fs_infoclass_size);
+			      rsp, work->response_buf);
 	path_put(&path);
 	return rc;
 }
 
 static int smb2_get_info_sec(struct ksmbd_work *work,
 			     struct smb2_query_info_req *req,
-			     struct smb2_query_info_rsp *rsp, void *rsp_org)
+			     struct smb2_query_info_rsp *rsp)
 {
 	struct ksmbd_file *fp;
 	struct user_namespace *user_ns;
@@ -5177,13 +5222,12 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 
 		secdesclen = sizeof(struct smb_ntsd);
 		rsp->OutputBufferLength = cpu_to_le32(secdesclen);
-		inc_rfc1001_len(rsp_org, secdesclen);
 
 		return 0;
 	}
 
 	if (work->next_smb2_rcv_hdr_off) {
-		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+		if (!has_file_id(req->VolatileFileId)) {
 			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
 				    work->compound_fid);
 			id = work->compound_fid;
@@ -5192,8 +5236,8 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 	}
 
 	if (!has_file_id(id)) {
-		id = le64_to_cpu(req->VolatileFileId);
-		pid = le64_to_cpu(req->PersistentFileId);
+		id = req->VolatileFileId;
+		pid = req->PersistentFileId;
 	}
 
 	fp = ksmbd_lookup_fd_slow(work, id, pid);
@@ -5222,7 +5266,6 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 		return rc;
 
 	rsp->OutputBufferLength = cpu_to_le32(secdesclen);
-	inc_rfc1001_len(rsp_org, secdesclen);
 	return 0;
 }
 
@@ -5235,10 +5278,9 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 int smb2_query_info(struct ksmbd_work *work)
 {
 	struct smb2_query_info_req *req;
-	struct smb2_query_info_rsp *rsp, *rsp_org;
+	struct smb2_query_info_rsp *rsp;
 	int rc = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	ksmbd_debug(SMB, "GOT query info request\n");
@@ -5246,15 +5288,15 @@ int smb2_query_info(struct ksmbd_work *work)
 	switch (req->InfoType) {
 	case SMB2_O_INFO_FILE:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
-		rc = smb2_get_info_file(work, req, rsp, (void *)rsp_org);
+		rc = smb2_get_info_file(work, req, rsp);
 		break;
 	case SMB2_O_INFO_FILESYSTEM:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILESYSTEM\n");
-		rc = smb2_get_info_filesystem(work, req, rsp, (void *)rsp_org);
+		rc = smb2_get_info_filesystem(work, req, rsp);
 		break;
 	case SMB2_O_INFO_SECURITY:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_SECURITY\n");
-		rc = smb2_get_info_sec(work, req, rsp, (void *)rsp_org);
+		rc = smb2_get_info_sec(work, req, rsp);
 		break;
 	default:
 		ksmbd_debug(SMB, "InfoType %d not supported yet\n",
@@ -5262,6 +5304,14 @@ int smb2_query_info(struct ksmbd_work *work)
 		rc = -EOPNOTSUPP;
 	}
 
+	if (!rc) {
+		rsp->StructureSize = cpu_to_le16(9);
+		rsp->OutputBufferOffset = cpu_to_le16(72);
+		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
+				       offsetof(struct smb2_query_info_rsp, Buffer) +
+					le32_to_cpu(rsp->OutputBufferLength));
+	}
+
 	if (rc < 0) {
 		if (rc == -EACCES)
 			rsp->hdr.Status = STATUS_ACCESS_DENIED;
@@ -5269,6 +5319,8 @@ int smb2_query_info(struct ksmbd_work *work)
 			rsp->hdr.Status = STATUS_FILE_CLOSED;
 		else if (rc == -EIO)
 			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+		else if (rc == -ENOMEM)
+			rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
 		else if (rc == -EOPNOTSUPP || rsp->hdr.Status == 0)
 			rsp->hdr.Status = STATUS_INVALID_INFO_CLASS;
 		smb2_set_err_rsp(work);
@@ -5277,9 +5329,6 @@ int smb2_query_info(struct ksmbd_work *work)
 			    rc);
 		return rc;
 	}
-	rsp->StructureSize = cpu_to_le16(9);
-	rsp->OutputBufferOffset = cpu_to_le16(72);
-	inc_rfc1001_len(rsp_org, 8);
 	return 0;
 }
 
@@ -5292,10 +5341,12 @@ int smb2_query_info(struct ksmbd_work *work)
 static noinline int smb2_close_pipe(struct ksmbd_work *work)
 {
 	u64 id;
-	struct smb2_close_req *req = work->request_buf;
-	struct smb2_close_rsp *rsp = work->response_buf;
+	struct smb2_close_req *req;
+	struct smb2_close_rsp *rsp;
 
-	id = le64_to_cpu(req->VolatileFileId);
+	WORK_BUFFERS(work, req, rsp);
+
+	id = req->VolatileFileId;
 	ksmbd_session_rpc_close(work->sess, id);
 
 	rsp->StructureSize = cpu_to_le16(60);
@@ -5308,8 +5359,9 @@ static noinline int smb2_close_pipe(struct ksmbd_work *work)
 	rsp->AllocationSize = 0;
 	rsp->EndOfFile = 0;
 	rsp->Attributes = 0;
-	inc_rfc1001_len(rsp, 60);
-	return 0;
+
+	return ksmbd_iov_pin_rsp(work, (void *)rsp,
+				 sizeof(struct smb2_close_rsp));
 }
 
 /**
@@ -5324,14 +5376,12 @@ int smb2_close(struct ksmbd_work *work)
 	u64 sess_id;
 	struct smb2_close_req *req;
 	struct smb2_close_rsp *rsp;
-	struct smb2_close_rsp *rsp_org;
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_file *fp;
 	struct inode *inode;
 	u64 time;
 	int err = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (test_share_config_flag(work->tcon->share_conf,
@@ -5356,7 +5406,7 @@ int smb2_close(struct ksmbd_work *work)
 	}
 
 	if (work->next_smb2_rcv_hdr_off &&
-	    !has_file_id(le64_to_cpu(req->VolatileFileId))) {
+	    !has_file_id(req->VolatileFileId)) {
 		if (!has_file_id(work->compound_fid)) {
 			/* file already closed, return FILE_CLOSED */
 			ksmbd_debug(SMB, "file already closed\n");
@@ -5375,7 +5425,7 @@ int smb2_close(struct ksmbd_work *work)
 			work->compound_pfid = KSMBD_NO_FID;
 		}
 	} else {
-		volatile_id = le64_to_cpu(req->VolatileFileId);
+		volatile_id = req->VolatileFileId;
 	}
 	ksmbd_debug(SMB, "volatile_id = %llu\n", volatile_id);
 
@@ -5416,15 +5466,17 @@ int smb2_close(struct ksmbd_work *work)
 
 	err = ksmbd_close_fd(work, volatile_id);
 out:
+	if (!err)
+		err = ksmbd_iov_pin_rsp(work, (void *)rsp,
+					sizeof(struct smb2_close_rsp));
+
 	if (err) {
 		if (rsp->hdr.Status == 0)
 			rsp->hdr.Status = STATUS_FILE_CLOSED;
 		smb2_set_err_rsp(work);
-	} else {
-		inc_rfc1001_len(rsp_org, 60);
 	}
 
-	return 0;
+	return err;
 }
 
 /**
@@ -5435,55 +5487,31 @@ int smb2_close(struct ksmbd_work *work)
  */
 int smb2_echo(struct ksmbd_work *work)
 {
-	struct smb2_echo_rsp *rsp = work->response_buf;
+	struct smb2_echo_rsp *rsp = smb2_get_msg(work->response_buf);
+
+	if (work->next_smb2_rcv_hdr_off)
+		rsp = ksmbd_resp_buf_next(work);
 
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
-	inc_rfc1001_len(rsp, 4);
-	return 0;
+	return ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_echo_rsp));
 }
 
 static int smb2_rename(struct ksmbd_work *work,
 		       struct ksmbd_file *fp,
-		       struct user_namespace *user_ns,
 		       struct smb2_file_rename_info *file_info,
 		       struct nls_table *local_nls)
 {
 	struct ksmbd_share_config *share = fp->tcon->share_conf;
-	char *new_name = NULL, *abs_oldname = NULL, *old_name = NULL;
-	char *pathname = NULL;
-	struct path path;
-	bool file_present = true;
-	int rc;
+	char *new_name = NULL;
+	int rc, flags = 0;
 
 	ksmbd_debug(SMB, "setting FILE_RENAME_INFO\n");
-	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!pathname)
-		return -ENOMEM;
-
-	abs_oldname = d_path(&fp->filp->f_path, pathname, PATH_MAX);
-	if (IS_ERR(abs_oldname)) {
-		rc = -EINVAL;
-		goto out;
-	}
-	old_name = strrchr(abs_oldname, '/');
-	if (old_name && old_name[1] != '\0') {
-		old_name++;
-	} else {
-		ksmbd_debug(SMB, "can't get last component in path %s\n",
-			    abs_oldname);
-		rc = -ENOENT;
-		goto out;
-	}
-
-	new_name = smb2_get_name(share,
-				 file_info->FileName,
+	new_name = smb2_get_name(file_info->FileName,
 				 le32_to_cpu(file_info->FileNameLength),
 				 local_nls);
-	if (IS_ERR(new_name)) {
-		rc = PTR_ERR(new_name);
-		goto out;
-	}
+	if (IS_ERR(new_name))
+		return PTR_ERR(new_name);
 
 	if (strchr(new_name, ':')) {
 		int s_type;
@@ -5509,10 +5537,10 @@ static int smb2_rename(struct ksmbd_work *work,
 		if (rc)
 			goto out;
 
-		rc = ksmbd_vfs_setxattr(user_ns,
-					fp->filp->f_path.dentry,
+		rc = ksmbd_vfs_setxattr(file_mnt_user_ns(fp->filp),
+					&fp->filp->f_path,
 					xattr_stream_name,
-					NULL, 0, 0);
+					NULL, 0, 0, true);
 		if (rc < 0) {
 			pr_err("failed to store stream name in xattr: %d\n",
 			       rc);
@@ -5524,47 +5552,18 @@ static int smb2_rename(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "new name %s\n", new_name);
-	rc = ksmbd_vfs_kern_path(work, new_name, LOOKUP_NO_SYMLINKS, &path, 1);
-	if (rc) {
-		if (rc != -ENOENT)
-			goto out;
-		file_present = false;
-	} else {
-		path_put(&path);
-	}
-
 	if (ksmbd_share_veto_filename(share, new_name)) {
 		rc = -ENOENT;
 		ksmbd_debug(SMB, "Can't rename vetoed file: %s\n", new_name);
 		goto out;
 	}
 
-	if (file_info->ReplaceIfExists) {
-		if (file_present) {
-			rc = ksmbd_vfs_remove_file(work, new_name);
-			if (rc) {
-				if (rc != -ENOTEMPTY)
-					rc = -EINVAL;
-				ksmbd_debug(SMB, "cannot delete %s, rc %d\n",
-					    new_name, rc);
-				goto out;
-			}
-		}
-	} else {
-		if (file_present &&
-		    strncmp(old_name, path.dentry->d_name.name, strlen(old_name))) {
-			rc = -EEXIST;
-			ksmbd_debug(SMB,
-				    "cannot rename already existing file\n");
-			goto out;
-		}
-	}
+	if (!file_info->ReplaceIfExists)
+		flags = RENAME_NOREPLACE;
 
-	rc = ksmbd_vfs_fp_rename(work, fp, new_name);
+	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
-	kfree(pathname);
-	if (!IS_ERR(new_name))
-		kfree(new_name);
+	kfree(new_name);
 	return rc;
 }
 
@@ -5575,8 +5574,8 @@ static int smb2_create_link(struct ksmbd_work *work,
 			    struct nls_table *local_nls)
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
-	struct path path;
-	bool file_present = true;
+	struct path path, parent_path;
+	bool file_present = false;
 	int rc;
 
 	if (buf_len < (u64)sizeof(struct smb2_file_link_info) +
@@ -5588,8 +5587,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (!pathname)
 		return -ENOMEM;
 
-	link_name = smb2_get_name(share,
-				  file_info->FileName,
+	link_name = smb2_get_name(file_info->FileName,
 				  le32_to_cpu(file_info->FileNameLength),
 				  local_nls);
 	if (IS_ERR(link_name) || S_ISDIR(file_inode(filp)->i_mode)) {
@@ -5598,25 +5596,24 @@ static int smb2_create_link(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "link name is %s\n", link_name);
-	target_name = d_path(&filp->f_path, pathname, PATH_MAX);
+	target_name = file_path(filp, pathname, PATH_MAX);
 	if (IS_ERR(target_name)) {
 		rc = -EINVAL;
 		goto out;
 	}
 
 	ksmbd_debug(SMB, "target name is %s\n", target_name);
-	rc = ksmbd_vfs_kern_path(work, link_name, LOOKUP_NO_SYMLINKS, &path, 0);
+	rc = ksmbd_vfs_kern_path_locked(work, link_name, LOOKUP_NO_SYMLINKS,
+					&parent_path, &path, 0);
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
-		file_present = false;
-	} else {
-		path_put(&path);
-	}
+	} else
+		file_present = true;
 
 	if (file_info->ReplaceIfExists) {
 		if (file_present) {
-			rc = ksmbd_vfs_remove_file(work, link_name);
+			rc = ksmbd_vfs_remove_file(work, &path);
 			if (rc) {
 				rc = -EINVAL;
 				ksmbd_debug(SMB, "cannot delete %s\n",
@@ -5636,6 +5633,9 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (rc)
 		rc = -EINVAL;
 out:
+	if (file_present)
+		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+
 	if (!IS_ERR(link_name))
 		kfree(link_name);
 	kfree(pathname);
@@ -5702,8 +5702,8 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 			XATTR_DOSINFO_ITIME;
 
-		rc = ksmbd_vfs_set_dos_attrib_xattr(user_ns,
-						    filp->f_path.dentry, &da);
+		rc = ksmbd_vfs_set_dos_attrib_xattr(user_ns, &filp->f_path, &da,
+				true);
 		if (rc)
 			ksmbd_debug(SMB,
 				    "failed to restore file attribute in EA\n");
@@ -5767,8 +5767,7 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 		size = i_size_read(inode);
 		rc = ksmbd_vfs_truncate(work, fp, alloc_blks * 512);
 		if (rc) {
-			pr_err("truncate failed! filename : %s, err %d\n",
-			       fp->filename, rc);
+			pr_err("truncate failed!, err %d\n", rc);
 			return rc;
 		}
 		if (size < alloc_blks * 512)
@@ -5798,12 +5797,10 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	 * truncated range.
 	 */
 	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC) {
-		ksmbd_debug(SMB, "filename : %s truncated to newsize %lld\n",
-			    fp->filename, newsize);
+		ksmbd_debug(SMB, "truncated to newsize %lld\n", newsize);
 		rc = ksmbd_vfs_truncate(work, fp, newsize);
 		if (rc) {
-			ksmbd_debug(SMB, "truncate failed! filename : %s err %d\n",
-				    fp->filename, rc);
+			ksmbd_debug(SMB, "truncate failed!, err %d\n", rc);
 			if (rc != -EAGAIN)
 				rc = -EBADF;
 			return rc;
@@ -5816,12 +5813,6 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 			   struct smb2_file_rename_info *rename_info,
 			   unsigned int buf_len)
 {
-	struct user_namespace *user_ns;
-	struct ksmbd_file *parent_fp;
-	struct dentry *parent;
-	struct dentry *dentry = fp->filp->f_path.dentry;
-	int ret;
-
 	if (!(fp->daccess & FILE_DELETE_LE)) {
 		pr_err("no right to delete : 0x%x\n", fp->daccess);
 		return -EACCES;
@@ -5831,32 +5822,10 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 			le32_to_cpu(rename_info->FileNameLength))
 		return -EINVAL;
 
-	user_ns = file_mnt_user_ns(fp->filp);
-	if (ksmbd_stream_fd(fp))
-		goto next;
-
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
-	}
-
-	parent_fp = ksmbd_lookup_fd_inode(d_inode(parent));
-	inode_unlock(d_inode(parent));
-	dput(parent);
+	if (!le32_to_cpu(rename_info->FileNameLength))
+		return -EINVAL;
 
-	if (parent_fp) {
-		if (parent_fp->daccess & FILE_DELETE_LE) {
-			pr_err("parent dir is opened with delete access\n");
-			ksmbd_fd_put(work, parent_fp);
-			return -ESHARE;
-		}
-		ksmbd_fd_put(work, parent_fp);
-	}
-next:
-	return smb2_rename(work, fp, user_ns, rename_info,
-			   work->conn->local_nls);
+	return smb2_rename(work, fp, rename_info, work->conn->local_nls);
 }
 
 static int set_file_disposition_info(struct ksmbd_file *fp,
@@ -5931,7 +5900,7 @@ static int set_file_mode_info(struct ksmbd_file *fp,
  * smb2_set_info_file() - handler for smb2 set info command
  * @work:	smb work containing set info command buffer
  * @fp:		ksmbd_file pointer
- * @info_class:	smb2 set info class
+ * @req:	request buffer pointer
  * @share:	ksmbd_share_config pointer
  *
  * Return:	0 on success, otherwise error
@@ -6048,7 +6017,7 @@ static int smb2_set_info_sec(struct ksmbd_file *fp, int addition_info,
 	fp->saccess |= FILE_SHARE_DELETE_LE;
 
 	return set_info_sec(fp->conn, fp->tcon, &fp->filp->f_path, pntsd,
-			buf_len, false);
+			buf_len, false, true);
 }
 
 /**
@@ -6060,31 +6029,30 @@ static int smb2_set_info_sec(struct ksmbd_file *fp, int addition_info,
 int smb2_set_info(struct ksmbd_work *work)
 {
 	struct smb2_set_info_req *req;
-	struct smb2_set_info_rsp *rsp, *rsp_org;
+	struct smb2_set_info_rsp *rsp;
 	struct ksmbd_file *fp;
 	int rc = 0;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 
 	ksmbd_debug(SMB, "Received set info request\n");
 
-	rsp_org = work->response_buf;
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
 		rsp = ksmbd_resp_buf_next(work);
-		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+		if (!has_file_id(req->VolatileFileId)) {
 			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
 				    work->compound_fid);
 			id = work->compound_fid;
 			pid = work->compound_pfid;
 		}
 	} else {
-		req = work->request_buf;
-		rsp = work->response_buf;
+		req = smb2_get_msg(work->request_buf);
+		rsp = smb2_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id)) {
-		id = le64_to_cpu(req->VolatileFileId);
-		pid = le64_to_cpu(req->PersistentFileId);
+		id = req->VolatileFileId;
+		pid = req->PersistentFileId;
 	}
 
 	fp = ksmbd_lookup_fd_slow(work, id, pid);
@@ -6119,7 +6087,10 @@ int smb2_set_info(struct ksmbd_work *work)
 		goto err_out;
 
 	rsp->StructureSize = cpu_to_le16(2);
-	inc_rfc1001_len(rsp_org, 2);
+	rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
+			       sizeof(struct smb2_set_info_rsp));
+	if (rc)
+		goto err_out;
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6159,33 +6130,43 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 	int nbytes = 0, err;
 	u64 id;
 	struct ksmbd_rpc_command *rpc_resp;
-	struct smb2_read_req *req = work->request_buf;
-	struct smb2_read_rsp *rsp = work->response_buf;
+	struct smb2_read_req *req;
+	struct smb2_read_rsp *rsp;
+
+	WORK_BUFFERS(work, req, rsp);
 
-	id = le64_to_cpu(req->VolatileFileId);
+	id = req->VolatileFileId;
 
-	inc_rfc1001_len(rsp, 16);
 	rpc_resp = ksmbd_rpc_read(work->sess, id);
 	if (rpc_resp) {
+		void *aux_payload_buf;
+
 		if (rpc_resp->flags != KSMBD_RPC_OK) {
 			err = -EINVAL;
 			goto out;
 		}
 
-		work->aux_payload_buf =
-			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL | __GFP_ZERO);
-		if (!work->aux_payload_buf) {
+		aux_payload_buf =
+			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL);
+		if (!aux_payload_buf) {
 			err = -ENOMEM;
 			goto out;
 		}
 
-		memcpy(work->aux_payload_buf, rpc_resp->payload,
-		       rpc_resp->payload_sz);
+		memcpy(aux_payload_buf, rpc_resp->payload, rpc_resp->payload_sz);
 
 		nbytes = rpc_resp->payload_sz;
-		work->resp_hdr_sz = get_rfc1002_len(rsp) + 4;
-		work->aux_payload_sz = nbytes;
+		err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
+					     offsetof(struct smb2_read_rsp, Buffer),
+					     aux_payload_buf, nbytes);
+		if (err)
+			goto out;
 		kvfree(rpc_resp);
+	} else {
+		err = ksmbd_iov_pin_rsp(work, (void *)rsp,
+					offsetof(struct smb2_read_rsp, Buffer));
+		if (err)
+			goto out;
 	}
 
 	rsp->StructureSize = cpu_to_le16(17);
@@ -6194,7 +6175,6 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = 0;
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp, nbytes);
 	return 0;
 
 out:
@@ -6204,30 +6184,46 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 	return err;
 }
 
-static ssize_t smb2_read_rdma_channel(struct ksmbd_work *work,
-				      struct smb2_read_req *req, void *data_buf,
-				      size_t length)
+static int smb2_set_remote_key_for_rdma(struct ksmbd_work *work,
+					struct smb2_buffer_desc_v1 *desc,
+					__le32 Channel,
+					__le16 ChannelInfoLength)
 {
-	struct smb2_buffer_desc_v1 *desc =
-		(struct smb2_buffer_desc_v1 *)&req->Buffer[0];
-	int err;
+	unsigned int i, ch_count;
 
 	if (work->conn->dialect == SMB30_PROT_ID &&
-	    req->Channel != SMB2_CHANNEL_RDMA_V1)
+	    Channel != SMB2_CHANNEL_RDMA_V1)
 		return -EINVAL;
 
-	if (req->ReadChannelInfoOffset == 0 ||
-	    le16_to_cpu(req->ReadChannelInfoLength) < sizeof(*desc))
+	ch_count = le16_to_cpu(ChannelInfoLength) / sizeof(*desc);
+	if (ksmbd_debug_types & KSMBD_DEBUG_RDMA) {
+		for (i = 0; i < ch_count; i++) {
+			pr_info("RDMA r/w request %#x: token %#x, length %#x\n",
+				i,
+				le32_to_cpu(desc[i].token),
+				le32_to_cpu(desc[i].length));
+		}
+	}
+	if (!ch_count)
 		return -EINVAL;
 
 	work->need_invalidate_rkey =
-		(req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
-	work->remote_key = le32_to_cpu(desc->token);
+		(Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
+	if (Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE)
+		work->remote_key = le32_to_cpu(desc->token);
+	return 0;
+}
+
+static ssize_t smb2_read_rdma_channel(struct ksmbd_work *work,
+				      struct smb2_read_req *req, void *data_buf,
+				      size_t length)
+{
+	int err;
 
 	err = ksmbd_conn_rdma_write(work->conn, data_buf, length,
-				    le32_to_cpu(desc->token),
-				    le64_to_cpu(desc->offset),
-				    le32_to_cpu(desc->length));
+				    (struct smb2_buffer_desc_v1 *)
+				    ((char *)req + le16_to_cpu(req->ReadChannelInfoOffset)),
+				    le16_to_cpu(req->ReadChannelInfoLength));
 	if (err)
 		return err;
 
@@ -6244,20 +6240,16 @@ int smb2_read(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_read_req *req;
-	struct smb2_read_rsp *rsp, *rsp_org;
+	struct smb2_read_rsp *rsp;
 	struct ksmbd_file *fp = NULL;
 	loff_t offset;
 	size_t length, mincount;
 	ssize_t nbytes = 0, remain_bytes = 0;
 	int err = 0;
-
-	rsp_org = work->response_buf;
-	WORK_BUFFERS(work, req, rsp);
-	if (work->next_smb2_rcv_hdr_off) {
-		work->send_no_response = 1;
-		err = -EOPNOTSUPP;
-		goto out;
-	}
+	bool is_rdma_channel = false;
+	unsigned int max_read_size = conn->vals->max_read_size;
+	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
+	void *aux_payload_buf;
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_PIPE)) {
@@ -6265,8 +6257,48 @@ int smb2_read(struct ksmbd_work *work)
 		return smb2_read_pipe(work);
 	}
 
-	fp = ksmbd_lookup_fd_slow(work, le64_to_cpu(req->VolatileFileId),
-				  le64_to_cpu(req->PersistentFileId));
+	if (work->next_smb2_rcv_hdr_off) {
+		req = ksmbd_req_buf_next(work);
+		rsp = ksmbd_resp_buf_next(work);
+		if (!has_file_id(req->VolatileFileId)) {
+			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
+					work->compound_fid);
+			id = work->compound_fid;
+			pid = work->compound_pfid;
+		}
+	} else {
+		req = smb2_get_msg(work->request_buf);
+		rsp = smb2_get_msg(work->response_buf);
+	}
+
+	if (!has_file_id(id)) {
+		id = req->VolatileFileId;
+		pid = req->PersistentFileId;
+	}
+
+	if (req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE ||
+	    req->Channel == SMB2_CHANNEL_RDMA_V1) {
+		is_rdma_channel = true;
+		max_read_size = get_smbd_max_read_write_size();
+	}
+
+	if (is_rdma_channel == true) {
+		unsigned int ch_offset = le16_to_cpu(req->ReadChannelInfoOffset);
+
+		if (ch_offset < offsetof(struct smb2_read_req, Buffer)) {
+			err = -EINVAL;
+			goto out;
+		}
+		err = smb2_set_remote_key_for_rdma(work,
+						   (struct smb2_buffer_desc_v1 *)
+						   ((char *)req + ch_offset),
+						   req->Channel,
+						   req->ReadChannelInfoLength);
+		if (err)
+			goto out;
+	}
+
+	fp = ksmbd_lookup_fd_slow(work, id, pid);
 	if (!fp) {
 		err = -ENOENT;
 		goto out;
@@ -6282,31 +6314,30 @@ int smb2_read(struct ksmbd_work *work)
 	length = le32_to_cpu(req->Length);
 	mincount = le32_to_cpu(req->MinimumCount);
 
-	if (length > conn->vals->max_read_size) {
+	if (length > max_read_size) {
 		ksmbd_debug(SMB, "limiting read size to max size(%u)\n",
-			    conn->vals->max_read_size);
+			    max_read_size);
 		err = -EINVAL;
 		goto out;
 	}
 
-	ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
-		    fp->filp->f_path.dentry, offset, length);
+	ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
+		    fp->filp, offset, length);
 
-	work->aux_payload_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
-	if (!work->aux_payload_buf) {
+	aux_payload_buf = kvzalloc(length, GFP_KERNEL);
+	if (!aux_payload_buf) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	nbytes = ksmbd_vfs_read(work, fp, length, &offset);
+	nbytes = ksmbd_vfs_read(work, fp, length, &offset, aux_payload_buf);
 	if (nbytes < 0) {
 		err = nbytes;
 		goto out;
 	}
 
 	if ((nbytes == 0 && length != 0) || nbytes < mincount) {
-		kvfree(work->aux_payload_buf);
-		work->aux_payload_buf = NULL;
+		kvfree(aux_payload_buf);
 		rsp->hdr.Status = STATUS_END_OF_FILE;
 		smb2_set_err_rsp(work);
 		ksmbd_fd_put(work, fp);
@@ -6316,15 +6347,13 @@ int smb2_read(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "nbytes %zu, offset %lld mincount %zu\n",
 		    nbytes, offset, mincount);
 
-	if (req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE ||
-	    req->Channel == SMB2_CHANNEL_RDMA_V1) {
+	if (is_rdma_channel == true) {
 		/* write data to the client using rdma channel */
 		remain_bytes = smb2_read_rdma_channel(work, req,
-						      work->aux_payload_buf,
+						      aux_payload_buf,
 						      nbytes);
-		kvfree(work->aux_payload_buf);
-		work->aux_payload_buf = NULL;
-
+		kvfree(aux_payload_buf);
+		aux_payload_buf = NULL;
 		nbytes = 0;
 		if (remain_bytes < 0) {
 			err = (int)remain_bytes;
@@ -6338,10 +6367,11 @@ int smb2_read(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = cpu_to_le32(remain_bytes);
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp_org, 16);
-	work->resp_hdr_sz = get_rfc1002_len(rsp_org) + 4;
-	work->aux_payload_sz = nbytes;
-	inc_rfc1001_len(rsp_org, nbytes);
+	err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
+				     offsetof(struct smb2_read_rsp, Buffer),
+				     aux_payload_buf, nbytes);
+	if (err)
+		goto out;
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6376,33 +6406,31 @@ int smb2_read(struct ksmbd_work *work)
  */
 static noinline int smb2_write_pipe(struct ksmbd_work *work)
 {
-	struct smb2_write_req *req = work->request_buf;
-	struct smb2_write_rsp *rsp = work->response_buf;
+	struct smb2_write_req *req;
+	struct smb2_write_rsp *rsp;
 	struct ksmbd_rpc_command *rpc_resp;
 	u64 id = 0;
 	int err = 0, ret = 0;
 	char *data_buf;
 	size_t length;
 
-	length = le32_to_cpu(req->Length);
-	id = le64_to_cpu(req->VolatileFileId);
+	WORK_BUFFERS(work, req, rsp);
 
-	if (le16_to_cpu(req->DataOffset) ==
-	    (offsetof(struct smb2_write_req, Buffer) - 4)) {
-		data_buf = (char *)&req->Buffer[0];
-	} else {
-		if ((u64)le16_to_cpu(req->DataOffset) + length > get_rfc1002_len(req)) {
-			pr_err("invalid write data offset %u, smb_len %u\n",
-			       le16_to_cpu(req->DataOffset),
-			       get_rfc1002_len(req));
-			err = -EINVAL;
-			goto out;
-		}
+	length = le32_to_cpu(req->Length);
+	id = req->VolatileFileId;
 
-		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
-				le16_to_cpu(req->DataOffset));
+	if ((u64)le16_to_cpu(req->DataOffset) + length >
+	    get_rfc1002_len(work->request_buf)) {
+		pr_err("invalid write data offset %u, smb_len %u\n",
+		       le16_to_cpu(req->DataOffset),
+		       get_rfc1002_len(work->request_buf));
+		err = -EINVAL;
+		goto out;
 	}
 
+	data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
+			   le16_to_cpu(req->DataOffset));
+
 	rpc_resp = ksmbd_rpc_write(work->sess, id, data_buf, length);
 	if (rpc_resp) {
 		if (rpc_resp->flags == KSMBD_RPC_ENOTIMPLEMENTED) {
@@ -6426,8 +6454,8 @@ static noinline int smb2_write_pipe(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(length);
 	rsp->DataRemaining = 0;
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp, 16);
-	return 0;
+	err = ksmbd_iov_pin_rsp(work, (void *)rsp,
+				offsetof(struct smb2_write_rsp, Buffer));
 out:
 	if (err) {
 		rsp->hdr.Status = STATUS_INVALID_HANDLE;
@@ -6442,36 +6470,18 @@ static ssize_t smb2_write_rdma_channel(struct ksmbd_work *work,
 				       struct ksmbd_file *fp,
 				       loff_t offset, size_t length, bool sync)
 {
-	struct smb2_buffer_desc_v1 *desc;
 	char *data_buf;
 	int ret;
 	ssize_t nbytes;
 
-	desc = (struct smb2_buffer_desc_v1 *)&req->Buffer[0];
-
-	if (work->conn->dialect == SMB30_PROT_ID &&
-	    req->Channel != SMB2_CHANNEL_RDMA_V1)
-		return -EINVAL;
-
-	if (req->Length != 0 || req->DataOffset != 0)
-		return -EINVAL;
-
-	if (req->WriteChannelInfoOffset == 0 ||
-	    le16_to_cpu(req->WriteChannelInfoLength) < sizeof(*desc))
-		return -EINVAL;
-
-	work->need_invalidate_rkey =
-		(req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
-	work->remote_key = le32_to_cpu(desc->token);
-
-	data_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
+	data_buf = kvzalloc(length, GFP_KERNEL);
 	if (!data_buf)
 		return -ENOMEM;
 
 	ret = ksmbd_conn_rdma_read(work->conn, data_buf, length,
-				   le32_to_cpu(desc->token),
-				   le64_to_cpu(desc->offset),
-				   le32_to_cpu(desc->length));
+				   (struct smb2_buffer_desc_v1 *)
+				   ((char *)req + le16_to_cpu(req->WriteChannelInfoOffset)),
+				   le16_to_cpu(req->WriteChannelInfoLength));
 	if (ret < 0) {
 		kvfree(data_buf);
 		return ret;
@@ -6494,16 +6504,16 @@ static ssize_t smb2_write_rdma_channel(struct ksmbd_work *work,
 int smb2_write(struct ksmbd_work *work)
 {
 	struct smb2_write_req *req;
-	struct smb2_write_rsp *rsp, *rsp_org;
+	struct smb2_write_rsp *rsp;
 	struct ksmbd_file *fp = NULL;
 	loff_t offset;
 	size_t length;
 	ssize_t nbytes;
 	char *data_buf;
-	bool writethrough = false;
+	bool writethrough = false, is_rdma_channel = false;
 	int err = 0;
+	unsigned int max_write_size = work->conn->vals->max_write_size;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_PIPE)) {
@@ -6511,14 +6521,40 @@ int smb2_write(struct ksmbd_work *work)
 		return smb2_write_pipe(work);
 	}
 
+	offset = le64_to_cpu(req->Offset);
+	length = le32_to_cpu(req->Length);
+
+	if (req->Channel == SMB2_CHANNEL_RDMA_V1 ||
+	    req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE) {
+		is_rdma_channel = true;
+		max_write_size = get_smbd_max_read_write_size();
+		length = le32_to_cpu(req->RemainingBytes);
+	}
+
+	if (is_rdma_channel == true) {
+		unsigned int ch_offset = le16_to_cpu(req->WriteChannelInfoOffset);
+
+		if (req->Length != 0 || req->DataOffset != 0 ||
+		    ch_offset < offsetof(struct smb2_write_req, Buffer)) {
+			err = -EINVAL;
+			goto out;
+		}
+		err = smb2_set_remote_key_for_rdma(work,
+						   (struct smb2_buffer_desc_v1 *)
+						   ((char *)req + ch_offset),
+						   req->Channel,
+						   req->WriteChannelInfoLength);
+		if (err)
+			goto out;
+	}
+
 	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
 		ksmbd_debug(SMB, "User does not have write permission\n");
 		err = -EACCES;
 		goto out;
 	}
 
-	fp = ksmbd_lookup_fd_slow(work, le64_to_cpu(req->VolatileFileId),
-				  le64_to_cpu(req->PersistentFileId));
+	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!fp) {
 		err = -ENOENT;
 		goto out;
@@ -6530,41 +6566,29 @@ int smb2_write(struct ksmbd_work *work)
 		goto out;
 	}
 
-	offset = le64_to_cpu(req->Offset);
-	length = le32_to_cpu(req->Length);
-
-	if (length > work->conn->vals->max_write_size) {
+	if (length > max_write_size) {
 		ksmbd_debug(SMB, "limiting write size to max size(%u)\n",
-			    work->conn->vals->max_write_size);
+			    max_write_size);
 		err = -EINVAL;
 		goto out;
 	}
 
+	ksmbd_debug(SMB, "flags %u\n", le32_to_cpu(req->Flags));
 	if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
 		writethrough = true;
 
-	if (req->Channel != SMB2_CHANNEL_RDMA_V1 &&
-	    req->Channel != SMB2_CHANNEL_RDMA_V1_INVALIDATE) {
-		if (le16_to_cpu(req->DataOffset) ==
-		    (offsetof(struct smb2_write_req, Buffer) - 4)) {
-			data_buf = (char *)&req->Buffer[0];
-		} else {
-			if (le16_to_cpu(req->DataOffset) <
-			    offsetof(struct smb2_write_req, Buffer)) {
-				err = -EINVAL;
-				goto out;
-			}
-
-			data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
-					le16_to_cpu(req->DataOffset));
+	if (is_rdma_channel == false) {
+		if (le16_to_cpu(req->DataOffset) <
+		    offsetof(struct smb2_write_req, Buffer)) {
+			err = -EINVAL;
+			goto out;
 		}
 
-		ksmbd_debug(SMB, "flags %u\n", le32_to_cpu(req->Flags));
-		if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
-			writethrough = true;
+		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
+				    le16_to_cpu(req->DataOffset));
 
-		ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
-			    fp->filp->f_path.dentry, offset, length);
+		ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
+			    fp->filp, offset, length);
 		err = ksmbd_vfs_write(work, fp, data_buf, length, &offset,
 				      writethrough, &nbytes);
 		if (err < 0)
@@ -6573,8 +6597,7 @@ int smb2_write(struct ksmbd_work *work)
 		/* read data from the client using rdma channel, and
 		 * write the data.
 		 */
-		nbytes = smb2_write_rdma_channel(work, req, fp, offset,
-						 le32_to_cpu(req->RemainingBytes),
+		nbytes = smb2_write_rdma_channel(work, req, fp, offset, length,
 						 writethrough);
 		if (nbytes < 0) {
 			err = (int)nbytes;
@@ -6588,7 +6611,9 @@ int smb2_write(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = 0;
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp_org, 16);
+	err = ksmbd_iov_pin_rsp(work, rsp, offsetof(struct smb2_write_rsp, Buffer));
+	if (err)
+		goto out;
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6622,32 +6647,24 @@ int smb2_write(struct ksmbd_work *work)
 int smb2_flush(struct ksmbd_work *work)
 {
 	struct smb2_flush_req *req;
-	struct smb2_flush_rsp *rsp, *rsp_org;
+	struct smb2_flush_rsp *rsp;
 	int err;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
-	ksmbd_debug(SMB, "SMB2_FLUSH called for fid %llu\n",
-		    le64_to_cpu(req->VolatileFileId));
+	ksmbd_debug(SMB, "SMB2_FLUSH called for fid %llu\n", req->VolatileFileId);
 
-	err = ksmbd_vfs_fsync(work,
-			      le64_to_cpu(req->VolatileFileId),
-			      le64_to_cpu(req->PersistentFileId));
+	err = ksmbd_vfs_fsync(work, req->VolatileFileId, req->PersistentFileId);
 	if (err)
 		goto out;
 
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
-	inc_rfc1001_len(rsp_org, 4);
-	return 0;
+	return ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_flush_rsp));
 
 out:
-	if (err) {
-		rsp->hdr.Status = STATUS_INVALID_HANDLE;
-		smb2_set_err_rsp(work);
-	}
-
+	rsp->hdr.Status = STATUS_INVALID_HANDLE;
+	smb2_set_err_rsp(work);
 	return err;
 }
 
@@ -6660,12 +6677,14 @@ int smb2_flush(struct ksmbd_work *work)
 int smb2_cancel(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	struct smb2_hdr *chdr;
-	struct ksmbd_work *cancel_work = NULL;
-	int canceled = 0;
+	struct ksmbd_work *iter;
 	struct list_head *command_list;
 
+	if (work->next_smb2_rcv_hdr_off)
+		hdr = ksmbd_resp_buf_next(work);
+
 	ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%x\n",
 		    hdr->MessageId, hdr->Flags);
 
@@ -6673,11 +6692,11 @@ int smb2_cancel(struct ksmbd_work *work)
 		command_list = &conn->async_requests;
 
 		spin_lock(&conn->request_lock);
-		list_for_each_entry(cancel_work, command_list,
+		list_for_each_entry(iter, command_list,
 				    async_request_entry) {
-			chdr = cancel_work->request_buf;
+			chdr = smb2_get_msg(iter->request_buf);
 
-			if (cancel_work->async_id !=
+			if (iter->async_id !=
 			    le64_to_cpu(hdr->Id.AsyncId))
 				continue;
 
@@ -6685,7 +6704,9 @@ int smb2_cancel(struct ksmbd_work *work)
 				    "smb2 with AsyncId %llu cancelled command = 0x%x\n",
 				    le64_to_cpu(hdr->Id.AsyncId),
 				    le16_to_cpu(chdr->Command));
-			canceled = 1;
+			iter->state = KSMBD_WORK_CANCELLED;
+			if (iter->cancel_fn)
+				iter->cancel_fn(iter->cancel_argv);
 			break;
 		}
 		spin_unlock(&conn->request_lock);
@@ -6693,29 +6714,23 @@ int smb2_cancel(struct ksmbd_work *work)
 		command_list = &conn->requests;
 
 		spin_lock(&conn->request_lock);
-		list_for_each_entry(cancel_work, command_list, request_entry) {
-			chdr = cancel_work->request_buf;
+		list_for_each_entry(iter, command_list, request_entry) {
+			chdr = smb2_get_msg(iter->request_buf);
 
 			if (chdr->MessageId != hdr->MessageId ||
-			    cancel_work == work)
+			    iter == work)
 				continue;
 
 			ksmbd_debug(SMB,
 				    "smb2 with mid %llu cancelled command = 0x%x\n",
 				    le64_to_cpu(hdr->MessageId),
 				    le16_to_cpu(chdr->Command));
-			canceled = 1;
+			iter->state = KSMBD_WORK_CANCELLED;
 			break;
 		}
 		spin_unlock(&conn->request_lock);
 	}
 
-	if (canceled) {
-		cancel_work->state = KSMBD_WORK_CANCELLED;
-		if (cancel_work->cancel_fn)
-			cancel_work->cancel_fn(cancel_work->cancel_argv);
-	}
-
 	/* For SMB2_CANCEL command itself send no response*/
 	work->send_no_response = 1;
 	return 0;
@@ -6775,7 +6790,7 @@ static int smb2_set_flock_flags(struct file_lock *flock, int flags)
 	case SMB2_LOCKFLAG_UNLOCK:
 		ksmbd_debug(SMB, "received unlock request\n");
 		flock->fl_type = F_UNLCK;
-		cmd = 0;
+		cmd = F_SETLK;
 		break;
 	}
 
@@ -6829,8 +6844,8 @@ static inline bool lock_defer_pending(struct file_lock *fl)
  */
 int smb2_lock(struct ksmbd_work *work)
 {
-	struct smb2_lock_req *req = work->request_buf;
-	struct smb2_lock_rsp *rsp = work->response_buf;
+	struct smb2_lock_req *req;
+	struct smb2_lock_rsp *rsp;
 	struct smb2_lock_element *lock_ele;
 	struct ksmbd_file *fp = NULL;
 	struct file_lock *flock = NULL;
@@ -6847,13 +6862,12 @@ int smb2_lock(struct ksmbd_work *work)
 	LIST_HEAD(rollback_list);
 	int prior_lock = 0;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	ksmbd_debug(SMB, "Received lock request\n");
-	fp = ksmbd_lookup_fd_slow(work,
-				  le64_to_cpu(req->VolatileFileId),
-				  le64_to_cpu(req->PersistentFileId));
+	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!fp) {
-		ksmbd_debug(SMB, "Invalid file id for lock : %llu\n",
-			    le64_to_cpu(req->VolatileFileId));
+		ksmbd_debug(SMB, "Invalid file id for lock : %llu\n", req->VolatileFileId);
 		err = -ENOENT;
 		goto out2;
 	}
@@ -6882,6 +6896,7 @@ int smb2_lock(struct ksmbd_work *work)
 		if (lock_start > U64_MAX - lock_length) {
 			pr_err("Invalid lock range requested\n");
 			rsp->hdr.Status = STATUS_INVALID_LOCK_RANGE;
+			locks_free_lock(flock);
 			goto out;
 		}
 
@@ -6901,6 +6916,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    "the end offset(%llx) is smaller than the start offset(%llx)\n",
 				    flock->fl_end, flock->fl_start);
 			rsp->hdr.Status = STATUS_INVALID_LOCK_RANGE;
+			locks_free_lock(flock);
 			goto out;
 		}
 
@@ -6912,6 +6928,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    flock->fl_type != F_UNLCK) {
 					pr_err("conflict two locks in one request\n");
 					err = -EINVAL;
+					locks_free_lock(flock);
 					goto out;
 				}
 			}
@@ -6920,6 +6937,7 @@ int smb2_lock(struct ksmbd_work *work)
 		smb_lock = smb2_lock_init(flock, cmd, flags, &lock_list);
 		if (!smb_lock) {
 			err = -EINVAL;
+			locks_free_lock(flock);
 			goto out;
 		}
 	}
@@ -6951,7 +6969,7 @@ int smb2_lock(struct ksmbd_work *work)
 
 		nolock = 1;
 		/* check locks in connection list */
-		read_lock(&conn_list_lock);
+		down_read(&conn_list_lock);
 		list_for_each_entry(conn, &conn_list, conns_list) {
 			spin_lock(&conn->llist_lock);
 			list_for_each_entry_safe(cmp_lock, tmp2, &conn->lock_list, clist) {
@@ -6968,7 +6986,7 @@ int smb2_lock(struct ksmbd_work *work)
 						list_del(&cmp_lock->flist);
 						list_del(&cmp_lock->clist);
 						spin_unlock(&conn->llist_lock);
-						read_unlock(&conn_list_lock);
+						up_read(&conn_list_lock);
 
 						locks_free_lock(cmp_lock->fl);
 						kfree(cmp_lock);
@@ -6990,7 +7008,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    cmp_lock->start > smb_lock->start &&
 				    cmp_lock->start < smb_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("previous lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -6999,7 +7017,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    smb_lock->start > cmp_lock->start &&
 				    smb_lock->start < cmp_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("current lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -7010,14 +7028,14 @@ int smb2_lock(struct ksmbd_work *work)
 				      cmp_lock->end >= smb_lock->end)) &&
 				    !cmp_lock->zero_len && !smb_lock->zero_len) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("Not allow lock operation on exclusive lock range\n");
 					goto out;
 				}
 			}
 			spin_unlock(&conn->llist_lock);
 		}
-		read_unlock(&conn_list_lock);
+		up_read(&conn_list_lock);
 out_check_cl:
 		if (smb_lock->fl->fl_type == F_UNLCK && nolock) {
 			pr_err("Try to unlock nolocked range\n");
@@ -7051,10 +7069,6 @@ int smb2_lock(struct ksmbd_work *work)
 
 				ksmbd_debug(SMB,
 					    "would have to wait for getting lock\n");
-				spin_lock(&work->conn->llist_lock);
-				list_add_tail(&smb_lock->clist,
-					      &work->conn->lock_list);
-				spin_unlock(&work->conn->llist_lock);
 				list_add(&smb_lock->llist, &rollback_list);
 
 				argv = kmalloc(sizeof(void *), GFP_KERNEL);
@@ -7080,17 +7094,15 @@ int smb2_lock(struct ksmbd_work *work)
 
 				ksmbd_vfs_posix_lock_wait(flock);
 
+				spin_lock(&fp->f_lock);
+				list_del(&work->fp_entry);
+				spin_unlock(&fp->f_lock);
+
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
-					spin_lock(&work->conn->llist_lock);
-					list_del(&smb_lock->clist);
-					spin_unlock(&work->conn->llist_lock);
 					locks_free_lock(flock);
 
 					if (work->state == KSMBD_WORK_CANCELLED) {
-						spin_lock(&fp->f_lock);
-						list_del(&work->fp_entry);
-						spin_unlock(&fp->f_lock);
 						rsp->hdr.Status =
 							STATUS_CANCELLED;
 						kfree(smb_lock);
@@ -7099,8 +7111,7 @@ int smb2_lock(struct ksmbd_work *work)
 						work->send_no_response = 1;
 						goto out;
 					}
-					init_smb2_rsp_hdr(work);
-					smb2_set_err_rsp(work);
+
 					rsp->hdr.Status =
 						STATUS_RANGE_NOT_LOCKED;
 					kfree(smb_lock);
@@ -7108,22 +7119,16 @@ int smb2_lock(struct ksmbd_work *work)
 				}
 
 				list_del(&smb_lock->llist);
-				spin_lock(&work->conn->llist_lock);
-				list_del(&smb_lock->clist);
-				spin_unlock(&work->conn->llist_lock);
-
-				spin_lock(&fp->f_lock);
-				list_del(&work->fp_entry);
-				spin_unlock(&fp->f_lock);
+				release_async_work(work);
 				goto retry;
 			} else if (!rc) {
+				list_add(&smb_lock->llist, &rollback_list);
 				spin_lock(&work->conn->llist_lock);
 				list_add_tail(&smb_lock->clist,
 					      &work->conn->lock_list);
 				list_add_tail(&smb_lock->flist,
 					      &fp->lock_list);
 				spin_unlock(&work->conn->llist_lock);
-				list_add(&smb_lock->llist, &rollback_list);
 				ksmbd_debug(SMB, "successful in taking lock\n");
 			} else {
 				goto out;
@@ -7138,7 +7143,10 @@ int smb2_lock(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "successful in taking lock\n");
 	rsp->hdr.Status = STATUS_SUCCESS;
 	rsp->Reserved = 0;
-	inc_rfc1001_len(rsp, 4);
+	err = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_lock_rsp));
+	if (err)
+		goto out;
+
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -7157,7 +7165,7 @@ int smb2_lock(struct ksmbd_work *work)
 		rlock->fl_start = smb_lock->start;
 		rlock->fl_end = smb_lock->end;
 
-		rc = vfs_lock_file(filp, 0, rlock, NULL);
+		rc = vfs_lock_file(filp, F_SETLK, rlock, NULL);
 		if (rc)
 			pr_err("rollback unlock fail : %d\n", rc);
 
@@ -7209,8 +7217,8 @@ static int fsctl_copychunk(struct ksmbd_work *work,
 
 	ci_rsp = (struct copychunk_ioctl_rsp *)&rsp->Buffer[0];
 
-	rsp->VolatileFileId = cpu_to_le64(volatile_id);
-	rsp->PersistentFileId = cpu_to_le64(persistent_id);
+	rsp->VolatileFileId = volatile_id;
+	rsp->PersistentFileId = persistent_id;
 	ci_rsp->ChunksWritten =
 		cpu_to_le32(ksmbd_server_side_copy_max_chunk_count());
 	ci_rsp->ChunkBytesWritten =
@@ -7331,15 +7339,10 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 	struct sockaddr_storage_rsp *sockaddr_storage;
 	unsigned int flags;
 	unsigned long long speed;
-	struct sockaddr_in6 *csin6 = (struct sockaddr_in6 *)&conn->peer_addr;
 
 	rtnl_lock();
 	for_each_netdev(&init_net, netdev) {
-		if (out_buf_len <
-		    nbytes + sizeof(struct network_interface_info_ioctl_rsp)) {
-			rtnl_unlock();
-			return -ENOSPC;
-		}
+		bool ipv4_set = false;
 
 		if (netdev->type == ARPHRD_LOOPBACK)
 			continue;
@@ -7347,6 +7350,12 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		flags = dev_get_flags(netdev);
 		if (!(flags & IFF_RUNNING))
 			continue;
+ipv6_retry:
+		if (out_buf_len <
+		    nbytes + sizeof(struct network_interface_info_ioctl_rsp)) {
+			rtnl_unlock();
+			return -ENOSPC;
+		}
 
 		nii_rsp = (struct network_interface_info_ioctl_rsp *)
 				&rsp->Buffer[nbytes];
@@ -7379,8 +7388,7 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 					nii_rsp->SockAddr_Storage;
 		memset(sockaddr_storage, 0, 128);
 
-		if (conn->peer_addr.ss_family == PF_INET ||
-		    ipv6_addr_v4mapped(&csin6->sin6_addr)) {
+		if (!ipv4_set) {
 			struct in_device *idev;
 
 			sockaddr_storage->Family = cpu_to_le16(INTERNETWORK);
@@ -7391,6 +7399,9 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 				continue;
 			sockaddr_storage->addr4.IPv4address =
 						idev_ipv4_address(idev);
+			nbytes += sizeof(struct network_interface_info_ioctl_rsp);
+			ipv4_set = true;
+			goto ipv6_retry;
 		} else {
 			struct inet6_dev *idev6;
 			struct inet6_ifaddr *ifa;
@@ -7412,9 +7423,8 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 				break;
 			}
 			sockaddr_storage->addr6.ScopeId = 0;
+			nbytes += sizeof(struct network_interface_info_ioctl_rsp);
 		}
-
-		nbytes += sizeof(struct network_interface_info_ioctl_rsp);
 	}
 	rtnl_unlock();
 
@@ -7422,8 +7432,8 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 	if (nii_rsp)
 		nii_rsp->Next = 0;
 
-	rsp->PersistentFileId = cpu_to_le64(SMB2_NO_FID);
-	rsp->VolatileFileId = cpu_to_le64(SMB2_NO_FID);
+	rsp->PersistentFileId = SMB2_NO_FID;
+	rsp->VolatileFileId = SMB2_NO_FID;
 	return nbytes;
 }
 
@@ -7577,7 +7587,8 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 
 		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
 		ret = ksmbd_vfs_set_dos_attrib_xattr(user_ns,
-						     fp->filp->f_path.dentry, &da);
+						     &fp->filp->f_path,
+						     &da, true);
 		if (ret)
 			fp->f_ci->m_fattr = old_fattr;
 	}
@@ -7593,9 +7604,7 @@ static int fsctl_request_resume_key(struct ksmbd_work *work,
 {
 	struct ksmbd_file *fp;
 
-	fp = ksmbd_lookup_fd_slow(work,
-				  le64_to_cpu(req->VolatileFileId),
-				  le64_to_cpu(req->PersistentFileId));
+	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!fp)
 		return -ENOENT;
 
@@ -7616,28 +7625,27 @@ static int fsctl_request_resume_key(struct ksmbd_work *work,
 int smb2_ioctl(struct ksmbd_work *work)
 {
 	struct smb2_ioctl_req *req;
-	struct smb2_ioctl_rsp *rsp, *rsp_org;
+	struct smb2_ioctl_rsp *rsp;
 	unsigned int cnt_code, nbytes = 0, out_buf_len, in_buf_len;
 	u64 id = KSMBD_NO_FID;
 	struct ksmbd_conn *conn = work->conn;
 	int ret = 0;
 
-	rsp_org = work->response_buf;
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
 		rsp = ksmbd_resp_buf_next(work);
-		if (!has_file_id(le64_to_cpu(req->VolatileFileId))) {
+		if (!has_file_id(req->VolatileFileId)) {
 			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
 				    work->compound_fid);
 			id = work->compound_fid;
 		}
 	} else {
-		req = work->request_buf;
-		rsp = work->response_buf;
+		req = smb2_get_msg(work->request_buf);
+		rsp = smb2_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id))
-		id = le64_to_cpu(req->VolatileFileId);
+		id = req->VolatileFileId;
 
 	if (req->Flags != cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL)) {
 		rsp->hdr.Status = STATUS_NOT_SUPPORTED;
@@ -7708,8 +7716,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 
 		nbytes = sizeof(struct validate_negotiate_info_rsp);
-		rsp->PersistentFileId = cpu_to_le64(SMB2_NO_FID);
-		rsp->VolatileFileId = cpu_to_le64(SMB2_NO_FID);
+		rsp->PersistentFileId = SMB2_NO_FID;
+		rsp->VolatileFileId = SMB2_NO_FID;
 		break;
 	case FSCTL_QUERY_NETWORK_INTERFACE_INFO:
 		ret = fsctl_query_iface_info_ioctl(conn, rsp, out_buf_len);
@@ -7757,8 +7765,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 				(struct copychunk_ioctl_req *)&req->Buffer[0],
 				le32_to_cpu(req->CntCode),
 				le32_to_cpu(req->InputCount),
-				le64_to_cpu(req->VolatileFileId),
-				le64_to_cpu(req->PersistentFileId),
+				req->VolatileFileId,
+				req->PersistentFileId,
 				rsp);
 		break;
 	case FSCTL_SET_SPARSE:
@@ -7935,9 +7943,9 @@ int smb2_ioctl(struct ksmbd_work *work)
 	rsp->Reserved = cpu_to_le16(0);
 	rsp->Flags = cpu_to_le32(0);
 	rsp->Reserved2 = cpu_to_le32(0);
-	inc_rfc1001_len(rsp_org, 48 + nbytes);
-
-	return 0;
+	ret = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_ioctl_rsp) + nbytes);
+	if (!ret)
+		return ret;
 
 out:
 	if (ret == -EACCES)
@@ -7962,8 +7970,8 @@ int smb2_ioctl(struct ksmbd_work *work)
  */
 static void smb20_oplock_break_ack(struct ksmbd_work *work)
 {
-	struct smb2_oplock_break *req = work->request_buf;
-	struct smb2_oplock_break *rsp = work->response_buf;
+	struct smb2_oplock_break *req;
+	struct smb2_oplock_break *rsp;
 	struct ksmbd_file *fp;
 	struct oplock_info *opinfo = NULL;
 	__le32 err = 0;
@@ -7972,8 +7980,10 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	char req_oplevel = 0, rsp_oplevel = 0;
 	unsigned int oplock_change_type;
 
-	volatile_id = le64_to_cpu(req->VolatileFid);
-	persistent_id = le64_to_cpu(req->PersistentFid);
+	WORK_BUFFERS(work, req, rsp);
+
+	volatile_id = req->VolatileFid;
+	persistent_id = req->PersistentFid;
 	req_oplevel = req->OplockLevel;
 	ksmbd_debug(OPLOCK, "v_id %llu, p_id %llu request oplock level %d\n",
 		    volatile_id, persistent_id, req_oplevel);
@@ -8068,10 +8078,11 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	rsp->OplockLevel = rsp_oplevel;
 	rsp->Reserved = 0;
 	rsp->Reserved2 = 0;
-	rsp->VolatileFid = cpu_to_le64(volatile_id);
-	rsp->PersistentFid = cpu_to_le64(persistent_id);
-	inc_rfc1001_len(rsp, 24);
-	return;
+	rsp->VolatileFid = volatile_id;
+	rsp->PersistentFid = persistent_id;
+	ret = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_oplock_break));
+	if (!ret)
+		return;
 
 err_out:
 	opinfo->op_state = OPLOCK_STATE_NONE;
@@ -8106,8 +8117,8 @@ static int check_lease_state(struct lease *lease, __le32 req_state)
 static void smb21_lease_break_ack(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_lease_ack *req = work->request_buf;
-	struct smb2_lease_ack *rsp = work->response_buf;
+	struct smb2_lease_ack *req;
+	struct smb2_lease_ack *rsp;
 	struct oplock_info *opinfo;
 	__le32 err = 0;
 	int ret = 0;
@@ -8115,6 +8126,8 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	__le32 lease_state;
 	struct lease *lease;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	ksmbd_debug(OPLOCK, "smb21 lease break, lease state(0x%x)\n",
 		    le32_to_cpu(req->LeaseState));
 	opinfo = lookup_lease_in_table(conn, req->LeaseKey);
@@ -8219,11 +8232,11 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	memcpy(rsp->LeaseKey, req->LeaseKey, 16);
 	rsp->LeaseState = lease_state;
 	rsp->LeaseDuration = 0;
-	inc_rfc1001_len(rsp, 36);
-	return;
+	ret = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_lease_ack));
+	if (!ret)
+		return;
 
 err_out:
-	opinfo->op_state = OPLOCK_STATE_NONE;
 	wake_up_interruptible_all(&opinfo->oplock_q);
 	atomic_dec(&opinfo->breaking_cnt);
 	wake_up_interruptible_all(&opinfo->oplock_brk);
@@ -8240,8 +8253,10 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
  */
 int smb2_oplock_break(struct ksmbd_work *work)
 {
-	struct smb2_oplock_break *req = work->request_buf;
-	struct smb2_oplock_break *rsp = work->response_buf;
+	struct smb2_oplock_break *req;
+	struct smb2_oplock_break *rsp;
+
+	WORK_BUFFERS(work, req, rsp);
 
 	switch (le16_to_cpu(req->StructureSize)) {
 	case OP_BREAK_STRUCT_SIZE_20:
@@ -8293,7 +8308,7 @@ int smb2_notify(struct ksmbd_work *work)
  */
 bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
 {
-	struct smb2_hdr *rcv_hdr2 = work->request_buf;
+	struct smb2_hdr *rcv_hdr2 = smb2_get_msg(work->request_buf);
 
 	if ((rcv_hdr2->Flags & SMB2_FLAGS_SIGNED) &&
 	    command != SMB2_NEGOTIATE_HE &&
@@ -8312,22 +8327,22 @@ bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
  */
 int smb2_check_sign_req(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *hdr;
 	char signature_req[SMB2_SIGNATURE_SIZE];
 	char signature[SMB2_HMACSHA256_SIZE];
 	struct kvec iov[1];
 	size_t len;
 
-	hdr_org = hdr = work->request_buf;
+	hdr = smb2_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
 	if (!hdr->NextCommand && !work->next_smb2_rcv_hdr_off)
-		len = be32_to_cpu(hdr_org->smb2_buf_length);
+		len = get_rfc1002_len(work->request_buf);
 	else if (hdr->NextCommand)
 		len = le32_to_cpu(hdr->NextCommand);
 	else
-		len = be32_to_cpu(hdr_org->smb2_buf_length) -
+		len = get_rfc1002_len(work->request_buf) -
 			work->next_smb2_rcv_hdr_off;
 
 	memcpy(signature_req, hdr->Signature, SMB2_SIGNATURE_SIZE);
@@ -8355,43 +8370,20 @@ int smb2_check_sign_req(struct ksmbd_work *work)
  */
 void smb2_set_sign_rsp(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr, *hdr_org;
-	struct smb2_hdr *req_hdr;
+	struct smb2_hdr *hdr;
 	char signature[SMB2_HMACSHA256_SIZE];
-	struct kvec iov[2];
-	size_t len;
+	struct kvec *iov;
 	int n_vec = 1;
 
-	hdr_org = hdr = work->response_buf;
-	if (work->next_smb2_rsp_hdr_off)
-		hdr = ksmbd_resp_buf_next(work);
-
-	req_hdr = ksmbd_req_buf_next(work);
-
-	if (!work->next_smb2_rsp_hdr_off) {
-		len = get_rfc1002_len(hdr_org);
-		if (req_hdr->NextCommand)
-			len = ALIGN(len, 8);
-	} else {
-		len = get_rfc1002_len(hdr_org) - work->next_smb2_rsp_hdr_off;
-		len = ALIGN(len, 8);
-	}
-
-	if (req_hdr->NextCommand)
-		hdr->NextCommand = cpu_to_le32(len);
-
+	hdr = ksmbd_resp_buf_curr(work);
 	hdr->Flags |= SMB2_FLAGS_SIGNED;
 	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
 
-	iov[0].iov_base = (char *)&hdr->ProtocolId;
-	iov[0].iov_len = len;
-
-	if (work->aux_payload_sz) {
-		iov[0].iov_len -= work->aux_payload_sz;
-
-		iov[1].iov_base = work->aux_payload_buf;
-		iov[1].iov_len = work->aux_payload_sz;
+	if (hdr->Command == SMB2_READ) {
+		iov = &work->iov[work->iov_idx - 1];
 		n_vec++;
+	} else {
+		iov = &work->iov[work->iov_idx];
 	}
 
 	if (!ksmbd_sign_smb2_pdu(work->conn, work->sess->sess_key, iov, n_vec,
@@ -8409,36 +8401,33 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	char *signing_key;
-	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *hdr;
 	struct channel *chann;
 	char signature_req[SMB2_SIGNATURE_SIZE];
 	char signature[SMB2_CMACAES_SIZE];
 	struct kvec iov[1];
 	size_t len;
 
-	hdr_org = hdr = work->request_buf;
+	hdr = smb2_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
 	if (!hdr->NextCommand && !work->next_smb2_rcv_hdr_off)
-		len = be32_to_cpu(hdr_org->smb2_buf_length);
+		len = get_rfc1002_len(work->request_buf);
 	else if (hdr->NextCommand)
 		len = le32_to_cpu(hdr->NextCommand);
 	else
-		len = be32_to_cpu(hdr_org->smb2_buf_length) -
+		len = get_rfc1002_len(work->request_buf) -
 			work->next_smb2_rcv_hdr_off;
 
 	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return 0;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key) {
@@ -8470,62 +8459,41 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 void smb3_set_sign_rsp(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *req_hdr;
-	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *hdr;
 	struct channel *chann;
 	char signature[SMB2_CMACAES_SIZE];
-	struct kvec iov[2];
+	struct kvec *iov;
 	int n_vec = 1;
-	size_t len;
 	char *signing_key;
 
-	hdr_org = hdr = work->response_buf;
-	if (work->next_smb2_rsp_hdr_off)
-		hdr = ksmbd_resp_buf_next(work);
-
-	req_hdr = ksmbd_req_buf_next(work);
-
-	if (!work->next_smb2_rsp_hdr_off) {
-		len = get_rfc1002_len(hdr_org);
-		if (req_hdr->NextCommand)
-			len = ALIGN(len, 8);
-	} else {
-		len = get_rfc1002_len(hdr_org) - work->next_smb2_rsp_hdr_off;
-		len = ALIGN(len, 8);
-	}
+	hdr = ksmbd_resp_buf_curr(work);
 
 	if (conn->binding == false &&
 	    le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, work->conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key)
 		return;
 
-	if (req_hdr->NextCommand)
-		hdr->NextCommand = cpu_to_le32(len);
-
 	hdr->Flags |= SMB2_FLAGS_SIGNED;
 	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
-	iov[0].iov_base = (char *)&hdr->ProtocolId;
-	iov[0].iov_len = len;
-	if (work->aux_payload_sz) {
-		iov[0].iov_len -= work->aux_payload_sz;
-		iov[1].iov_base = work->aux_payload_buf;
-		iov[1].iov_len = work->aux_payload_sz;
+
+	if (hdr->Command == SMB2_READ) {
+		iov = &work->iov[work->iov_idx - 1];
 		n_vec++;
+	} else {
+		iov = &work->iov[work->iov_idx];
 	}
 
-	if (!ksmbd_sign_smb3_pdu(conn, signing_key, iov, n_vec, signature))
+	if (!ksmbd_sign_smb3_pdu(conn, signing_key, iov, n_vec,
+				 signature))
 		memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
 }
 
@@ -8547,7 +8515,7 @@ void smb3_preauth_hash_rsp(struct ksmbd_work *work)
 
 	if (le16_to_cpu(req->Command) == SMB2_NEGOTIATE_HE &&
 	    conn->preauth_info)
-		ksmbd_gen_preauth_integrity_hash(conn, (char *)rsp,
+		ksmbd_gen_preauth_integrity_hash(conn, work->response_buf,
 						 conn->preauth_info->Preauth_HashValue);
 
 	if (le16_to_cpu(rsp->Command) == SMB2_SESSION_SETUP_HE && sess) {
@@ -8565,18 +8533,18 @@ void smb3_preauth_hash_rsp(struct ksmbd_work *work)
 			if (!hash_value)
 				return;
 		}
-		ksmbd_gen_preauth_integrity_hash(conn, (char *)rsp,
+		ksmbd_gen_preauth_integrity_hash(conn, work->response_buf,
 						 hash_value);
 	}
 }
 
-static void fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, char *old_buf,
-			       __le16 cipher_type)
+static void fill_transform_hdr(void *tr_buf, char *old_buf, __le16 cipher_type)
 {
-	struct smb2_hdr *hdr = (struct smb2_hdr *)old_buf;
+	struct smb2_transform_hdr *tr_hdr = tr_buf + 4;
+	struct smb2_hdr *hdr = smb2_get_msg(old_buf);
 	unsigned int orig_len = get_rfc1002_len(old_buf);
 
-	memset(tr_hdr, 0, sizeof(struct smb2_transform_hdr));
+	/* tr_buf must be cleared by the caller */
 	tr_hdr->ProtocolId = SMB2_TRANSFORM_PROTO_NUM;
 	tr_hdr->OriginalMessageSize = cpu_to_le32(orig_len);
 	tr_hdr->Flags = cpu_to_le16(0x01);
@@ -8586,73 +8554,45 @@ static void fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, char *old_buf,
 	else
 		get_random_bytes(&tr_hdr->Nonce, SMB3_AES_CCM_NONCE);
 	memcpy(&tr_hdr->SessionId, &hdr->SessionId, 8);
-	inc_rfc1001_len(tr_hdr, sizeof(struct smb2_transform_hdr) - 4);
-	inc_rfc1001_len(tr_hdr, orig_len);
+	inc_rfc1001_len(tr_buf, sizeof(struct smb2_transform_hdr));
+	inc_rfc1001_len(tr_buf, orig_len);
 }
 
 int smb3_encrypt_resp(struct ksmbd_work *work)
 {
-	char *buf = work->response_buf;
-	struct smb2_transform_hdr *tr_hdr;
-	struct kvec iov[3];
+	struct kvec *iov = work->iov;
 	int rc = -ENOMEM;
-	int buf_size = 0, rq_nvec = 2 + (work->aux_payload_sz ? 1 : 0);
+	void *tr_buf;
 
-	if (ARRAY_SIZE(iov) < rq_nvec)
-		return -ENOMEM;
-
-	tr_hdr = kzalloc(sizeof(struct smb2_transform_hdr), GFP_KERNEL);
-	if (!tr_hdr)
+	tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
+	if (!tr_buf)
 		return rc;
 
 	/* fill transform header */
-	fill_transform_hdr(tr_hdr, buf, work->conn->cipher_type);
-
-	iov[0].iov_base = tr_hdr;
-	iov[0].iov_len = sizeof(struct smb2_transform_hdr);
-	buf_size += iov[0].iov_len - 4;
-
-	iov[1].iov_base = buf + 4;
-	iov[1].iov_len = get_rfc1002_len(buf);
-	if (work->aux_payload_sz) {
-		iov[1].iov_len = work->resp_hdr_sz - 4;
+	fill_transform_hdr(tr_buf, work->response_buf, work->conn->cipher_type);
 
-		iov[2].iov_base = work->aux_payload_buf;
-		iov[2].iov_len = work->aux_payload_sz;
-		buf_size += iov[2].iov_len;
-	}
-	buf_size += iov[1].iov_len;
-	work->resp_hdr_sz = iov[1].iov_len;
-
-	rc = ksmbd_crypt_message(work->conn, iov, rq_nvec, 1);
-	if (rc)
-		return rc;
+	iov[0].iov_base = tr_buf;
+	iov[0].iov_len = sizeof(struct smb2_transform_hdr) + 4;
+	work->tr_buf = tr_buf;
 
-	memmove(buf, iov[1].iov_base, iov[1].iov_len);
-	tr_hdr->smb2_buf_length = cpu_to_be32(buf_size);
-	work->tr_buf = tr_hdr;
-
-	return rc;
+	return ksmbd_crypt_message(work, iov, work->iov_idx + 1, 1);
 }
 
 bool smb3_is_transform_hdr(void *buf)
 {
-	struct smb2_transform_hdr *trhdr = buf;
+	struct smb2_transform_hdr *trhdr = smb2_get_msg(buf);
 
 	return trhdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM;
 }
 
 int smb3_decrypt_req(struct ksmbd_work *work)
 {
-	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess;
 	char *buf = work->request_buf;
-	struct smb2_hdr *hdr;
 	unsigned int pdu_length = get_rfc1002_len(buf);
 	struct kvec iov[2];
-	int buf_data_size = pdu_length + 4 -
-		sizeof(struct smb2_transform_hdr);
-	struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
+	int buf_data_size = pdu_length - sizeof(struct smb2_transform_hdr);
+	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(buf);
 	int rc = 0;
 
 	if (pdu_length < sizeof(struct smb2_transform_hdr) ||
@@ -8667,7 +8607,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 		return -ECONNABORTED;
 	}
 
-	sess = ksmbd_session_lookup_all(conn, le64_to_cpu(tr_hdr->SessionId));
+	sess = ksmbd_session_lookup_all(work->conn, le64_to_cpu(tr_hdr->SessionId));
 	if (!sess) {
 		pr_err("invalid session id(%llx) in transform header\n",
 		       le64_to_cpu(tr_hdr->SessionId));
@@ -8675,16 +8615,15 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	}
 
 	iov[0].iov_base = buf;
-	iov[0].iov_len = sizeof(struct smb2_transform_hdr);
-	iov[1].iov_base = buf + sizeof(struct smb2_transform_hdr);
+	iov[0].iov_len = sizeof(struct smb2_transform_hdr) + 4;
+	iov[1].iov_base = buf + sizeof(struct smb2_transform_hdr) + 4;
 	iov[1].iov_len = buf_data_size;
-	rc = ksmbd_crypt_message(conn, iov, 2, 0);
+	rc = ksmbd_crypt_message(work, iov, 2, 0);
 	if (rc)
 		return rc;
 
 	memmove(buf + 4, iov[1].iov_base, buf_data_size);
-	hdr = (struct smb2_hdr *)buf;
-	hdr->smb2_buf_length = cpu_to_be32(buf_data_size);
+	*(__be32 *)buf = cpu_to_be32(buf_data_size);
 
 	return rc;
 }
@@ -8693,7 +8632,7 @@ bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
-	struct smb2_hdr *rsp = work->response_buf;
+	struct smb2_hdr *rsp = smb2_get_msg(work->response_buf);
 
 	if (conn->dialect < SMB30_PROT_ID)
 		return false;
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index fa1cd556ab7a..e1d0849ee68f 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -109,6 +109,7 @@
 
 #define SMB2_PROTO_NUMBER cpu_to_le32(0x424d53fe) /* 'B''M''S' */
 #define SMB2_TRANSFORM_PROTO_NUM cpu_to_le32(0x424d53fd)
+#define SMB2_COMPRESSION_TRANSFORM_ID cpu_to_le32(0x424d53fc)
 
 #define SMB21_DEFAULT_IOSIZE	(1024 * 1024)
 #define SMB3_DEFAULT_IOSIZE	(4 * 1024 * 1024)
@@ -131,11 +132,6 @@
 	cpu_to_le16(__SMB2_HEADER_STRUCTURE_SIZE)
 
 struct smb2_hdr {
-	__be32 smb2_buf_length;	/* big endian on wire */
-				/*
-				 * length is only two or three bytes - with
-				 * one or two byte type preceding it that MBZ
-				 */
 	__le32 ProtocolId;	/* 0xFE 'S' 'M' 'B' */
 	__le16 StructureSize;	/* 64 */
 	__le16 CreditCharge;	/* MBZ */
@@ -165,11 +161,6 @@ struct smb2_pdu {
 #define SMB3_AES_GCM_NONCE 12
 
 struct smb2_transform_hdr {
-	__be32 smb2_buf_length; /* big endian on wire */
-	/*
-	 * length is only two or three bytes - with
-	 * one or two byte type preceding it that MBZ
-	 */
 	__le32 ProtocolId;      /* 0xFD 'S' 'M' 'B' */
 	__u8   Signature[16];
 	__u8   Nonce[16];
@@ -254,14 +245,14 @@ struct preauth_integrity_info {
 	__u8			Preauth_HashValue[PREAUTH_HASHVALUE_SIZE];
 };
 
-/* offset is sizeof smb2_negotiate_rsp - 4 but rounded up to 8 bytes. */
+/* offset is sizeof smb2_negotiate_rsp but rounded up to 8 bytes. */
 #ifdef CONFIG_SMB_SERVER_KERBEROS5
-/* sizeof(struct smb2_negotiate_rsp) - 4 =
+/* sizeof(struct smb2_negotiate_rsp) =
  * header(64) + response(64) + GSS_LENGTH(96) + GSS_PADDING(0)
  */
 #define OFFSET_OF_NEG_CONTEXT	0xe0
 #else
-/* sizeof(struct smb2_negotiate_rsp) - 4 =
+/* sizeof(struct smb2_negotiate_rsp) =
  * header(64) + response(64) + GSS_LENGTH(74) + GSS_PADDING(6)
  */
 #define OFFSET_OF_NEG_CONTEXT	0xd0
@@ -629,6 +620,8 @@ struct create_context {
 	__u8 Buffer[0];
 } __packed;
 
+#define SMB2_SESSION_TIMEOUT		(10 * HZ)
+
 struct create_durable_req_v2 {
 	struct create_context ccontext;
 	__u8   Name[8];
@@ -644,8 +637,8 @@ struct create_durable_reconn_req {
 	union {
 		__u8  Reserved[16];
 		struct {
-			__le64 PersistentFileId;
-			__le64 VolatileFileId;
+			__u64 PersistentFileId;
+			__u64 VolatileFileId;
 		} Fid;
 	} Data;
 } __packed;
@@ -654,8 +647,8 @@ struct create_durable_reconn_v2_req {
 	struct create_context ccontext;
 	__u8   Name[8];
 	struct {
-		__le64 PersistentFileId;
-		__le64 VolatileFileId;
+		__u64 PersistentFileId;
+		__u64 VolatileFileId;
 	} Fid;
 	__u8 CreateGuid[16];
 	__le32 Flags;
@@ -734,7 +727,8 @@ struct create_posix_rsp {
 	__le32 nlink;
 	__le32 reparse_tag;
 	__le32 mode;
-	u8 SidBuffer[40];
+	/* SidBuffer contain two sids(Domain sid(28), UNIX group sid(16)) */
+	u8 SidBuffer[44];
 } __packed;
 
 #define SMB2_LEASE_NONE_LE			cpu_to_le32(0x00)
@@ -744,22 +738,21 @@ struct create_posix_rsp {
 
 #define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE	cpu_to_le32(0x02)
 
+#define SMB2_LEASE_KEY_SIZE			16
+
 struct lease_context {
-	__le64 LeaseKeyLow;
-	__le64 LeaseKeyHigh;
+	__u8 LeaseKey[SMB2_LEASE_KEY_SIZE];
 	__le32 LeaseState;
 	__le32 LeaseFlags;
 	__le64 LeaseDuration;
 } __packed;
 
 struct lease_context_v2 {
-	__le64 LeaseKeyLow;
-	__le64 LeaseKeyHigh;
+	__u8 LeaseKey[SMB2_LEASE_KEY_SIZE];
 	__le32 LeaseState;
 	__le32 LeaseFlags;
 	__le64 LeaseDuration;
-	__le64 ParentLeaseKeyLow;
-	__le64 ParentLeaseKeyHigh;
+	__u8 ParentLeaseKey[SMB2_LEASE_KEY_SIZE];
 	__le16 Epoch;
 	__le16 Reserved;
 } __packed;
@@ -900,8 +893,8 @@ struct smb2_ioctl_req {
 	__le16 StructureSize; /* Must be 57 */
 	__le16 Reserved; /* offset from start of SMB2 header to write data */
 	__le32 CntCode;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	__le32 InputOffset; /* Reserved MBZ */
 	__le32 InputCount;
 	__le32 MaxInputResponse;
@@ -918,8 +911,8 @@ struct smb2_ioctl_rsp {
 	__le16 StructureSize; /* Must be 49 */
 	__le16 Reserved; /* offset from start of SMB2 header to write data */
 	__le32 CntCode;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	__le32 InputOffset; /* Reserved MBZ */
 	__le32 InputCount;
 	__le32 OutputOffset;
@@ -988,7 +981,7 @@ struct file_object_buf_type1_ioctl_rsp {
 } __packed;
 
 struct resume_key_ioctl_rsp {
-	__le64 ResumeKey[3];
+	__u64 ResumeKey[3];
 	__le32 ContextLength;
 	__u8 Context[4]; /* ignored, Windows sets to 4 bytes of zero */
 } __packed;
@@ -1100,8 +1093,8 @@ struct smb2_lock_req {
 	__le16 StructureSize; /* Must be 48 */
 	__le16 LockCount;
 	__le32 Reserved;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	/* Followed by at least one */
 	struct smb2_lock_element locks[1];
 } __packed;
@@ -1136,8 +1129,8 @@ struct smb2_query_directory_req {
 	__u8   FileInformationClass;
 	__u8   Flags;
 	__le32 FileIndex;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	__le16 FileNameOffset;
 	__le16 FileNameLength;
 	__le32 OutputBufferLength;
@@ -1183,8 +1176,8 @@ struct smb2_query_info_req {
 	__le32 InputBufferLength;
 	__le32 AdditionalInformation;
 	__le32 Flags;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	__u8   Buffer[1];
 } __packed;
 
@@ -1205,8 +1198,8 @@ struct smb2_set_info_req {
 	__le16 BufferOffset;
 	__u16  Reserved;
 	__le32 AdditionalInformation;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
+	__u64  PersistentFileId;
+	__u64  VolatileFileId;
 	__u8   Buffer[1];
 } __packed;
 
@@ -1628,9 +1621,10 @@ struct smb2_posix_info {
 	__le32 HardLinks;
 	__le32 ReparseTag;
 	__le32 Mode;
-	u8 SidBuffer[40];
+	/* SidBuffer contain two sids (UNIX user sid(16), UNIX group sid(16)) */
+	u8 SidBuffer[32];
 	__le32 name_len;
-	u8 name[1];
+	u8 name[];
 	/*
 	 * var sized owner SID
 	 * var sized group SID
@@ -1672,6 +1666,7 @@ int find_matching_smb2_dialect(int start_index, __le16 *cli_dialects,
 struct file_lock *smb_flock_init(struct file *f);
 int setup_async_work(struct ksmbd_work *work, void (*fn)(void **),
 		     void **arg);
+void release_async_work(struct ksmbd_work *work);
 void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status);
 struct channel *lookup_chann_list(struct ksmbd_session *sess,
 				  struct ksmbd_conn *conn);
@@ -1681,6 +1676,7 @@ int smb3_decrypt_req(struct ksmbd_work *work);
 int smb3_encrypt_resp(struct ksmbd_work *work);
 bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work);
 int smb2_set_rsp_credits(struct ksmbd_work *work);
+bool smb3_encryption_negotiated(struct ksmbd_conn *conn);
 
 /* smb2 misc functions */
 int ksmbd_smb2_check_message(struct ksmbd_work *work);
@@ -1707,4 +1703,13 @@ int smb2_ioctl(struct ksmbd_work *work);
 int smb2_oplock_break(struct ksmbd_work *work);
 int smb2_notify(struct ksmbd_work *ksmbd_work);
 
+/*
+ * Get the body of the smb2 message excluding the 4 byte rfc1002 headers
+ * from request/response buffer.
+ */
+static inline void *smb2_get_msg(void *buf)
+{
+	return buf + 4;
+}
+
 #endif	/* _SMB2PDU_H */
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index af583e426621..d160363c09eb 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -134,7 +134,7 @@ int ksmbd_lookup_protocol_idx(char *str)
  */
 int ksmbd_verify_smb_message(struct ksmbd_work *work)
 {
-	struct smb2_hdr *smb2_hdr = work->request_buf + work->next_smb2_rcv_hdr_off;
+	struct smb2_hdr *smb2_hdr = ksmbd_req_buf_next(work);
 	struct smb_hdr *hdr;
 
 	if (smb2_hdr->ProtocolId == SMB2_PROTO_NUMBER)
@@ -158,7 +158,19 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
  */
 bool ksmbd_smb_request(struct ksmbd_conn *conn)
 {
-	return conn->request_buf[0] == 0;
+	__le32 *proto = (__le32 *)smb2_get_msg(conn->request_buf);
+
+	if (*proto == SMB2_COMPRESSION_TRANSFORM_ID) {
+		pr_err_ratelimited("smb2 compression not support yet");
+		return false;
+	}
+
+	if (*proto != SMB1_PROTO_NUMBER &&
+	    *proto != SMB2_PROTO_NUMBER &&
+	    *proto != SMB2_TRANSFORM_PROTO_NUM)
+		return false;
+
+	return true;
 }
 
 static bool supported_protocol(int idx)
@@ -243,18 +255,18 @@ int ksmbd_lookup_dialect_by_id(__le16 *cli_dialects, __le16 dialects_count)
 static int ksmbd_negotiate_smb_dialect(void *buf)
 {
 	int smb_buf_length = get_rfc1002_len(buf);
-	__le32 proto = ((struct smb2_hdr *)buf)->ProtocolId;
+	__le32 proto = ((struct smb2_hdr *)smb2_get_msg(buf))->ProtocolId;
 
 	if (proto == SMB2_PROTO_NUMBER) {
 		struct smb2_negotiate_req *req;
 		int smb2_neg_size =
-			offsetof(struct smb2_negotiate_req, Dialects) - 4;
+			offsetof(struct smb2_negotiate_req, Dialects);
 
-		req = (struct smb2_negotiate_req *)buf;
+		req = (struct smb2_negotiate_req *)smb2_get_msg(buf);
 		if (smb2_neg_size > smb_buf_length)
 			goto err_out;
 
-		if (smb2_neg_size + le16_to_cpu(req->DialectCount) * sizeof(__le16) >
+		if (struct_size(req, Dialects, le16_to_cpu(req->DialectCount)) >
 		    smb_buf_length)
 			goto err_out;
 
@@ -283,20 +295,129 @@ static int ksmbd_negotiate_smb_dialect(void *buf)
 	return BAD_PROT_ID;
 }
 
-int ksmbd_init_smb_server(struct ksmbd_work *work)
+#define SMB_COM_NEGOTIATE_EX	0x0
+
+/**
+ * get_smb1_cmd_val() - get smb command value from smb header
+ * @work:	smb work containing smb header
+ *
+ * Return:      smb command value
+ */
+static u16 get_smb1_cmd_val(struct ksmbd_work *work)
 {
-	struct ksmbd_conn *conn = work->conn;
+	return SMB_COM_NEGOTIATE_EX;
+}
 
-	if (conn->need_neg == false)
+/**
+ * init_smb1_rsp_hdr() - initialize smb negotiate response header
+ * @work:	smb work containing smb request
+ *
+ * Return:      0 on success, otherwise -EINVAL
+ */
+static int init_smb1_rsp_hdr(struct ksmbd_work *work)
+{
+	struct smb_hdr *rsp_hdr = (struct smb_hdr *)work->response_buf;
+	struct smb_hdr *rcv_hdr = (struct smb_hdr *)work->request_buf;
+
+	rsp_hdr->Command = SMB_COM_NEGOTIATE;
+	*(__le32 *)rsp_hdr->Protocol = SMB1_PROTO_NUMBER;
+	rsp_hdr->Flags = SMBFLG_RESPONSE;
+	rsp_hdr->Flags2 = SMBFLG2_UNICODE | SMBFLG2_ERR_STATUS |
+		SMBFLG2_EXT_SEC | SMBFLG2_IS_LONG_NAME;
+	rsp_hdr->Pid = rcv_hdr->Pid;
+	rsp_hdr->Mid = rcv_hdr->Mid;
+	return 0;
+}
+
+/**
+ * smb1_check_user_session() - check for valid session for a user
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      0 on success, otherwise error
+ */
+static int smb1_check_user_session(struct ksmbd_work *work)
+{
+	unsigned int cmd = work->conn->ops->get_cmd_val(work);
+
+	if (cmd == SMB_COM_NEGOTIATE_EX)
 		return 0;
 
-	init_smb3_11_server(conn);
+	return -EINVAL;
+}
+
+/**
+ * smb1_allocate_rsp_buf() - allocate response buffer for a command
+ * @work:	smb work containing smb request
+ *
+ * Return:      0 on success, otherwise -ENOMEM
+ */
+static int smb1_allocate_rsp_buf(struct ksmbd_work *work)
+{
+	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE,
+			GFP_KERNEL);
+	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
+
+	if (!work->response_buf) {
+		pr_err("Failed to allocate %u bytes buffer\n",
+				MAX_CIFS_SMALL_BUFFER_SIZE);
+		return -ENOMEM;
+	}
 
-	if (conn->ops->get_cmd_val(work) != SMB_COM_NEGOTIATE)
-		conn->need_neg = false;
 	return 0;
 }
 
+/**
+ * set_smb1_rsp_status() - set error type in smb response header
+ * @work:	smb work containing smb response header
+ * @err:	error code to set in response
+ */
+static void set_smb1_rsp_status(struct ksmbd_work *work, __le32 err)
+{
+	work->send_no_response = 1;
+}
+
+static struct smb_version_ops smb1_server_ops = {
+	.get_cmd_val = get_smb1_cmd_val,
+	.init_rsp_hdr = init_smb1_rsp_hdr,
+	.allocate_rsp_buf = smb1_allocate_rsp_buf,
+	.check_user_session = smb1_check_user_session,
+	.set_rsp_status = set_smb1_rsp_status,
+};
+
+static int smb1_negotiate(struct ksmbd_work *work)
+{
+	return ksmbd_smb_negotiate_common(work, SMB_COM_NEGOTIATE);
+}
+
+static struct smb_version_cmds smb1_server_cmds[1] = {
+	[SMB_COM_NEGOTIATE_EX]	= { .proc = smb1_negotiate, },
+};
+
+static int init_smb1_server(struct ksmbd_conn *conn)
+{
+	conn->ops = &smb1_server_ops;
+	conn->cmds = smb1_server_cmds;
+	conn->max_cmds = ARRAY_SIZE(smb1_server_cmds);
+	return 0;
+}
+
+int ksmbd_init_smb_server(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	__le32 proto;
+
+	proto = *(__le32 *)((struct smb_hdr *)work->request_buf)->Protocol;
+	if (conn->need_neg == false) {
+		if (proto == SMB1_PROTO_NUMBER)
+			return -EINVAL;
+		return 0;
+	}
+
+	if (proto == SMB1_PROTO_NUMBER)
+		return init_smb1_server(conn);
+	return init_smb3_11_server(conn);
+}
+
 int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
 				      struct ksmbd_file *dir,
 				      struct ksmbd_dir_info *d_info,
@@ -444,20 +565,11 @@ static int smb_handle_negotiate(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "Unsupported SMB1 protocol\n");
 
-	/*
-	 * Remove 4 byte direct TCP header, add 2 byte bcc and
-	 * 2 byte DialectIndex.
-	 */
-	*(__be32 *)work->response_buf =
-		cpu_to_be32(sizeof(struct smb_hdr) - 4 + 2 + 2);
-	neg_rsp->hdr.Status.CifsError = STATUS_SUCCESS;
-
-	neg_rsp->hdr.Command = SMB_COM_NEGOTIATE;
-	*(__le32 *)neg_rsp->hdr.Protocol = SMB1_PROTO_NUMBER;
-	neg_rsp->hdr.Flags = SMBFLG_RESPONSE;
-	neg_rsp->hdr.Flags2 = SMBFLG2_UNICODE | SMBFLG2_ERR_STATUS |
-		SMBFLG2_EXT_SEC | SMBFLG2_IS_LONG_NAME;
+	if (ksmbd_iov_pin_rsp(work, (void *)neg_rsp,
+			      sizeof(struct smb_negotiate_rsp) - 4))
+		return -ENOMEM;
 
+	neg_rsp->hdr.Status.CifsError = STATUS_SUCCESS;
 	neg_rsp->hdr.WordCount = 1;
 	neg_rsp->DialectIndex = cpu_to_le16(work->conn->dialect);
 	neg_rsp->ByteCount = 0;
@@ -469,27 +581,17 @@ int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command)
 	struct ksmbd_conn *conn = work->conn;
 	int ret;
 
-	conn->dialect = ksmbd_negotiate_smb_dialect(work->request_buf);
+	conn->dialect =
+		ksmbd_negotiate_smb_dialect(work->request_buf);
 	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
 
-	if (command == SMB2_NEGOTIATE_HE) {
-		struct smb2_hdr *smb2_hdr = work->request_buf;
-
-		if (smb2_hdr->ProtocolId != SMB2_PROTO_NUMBER) {
-			ksmbd_debug(SMB, "Downgrade to SMB1 negotiation\n");
-			command = SMB_COM_NEGOTIATE;
-		}
-	}
-
 	if (command == SMB2_NEGOTIATE_HE) {
 		ret = smb2_handle_negotiate(work);
-		init_smb2_neg_rsp(work);
 		return ret;
 	}
 
 	if (command == SMB_COM_NEGOTIATE) {
 		if (__smb2_negotiate(conn)) {
-			conn->need_neg = true;
 			init_smb3_11_server(conn);
 			init_smb2_neg_rsp(work);
 			ksmbd_debug(SMB, "Upgrade to SMB2 negotiation\n");
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index 48cbaa032140..c4978579c541 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -247,7 +247,7 @@ struct smb_hdr {
 struct smb_negotiate_req {
 	struct smb_hdr hdr;     /* wct = 0 */
 	__le16 ByteCount;
-	unsigned char DialectsArray[1];
+	unsigned char DialectsArray[];
 } __packed;
 
 struct smb_negotiate_rsp {
@@ -310,14 +310,14 @@ struct file_directory_info {
 	__le64 AllocationSize;
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __packed;   /* level 0x101 FF resp data */
 
 struct file_names_info {
 	__le32 NextEntryOffset;
 	__u32 FileIndex;
 	__le32 FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __packed;   /* level 0xc FF resp data */
 
 struct file_full_directory_info {
@@ -332,7 +332,7 @@ struct file_full_directory_info {
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
 	__le32 EaSize;
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 0x102 FF resp */
 
 struct file_both_directory_info {
@@ -350,7 +350,7 @@ struct file_both_directory_info {
 	__u8   ShortNameLength;
 	__u8   Reserved;
 	__u8   ShortName[24];
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 0x104 FFrsp data */
 
 struct file_id_both_directory_info {
@@ -370,7 +370,7 @@ struct file_id_both_directory_info {
 	__u8   ShortName[24];
 	__le16 Reserved2;
 	__le64 UniqueId;
-	char FileName[1];
+	char FileName[];
 } __packed;
 
 struct file_id_full_dir_info {
@@ -387,7 +387,7 @@ struct file_id_full_dir_info {
 	__le32 EaSize; /* EA size */
 	__le32 Reserved;
 	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit*/
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 0x105 FF rsp data */
 
 struct smb_version_values {
@@ -464,12 +464,6 @@ struct smb_version_cmds {
 	int (*proc)(struct ksmbd_work *swork);
 };
 
-static inline size_t
-smb2_hdr_size_no_buflen(struct smb_version_values *vals)
-{
-	return vals->header_size - 4;
-}
-
 int ksmbd_min_protocol(void);
 int ksmbd_max_protocol(void);
 
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 83f805248a81..9ace5027684d 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -97,7 +97,7 @@ int compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid)
 	/* compare all of the subauth values if any */
 	num_sat = ctsid->num_subauth;
 	num_saw = cwsid->num_subauth;
-	num_subauth = num_sat < num_saw ? num_sat : num_saw;
+	num_subauth = min(num_sat, num_saw);
 	if (num_subauth) {
 		for (i = 0; i < num_subauth; ++i) {
 			if (ctsid->sub_auth[i] != cwsid->sub_auth[i]) {
@@ -991,7 +991,7 @@ static void smb_set_ace(struct smb_ace *ace, const struct smb_sid *sid, u8 type,
 }
 
 int smb_inherit_dacl(struct ksmbd_conn *conn,
-		     struct path *path,
+		     const struct path *path,
 		     unsigned int uid, unsigned int gid)
 {
 	const struct smb_sid *psid, *creator = NULL;
@@ -1183,8 +1183,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pntsd_size += sizeof(struct smb_acl) + nt_size;
 		}
 
-		ksmbd_vfs_set_sd_xattr(conn, user_ns,
-				       path->dentry, pntsd, pntsd_size);
+		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, pntsd_size, false);
 		kfree(pntsd);
 	}
 
@@ -1208,7 +1207,7 @@ bool smb_inherit_flags(int flags, bool is_dir)
 	return false;
 }
 
-int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
+int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
@@ -1311,7 +1310,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
 
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 		posix_acls = get_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
-		if (posix_acls && !found) {
+		if (!IS_ERR_OR_NULL(posix_acls) && !found) {
 			unsigned int id = -1;
 
 			pa_entry = posix_acls->a_entries;
@@ -1335,7 +1334,7 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
 				}
 			}
 		}
-		if (posix_acls)
+		if (!IS_ERR_OR_NULL(posix_acls))
 			posix_acl_release(posix_acls);
 	}
 
@@ -1375,8 +1374,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
 }
 
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
-		 struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
-		 bool type_check)
+		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
+		 bool type_check, bool get_write)
 {
 	int rc;
 	struct smb_fattr fattr = {{0}};
@@ -1404,7 +1403,7 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	newattrs.ia_valid |= ATTR_MODE;
 	newattrs.ia_mode = (inode->i_mode & ~0777) | (fattr.cf_mode & 0777);
 
-	ksmbd_vfs_remove_acl_xattrs(user_ns, path->dentry);
+	ksmbd_vfs_remove_acl_xattrs(user_ns, path);
 	/* Update posix acls */
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && fattr.cf_dacls) {
 		rc = set_posix_acl(user_ns, inode,
@@ -1435,15 +1434,14 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 
 	if (test_share_config_flag(tcon->share_conf, KSMBD_SHARE_FLAG_ACL_XATTR)) {
 		/* Update WinACL in xattr */
-		ksmbd_vfs_remove_sd_xattrs(user_ns, path->dentry);
-		ksmbd_vfs_set_sd_xattr(conn, user_ns,
-				       path->dentry, pntsd, ntsd_len);
+		ksmbd_vfs_remove_sd_xattrs(user_ns, path);
+		ksmbd_vfs_set_sd_xattr(conn, user_ns, path, pntsd, ntsd_len,
+				get_write);
 	}
 
 out:
 	posix_acl_release(fattr.cf_acls);
 	posix_acl_release(fattr.cf_dacls);
-	mark_inode_dirty(inode);
 	return rc;
 }
 
diff --git a/fs/ksmbd/smbacl.h b/fs/ksmbd/smbacl.h
index fcb2c83f2992..17f81a510f23 100644
--- a/fs/ksmbd/smbacl.h
+++ b/fs/ksmbd/smbacl.h
@@ -201,13 +201,13 @@ void posix_state_to_acl(struct posix_acl_state *state,
 			struct posix_acl_entry *pace);
 int compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid);
 bool smb_inherit_flags(int flags, bool is_dir);
-int smb_inherit_dacl(struct ksmbd_conn *conn, struct path *path,
+int smb_inherit_dacl(struct ksmbd_conn *conn, const struct path *path,
 		     unsigned int uid, unsigned int gid);
-int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
+int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 			__le32 *pdaccess, int uid);
 int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
-		 struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
-		 bool type_check);
+		 const struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
+		 bool type_check, bool get_write);
 void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid);
 void ksmbd_init_domain(u32 *sub_auth);
 
diff --git a/fs/ksmbd/transport_ipc.c b/fs/ksmbd/transport_ipc.c
index a8313eed4f10..9560c704033e 100644
--- a/fs/ksmbd/transport_ipc.c
+++ b/fs/ksmbd/transport_ipc.c
@@ -228,7 +228,7 @@ static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
 	struct ksmbd_ipc_msg *msg;
 	size_t msg_sz = sz + sizeof(struct ksmbd_ipc_msg);
 
-	msg = kvmalloc(msg_sz, GFP_KERNEL | __GFP_ZERO);
+	msg = kvzalloc(msg_sz, GFP_KERNEL);
 	if (msg)
 		msg->sz = sz;
 	return msg;
@@ -267,7 +267,7 @@ static int handle_response(int type, void *payload, size_t sz)
 			       entry->type + 1, type);
 		}
 
-		entry->response = kvmalloc(sz, GFP_KERNEL | __GFP_ZERO);
+		entry->response = kvzalloc(sz, GFP_KERNEL);
 		if (!entry->response) {
 			ret = -ENOMEM;
 			break;
diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 9ca29cdb7898..252a1e7afcc0 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -5,16 +5,6 @@
  *
  *   Author(s): Long Li <longli@microsoft.com>,
  *		Hyunchul Lee <hyc.lee@gmail.com>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
  */
 
 #define SUBMOD_NAME	"smb_direct"
@@ -34,14 +24,15 @@
 #include "smbstatus.h"
 #include "transport_rdma.h"
 
-#define SMB_DIRECT_PORT	5445
+#define SMB_DIRECT_PORT_IWARP		5445
+#define SMB_DIRECT_PORT_INFINIBAND	445
 
 #define SMB_DIRECT_VERSION_LE		cpu_to_le16(0x0100)
 
 /* SMB_DIRECT negotiation timeout in seconds */
 #define SMB_DIRECT_NEGOTIATE_TIMEOUT		120
 
-#define SMB_DIRECT_MAX_SEND_SGES		8
+#define SMB_DIRECT_MAX_SEND_SGES		6
 #define SMB_DIRECT_MAX_RECV_SGES		1
 
 /*
@@ -60,6 +51,10 @@
  * as defined in [MS-SMBD] 3.1.1.1
  * Those may change after a SMB_DIRECT negotiation
  */
+
+/* Set 445 port to SMB Direct port by default */
+static int smb_direct_port = SMB_DIRECT_PORT_INFINIBAND;
+
 /* The local peer's maximum number of credits to grant to the peer */
 static int smb_direct_receive_credit_max = 255;
 
@@ -67,17 +62,23 @@ static int smb_direct_receive_credit_max = 255;
 static int smb_direct_send_credit_target = 255;
 
 /* The maximum single message size can be sent to remote peer */
-static int smb_direct_max_send_size = 8192;
+static int smb_direct_max_send_size = 1364;
 
 /*  The maximum fragmented upper-layer payload receive size supported */
 static int smb_direct_max_fragmented_recv_size = 1024 * 1024;
 
 /*  The maximum single-message size which can be received */
-static int smb_direct_max_receive_size = 8192;
+static int smb_direct_max_receive_size = 1364;
 
 static int smb_direct_max_read_write_size = SMBD_DEFAULT_IOSIZE;
 
-static int smb_direct_max_outstanding_rw_ops = 8;
+static LIST_HEAD(smb_direct_device_list);
+static DEFINE_RWLOCK(smb_direct_device_lock);
+
+struct smb_direct_device {
+	struct ib_device	*ib_dev;
+	struct list_head	list;
+};
 
 static struct smb_direct_listener {
 	struct rdma_cm_id	*cm_id;
@@ -134,18 +135,18 @@ struct smb_direct_transport {
 	atomic_t		send_credits;
 	spinlock_t		lock_new_recv_credits;
 	int			new_recv_credits;
-	atomic_t		rw_avail_ops;
+	int			max_rw_credits;
+	int			pages_per_rw_credit;
+	atomic_t		rw_credits;
 
 	wait_queue_head_t	wait_send_credits;
-	wait_queue_head_t	wait_rw_avail_ops;
+	wait_queue_head_t	wait_rw_credits;
 
 	mempool_t		*sendmsg_mempool;
 	struct kmem_cache	*sendmsg_cache;
 	mempool_t		*recvmsg_mempool;
 	struct kmem_cache	*recvmsg_cache;
 
-	wait_queue_head_t	wait_send_payload_pending;
-	atomic_t		send_payload_pending;
 	wait_queue_head_t	wait_send_pending;
 	atomic_t		send_pending;
 
@@ -195,7 +196,9 @@ struct smb_direct_recvmsg {
 struct smb_direct_rdma_rw_msg {
 	struct smb_direct_transport	*t;
 	struct ib_cqe		cqe;
+	int			status;
 	struct completion	*completion;
+	struct list_head	list;
 	struct rdma_rw_ctx	rw_ctx;
 	struct sg_table		sgt;
 	struct scatterlist	sg_list[0];
@@ -207,6 +210,11 @@ void init_smbd_max_io_size(unsigned int sz)
 	smb_direct_max_read_write_size = sz;
 }
 
+unsigned int get_smbd_max_read_write_size(void)
+{
+	return smb_direct_max_read_write_size;
+}
+
 static inline int get_buf_page_count(void *buf, int size)
 {
 	return DIV_ROUND_UP((uintptr_t)buf + size, PAGE_SIZE) -
@@ -370,7 +378,7 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	t->reassembly_queue_length = 0;
 	init_waitqueue_head(&t->wait_reassembly_queue);
 	init_waitqueue_head(&t->wait_send_credits);
-	init_waitqueue_head(&t->wait_rw_avail_ops);
+	init_waitqueue_head(&t->wait_rw_credits);
 
 	spin_lock_init(&t->receive_credit_lock);
 	spin_lock_init(&t->recvmsg_queue_lock);
@@ -379,8 +387,6 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	spin_lock_init(&t->empty_recvmsg_queue_lock);
 	INIT_LIST_HEAD(&t->empty_recvmsg_queue);
 
-	init_waitqueue_head(&t->wait_send_payload_pending);
-	atomic_set(&t->send_payload_pending, 0);
 	init_waitqueue_head(&t->wait_send_pending);
 	atomic_set(&t->send_pending, 0);
 
@@ -410,8 +416,6 @@ static void free_transport(struct smb_direct_transport *t)
 	wake_up_interruptible(&t->wait_send_credits);
 
 	ksmbd_debug(RDMA, "wait for all send posted to IB to finish\n");
-	wait_event(t->wait_send_payload_pending,
-		   atomic_read(&t->send_payload_pending) == 0);
 	wait_event(t->wait_send_pending,
 		   atomic_read(&t->send_pending) == 0);
 
@@ -421,6 +425,7 @@ static void free_transport(struct smb_direct_transport *t)
 
 	if (t->qp) {
 		ib_drain_qp(t->qp);
+		ib_mr_pool_destroy(t->qp, &t->qp->rdma_mrs);
 		ib_destroy_qp(t->qp);
 	}
 
@@ -490,7 +495,7 @@ static int smb_direct_check_recvmsg(struct smb_direct_recvmsg *recvmsg)
 		struct smb_direct_data_transfer *req =
 			(struct smb_direct_data_transfer *)recvmsg->packet;
 		struct smb2_hdr *hdr = (struct smb2_hdr *)(recvmsg->packet
-				+ le32_to_cpu(req->data_offset) - 4);
+				+ le32_to_cpu(req->data_offset));
 		ksmbd_debug(RDMA,
 			    "CreditGranted: %u, CreditRequested: %u, DataLength: %u, RemainingDataLength: %u, SMB: %x, Command: %u\n",
 			    le16_to_cpu(req->credits_granted),
@@ -561,6 +566,8 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		}
 		t->negotiation_requested = true;
 		t->full_packet_received = true;
+		t->status = SMB_DIRECT_CS_CONNECTED;
+		enqueue_reassembly(t, recvmsg, 0);
 		wake_up_interruptible(&t->wait_status);
 		break;
 	case SMB_DIRECT_MSG_DATA_TRANSFER: {
@@ -864,13 +871,8 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 		smb_direct_disconnect_rdma_connection(t);
 	}
 
-	if (sendmsg->num_sge > 1) {
-		if (atomic_dec_and_test(&t->send_payload_pending))
-			wake_up(&t->wait_send_payload_pending);
-	} else {
-		if (atomic_dec_and_test(&t->send_pending))
-			wake_up(&t->wait_send_pending);
-	}
+	if (atomic_dec_and_test(&t->send_pending))
+		wake_up(&t->wait_send_pending);
 
 	/* iterate and free the list of messages in reverse. the list's head
 	 * is invalid.
@@ -902,21 +904,12 @@ static int smb_direct_post_send(struct smb_direct_transport *t,
 {
 	int ret;
 
-	if (wr->num_sge > 1)
-		atomic_inc(&t->send_payload_pending);
-	else
-		atomic_inc(&t->send_pending);
-
+	atomic_inc(&t->send_pending);
 	ret = ib_post_send(t->qp, wr, NULL);
 	if (ret) {
 		pr_err("failed to post send: %d\n", ret);
-		if (wr->num_sge > 1) {
-			if (atomic_dec_and_test(&t->send_payload_pending))
-				wake_up(&t->wait_send_payload_pending);
-		} else {
-			if (atomic_dec_and_test(&t->send_pending))
-				wake_up(&t->wait_send_pending);
-		}
+		if (atomic_dec_and_test(&t->send_pending))
+			wake_up(&t->wait_send_pending);
 		smb_direct_disconnect_rdma_connection(t);
 	}
 	return ret;
@@ -974,18 +967,19 @@ static int smb_direct_flush_send_list(struct smb_direct_transport *t,
 }
 
 static int wait_for_credits(struct smb_direct_transport *t,
-			    wait_queue_head_t *waitq, atomic_t *credits)
+			    wait_queue_head_t *waitq, atomic_t *total_credits,
+			    int needed)
 {
 	int ret;
 
 	do {
-		if (atomic_dec_return(credits) >= 0)
+		if (atomic_sub_return(needed, total_credits) >= 0)
 			return 0;
 
-		atomic_inc(credits);
+		atomic_add(needed, total_credits);
 		ret = wait_event_interruptible(*waitq,
-					       atomic_read(credits) > 0 ||
-						t->status != SMB_DIRECT_CS_CONNECTED);
+					       atomic_read(total_credits) >= needed ||
+					       t->status != SMB_DIRECT_CS_CONNECTED);
 
 		if (t->status != SMB_DIRECT_CS_CONNECTED)
 			return -ENOTCONN;
@@ -1006,7 +1000,19 @@ static int wait_for_send_credits(struct smb_direct_transport *t,
 			return ret;
 	}
 
-	return wait_for_credits(t, &t->wait_send_credits, &t->send_credits);
+	return wait_for_credits(t, &t->wait_send_credits, &t->send_credits, 1);
+}
+
+static int wait_for_rw_credits(struct smb_direct_transport *t, int credits)
+{
+	return wait_for_credits(t, &t->wait_rw_credits, &t->rw_credits, credits);
+}
+
+static int calc_rw_credits(struct smb_direct_transport *t,
+			   char *buf, unsigned int len)
+{
+	return DIV_ROUND_UP(get_buf_page_count(buf, len),
+			    t->pages_per_rw_credit);
 }
 
 static int smb_direct_create_header(struct smb_direct_transport *t,
@@ -1077,7 +1083,7 @@ static int get_sg_list(void *buf, int size, struct scatterlist *sg_list, int nen
 	int offset, len;
 	int i = 0;
 
-	if (nentries < get_buf_page_count(buf, size))
+	if (size <= 0 || nentries < get_buf_page_count(buf, size))
 		return -EINVAL;
 
 	offset = offset_in_page(buf);
@@ -1109,7 +1115,7 @@ static int get_mapped_sg_list(struct ib_device *device, void *buf, int size,
 	int npages;
 
 	npages = get_sg_list(buf, size, sg_list, nentries);
-	if (npages <= 0)
+	if (npages < 0)
 		return -EINVAL;
 	return ib_dma_map_sg(device, sg_list, npages, dir);
 }
@@ -1235,14 +1241,12 @@ static int smb_direct_writev(struct ksmbd_transport *t,
 
 	//FIXME: skip RFC1002 header..
 	buflen -= 4;
-	iov[0].iov_base += 4;
-	iov[0].iov_len -= 4;
 
 	remaining_data_length = buflen;
 	ksmbd_debug(RDMA, "Sending smb (RDMA): smb_len=%u\n", buflen);
 
 	smb_direct_send_ctx_init(st, &send_ctx, need_invalidate, remote_key);
-	start = i = 0;
+	start = i = 1;
 	buflen = 0;
 	while (true) {
 		buflen += iov[i].iov_len;
@@ -1304,11 +1308,21 @@ static int smb_direct_writev(struct ksmbd_transport *t,
 	 * that means all the I/Os have been out and we are good to return
 	 */
 
-	wait_event(st->wait_send_payload_pending,
-		   atomic_read(&st->send_payload_pending) == 0);
+	wait_event(st->wait_send_pending,
+		   atomic_read(&st->send_pending) == 0);
 	return ret;
 }
 
+static void smb_direct_free_rdma_rw_msg(struct smb_direct_transport *t,
+					struct smb_direct_rdma_rw_msg *msg,
+					enum dma_data_direction dir)
+{
+	rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
+			    msg->sgt.sgl, msg->sgt.nents, dir);
+	sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
+	kfree(msg);
+}
+
 static void read_write_done(struct ib_cq *cq, struct ib_wc *wc,
 			    enum dma_data_direction dir)
 {
@@ -1317,19 +1331,14 @@ static void read_write_done(struct ib_cq *cq, struct ib_wc *wc,
 	struct smb_direct_transport *t = msg->t;
 
 	if (wc->status != IB_WC_SUCCESS) {
+		msg->status = -EIO;
 		pr_err("read/write error. opcode = %d, status = %s(%d)\n",
 		       wc->opcode, ib_wc_status_msg(wc->status), wc->status);
-		smb_direct_disconnect_rdma_connection(t);
+		if (wc->status != IB_WC_WR_FLUSH_ERR)
+			smb_direct_disconnect_rdma_connection(t);
 	}
 
-	if (atomic_inc_return(&t->rw_avail_ops) > 0)
-		wake_up(&t->wait_rw_avail_ops);
-
-	rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
-			    msg->sg_list, msg->sgt.nents, dir);
-	sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
 	complete(msg->completion);
-	kfree(msg);
 }
 
 static void read_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -1342,94 +1351,152 @@ static void write_done(struct ib_cq *cq, struct ib_wc *wc)
 	read_write_done(cq, wc, DMA_TO_DEVICE);
 }
 
-static int smb_direct_rdma_xmit(struct smb_direct_transport *t, void *buf,
-				int buf_len, u32 remote_key, u64 remote_offset,
-				u32 remote_len, bool is_read)
+static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
+				void *buf, int buf_len,
+				struct smb2_buffer_desc_v1 *desc,
+				unsigned int desc_len,
+				bool is_read)
 {
-	struct smb_direct_rdma_rw_msg *msg;
-	int ret;
+	struct smb_direct_rdma_rw_msg *msg, *next_msg;
+	int i, ret;
 	DECLARE_COMPLETION_ONSTACK(completion);
-	struct ib_send_wr *first_wr = NULL;
+	struct ib_send_wr *first_wr;
+	LIST_HEAD(msg_list);
+	char *desc_buf;
+	int credits_needed;
+	unsigned int desc_buf_len, desc_num = 0;
+
+	if (t->status != SMB_DIRECT_CS_CONNECTED)
+		return -ENOTCONN;
+
+	if (buf_len > t->max_rdma_rw_size)
+		return -EINVAL;
+
+	/* calculate needed credits */
+	credits_needed = 0;
+	desc_buf = buf;
+	for (i = 0; i < desc_len / sizeof(*desc); i++) {
+		if (!buf_len)
+			break;
+
+		desc_buf_len = le32_to_cpu(desc[i].length);
+		if (!desc_buf_len)
+			return -EINVAL;
+
+		if (desc_buf_len > buf_len) {
+			desc_buf_len = buf_len;
+			desc[i].length = cpu_to_le32(desc_buf_len);
+			buf_len = 0;
+		}
+
+		credits_needed += calc_rw_credits(t, desc_buf, desc_buf_len);
+		desc_buf += desc_buf_len;
+		buf_len -= desc_buf_len;
+		desc_num++;
+	}
+
+	ksmbd_debug(RDMA, "RDMA %s, len %#x, needed credits %#x\n",
+		    is_read ? "read" : "write", buf_len, credits_needed);
 
-	ret = wait_for_credits(t, &t->wait_rw_avail_ops, &t->rw_avail_ops);
+	ret = wait_for_rw_credits(t, credits_needed);
 	if (ret < 0)
 		return ret;
 
-	/* TODO: mempool */
-	msg = kmalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
-		      sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
-	if (!msg) {
-		atomic_inc(&t->rw_avail_ops);
-		return -ENOMEM;
-	}
+	/* build rdma_rw_ctx for each descriptor */
+	desc_buf = buf;
+	for (i = 0; i < desc_num; i++) {
+		msg = kzalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
+			      sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
+		if (!msg) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
-	msg->sgt.sgl = &msg->sg_list[0];
-	ret = sg_alloc_table_chained(&msg->sgt,
-				     get_buf_page_count(buf, buf_len),
-				     msg->sg_list, SG_CHUNK_SIZE);
-	if (ret) {
-		atomic_inc(&t->rw_avail_ops);
-		kfree(msg);
-		return -ENOMEM;
-	}
+		desc_buf_len = le32_to_cpu(desc[i].length);
 
-	ret = get_sg_list(buf, buf_len, msg->sgt.sgl, msg->sgt.orig_nents);
-	if (ret <= 0) {
-		pr_err("failed to get pages\n");
-		goto err;
-	}
+		msg->t = t;
+		msg->cqe.done = is_read ? read_done : write_done;
+		msg->completion = &completion;
 
-	ret = rdma_rw_ctx_init(&msg->rw_ctx, t->qp, t->qp->port,
-			       msg->sg_list, get_buf_page_count(buf, buf_len),
-			       0, remote_offset, remote_key,
-			       is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	if (ret < 0) {
-		pr_err("failed to init rdma_rw_ctx: %d\n", ret);
-		goto err;
+		msg->sgt.sgl = &msg->sg_list[0];
+		ret = sg_alloc_table_chained(&msg->sgt,
+					     get_buf_page_count(desc_buf, desc_buf_len),
+					     msg->sg_list, SG_CHUNK_SIZE);
+		if (ret) {
+			kfree(msg);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = get_sg_list(desc_buf, desc_buf_len,
+				  msg->sgt.sgl, msg->sgt.orig_nents);
+		if (ret < 0) {
+			sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
+			kfree(msg);
+			goto out;
+		}
+
+		ret = rdma_rw_ctx_init(&msg->rw_ctx, t->qp, t->qp->port,
+				       msg->sgt.sgl,
+				       get_buf_page_count(desc_buf, desc_buf_len),
+				       0,
+				       le64_to_cpu(desc[i].offset),
+				       le32_to_cpu(desc[i].token),
+				       is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		if (ret < 0) {
+			pr_err("failed to init rdma_rw_ctx: %d\n", ret);
+			sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
+			kfree(msg);
+			goto out;
+		}
+
+		list_add_tail(&msg->list, &msg_list);
+		desc_buf += desc_buf_len;
 	}
 
-	msg->t = t;
-	msg->cqe.done = is_read ? read_done : write_done;
-	msg->completion = &completion;
-	first_wr = rdma_rw_ctx_wrs(&msg->rw_ctx, t->qp, t->qp->port,
-				   &msg->cqe, NULL);
+	/* concatenate work requests of rdma_rw_ctxs */
+	first_wr = NULL;
+	list_for_each_entry_reverse(msg, &msg_list, list) {
+		first_wr = rdma_rw_ctx_wrs(&msg->rw_ctx, t->qp, t->qp->port,
+					   &msg->cqe, first_wr);
+	}
 
 	ret = ib_post_send(t->qp, first_wr, NULL);
 	if (ret) {
-		pr_err("failed to post send wr: %d\n", ret);
-		goto err;
+		pr_err("failed to post send wr for RDMA R/W: %d\n", ret);
+		goto out;
 	}
 
+	msg = list_last_entry(&msg_list, struct smb_direct_rdma_rw_msg, list);
 	wait_for_completion(&completion);
-	return 0;
-
-err:
-	atomic_inc(&t->rw_avail_ops);
-	if (first_wr)
-		rdma_rw_ctx_destroy(&msg->rw_ctx, t->qp, t->qp->port,
-				    msg->sg_list, msg->sgt.nents,
-				    is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);
-	kfree(msg);
+	ret = msg->status;
+out:
+	list_for_each_entry_safe(msg, next_msg, &msg_list, list) {
+		list_del(&msg->list);
+		smb_direct_free_rdma_rw_msg(t, msg,
+					    is_read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	}
+	atomic_add(credits_needed, &t->rw_credits);
+	wake_up(&t->wait_rw_credits);
 	return ret;
 }
 
-static int smb_direct_rdma_write(struct ksmbd_transport *t, void *buf,
-				 unsigned int buflen, u32 remote_key,
-				 u64 remote_offset, u32 remote_len)
+static int smb_direct_rdma_write(struct ksmbd_transport *t,
+				 void *buf, unsigned int buflen,
+				 struct smb2_buffer_desc_v1 *desc,
+				 unsigned int desc_len)
 {
 	return smb_direct_rdma_xmit(smb_trans_direct_transfort(t), buf, buflen,
-				    remote_key, remote_offset,
-				    remote_len, false);
+				    desc, desc_len, false);
 }
 
-static int smb_direct_rdma_read(struct ksmbd_transport *t, void *buf,
-				unsigned int buflen, u32 remote_key,
-				u64 remote_offset, u32 remote_len)
+static int smb_direct_rdma_read(struct ksmbd_transport *t,
+				void *buf, unsigned int buflen,
+				struct smb2_buffer_desc_v1 *desc,
+				unsigned int desc_len)
 {
 	return smb_direct_rdma_xmit(smb_trans_direct_transfort(t), buf, buflen,
-				    remote_key, remote_offset,
-				    remote_len, true);
+				    desc, desc_len, true);
 }
 
 static void smb_direct_disconnect(struct ksmbd_transport *t)
@@ -1444,6 +1511,15 @@ static void smb_direct_disconnect(struct ksmbd_transport *t)
 	free_transport(st);
 }
 
+static void smb_direct_shutdown(struct ksmbd_transport *t)
+{
+	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
+
+	ksmbd_debug(RDMA, "smb-direct shutdown cm_id=%p\n", st->cm_id);
+
+	smb_direct_disconnect_rdma_work(&st->disconnect_work);
+}
+
 static int smb_direct_cm_handler(struct rdma_cm_id *cm_id,
 				 struct rdma_cm_event *event)
 {
@@ -1460,6 +1536,8 @@ static int smb_direct_cm_handler(struct rdma_cm_id *cm_id,
 	}
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 	case RDMA_CM_EVENT_DISCONNECTED: {
+		ib_drain_qp(t->qp);
+
 		t->status = SMB_DIRECT_CS_DISCONNECTED;
 		wake_up_interruptible(&t->wait_status);
 		wake_up_interruptible(&t->wait_reassembly_queue);
@@ -1587,19 +1665,13 @@ static int smb_direct_accept_client(struct smb_direct_transport *t)
 		pr_err("error at rdma_accept: %d\n", ret);
 		return ret;
 	}
-
-	wait_event_interruptible(t->wait_status,
-				 t->status != SMB_DIRECT_CS_NEW);
-	if (t->status != SMB_DIRECT_CS_CONNECTED)
-		return -ENOTCONN;
 	return 0;
 }
 
-static int smb_direct_negotiate(struct smb_direct_transport *t)
+static int smb_direct_prepare_negotiation(struct smb_direct_transport *t)
 {
 	int ret;
 	struct smb_direct_recvmsg *recvmsg;
-	struct smb_direct_negotiate_req *req;
 
 	recvmsg = get_free_recvmsg(t);
 	if (!recvmsg)
@@ -1609,82 +1681,74 @@ static int smb_direct_negotiate(struct smb_direct_transport *t)
 	ret = smb_direct_post_recv(t, recvmsg);
 	if (ret) {
 		pr_err("Can't post recv: %d\n", ret);
-		goto out;
+		goto out_err;
 	}
 
 	t->negotiation_requested = false;
 	ret = smb_direct_accept_client(t);
 	if (ret) {
 		pr_err("Can't accept client\n");
-		goto out;
+		goto out_err;
 	}
 
 	smb_direct_post_recv_credits(&t->post_recv_credits_work.work);
-
-	ksmbd_debug(RDMA, "Waiting for SMB_DIRECT negotiate request\n");
-	ret = wait_event_interruptible_timeout(t->wait_status,
-					       t->negotiation_requested ||
-						t->status == SMB_DIRECT_CS_DISCONNECTED,
-					       SMB_DIRECT_NEGOTIATE_TIMEOUT * HZ);
-	if (ret <= 0 || t->status == SMB_DIRECT_CS_DISCONNECTED) {
-		ret = ret < 0 ? ret : -ETIMEDOUT;
-		goto out;
-	}
-
-	ret = smb_direct_check_recvmsg(recvmsg);
-	if (ret == -ECONNABORTED)
-		goto out;
-
-	req = (struct smb_direct_negotiate_req *)recvmsg->packet;
-	t->max_recv_size = min_t(int, t->max_recv_size,
-				 le32_to_cpu(req->preferred_send_size));
-	t->max_send_size = min_t(int, t->max_send_size,
-				 le32_to_cpu(req->max_receive_size));
-	t->max_fragmented_send_size =
-			le32_to_cpu(req->max_fragmented_size);
-
-	ret = smb_direct_send_negotiate_response(t, ret);
-out:
-	if (recvmsg)
-		put_recvmsg(t, recvmsg);
+	return 0;
+out_err:
+	put_recvmsg(t, recvmsg);
 	return ret;
 }
 
+static unsigned int smb_direct_get_max_fr_pages(struct smb_direct_transport *t)
+{
+	return min_t(unsigned int,
+		     t->cm_id->device->attrs.max_fast_reg_page_list_len,
+		     256);
+}
+
 static int smb_direct_init_params(struct smb_direct_transport *t,
 				  struct ib_qp_cap *cap)
 {
 	struct ib_device *device = t->cm_id->device;
-	int max_send_sges, max_pages, max_rw_wrs, max_send_wrs;
+	int max_send_sges, max_rw_wrs, max_send_wrs;
+	unsigned int max_sge_per_wr, wrs_per_credit;
 
-	/* need 2 more sge. because a SMB_DIRECT header will be mapped,
-	 * and maybe a send buffer could be not page aligned.
+	/* need 3 more sge. because a SMB_DIRECT header, SMB2 header,
+	 * SMB2 response could be mapped.
 	 */
 	t->max_send_size = smb_direct_max_send_size;
-	max_send_sges = DIV_ROUND_UP(t->max_send_size, PAGE_SIZE) + 2;
+	max_send_sges = DIV_ROUND_UP(t->max_send_size, PAGE_SIZE) + 3;
 	if (max_send_sges > SMB_DIRECT_MAX_SEND_SGES) {
 		pr_err("max_send_size %d is too large\n", t->max_send_size);
 		return -EINVAL;
 	}
 
-	/*
-	 * allow smb_direct_max_outstanding_rw_ops of in-flight RDMA
-	 * read/writes. HCA guarantees at least max_send_sge of sges for
-	 * a RDMA read/write work request, and if memory registration is used,
-	 * we need reg_mr, local_inv wrs for each read/write.
+	/* Calculate the number of work requests for RDMA R/W.
+	 * The maximum number of pages which can be registered
+	 * with one Memory region can be transferred with one
+	 * R/W credit. And at least 4 work requests for each credit
+	 * are needed for MR registration, RDMA R/W, local & remote
+	 * MR invalidation.
 	 */
 	t->max_rdma_rw_size = smb_direct_max_read_write_size;
-	max_pages = DIV_ROUND_UP(t->max_rdma_rw_size, PAGE_SIZE) + 1;
-	max_rw_wrs = DIV_ROUND_UP(max_pages, SMB_DIRECT_MAX_SEND_SGES);
-	max_rw_wrs += rdma_rw_mr_factor(device, t->cm_id->port_num,
-			max_pages) * 2;
-	max_rw_wrs *= smb_direct_max_outstanding_rw_ops;
+	t->pages_per_rw_credit = smb_direct_get_max_fr_pages(t);
+	t->max_rw_credits = DIV_ROUND_UP(t->max_rdma_rw_size,
+					 (t->pages_per_rw_credit - 1) *
+					 PAGE_SIZE);
+
+	max_sge_per_wr = min_t(unsigned int, device->attrs.max_send_sge,
+			       device->attrs.max_sge_rd);
+	max_sge_per_wr = max_t(unsigned int, max_sge_per_wr,
+			       max_send_sges);
+	wrs_per_credit = max_t(unsigned int, 4,
+			       DIV_ROUND_UP(t->pages_per_rw_credit,
+					    max_sge_per_wr) + 1);
+	max_rw_wrs = t->max_rw_credits * wrs_per_credit;
 
 	max_send_wrs = smb_direct_send_credit_target + max_rw_wrs;
 	if (max_send_wrs > device->attrs.max_cqe ||
 	    max_send_wrs > device->attrs.max_qp_wr) {
-		pr_err("consider lowering send_credit_target = %d, or max_outstanding_rw_ops = %d\n",
-		       smb_direct_send_credit_target,
-		       smb_direct_max_outstanding_rw_ops);
+		pr_err("consider lowering send_credit_target = %d\n",
+		       smb_direct_send_credit_target);
 		pr_err("Possible CQE overrun, device reporting max_cqe %d max_qp_wr %d\n",
 		       device->attrs.max_cqe, device->attrs.max_qp_wr);
 		return -EINVAL;
@@ -1699,11 +1763,6 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
 		return -EINVAL;
 	}
 
-	if (device->attrs.max_send_sge < SMB_DIRECT_MAX_SEND_SGES) {
-		pr_err("warning: device max_send_sge = %d too small\n",
-		       device->attrs.max_send_sge);
-		return -EINVAL;
-	}
 	if (device->attrs.max_recv_sge < SMB_DIRECT_MAX_RECV_SGES) {
 		pr_err("warning: device max_recv_sge = %d too small\n",
 		       device->attrs.max_recv_sge);
@@ -1719,7 +1778,7 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
 
 	t->send_credit_target = smb_direct_send_credit_target;
 	atomic_set(&t->send_credits, 0);
-	atomic_set(&t->rw_avail_ops, smb_direct_max_outstanding_rw_ops);
+	atomic_set(&t->rw_credits, t->max_rw_credits);
 
 	t->max_send_size = smb_direct_max_send_size;
 	t->max_recv_size = smb_direct_max_receive_size;
@@ -1727,10 +1786,10 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
 
 	cap->max_send_wr = max_send_wrs;
 	cap->max_recv_wr = t->recv_credit_max;
-	cap->max_send_sge = SMB_DIRECT_MAX_SEND_SGES;
+	cap->max_send_sge = max_sge_per_wr;
 	cap->max_recv_sge = SMB_DIRECT_MAX_RECV_SGES;
 	cap->max_inline_data = 0;
-	cap->max_rdma_ctxs = 0;
+	cap->max_rdma_ctxs = t->max_rw_credits;
 	return 0;
 }
 
@@ -1812,6 +1871,7 @@ static int smb_direct_create_qpair(struct smb_direct_transport *t,
 {
 	int ret;
 	struct ib_qp_init_attr qp_attr;
+	int pages_per_rw;
 
 	t->pd = ib_alloc_pd(t->cm_id->device, 0);
 	if (IS_ERR(t->pd)) {
@@ -1822,7 +1882,8 @@ static int smb_direct_create_qpair(struct smb_direct_transport *t,
 	}
 
 	t->send_cq = ib_alloc_cq(t->cm_id->device, t,
-				 t->send_credit_target, 0, IB_POLL_WORKQUEUE);
+				 smb_direct_send_credit_target + cap->max_rdma_ctxs,
+				 0, IB_POLL_WORKQUEUE);
 	if (IS_ERR(t->send_cq)) {
 		pr_err("Can't create RDMA send CQ\n");
 		ret = PTR_ERR(t->send_cq);
@@ -1831,8 +1892,7 @@ static int smb_direct_create_qpair(struct smb_direct_transport *t,
 	}
 
 	t->recv_cq = ib_alloc_cq(t->cm_id->device, t,
-				 cap->max_send_wr + cap->max_rdma_ctxs,
-				 0, IB_POLL_WORKQUEUE);
+				 t->recv_credit_max, 0, IB_POLL_WORKQUEUE);
 	if (IS_ERR(t->recv_cq)) {
 		pr_err("Can't create RDMA recv CQ\n");
 		ret = PTR_ERR(t->recv_cq);
@@ -1859,6 +1919,18 @@ static int smb_direct_create_qpair(struct smb_direct_transport *t,
 	t->qp = t->cm_id->qp;
 	t->cm_id->event_handler = smb_direct_cm_handler;
 
+	pages_per_rw = DIV_ROUND_UP(t->max_rdma_rw_size, PAGE_SIZE) + 1;
+	if (pages_per_rw > t->cm_id->device->attrs.max_sgl_rd) {
+		ret = ib_mr_pool_init(t->qp, &t->qp->rdma_mrs,
+				      t->max_rw_credits, IB_MR_TYPE_MEM_REG,
+				      t->pages_per_rw_credit, 0);
+		if (ret) {
+			pr_err("failed to init mr pool count %d pages %d\n",
+			       t->max_rw_credits, t->pages_per_rw_credit);
+			goto err;
+		}
+	}
+
 	return 0;
 err:
 	if (t->qp) {
@@ -1883,6 +1955,49 @@ static int smb_direct_create_qpair(struct smb_direct_transport *t,
 static int smb_direct_prepare(struct ksmbd_transport *t)
 {
 	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
+	struct smb_direct_recvmsg *recvmsg;
+	struct smb_direct_negotiate_req *req;
+	int ret;
+
+	ksmbd_debug(RDMA, "Waiting for SMB_DIRECT negotiate request\n");
+	ret = wait_event_interruptible_timeout(st->wait_status,
+					       st->negotiation_requested ||
+					       st->status == SMB_DIRECT_CS_DISCONNECTED,
+					       SMB_DIRECT_NEGOTIATE_TIMEOUT * HZ);
+	if (ret <= 0 || st->status == SMB_DIRECT_CS_DISCONNECTED)
+		return ret < 0 ? ret : -ETIMEDOUT;
+
+	recvmsg = get_first_reassembly(st);
+	if (!recvmsg)
+		return -ECONNABORTED;
+
+	ret = smb_direct_check_recvmsg(recvmsg);
+	if (ret == -ECONNABORTED)
+		goto out;
+
+	req = (struct smb_direct_negotiate_req *)recvmsg->packet;
+	st->max_recv_size = min_t(int, st->max_recv_size,
+				  le32_to_cpu(req->preferred_send_size));
+	st->max_send_size = min_t(int, st->max_send_size,
+				  le32_to_cpu(req->max_receive_size));
+	st->max_fragmented_send_size =
+		le32_to_cpu(req->max_fragmented_size);
+	st->max_fragmented_recv_size =
+		(st->recv_credit_max * st->max_recv_size) / 2;
+
+	ret = smb_direct_send_negotiate_response(st, ret);
+out:
+	spin_lock_irq(&st->reassembly_queue_lock);
+	st->reassembly_queue_length--;
+	list_del(&recvmsg->list);
+	spin_unlock_irq(&st->reassembly_queue_lock);
+	put_recvmsg(st, recvmsg);
+
+	return ret;
+}
+
+static int smb_direct_connect(struct smb_direct_transport *st)
+{
 	int ret;
 	struct ib_qp_cap qp_cap;
 
@@ -1904,13 +2019,11 @@ static int smb_direct_prepare(struct ksmbd_transport *t)
 		return ret;
 	}
 
-	ret = smb_direct_negotiate(st);
+	ret = smb_direct_prepare_negotiation(st);
 	if (ret) {
 		pr_err("Can't negotiate: %d\n", ret);
 		return ret;
 	}
-
-	st->status = SMB_DIRECT_CS_CONNECTED;
 	return 0;
 }
 
@@ -1926,6 +2039,7 @@ static bool rdma_frwr_is_supported(struct ib_device_attr *attrs)
 static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 {
 	struct smb_direct_transport *t;
+	int ret;
 
 	if (!rdma_frwr_is_supported(&new_cm_id->device->attrs)) {
 		ksmbd_debug(RDMA,
@@ -1938,18 +2052,23 @@ static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 	if (!t)
 		return -ENOMEM;
 
+	ret = smb_direct_connect(t);
+	if (ret)
+		goto out_err;
+
 	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
 					      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
-					      SMB_DIRECT_PORT);
+					      smb_direct_port);
 	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
-		int ret = PTR_ERR(KSMBD_TRANS(t)->handler);
-
+		ret = PTR_ERR(KSMBD_TRANS(t)->handler);
 		pr_err("Can't start thread\n");
-		free_transport(t);
-		return ret;
+		goto out_err;
 	}
 
 	return 0;
+out_err:
+	free_transport(t);
+	return ret;
 }
 
 static int smb_direct_listen_handler(struct rdma_cm_id *cm_id,
@@ -2013,12 +2132,64 @@ static int smb_direct_listen(int port)
 	return ret;
 }
 
+static int smb_direct_ib_client_add(struct ib_device *ib_dev)
+{
+	struct smb_direct_device *smb_dev;
+
+	/* Set 5445 port if device type is iWARP(No IB) */
+	if (ib_dev->node_type != RDMA_NODE_IB_CA)
+		smb_direct_port = SMB_DIRECT_PORT_IWARP;
+
+	if (!rdma_frwr_is_supported(&ib_dev->attrs))
+		return 0;
+
+	smb_dev = kzalloc(sizeof(*smb_dev), GFP_KERNEL);
+	if (!smb_dev)
+		return -ENOMEM;
+	smb_dev->ib_dev = ib_dev;
+
+	write_lock(&smb_direct_device_lock);
+	list_add(&smb_dev->list, &smb_direct_device_list);
+	write_unlock(&smb_direct_device_lock);
+
+	ksmbd_debug(RDMA, "ib device added: name %s\n", ib_dev->name);
+	return 0;
+}
+
+static void smb_direct_ib_client_remove(struct ib_device *ib_dev,
+					void *client_data)
+{
+	struct smb_direct_device *smb_dev, *tmp;
+
+	write_lock(&smb_direct_device_lock);
+	list_for_each_entry_safe(smb_dev, tmp, &smb_direct_device_list, list) {
+		if (smb_dev->ib_dev == ib_dev) {
+			list_del(&smb_dev->list);
+			kfree(smb_dev);
+			break;
+		}
+	}
+	write_unlock(&smb_direct_device_lock);
+}
+
+static struct ib_client smb_direct_ib_client = {
+	.name	= "ksmbd_smb_direct_ib",
+	.add	= smb_direct_ib_client_add,
+	.remove	= smb_direct_ib_client_remove,
+};
+
 int ksmbd_rdma_init(void)
 {
 	int ret;
 
 	smb_direct_listener.cm_id = NULL;
 
+	ret = ib_register_client(&smb_direct_ib_client);
+	if (ret) {
+		pr_err("failed to ib_register_client\n");
+		return ret;
+	}
+
 	/* When a client is running out of send credits, the credits are
 	 * granted by the server's sending a packet using this queue.
 	 * This avoids the situation that a clients cannot send packets
@@ -2029,7 +2200,7 @@ int ksmbd_rdma_init(void)
 	if (!smb_direct_wq)
 		return -ENOMEM;
 
-	ret = smb_direct_listen(SMB_DIRECT_PORT);
+	ret = smb_direct_listen(smb_direct_port);
 	if (ret) {
 		destroy_workqueue(smb_direct_wq);
 		smb_direct_wq = NULL;
@@ -2042,37 +2213,88 @@ int ksmbd_rdma_init(void)
 	return 0;
 }
 
-int ksmbd_rdma_destroy(void)
+void ksmbd_rdma_destroy(void)
 {
-	if (smb_direct_listener.cm_id)
-		rdma_destroy_id(smb_direct_listener.cm_id);
+	if (!smb_direct_listener.cm_id)
+		return;
+
+	ib_unregister_client(&smb_direct_ib_client);
+	rdma_destroy_id(smb_direct_listener.cm_id);
+
 	smb_direct_listener.cm_id = NULL;
 
 	if (smb_direct_wq) {
-		flush_workqueue(smb_direct_wq);
 		destroy_workqueue(smb_direct_wq);
 		smb_direct_wq = NULL;
 	}
-	return 0;
 }
 
 bool ksmbd_rdma_capable_netdev(struct net_device *netdev)
 {
-	struct ib_device *ibdev;
+	struct smb_direct_device *smb_dev;
+	int i;
 	bool rdma_capable = false;
 
-	ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_UNKNOWN);
-	if (ibdev) {
-		if (rdma_frwr_is_supported(&ibdev->attrs))
-			rdma_capable = true;
-		ib_device_put(ibdev);
+	read_lock(&smb_direct_device_lock);
+	list_for_each_entry(smb_dev, &smb_direct_device_list, list) {
+		for (i = 0; i < smb_dev->ib_dev->phys_port_cnt; i++) {
+			struct net_device *ndev;
+
+			if (smb_dev->ib_dev->ops.get_netdev) {
+				ndev = smb_dev->ib_dev->ops.get_netdev(
+					smb_dev->ib_dev, i + 1);
+				if (!ndev)
+					continue;
+
+				if (ndev == netdev) {
+					dev_put(ndev);
+					rdma_capable = true;
+					goto out;
+				}
+				dev_put(ndev);
+			/* if ib_dev does not implement ops.get_netdev
+			 * check for matching infiniband GUID in hw_addr
+			 */
+			} else if (netdev->type == ARPHRD_INFINIBAND) {
+				struct netdev_hw_addr *ha;
+				union ib_gid gid;
+				u32 port_num;
+				int ret;
+
+				netdev_hw_addr_list_for_each(
+					ha, &netdev->dev_addrs) {
+					memcpy(&gid, ha->addr + 4, sizeof(gid));
+					ret = ib_find_gid(smb_dev->ib_dev, &gid,
+							  &port_num, NULL);
+					if (!ret) {
+						rdma_capable = true;
+						goto out;
+					}
+				}
+			}
+		}
 	}
+out:
+	read_unlock(&smb_direct_device_lock);
+
+	if (rdma_capable == false) {
+		struct ib_device *ibdev;
+
+		ibdev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_UNKNOWN);
+		if (ibdev) {
+			if (rdma_frwr_is_supported(&ibdev->attrs))
+				rdma_capable = true;
+			ib_device_put(ibdev);
+		}
+	}
+
 	return rdma_capable;
 }
 
 static struct ksmbd_transport_ops ksmbd_smb_direct_transport_ops = {
 	.prepare	= smb_direct_prepare,
 	.disconnect	= smb_direct_disconnect,
+	.shutdown	= smb_direct_shutdown,
 	.writev		= smb_direct_writev,
 	.read		= smb_direct_read,
 	.rdma_read	= smb_direct_rdma_read,
diff --git a/fs/ksmbd/transport_rdma.h b/fs/ksmbd/transport_rdma.h
index 04a7a37685c3..77aee4e5c9dc 100644
--- a/fs/ksmbd/transport_rdma.h
+++ b/fs/ksmbd/transport_rdma.h
@@ -7,8 +7,6 @@
 #ifndef __KSMBD_TRANSPORT_RDMA_H__
 #define __KSMBD_TRANSPORT_RDMA_H__
 
-#define SMB_DIRECT_PORT	5445
-
 #define SMBD_DEFAULT_IOSIZE (8 * 1024 * 1024)
 #define SMBD_MIN_IOSIZE (512 * 1024)
 #define SMBD_MAX_IOSIZE (16 * 1024 * 1024)
@@ -56,14 +54,16 @@ struct smb_direct_data_transfer {
 
 #ifdef CONFIG_SMB_SERVER_SMBDIRECT
 int ksmbd_rdma_init(void);
-int ksmbd_rdma_destroy(void);
+void ksmbd_rdma_destroy(void);
 bool ksmbd_rdma_capable_netdev(struct net_device *netdev);
 void init_smbd_max_io_size(unsigned int sz);
+unsigned int get_smbd_max_read_write_size(void);
 #else
 static inline int ksmbd_rdma_init(void) { return 0; }
 static inline int ksmbd_rdma_destroy(void) { return 0; }
 static inline bool ksmbd_rdma_capable_netdev(struct net_device *netdev) { return false; }
 static inline void init_smbd_max_io_size(unsigned int sz) { }
+static inline unsigned int get_smbd_max_read_write_size(void) { return 0; }
 #endif
 
 #endif /* __KSMBD_TRANSPORT_RDMA_H__ */
diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index d1d7954368a5..eff7a1d793f0 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -333,7 +333,7 @@ static int ksmbd_tcp_readv(struct tcp_transport *t, struct kvec *iov_orig,
 		if (length == -EINTR) {
 			total_read = -ESHUTDOWN;
 			break;
-		} else if (conn->status == KSMBD_SESS_NEED_RECONNECT) {
+		} else if (ksmbd_conn_need_reconnect(conn)) {
 			total_read = -EAGAIN;
 			break;
 		} else if (length == -ERESTARTSYS || length == -EAGAIN) {
@@ -428,7 +428,8 @@ static int create_socket(struct interface *iface)
 
 	ret = sock_create(PF_INET6, SOCK_STREAM, IPPROTO_TCP, &ksmbd_socket);
 	if (ret) {
-		pr_err("Can't create socket for ipv6, try ipv4: %d\n", ret);
+		if (ret != -EAFNOSUPPORT)
+			pr_err("Can't create socket for ipv6, fallback to ipv4: %d\n", ret);
 		ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP,
 				  &ksmbd_socket);
 		if (ret) {
@@ -505,7 +506,7 @@ static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 
 	switch (event) {
 	case NETDEV_UP:
-		if (netdev->priv_flags & IFF_BRIDGE_PORT)
+		if (netif_is_bridge_port(netdev))
 			return NOTIFY_OK;
 
 		list_for_each_entry(iface, &iface_list, entry) {
@@ -614,7 +615,7 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 
 		rtnl_lock();
 		for_each_netdev(&init_net, netdev) {
-			if (netdev->priv_flags & IFF_BRIDGE_PORT)
+			if (netif_is_bridge_port(netdev))
 				continue;
 			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL)))
 				return -ENOMEM;
diff --git a/fs/ksmbd/unicode.c b/fs/ksmbd/unicode.c
index a0db699ddafd..33fc6d45c0f3 100644
--- a/fs/ksmbd/unicode.c
+++ b/fs/ksmbd/unicode.c
@@ -14,46 +14,10 @@
 #include "uniupr.h"
 #include "smb_common.h"
 
-/*
- * smb_utf16_bytes() - how long will a string be after conversion?
- * @from:	pointer to input string
- * @maxbytes:	don't go past this many bytes of input string
- * @codepage:	destination codepage
- *
- * Walk a utf16le string and return the number of bytes that the string will
- * be after being converted to the given charset, not including any null
- * termination required. Don't walk past maxbytes in the source buffer.
- *
- * Return:	string length after conversion
- */
-static int smb_utf16_bytes(const __le16 *from, int maxbytes,
-			   const struct nls_table *codepage)
-{
-	int i;
-	int charlen, outlen = 0;
-	int maxwords = maxbytes / 2;
-	char tmp[NLS_MAX_CHARSET_SIZE];
-	__u16 ftmp;
-
-	for (i = 0; i < maxwords; i++) {
-		ftmp = get_unaligned_le16(&from[i]);
-		if (ftmp == 0)
-			break;
-
-		charlen = codepage->uni2char(ftmp, tmp, NLS_MAX_CHARSET_SIZE);
-		if (charlen > 0)
-			outlen += charlen;
-		else
-			outlen++;
-	}
-
-	return outlen;
-}
-
 /*
  * cifs_mapchar() - convert a host-endian char to proper char in codepage
  * @target:	where converted character should be copied
- * @src_char:	2 byte host-endian source character
+ * @from:	host-endian source string
  * @cp:		codepage to which character should be converted
  * @mapchar:	should character be mapped according to mapchars mount option?
  *
@@ -64,10 +28,13 @@ static int smb_utf16_bytes(const __le16 *from, int maxbytes,
  * Return:	string length after conversion
  */
 static int
-cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
+cifs_mapchar(char *target, const __u16 *from, const struct nls_table *cp,
 	     bool mapchar)
 {
 	int len = 1;
+	__u16 src_char;
+
+	src_char = *from;
 
 	if (!mapchar)
 		goto cp_convert;
@@ -105,30 +72,66 @@ cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
 
 cp_convert:
 	len = cp->uni2char(src_char, target, NLS_MAX_CHARSET_SIZE);
-	if (len <= 0) {
-		*target = '?';
-		len = 1;
-	}
+	if (len <= 0)
+		goto surrogate_pair;
+
+	goto out;
+
+surrogate_pair:
+	/* convert SURROGATE_PAIR and IVS */
+	if (strcmp(cp->charset, "utf8"))
+		goto unknown;
+	len = utf16s_to_utf8s(from, 3, UTF16_LITTLE_ENDIAN, target, 6);
+	if (len <= 0)
+		goto unknown;
+	return len;
 
+unknown:
+	*target = '?';
+	len = 1;
 	goto out;
 }
 
 /*
- * is_char_allowed() - check for valid character
- * @ch:		input character to be checked
+ * smb_utf16_bytes() - compute converted string length
+ * @from:	pointer to input string
+ * @maxbytes:	input string length
+ * @codepage:	destination codepage
+ *
+ * Walk a utf16le string and return the number of bytes that the string will
+ * be after being converted to the given charset, not including any null
+ * termination required. Don't walk past maxbytes in the source buffer.
  *
- * Return:	1 if char is allowed, otherwise 0
+ * Return:	string length after conversion
  */
-static inline int is_char_allowed(char *ch)
+static int smb_utf16_bytes(const __le16 *from, int maxbytes,
+			   const struct nls_table *codepage)
 {
-	/* check for control chars, wildcards etc. */
-	if (!(*ch & 0x80) &&
-	    (*ch <= 0x1f ||
-	     *ch == '?' || *ch == '"' || *ch == '<' ||
-	     *ch == '>' || *ch == '|'))
-		return 0;
-
-	return 1;
+	int i, j;
+	int charlen, outlen = 0;
+	int maxwords = maxbytes / 2;
+	char tmp[NLS_MAX_CHARSET_SIZE];
+	__u16 ftmp[3];
+
+	for (i = 0; i < maxwords; i++) {
+		ftmp[0] = get_unaligned_le16(&from[i]);
+		if (ftmp[0] == 0)
+			break;
+		for (j = 1; j <= 2; j++) {
+			if (i + j < maxwords)
+				ftmp[j] = get_unaligned_le16(&from[i + j]);
+			else
+				ftmp[j] = 0;
+		}
+
+		charlen = cifs_mapchar(tmp, ftmp, codepage, 0);
+		if (charlen > 0)
+			outlen += charlen;
+		else
+			outlen++;
+	}
+
+	return outlen;
 }
 
 /*
@@ -158,12 +161,12 @@ static inline int is_char_allowed(char *ch)
 static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 			  const struct nls_table *codepage, bool mapchar)
 {
-	int i, charlen, safelen;
+	int i, j, charlen, safelen;
 	int outlen = 0;
 	int nullsize = nls_nullsize(codepage);
 	int fromwords = fromlen / 2;
 	char tmp[NLS_MAX_CHARSET_SIZE];
-	__u16 ftmp;
+	__u16 ftmp[3];	/* ftmp[3] = 3array x 2bytes = 6bytes UTF-16 */
 
 	/*
 	 * because the chars can be of varying widths, we need to take care
@@ -174,9 +177,15 @@ static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 	safelen = tolen - (NLS_MAX_CHARSET_SIZE + nullsize);
 
 	for (i = 0; i < fromwords; i++) {
-		ftmp = get_unaligned_le16(&from[i]);
-		if (ftmp == 0)
+		ftmp[0] = get_unaligned_le16(&from[i]);
+		if (ftmp[0] == 0)
 			break;
+		for (j = 1; j <= 2; j++) {
+			if (i + j < fromwords)
+				ftmp[j] = get_unaligned_le16(&from[i + j]);
+			else
+				ftmp[j] = 0;
+		}
 
 		/*
 		 * check to see if converting this character might make the
@@ -191,6 +200,19 @@ static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 		/* put converted char into 'to' buffer */
 		charlen = cifs_mapchar(&to[outlen], ftmp, codepage, mapchar);
 		outlen += charlen;
+
+		/*
+		 * charlen (=bytes of UTF-8 for 1 character)
+		 * 4bytes UTF-8(surrogate pair) is charlen=4
+		 * (4bytes UTF-16 code)
+		 * 7-8bytes UTF-8(IVS) is charlen=3+4 or 4+4
+		 * (2 UTF-8 pairs divided to 2 UTF-16 pairs)
+		 */
+		if (charlen == 4)
+			i++;
+		else if (charlen >= 5)
+			/* 5-6bytes UTF-8 */
+			i += 2;
 	}
 
 	/* properly null-terminate string */
@@ -325,6 +347,9 @@ int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
 	char src_char;
 	__le16 dst_char;
 	wchar_t tmp;
+	wchar_t wchar_to[6];	/* UTF-16 */
+	int ret;
+	unicode_t u;
 
 	if (!mapchars)
 		return smb_strtoUTF16(target, source, srclen, cp);
@@ -367,11 +392,57 @@ int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
 			 * if no match, use question mark, which at least in
 			 * some cases serves as wild card
 			 */
-			if (charlen < 1) {
-				dst_char = cpu_to_le16(0x003f);
-				charlen = 1;
+			if (charlen > 0)
+				goto ctoUTF16;
+
+			/* convert SURROGATE_PAIR */
+			if (strcmp(cp->charset, "utf8"))
+				goto unknown;
+			if (*(source + i) & 0x80) {
+				charlen = utf8_to_utf32(source + i, 6, &u);
+				if (charlen < 0)
+					goto unknown;
+			} else
+				goto unknown;
+			ret  = utf8s_to_utf16s(source + i, charlen,
+					UTF16_LITTLE_ENDIAN,
+					wchar_to, 6);
+			if (ret < 0)
+				goto unknown;
+
+			i += charlen;
+			dst_char = cpu_to_le16(*wchar_to);
+			if (charlen <= 3)
+				/* 1-3bytes UTF-8 to 2bytes UTF-16 */
+				put_unaligned(dst_char, &target[j]);
+			else if (charlen == 4) {
+				/*
+				 * 4bytes UTF-8(surrogate pair) to 4bytes UTF-16
+				 * 7-8bytes UTF-8(IVS) divided to 2 UTF-16
+				 * (charlen=3+4 or 4+4)
+				 */
+				put_unaligned(dst_char, &target[j]);
+				dst_char = cpu_to_le16(*(wchar_to + 1));
+				j++;
+				put_unaligned(dst_char, &target[j]);
+			} else if (charlen >= 5) {
+				/* 5-6bytes UTF-8 to 6bytes UTF-16 */
+				put_unaligned(dst_char, &target[j]);
+				dst_char = cpu_to_le16(*(wchar_to + 1));
+				j++;
+				put_unaligned(dst_char, &target[j]);
+				dst_char = cpu_to_le16(*(wchar_to + 2));
+				j++;
+				put_unaligned(dst_char, &target[j]);
 			}
+			continue;
+
+unknown:
+			dst_char = cpu_to_le16(0x003f);
+			charlen = 1;
 		}
+
+ctoUTF16:
 		/*
 		 * character may take more than one byte in the source string,
 		 * but will take exactly two bytes in the target string
diff --git a/fs/ksmbd/unicode.h b/fs/ksmbd/unicode.h
index 5593024230ae..076f6034a789 100644
--- a/fs/ksmbd/unicode.h
+++ b/fs/ksmbd/unicode.h
@@ -24,6 +24,7 @@
 #include <asm/byteorder.h>
 #include <linux/types.h>
 #include <linux/nls.h>
+#include <linux/unicode.h>
 
 #define  UNIUPR_NOLOWER		/* Example to not expand lower case tables */
 
@@ -69,7 +70,7 @@ char *smb_strndup_from_utf16(const char *src, const int maxlen,
 			     const struct nls_table *codepage);
 int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
 		      const struct nls_table *cp, int mapchars);
-char *ksmbd_extract_sharename(char *treename);
+char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename);
 #endif
 
 /*
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index f76acd83c294..a89529b21c86 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -18,6 +18,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sched/xacct.h>
 #include <linux/crc32c.h>
+#include <linux/namei.h>
 
 #include "glob.h"
 #include "oplock.h"
@@ -35,19 +36,6 @@
 #include "mgmt/user_session.h"
 #include "mgmt/user_config.h"
 
-static char *extract_last_component(char *path)
-{
-	char *p = strrchr(path, '/');
-
-	if (p && p[1] != '\0') {
-		*p = '\0';
-		p++;
-	} else {
-		p = NULL;
-	}
-	return p;
-}
-
 static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
 				    struct inode *parent_inode,
 				    struct inode *inode)
@@ -61,67 +49,96 @@ static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
 
 /**
  * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
- *
- * the parent dentry got by dget_parent or @parent could be
- * unstable, we try to lock a parent inode and lookup the
- * child dentry again.
- *
- * the reference count of @parent isn't incremented.
  */
-int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
-			  struct dentry *child)
+int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
 {
-	struct dentry *dentry;
-	int ret = 0;
-
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	dentry = lookup_one(user_ns, child->d_name.name, parent,
-			    child->d_name.len);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto out_err;
-	}
-
-	if (dentry != child) {
-		ret = -ESTALE;
-		dput(dentry);
-		goto out_err;
+	if (child->d_parent != parent) {
+		inode_unlock(d_inode(parent));
+		return -ENOENT;
 	}
 
-	dput(dentry);
 	return 0;
-out_err:
-	inode_unlock(d_inode(parent));
-	return ret;
 }
 
-int ksmbd_vfs_may_delete(struct user_namespace *user_ns,
-			 struct dentry *dentry)
+static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
+					char *pathname, unsigned int flags,
+					struct path *parent_path,
+					struct path *path)
 {
-	struct dentry *parent;
-	int ret;
+	struct qstr last;
+	struct filename *filename;
+	struct path *root_share_path = &share_conf->vfs_path;
+	int err, type;
+	struct dentry *d;
+
+	if (pathname[0] == '\0') {
+		pathname = share_conf->path;
+		root_share_path = NULL;
+	} else {
+		flags |= LOOKUP_BENEATH;
+	}
+
+	filename = getname_kernel(pathname);
+	if (IS_ERR(filename))
+		return PTR_ERR(filename);
 
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
+	err = vfs_path_parent_lookup(filename, flags,
+				     parent_path, &last, &type,
+				     root_share_path);
+	if (err) {
+		putname(filename);
+		return err;
 	}
 
-	ret = inode_permission(user_ns, d_inode(parent),
-			       MAY_EXEC | MAY_WRITE);
+	if (unlikely(type != LAST_NORM)) {
+		path_put(parent_path);
+		putname(filename);
+		return -ENOENT;
+	}
 
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	return ret;
+	err = mnt_want_write(parent_path->mnt);
+	if (err) {
+		path_put(parent_path);
+		putname(filename);
+		return -ENOENT;
+	}
+
+	inode_lock_nested(parent_path->dentry->d_inode, I_MUTEX_PARENT);
+	d = lookup_one_qstr_excl(&last, parent_path->dentry, 0);
+	if (IS_ERR(d))
+		goto err_out;
+
+	if (d_is_negative(d)) {
+		dput(d);
+		goto err_out;
+	}
+
+	path->dentry = d;
+	path->mnt = mntget(parent_path->mnt);
+
+	if (test_share_config_flag(share_conf, KSMBD_SHARE_FLAG_CROSSMNT)) {
+		err = follow_down(path);
+		if (err < 0) {
+			path_put(path);
+			goto err_out;
+		}
+	}
+
+	putname(filename);
+	return 0;
+
+err_out:
+	inode_unlock(d_inode(parent_path->dentry));
+	mnt_drop_write(parent_path->mnt);
+	path_put(parent_path);
+	putname(filename);
+	return -ENOENT;
 }
 
-int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
+void ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 				   struct dentry *dentry, __le32 *daccess)
 {
-	struct dentry *parent;
-	int ret = 0;
-
 	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
 
 	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_WRITE))
@@ -136,19 +153,8 @@ int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 	if (!inode_permission(user_ns, d_inode(dentry), MAY_OPEN | MAY_EXEC))
 		*daccess |= FILE_EXECUTE_LE;
 
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(user_ns, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
-	}
-
-	if (!inode_permission(user_ns, d_inode(parent), MAY_EXEC | MAY_WRITE))
+	if (!inode_permission(user_ns, d_inode(dentry->d_parent), MAY_EXEC | MAY_WRITE))
 		*daccess |= FILE_DELETE_LE;
-
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	return ret;
 }
 
 /**
@@ -184,6 +190,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 	} else {
 		pr_err("File(%s): creation failed (err:%d)\n", name, err);
 	}
+
 	done_path_create(&path, dentry);
 	return err;
 }
@@ -217,27 +224,26 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 	user_ns = mnt_user_ns(path.mnt);
 	mode |= S_IFDIR;
 	err = vfs_mkdir(user_ns, d_inode(path.dentry), dentry, mode);
-	if (err) {
-		goto out;
-	} else if (d_unhashed(dentry)) {
+	if (!err && d_unhashed(dentry)) {
 		struct dentry *d;
 
 		d = lookup_one(user_ns, dentry->d_name.name, dentry->d_parent,
 			       dentry->d_name.len);
 		if (IS_ERR(d)) {
 			err = PTR_ERR(d);
-			goto out;
+			goto out_err;
 		}
 		if (unlikely(d_is_negative(d))) {
 			dput(d);
 			err = -ENOENT;
-			goto out;
+			goto out_err;
 		}
 
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
 		dput(d);
 	}
-out:
+
+out_err:
 	done_path_create(&path, dentry);
 	if (err)
 		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
@@ -357,15 +363,15 @@ static int check_lock_range(struct file *filp, loff_t start, loff_t end,
  * @fid:	file id of open file
  * @count:	read byte count
  * @pos:	file pos
+ * @rbuf:	read data buffer
  *
  * Return:	number of read bytes on success, otherwise error
  */
 int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
-		   loff_t *pos)
+		   loff_t *pos, char *rbuf)
 {
 	struct file *filp = fp->filp;
 	ssize_t nbytes = 0;
-	char *rbuf = work->aux_payload_buf;
 	struct inode *inode = file_inode(filp);
 
 	if (S_ISDIR(inode->i_mode))
@@ -376,8 +382,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 
 	if (work->conn->connection_type) {
 		if (!(fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
-			pr_err("no right to read(%pd)\n",
-			       fp->filp->f_path.dentry);
+			pr_err("no right to read(%pD)\n", fp->filp);
 			return -EACCES;
 		}
 	}
@@ -397,8 +402,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 
 	nbytes = kernel_read(filp, rbuf, count, pos);
 	if (nbytes < 0) {
-		pr_err("smb read failed for (%s), err = %zd\n",
-		       fp->filename, nbytes);
+		pr_err("smb read failed, err = %zd\n", nbytes);
 		return nbytes;
 	}
 
@@ -411,7 +415,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 {
 	char *stream_buf = NULL, *wbuf;
 	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
-	size_t size, v_len;
+	size_t size;
+	ssize_t v_len;
 	int err = 0;
 
 	ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
@@ -428,14 +433,14 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				       fp->stream.name,
 				       fp->stream.size,
 				       &stream_buf);
-	if ((int)v_len < 0) {
+	if (v_len < 0) {
 		pr_err("not found stream in xattr : %zd\n", v_len);
-		err = (int)v_len;
+		err = v_len;
 		goto out;
 	}
 
 	if (v_len < size) {
-		wbuf = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+		wbuf = kvzalloc(size, GFP_KERNEL);
 		if (!wbuf) {
 			err = -ENOMEM;
 			goto out;
@@ -450,11 +455,12 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	memcpy(&stream_buf[*pos], buf, count);
 
 	err = ksmbd_vfs_setxattr(user_ns,
-				 fp->filp->f_path.dentry,
+				 &fp->filp->f_path,
 				 fp->stream.name,
 				 (void *)stream_buf,
 				 size,
-				 0);
+				 0,
+				 true);
 	if (err < 0)
 		goto out;
 
@@ -487,8 +493,7 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 
 	if (work->conn->connection_type) {
 		if (!(fp->daccess & FILE_WRITE_DATA_LE)) {
-			pr_err("no right to write(%pd)\n",
-			       fp->filp->f_path.dentry);
+			pr_err("no right to write(%pD)\n", fp->filp);
 			err = -EACCES;
 			goto out;
 		}
@@ -527,8 +532,8 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 	if (sync) {
 		err = vfs_fsync_range(filp, offset, offset + *written, 0);
 		if (err < 0)
-			pr_err("fsync failed for filename = %pd, err = %d\n",
-			       fp->filp->f_path.dentry, err);
+			pr_err("fsync failed for filename = %pD, err = %d\n",
+			       fp->filp, err);
 	}
 
 out:
@@ -543,7 +548,7 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_getattr(struct path *path, struct kstat *stat)
+int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat)
 {
 	int err;
 
@@ -583,54 +588,32 @@ int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id)
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 {
 	struct user_namespace *user_ns;
-	struct path path;
-	struct dentry *parent;
+	struct dentry *parent = path->dentry->d_parent;
 	int err;
 
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
 
-	err = ksmbd_vfs_kern_path(work, name, LOOKUP_NO_SYMLINKS, &path, false);
-	if (err) {
-		ksmbd_debug(VFS, "can't get %s, err %d\n", name, err);
-		ksmbd_revert_fsids(work);
-		return err;
-	}
-
-	user_ns = mnt_user_ns(path.mnt);
-	parent = dget_parent(path.dentry);
-	err = ksmbd_vfs_lock_parent(user_ns, parent, path.dentry);
-	if (err) {
-		dput(parent);
-		path_put(&path);
-		ksmbd_revert_fsids(work);
-		return err;
-	}
-
-	if (!d_inode(path.dentry)->i_nlink) {
+	if (!d_inode(path->dentry)->i_nlink) {
 		err = -ENOENT;
 		goto out_err;
 	}
 
-	if (S_ISDIR(d_inode(path.dentry)->i_mode)) {
-		err = vfs_rmdir(user_ns, d_inode(parent), path.dentry);
+	user_ns = mnt_user_ns(path->mnt);
+	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
+		err = vfs_rmdir(user_ns, d_inode(parent), path->dentry);
 		if (err && err != -ENOTEMPTY)
-			ksmbd_debug(VFS, "%s: rmdir failed, err %d\n", name,
-				    err);
+			ksmbd_debug(VFS, "rmdir failed, err %d\n", err);
 	} else {
-		err = vfs_unlink(user_ns, d_inode(parent), path.dentry, NULL);
+		err = vfs_unlink(user_ns, d_inode(parent), path->dentry, NULL);
 		if (err)
-			ksmbd_debug(VFS, "%s: unlink failed, err %d\n", name,
-				    err);
+			ksmbd_debug(VFS, "unlink failed, err %d\n", err);
 	}
 
 out_err:
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	path_put(&path);
 	ksmbd_revert_fsids(work);
 	return err;
 }
@@ -689,149 +672,120 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 	return err;
 }
 
-static int ksmbd_validate_entry_in_use(struct dentry *src_dent)
+int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
+		     char *newname, int flags)
 {
-	struct dentry *dst_dent;
+	struct dentry *old_parent, *new_dentry, *trap;
+	struct dentry *old_child = old_path->dentry;
+	struct path new_path;
+	struct qstr new_last;
+	struct renamedata rd;
+	struct filename *to;
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	struct ksmbd_file *parent_fp;
+	int new_type;
+	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
+
+	if (ksmbd_override_fsids(work))
+		return -ENOMEM;
 
-	spin_lock(&src_dent->d_lock);
-	list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
-		struct ksmbd_file *child_fp;
+	to = getname_kernel(newname);
+	if (IS_ERR(to)) {
+		err = PTR_ERR(to);
+		goto revert_fsids;
+	}
 
-		if (d_really_is_negative(dst_dent))
-			continue;
+retry:
+	err = vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
+				     &new_path, &new_last, &new_type,
+				     &share_conf->vfs_path);
+	if (err)
+		goto out1;
 
-		child_fp = ksmbd_lookup_fd_inode(d_inode(dst_dent));
-		if (child_fp) {
-			spin_unlock(&src_dent->d_lock);
-			ksmbd_debug(VFS, "Forbid rename, sub file/dir is in use\n");
-			return -EACCES;
-		}
+	if (old_path->mnt != new_path.mnt) {
+		err = -EXDEV;
+		goto out2;
 	}
-	spin_unlock(&src_dent->d_lock);
 
-	return 0;
-}
+	err = mnt_want_write(old_path->mnt);
+	if (err)
+		goto out2;
 
-static int __ksmbd_vfs_rename(struct ksmbd_work *work,
-			      struct user_namespace *src_user_ns,
-			      struct dentry *src_dent_parent,
-			      struct dentry *src_dent,
-			      struct user_namespace *dst_user_ns,
-			      struct dentry *dst_dent_parent,
-			      struct dentry *trap_dent,
-			      char *dst_name)
-{
-	struct dentry *dst_dent;
-	int err;
+	trap = lock_rename_child(old_child, new_path.dentry);
 
-	if (!work->tcon->posix_extensions) {
-		err = ksmbd_validate_entry_in_use(src_dent);
-		if (err)
-			return err;
+	old_parent = dget(old_child->d_parent);
+	if (d_unhashed(old_child)) {
+		err = -EINVAL;
+		goto out3;
 	}
 
-	if (d_really_is_negative(src_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(dst_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(src_dent))
-		return -ENOENT;
-	if (src_dent == trap_dent)
-		return -EINVAL;
-
-	if (ksmbd_override_fsids(work))
-		return -ENOMEM;
+	parent_fp = ksmbd_lookup_fd_inode(old_child->d_parent);
+	if (parent_fp) {
+		if (parent_fp->daccess & FILE_DELETE_LE) {
+			pr_err("parent dir is opened with delete access\n");
+			err = -ESHARE;
+			ksmbd_fd_put(work, parent_fp);
+			goto out3;
+		}
+		ksmbd_fd_put(work, parent_fp);
+	}
 
-	dst_dent = lookup_one(dst_user_ns, dst_name, dst_dent_parent,
-			      strlen(dst_name));
-	err = PTR_ERR(dst_dent);
-	if (IS_ERR(dst_dent)) {
-		pr_err("lookup failed %s [%d]\n", dst_name, err);
-		goto out;
+	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
+					  lookup_flags | LOOKUP_RENAME_TARGET);
+	if (IS_ERR(new_dentry)) {
+		err = PTR_ERR(new_dentry);
+		goto out3;
 	}
 
-	err = -ENOTEMPTY;
-	if (dst_dent != trap_dent && !d_really_is_positive(dst_dent)) {
-		struct renamedata rd = {
-			.old_mnt_userns	= src_user_ns,
-			.old_dir	= d_inode(src_dent_parent),
-			.old_dentry	= src_dent,
-			.new_mnt_userns	= dst_user_ns,
-			.new_dir	= d_inode(dst_dent_parent),
-			.new_dentry	= dst_dent,
-		};
-		err = vfs_rename(&rd);
+	if (d_is_symlink(new_dentry)) {
+		err = -EACCES;
+		goto out4;
 	}
-	if (err)
-		pr_err("vfs_rename failed err %d\n", err);
-	if (dst_dent)
-		dput(dst_dent);
-out:
-	ksmbd_revert_fsids(work);
-	return err;
-}
 
-int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
-			char *newname)
-{
-	struct user_namespace *user_ns;
-	struct path dst_path;
-	struct dentry *src_dent_parent, *dst_dent_parent;
-	struct dentry *src_dent, *trap_dent, *src_child;
-	char *dst_name;
-	int err;
+	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
+		err = -EEXIST;
+		goto out4;
+	}
 
-	dst_name = extract_last_component(newname);
-	if (!dst_name) {
-		dst_name = newname;
-		newname = "";
+	if (old_child == trap) {
+		err = -EINVAL;
+		goto out4;
 	}
 
-	src_dent_parent = dget_parent(fp->filp->f_path.dentry);
-	src_dent = fp->filp->f_path.dentry;
+	if (new_dentry == trap) {
+		err = -ENOTEMPTY;
+		goto out4;
+	}
+
+	rd.old_mnt_userns	= mnt_user_ns(old_path->mnt),
+	rd.old_dir		= d_inode(old_parent),
+	rd.old_dentry		= old_child,
+	rd.new_mnt_userns	= mnt_user_ns(new_path.mnt),
+	rd.new_dir		= new_path.dentry->d_inode,
+	rd.new_dentry		= new_dentry,
+	rd.flags		= flags,
+	rd.delegated_inode	= NULL,
+	err = vfs_rename(&rd);
+	if (err)
+		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
+
+out4:
+	dput(new_dentry);
+out3:
+	dput(old_parent);
+	unlock_rename(old_parent, new_path.dentry);
+	mnt_drop_write(old_path->mnt);
+out2:
+	path_put(&new_path);
 
-	err = ksmbd_vfs_kern_path(work, newname,
-				  LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
-				  &dst_path, false);
-	if (err) {
-		ksmbd_debug(VFS, "Cannot get path for %s [%d]\n", newname, err);
-		goto out;
+	if (retry_estale(err, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		goto retry;
 	}
-	dst_dent_parent = dst_path.dentry;
-
-	trap_dent = lock_rename(src_dent_parent, dst_dent_parent);
-	dget(src_dent);
-	dget(dst_dent_parent);
-	user_ns = file_mnt_user_ns(fp->filp);
-	src_child = lookup_one(user_ns, src_dent->d_name.name, src_dent_parent,
-			       src_dent->d_name.len);
-	if (IS_ERR(src_child)) {
-		err = PTR_ERR(src_child);
-		goto out_lock;
-	}
-
-	if (src_child != src_dent) {
-		err = -ESTALE;
-		dput(src_child);
-		goto out_lock;
-	}
-	dput(src_child);
-
-	err = __ksmbd_vfs_rename(work,
-				 user_ns,
-				 src_dent_parent,
-				 src_dent,
-				 mnt_user_ns(dst_path.mnt),
-				 dst_dent_parent,
-				 trap_dent,
-				 dst_name);
-out_lock:
-	dput(src_dent);
-	dput(dst_dent_parent);
-	unlock_rename(src_dent_parent, dst_dent_parent);
-	path_put(&dst_path);
-out:
-	dput(src_dent_parent);
+out1:
+	putname(to);
+revert_fsids:
+	ksmbd_revert_fsids(work);
 	return err;
 }
 
@@ -873,8 +827,7 @@ int ksmbd_vfs_truncate(struct ksmbd_work *work,
 
 	err = vfs_truncate(&filp->f_path, size);
 	if (err)
-		pr_err("truncate failed for filename : %s err %d\n",
-		       fp->filename, err);
+		pr_err("truncate failed, err %d\n", err);
 	return err;
 }
 
@@ -895,7 +848,7 @@ ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
 	if (size <= 0)
 		return size;
 
-	vlist = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	vlist = kvzalloc(size, GFP_KERNEL);
 	if (!vlist)
 		return -ENOMEM;
 
@@ -953,28 +906,38 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
 /**
  * ksmbd_vfs_setxattr() - vfs helper for smb set extended attributes value
  * @user_ns:	user namespace
- * @dentry:	dentry to set XATTR at
- * @name:	xattr name for setxattr
- * @value:	xattr value to set
- * @size:	size of xattr value
+ * @path:	path of dentry to set XATTR at
+ * @attr_name:	xattr name for setxattr
+ * @attr_value:	xattr value to set
+ * @attr_size:	size of xattr value
  * @flags:	destination buffer length
+ * @get_write:	get write access to a mount
  *
  * Return:	0 on success, otherwise error
  */
 int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
-		       struct dentry *dentry, const char *attr_name,
-		       const void *attr_value, size_t attr_size, int flags)
+		       const struct path *path, const char *attr_name,
+		       const void *attr_value, size_t attr_size, int flags,
+		       bool get_write)
 {
 	int err;
 
+	if (get_write == true) {
+		err = mnt_want_write(path->mnt);
+		if (err)
+			return err;
+	}
+
 	err = vfs_setxattr(user_ns,
-			   dentry,
+			   path->dentry,
 			   attr_name,
 			   attr_value,
 			   attr_size,
 			   flags);
 	if (err)
 		ksmbd_debug(VFS, "setxattr failed, err %d\n", err);
+	if (get_write == true)
+		mnt_drop_write(path->mnt);
 	return err;
 }
 
@@ -1078,19 +1041,34 @@ int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 }
 
 int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
-			   struct dentry *dentry, char *attr_name)
+			   const struct path *path, char *attr_name)
 {
-	return vfs_removexattr(user_ns, dentry, attr_name);
+	int err;
+
+	err = mnt_want_write(path->mnt);
+	if (err)
+		return err;
+
+	err = vfs_removexattr(user_ns, path->dentry, attr_name);
+	mnt_drop_write(path->mnt);
+
+	return err;
 }
 
-int ksmbd_vfs_unlink(struct user_namespace *user_ns,
-		     struct dentry *dir, struct dentry *dentry)
+int ksmbd_vfs_unlink(struct file *filp)
 {
 	int err = 0;
+	struct dentry *dir, *dentry = filp->f_path.dentry;
+	struct user_namespace *user_ns = file_mnt_user_ns(filp);
 
-	err = ksmbd_vfs_lock_parent(user_ns, dir, dentry);
+	err = mnt_want_write(filp->f_path.mnt);
 	if (err)
 		return err;
+
+	dir = dget_parent(dentry);
+	err = ksmbd_vfs_lock_parent(dir, dentry);
+	if (err)
+		goto out;
 	dget(dentry);
 
 	if (S_ISDIR(d_inode(dentry)->i_mode))
@@ -1102,6 +1080,9 @@ int ksmbd_vfs_unlink(struct user_namespace *user_ns,
 	inode_unlock(d_inode(dir));
 	if (err)
 		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
+out:
+	dput(dir);
+	mnt_drop_write(filp->f_path.mnt);
 
 	return err;
 }
@@ -1148,12 +1129,23 @@ static int __caseless_lookup(struct dir_context *ctx, const char *name,
 			     unsigned int d_type)
 {
 	struct ksmbd_readdir_data *buf;
+	int cmp = -EINVAL;
 
 	buf = container_of(ctx, struct ksmbd_readdir_data, ctx);
 
 	if (buf->used != namlen)
 		return 0;
-	if (!strncasecmp((char *)buf->private, name, namlen)) {
+	if (IS_ENABLED(CONFIG_UNICODE) && buf->um) {
+		const struct qstr q_buf = {.name = buf->private,
+					   .len = buf->used};
+		const struct qstr q_name = {.name = name,
+					    .len = namlen};
+
+		cmp = utf8_strncasecmp(buf->um, &q_buf, &q_name);
+	}
+	if (cmp < 0)
+		cmp = strncasecmp((char *)buf->private, name, namlen);
+	if (!cmp) {
 		memcpy((char *)buf->private, name, namlen);
 		buf->dirent_count = 1;
 		return -EEXIST;
@@ -1169,7 +1161,8 @@ static int __caseless_lookup(struct dir_context *ctx, const char *name,
  *
  * Return:	0 on success, otherwise error
  */
-static int ksmbd_vfs_lookup_in_dir(struct path *dir, char *name, size_t namelen)
+static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
+				   size_t namelen, struct unicode_map *um)
 {
 	int ret;
 	struct file *dfilp;
@@ -1179,6 +1172,7 @@ static int ksmbd_vfs_lookup_in_dir(struct path *dir, char *name, size_t namelen)
 		.private	= name,
 		.used		= namelen,
 		.dirent_count	= 0,
+		.um		= um,
 	};
 
 	dfilp = dentry_open(dir, flags, current_cred());
@@ -1193,32 +1187,29 @@ static int ksmbd_vfs_lookup_in_dir(struct path *dir, char *name, size_t namelen)
 }
 
 /**
- * ksmbd_vfs_kern_path() - lookup a file and get path info
- * @name:	file path that is relative to share
- * @flags:	lookup flags
- * @path:	if lookup succeed, return path info
+ * ksmbd_vfs_kern_path_locked() - lookup a file and get path info
+ * @name:		file path that is relative to share
+ * @flags:		lookup flags
+ * @parent_path:	if lookup succeed, return parent_path info
+ * @path:		if lookup succeed, return path info
  * @caseless:	caseless filename lookup
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
-			unsigned int flags, struct path *path, bool caseless)
+int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
+			       unsigned int flags, struct path *parent_path,
+			       struct path *path, bool caseless)
 {
 	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
 	int err;
 
-	flags |= LOOKUP_BENEATH;
-	err = vfs_path_lookup(share_conf->vfs_path.dentry,
-			      share_conf->vfs_path.mnt,
-			      name,
-			      flags,
-			      path);
+	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, parent_path,
+					   path);
 	if (!err)
 		return 0;
 
 	if (caseless) {
 		char *filepath;
-		struct path parent;
 		size_t path_len, remain_len;
 
 		filepath = kstrdup(name, GFP_KERNEL);
@@ -1228,10 +1219,10 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 		path_len = strlen(filepath);
 		remain_len = path_len;
 
-		parent = share_conf->vfs_path;
-		path_get(&parent);
+		*parent_path = share_conf->vfs_path;
+		path_get(parent_path);
 
-		while (d_can_lookup(parent.dentry)) {
+		while (d_can_lookup(parent_path->dentry)) {
 			char *filename = filepath + path_len - remain_len;
 			char *next = strchrnul(filename, '/');
 			size_t filename_len = next - filename;
@@ -1240,11 +1231,11 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 			if (filename_len == 0)
 				break;
 
-			err = ksmbd_vfs_lookup_in_dir(&parent, filename,
-						      filename_len);
-			path_put(&parent);
+			err = ksmbd_vfs_lookup_in_dir(parent_path, filename,
+						      filename_len,
+						      work->conn->um);
 			if (err)
-				goto out;
+				goto out2;
 
 			next[0] = '\0';
 
@@ -1252,26 +1243,50 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 					      share_conf->vfs_path.mnt,
 					      filepath,
 					      flags,
-					      &parent);
+					      path);
 			if (err)
-				goto out;
-			else if (is_last) {
-				*path = parent;
-				goto out;
-			}
+				goto out2;
+			else if (is_last)
+				goto out1;
+			path_put(parent_path);
+			*parent_path = *path;
 
 			next[0] = '/';
 			remain_len -= filename_len + 1;
 		}
 
-		path_put(&parent);
 		err = -EINVAL;
-out:
+out2:
+		path_put(parent_path);
+out1:
 		kfree(filepath);
 	}
+
+	if (!err) {
+		err = mnt_want_write(parent_path->mnt);
+		if (err) {
+			path_put(path);
+			path_put(parent_path);
+			return err;
+		}
+
+		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
+		if (err) {
+			path_put(path);
+			path_put(parent_path);
+		}
+	}
 	return err;
 }
 
+void ksmbd_vfs_kern_path_unlock(struct path *parent_path, struct path *path)
+{
+	inode_unlock(d_inode(parent_path->dentry));
+	mnt_drop_write(parent_path->mnt);
+	path_put(path);
+	path_put(parent_path);
+}
+
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
@@ -1290,13 +1305,13 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 }
 
 int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
-				struct dentry *dentry)
+				const struct path *path)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t xattr_list_len;
 	int err = 0;
 
-	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	xattr_list_len = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
 	if (xattr_list_len < 0) {
 		goto out;
 	} else if (!xattr_list_len) {
@@ -1312,25 +1327,25 @@ int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
 			     sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1) ||
 		    !strncmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
 			     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1)) {
-			err = ksmbd_vfs_remove_xattr(user_ns, dentry, name);
+			err = ksmbd_vfs_remove_xattr(user_ns, path, name);
 			if (err)
 				ksmbd_debug(SMB,
 					    "remove acl xattr failed : %s\n", name);
 		}
 	}
+
 out:
 	kvfree(xattr_list);
 	return err;
 }
 
-int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
-			       struct dentry *dentry)
+int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns, const struct path *path)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t xattr_list_len;
 	int err = 0;
 
-	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	xattr_list_len = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
 	if (xattr_list_len < 0) {
 		goto out;
 	} else if (!xattr_list_len) {
@@ -1343,7 +1358,7 @@ int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
 		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
 
 		if (!strncmp(name, XATTR_NAME_SD, XATTR_NAME_SD_LEN)) {
-			err = ksmbd_vfs_remove_xattr(user_ns, dentry, name);
+			err = ksmbd_vfs_remove_xattr(user_ns, path, name);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n", name);
 		}
@@ -1367,7 +1382,7 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespac
 		return NULL;
 
 	posix_acls = get_acl(inode, acl_type);
-	if (!posix_acls)
+	if (IS_ERR_OR_NULL(posix_acls))
 		return NULL;
 
 	smb_acl = kzalloc(sizeof(struct xattr_smb_acl) +
@@ -1420,13 +1435,15 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct user_namespac
 
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct user_namespace *user_ns,
-			   struct dentry *dentry,
-			   struct smb_ntsd *pntsd, int len)
+			   const struct path *path,
+			   struct smb_ntsd *pntsd, int len,
+			   bool get_write)
 {
 	int rc;
 	struct ndr sd_ndr = {0}, acl_ndr = {0};
 	struct xattr_ntacl acl = {0};
 	struct xattr_smb_acl *smb_acl, *def_smb_acl = NULL;
+	struct dentry *dentry = path->dentry;
 	struct inode *inode = d_inode(dentry);
 
 	acl.version = 4;
@@ -1478,9 +1495,9 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 		goto out;
 	}
 
-	rc = ksmbd_vfs_setxattr(user_ns, dentry,
+	rc = ksmbd_vfs_setxattr(user_ns, path,
 				XATTR_NAME_SD, sd_ndr.data,
-				sd_ndr.offset, 0);
+				sd_ndr.offset, 0, get_write);
 	if (rc < 0)
 		pr_err("Failed to store XATTR ntacl :%d\n", rc);
 
@@ -1568,8 +1585,9 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 }
 
 int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
-				   struct dentry *dentry,
-				   struct xattr_dos_attrib *da)
+				   const struct path *path,
+				   struct xattr_dos_attrib *da,
+				   bool get_write)
 {
 	struct ndr n;
 	int err;
@@ -1578,8 +1596,8 @@ int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
 	if (err)
 		return err;
 
-	err = ksmbd_vfs_setxattr(user_ns, dentry, XATTR_NAME_DOS_ATTRIBUTE,
-				 (void *)n.data, n.offset, 0);
+	err = ksmbd_vfs_setxattr(user_ns, path, XATTR_NAME_DOS_ATTRIBUTE,
+				 (void *)n.data, n.offset, 0, get_write);
 	if (err)
 		ksmbd_debug(SMB, "failed to store dos attribute in xattr\n");
 	kfree(n.data);
@@ -1744,11 +1762,11 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 	*total_size_written = 0;
 
 	if (!(src_fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
-		pr_err("no right to read(%pd)\n", src_fp->filp->f_path.dentry);
+		pr_err("no right to read(%pD)\n", src_fp->filp);
 		return -EACCES;
 	}
 	if (!(dst_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE))) {
-		pr_err("no right to write(%pd)\n", dst_fp->filp->f_path.dentry);
+		pr_err("no right to write(%pD)\n", dst_fp->filp);
 		return -EACCES;
 	}
 
@@ -1815,10 +1833,11 @@ void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock)
 }
 
 int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
-				 struct inode *inode)
+				 struct path *path)
 {
 	struct posix_acl_state acl_state;
 	struct posix_acl *acls;
+	struct inode *inode = d_inode(path->dentry);
 	int rc;
 
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
@@ -1847,6 +1866,7 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
 		return -ENOMEM;
 	}
 	posix_state_to_acl(&acl_state, acls->a_entries);
+
 	rc = set_posix_acl(user_ns, inode, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1859,23 +1879,25 @@ int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
+
 	free_acl_state(&acl_state);
 	posix_acl_release(acls);
 	return rc;
 }
 
 int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
-				struct inode *inode, struct inode *parent_inode)
+				struct path *path, struct inode *parent_inode)
 {
 	struct posix_acl *acls;
 	struct posix_acl_entry *pace;
+	struct inode *inode = d_inode(path->dentry);
 	int rc, i;
 
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL))
 		return -EOPNOTSUPP;
 
 	acls = get_acl(parent_inode, ACL_TYPE_DEFAULT);
-	if (!acls)
+	if (IS_ERR_OR_NULL(acls))
 		return -ENOENT;
 	pace = acls->a_entries;
 
@@ -1897,6 +1919,7 @@ int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
+
 	posix_acl_release(acls);
 	return rc;
 }
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 432c94773177..6d108cba7e0c 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -12,6 +12,7 @@
 #include <linux/namei.h>
 #include <uapi/linux/xattr.h>
 #include <linux/posix_acl.h>
+#include <linux/unicode.h>
 
 #include "smbacl.h"
 #include "xattr.h"
@@ -99,6 +100,7 @@ struct ksmbd_readdir_data {
 	unsigned int		used;
 	unsigned int		dirent_count;
 	unsigned int		file_attr;
+	struct unicode_map	*um;
 };
 
 /* ksmbd kstat wrapper to get valid create time when reading dir entry */
@@ -108,25 +110,23 @@ struct ksmbd_kstat {
 	__le32			file_attributes;
 };
 
-int ksmbd_vfs_lock_parent(struct user_namespace *user_ns, struct dentry *parent,
-			  struct dentry *child);
-int ksmbd_vfs_may_delete(struct user_namespace *user_ns, struct dentry *dentry);
-int ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
+int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child);
+void ksmbd_vfs_query_maximal_access(struct user_namespace *user_ns,
 				   struct dentry *dentry, __le32 *daccess);
 int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
 int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode);
-int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp,
-		   size_t count, loff_t *pos);
+int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
+		   loff_t *pos, char *rbuf);
 int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    char *buf, size_t count, loff_t *pos, bool sync,
 		    ssize_t *written);
 int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id);
-int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name);
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path);
 int ksmbd_vfs_link(struct ksmbd_work *work,
 		   const char *oldname, const char *newname);
-int ksmbd_vfs_getattr(struct path *path, struct kstat *stat);
-int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
-			char *newname);
+int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat);
+int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
+		     char *newname, int flags);
 int ksmbd_vfs_truncate(struct ksmbd_work *work,
 		       struct ksmbd_file *fp, loff_t size);
 struct srv_copychunk;
@@ -147,15 +147,17 @@ ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
 				struct dentry *dentry, char *attr_name,
 				int attr_name_len);
 int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
-		       struct dentry *dentry, const char *attr_name,
-		       const void *attr_value, size_t attr_size, int flags);
+		       const struct path *path, const char *attr_name,
+		       const void *attr_value, size_t attr_size, int flags,
+		       bool get_write);
 int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
 int ksmbd_vfs_remove_xattr(struct user_namespace *user_ns,
-			   struct dentry *dentry, char *attr_name);
-int ksmbd_vfs_kern_path(struct ksmbd_work *work,
-			char *name, unsigned int flags, struct path *path,
-			bool caseless);
+			   const struct path *path, char *attr_name);
+int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
+			       unsigned int flags, struct path *parent_path,
+			       struct path *path, bool caseless);
+void ksmbd_vfs_kern_path_unlock(struct path *parent_path, struct path *path);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
@@ -168,8 +170,7 @@ struct file_allocated_range_buffer;
 int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 			 struct file_allocated_range_buffer *ranges,
 			 unsigned int in_count, unsigned int *out_count);
-int ksmbd_vfs_unlink(struct user_namespace *user_ns,
-		     struct dentry *dir, struct dentry *dentry);
+int ksmbd_vfs_unlink(struct file *filp);
 void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat);
 int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 				struct user_namespace *user_ns,
@@ -179,26 +180,27 @@ void ksmbd_vfs_posix_lock_wait(struct file_lock *flock);
 int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout);
 void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock);
 int ksmbd_vfs_remove_acl_xattrs(struct user_namespace *user_ns,
-				struct dentry *dentry);
-int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns,
-			       struct dentry *dentry);
+				const struct path *path);
+int ksmbd_vfs_remove_sd_xattrs(struct user_namespace *user_ns, const struct path *path);
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct user_namespace *user_ns,
-			   struct dentry *dentry,
-			   struct smb_ntsd *pntsd, int len);
+			   const struct path *path,
+			   struct smb_ntsd *pntsd, int len,
+			   bool get_write);
 int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 			   struct user_namespace *user_ns,
 			   struct dentry *dentry,
 			   struct smb_ntsd **pntsd);
 int ksmbd_vfs_set_dos_attrib_xattr(struct user_namespace *user_ns,
-				   struct dentry *dentry,
-				   struct xattr_dos_attrib *da);
+				   const struct path *path,
+				   struct xattr_dos_attrib *da,
+				   bool get_write);
 int ksmbd_vfs_get_dos_attrib_xattr(struct user_namespace *user_ns,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da);
 int ksmbd_vfs_set_init_posix_acl(struct user_namespace *user_ns,
-				 struct inode *inode);
+				 struct path *path);
 int ksmbd_vfs_inherit_posix_acl(struct user_namespace *user_ns,
-				struct inode *inode,
+				struct path *path,
 				struct inode *parent_inode);
 #endif /* __KSMBD_VFS_H__ */
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index b67ce2d52cee..774a387fccce 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -65,14 +65,14 @@ static unsigned long inode_hash(struct super_block *sb, unsigned long hashval)
 	return tmp & inode_hash_mask;
 }
 
-static struct ksmbd_inode *__ksmbd_inode_lookup(struct inode *inode)
+static struct ksmbd_inode *__ksmbd_inode_lookup(struct dentry *de)
 {
 	struct hlist_head *head = inode_hashtable +
-		inode_hash(inode->i_sb, inode->i_ino);
+		inode_hash(d_inode(de)->i_sb, (unsigned long)de);
 	struct ksmbd_inode *ci = NULL, *ret_ci = NULL;
 
 	hlist_for_each_entry(ci, head, m_hash) {
-		if (ci->m_inode == inode) {
+		if (ci->m_de == de) {
 			if (atomic_inc_not_zero(&ci->m_count))
 				ret_ci = ci;
 			break;
@@ -83,26 +83,16 @@ static struct ksmbd_inode *__ksmbd_inode_lookup(struct inode *inode)
 
 static struct ksmbd_inode *ksmbd_inode_lookup(struct ksmbd_file *fp)
 {
-	return __ksmbd_inode_lookup(file_inode(fp->filp));
+	return __ksmbd_inode_lookup(fp->filp->f_path.dentry);
 }
 
-static struct ksmbd_inode *ksmbd_inode_lookup_by_vfsinode(struct inode *inode)
-{
-	struct ksmbd_inode *ci;
-
-	read_lock(&inode_hash_lock);
-	ci = __ksmbd_inode_lookup(inode);
-	read_unlock(&inode_hash_lock);
-	return ci;
-}
-
-int ksmbd_query_inode_status(struct inode *inode)
+int ksmbd_query_inode_status(struct dentry *dentry)
 {
 	struct ksmbd_inode *ci;
 	int ret = KSMBD_INODE_STATUS_UNKNOWN;
 
 	read_lock(&inode_hash_lock);
-	ci = __ksmbd_inode_lookup(inode);
+	ci = __ksmbd_inode_lookup(dentry);
 	if (ci) {
 		ret = KSMBD_INODE_STATUS_OK;
 		if (ci->m_flags & (S_DEL_PENDING | S_DEL_ON_CLS))
@@ -142,7 +132,7 @@ void ksmbd_fd_set_delete_on_close(struct ksmbd_file *fp,
 static void ksmbd_inode_hash(struct ksmbd_inode *ci)
 {
 	struct hlist_head *b = inode_hashtable +
-		inode_hash(ci->m_inode->i_sb, ci->m_inode->i_ino);
+		inode_hash(d_inode(ci->m_de)->i_sb, (unsigned long)ci->m_de);
 
 	hlist_add_head(&ci->m_hash, b);
 }
@@ -156,7 +146,6 @@ static void ksmbd_inode_unhash(struct ksmbd_inode *ci)
 
 static int ksmbd_inode_init(struct ksmbd_inode *ci, struct ksmbd_file *fp)
 {
-	ci->m_inode = file_inode(fp->filp);
 	atomic_set(&ci->m_count, 1);
 	atomic_set(&ci->op_count, 0);
 	atomic_set(&ci->sop_count, 0);
@@ -165,6 +154,7 @@ static int ksmbd_inode_init(struct ksmbd_inode *ci, struct ksmbd_file *fp)
 	INIT_LIST_HEAD(&ci->m_fp_list);
 	INIT_LIST_HEAD(&ci->m_op_list);
 	rwlock_init(&ci->m_lock);
+	ci->m_de = fp->filp->f_path.dentry;
 	return 0;
 }
 
@@ -243,7 +233,6 @@ void ksmbd_release_inode_hash(void)
 
 static void __ksmbd_inode_close(struct ksmbd_file *fp)
 {
-	struct dentry *dir, *dentry;
 	struct ksmbd_inode *ci = fp->f_ci;
 	int err;
 	struct file *filp;
@@ -252,7 +241,7 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 	if (ksmbd_stream_fd(fp) && (ci->m_flags & S_DEL_ON_CLS_STREAM)) {
 		ci->m_flags &= ~S_DEL_ON_CLS_STREAM;
 		err = ksmbd_vfs_remove_xattr(file_mnt_user_ns(filp),
-					     filp->f_path.dentry,
+					     &filp->f_path,
 					     fp->stream.name);
 		if (err)
 			pr_err("remove xattr failed : %s\n",
@@ -262,11 +251,9 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 	if (atomic_dec_and_test(&ci->m_count)) {
 		write_lock(&ci->m_lock);
 		if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING)) {
-			dentry = filp->f_path.dentry;
-			dir = dentry->d_parent;
 			ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
 			write_unlock(&ci->m_lock);
-			ksmbd_vfs_unlink(file_mnt_user_ns(filp), dir, dentry);
+			ksmbd_vfs_unlink(filp);
 			write_lock(&ci->m_lock);
 		}
 		write_unlock(&ci->m_lock);
@@ -328,7 +315,6 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 		kfree(smb_lock);
 	}
 
-	kfree(fp->filename);
 	if (ksmbd_stream_fd(fp))
 		kfree(fp->stream.name);
 	kmem_cache_free(filp_cache, fp);
@@ -336,6 +322,9 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 
 static struct ksmbd_file *ksmbd_fp_get(struct ksmbd_file *fp)
 {
+	if (fp->f_state != FP_INITED)
+		return NULL;
+
 	if (!atomic_inc_not_zero(&fp->refcount))
 		return NULL;
 	return fp;
@@ -365,12 +354,11 @@ static void __put_fd_final(struct ksmbd_work *work, struct ksmbd_file *fp)
 
 static void set_close_state_blocked_works(struct ksmbd_file *fp)
 {
-	struct ksmbd_work *cancel_work, *ctmp;
+	struct ksmbd_work *cancel_work;
 
 	spin_lock(&fp->f_lock);
-	list_for_each_entry_safe(cancel_work, ctmp, &fp->blocked_works,
+	list_for_each_entry(cancel_work, &fp->blocked_works,
 				 fp_entry) {
-		list_del(&cancel_work->fp_entry);
 		cancel_work->state = KSMBD_WORK_CLOSED;
 		cancel_work->cancel_fn(cancel_work->cancel_argv);
 	}
@@ -386,15 +374,20 @@ int ksmbd_close_fd(struct ksmbd_work *work, u64 id)
 		return 0;
 
 	ft = &work->sess->file_table;
-	read_lock(&ft->lock);
+	write_lock(&ft->lock);
 	fp = idr_find(ft->idr, id);
 	if (fp) {
 		set_close_state_blocked_works(fp);
 
-		if (!atomic_dec_and_test(&fp->refcount))
+		if (fp->f_state != FP_INITED)
 			fp = NULL;
+		else {
+			fp->f_state = FP_CLOSED;
+			if (!atomic_dec_and_test(&fp->refcount))
+				fp = NULL;
+		}
 	}
-	read_unlock(&ft->lock);
+	write_unlock(&ft->lock);
 
 	if (!fp)
 		return -EINVAL;
@@ -484,12 +477,15 @@ struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid)
 	return fp;
 }
 
-struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode)
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry)
 {
 	struct ksmbd_file	*lfp;
 	struct ksmbd_inode	*ci;
+	struct inode		*inode = d_inode(dentry);
 
-	ci = ksmbd_inode_lookup_by_vfsinode(inode);
+	read_lock(&inode_hash_lock);
+	ci = __ksmbd_inode_lookup(dentry);
+	read_unlock(&inode_hash_lock);
 	if (!ci)
 		return NULL;
 
@@ -574,6 +570,7 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 	fp->tcon		= work->tcon;
 	fp->volatile_id		= KSMBD_NO_FID;
 	fp->persistent_id	= KSMBD_NO_FID;
+	fp->f_state		= FP_NEW;
 	fp->f_ci		= ksmbd_inode_get(fp);
 
 	if (!fp->f_ci) {
@@ -595,6 +592,17 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 	return ERR_PTR(ret);
 }
 
+void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
+			 unsigned int state)
+{
+	if (!fp)
+		return;
+
+	write_lock(&ft->lock);
+	fp->f_state = state;
+	write_unlock(&ft->lock);
+}
+
 static int
 __close_file_table_ids(struct ksmbd_file_table *ft,
 		       struct ksmbd_tree_connect *tcon,
diff --git a/fs/ksmbd/vfs_cache.h b/fs/ksmbd/vfs_cache.h
index 448576fbe4b7..8325cf4527c4 100644
--- a/fs/ksmbd/vfs_cache.h
+++ b/fs/ksmbd/vfs_cache.h
@@ -51,7 +51,7 @@ struct ksmbd_inode {
 	atomic_t			op_count;
 	/* opinfo count for streams */
 	atomic_t			sop_count;
-	struct inode			*m_inode;
+	struct dentry			*m_de;
 	unsigned int			m_flags;
 	struct hlist_node		m_hash;
 	struct list_head		m_fp_list;
@@ -60,9 +60,14 @@ struct ksmbd_inode {
 	__le32				m_fattr;
 };
 
+enum {
+	FP_NEW = 0,
+	FP_INITED,
+	FP_CLOSED
+};
+
 struct ksmbd_file {
 	struct file			*filp;
-	char				*filename;
 	u64				persistent_id;
 	u64				volatile_id;
 
@@ -96,19 +101,10 @@ struct ksmbd_file {
 
 	int				durable_timeout;
 
-	/* for SMB1 */
-	int				pid;
-
-	/* conflict lock fail count for SMB1 */
-	unsigned int			cflock_cnt;
-	/* last lock failure start offset for SMB1 */
-	unsigned long long		llock_fstart;
-
-	int				dirent_offset;
-
 	/* if ls is happening on directory, below is valid*/
 	struct ksmbd_readdir_data	readdir_data;
 	int				dot_dotdot[2];
+	unsigned int			f_state;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
@@ -144,7 +140,7 @@ struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
 void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id);
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
-struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode);
+struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
 unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp);
 void ksmbd_close_tree_conn_fds(struct ksmbd_work *work);
@@ -153,6 +149,8 @@ int ksmbd_close_inode_fds(struct ksmbd_work *work, struct inode *inode);
 int ksmbd_init_global_file_table(void);
 void ksmbd_free_global_file_table(void);
 void ksmbd_set_fd_limit(unsigned long limit);
+void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
+			 unsigned int state);
 
 /*
  * INODE hash
@@ -166,7 +164,7 @@ enum KSMBD_INODE_STATUS {
 	KSMBD_INODE_STATUS_PENDING_DELETE,
 };
 
-int ksmbd_query_inode_status(struct inode *inode);
+int ksmbd_query_inode_status(struct dentry *dentry);
 bool ksmbd_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_clear_inode_pending_delete(struct ksmbd_file *fp);
diff --git a/fs/namei.c b/fs/namei.c
index ea2785103376..a7f88c5b3d90 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -252,6 +252,7 @@ getname_kernel(const char * filename)
 
 	return result;
 }
+EXPORT_SYMBOL(getname_kernel);
 
 void putname(struct filename *name)
 {
@@ -269,6 +270,7 @@ void putname(struct filename *name)
 	} else
 		__putname(name);
 }
+EXPORT_SYMBOL(putname);
 
 /**
  * check_acl - perform ACL permission checking
@@ -1539,8 +1541,9 @@ static struct dentry *lookup_dcache(const struct qstr *name,
  * when directory is guaranteed to have no in-lookup children
  * at all.
  */
-static struct dentry *__lookup_hash(const struct qstr *name,
-		struct dentry *base, unsigned int flags)
+struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+				    struct dentry *base,
+				    unsigned int flags)
 {
 	struct dentry *dentry = lookup_dcache(name, base, flags);
 	struct dentry *old;
@@ -1564,6 +1567,7 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 	}
 	return dentry;
 }
+EXPORT_SYMBOL(lookup_one_qstr_excl);
 
 static struct dentry *lookup_fast(struct nameidata *nd,
 				  struct inode **inode,
@@ -2508,16 +2512,17 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 }
 
 /* Note: this does not consume "name" */
-static int filename_parentat(int dfd, struct filename *name,
-			     unsigned int flags, struct path *parent,
-			     struct qstr *last, int *type)
+static int __filename_parentat(int dfd, struct filename *name,
+			       unsigned int flags, struct path *parent,
+			       struct qstr *last, int *type,
+			       const struct path *root)
 {
 	int retval;
 	struct nameidata nd;
 
 	if (IS_ERR(name))
 		return PTR_ERR(name);
-	set_nameidata(&nd, dfd, name, NULL);
+	set_nameidata(&nd, dfd, name, root);
 	retval = path_parentat(&nd, flags | LOOKUP_RCU, parent);
 	if (unlikely(retval == -ECHILD))
 		retval = path_parentat(&nd, flags, parent);
@@ -2532,6 +2537,13 @@ static int filename_parentat(int dfd, struct filename *name,
 	return retval;
 }
 
+static int filename_parentat(int dfd, struct filename *name,
+			     unsigned int flags, struct path *parent,
+			     struct qstr *last, int *type)
+{
+	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
+}
+
 /* does lookup, returns the object with parent locked */
 static struct dentry *__kern_path_locked(struct filename *name, struct path *path)
 {
@@ -2547,7 +2559,7 @@ static struct dentry *__kern_path_locked(struct filename *name, struct path *pat
 		return ERR_PTR(-EINVAL);
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	d = __lookup_hash(&last, path->dentry, 0);
+	d = lookup_one_qstr_excl(&last, path->dentry, 0);
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
@@ -2575,6 +2587,24 @@ int kern_path(const char *name, unsigned int flags, struct path *path)
 }
 EXPORT_SYMBOL(kern_path);
 
+/**
+ * vfs_path_parent_lookup - lookup a parent path relative to a dentry-vfsmount pair
+ * @filename: filename structure
+ * @flags: lookup flags
+ * @parent: pointer to struct path to fill
+ * @last: last component
+ * @type: type of the last component
+ * @root: pointer to struct path of the base directory
+ */
+int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
+			   struct path *parent, struct qstr *last, int *type,
+			   const struct path *root)
+{
+	return  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
+				    type, root);
+}
+EXPORT_SYMBOL(vfs_path_parent_lookup);
+
 /**
  * vfs_path_lookup - lookup a file path relative to a dentry-vfsmount pair
  * @dentry:  pointer to dentry of the base directory
@@ -2956,20 +2986,10 @@ static inline int may_create(struct user_namespace *mnt_userns,
 	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 }
 
-/*
- * p1 and p2 should be directories on the same fs.
- */
-struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 {
 	struct dentry *p;
 
-	if (p1 == p2) {
-		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-		return NULL;
-	}
-
-	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
-
 	p = d_ancestor(p2, p1);
 	if (p) {
 		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
@@ -2988,8 +3008,64 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 			I_MUTEX_PARENT, I_MUTEX_PARENT2);
 	return NULL;
 }
+
+/*
+ * p1 and p2 should be directories on the same fs.
+ */
+struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+{
+	if (p1 == p2) {
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+		return NULL;
+	}
+
+	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
+	return lock_two_directories(p1, p2);
+}
 EXPORT_SYMBOL(lock_rename);
 
+/*
+ * c1 and p2 should be on the same fs.
+ */
+struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
+{
+	if (READ_ONCE(c1->d_parent) == p2) {
+		/*
+		 * hopefully won't need to touch ->s_vfs_rename_mutex at all.
+		 */
+		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+		/*
+		 * now that p2 is locked, nobody can move in or out of it,
+		 * so the test below is safe.
+		 */
+		if (likely(c1->d_parent == p2))
+			return NULL;
+
+		/*
+		 * c1 got moved out of p2 while we'd been taking locks;
+		 * unlock and fall back to slow case.
+		 */
+		inode_unlock(p2->d_inode);
+	}
+
+	mutex_lock(&c1->d_sb->s_vfs_rename_mutex);
+	/*
+	 * nobody can move out of any directories on this fs.
+	 */
+	if (likely(c1->d_parent != p2))
+		return lock_two_directories(c1->d_parent, p2);
+
+	/*
+	 * c1 got moved into p2 while we were taking locks;
+	 * we need p2 locked and ->s_vfs_rename_mutex unlocked,
+	 * for consistency with lock_rename().
+	 */
+	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+	mutex_unlock(&c1->d_sb->s_vfs_rename_mutex);
+	return NULL;
+}
+EXPORT_SYMBOL(lock_rename_child);
+
 void unlock_rename(struct dentry *p1, struct dentry *p2)
 {
 	inode_unlock(p1->d_inode);
@@ -3763,7 +3839,8 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	if (last.name[last.len] && !want_dir)
 		create_flags = 0;
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path->dentry, reval_flag | create_flags);
+	dentry = lookup_one_qstr_excl(&last, path->dentry,
+				      reval_flag | create_flags);
 	if (IS_ERR(dentry))
 		goto unlock;
 
@@ -4124,7 +4201,7 @@ int do_rmdir(int dfd, struct filename *name)
 		goto exit2;
 
 	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4258,7 +4335,7 @@ int do_unlinkat(int dfd, struct filename *name)
 		goto exit2;
 retry_deleg:
 	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		struct user_namespace *mnt_userns;
@@ -4832,7 +4909,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 retry_deleg:
 	trap = lock_rename(new_path.dentry, old_path.dentry);
 
-	old_dentry = __lookup_hash(&old_last, old_path.dentry, lookup_flags);
+	old_dentry = lookup_one_qstr_excl(&old_last, old_path.dentry,
+					  lookup_flags);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
@@ -4840,7 +4918,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	error = -ENOENT;
 	if (d_is_negative(old_dentry))
 		goto exit4;
-	new_dentry = __lookup_hash(&new_last, new_path.dentry, lookup_flags | target_flags);
+	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
+					  lookup_flags | target_flags);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto exit4;
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 00cbe31c8748..056ca8e563aa 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -471,10 +471,10 @@ static inline void kasan_free_shadow(const struct vm_struct *vm) {}
 
 #endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 void kasan_non_canonical_hook(unsigned long addr);
-#else /* CONFIG_KASAN */
+#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 static inline void kasan_non_canonical_hook(unsigned long addr) { }
-#endif /* CONFIG_KASAN */
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 #endif /* LINUX_KASAN_H */
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 40c693525f79..53c03d9ed34c 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -57,12 +57,18 @@ static inline int user_path_at(int dfd, const char __user *name, unsigned flags,
 	return user_path_at_empty(dfd, name, flags, path, NULL);
 }
 
+struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+				    struct dentry *base,
+				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
+int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
+			   struct path *parent, struct qstr *last, int *type,
+			   const struct path *root);
 int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
 		    unsigned int, struct path *);
 
@@ -83,6 +89,7 @@ extern int follow_down(struct path *);
 extern int follow_up(struct path *);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
+extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
 extern int __must_check nd_jump_link(struct path *path);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 0b3ee4eea51b..1c565db2de7b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -708,6 +708,36 @@ static struct notifier_block trace_kprobe_module_nb = {
 	.priority = 1	/* Invoked after kprobe module callback */
 };
 
+struct count_symbols_struct {
+	const char *func_name;
+	unsigned int count;
+};
+
+static int count_symbols(void *data, const char *name, struct module *unused0,
+			 unsigned long unused1)
+{
+	struct count_symbols_struct *args = data;
+
+	if (strcmp(args->func_name, name))
+		return 0;
+
+	args->count++;
+
+	return 0;
+}
+
+static unsigned int number_of_same_symbols(char *func_name)
+{
+	struct count_symbols_struct args = {
+		.func_name = func_name,
+		.count = 0,
+	};
+
+	kallsyms_on_each_symbol(count_symbols, &args);
+
+	return args.count;
+}
+
 static int __trace_kprobe_create(int argc, const char *argv[])
 {
 	/*
@@ -836,6 +866,31 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		}
 	}
 
+	if (symbol && !strchr(symbol, ':')) {
+		unsigned int count;
+
+		count = number_of_same_symbols(symbol);
+		if (count > 1) {
+			/*
+			 * Users should use ADDR to remove the ambiguity of
+			 * using KSYM only.
+			 */
+			trace_probe_log_err(0, NON_UNIQ_SYMBOL);
+			ret = -EADDRNOTAVAIL;
+
+			goto error;
+		} else if (count == 0) {
+			/*
+			 * We can return ENOENT earlier than when register the
+			 * kprobe.
+			 */
+			trace_probe_log_err(0, BAD_PROBE_ADDR);
+			ret = -ENOENT;
+
+			goto error;
+		}
+	}
+
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, buf,
@@ -1755,6 +1810,7 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
 }
 
 #ifdef CONFIG_PERF_EVENTS
+
 /* create a trace_kprobe, but don't add it to global lists */
 struct trace_event_call *
 create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
@@ -1765,6 +1821,24 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	int ret;
 	char *event;
 
+	if (func) {
+		unsigned int count;
+
+		count = number_of_same_symbols(func);
+		if (count > 1)
+			/*
+			 * Users should use addr to remove the ambiguity of
+			 * using func only.
+			 */
+			return ERR_PTR(-EADDRNOTAVAIL);
+		else if (count == 0)
+			/*
+			 * We can return ENOENT earlier than when register the
+			 * kprobe.
+			 */
+			return ERR_PTR(-ENOENT);
+	}
+
 	/*
 	 * local trace_kprobes are not added to dyn_event, so they are never
 	 * searched in find_trace_kprobe(). Therefore, there is no concern of
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 0f0e5005b97a..82e1df8aefcb 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -405,6 +405,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_MAXACT,		"Invalid maxactive number"),		\
 	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
 	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
+	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
 	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 1c929d964dde..8786cdfeaa91 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -457,8 +457,9 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	return ret;
 }
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 /*
- * With CONFIG_KASAN, accesses to bogus pointers (outside the high
+ * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
  * canonical half of the address space) cause out-of-bounds shadow memory reads
  * before the actual access. For addresses in the low canonical half of the
  * address space, as well as most non-canonical addresses, that out-of-bounds
@@ -494,3 +495,4 @@ void kasan_non_canonical_hook(unsigned long addr)
 	pr_alert("KASAN: %s in range [0x%016lx-0x%016lx]\n", bug_type,
 		 orig_addr, orig_addr + KASAN_GRANULE_SIZE - 1);
 }
+#endif

