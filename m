Return-Path: <linux-kernel+bounces-74226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C6885D152
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE071F22C03
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369B3D0D9;
	Wed, 21 Feb 2024 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LUWB94C0"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AB3CF79
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500379; cv=none; b=TkATIN1lrW3SCWySGGwFs95WlM5cJYeN1UmiSXTw92RjaHdXeqcpMlKOeBjppwdZ8YoyOhQXlaqj8PKdURzFrXJud2gTrS94huFTh9mPGVE/s0sggO9t/x5a0hqnvaEs9B5ehcyZKEelMZKyCnwJWFofHjKnT2V3+J29+FSQixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500379; c=relaxed/simple;
	bh=1ox+KlmFyzigfEM1ahAanGLox6PX2sF7DV2hmNrOSqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZbS0graqj9tUnDkuaH0Q7kZvivWS3iKhSgzUk0Jjxv2RO+ZI1rS2j0YPAuB+3hclncvU0kM/57+3YblS6TNUrqcB2CFrH11bC3aBKn79b9JDpc1TPXGa1xpSTsHrzwY4Nh3S/Zq9BKDeevAZjYMv6AmqfiaYCSHEf9v9fLL2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LUWB94C0; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e445b4f80bso2413581a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708500377; x=1709105177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkUtPwrd2MxLHuSBqQ67neXeqjLzee+wPf1sR5jV+c0=;
        b=LUWB94C0IVZnKN+0jAr+AbMisiZWqcJ0vaR8MuuZRj+65Qgvs3AYhByzigZdslB3IS
         8njv/WXSyoHk5SRJ/hihhiAaKKqOLPChBUHQ0tKYJSdheZQtm6b2RmVhDDsseOiE5jgN
         iP6jBoxfydGloZ91MvPFLlaIBHXtbs3iht5yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500377; x=1709105177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkUtPwrd2MxLHuSBqQ67neXeqjLzee+wPf1sR5jV+c0=;
        b=lgbVn+ljWgFmM1B7c1r1HEHIxctKH3KoaQGZiOxKOt8WJQ5jyzMPx5H1YBj0T4GSBj
         FOULnRo1rHfm/GFniKn+ZDSp2zaO/la0BZntcmb/vZF3Mj8SriYHe3TXAOHtB0HQoQxR
         I+aKbPqPLJxXF+WjfngBuc2qA/Ws5O+9yI7RE0BlzFzUwuIRnVJ2pdRji4beSxGZg/l2
         FXJsLtWPZRVl5GaF5zk6OBFiDqxwvx7UHuCbQ3/xl827TR3xNBRMnYP96ST2UsWyqp6b
         sS0a8ZQf6wazCe9qPJhJJQoOomTl8ahPXHdcoPX8R73Eg4FKTN+1S7zI7m45ZYXUV74V
         yOVg==
X-Forwarded-Encrypted: i=1; AJvYcCUbwev7+LCgbv2noBGzaG6lDwvdW770yoiVtf80J3rcG2baNZhT4ALM1mJD1GgraQ8uSqWphL6BJ6h+ujNPriMbZq+QDGbQWw6WjRbQ
X-Gm-Message-State: AOJu0Ywh1I6owpNHE/EBODa6QNKAzrrd9pGKNp3rg/Cj8l+yThH0Xs6q
	May9tyH77xsSA70Cr78if+PNXAayz3dnQ5SlT8QlyDn65TtPzqjPUT4/NL5qVA==
X-Google-Smtp-Source: AGHT+IHIRmw7KOf0S7zevk1ZVHq4HTPptYom7wxTZTyuRHTWKzNijZn/KQq93KqEbVhWnYt7rNUGVA==
X-Received: by 2002:a05:6830:10d3:b0:6e2:d888:6502 with SMTP id z19-20020a05683010d300b006e2d8886502mr21734446oto.11.1708500376915;
        Tue, 20 Feb 2024 23:26:16 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:b417:5d09:c226:a19c])
        by smtp.gmail.com with UTF8SMTPSA id d18-20020a63ed12000000b005dcbb699abfsm7827438pgi.34.2024.02.20.23.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:26:16 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v10 5/8] KVM: Migrate kvm_vcpu_map to __kvm_follow_pfn
Date: Wed, 21 Feb 2024 16:25:23 +0900
Message-ID: <20240221072528.2702048-6-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240221072528.2702048-1-stevensd@google.com>
References: <20240221072528.2702048-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

Migrate kvm_vcpu_map to __kvm_follow_pfn. Track is_refcounted_page so
that kvm_vcpu_unmap know whether or not it needs to release the page.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 include/linux/kvm_host.h |  2 +-
 virt/kvm/kvm_main.c      | 24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 88279649c00d..f72c79f159a2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -295,6 +295,7 @@ struct kvm_host_map {
 	void *hva;
 	kvm_pfn_t pfn;
 	kvm_pfn_t gfn;
+	bool is_refcounted_page;
 };
 
 /*
@@ -1265,7 +1266,6 @@ void kvm_release_pfn_dirty(kvm_pfn_t pfn);
 void kvm_set_pfn_dirty(kvm_pfn_t pfn);
 void kvm_set_pfn_accessed(kvm_pfn_t pfn);
 
-void kvm_release_pfn(kvm_pfn_t pfn, bool dirty);
 int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 			int len);
 int kvm_read_guest(struct kvm *kvm, gpa_t gpa, void *data, unsigned long len);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6c10dc546c8d..e617fe5cac2e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3188,24 +3188,22 @@ struct page *gfn_to_page(struct kvm *kvm, gfn_t gfn)
 }
 EXPORT_SYMBOL_GPL(gfn_to_page);
 
-void kvm_release_pfn(kvm_pfn_t pfn, bool dirty)
-{
-	if (dirty)
-		kvm_release_pfn_dirty(pfn);
-	else
-		kvm_release_pfn_clean(pfn);
-}
-
 int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
 {
 	kvm_pfn_t pfn;
 	void *hva = NULL;
 	struct page *page = KVM_UNMAPPED_PAGE;
+	struct kvm_follow_pfn kfp = {
+		.slot = gfn_to_memslot(vcpu->kvm, gfn),
+		.gfn = gfn,
+		.flags = FOLL_GET | FOLL_WRITE,
+		.allow_non_refcounted_struct_page = true,
+	};
 
 	if (!map)
 		return -EINVAL;
 
-	pfn = gfn_to_pfn(vcpu->kvm, gfn);
+	pfn = kvm_follow_pfn(&kfp);
 	if (is_error_noslot_pfn(pfn))
 		return -EINVAL;
 
@@ -3225,6 +3223,7 @@ int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
 	map->hva = hva;
 	map->pfn = pfn;
 	map->gfn = gfn;
+	map->is_refcounted_page = !!kfp.refcounted_page;
 
 	return 0;
 }
@@ -3248,7 +3247,12 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map, bool dirty)
 	if (dirty)
 		kvm_vcpu_mark_page_dirty(vcpu, map->gfn);
 
-	kvm_release_pfn(map->pfn, dirty);
+	if (map->is_refcounted_page) {
+		if (dirty)
+			kvm_release_page_dirty(map->page);
+		else
+			kvm_release_page_clean(map->page);
+	}
 
 	map->hva = NULL;
 	map->page = NULL;
-- 
2.44.0.rc0.258.g7320e95886-goog


