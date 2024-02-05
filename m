Return-Path: <linux-kernel+bounces-52849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587B8849D68
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163242889B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DBF2C1BA;
	Mon,  5 Feb 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYwF7tfL"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A32C6B2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144765; cv=none; b=n9WHwRizGT/T9kjGS9AbIL9G9/QhFx15vXqz7RXQFKLRMcWxCZXeKr9PkryEoBBLyKneNWGTtrWLwjjPRidatuPkKDU7cCML3L3Zk6Oft+EKwLD+OqeNCO7Y9+LHNqwr8DTUp51X8Vq/q/0Y5SRMKfS9G4pochGpIX2qMC1JRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144765; c=relaxed/simple;
	bh=kdUOmRDXfFl0jnIDxBdauT+ue8GQmGp+3PNk2EP1TCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGZwbuZ69JcWpeOVsC59MkF03nvrn7gVqzUx+7mhKV8KdFeKlB2xOtiW9hlVU5facatKORYCct3dnwp0bysWhKbrXN4QMehQXy9DIDI2cgovZwgvPzY9LJ/Z1/xxrIWZawj+8DXeE3k0VJtM3vh7AOXEbFXmNhK1qdLfKTS5B3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xYwF7tfL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56077dd7936so965369a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 06:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707144761; x=1707749561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+B1PQfcVc67wCAzKjMbkuU0YKimpNnbO8uCUJIhj5w=;
        b=xYwF7tfLZewgC+mClXAtzvN7a8QE+WYjQ4//NCCo2luQr9W1TfXBvgkaeu5FBpk11T
         c/YT9zT4zpZzX5Rh3ItY5vqnCcoR6ArQrq8OUyw2UTaYrHnZVf58JASQ/iK/BoMZAYD/
         6Rue6QRwDm3Ctji7cec059l5s1prqjMWIlJxC0jYzRi+kj/cM2KpyIRQd34207YuCSMa
         LgtkA8+IrzF3BBMIjkGT0CuLvFkFYmOSHuFBk1K7Bu1l/lrrK3Ahumsftu+wPDIDoz0c
         8xSP2z+7BPAyO/T5scJ7boS9qsByJx74jxxErUph4qjEquHsHlooTJRnrFOR4VsklAz/
         ow3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707144761; x=1707749561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+B1PQfcVc67wCAzKjMbkuU0YKimpNnbO8uCUJIhj5w=;
        b=NDi+ieJ0SGvKojkQ2u7HJdKF/enS41EYeKo2SnyESjYZLNqYp1v/Dk8DshHJFV0lGJ
         jZmGP79rMECZH/d6aUJ1ooqB6Vdsk3tAIobH+u34kgKjincuwBpvnSeiyNlfcRF2DYR9
         hOTmbtitngiJ2KBJxjB1V+8QUymLD6cHBqrnxQ0lY8vga7uw3WbrzqcEC/ol5LoZre4Y
         gssdrQ9BSxAqHcodm/THyzfarge/KyZClbcqrreHDKqVJzKYMvK4qUZzCnTaTc8zC9mB
         wXkmEm1ZTB1f112N5Xhb2/yX1066jlERLPg77nu3trt9BpG/KlMKnjXarAumIhpE7Y9u
         rD/w==
X-Gm-Message-State: AOJu0Yz7nxL22R8OA1pL9+ViZPHI+acAOuN3as5zIEl8v6EvqeiSqSgx
	rq4ka+jMKFb2rG1rczX1PT8edZIoVjw6saVmvAzo4GZVl/Fahpw65GgsFiqc9w8=
X-Google-Smtp-Source: AGHT+IGG+Z4rp6MIk2RqL/xipEmA/8eU+tKGuvnFbLRs+W5ftWOW2kQ0uAQc5mvqzaC5TFZudNMhsg==
X-Received: by 2002:aa7:df14:0:b0:55e:e9f3:4f63 with SMTP id c20-20020aa7df14000000b0055ee9f34f63mr5397435edy.3.1707144760808;
        Mon, 05 Feb 2024 06:52:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXetjilpo/u+b9OWUhUddsYGepxvOzImn+KeO64qdnzYe7m1v2v9migu3ttmYYHK/pckPkqrERHQqUnzBY5T1/5j5BOsLHLyLcxE6FCtvOnuH2siRKTDrudh6LwVVrUSimPhdtB+6WEPdf98TrRy130u3b49UZAsxS/Z2bAyTn4v6+/1/qz2+0mB26Z5ln8hL8ifbL3Im98npQuQS+EaLrjbqiMHNBfhyNtRliMumlGIJQjPgEPsR7/u++dGOT2MTBdJoS4MX57BQk=
Received: from ttritton.c.googlers.com.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id h31-20020a0564020e9f00b00558a1937dddsm3821348eda.63.2024.02.05.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:52:40 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org,
	bettyzhou@google.com,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH] selftests/mm: uffd-unit-test check if huge page size is 0
Date: Mon,  5 Feb 2024 14:50:56 +0000
Message-ID: <20240205145055.3545806-2-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If HUGETLBFS is not enabled then the default_huge_page_size function will
return 0 and cause a divide by 0 error. Add a check to see if the huge page
size is 0 and skip the hugetlb tests if it is.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index cce90a10515a..2b9f8cc52639 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1517,6 +1517,12 @@ int main(int argc, char *argv[])
 				continue;
 
 			uffd_test_start("%s on %s", test->name, mem_type->name);
+			if ((mem_type->mem_flag == MEM_HUGETLB ||
+			    mem_type->mem_flag == MEM_HUGETLB_PRIVATE) &&
+			    (default_huge_page_size() == 0)) {
+				uffd_test_skip("huge page size is 0, feature missing?");
+				continue;
+			}
 			if (!uffd_feature_supported(test)) {
 				uffd_test_skip("feature missing");
 				continue;
-- 
2.43.0.594.gd9cf4e227d-goog


