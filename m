Return-Path: <linux-kernel+bounces-95821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BB1875363
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04491F251EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E583912F380;
	Thu,  7 Mar 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="JAvWO9KN"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A812FB23
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825947; cv=none; b=tZ/xcH/SY06MMCMpcngTn5/6loAoNS0KxNspUKZsaxO1BLTRWfxHt3oOeZeblhbx1CSLPpEe13XRMjV22L4j5nvKQo66aU7jq0cfpAo82wY2Y3GrpVOdF7+V/SgKi2y8pk7biAKYSWQC0VxHBwqf3hX8hZQN+sY9wkemmxQbEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825947; c=relaxed/simple;
	bh=A0O6/w7bbUy1TrcLSjuH9e83BoPYKup6oiJvr7VavE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/P+CfWe9/uR+7jfisefKi99F7ROfs7yqnZJZR7MG9WJsz5kXHLytNOqPSWcUsxwNZ/QVChjPvEatf8K4gQDIzPuPlI77NINKyFuoMvK4eETUjhX1898+wDhk38E/4+73doBl1yTJKBjZFtyZUgou9hMGnAdLVj6jxz/fQ2cBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=JAvWO9KN; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so12055981fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 07:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1709825944; x=1710430744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5byLpxSkDHpWtFqk+o0iXmSYvszrS7+YdXxWavlXQY=;
        b=JAvWO9KNPCWPeNiKas3mCKiB18zgWaGnFoppsCH7DfyWJx7CHooFSfJDD90LGuKjew
         wrS4oJIJtLpO+rFHNsBjHa2wlo22w4+4+UTYWgm1Q34YiGe7fnh6BmLu3mWEQkRSKbeC
         EQUGztP2DxfJjxVPDMgPxDQyhF/ivSacxEgIlygjozM1SIe5AyK4ubpdcfslNlNmh/Lf
         VUuM45cRJL0o1Twq05Ai/NDpZFPTy/ls16uRBcNzeuCpl9Qi+Y/8FeMM4ivJ40NXZaLs
         udq4jjOVQQlro9TwSR7BYmZIVlNvsNeadmj8R6Trk0kI8HhdppjqkTC+nIgYJ8WXmcUL
         cMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709825944; x=1710430744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5byLpxSkDHpWtFqk+o0iXmSYvszrS7+YdXxWavlXQY=;
        b=XU6J2XahP3GmvU8ocwVbVZjB5mHe1YJ2ROHcS9InBcr6G+AoCdfdfRXYOxerprYcfC
         ALQTPjVxPtZMQA6W/EZzAv6vJ5YcAUPupAuP066l9A/Ri48OGVYCuaCmTLA8STFwtPE/
         yHAQ+rdHCkP6lIML1LS2DtA/Lr592kU+kZvj9T52lHyqUCJcePIZeDFK3nQ/2xGY3z6R
         L069B7jMJ66Pye+ZLigbdeBonFh3kAn4XTqaeu0eIefWtY3gAeG1wMzU00adQRIjXzKV
         JWGA01aF08mSh9cbs7mko8ZjYi8HyfZK1MFCqs4xxEjtip2veA7xeuUkCRwIuAfia+iy
         uD/A==
X-Forwarded-Encrypted: i=1; AJvYcCVGLKX8UpBqx8H87WhG8bYum2A8AWXob7eJMxPPYCUEtwZxwC1ACX4cIwvJ+qsxYe0Ju83yr0LnmOy5pr0lYchdn565Y2BHA+GPU7Ae
X-Gm-Message-State: AOJu0Yz7iIEZgoLCLweuFxAytVSRBzRsRW9f0xCYa75puuNT4dxVn5PP
	Jvthupq9nrsIQynrqR0TAFPJ+tNk2N9WgxVUoWbx6ZBLt6iIX84MfbFUud7S8xI=
X-Google-Smtp-Source: AGHT+IH+LPdv4uI8ZtpLAROMjGCY94DX6j2AvsclNLplVSroc4bHXuz/v1iWuKlTq88uAf/Bob4Hwg==
X-Received: by 2002:a2e:a99f:0:b0:2d3:2a95:6f0b with SMTP id x31-20020a2ea99f000000b002d32a956f0bmr1921680ljq.12.1709825944291;
        Thu, 07 Mar 2024 07:39:04 -0800 (PST)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id n24-20020a05640204d800b00566f92f1facsm6501964edw.36.2024.03.07.07.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 07:39:04 -0800 (PST)
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
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 2/6] KEYS: trusted: improve scalability of trust source config
Date: Thu,  7 Mar 2024 16:38:29 +0100
Message-ID: <20240307153842.80033-3-david@sigma-star.at>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307153842.80033-1-david@sigma-star.at>
References: <20240307153842.80033-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling trusted keys requires at least one trust source implementation
(currently TPM, TEE or CAAM) to be enabled. Currently, this is
done by checking each trust source's config option individually.
This does not scale when more trust sources like the one for DCP
are added.

Add config HAVE_TRUSTED_KEYS which is set to true by each trust source
once its enabled and adapt the check for having at least one active trust
source to use this option. Whenever a new trust source is added, it now
needs to select HAVE_TRUSTED_KEYS.

Signed-off-by: David Gstir <david@sigma-star.at>
---
 security/keys/trusted-keys/Kconfig | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index dbfdd8536468..553dc117f385 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -1,3 +1,6 @@
+config HAVE_TRUSTED_KEYS
+	bool
+
 config TRUSTED_KEYS_TPM
 	bool "TPM-based trusted keys"
 	depends on TCG_TPM >= TRUSTED_KEYS
@@ -9,6 +12,7 @@ config TRUSTED_KEYS_TPM
 	select ASN1_ENCODER
 	select OID_REGISTRY
 	select ASN1
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Platform Module (TPM) as trusted key
 	  backend. Trusted keys are random number symmetric keys,
@@ -20,6 +24,7 @@ config TRUSTED_KEYS_TEE
 	bool "TEE-based trusted keys"
 	depends on TEE >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Execution Environment (TEE) as trusted
 	  key backend.
@@ -29,10 +34,11 @@ config TRUSTED_KEYS_CAAM
 	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
 	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
 	default y
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
 	  (CAAM) as trusted key backend.
 
-if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE && !TRUSTED_KEYS_CAAM
-comment "No trust source selected!"
+if !HAVE_TRUSTED_KEYS
+	comment "No trust source selected!"
 endif
-- 
2.35.3


