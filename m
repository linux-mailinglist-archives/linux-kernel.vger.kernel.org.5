Return-Path: <linux-kernel+bounces-132307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F628992D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730F31F26D51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CDEB67E;
	Fri,  5 Apr 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/J2BBGe"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1641C02
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712280952; cv=none; b=b7t11Rpyh+PUVul9OrYzRzdCCzTU0tkEP/ii90o9rUSjgt8JN9ljjd3GfTf4PboGl0EpQ3lk2Z7k1GGXfxBqpmBPuUDdEJkpP0a1berOi+0ZxrmaFeLRsNIrlDEtje4IUpKQl0LifY0DGxGwAnxqXawQ8GbxyvQDY5ndggRQgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712280952; c=relaxed/simple;
	bh=o1tFAOQGkW0DbNrZ7sCZTDIeI632kqdvmGXl6Q8/qxk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i8FANzuxBYEH1zUkLAnEGR02EWfBlD/0wMRbWEpxssSTSJLLtskEyuaT4G79wAhfJQ280N1Aks4e55aQRfg5nXBpt4cPv4w+/zjkcEtFLxcHOZrVRmr7SkSm4UAaoxcVr4hgF3gk58ffVLhpvsm7Ak6eUkMjS3ug1M9zq4TIJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/J2BBGe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6144244c60cso24774857b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 18:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712280949; x=1712885749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pgu3p7tHjxQ3lz6MwjVSh+dwW77hGBwLZpXn88zTuiY=;
        b=N/J2BBGeGqyOxvEgZqiYmqOH6NFpKKVEMX67rRmam2Eemdu6OWLbYq85098Y5YPTqS
         Pk0juaaE4AaP0l71cf0coEQR6uUfVMii+HfECWh/ezFRnTho+/R7yv7JcGgyPDpUhYTE
         zp1dFWSDHg8LW40R2KrZblEWNwNVkdlojuaVgq/1dFk5F2daTugIXDidS6v6LojUtCkZ
         GDHdG207qMjhQYSYnDInF1GcE08Hg5npP4HQtifZmt0/lrnIp8PQc9F2vboFyESFxkzS
         I0r+weQdPzpur5KHBowmS73v/HT3gRGKESRplpC86RUAS+Nm3psVVSatkX4IDif6i6qn
         gddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712280949; x=1712885749;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgu3p7tHjxQ3lz6MwjVSh+dwW77hGBwLZpXn88zTuiY=;
        b=oi/iS0C1Ua3aHht8SYuNFTM8RsalINlUrRqe+S8fTCycsdnYUS6a4GFNkbSCzjjmtI
         nERGtX+/6gmFt9BrvcVuwczAB7Xf5+2n/3bsUlMh/KPVG6VaV2e7m5GhckKwW6CzIUp/
         kOPnf6L3wiyxzllmi3hhpAW1RZLCDo1NjOsqHD8VtlwgglLi5iBSbfw+WKWr/V0/vp+W
         9n33SPaSZCM6m4Sj23dJ9E8di40UcoWJN2b++QOq03bVjR7ENFUPwH5g1Ke232ZnBecm
         yZAyLjNGXBCrCvOMAlUBojbXaBrUWHgmitrGDs14XMZLbEU9ekKany3xyb6yDALttCng
         Gmmw==
X-Forwarded-Encrypted: i=1; AJvYcCWzTwz1CyH+zTm2/jF8AyoQpfOUHt9+VB3HX4IggV32F/OrLtkp2gXkhDuDP5nrZ+txoVnmZG80FeRPZ8KwU9/PdF5HsF3tnZ01IR9C
X-Gm-Message-State: AOJu0YwMqpWReccRBMoilQ4+eAKOg17o0pvyQmaKp252Yw/3KqQd0gB3
	PKtJv44sBrQ9XlyO+vXli6SHoIw4HJb2deQvq86DUGEjyvu7ZcJrgJjMd7+BENShHqvIjrhxSFH
	I1lQOaPhhMUa2TPMOSg==
X-Google-Smtp-Source: AGHT+IFmdDVM5iEw5hLAYn2UqtkOKLKmP+POWbEp+oIqY1Yon9Z83GqDagsvAteAyMDek1A3jRsJBS0FPUdfD8oo
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:f0d:b0:615:fd8:d65f with SMTP
 id dc13-20020a05690c0f0d00b006150fd8d65fmr322595ywb.4.1712280949675; Thu, 04
 Apr 2024 18:35:49 -0700 (PDT)
Date: Fri,  5 Apr 2024 01:35:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405013547.1859126-1-yosryahmed@google.com>
Subject: [PATCH v1 0/5] zswap same-filled and limit checking cleanups
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Miscellaneous cleanups for limit checking and same-filled handling in
the store path. This series was broken out of the "zswap: store
zero-filled pages more efficiently" series [1]. It contains the cleanups
and drops the main functional changes.

[1]https://lore.kernel.org/lkml/20240325235018.2028408-1-yosryahmed@google.com/

Yosry Ahmed (5):
  mm: zswap: always shrink in zswap_store() if zswap_pool_reached_full
  mm: zswap: refactor limit checking from zswap_store()
  mm: zswap: move more same-filled pages checks outside of zswap_store()
  mm: zswap: remove same_filled module params
  mm: zswap: do not check the global limit for same-filled pages

 mm/zswap.c | 93 +++++++++++++++++++++---------------------------------
 1 file changed, 36 insertions(+), 57 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


