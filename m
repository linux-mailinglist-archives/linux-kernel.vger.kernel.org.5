Return-Path: <linux-kernel+bounces-168343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4C18BB704
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C48F1C24744
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DCA5B5D6;
	Fri,  3 May 2024 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="O2p0+Ztz"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F567E79F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774628; cv=none; b=YW2hi6k+4AHBYpUvRTvrsSqXP1uyj6oQd/8T2+0UbcPl7fW/KeShoufweki0GsAsd0XGbR/6i5iCHUTkz2RqkP4iytn2bFZPSQPxWINrPA3hnomkJupoJDzDaHl4g/DKyn6v44z0ohspX/Y6d1VJcbivi+xOPFxefLiQzctsZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774628; c=relaxed/simple;
	bh=wr3vNqQBg1Lyk5k85X61GyHRBEKLjqBseZ99Ryz7g9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lU1r+wKY5v220r5g9HKaWCSD+rF1TRhkAToU6qdKd0lqXquOP4ea9fgD42W5/eReyLgQbiX3rbcg4/zgAN53mvDlTOY/7BMYg5WIzITY3OtqR/Mx9JvxB7PIdEmsjWcMKzI9geA+NvRXLKMSsEwR0GChJ7SzQbAH8sRiqWu+oWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=O2p0+Ztz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ba0bb5837so1878165e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 15:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1714774625; x=1715379425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1bFdRvB80MlNQ5C206sTg/ru4C64YyLq7dEp4BhNg8=;
        b=O2p0+ZtzduRcD98d5TOWybODS0E+KcDda7hkDS18YLbZx+yBa48UoWxEhiO78v1Ayo
         YkizC4UcQCZrTlr7muBvcyN+ObFjJ4J6HJFaIZ0KcU4mInDss2TXvX8RLz+CtIN6DY3l
         SqTn9QZ8kcZufzMUpOShpqf0Gh267sYXoVpmzoBPSi6+ipWJ1c+YFKy7e0y+2N7w7riN
         nCrGE99lJywEP6i5OP7bwE0jLruX137mf7KqLoap4duORypMBjocVb+nlGqidhz5439u
         KbedIlzZEaL7pElcw5Vv2yc0CHdiRnMCdaU+jZWkWtQcWs1hA5Jh8DK6OjSbg2UNaExf
         nC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714774625; x=1715379425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1bFdRvB80MlNQ5C206sTg/ru4C64YyLq7dEp4BhNg8=;
        b=njHQw5GvFZgIX4t0+XCCjoqXsxzUMMVoLPVEigrXz3PZPCzlrLjnBmwmsk3RXRAMiO
         ciaOZD8Mpa9ZfjCRbQcji0jzvSgsUG79R6k8xXOXRTqh0XIIt6wmErwzW/K0NHaFlb0C
         YCvGir3HECahKIyhDNAktBtLq7HeoafqP4XnBSO/3VhfPx3IAZVevjCAAAF/X0aynLST
         nJ+XrwZkqVrx4WgPGa5xccyqcq3n34wfE3+rgmB7WsFELruO1KI/wENlGGA6KGqSdxPI
         ek9SSzkH3ZN9Mp1eTgOqNIqEhR+WYZGi62wh8xgDof44M2V6dHFLenaF9bwMItcd8Kjp
         PcRw==
X-Forwarded-Encrypted: i=1; AJvYcCWrGLB9M9O+IQobUh8YVKx8imIH7RfRQCLObBhgbv2W3bJqUaC/I+J0IKFEpz+p4cCv3NWiqhlZXH8F4gSoWnJ1SKrqHtLHMMMhErbU
X-Gm-Message-State: AOJu0Yx7kzt/vEx4PFTl8zVIxiGWQ3gjP1Orl/0V8z39lUofPPvFWPiU
	xUd8HbTwvy1bD1cAtIEj9DbCDV/FtgjiEatoLw0njtUhva+EqYCByRwfK0akffkm/KdEfxSVChb
	N/2U=
X-Google-Smtp-Source: AGHT+IFRCprfR1xmbOeYjnqYbSqeYX7ff/SQYx3k+IbY6hrZcmf3zLJbE17DrfAfR//jCInXZEu+dg==
X-Received: by 2002:a05:600c:5251:b0:418:e04b:ee63 with SMTP id fc17-20020a05600c525100b00418e04bee63mr3012210wmb.36.1714774625053;
        Fri, 03 May 2024 15:17:05 -0700 (PDT)
Received: from localhost.localdomain ([104.28.200.6])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b0041563096e15sm10873368wms.5.2024.05.03.15.17.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 May 2024 15:17:04 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [RFC PATCH 1/2] tpm: add some algorithm and constant definitions from the TPM spec
Date: Fri,  3 May 2024 23:16:33 +0100
Message-Id: <20240503221634.44274-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240503221634.44274-1-ignat@cloudflare.com>
References: <20240503221634.44274-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for implementing TPM derived keys we need to use some new TPM
functionality in the kernel, so add relevant constant definitions.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 include/linux/tpm.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4ee9d13749ad..5be0808b1b91 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -35,6 +35,7 @@ struct trusted_key_options;
 enum tpm_algorithms {
 	TPM_ALG_ERROR		= 0x0000,
 	TPM_ALG_SHA1		= 0x0004,
+	TPM_ALG_HMAC		= 0x0005,
 	TPM_ALG_KEYEDHASH	= 0x0008,
 	TPM_ALG_SHA256		= 0x000B,
 	TPM_ALG_SHA384		= 0x000C,
@@ -209,6 +210,7 @@ enum tpm2_return_codes {
 	TPM2_RC_DISABLED	= 0x0120,
 	TPM2_RC_UPGRADE		= 0x012D,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
+	TPM2_RC_OBJECT_MEMORY	= 0x0902,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
 	TPM2_RC_RETRY		= 0x0922,
@@ -227,6 +229,7 @@ enum tpm2_command_codes {
 	TPM2_CC_CREATE		        = 0x0153,
 	TPM2_CC_LOAD		        = 0x0157,
 	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
+	TPM2_CC_SIGN		        = 0x015D,
 	TPM2_CC_UNSEAL		        = 0x015E,
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
@@ -234,6 +237,7 @@ enum tpm2_command_codes {
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
 	TPM2_CC_GET_CAPABILITY	        = 0x017A,
 	TPM2_CC_GET_RANDOM	        = 0x017B,
+	TPM2_CC_HASH	        	= 0x017D,
 	TPM2_CC_PCR_READ	        = 0x017E,
 	TPM2_CC_PCR_EXTEND	        = 0x0182,
 	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
@@ -243,7 +247,8 @@ enum tpm2_command_codes {
 };
 
 enum tpm2_permanent_handles {
-	TPM2_RS_PW		= 0x40000009,
+	TPM2_RH_OWNER = 0x40000001,
+	TPM2_RS_PW    = 0x40000009,
 };
 
 enum tpm2_capabilities {
@@ -312,9 +317,12 @@ struct tpm_buf {
 };
 
 enum tpm2_object_attributes {
-	TPM2_OA_FIXED_TPM		= BIT(1),
-	TPM2_OA_FIXED_PARENT		= BIT(4),
-	TPM2_OA_USER_WITH_AUTH		= BIT(6),
+	TPM2_OA_FIXED_TPM 		= BIT(1),
+	TPM2_OA_FIXED_PARENT 		= BIT(4),
+	TPM2_OA_SENSITIVE_DATA_ORIGIN	= BIT(5),
+	TPM2_OA_USER_WITH_AUTH 		= BIT(6),
+	TPM2_OA_RESTRICTED 		= BIT(16),
+	TPM2_OA_SIGN 			= BIT(18),
 };
 
 enum tpm2_session_attributes {
-- 
2.39.2


