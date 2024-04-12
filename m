Return-Path: <linux-kernel+bounces-142220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819308A2917
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21751C21C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031754F20A;
	Fri, 12 Apr 2024 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHVtPrm8"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD651CAA1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909882; cv=none; b=dlnXaTvlV1QRlWIVAnrDyNMNrbhzQEuadUwOoFnyGwcht4oOK4MAG3MewlY6OnT8oavd60Q0dijQbCpqvH11BfuUOuhMcpWDpTUg5AsizfXzmolqY+qDANaFLTrZVpe3073ZXnWCYfK/WToQvT8OxB7emYLFzImcgWv6aO9bfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909882; c=relaxed/simple;
	bh=0DU13dBLve4+ri+EwY0n9m1cW/RT/79cO78sKZiWAPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BncrUEhxHFq2/TjuHxR95QcLy/9d/Fr3a7HYTZLOCuDV9kbceF/ICQcy0WEXVWZZUPD04DMdQfh8lfdeSej0PuE2c2tHvbcEhWi8DdA2FMQ2uG+Pp6b8V/PGx4f5EppeRxgXjttOTBwk4sRG4wnxjWjFgANi6/PVTWmGU4tUgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHVtPrm8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecee5c08e6so709204b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712909880; x=1713514680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjsiSNQp4uxaVI8Pi3iYdhRweQGzOvI3FKANnlTJ6Gs=;
        b=OHVtPrm8mX54JFqG8BpZIyhllTGJVxMnNe+8QwFS4AEHwz0r2Urinl37bB0f4lgnHz
         RamlqxOpfHHvB1er1IOMyBuVoDpWjs5jJohmco96dj+4ShPuwSxePaT8HnObHwthaSfW
         c3QpIwoFgS+k/DX8/TsrsTFotbDpUqB3zpV72OX0JPfucO6Vn8MUdELLSHfD5baISWyJ
         Eem2LRmDqA1niqQI1iMWMST4KrR+W4fxINoaQ/i2JOXGD51vTdiurGRoL5nGRU2qkptz
         qPJOxRbOdbATwxosV/DLDZkRUbGFTZwM9e6eYdWxwYudqvjr7tq6DSCK/3RhxjyYIdlf
         /aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712909880; x=1713514680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjsiSNQp4uxaVI8Pi3iYdhRweQGzOvI3FKANnlTJ6Gs=;
        b=D9EWlHe+FJzkv6Efe3VWIonLR8baUQFUJ71zc5/NlwCOuzxxh1m0IPbwV2E+FLyVC0
         isepUV/rEt20J4M6dg2ULI16Bl5Y919I8rceE4MK6jUbFvnKmhe50kq/g5ba+8Lohdbz
         VDJUQXAXheEZBCEl9x+wpPrIccMTURMzOZTX/+zLF3ib/ujpwwpOHSm/1tDtgbPo5zYc
         EsnU2fwAu6jvQdw9Rts04iPopQmON0yGNC8Ym09nK69dyaeW0nGJfEk99veVALsaKXyZ
         kiGQ4R9OjshFBv/g9ZDoiYPZA2J9ED9PN0bCKVHcWd7Q0eAWzWbAEcUow1cvPQqQXCGM
         CNtg==
X-Forwarded-Encrypted: i=1; AJvYcCU4JjpO0vkSVLR736bUYMlegY7YkU8pPNBr21/75aNMIm07PTOxDFsW5J6adsWQWq4nwiVzW92dvWjlEt21sWLicSNyifbknbby4BZ3
X-Gm-Message-State: AOJu0Yw2H001q+saY1ZxwLN7q1GPyLMK0ZMJPK5CEvYGK+9do6WeSMBe
	oakDEv/wAARNjln/5+YjxmJJxUiba+RTLrXr5LNKe9RyPvFZ1EuHPrBf8kWx
X-Google-Smtp-Source: AGHT+IFknTy+7/o6/TDzRb0letw8QFdLY5GU5/3ivPz1djE5rZurxqoAg9DDIp6Ptj4DOEM2lluHtg==
X-Received: by 2002:a05:6a00:1a8d:b0:6ed:5655:a02a with SMTP id e13-20020a056a001a8d00b006ed5655a02amr1885358pfv.30.1712909880335;
        Fri, 12 Apr 2024 01:18:00 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id i15-20020a63130f000000b005f43a5c4e7dsm2276393pgl.41.2024.04.12.01.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:18:00 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	christophe.leroy@csgroup.eu,
	geert@linux-m68k.org,
	jpoimboe@kernel.org,
	kjlx@templeofstupid.com,
	linux-kernel@vger.kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	rppt@kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH v2 0/2] Fix potential static_command_line memory overflow
Date: Fri, 12 Apr 2024 16:17:31 +0800
Message-ID: <20240412081733.35925-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412141536.3f59fde391a6d28181562dbe@kernel.org>
References: <20240412141536.3f59fde391a6d28181562dbe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 -> v2: Split the v1 version patch into a bugfix patch and a cleanup patch

Yuntao Wang (2):
  init/main.c: Fix potential static_command_line memory overflow
  init/main.c: Minor cleanup for the setup_command_line() function

 init/main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.44.0


