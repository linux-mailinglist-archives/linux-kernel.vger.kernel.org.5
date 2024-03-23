Return-Path: <linux-kernel+bounces-112233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF866887736
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A561F239B8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB46453BE;
	Sat, 23 Mar 2024 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evsZmLEH"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C933D9E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711175199; cv=none; b=XAiLMpbq4XMVpvkreURZIT4gCzYC0MRAlobsPGjZM8ERVnpvcZnHJDouA4UpkMEM142bUsvNHVKgXvKOMBvaJnhSW2fZGfK5O2eaV+pE+Tz92ippsXGEeqpU2CwiZmXsrNfR0sG5SrPe/HhBAW5hKiNk8GWSjHEiVlJ+0017JPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711175199; c=relaxed/simple;
	bh=1jaVCkfGUt9+ZKDpqqrdz4xILcOY76BiSHYTOJFFH2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=td2prb+B8H9Zn355Zzkhd4AkO4DHH7F5vV83AfrhWh+g2ID/ZHP8SR4jwCdKALIMUsq80Jg8VkYWYNqXE4+r5qP6bgNCdHflPbdTwwkGAdtFhpR2xBLgoAlIqex/zTY+Z7cEsrf1cOQexLN2Nfo3m3/q8Yrja2Kpx+TFYN7ReFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evsZmLEH; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e6969855c8so1595489a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711175197; x=1711779997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jaVCkfGUt9+ZKDpqqrdz4xILcOY76BiSHYTOJFFH2E=;
        b=evsZmLEH+v8ajjjvhpyOyI3yFuxDwgiRQcpVTYWekXXKcKatBa5IkLKuWmCbTTXdTV
         +kzGE1B427irI3sVHM4jTJhi9FAnB1Zu6zlR1DrRwx91ExxZQ+ZfPxWL7t0q3smWgGTo
         iwyyS6e+ZP6fHiS1oPEPOZQZz93yaMXoJqcO4hL0H0f4igUt56w+0ZQiavLI0a+/jZi0
         7t2zXZU1ykvupmDV0qXIWvXueiFxxcHZiig3IRimcdpq4BceMcpopIkE/SOqDXY2gd62
         2on/x4yNjuU3kgOy0yFpSu3F5pflK2udFPbYDO7n1eDOMZiJKroPznK0nMcH7xVzAs2P
         OBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711175197; x=1711779997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jaVCkfGUt9+ZKDpqqrdz4xILcOY76BiSHYTOJFFH2E=;
        b=m71G40WodF7AHjg3MLgk6+fUyXXInBjSqbbv+BTk/uofZpWTYt0BZon2gJGkCbIeoL
         SLyS5ohBha2V1fLBqtM4Pd5WI6NyaAF7BUV3v1/41JMVhsluwwE2cgklBkvIh6rwMWai
         uyvHsMfgJLt6LBnRLb9AKpbgMw5bZgcyX4GzYA0DTnrXz5Eo2uy6Y5sbQoyJ9dlPoWFw
         T6LrmSi+Rqc5ErAMieQvzxZPEICDaAcEcgVf4uwuYfq8lzR/n776E7xN5zbG14sM/xEx
         J0//xF0bQ1Aulpu+6D/iteg6XenZ4SlUU3VkrviRQhiQZRwVfPAjwmY8Aa2ROMyYXbLF
         qlZw==
X-Forwarded-Encrypted: i=1; AJvYcCUkQrARn8ZScIMyUpM9FEiEXofKCczKtfZYA82pstB7tYcwmIsPTt8mpUJNgVEo6RQ67N2bSo9hb+pqYiasUtuYnqOBBmQKjTmDR4tI
X-Gm-Message-State: AOJu0YzpXJLHt0sYWI0kS/sRxjH+01D+IAP+kPXHLLPXPTJmpOBmvJDC
	ayaOYs5a8OjSeHEwDcgUirKdrERFtAHqNENgwbMFFMLpuWugaJ3K
X-Google-Smtp-Source: AGHT+IEHyo+ubbUWK4arwma+3PRQMV7yKpXQuggv/YJ9P+edg7f4UJVqvn625Nj+WKv5vFH08lYBkA==
X-Received: by 2002:a05:6830:4d7:b0:6e6:84a2:9e59 with SMTP id s23-20020a05683004d700b006e684a29e59mr1830226otd.9.1711175196822;
        Fri, 22 Mar 2024 23:26:36 -0700 (PDT)
Received: from gmail.com ([104.28.240.134])
        by smtp.gmail.com with ESMTPSA id v8-20020a63f208000000b005d7994a08dcsm2589763pgh.36.2024.03.22.23.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 23:26:36 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: alexghiti@rivosinc.com
Cc: aou@eecs.berkeley.edu,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com
Subject: Re: [PATCH] riscv: Improve sbi_ecall() code generation by reordering arguments
Date: Sat, 23 Mar 2024 14:26:25 +0800
Message-Id: <20240323062625.2488-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322112629.68170-1-alexghiti@rivosinc.com>
References: <20240322112629.68170-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alexandre,

You can simply make sbi_ecall `__always_inline`, so the C function call
overhead can be fully avoided.

