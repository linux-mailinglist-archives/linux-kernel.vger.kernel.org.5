Return-Path: <linux-kernel+bounces-154168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855968AD88E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 092A5B24403
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6221D1A0AED;
	Mon, 22 Apr 2024 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GGZh+Zl7"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457119DF66
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826645; cv=none; b=Mi0WEdBxV+PCtICHFfrSM/ubCBnqTyjV0lT2c1vKfPBL2kLh8iv/c3uRaMTUr4/Rw1RIFsUZcXB+8olzUXTqYl3ntWNvlz7j8ejIT9yTfySzuIU68mNbc9Vdier6SuEyrJxzL6R4wI7zZclyGixZmt0JUQ3B1Z/Km7O48yR6GMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826645; c=relaxed/simple;
	bh=BTdB/bKcsgIg8SG05ME4z6NR7Hf/yomiKs5wTQl9JKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NYv9gjrkP2ql2VoaVn98VtqDrtOHVdA4BbYmRWkSKaHNa/IIvmkqh/rIrX0ds0WDw+hTTcU6UZmGD23gkgoMmNpJoZRtmJNYA00EdyW0DoE1lewBKWu7PTL6vX0eqqlLthuXVczUgJboIzZFUHoYFI6bcYnLscqBSKOBTpvZQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GGZh+Zl7; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6eb812370a5so3092404a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713826643; x=1714431443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fIJKpP9PuqIwYQVQAXhh3lvsNULoqRv8W6dHtBpvXk=;
        b=GGZh+Zl7G62V8w+3ynRNV0ZHxo3PSqc65mVl+O5uBMrg/HefmOKZxh1WS4Cw4rrwjJ
         +ceBFmXV0QC5EAvK5UK0wEPQX6CNracDvtwZ//kjS5OVvNkS8Du5MGkdedRJDYkXF3Xg
         zbctJ+o8DHMbyfJdRKv1NxJNgfvfJzVBwOEp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826643; x=1714431443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fIJKpP9PuqIwYQVQAXhh3lvsNULoqRv8W6dHtBpvXk=;
        b=l1Qh4da0QaYHEQqkXySoM+ZzGRlpkcalpCZBtJRxmK/ZlDVZJ8p+iRnDJ7copC0Gbg
         YvQZLhP571X3d7OymugsCFxvaDDoSJ7uHXllXPcjQ1swG2SWNHSyryUimGqQt9UTXT2M
         ywFoHSAa10x5DyOL5BDq3MDk6tBo/1ic/ruf8vtSOJiiHaUqtkfc8T3i4+6aRjFAh6AL
         fw5dDA0QsYFQZDY/i4cPaNNolK8OLTIYiTQIXNVAetUlf1QimuOGsn8N1ZpOAOIPudun
         oAdJaaAba7QzYmF5VWhWvo50Ntkhg2gPAwhmZ2ioUzj7Xc02xGEeUjAHJtqwPM1XVgki
         E1tA==
X-Gm-Message-State: AOJu0YyLUfDxQMJG4WojVI9xfnBSYEe7WzDD+nLSN/UJyeFflnuvUZ7E
	AzOK5jc6lEEMDqOjG6zZcLWfoAwkN87LXpb70VJ59Iccw8g52DyPPsmLIyw26tOssQaqLNVYN0L
	4qh2DFZeOSU7r1sqnO8uslsnBvs/GQZKIdBeZMWZXnMw0T88KAmeVdBrKMObkPN0BGwtfQJOGLJ
	miaumvKSs+U7t11udYg7PAEWKyzsQt6ZjbDEfC6a+MHQcUOaBcgX/d
X-Google-Smtp-Source: AGHT+IEv2WhbdeTm+ITZUjA7wRjDe33Me8JI8D8cOBtCVuMHtiFWNGlYrKrwKoReJqK7LTHdXsmAJg==
X-Received: by 2002:a05:6870:cb91:b0:22a:9ea4:c18 with SMTP id ov17-20020a056870cb9100b0022a9ea40c18mr16126552oab.15.1713826643266;
        Mon, 22 Apr 2024 15:57:23 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id e131-20020a636989000000b005e43cce33f8sm8093597pgc.88.2024.04.22.15.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:57:22 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v8 6/7] x86/vmware: Undefine VMWARE_HYPERCALL
Date: Mon, 22 Apr 2024 15:56:55 -0700
Message-Id: <20240422225656.10309-7-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240422225656.10309-1-alexey.makhalov@broadcom.com>
References: <20240422225656.10309-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No more direct use of VMWARE_HYPERCALL macro should be allowed.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/include/asm/vmware.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 2ac87068184a..84a31f579a30 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -273,5 +273,6 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 }
 #undef VMW_BP_REG
 #undef VMW_BP_CONSTRAINT
+#undef VMWARE_HYPERCALL
 
 #endif
-- 
2.39.0


