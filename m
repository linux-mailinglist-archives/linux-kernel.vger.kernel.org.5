Return-Path: <linux-kernel+bounces-120535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD56A88D8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B86329F2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2793E4E1DA;
	Wed, 27 Mar 2024 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="TnK2buSA"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC71481A8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527928; cv=none; b=L1dWUYwBuAwGca8kWE6BwAOC/eJFyGdoxjh8n3kFrdK97ku47Py1chOqfkhvxReO1DDXADpzt2Pb3gWSheYow2Bq+sWp0+YPI+jhjd9/Fte1Vz0WUwaguzj22E6uNujMrKco5UHMszXJ2rAURbO9z0AGoGVjjtDhS4oxgQaG4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527928; c=relaxed/simple;
	bh=IoJ5PhDwmkZFYUe1jIRt3XY+XYejXNxDc1GhQecxiN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgaUao37rVYXdbndn/KA4EysAqDm0/+rwBPfVEkhql+PSMl9+VAmc2BlSJWyhemWzAsXYjhj9KBPeU3XONVfxyDOJYM2UTsX0sBLJTJ8qxeDtwnXbcF0Y6BkQJsWDP2CjwF/uNwDIPU5tLHubwDgx5AxBlleBsK3R69747mkZMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=TnK2buSA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341808b6217so4114605f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1711527923; x=1712132723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q95Pv5eUd7/PCCDIkGY46bAHfemcttBtSKECUmP8rbg=;
        b=TnK2buSA7GmjcMGWnwWRo2itc5TOs/LCl5WiWe6EmBSNqD6EzB/LIobeLLA7HKfKwk
         6+ZLAUWDVmLsm/0xIR0mcl0A8IgaUJBXBAxbl0egxArSEjSWJmev1qZj0cD4HhimKm6g
         wDal0f82l4PclBII7nx7vCjvOeAZ0UfC1PBcasxEwYW1o4GFOvbobh9lCJCt9YNmdXE0
         OXRQ4EY8f9UjwnH5zjSLgkOIzzzeNgO99AQ59M+lraKTXwN/osk+cPIqa1iEZHCU9wO7
         81yWG1IY6zX9oRDOW+OxYj+3tEE182VIykr04UQ6qMy42CsNjKD73rjaKMKwXZhKRIEw
         vu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527923; x=1712132723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q95Pv5eUd7/PCCDIkGY46bAHfemcttBtSKECUmP8rbg=;
        b=awcszlh/gcjNRY5RkK3qHg9vRsIjE4C6JNAKsLvZN/c7PO0B6bfbAA10AIIy1BeLSM
         pgXTcOf1m8vA4f+ReoO42cpB9L4KJxm2Xxot737qwzRKlz3V8IQfR0FRIC+1/bMVrT+t
         OwrsTbq7FOV3wr3VqE7JkwTs9VBUkMOn/3NRVGNYVhwNOUx4W6ZDHZrGVUBfrrHKTeNE
         /2JF4IwJj/EmgBPLrclzERKRu1pLBZGHYEULlcqa7aTiP/TxXK71lgEeGwap1eLG0frp
         QUcYtVDwFFuyUCxw000B1p+7B5vrYasNVoXvcIoY+b/EugyCx6nI6ftXAFrLgtFdNtwI
         SREg==
X-Forwarded-Encrypted: i=1; AJvYcCWx4Kh+Fd4x42y1s2tXiuqDV5NuDizIVyrsdPan2SUfa5TEH3LhO98rcJBKoesXY0XwjLXbRgPPngFkZBegxBDwawR1O9SrTvxWGEfW
X-Gm-Message-State: AOJu0Yy9gK8ns924ideRoLAhRRmCyf/2PeAEkr1oFf1jDK8dMQGaJLgG
	W+aMZb1vSLgRGxy7aWR4UqKvETIZFPwdD+vEYjxl1ehhQ/tWdlx+mDtTpTmpYdM=
X-Google-Smtp-Source: AGHT+IErr6t+SUrVfJunEwUJoIKv/4U7lQAfXQ9Bqp61+O4I6oZbasCzHveygFWHw9GNXm9VGKM5sA==
X-Received: by 2002:a05:600c:444c:b0:414:7e91:a992 with SMTP id v12-20020a05600c444c00b004147e91a992mr399734wmn.3.1711527923123;
        Wed, 27 Mar 2024 01:25:23 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id iw18-20020a05600c54d200b004148619f5d0sm1379012wmb.35.2024.03.27.01.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:25:22 -0700 (PDT)
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
Subject: [PATCH v7 5/6] docs: document DCP-backed trusted keys kernel params
Date: Wed, 27 Mar 2024 09:24:51 +0100
Message-ID: <20240327082454.13729-6-david@sigma-star.at>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327082454.13729-1-david@sigma-star.at>
References: <20240327082454.13729-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the kernel parameters trusted.dcp_use_otp_key
and trusted.dcp_skip_zk_test for DCP-backed trusted keys.

Co-developed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
Co-developed-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Gstir <david@sigma-star.at>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 24c02c704049..b6944e57768a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6698,6 +6698,7 @@
 			- "tpm"
 			- "tee"
 			- "caam"
+			- "dcp"
 			If not specified then it defaults to iterating through
 			the trust source list starting with TPM and assigns the
 			first trust source as a backend which is initialized
@@ -6713,6 +6714,18 @@
 			If not specified, "default" is used. In this case,
 			the RNG's choice is left to each individual trust source.
 
+	trusted.dcp_use_otp_key
+			This is intended to be used in combination with
+			trusted.source=dcp and will select the DCP OTP key
+			instead of the DCP UNIQUE key blob encryption.
+
+	trusted.dcp_skip_zk_test
+			This is intended to be used in combination with
+			trusted.source=dcp and will disable the check if all
+			the blob key is zero'ed. This is helpful for situations where
+			having this key zero'ed is acceptable. E.g. in testing
+			scenarios.
+
 	tsc=		Disable clocksource stability checks for TSC.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
-- 
2.35.3


