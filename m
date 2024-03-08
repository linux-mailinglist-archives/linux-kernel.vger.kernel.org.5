Return-Path: <linux-kernel+bounces-97453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48C876AB5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DB3B22030
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC659140;
	Fri,  8 Mar 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QI41MAPu"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12B56479
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922364; cv=none; b=bt2eLjPpWnAgkRZ8uuHJaEF34vo/fA8i707NahY3XAl0gxQLi+8swB3wVm/DCLyG8z8+Wo+G/H90IF2s3lXTVzE+gdpiNW/nKGJfW1wW0kO5PzLpAJSKBzo6C2J/hbpJBCdJMA8t+HkgQTtOvnLYzAFP04/yMgwsBWhZG6Sxw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922364; c=relaxed/simple;
	bh=VSZiKx13zcdCVDYwqIRzCcJDp79icXmI6mc1wjrw+wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hs2EG97T2+G9cZi5vRDmypT6/wMTMso/xxf367Y2hIzx3mSQLMXvY5XzYWJzuX17vE67hjcAYlk+XGl1LuIryQzOCTKsoJQ0m05HItNllQAdxqffhBhYDZLoKBVqJdoCXugbtTVfPHsx1CuW1+nK9VK3OAHCJJ5uUQUzlV9Cj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QI41MAPu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29b73143920so2531519a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 10:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709922363; x=1710527163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8i7Hn0NjGdBjABWwTPM97LUVWqQ4V1pWIxyh4e32z8=;
        b=QI41MAPuRdkqr0AfJW4taF0RrrBcq/z6yaBqjAiE0jErNP60n5UtsFzkJSDjrDuokd
         g4DVYqQxqifBi1+xS741hlR5/PqR0X1V/WVklhZ9dA13oNutvQXbrIKorwYdGOV6DUyT
         dKtLAq2N+f7JWcRh2DzplixvwzXiNbK2Z8cF91fwHa36l0G/cOkprYF/TN05PuvagQ17
         hdrQY6Zbn+5CuCWfaDKxisz/7HTu8EvEFNMNpdEZ/fpc72BwNA7J8GAZvicP/9nizuo+
         61GB4H14v2naS9BHXxxTXc8K+bV473aye+TZjiluo4Ml9u/fYl31o9K0XNdWDPcaWNQN
         7mBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709922363; x=1710527163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8i7Hn0NjGdBjABWwTPM97LUVWqQ4V1pWIxyh4e32z8=;
        b=vCV9q41vYUuUjzQ3jlYt7SZV46gHNKd5C5BJ0/dh+GHLsfpz/IZqW1tQ/0PX9PaDxe
         vCTFwjOg7S5u5p80kXPMPKMnbS/7zcK/QURb5O8RmG84CeekkchA9syDQH+iijv75TJu
         CuuP7CFNCRLDn5lNUx/F7syHLIIsmTE6OBYd5qHM9JOu81vNssiCVN8wcUHYE630o+OY
         R2ocMo4/7NrMMUG5yuquWUXxPgOW2GHWPiZ0PEe4AFcu76WXebU4guLX6yty1bG2XJhp
         WRf659RS5fRnnIk6Zl+IiM3Ev3r4hzcFOgkADrEy0RpcZsnY3XkhYXYyU220LNcBlqa6
         NFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8EmuL3mkqU6oplvUHGKHIN7jZ9iiP8e6ZA6QAtyQC1S+HDu0b+cHmsyRe1d6wnOrIpWe+hlyM/CJv8x67aJdEiGJD3sXDLnIL6vlB
X-Gm-Message-State: AOJu0YyCkhwCql9ZT9UOBY/xjTMHewhcHzZlZyAdvgvLiGkRgni53+si
	MVv3AQJUVopLQUk5N85dSH6sOcE8ou4EqcjlUpOfSrW0unKTNECRaj3JA9BgeYzh4kvbcuRfyGe
	R
X-Google-Smtp-Source: AGHT+IH8kgZbnyf3P/VRv+u1abDgA38A8Cw2bjDl1+Lq+akQmbwU/gPrg+PUnxBiEC1gfXB4O4UoAg==
X-Received: by 2002:a17:90b:198b:b0:29b:7371:c180 with SMTP id mv11-20020a17090b198b00b0029b7371c180mr1003365pjb.23.1709922362829;
        Fri, 08 Mar 2024 10:26:02 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090ac20d00b0029bb1bb298dsm44821pjt.35.2024.03.08.10.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:26:02 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 08 Mar 2024 10:25:56 -0800
Subject: [PATCH v9 2/4] riscv: Only check online cpus for emulated accesses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-disable_misaligned_probe_config-v9-2-a388770ba0ce@rivosinc.com>
References: <20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com>
In-Reply-To: <20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709922358; l=985;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=VSZiKx13zcdCVDYwqIRzCcJDp79icXmI6mc1wjrw+wY=;
 b=s3J/YA19nA3aZwWo0vtRnSvwuO//sW+TUai4jGeI6zCrCeWII+2VQxVrMJtsSd3U0Nt0G4SEJ
 UXe9nzS322pDT1H/9TJxMSBSaS/f5JfhnMiNZGh3Cr0A31oF0SggGmp
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The unaligned access checker only sets valid values for online cpus.
Check for these values on online cpus rather than on present cpus.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe")
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 8ded225e8c5b..c2ed4e689bf9 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -632,7 +632,7 @@ void unaligned_emulation_finish(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		if (per_cpu(misaligned_access_speed, cpu) !=
 					RISCV_HWPROBE_MISALIGNED_EMULATED) {
 			return;

-- 
2.43.2


