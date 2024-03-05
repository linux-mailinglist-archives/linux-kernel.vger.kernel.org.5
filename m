Return-Path: <linux-kernel+bounces-92453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A11087205B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA3F1C21FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B88593E;
	Tue,  5 Mar 2024 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="RVKfHtX2"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19D537F8;
	Tue,  5 Mar 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645878; cv=none; b=C8cSAQsJF/yJSHm2bpdoBohR1Qqve1hI+4SabWQXrl63eWoBYHcm0vE60oXODwe2ULe1pr/h7FI4TIaOBbkv/hgM+dFOgsueXQZsc7NbM3ap7ULIzsftqoTszcHO6V4GFTAx9BajU4T1n3tefIbdacVwuVBtJtOdM/G+JZxH1vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645878; c=relaxed/simple;
	bh=5A/HA5mxh2/KDwzT7YsD8BlXYYkWDTCAWPYMJFnfwq4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WpIiPV4wUWNTSxmckXqocBXKI4aoPVK05JKH2hTNfH0oPLzgtLQZVtpxZVBUM/IVnG+is8FPE4M3VGnaTOEA5XnhOw7zIDVMOP8aGUKwX9fryJRhMne6d7TkGDzdbwh5jZi5xszlzUKramDK6st75AYTOGzESnpJ4ip822PZGDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=RVKfHtX2; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e4dec6f672so1175175a34.1;
        Tue, 05 Mar 2024 05:37:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645876; x=1710250676;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x29ugXEofcSo8fPY0HjL3M7rQfkHZfcuxvR3xwrwD1Q=;
        b=rL/WsN8zmtUlbVzu6thc+i11E5S9pa0mv4ZUKnWfViwBmqLR4hJ1RlVvyEx/1dYtV8
         zRcNKWA60GV82k1XBOZa+Poap9C98vxuCjLznog3UVdtgC4iS6+dTBXgLwF3vanpyHcd
         FIgN/oYi5JSJ/b4viC0luuqcweR9trCVLAcjXjyOYlNRjGx10QJzTbvZTgf3ADb66ba0
         4VNVVBiRBmrwnl3AFdog96z0ACNj99BvTHhKiwvv92yFT5tx11TAyDH0l1qd9aRdGLkz
         VP/o5iCEHFCCDjdQL1rR3nOiwSZkl79uBZFM0jNTkRcupJAx9UhJ+AT5NNc/IVadco8/
         aRxA==
X-Forwarded-Encrypted: i=1; AJvYcCXpKYerK3oorwubxshEOMzCLqoelbwXHaI/lDLoT3NPaToCHbu6/k/7QQsSjDPP6rHox4NcrWqTr51HZq00njH7UhXNd8xOZq2lkc1q
X-Gm-Message-State: AOJu0YzPR9uNj5Jhcyso3H4DT5fpFpnqLn/sNpQJG/p33l8X5ongpj8g
	IXCg1w5mAPWU76VgxjY3x9qIyJTNQMT8Flc3n8cpvJXTqH72mULQBPf1hyL2RICmTg==
X-Google-Smtp-Source: AGHT+IHWFFgt6TTFRzqtTqFgflRQ+scZHJkpO3aYF+5aCIIt/EBeaYtoxMrRBnRTV8EBWBRESEXDAQ==
X-Received: by 2002:a05:6830:1e32:b0:6e4:efc1:a995 with SMTP id t18-20020a0568301e3200b006e4efc1a995mr2161460otr.26.1709645875900;
        Tue, 05 Mar 2024 05:37:55 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id l185-20020a6388c2000000b005dab535fac2sm8915600pgd.90.2024.03.05.05.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:37:55 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709645873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x29ugXEofcSo8fPY0HjL3M7rQfkHZfcuxvR3xwrwD1Q=;
	b=RVKfHtX20nv/n+7BIbtpijdAD256TX6UIp4oO9+wyoSAJlBA5XBA0nXq722i725ZZS/tDn
	wirmm1EXBXw+c4UREraPRaPYDO6rTFYz2k1tEqu2U5+mPGqY0HS55be6I9xtHmQ/Su2wFX
	4vgB0Ocnk0zfz39j1ZB31FegDArGEcFh6fHkwSc0320tME2Xfsq684sy4GbWGV7S7/UXbl
	Pvg6pBJIL92wspiG/sxKfEpUTrwl4c0aZT5hrs5SNrRpxrQRegPHnk6g8eUOjVjMLyXjra
	/ltJapcG1OqXb+NhopooWKSdtB4U951XTRUq8ImroT7QLTxoP4ZiLo3T1s6xpQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] mips: constify struct class usage
Date: Tue, 05 Mar 2024 10:37:49 -0300
Message-Id: <20240305-class_cleanup-mips-v1-0-e93726711468@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0g52UC/x3MQQqAIBBA0avErBOsjKCrRMRgUw2YiUMRiHdPW
 r7F/wmEIpPAWCWI9LDw5QuaugJ7oN9J8VoMrW6N7nSvrEORxTpCfwd1chCFw4CkG0KzWShhiLT
 x+0+nOecPHDg5rWQAAAA=
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=5A/HA5mxh2/KDwzT7YsD8BlXYYkWDTCAWPYMJFnfwq4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5yAuDmXWzy1esrDGha5pHYoRh68joux8/i158
 ls3wwF/hFKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecgLgAKCRDJC4p8Y4ZY
 pjrrD/4vJqQgBTfOdFtvprXl/ebh2E+4lf9wc4I692MOGqOGhcTZaeRn5m9cxAad6t5dXVWgmmV
 h4SDUn+bhq88+UvvhqLMHOjcfrHSRTPupfl+JRWPmUJydqFy6HKAZWuzj+xq46f61W6CszHaMPO
 kCoEfXO6YI951nB5sx61ppQUziZNZl4dROAVsPlwaWujfz+6KpxkTFs4K6HsUPkjYHJCX1cU9jX
 mzZZ9koPNT7cp8A1leMJv9YrMmdOXZpyppLnzs8eBdAnbeaetoRcgasSIAlK8g8sZDOKZKmcLnP
 yYJ095nMGx3sZJ6TPEs/zTXpbB+SVHhynlAhvu6PlK0s4HEK5GEAMGvsPcckWdxB7WWn5e5g1gL
 qviVdW0Ev4pBvH4r/zlNLdI7Z21W/6UJ9LvwufRPqQWgY1V1awLrApt8YLyPRluyMG0Gsug5sG2
 q3XkEqeYiXO5agF4NnA/UzPMTup20TwJEqHxD59gKwVzVeZvpnVbpJfkUS3/to57avdDdTILdfJ
 XsITUFg2rUSEiaMBE0DPNEbEBv+ealKjlYbV314BmrqAyIkU9muoteTv+/a2JhSscv1jZwSxQVB
 K6FB6H6xBqAvqPpj8V+FQvuVvmqFM0mIX67HcovPL4AFtFTmvSc+j/TRfK4fzcywsI8l35bUa6V
 Az899dBF9AE2lEA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that aims to make the
class structures in mips constant. This has been possible since 2023 [1].

[1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Ricardo B. Marliere (2):
      mips: mt: make mt_class constant
      mips: sibyte: make tb_class constant

 arch/mips/include/asm/mips_mt.h     |  2 +-
 arch/mips/kernel/mips-mt.c          | 14 ++++----------
 arch/mips/kernel/rtlx-mt.c          |  8 ++++----
 arch/mips/sibyte/common/sb_tbprof.c | 21 +++++++++------------
 4 files changed, 18 insertions(+), 27 deletions(-)
---
base-commit: fdf0df8c936c0822570e067009dee6824ff3a2be
change-id: 20240305-class_cleanup-mips-a77ae01ea4fc

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


