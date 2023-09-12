Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3971E79CFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjILLOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjILLMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:12:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A73172A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:11:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so7036997a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1694517117; x=1695121917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qntkmutwprS+2oQeQzgmaP97TAaIsTbzLeg5qvDo3I=;
        b=iMzepLjNMKLJcQYvd5fyO+0ZOQ90UpaYBgzGzIm7H58asy0ZRDjtnwgLLDhr+Y7RoA
         PFDxp0+dLGLpL0AwUT/sT5su7Rl7SnVKKRCb6T3uFCWjDYrvt5JucNYAJA7tz4x6qwFZ
         6QFX6rvRGgY4PqLVTvn3fI/Wvuhcf0VKmq/x3Xg+MvjsOL9iKAEmMaR3L70dtVWKT5WM
         j+/scgZ5VdLXCIfJ2CsmT5Yhb6r9gkEEnnImnm3cIviardcyc7Hp78CS24ILZFWLp41l
         5ac+povKJbVzTzodm+nFR2y7QknUg+9UKV+bMPwkxNHADXXpzARlF8CkYBaytmRQ+KYE
         bsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694517117; x=1695121917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qntkmutwprS+2oQeQzgmaP97TAaIsTbzLeg5qvDo3I=;
        b=n0SdVMJAGcSRVySTVV+BrrB+xpu2ojLOx/DAw5ceJhUive7j0Obr+6GdOueYnpcEGR
         fBdtFmM1eVQoqxKKOK9KIwEp40DVElCA6TvCKCVsE0gAoalV9TWnNcyJwfDT1vIJKuqu
         lgVh5VIJ0rrQC/RBMHc0vUbfoyVemUnUHL71SdDQYw66wfhjaWCo4l0OyOCZgtNlrsfr
         mU0LvC/hjZrqSUFaZO4AGRiONuZmIil0iVPAc5bfsolQ0vLl6j/KTkp/rc0FvQOXwWf+
         8PykMr6RGmrulJnxtVS+EKtEneYdgksdEP2R42NJKlA38PNYAhrNYR1gej/w91EE7SLQ
         tYFQ==
X-Gm-Message-State: AOJu0YwqqMtqqInpfY3IVLrYJb1rT0luA0n3X40IM+2p6Fk/IijCHCkp
        2nhQmQ/IKXozva5MF4MtnSAWDA==
X-Google-Smtp-Source: AGHT+IFcfRE8ddxwpToYbqFfRtOil3lX24xXTcYqNYqRo7uISxMJRRm2P8R9+XFaZVp+WcaxzQj80A==
X-Received: by 2002:a17:906:51c8:b0:9a9:e4ce:c9a2 with SMTP id v8-20020a17090651c800b009a9e4cec9a2mr10496806ejk.53.1694517117122;
        Tue, 12 Sep 2023 04:11:57 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id u17-20020a170906069100b009a5f7fb51d5sm6638903ejb.21.2023.09.12.04.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:11:56 -0700 (PDT)
From:   David Gstir <david@sigma-star.at>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     David Gstir <david@sigma-star.at>, Shawn Guo <shawnguo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        sigma star Kernel Team <upstream+dcp@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        Li Yang <leoyang.li@nxp.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v2 3/3] doc: trusted-encrypted: add DCP as new trust source
Date:   Tue, 12 Sep 2023 13:11:14 +0200
Message-ID: <20230912111115.24274-4-david@sigma-star.at>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912111115.24274-1-david@sigma-star.at>
References: <20230912111115.24274-1-david@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 .../security/keys/trusted-encrypted.rst       | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 9bc9db8ec651..4452070afbe9 100644
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
 
@@ -426,3 +470,44 @@ string length.
 privkey is the binary representation of TPM2B_PUBLIC excluding the
 initial TPM2B header which can be reconstructed from the ASN.1 octed
 string length.
+
+DCP Blob Format
+---------------
+
+The Data Co-Processor (DCP) provides hardware-bound AES keys using its
+AES encryption engine only. It does not provide direct key sealing/unsealing.
+To make DCP hardware encryption keys usable as trust source, we define
+our own custom format that uses a hardware-bound key to secure the sealing
+key stored in the key blob.
+
+Whenever a new trusted key using DCP is generated, we generate a random 128-bit
+blob encryption key (BEK) and 128-bit nonce. The BEK and nonce are used to
+encrypt the trusted key payload using AES-128-GCM.
+
+The BEK itself is encrypted using the hardware-bound key using the DCP's AES
+encryption engine with AES-128-ECB. The encrypted BEK, generated nonce,
+BEK-encrypted payload and authentication tag make up the blob format together
+with a version number, payload length and authentication tag::
+
+    /*
+     * struct dcp_blob_fmt - DCP BLOB format.
+     *
+     * @fmt_version: Format version, currently being %1
+     * @blob_key: Random AES 128 key which is used to encrypt @payload,
+     *            @blob_key itself is encrypted with OTP or UNIQUE device key in
+     *            AES-128-ECB mode by DCP.
+     * @nonce: Random nonce used for @payload encryption.
+     * @payload_len: Length of the plain text @payload.
+     * @payload: The payload itself, encrypted using AES-128-GCM and @blob_key,
+     *           GCM auth tag of size AES_BLOCK_SIZE is attached at the end of it.
+     *
+     * The total size of a DCP BLOB is sizeof(struct dcp_blob_fmt) + @payload_len +
+     * AES_BLOCK_SIZE.
+     */
+    struct dcp_blob_fmt {
+            __u8 fmt_version;
+            __u8 blob_key[AES_KEYSIZE_128];
+            __u8 nonce[AES_KEYSIZE_128];
+            __le32 payload_len;
+            __u8 payload[];
+    } __packed;
-- 
2.35.3

