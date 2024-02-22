Return-Path: <linux-kernel+bounces-77070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1448600DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56CEDB26753
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E515CD64;
	Thu, 22 Feb 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIbz+QgS"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801815B971;
	Thu, 22 Feb 2024 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625680; cv=none; b=MoxpTHG66W+nmma0VWkIzN7wTZkPrbiylGcC3/IC2GW1RqDzUuPJ4gIPYrtty3FDjEFAbw20KljBZvYC0QtnIFxgGwfn9VKp3qOwyDj6o5XAiWaPvPlk8nk2bX4pIrUQmTGABxo8yEUGSicZVmvDRmydSp9y5FVnvdPBtuP+Y9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625680; c=relaxed/simple;
	bh=VQAh5ZV9wY5Ul9uQ7BUU57UTPtumS14kEbBWZKhZ10Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cp/WNUNtjfeDEtfMijk+aLVwJBuMJv/0HURJF5WDQHPXvaQhvG2FEbL434MErhDFDX57InCH5fjvU3oJZnxms8bXJsejNAYhh6ClsPUHqI8O/0vyfXouFuUG27OjaEEVlj9p4T49hH1yiOe0h3x/AcmnO4iBpzEfAn499nDp5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIbz+QgS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso98167e87.3;
        Thu, 22 Feb 2024 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625677; x=1709230477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KDD/bgajALRVWO+j8th9FkNjs1Uxn5aRXvljpgi1rg=;
        b=iIbz+QgSSQ++rAYG1JPchJDVB0s6ppR4L+a/x5JMhsLoDqA1C6kiO5YfHWST8lMdyB
         C8agKesKgqtxzRUXWZ67u7LxDjDPL/BQbBH+HYqLdjbyr3CeS17ekKV2TyXbKSyKFYvF
         WBEKBRGvvVgXCidbdFAs47yqNTgVyZs2kRj9Gpmc2RECmNPzWOhmWrDB3BFyUiB8hvpg
         9yVEDrR5Rkjpj+Hb/fpwkik71ob4ajadZ6Fs/QO/XQOGPoJT/ZMzaIVqYqovD3kU0L07
         dWGPPp/bvY5iHk+quT7EbVOXf5eXDD3/zkl+6xrhP5GL0JkRVFJqJOKCNqbLgBdkpE75
         BCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625677; x=1709230477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KDD/bgajALRVWO+j8th9FkNjs1Uxn5aRXvljpgi1rg=;
        b=TDMVltf7IDpjTJ1/IMF/ZgpGuo8FaQXb6JAs3Pxs4CLDZAktXlAggQAQJlHPQpbmtb
         IgS4chj6a8mZeWt7ntTl6gLuiNfBUaBZwns+JRUBqCzZtfPG4qwikUUkwNvVgNyMz4U/
         zHC3/ERqb/8PwpIhFNEo0cPS+Yp0OFcTqC9v8vgqnjoQQIHBlIe8Xb76CmINy0iYTEPb
         kgH+DQ5kJNBqoDziruE/tEvir7xcdmIH2gGeST40lIr5dXqa4mn7K+H+HfHUvFDZ6Ja4
         2vwae5Zq+VJXdo4IQsNXHX9UwHtnDNDK+fo5meuwi7SlamsFt1nLqIHRaTP0WloNy+2b
         3F1g==
X-Forwarded-Encrypted: i=1; AJvYcCUCRUeojL91m34YbZGX8xiOqaGhqoIeIR+zV6+IDBdXqnP+GxiWi+LGKtEWJOO3lepFwsXyeHvDPafcRtF2NDLd80qUWfOlC1rfKT7XzLuQeafye1CtLDJzPqHHJUxParp20I9w3zd9fw==
X-Gm-Message-State: AOJu0YyBnZg3K70pC93r6O4Uk5ZRu/Oixmj+PJMQ5gLT0HsnuYbBQevz
	Jxt3amDkVIQ2sbXqpWAQgzYhcJy16Z/VKjGHiTKUVhxnpMXTjAA4
X-Google-Smtp-Source: AGHT+IEqX3LxEhT5jkFdrvdQSh0VSFYxzZfMDjApSMdtK11qjBKsdW+5JPn+EfVyBINk1xssUQMbPQ==
X-Received: by 2002:a05:6512:1327:b0:512:99a3:62eb with SMTP id x39-20020a056512132700b0051299a362ebmr13469414lfu.54.1708625676990;
        Thu, 22 Feb 2024 10:14:36 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a10-20020ac25e6a000000b00512dd50af1dsm296800lfr.22.2024.02.22.10.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:36 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/20] EDAC/synopsys: Drop local to_mci() macro definition
Date: Thu, 22 Feb 2024 21:12:54 +0300
Message-ID: <20240222181324.28242-10-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222181324.28242-1-fancer.lancer@gmail.com>
References: <20240222181324.28242-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The to_mci() macro was added in commit 1a81361f75d8 ("EDAC, synopsys: Add
Error Injection support for ZynqMP DDR controller") together with the
errors injection debug feature. It turns out the absolutely the same
macro-function has already been defined in the edac_mc.h (former
edac_core.h) header file. No idea why it was needed to have a local
version of the macro, but there is no point in it now. Drop the local
macro-function definition for good.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 5099246db90e..21b0d791cb8b 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -940,7 +940,6 @@ static const struct of_device_id synps_edac_match[] = {
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
 #ifdef CONFIG_EDAC_DEBUG
-#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
 
 /**
  * ddr_poison_setup -	Update poison registers.
-- 
2.43.0


