Return-Path: <linux-kernel+bounces-43743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B5C841888
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D1D28428A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0E374C2;
	Tue, 30 Jan 2024 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Qj2APR78"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA7364AB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578941; cv=none; b=Ql32flTg9L4cUrt8DhyOH3+4m9RyJVwpxE31afw5idBVOBeni6eeVBAUSpG0xOx+4hkYZ5mkBrUDc2eU12g8Y3c2KRLIyG7QWJ3A027+f2pSC2Pfd0aP9YMzCXrCO8N8c4TIgL3E1cY5IJwhSKX9UFaQ+TM7R84K6FofZI1+3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578941; c=relaxed/simple;
	bh=B/uwPD5Q03PavcbhkfXKr63FB/8V2Nu3ZADVd0o9EXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihYlk3hS9AgsRgcph8AC/PO9/vYgWUNVnRjWqwKxqGxm1HV0YIBOZ8BnwegoWreGNopsj8U/Mcu2GoVUizUZSWQJ/TlAPfGZpVhA2yr+Ha98KtyEbM0Rp5Ip3VWER6qRGlfKSpSAwH053/oc1OA3qn/0grhRSEAL9iSvLs5m/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Qj2APR78; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42aa4a9d984so17707211cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578938; x=1707183738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMNhWdXKrsGXbbTndUjwna9Z9KC3QLUt3pRgP5ry3e4=;
        b=Qj2APR7869JDVbAwY87Hbsq0yccZ48zJzMFRA7aBMPTH/WxACmuLobcpJ3nlmnpOC5
         2Bm1hZAdV6IZHJjH+abZtMC+9F+EQBVzWmzZXTZxIG3B/Bv1TYXeK5gpKiFeIGn7z/pY
         XhhTRdOM9CiQw59DrIp5adMqNoRsMbXhEI6G+8fFOrsaKjloVBaZS2HNgWH74Vml+ygw
         8osBB959psK4Zj9ThIYJG3ir2iVJsWvRxtOeeslfWqczBfhyWGXI9goxsZnokGGeB+iK
         Gad8LFLVgh/eFrslMVP0nU5d6GjAVAmO/gkE9xcSTHjEJmIDWD0nVlcgvPOGvmFqNhet
         Cteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578938; x=1707183738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMNhWdXKrsGXbbTndUjwna9Z9KC3QLUt3pRgP5ry3e4=;
        b=fotArQiWn6lsGJUjjyAv8fIK75ROolFvZajDZVn2kQkTcG8qnoq/IY20g9E1p4mHy/
         v9bEEqgTQrf8OhLYTHj/dCQPCtpVeYOqjAWkloUwNA6vMdQyJDKoUxogvMXaMCQEW58O
         FQm+yr+qg9QVmmIt6cNfPvg+NXlirlWn1sEGUo86VKfZete/DK7Hg7t2VUD1eQ9r4oXy
         DEKFCkTgRp8qILG78BuBxG1aq/EkE6cD4VpInCzjewxmk1tRR7uVHsJ18R0PNSGQWH5N
         iiqi9eKBaenmmDOoollTnXAgxqlg7bn3D2cVC7uVIw+1dUjetp2fe16rVhA8xL+4TK3r
         tvbg==
X-Gm-Message-State: AOJu0YwdxIXhPXFIWGzJSPM5DsCabtqFhdmsWuiVxZpD/zaYK+pYjNQu
	zakbtxvqurATgOZRCYzJhcF0eA/uQrNo4u9wUVCYVzc3H+GalxtR8utKkjNDlWE=
X-Google-Smtp-Source: AGHT+IF5MO6AEMmCAsk5IQGTGkKhQ4HvnX3tReOL/xtjiCFFl+s4iNpGpwrLVsQ3sbMAj+NPQ5HOgA==
X-Received: by 2002:ac8:7f0f:0:b0:42a:aaba:73cb with SMTP id f15-20020ac87f0f000000b0042aaaba73cbmr2427380qtk.74.1706578938767;
        Mon, 29 Jan 2024 17:42:18 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id y19-20020a05622a005300b004181e5a724csm3357547qtw.88.2024.01.29.17.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:18 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/20] mm: zswap: warn when referencing a dead entry
Date: Mon, 29 Jan 2024 20:36:40 -0500
Message-ID: <20240130014208.565554-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130014208.565554-1-hannes@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put a standard sanity check on zswap_entry_get() for UAF scenario.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 9f05282efe3c..0c6adaf2fdb6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -542,6 +542,7 @@ static void zswap_entry_free(struct zswap_entry *entry)
 /* caller must hold the tree lock */
 static void zswap_entry_get(struct zswap_entry *entry)
 {
+	WARN_ON_ONCE(!entry->refcount);
 	entry->refcount++;
 }
 
-- 
2.43.0


