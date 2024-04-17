Return-Path: <linux-kernel+bounces-149245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751178A8DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324062838AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29794EB5C;
	Wed, 17 Apr 2024 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcdLszci"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578578F4A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388725; cv=none; b=LMPSdF3MiUVgQ7+ytKb3jXOx7In3P6HWDi0I/bfz8AX4YuYwvVXr/+WzH1mjQqJWkwNPmlYSyguPi8HXHMeMGpt2X8g/x/I0aIBPLUsf1GRGXbw3Y9Rdsv5AZSkbE58Yk2455O2H68b/1q2uyN2tNefax0s53Cjryz4LGyJ6pkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388725; c=relaxed/simple;
	bh=irYiypJgFD0pCZz/79o8iDdED7uhhTjSUbG2fBX4vyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNvfAbSjME4ACmAnyaklbBNoDL5uNtAcaBPliRAXunRuRKAMpi77x1YvIHoARmsDEUOp+NR0BskMIVUVxM1hJ6Dq2qMl0quFSuIlPO6fL6m5K6sBUrvrdxzKmaxz3PBWTTqWq8xMe6J0SEs/QjfNGMlbYBz3gBALb+sHuwyY/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcdLszci; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713388722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaZSbjr/Big1ZTWFV5V3ewRiOJHQfxaJnQPHMzFI5qg=;
	b=UcdLszciuQdO/IW6/YG2bjlFb70AotHGLKjgen92SGIjwvNDpNyK0b8TuLceBx45WbGrYL
	VpMZpHnQet9c3aPzc7a9DAUcE0VwLahpRAaONVxWfAxf8eD36znf9N1XuCTm+xZXrpTAEE
	pR6a1SiW8mbO3wDfKlhx0Czxq96/wYw=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-u-Ws97VuM2ek7OnaUp6dcA-1; Wed, 17 Apr 2024 17:18:40 -0400
X-MC-Unique: u-Ws97VuM2ek7OnaUp6dcA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5aa6ba70bcbso37356eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713388719; x=1713993519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaZSbjr/Big1ZTWFV5V3ewRiOJHQfxaJnQPHMzFI5qg=;
        b=NBnT5kxd+1GMWy6VRzwr3xqixBQ0zAIyygnGvF2m+DmPsDxPT2Puwlo+QB0npKonmi
         XSsBOfX+4Rw0t+lgysFPUCKYx0XECWKxftVugPXdTB6tPjvzDAqSRiLDg+T3WS2fA6C3
         wGvzoGFgnWh8Ht/twiHmO731bCtdMKhJ1Caj6w64H9kxBH1nsUUalar1U/8egyP0oX0I
         jVkJ75O8DMVl/P0Uvr55q17I2hm9Mr2Vh/PU/W/tHobvxr6HJ8tQWITwxqvzYpDLeY6b
         kVyCLvSAqiNghnRdomcNWQLGRM30FWLLhDwFRFfvCmMzH1XH+GcsYhIftqRuNFfAQ52p
         MlQg==
X-Forwarded-Encrypted: i=1; AJvYcCWuohqPY0SxHso+OSVQmczc5JKwHXBmF+YofRzSJBrmYuTZbf33smG7s/B33MPjG4InZYQ26bQQ45JHq91o/ZnsMv1ebEoADflShF2q
X-Gm-Message-State: AOJu0Yyvs7UsgtO3QZarJ0Khlqb1EUynOAw5maQb+r2hYKFqBo3i9/vS
	2W3tarud0hLPSpnhtKBGJWwBNyEnV5hTJiDPs2zoXrjee5zzTffh29bH4+h2MowwzhhYhiL1FlM
	CPvyRDU/5dFilc0hzSudSuD0y3FsBdprtSlSbRbekN704RFAcUmhwi5s9wSP4ug==
X-Received: by 2002:a05:6358:5903:b0:189:a9fa:f512 with SMTP id g3-20020a056358590300b00189a9faf512mr791808rwf.0.1713388719322;
        Wed, 17 Apr 2024 14:18:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkJAo39kjQ/eDy9sVg3usabpSgplaT/SVidXPJ26Le9qlIHvGQ4T7UGdRB3oGfYwJTy6M4JQ==
X-Received: by 2002:a05:6358:5903:b0:189:a9fa:f512 with SMTP id g3-20020a056358590300b00189a9faf512mr791783rwf.0.1713388718852;
        Wed, 17 Apr 2024 14:18:38 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id c10-20020a37e10a000000b0078d667d1085sm18692qkm.84.2024.04.17.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 14:18:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>
Subject: [PATCH 1/3] fixup! mm: always initialise folio->_deferred_list
Date: Wed, 17 Apr 2024 17:18:34 -0400
Message-ID: <20240417211836.2742593-2-peterx@redhat.com>
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

Current mm-unstable will hit this when running test_hugetlb_memcg.  This
fixes the crash for me.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1840ba4c355d..7703ced535a3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7529,6 +7529,7 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
+			!folio_test_hugetlb(folio) &&
 			!list_empty(&folio->_deferred_list), folio);
 
 	/*
-- 
2.44.0


