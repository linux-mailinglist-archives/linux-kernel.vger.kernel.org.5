Return-Path: <linux-kernel+bounces-110838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB06886492
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC2F1F22911
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340DB1392;
	Fri, 22 Mar 2024 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7xuTVW4"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F808376
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711069738; cv=none; b=PtNTf1je3xTi+kqcApfZJBj6kgkQ0nJAo43SXvxPUukLdlTbOZVI6vxNrup+tQKJustivmqI0I30DLgiSAbBLg/a4NBJRFe67EyFoYM0N3GEMQeLX/l6gp5sHXzaj6ULY0xon+//ctHQrEXvo62wVJU3f+9Sxa58LtVzsFftGgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711069738; c=relaxed/simple;
	bh=OfGge7sG/ns1z/ItuB0Kcv1DpFj1OPQ1tPMi+jFOVOY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GH8Lowi14QKBFlcjdIIrLd+284yx4xx7/ScYag//xqwmDAhjc0mdMPeJz3uEtDDv2M4EaC0DGpzXkfMWnG3CuCKaQCE3w/5uwEnGKWpKHfHR/PmRN+CsXZbE3Ck/5tsqbLHIQUnGYdWPlW43KvYfvvABFV6evjqi9u6CB1oLtw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7xuTVW4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4f312a995so701270a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711069736; x=1711674536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R+y1XoQi4L4pB9dXi4cPQL39QfY+GN+c/qrd7Sy4OvU=;
        b=d7xuTVW4SivG0vyvTbUrFEYr01NbbEUBtkH4uBkO6ZrgJ4tYWvxmSYu18KALSeZ3KU
         Xl7B+uTpwlEVEU3tMZZcYn5yoWQ2MM0w20cFG3f4hT5QZIUyJroswo6N3BE5WEQ60Oeg
         SINPIKbK7Fhihup7EcNQ2/Eqy6uOMFwpGqdUteKhe1/EHtyHirrVZjgqfEAA23HdLrn0
         /TIwwUae3La8LNJLLHBEzT2SrYUScU6ZnD8aAPcS1T1/opMjblS65ot21d5/hjxlllq9
         0J6wqyMMcuq+F1Qdp6atUVqO+E1kCRz8uyrO7UVpXgVVhkCbmKY289UrXBJtwzp0xRbi
         1F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711069736; x=1711674536;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+y1XoQi4L4pB9dXi4cPQL39QfY+GN+c/qrd7Sy4OvU=;
        b=kbHbhqyjioQYdg1TfvBzMmB6OnSid8SOIZ6N6kHMVShB0ing8M+Hm2muoBbo23m5sl
         TlLhXSDNUMoDmA4oQugjZeyyT9YX6DYXIMRkr0TPd+FynEhoKbaLsD5o7qkOsSLikdYs
         ePVR4LZ8Wcm1NDKb+EtDn/YUhhX6cJtJUdv3IlmCl3mi9J3SD2Q066Fg+P9TSwzJLVdB
         A36gws6yBnuEhLX5olc2osTMTYwWZEj5Xko3a+ZfQ691S7E06tjWqlNNEM8BO5U/HXnd
         ushuDISc6VBPM0l6D2rAIRy4osKRx4GSm1QGIGVDnd1+Dek0dECFVj1nhjYtWIONNKQA
         hTow==
X-Forwarded-Encrypted: i=1; AJvYcCXA3idS/EoUQbx54kkMqi+I5STuxSNAcCT1mLuA2Ei/2F9eCNJRNMSL7KQXLYsgQDjlAFbB4kGeQgME8Y/3V1t2hk/bEPoRxneKIjMs
X-Gm-Message-State: AOJu0YzlRHmHE5ov3DqXWyjAMZABKN6lKsxL5KLCwCYttq91bKVMPYqe
	yH3wWtQqgzWU4Y5RtxNBckfcVIUKWkIhWhVrDyWjk4tx3UveDgDYQu1JILHDaNS7ag==
X-Google-Smtp-Source: AGHT+IHfIQh71vgw10rr70rB9vqV/a/XdtF6keIbStJjf3iqaWb8qzS0oZN3PCrqBe/2yKDiiHU1ezg=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a63:d30a:0:b0:5d3:832c:4048 with SMTP id
 b10-20020a63d30a000000b005d3832c4048mr2276pgg.9.1711069736318; Thu, 21 Mar
 2024 18:08:56 -0700 (PDT)
Date: Fri, 22 Mar 2024 01:08:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322010846.305860-1-ovt@google.com>
Subject: [PATCH] efi: fix panic in kdump kernel
From: Oleksandr Tymoshenko <ovt@google.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: ovt@google.com, johan+linaro@kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Check if get_next_variable() is actually valid pointer before
calling it. In kdump kernel this method is set to NULL that causes
panic during the kexec-ed kernel boot.

Tested with QEMU and OVMF firmware.

Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
 drivers/firmware/efi/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 8859fb0b006d..800b85807a02 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -203,6 +203,8 @@ static bool generic_ops_supported(void)
 
 	name_size = sizeof(name);
 
+	if (efi.get_next_variable == NULL)
+		return false;
 	status = efi.get_next_variable(&name_size, &name, &guid);
 	if (status == EFI_UNSUPPORTED)
 		return false;
-- 
2.44.0.396.g6e790dbe36-goog


