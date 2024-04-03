Return-Path: <linux-kernel+bounces-129162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCAC896642
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93AC4B23FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85B6F524;
	Wed,  3 Apr 2024 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="uW854BK8"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2626DD08
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128915; cv=none; b=s27V2REFwdqgFY9SqjgNYutU/xnFrMDd8v4MwPhpzzHIdixUFmOY+uzS+RFw0KCJcmhx8I/Ak+G2ZiCwV4fZk4Wc85EHM4n4C2C23sufuwr/xGs5FrwSa2h7jyKouUulxQdymhHIGQoHU2idplfdWiMmk9I7fT7Y9IHin5X96kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128915; c=relaxed/simple;
	bh=YwCTtSxtOVaFrBMehGFPkK05qlCv/3lFORgK1gDJgN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtZzO7bUhNEhGABX+c/tgVvPmIRUzKxH5SPZY8HpZuuXoh/rcT2CZVOOpkMPF5l6ySY2IMsvuQ7Py5xKsUrYykuQZgg37R7PTwpU/dxHFsL6gJjKkgItcWD3jfaPf8tozWgsQaug2hMRre24hno4gafz3PEU3XnFZhzyOK6V6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=uW854BK8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41624c40b44so897735e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1712128912; x=1712733712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht1KLnNvKBCCICp+Y6JpKOSNrIWAe17k5/lz/+k/t0k=;
        b=uW854BK8iRab+dLisa+IbHPHJgwWKAKDISQ819SOYm1n3kgAF7WCNlqinyILIpJ2hI
         TGaQsz83vXduS0LjJAvE/5vDlZjmpGnTcq2/i2obKcAXtecd5iyzhn/HVL0v9CuaIoR+
         NIgoZQGNZZ6aYzLBkQNOtUajyD5C57G3czNHbSAtIKou8RtsxCbESzp8/Fkm4uPr1h/Q
         SHfuuM62iVAxN0aybNchd0oj8lS+U3QV9m2sQrQjrDP+VVZJhmR13Fk4FMPhqkHayZUP
         SXlWNSI6VrBviYkHIBADSh+q2qzJPbK+fVi7zA82Otz95blwYrofBZUHW1ma6NCe7mfC
         8diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712128912; x=1712733712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ht1KLnNvKBCCICp+Y6JpKOSNrIWAe17k5/lz/+k/t0k=;
        b=loaykPQJPQDPu1MJaZPRX87uARRuqv3xXQdK/R9M/wx3PlzFVzJvYZooOFr3ykpGMm
         7LaqiBGWlQlsdcSU2qbzw2B1yxpj1GTLyop1bDoDnHCskxoFjh34D3oeiunTYkkI8zcZ
         GKkpmqWIY/HqFdgGudFaXAxBdOGaCASlYrhYzU+/MLVP8oAlDkeq4P8BqPaX0zxY69zu
         na+PNBx3C4SR6pPJih0/Ewq7tSUk5+S0XNJmvQeYpfWHXWJ5Nj33DmkrtjRZIsUFfhls
         IdOccr/snzTXnvzauFHMdKiwhJDJdUzG5aGkPGBv0DlotSkvGizvz7frFT/7+b9YiCSm
         4uEw==
X-Forwarded-Encrypted: i=1; AJvYcCUWfUZbOZSdbs4EO9S5uH7rtn1kQSgS8P6ppHl+QS3KTm2Tmb/NtACr2Kl7sI9EzVFdNrsNAdRd21TjfWHO5bpFPKjbOPEVBYrqvct2
X-Gm-Message-State: AOJu0YzbQxwfYxzzuNL8bHLQNz0Gg9H7ncP/oDDaPl3Cg9EUp8lwBCxf
	QuiIgIUBvjo+stocFYXovqWdamyR53FJxZWOpJ0+PxGVahANRmeYqPI5eIUw8i0=
X-Google-Smtp-Source: AGHT+IHxnLJChRG6eyzjNgzPrS0ONsTJ00ZbGMzOG5HnqpNOaErE7IvWFJCS+7/AvipAmrK+4XCdlA==
X-Received: by 2002:a05:600c:2d06:b0:413:e19:337f with SMTP id x6-20020a05600c2d0600b004130e19337fmr3324441wmf.22.1712128912023;
        Wed, 03 Apr 2024 00:21:52 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id f11-20020a05600c4e8b00b004154e48bcdesm17187826wmq.14.2024.04.03.00.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:21:51 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <jejb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Gstir <david@sigma-star.at>,
	Shawn Guo <shawnguo@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	David Howells <dhowells@redhat.com>,
	Li Yang <leoyang.li@nxp.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-security-module@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v8 6/6] docs: trusted-encrypted: add DCP as new trust source
Date: Wed,  3 Apr 2024 09:21:22 +0200
Message-ID: <20240403072131.54935-7-david@sigma-star.at>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403072131.54935-1-david@sigma-star.at>
References: <20240403072131.54935-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation for trusted and encrypted KEYS with DCP as new
trust source:

- Describe security properties of DCP trust source
- Describe key usage
- Document blob format

Co-developed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
Co-developed-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Gstir <david@sigma-star.at>
---
 .../security/keys/trusted-encrypted.rst       | 53 +++++++++++++++++++
 security/keys/trusted-keys/trusted_dcp.c      | 19 +++++++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index e989b9802f92..f4d7e162d5e4 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -42,6 +42,14 @@ safe.
          randomly generated and fused into each SoC at manufacturing time.
          Otherwise, a common fixed test key is used instead.
 
+     (4) DCP (Data Co-Processor: crypto accelerator of various i.MX SoCs)
+
+         Rooted to a one-time programmable key (OTP) that is generally burnt
+         in the on-chip fuses and is accessible to the DCP encryption engine only.
+         DCP provides two keys that can be used as root of trust: the OTP key
+         and the UNIQUE key. Default is to use the UNIQUE key, but selecting
+         the OTP key can be done via a module parameter (dcp_use_otp_key).
+
   *  Execution isolation
 
      (1) TPM
@@ -57,6 +65,12 @@ safe.
 
          Fixed set of operations running in isolated execution environment.
 
+     (4) DCP
+
+         Fixed set of cryptographic operations running in isolated execution
+         environment. Only basic blob key encryption is executed there.
+         The actual key sealing/unsealing is done on main processor/kernel space.
+
   * Optional binding to platform integrity state
 
      (1) TPM
@@ -79,6 +93,11 @@ safe.
          Relies on the High Assurance Boot (HAB) mechanism of NXP SoCs
          for platform integrity.
 
+     (4) DCP
+
+         Relies on Secure/Trusted boot process (called HAB by vendor) for
+         platform integrity.
+
   *  Interfaces and APIs
 
      (1) TPM
@@ -94,6 +113,11 @@ safe.
 
          Interface is specific to silicon vendor.
 
+     (4) DCP
+
+         Vendor-specific API that is implemented as part of the DCP crypto driver in
+         ``drivers/crypto/mxs-dcp.c``.
+
   *  Threat model
 
      The strength and appropriateness of a particular trust source for a given
@@ -129,6 +153,13 @@ selected trust source:
      CAAM HWRNG, enable CRYPTO_DEV_FSL_CAAM_RNG_API and ensure the device
      is probed.
 
+  *  DCP (Data Co-Processor: crypto accelerator of various i.MX SoCs)
+
+     The DCP hardware device itself does not provide a dedicated RNG interface,
+     so the kernel default RNG is used. SoCs with DCP like the i.MX6ULL do have
+     a dedicated hardware RNG that is independent from DCP which can be enabled
+     to back the kernel RNG.
+
 Users may override this by specifying ``trusted.rng=kernel`` on the kernel
 command-line to override the used RNG with the kernel's random number pool.
 
@@ -231,6 +262,19 @@ Usage::
 CAAM-specific format.  The key length for new keys is always in bytes.
 Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
 
+Trusted Keys usage: DCP
+-----------------------
+
+Usage::
+
+    keyctl add trusted name "new keylen" ring
+    keyctl add trusted name "load hex_blob" ring
+    keyctl print keyid
+
+"keyctl print" returns an ASCII hex copy of the sealed key, which is in format
+specific to this DCP key-blob implementation.  The key length for new keys is
+always in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
+
 Encrypted Keys usage
 --------------------
 
@@ -426,3 +470,12 @@ string length.
 privkey is the binary representation of TPM2B_PUBLIC excluding the
 initial TPM2B header which can be reconstructed from the ASN.1 octed
 string length.
+
+DCP Blob Format
+---------------
+
+.. kernel-doc:: security/keys/trusted-keys/trusted_dcp.c
+   :doc: dcp blob format
+
+.. kernel-doc:: security/keys/trusted-keys/trusted_dcp.c
+   :identifiers: struct dcp_blob_fmt
diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index 16c44aafeab3..b5f81a05be36 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -19,6 +19,25 @@
 #define DCP_BLOB_VERSION 1
 #define DCP_BLOB_AUTHLEN 16
 
+/**
+ * DOC: dcp blob format
+ *
+ * The Data Co-Processor (DCP) provides hardware-bound AES keys using its
+ * AES encryption engine only. It does not provide direct key sealing/unsealing.
+ * To make DCP hardware encryption keys usable as trust source, we define
+ * our own custom format that uses a hardware-bound key to secure the sealing
+ * key stored in the key blob.
+ *
+ * Whenever a new trusted key using DCP is generated, we generate a random 128-bit
+ * blob encryption key (BEK) and 128-bit nonce. The BEK and nonce are used to
+ * encrypt the trusted key payload using AES-128-GCM.
+ *
+ * The BEK itself is encrypted using the hardware-bound key using the DCP's AES
+ * encryption engine with AES-128-ECB. The encrypted BEK, generated nonce,
+ * BEK-encrypted payload and authentication tag make up the blob format together
+ * with a version number, payload length and authentication tag.
+ */
+
 /**
  * struct dcp_blob_fmt - DCP BLOB format.
  *
-- 
2.35.3


