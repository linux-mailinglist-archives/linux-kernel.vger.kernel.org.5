Return-Path: <linux-kernel+bounces-103859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BD787C5CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC64728257F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69796171B6;
	Thu, 14 Mar 2024 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4iW6322Q"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D05168B1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458054; cv=none; b=I0otngdObpScIsFSffvAEIMn6JycGRH1M4CKgDbnMvBagISL+MFwXwPu8zJnUkIZC8wkt7n9Jfn7sNFbuJLaYU4bS3ODGvZ+tQRjX8Brl/nRVeqTALJP7kVJW7DctGW+Zv69Rilqk3T/d5v2n9akitBG7W2Aj2W9U0jk3pEpt7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458054; c=relaxed/simple;
	bh=c4BE70nsgZ4EpHYath9ENvwlSd32Bg8IXevQKA4Uufc=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=Mmr7KvWfQGSPC5L0x4rJe4uR0skWdCcMhta9c56G6BRauXztpHFyIVi1IXZQfNiOmhBCeRqb9HKiytyh/e/+tdhDSN7v+vpWyf4muai8GjMy8OiYy3j7Aq0NcFJTVpK2eM/RaRct1CKFJibOjezq6GLt+hu3FmLFTTCjPyowLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4iW6322Q; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so2413506276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710458052; x=1711062852; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47NgUQnVGQBbIng7KOEItYyrBF4Fqt+mN9GiaCGROqw=;
        b=4iW6322Q5S/rPLq0lHmAN/QrTib+fiMmj5voYxKhcYW3yme1VUGH6zEIkdzvgZ26R5
         UrlVvOKjmUub/QKT8DCLjFlyzmKufD/RBGyX1oDdb/S3hIgAG5kco74npmJKH2PsP0aa
         y/e0nqK4ViZ83YzckeYcLgjIX6suoG7k9P+1dPuU3gQ/NEV6Cgh8k9tuWUC5VOmLOyhb
         qGQM9cfhl0943v1HirO2sZKOlgHFdeUmBx125Bnz59sJKs6EQCZg1r7z7kJQkPko9tRA
         QrUNiIxBVyY3jp5Wtq8aMhd+JY9LCsXaoUeN5AM6z1UVgyJ2VFfnICzlP4ur3etOWadR
         1kTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458052; x=1711062852;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47NgUQnVGQBbIng7KOEItYyrBF4Fqt+mN9GiaCGROqw=;
        b=mmTUkhpBlmW7xcLcgGA9Q7AVTudMUbUnlfkWQKGVLD+sTalvooqPQXslMcVfZnuQ6/
         MXr6IveiwLJl76EoUn+Yw7XNKlweXajrLLkrakZeQK10o8fC3ZXBJU5B41lZnYvUwquH
         FHl8BvXIUDsKZi83lYifqWtCzGg4o6Rj/xco7YkM7KD8C7LvFBBKxJQOLMwTMOP8nzHJ
         q2lXm33SF2VZ2MyD8U2nssTirKnyfH+h5Kxpl4AaLeHCrYarD3QTaForxOw6bQiSUw1w
         RMkts88NLcXAxW/AhALMI8q+QphSGjWXBj2GLhEWqMbR1J3+71Y+Kt3v5hqaxpIBFpWe
         5aCg==
X-Forwarded-Encrypted: i=1; AJvYcCVZqiyPwlm0Ej4557Yqokjsrorg7IK9UKKscqU6C6Q72X2sY90SZe9Javg3OE78ll6iRiuBfqOag+9SDFj19cuExuhKOvdo+895yLmR
X-Gm-Message-State: AOJu0YyZtq1NVbnjTn6c3yiJUpyiBOovqoor7SQlYuiBJYlVfnsJxP3R
	IDg9Lw3RleShUhMRu/DJpAGzHlxA+U8AfZyt7KJ/SLFtpVUaWdSoooSvLjEcvF7NCmRRM7mturF
	gvhsfxg==
X-Google-Smtp-Source: AGHT+IFD8eEM1mWFsmXcSWuwtn82SwzRLKc7S4RbEAwxb8zYChzqbLS1oTHAz/G5FnRguCxvTTZCMPQdU8eD
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:c8:ad31:2162:e917])
 (user=dhavale job=sendgmr) by 2002:a05:6902:100c:b0:dc6:ff2b:7e1b with SMTP
 id w12-20020a056902100c00b00dc6ff2b7e1bmr918025ybt.4.1710458052162; Thu, 14
 Mar 2024 16:14:12 -0700 (PDT)
Date: Thu, 14 Mar 2024 16:14:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314231407.1000541-1-dhavale@google.com>
Subject: [PATCH] MAINTAINERS: erofs: add myself as reviewer
From: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, 
	Sandeep Dhavale <dhavale@google.com>, kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have been contributing to erofs for sometime and I would like to help
with code reviews as well.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f298c4187fb..b130340d71bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7875,6 +7875,7 @@ M:	Gao Xiang <xiang@kernel.org>
 M:	Chao Yu <chao@kernel.org>
 R:	Yue Hu <huyue2@coolpad.com>
 R:	Jeffle Xu <jefflexu@linux.alibaba.com>
+R:	Sandeep Dhavale <dhavale@google.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 W:	https://erofs.docs.kernel.org
-- 
2.44.0.291.gc1ea87d7ee-goog


