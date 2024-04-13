Return-Path: <linux-kernel+bounces-143612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D828A3B6B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967C71F21C01
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399E81CD2E;
	Sat, 13 Apr 2024 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b="HozHQ1Yr"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8611D555
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712992610; cv=none; b=knuF3ugN2L+6fSjIe0HSMkR/OWt48FfEi6xuiyNi1nVyOmy7FaLYHwDEnnNx/2gwizZNLwhV1i15ZE9JOOihwOFccDXqvgpIkbnTmZgA5Ns8K0oibCAh2nF0LdyB79Tcu+ULr6FgDdENBwr0uT1O+Us+OQc6gyXnC4FqAZ+jO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712992610; c=relaxed/simple;
	bh=h+jXI0oeBS8n98NMxvX0ZNK9OanOZVaWfhf9F7zYh20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piHIKxN6bsYg8+WTnSr8/LGJRB96puMAs37tsqzvDh5q/PGW2bXl85aQjqDsq1uHYzbGsX7BpON9RbrJzMO3jwXcrvXiAyLbQhDBErpop8PfJ5C2y30L/XmE3yLUVwrMSWGCTb0hyURmCxOGkalhZ0lE6pRgz2QBtCXS/aO1S8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b=HozHQ1Yr; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240413071646eac8825fa7c0ddeffb
        for <linux-kernel@vger.kernel.org>;
        Sat, 13 Apr 2024 09:16:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QyM1wgxijDrCMszk9wY5F2yipXafY8cejQEdgl4Lh14=;
 b=HozHQ1YreXAXjF1NAGUC2PjRvs1Y8ZdzsE1jOMDCElI5dCgL9/UnE6bzEliL3LlJJkPsbn
 a3xbOYh8Ycd+PdGAEdxh95X96WJG9WI+BEN3hGR9oJjAxbqYSz9TPsHzE6iXhN1Yt1f8uOLm
 TybqAFEOkCdvnA0LXOF/mWgd6O924=;
From: "M. Haener" <michael.haener@siemens.com>
To: linux-integrity@vger.kernel.org
Cc: Michael Haener <michael.haener@siemens.com>,
	linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS binding
Date: Sat, 13 Apr 2024 09:15:07 +0200
Message-ID: <20240413071621.12509-3-michael.haener@siemens.com>
In-Reply-To: <20240413071621.12509-1-michael.haener@siemens.com>
References: <20240413071621.12509-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer

From: Michael Haener <michael.haener@siemens.com>

Add the ST chip st33ktpm2xi2c to the supported compatible strings of the
TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
Profile specification.

For reference, a datasheet is available at:
https://www.st.com/resource/en/data_brief/st33ktpm2xi2c.pdf

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
index 3ab4434b7352..af7720dc4a12 100644
--- a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
+++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
@@ -32,6 +32,7 @@ properties:
           - enum:
               - infineon,slb9673
               - nuvoton,npct75x
+              - st,st33ktpm2xi2c
           - const: tcg,tpm-tis-i2c
 
       - description: TPM 1.2 and 2.0 chips with vendor-specific I²C interface
-- 
2.44.0


