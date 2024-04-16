Return-Path: <linux-kernel+bounces-146406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B64848A64DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D131F22CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77A1591FF;
	Tue, 16 Apr 2024 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFA+Xwgt"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5A84DF0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251870; cv=none; b=hiiVq5Befy91sDGBKbtx1V/aWQEmRUJQnZrR9FczM++XfESUSTdqa0OoK3J5qorcNTEup+sEDA1wILBMDkk7HPDCcljuBBjjzu4MVZlQM9XZk3SHuchdEbo0TGC4x3c5VrFqoa+1GTsikW2Jm4kvhIP9L+wLUGDrTczDWlCKjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251870; c=relaxed/simple;
	bh=1k7Mo6A53sEnM9AVmjmMFSd6Kr0X66nFRotuTggUvfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oExlzZ+mx4JvOgTyTxyCo1YmIKuLPk2N6uAjUthKdAFZt9qJ9/JmJH1Fj5E4WVA2XX/LtYHH/zNEOxGV9LVDFiRGaczUY5+L7CkujMvOUBTCRhmjiE+YD8S00tnqvCZA/5nZLdmCoH5F9Zoni//F959paayQoM0SeSCfwzH1d3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFA+Xwgt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed627829e6so4427498b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713251868; x=1713856668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0LQlo9tV6jA7edPLPREtk8jPXGN28KNPzfvTbxW9Ygw=;
        b=kFA+XwgtFqWJNWQJMA5iLnf1SEnD3Bh+Hd8uF0+gWd/ODr8p5Lm76xrta4mWeeecqI
         hPB3qrP9e3e5hz42rb8wTlL/nuYwuO3HazcTm4iOo32zvzSGVFKiFgcpZKU0PhIadGoG
         N6ZB3pPjTKWemR1KduOoMM7HlLS9eYWAGxY59sdj1MlXrKWLAqBSkGWEfRVlewlc/KtA
         TOYLLY/iqpSwnV8N5es/iv1Aw9JVdwcLyJQxukbQ8rp9h6qKKttMAxYgJKeo96UYwqE0
         KRkaRvaY00SEoisfXQNWAOqxlYADGW311Mjinb+39OKaLqwGulUrnnKDuPEtSmHRpBT/
         P/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713251868; x=1713856668;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LQlo9tV6jA7edPLPREtk8jPXGN28KNPzfvTbxW9Ygw=;
        b=G3P+WChu4m5PRTQLKiyT02Uy9NrZoTdanfMGvqKi2PTX12wt3OqKZzi/J4FADu1XmR
         X0fDmDcWFLou5okWMfGkA+HMsyKsrAF1mPtIHKwavcIPiVozpf8ao+iM+C7+yaBAAeVO
         SpsC8u9yMoSvNHQcE/Jwj6K7o3Z3QAhn8NXr/5Nurg5xTzo1sdnGyfUAW/D1JEyQkMDk
         MgN0snjQtVvEcOL9Opmx3sxymGlJj8I346ytTAlzVl9N6nkrWXTQQqARTainam6bRS4m
         GGXoXt+b8kgBbmeKkojyQyEw1yrYk4xGnKRliR3x44F/bNqx0MyXS+zQfwOlcbYJZft1
         CrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXufIG0M83QKskk0xC/r9L507p5QO97kjryEc70/aH1DyyzJduDWklpP9lnQfKtvN1M09F26uD2gU1J0ynN9U6Xr9d5FdlkMiU6/A7O
X-Gm-Message-State: AOJu0YyE+URnTWsLhH8Gg7gP8BruS138dsnmdzs6a7xIhdNWcnXwd9Il
	lLN4S4UiGshWwKQMDfQQpng3TcFrGa8d6tg73HIkhSUd5eEYTFrq
X-Google-Smtp-Source: AGHT+IFA2zmy9+KvgrKxSYzQek06HbyAOJH+OqT9zi1O7kh6mqKJgpjWl+AmhEUdNRhj7ZdCRoeZAQ==
X-Received: by 2002:a05:6a00:399d:b0:6ea:c2c7:5d6a with SMTP id fi29-20020a056a00399d00b006eac2c75d6amr15984911pfb.2.1713251868205;
        Tue, 16 Apr 2024 00:17:48 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id lr48-20020a056a0073b000b006e724ccdc3esm8340029pfb.55.2024.04.16.00.17.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Apr 2024 00:17:47 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v4 1/4] mm/filemap: return early if failed to allocate memory for split
Date: Tue, 16 Apr 2024 15:17:19 +0800
Message-ID: <20240416071722.45997-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416071722.45997-1-ryncsn@gmail.com>
References: <20240416071722.45997-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

xas_split_alloc could fail with NOMEM, and in such case, it should abort
early instead of keep going and fail the xas_split below.

Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 30de18c4fd28..d447b36ffd41 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -880,9 +880,12 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
 		void *entry, *old = NULL;
 
-		if (order > folio_order(folio))
+		if (order > folio_order(folio)) {
 			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
 					order, gfp);
+			if (xas_error(&xas))
+				goto error;
+		}
 		xas_lock_irq(&xas);
 		xas_for_each_conflict(&xas, entry) {
 			old = entry;
-- 
2.44.0


