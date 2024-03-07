Return-Path: <linux-kernel+bounces-96053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BCB87569A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C16B2152B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2513667D;
	Thu,  7 Mar 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2hh6kg83"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D2135A75
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838358; cv=none; b=quIMncyE1po9QQKxbSuSHJglPKgVSZDSHWrNyjRSC1h/KOsnEncmaumb4RdXawdr4orZli8BIi23XynEGpdNQ1raWQpEBSCtE5HLuYTb0dqjekEBAHl1I2PbirY2/dWNSmqtbEsDHNOozzQ47Ugqbq6IfWebIuHleq4zsoBRFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838358; c=relaxed/simple;
	bh=VSZiKx13zcdCVDYwqIRzCcJDp79icXmI6mc1wjrw+wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=glI+N90FoU3rAwITB+L56ZYbSk1XcGLiQlHijUbuA8Z79K6uOk3djYdlD4/hDSW0BagXfxzxgFNC3lesHjCYYDXWoN5svRmxXbuacKZ7E2U2MK4RnXttswRYu5id8Tv6FxTWr607fWCcbyZoydFqeqp1bzl7HHOyUGonOTBgQ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2hh6kg83; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd178fc492so8568395ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709838356; x=1710443156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8i7Hn0NjGdBjABWwTPM97LUVWqQ4V1pWIxyh4e32z8=;
        b=2hh6kg83cEgyf699kuxP2hMBSkIZtXThRkCb+QdP/Jn7L+izyv9kh9XPVa+9ZFbiof
         Pri+K9HlCQJrJP7lqmW05znauSIJC9jWmILR/PVuMFP8aJPYgx10sAXpbmFdbElp8UOb
         2n8fhxR9iXlAMkmuRnondvkKM5DCaN+Z5rN89QUIIih0WV7s99NtKSde0+L+0GUVp00Q
         gXVjZthMwY5IaloWpEICmk8lH8V/C1sy0YO0jehiurbnfXMoQPVE6fhTHXzHlQglyr62
         sxIRG1gQB+OLSWoj0d9CqUVIkRttegS/Er8+xw9HkVR0XDjPpmKI1ayCq+uu/zOy8brr
         mxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838356; x=1710443156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8i7Hn0NjGdBjABWwTPM97LUVWqQ4V1pWIxyh4e32z8=;
        b=Dz2fISAMQzNPcKKOO5PanW4NE6TZ2ViarqPhkG0hRv8hFFhP7jSnhrPzDZ7LzJ5czi
         Tq78bF+c89ny6qhatUeM3YlXFWOyp1y7+ody1Bjv8fdsBvOYUaBYMZ461ssXbxq6+xzK
         6LXTASGLkCK/7xqjEzdUjy8oHq927EM2JH/2uqxI0iC/0Cnh4kscWO344Q9mzCt9YpuG
         oNB0XeX4hXbblk6WW09fL5guEz9O+EfngeCOiL8kRh4dkE6A0Kqe/fjY1DC/uaTld0lT
         htfgdKeitxSd3PuFvGc1cj6Fk04JOPDadIJ53NNaYruzkOu2Z8Y6qGTgHWEfZWSs2cvc
         CqSA==
X-Forwarded-Encrypted: i=1; AJvYcCW6Vf8Gi2hrAb9PNdWfRc8mboebpcRcYHY7ycOkR5JBz12okR2Pr3BlcMlVM892x3AzcvKkdvP8YMD/NG1iRI9tbGdmLtZ+A1wCgNFM
X-Gm-Message-State: AOJu0Yw8oSZ/LzRmuMK4JDsyq2j18me0/rgfEnzJab3hylm/4j0cZAQd
	JQv1VFRLfvE1TEmSz9iGCNvT7/HXZnATkp2+0RyCz48KUqV5KZCOybz9O9363OY=
X-Google-Smtp-Source: AGHT+IGWG50eIYNqJYtIEtMgtF56ZtFfU2/+liaC87qJQqHAa4lId+qqp/lStD4LT51B0M3EfKpmCg==
X-Received: by 2002:a17:902:db0a:b0:1dd:a34:7321 with SMTP id m10-20020a170902db0a00b001dd0a347321mr10498088plx.25.1709838355931;
        Thu, 07 Mar 2024 11:05:55 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001dd526af36csm1747338plk.295.2024.03.07.11.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:05:55 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 07 Mar 2024 11:05:46 -0800
Subject: [PATCH v8 2/4] riscv: Only check online cpus for emulated accesses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-disable_misaligned_probe_config-v8-2-55d696cb398b@rivosinc.com>
References: <20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com>
In-Reply-To: <20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709838351; l=985;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=VSZiKx13zcdCVDYwqIRzCcJDp79icXmI6mc1wjrw+wY=;
 b=4lDes0vZrJms/4gMpoYeVGqXErBW/PLjmFFmXEprN4sEQrjl/O2TnHAvCflhkGywOBjrDhXZx
 brGOqXY3mv4DSqV1Bxg2PRf3Aizh4mrVFcQLGzt1urygWj2UkFOGR/j
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


