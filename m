Return-Path: <linux-kernel+bounces-85468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E862586B673
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ADB287CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9993515E5B2;
	Wed, 28 Feb 2024 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Qhfm7L8k"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423FB159573
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142778; cv=none; b=gUySG4dFsZx6lnoqyKlwxNezoBfhzmeKqf2TvNLEyIP4EmXtgOHHrNofc9OybOnHDP0IQX8z69OgHluzzj424fQ9caZwjJn6ellvdBHRpwDZz4QLhpB12E2oxhVbKLMHrCGlVfCrb/6rZVZob7qC3l55Q4nmJ1chRuo7vySjT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142778; c=relaxed/simple;
	bh=VvQb+BMTgSSey78SvDrMJm/73S7iPwz7W6A4Lzu8+18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A9+hd3wruedbajfmmRd+YJCW8UmhXuPyNjy8TqkwP/45nYbPJnqLayYTyHR3aLvS+anO3Vajnlfr39eQA0ucMV3z3j3uK2b6kQDk9ZC3jXMXmSxv6I2GHd/PBiCnTVXYpzbezuLjx7wGoM/Z5KUQFkAXBv5Pcgj01tm4+xEnC+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Qhfm7L8k; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d275e63590so71358971fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709142775; x=1709747575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN06uTemIfMB8SobqPuytHQ6Es/YWPqVM45xDKN/b1w=;
        b=Qhfm7L8kikplC47Nz/45oGAlXdkET9KCUglJpFm9sHkUPfQPlbtjWfIQGWSXHoLGgU
         BSWiGte/EPNeUIm+dTONcD/j0hKlI99iJmEHaRSJ/sgRbWVBrCHqrs8xY8wnV7jCCkVu
         1mZigIRXqwyCkNlWXrL9nzAEB0Yp90ILOO+Y7Pl7Txnb3M0u86SRA4KyozDVc2LvlEeR
         AiYqz/q659BMo7dY3nFjcFnTYXi7Oi8heY1gcpdK8ytWJchD+KFE9FpKbJMyQu3e0jX4
         4ZZt99RLcx6qCt3kBJydw/2ZVRCenoe0NgvfnSt4L4RpXmbqxSgFfHeCWgOyZCa+enGo
         LDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142775; x=1709747575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wN06uTemIfMB8SobqPuytHQ6Es/YWPqVM45xDKN/b1w=;
        b=fT1dxUKILpfWwBQkmKOxKQHx9NW1btPrzJq+lBN0wl2nwzY0CWgOmLquore6Y3mu2D
         Z6pIFWqwAk31QyP26EgYkrVoVgwLxCAms683zP4wgK/1VyYSsiaU9xfMDKp1IfnzUdlu
         0pgYsns82V5qJPpH+aw8OScx4PplprLpaHzQSZHSCREUc5FvYPrFivWKEfIhOzbjCC2R
         QavjLlZUFlmwObY7nkK2UgwyFGM3PoYrjWbkKq2EIW5/EZ3wGYBfSNDfuiydamaMNbri
         EuVfU6JR3fV6yedX1WrT+oDtzCwW75V+l6r86D6XbuY1dZ5Ee9e2CEgvKjbt9+OLPqK0
         ciug==
X-Forwarded-Encrypted: i=1; AJvYcCXKjzCUF8eDnPTsnByM6Rr/YX+l8S8ztSbtgG/ygW++l6oqvxI5yfVjAFqXUk8Nfa9LGIAL7fTgzw5lvfz5N0eYZ3H/Weq/0v6BGKPj
X-Gm-Message-State: AOJu0Yyu0KK5gZVvbLHKFxvM6CywKbLbGUwbdpC6aV5VtROVKIQLBhGz
	ZPGNlETidc5bW2j2zCL6aekKlQ8j2ICxfskayq8WuMCHJeZFRJfje0UNq7Ab/b8=
X-Google-Smtp-Source: AGHT+IETg7kV0bx5myF/NA0zMEyulWLTEzaaIPLLJycmnhfj1WlzWCL3ZxXNKtGoRPlCHLw3VzcB1w==
X-Received: by 2002:a2e:a545:0:b0:2d2:d58b:652a with SMTP id e5-20020a2ea545000000b002d2d58b652amr1724531ljn.21.1709142775497;
        Wed, 28 Feb 2024 09:52:55 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ch12-20020a5d5d0c000000b0033dabeacab2sm15500222wrb.39.2024.02.28.09.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:52:55 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 1/2] riscv: Remove superfluous smp_mb()
Date: Wed, 28 Feb 2024 18:51:48 +0100
Message-Id: <20240228175149.162646-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228175149.162646-1-alexghiti@rivosinc.com>
References: <20240228175149.162646-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This memory barrier is not needed and not documented so simply remove
it.

Suggested-by: Andrea Parri <andrea@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/patch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 37e87fdcf6a0..0b5c16dfe3f4 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -239,7 +239,6 @@ static int patch_text_cb(void *data)
 	} else {
 		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
 			cpu_relax();
-		smp_mb();
 	}
 
 	return ret;
-- 
2.39.2


