Return-Path: <linux-kernel+bounces-95347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF9C874C91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4032824D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685D85284;
	Thu,  7 Mar 2024 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SSkWN/Cs"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0A583A0A;
	Thu,  7 Mar 2024 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808096; cv=none; b=nh5HFpfx+9DDNR4AjODaY+a3+G/Ays7M+DD5CsxOW5Qo6UU8guNc61uTmOZMXJqZQlSSSi6rx95k03Y5lMbiJZ50RsIbA2zLQ+CQ2gBUjoagMP1E9u+p/g6jV8uwLd4+4gP3NRropA8KvSSJQ8flh84J3/SaFzuoxk8uJUHYiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808096; c=relaxed/simple;
	bh=1BU5u/cwj2k3L3jOkekAJtHo8nXpzXkMUDvC4MeZ0ug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rt0JZm+qENkNo6+Zv2Mx5MV52TNxFTj2ZJMk4X/u0jDr4h187WKtiG1fV030KwNSOStFvefrLPsqa00ihh24zkE7VF5A/H3jTcUEOWSXiK5/HmFKFQOEkKb2Vv1PfzkyWoo+w6O1czA4a8jZ/rt1zid/eOAw9v4Cp9BnFGfphas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=SSkWN/Cs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709808092;
	bh=QHwyFDcupjhTArKQOMkjJ6sLtDVOUhAmTuA0clhv4wM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SSkWN/CsUdTccQiVHbYQloY9qgzNHOhp2tWHvvoiKfSTW/OXDLdNJfX0VnHwmCfk3
	 gtXjChFioqzzrlQZsgsma3C+QfV75e2zWgTRiuV2A33jW2W9DJDl2k/5DCfHf2s97R
	 CtqUlxkXS5agv/jFDIXkpHkq/5X5/uPmaG5wSA+MM2l+xj1lu3ST142FhSKunOHswc
	 cJ3cFlZHsZFtw5Xrvnba1Eo55c7kG6lwjb+21AQgqP1izxedl6YQ+k81o8+Q6TPQcv
	 T05V3+iI3v1B70IsNm853jwb7VnOmpgMkd7Gh0fj5PxJ8JyKFdoSxGZAbRd7SS75ad
	 c6F7yI7FwY3IA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tr5Sr1LbWz4wc5;
	Thu,  7 Mar 2024 21:41:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, rnsastry@linux.ibm.com,
 peterhuewe@gmx.de, viparash@in.ibm.com, Stefan Berger
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/prom_init: Replace linux,sml-base/sml-size
 with linux,sml-log
In-Reply-To: <20240306155511.974517-2-stefanb@linux.ibm.com>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-2-stefanb@linux.ibm.com>
Date: Thu, 07 Mar 2024 21:41:31 +1100
Message-ID: <87jzmenx2c.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stefan Berger <stefanb@linux.ibm.com> writes:
> linux,sml-base holds the address of a buffer with the TPM log. This
> buffer may become invalid after a kexec and therefore embed the whole TPM
> log in linux,sml-log. This helps to protect the log since it is properly
> carried across a kexec with both of the kexec syscalls.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  arch/powerpc/kernel/prom_init.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index e67effdba85c..41268c30de4c 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1956,12 +1956,8 @@ static void __init prom_instantiate_sml(void)
>  
>  	reserve_mem(base, size);
>  
> -	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-base",
> -		     &base, sizeof(base));
> -	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-size",
> -		     &size, sizeof(size));
> -
> -	prom_debug("sml base     = 0x%llx\n", base);
> +	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-log",
> +		     (void *)base, size);

As we discussed via chat, doing it this way sucks the full content of
the log back into Open Firmware. 

That relies on OF handling such big properties, and also means more
memory will be consumed, which can cause problems early in boot.

A better solution is to explicitly add the log to the FDT in the
flattening phase.

Also adding the new linux,sml-log property should be accompanied by a
change to the device tree binding.

The syntax is not very obvious to me, but possibly something like?

diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
index 50a3fd31241c..cd75037948bc 100644
--- a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
+++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
@@ -74,8 +74,6 @@ required:
   - ibm,my-dma-window
   - ibm,my-drc-index
   - ibm,loc-code
-  - linux,sml-base
-  - linux,sml-size
 
 allOf:
   - $ref: tpm-common.yaml#
diff --git a/Documentation/devicetree/bindings/tpm/tpm-common.yaml b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
index 3c1241b2a43f..616604707c95 100644
--- a/Documentation/devicetree/bindings/tpm/tpm-common.yaml
+++ b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
@@ -25,6 +25,11 @@ properties:
       base address of reserved memory allocated for firmware event log
     $ref: /schemas/types.yaml#/definitions/uint64
 
+  linux,sml-log:
+    description:
+      Content of firmware event log
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+
   linux,sml-size:
     description:
       size of reserved memory allocated for firmware event log
@@ -53,15 +58,22 @@ dependentRequired:
   linux,sml-base: ['linux,sml-size']
   linux,sml-size: ['linux,sml-base']
 
-# must only have either memory-region or linux,sml-base
+# must only have either memory-region or linux,sml-base/size or linux,sml-log
 # as well as either resets or reset-gpios
 dependentSchemas:
   memory-region:
     properties:
       linux,sml-base: false
+      linux,sml-log: false
   linux,sml-base:
     properties:
       memory-region: false
+      linux,sml-log: false
+  linux,sml-log:
+    properties:
+      memory-region: false
+      linux,sml-base: false
+      linux,sml-size: false
   resets:
     properties:
       reset-gpios: false


cheers

