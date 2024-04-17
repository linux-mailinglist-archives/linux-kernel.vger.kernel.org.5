Return-Path: <linux-kernel+bounces-149246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134838A8DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440611C2183E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A9B5F87A;
	Wed, 17 Apr 2024 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6RV5IiZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD224AEED
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388727; cv=none; b=lH0jH8RTiAPqdAm+08d8XRCqrhClUxUUFm8a4hEuvPUqeBFERe3nOqoX5BnTHVTlhCGnqoE22Zb3C2HdjxPqxRieJcSpRUZCrDbA3IhUlTA6mwIM3Wj+m1i01WhcwIF3qJKBKFCu16rkcv5j1l2NylHFQAjr8Kkegbx7ZAXUTkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388727; c=relaxed/simple;
	bh=9JKcMI1ryyQZw1audDUIy9GcPT5/GaGd6txUjiGLFg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgNA9/8GmFMszxGEoza7C39icNr02mg2J4w27JrhnsxoFR5ryD4IlL7QTTpRjmyXhBC+HVGp1ftGjWfcxoVy7dT5aojbktxmJWhIBn0GXJZ1e2avS1VM+iJHby36qFD66e8j0Ss/KnMR6VVAMZfONejdil/C8T1TTsapwSJZdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6RV5IiZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713388724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RODytP55S9PjZjf+7gfJJ4x6mavqXkgxb7Ks2uWHAe4=;
	b=Y6RV5IiZJf8iJXCNjwb7chcbUandb0LSxINYveJMniJj4cTnSAJy6rP18K1mZEnbmURUob
	PfH9P8RBKVj5H3PdDHX1IV+1REF1eVZRMtugXOeNFomtkINQx/cW8mlpQEQyp9mb7zTYaZ
	eia1U+1VqZpbpPB52mdJtjqgfDU9Jaw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-ka3Ow4UfPPeELgAN0YHo-A-1; Wed, 17 Apr 2024 17:18:42 -0400
X-MC-Unique: ka3Ow4UfPPeELgAN0YHo-A-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ea10c8093eso18782a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713388722; x=1713993522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RODytP55S9PjZjf+7gfJJ4x6mavqXkgxb7Ks2uWHAe4=;
        b=Iw7T/Fvyc2JEU0Mon6P/jKsckzY0urH/bYJ8/5IMDRgB+Rl5x3ijlOlXXbVF2toyp4
         KyKoyQhd8wQxaquHS7FU7xBJwwgxkOPbLHjFYL/Yy7WSY4UjX9kIql6YccwTRyrq/OP3
         ZiTB+tAcMF0hP9v+p69Lpd2gfiW82fzYZzF7KWuEecT/qPl0TdaYeFRwZKFSyOlkPlA9
         jhu0DkLu6fKDPuCFlJrmT67WYIl1IgQpJRgUqEm0n8ZCgbdu2pTSMlkW/hnEqcvVYm+q
         RYycIn/pkV9eFpy/lXptvW9JzvIud01PJpj0n19+opHN0cxQHQx8MfKg3TPKS+vFqHtR
         2/mw==
X-Forwarded-Encrypted: i=1; AJvYcCUS1sInwgtQ9eAZh2b7jbKjh7++0pxhC2JlF/NHdnLVXb9qVvzaU1yNR/H7kV8T9F/OzLuo+0RzYXkYMD2rsR9vOHUN5pW09mmnidKk
X-Gm-Message-State: AOJu0YyY8h6FuP7OtBJUzDw2I6TuP324jpzqjrbTunZJsxDudqiJfwxk
	vA1MDH3B575bJAWkpYWuwsV/VMKL2J4kZ4U4Yu14RzFxLyN1Bd1ZLdVdzl4czpR1cwHoF5akxNY
	YrgKpKVZ9SBVIn/q8nVXQQmOjQ6auK9gl91Us3sDtbRfoEQJxwaPxtH/YsI83fw==
X-Received: by 2002:a9d:7406:0:b0:6eb:7e33:3fbb with SMTP id n6-20020a9d7406000000b006eb7e333fbbmr838906otk.0.1713388722117;
        Wed, 17 Apr 2024 14:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGQuu+Ru3d/WAMoyXikWuaGubuV6xaXPDqyX9q9vBRfpwd+WdeOnRC1LPB2iMpjdigzkGg1g==
X-Received: by 2002:a9d:7406:0:b0:6eb:7e33:3fbb with SMTP id n6-20020a9d7406000000b006eb7e333fbbmr838884otk.0.1713388721661;
        Wed, 17 Apr 2024 14:18:41 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id c10-20020a37e10a000000b0078d667d1085sm18692qkm.84.2024.04.17.14.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 14:18:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>
Subject: [PATCH 3/3] mm/hugetlb: Assert hugetlb_lock in __hugetlb_cgroup_commit_charge
Date: Wed, 17 Apr 2024 17:18:36 -0400
Message-ID: <20240417211836.2742593-4-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417211836.2742593-1-peterx@redhat.com>
References: <20240417211836.2742593-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is similar to __hugetlb_cgroup_uncharge_folio() where it relies on
holding hugetlb_lock.  Add the similar assertion like the other one, since
it looks like such things may help some day.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index aa4486bd3904..e20339a346b9 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -308,7 +308,7 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 {
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
-
+	lockdep_assert_held(&hugetlb_lock);
 	__set_hugetlb_cgroup(folio, h_cg, rsvd);
 	if (!rsvd) {
 		unsigned long usage =
-- 
2.44.0


