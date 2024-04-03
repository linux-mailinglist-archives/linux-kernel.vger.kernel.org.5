Return-Path: <linux-kernel+bounces-130533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E589797D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA971F25307
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26E8155738;
	Wed,  3 Apr 2024 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIFFF/2K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42952154BF0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174612; cv=none; b=Uhaf+V0vVsbDjho7IJKhJMmyxD6t50MNYu0TcHCscFEwxYmBzN+oVEwfMeh3bv7MxU3gewPEBXE3WoJjH7u9Upd3Ui26e45UPRLCEsHXCH7aIyx8LsgFCON0kcbZqYGnONSTOPwOByOtJtEPbBBoN/CBPhWw5Bfb0n+4+gsxoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174612; c=relaxed/simple;
	bh=VSsRNKh5HqVxQxx4n5MB2r6K4OooJ+e1z93k1bNsM/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDqC1X0XPAJYaw06ORVy69EWkNjghtd3sFrK5kEtfH+YNEEIRElyFaqEVvRzPKlaQudnDEmEoe+Zro1UPJFT9NqyiK4XSJlwaULgsArkeazR6kv8UwBHvjO57MKeueyspJNbokETWVOP19kjnkAmClzx/q1RYdtnrj6KhbUPlIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIFFF/2K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712174609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NQHNmovAOx9ZSifvDIgA24zi3CQm15Ag6TxzIliiHo0=;
	b=WIFFF/2KN/fjle65YPF8EIm4mZCItCobNelINYAoN51zXI4q4h/mieRlpqfBThIEdrq+T7
	ehUg7PjpOvF83gBqqnx9hKb/nMfDTQWTQea6JSFEaTLK9W7WY/mMbFMTX3iab1uu0Voigc
	5MDWqXPsZAj45an4iGBmUHs1FTgklwc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-hEz_3EK_MPWz_SPdoYghvQ-1; Wed, 03 Apr 2024 16:03:27 -0400
X-MC-Unique: hEz_3EK_MPWz_SPdoYghvQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78d3cf6aecfso3243785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 13:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174607; x=1712779407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQHNmovAOx9ZSifvDIgA24zi3CQm15Ag6TxzIliiHo0=;
        b=hgyOB4lInRREKcY6VMuS6MzjplA0CpR0YPiDfsQxIc+cyG0TIYIBsLUWxPBekC37WQ
         XknhAtvnE+x6thwCiWamZG09Ga3JkjZ0G2dwj9y80QJnrM3+FHM9Xjr1xKjJxAn8XFUF
         6Tz/qAuQYuVnCPZINet3qJlTXtFr+v3+5c9pUnFhK7kg0Ug7ETS5BcBZxhuDvkzCLz+x
         gCE0txKtyNRlVNfQM9Afq8xiqvp+myHdatIdH7xLB9iXESqSzpBP9yLrdiEnuKNUznWa
         b5oT8Zr1pXhLB09QmxuSzMKrFJL0bA7QHvCpYUzzrvPpzZQ7aBvOVXHXauf0H041MoK4
         SIUg==
X-Forwarded-Encrypted: i=1; AJvYcCWf4kSfZ4Z1n/l/f8Q1sRADf+CxlT23Zm3fxlZTXhgZqMPoq/VR76lV9MvmgrkjiiC0513mJUkqJrNm99o6ITAEc8IlCQV65owzwRGe
X-Gm-Message-State: AOJu0YwFKwmaWzCptIYowXziaY36j1cp3a4qQzXhW888sRfEXldpzgtu
	xmXwmTVAg+E5qW0+HOihseTTZ31fBoaEm8m24n9FP26bcEYdqAhpcEkm8mBm0/OBh9e0cFoSPba
	s/JA/e+BfNY/EKnTyL4HIujPIo3pvXDS5YCPNT9ELSQ7jrf4W75NAoRILX83K8Q==
X-Received: by 2002:a05:620a:1087:b0:78c:858b:e30a with SMTP id g7-20020a05620a108700b0078c858be30amr381072qkk.6.1712174607050;
        Wed, 03 Apr 2024 13:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsfkSVeNk/2mrnWcz86/GjcnNn671LJqtU7F+xI8QdLvlfJaXwTro1Uwml2W0IVKJBGait+Q==
X-Received: by 2002:a05:620a:1087:b0:78c:858b:e30a with SMTP id g7-20020a05620a108700b0078c858be30amr381044qkk.6.1712174606450;
        Wed, 03 Apr 2024 13:03:26 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a084e00b0078a48172335sm5329727qku.24.2024.04.03.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:03:26 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH] fixup! selftests/mm: run_vmtests.sh: fix hugetlb mem size calculation
Date: Wed,  3 Apr 2024 16:03:24 -0400
Message-ID: <20240403200324.1603493-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Fix up a breakage on uffd hugetlb test due to removal of a temp variable,
as reported by Ryan [1].

Instead of using the previous calculation, use the largest we can
have (which is put in freepgs) and cut it into half for userfault tests.

[1] https://lore.kernel.org/r/1c20b717-c5b5-4bdf-8fcd-d46db135b7fa@arm.com

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index b1b78e45d613..223c2304f885 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -298,7 +298,8 @@ CATEGORY="userfaultfd" run_test ./uffd-unit-tests
 uffd_stress_bin=./uffd-stress
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
 # Hugetlb tests require source and destination huge pages. Pass in half
-# the size ($half_ufd_size_MB), which is used for *each*.
+# the size of the free pages we have, which is used for *each*.
+half_ufd_size_MB=$((freepgs / 2))
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16
-- 
2.44.0


