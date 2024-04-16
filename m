Return-Path: <linux-kernel+bounces-147670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E358A7787
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FDC28308B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A807FBAA;
	Tue, 16 Apr 2024 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mZFsERtc"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2EE6BFCF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305408; cv=none; b=QYbTHcxhoc8cvub6P5IFGs1NJVAnezRv9q8FVVvdNdh4gbJL4KTbMkWuzz0eh+r+9rTRnv1zE+RyH1vYMN8D52iYDbybZivB6TAVCdPMObl98N4B2zhYPkfAO7QOqOj4EwEIWVDepOWb4/BGhPYowSpdG0r1+1B1tVjuWoicsWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305408; c=relaxed/simple;
	bh=WRfn/cAsNNMRbBq4GuWQdlT1whoo5mgh0SJ91YMp45M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/I07Xj9CuXU/fKVL6/6oqntBaz1ZroGDbFVgbBeIahgOzgZc2QAt9Pk+UkkmRvajN6VQ0XTd2Ff4m0uvIJTkaZM1DljeA/LNtvHfRbwxP6eyoRpneeqmXW2E7l18L5zOlChog1zE9GSpST79OhQGL3CV6Ypn060jqNnlmu05Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mZFsERtc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed267f2936so3932541b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713305406; x=1713910206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWpnbwrols/HFksVXx6/pFTtlVbtQF7yySAM3VjY0NM=;
        b=mZFsERtcoeR+yD6q+ecfyS+3pRFu1IrSUxDCgnESXNVP2gX3duOq02JoBYd6onKPkO
         QCzTDUlGVfwb63i9R7CsdkZqM9YWeTQnyYrKVvFV29f6SbA56cKAk3yKRQzaaY+bjogJ
         jBhp5wjwY3vGVkiE62AQ3mbu5JxPW3bDGs7Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713305406; x=1713910206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWpnbwrols/HFksVXx6/pFTtlVbtQF7yySAM3VjY0NM=;
        b=DPFXklR21hLVg4ICS+AoF5LCseku6TjBXNpNVNPekNGegCGIiPtvL7UPeUKw3sLw1J
         Ko2xc1S+mqH1ER7lvH/BqcDpVKN+rZxY0/37cbE/MAZvYQqVRDccHfrpUzd0zJQ3nMZY
         obLyhSRbmTAs6GQqIF+eP55aIpj15e9ON+HJshgleGL+G2Nka4dKEUYRov/RMPuxBcoG
         s1O4sxnUaQBH10jre8RQ/HELt/Igx2Qu5IwdDriHhppwtFk5tqRzDTv5LfLbRzmLZowr
         cy1ci9t4+j5enmokBW6SEsLBehL90T4tg7zFYOJ+pTuMvtkKjOUvaBAQy0nEu1hDESjz
         1EfA==
X-Forwarded-Encrypted: i=1; AJvYcCVDXpX+X+Nr8HGWxIEyxhPxO1+72wmVRAnsaQ1IASC5nsEispbzSy5iqPjj9obEsOId8j7GCWnctS2mQfkzdN93WRF2SzeLpd+C6LI2
X-Gm-Message-State: AOJu0YzIEtjWnZo/6juKSr70yOzV08v02G1uIF/y5Rca19hij1VDcRHk
	Zy33/Jh0Ijm0zBcyKx0/LNU3fAjnEk37WlB7uTEbeSQKv5/ugKX9bLUk8lk39g==
X-Google-Smtp-Source: AGHT+IFXzTOtdhmzkFf7kvRjs/2yOBCu6yaN7ivsHMPoTYcwF1gpR1l+bDIYrHHeInvIb0cUfNNPvg==
X-Received: by 2002:a05:6a20:9f86:b0:1a9:db37:bef3 with SMTP id mm6-20020a056a209f8600b001a9db37bef3mr8840834pzb.12.1713305406053;
        Tue, 16 Apr 2024 15:10:06 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id q4-20020a656244000000b005dc4fc80b21sm8032266pgv.70.2024.04.16.15.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 15:10:05 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	usama.anjum@collabora.com
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 0/1] selftest mm/mseal: style change
Date: Tue, 16 Apr 2024 22:09:43 +0000
Message-ID: <20240416220944.2481203-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This patch is a follow up to the comments [1] on test code during
mseal discussion. This is style only change to the selftest code, not to
test code logic.

Please apply on top of mseal v10 patch [2]

[1] 
https://lore.kernel.org/all/e1744539-a843-468a-9101-ce7a08669394@collabora.com/

[2]
https://lore.kernel.org/all/20240415163527.626541-1-jeffxu@chromium.org/

Thanks


Jeff Xu (1):
  selftest mm/mseal: style change

 tools/testing/selftests/mm/mseal_test.c | 124 +++++++++++++++++-------
 tools/testing/selftests/mm/seal_elf.c   |   3 -
 2 files changed, 91 insertions(+), 36 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


