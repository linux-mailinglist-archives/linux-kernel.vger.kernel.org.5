Return-Path: <linux-kernel+bounces-128045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01E8895559
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963DE1F216D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100EC8593E;
	Tue,  2 Apr 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTwXfqBa"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4885260
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064442; cv=none; b=n56cDAYLBKKnnrMrQh391lpncFV+wZXRTNjrlweOpkYJWvnBbdwPdr+RZ5pNydPBYVWMjZqFWdy56MTxY93WwmOr6S0iKBx3IpuYai9ppNz9DCUqKogtPWKc/hxiQjk87P2AMCskSucQny6+AVgCeDcLbpGWI9URDGS/5L5rWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064442; c=relaxed/simple;
	bh=Cfslaf8i7E8aCEMveG0FfqBpUIgV5rW5DmCwP919Sqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EZ4b1XNh6o5cE3A2EIc8fzI0Sr94ccEM3VXUHP9hkCWCwgC6W+qMhKP7XH36EALGArfQfh/X2UdOyyauWIA7V1wz1C/gkNYoCoDlBepNxcnoNtgnqMvKZuaTydtDGbgM8siT8bmSrhpaYGFDzGw88oJOfBLwj6CVoAB9plGXjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTwXfqBa; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56df41365c8so580080a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712064439; x=1712669239; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/zlJk86kk+e6v/0Hhm5prLyYwej1Vl0sY7sp0RzGlSU=;
        b=WTwXfqBaCLZmTnVxnpm1CuF7/JhLBgZFi+gZtEbsIJlIOQh8fMnV/OLr4S0rgUEHxS
         VbkLv61O6/KqaZsIsFDE0YRmgyxAkjMhB2FTerMR2MNTly4Cpdd2iSmWsF5F0X4Pn7gC
         yTMRce+ckut6L2APuhkVwxFy+RIhCFZd9pDSQlDYeyUwmN86yAPMjtGl52OodOjE8mqj
         o/NpKOhubkS++HpLl5mxk09RR3G529gn9pvemx3sNaT1ghoQqjvnowT4TIj5SY7G1Ie0
         6liJ3dSWuQXimuuZOZxG7iARv9WLlqzq6B5EIhrrwNGhUxsvhT3inOXQHWR1qzad87ss
         RIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064439; x=1712669239;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zlJk86kk+e6v/0Hhm5prLyYwej1Vl0sY7sp0RzGlSU=;
        b=gFI6nTjO1uX9Xnn0YAD9qb5YjaKZGuAxXWyI0cHBiFEKMxpwv0Z0SdRiJyneLCmowZ
         N9RKnObL4p7Hw/BpcxpiZVum3IX1m1BogZ/qj5x0qzJmF0WlOpeKndADFE6jU5mOFQN5
         f8oWrkkOcBLsPV9uMEShV85tlVCkirVuGoY5WFLt0cEX6DVPBj+mvZaVJ7O1KHxh9xUG
         bOm9zqTQe03KENviptaTbcMkpzACEGKXKVB5WHbCGi5xuFNWGUa1eKN4Qcf34luGJjZK
         C4RNrdQyjAEfJqX8nA33sZJBVGKXMJzbmEMrI1qcYMxu3WpCd6H4sl38YpFF02z6+AoZ
         gTWA==
X-Gm-Message-State: AOJu0YxI62UBQm4rfF84txhdWq82B0PkOebAWdmRxh4MQFfvseFwDCpI
	CFwqT2CPrz5XeTsMh+yt6R3C2A7KG3SztfSpxZKQRx2P/VdzBKvu
X-Google-Smtp-Source: AGHT+IGVGxd08nxJspeKCBa/sUfV4wRq6nZEH6TtddNfET39FJsuKrlK0+PJ5UXPJTlZxDo0ZOFcYA==
X-Received: by 2002:a05:6402:348a:b0:568:9d96:b2d1 with SMTP id v10-20020a056402348a00b005689d96b2d1mr9264446edc.32.1712064438815;
        Tue, 02 Apr 2024 06:27:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7c24b000000b0056bdec673c3sm6942782edo.38.2024.04.02.06.27.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2024 06:27:17 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	rongtao@cestc.cn
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 1/3] memblock tests: fix undefined reference to `early_pfn_to_nid'
Date: Tue,  2 Apr 2024 13:26:59 +0000
Message-Id: <20240402132701.29744-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240402132701.29744-1-richard.weiyang@gmail.com>
References: <20240402132701.29744-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

commit 6a9531c3a880 ("memblock: fix crash when reserved memory is not
added to memory") introduce the usage of early_pfn_to_nid, which is not
defined in memblock tests.

The original definition of early_pfn_to_nid is defined in mm.h, so let
add this in the corresponding mm.h.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Yajun Deng <yajun.deng@linux.dev>
CC: Mike Rapoport <rppt@kernel.org>
---
 tools/include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index f3c82ab5b14c..7d73da098047 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -37,4 +37,9 @@ static inline void totalram_pages_add(long count)
 {
 }
 
+static inline int early_pfn_to_nid(unsigned long pfn)
+{
+	return 0;
+}
+
 #endif
-- 
2.34.1


