Return-Path: <linux-kernel+bounces-139875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C258A08C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C34B26603
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F45813DDC5;
	Thu, 11 Apr 2024 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggKgHlAm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529FE13D8B8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818046; cv=none; b=IKRhPo8mERPjA2eyC2FDfSVMa/WxTNKJymcujHMC08iZ2+2CoYzHZAbDVwQPzyepGc1aEmSEaWWYjLPxDth8GGpN9P2eCjgGBzq5TIMIEFzHwiE5Xb51tFzJpB6cR+DUjlJjQfddMEsNaVABk1HQZKEiuHke8UkYPsnegxRjRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818046; c=relaxed/simple;
	bh=iPcZnylWBDvRsCE2L2tauJ8vojH2Mnl9xe6UlPGUsUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUqLFKi/gfZGYKg8qvmTQ8f8LtyJKr9oPNILPiE7paTfQjwyI46EK6xuP6OWYo/OuYQcshTZZKuPSks630BazE5WzMq7t3uVoZCfh2EEcSULPmSJib5AZou2pOg1NW8fliZNzPqlCaE1YjCD/NKQtjahlTns91Y9ZJZkYaYXouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggKgHlAm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712818044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vn3kbYVAUInyEJqyRV4/bjgt4/apuVePLjXauHm/Jbw=;
	b=ggKgHlAm1QVdYuwEaD4cJnT5jxsJ6Xtn+NlKT6K8xT6JVvJfXeKDbWvnMRA4CMOOrkpJj+
	nNND3MvJiyTAd/4V9jgqHU8I01hGiGwPgx/KoRnuo4HYlZpIme7tpqJvRvMywiF7hqMYmx
	AWgjM4WbRQwjORaoVM9VIi0iD80IeVo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-AUO27_dYOISiQpl5caKTZw-1; Thu, 11 Apr 2024 02:47:22 -0400
X-MC-Unique: AUO27_dYOISiQpl5caKTZw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56e5309b4d6so3166552a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712818041; x=1713422841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vn3kbYVAUInyEJqyRV4/bjgt4/apuVePLjXauHm/Jbw=;
        b=YclwaJcPLmT/m8BnjL2bCWNfIezCLv2Uod+KwjnJcuPU26Oe+cPDVDkL+YHKS90jtE
         MZk9J7Xs7MBBqxheqSPNIXQz0TsnlmWLrWCfJ2vyXMkeMqow6dLxF10kA1OvffAfgh6q
         KwBOiR8jA/QR3y2Q56OY+G9KewLD+Pvuk5nk3tdRPNvIpauRI5CUr9rmwy6xAZiLLIY3
         UyuEZDp+G/jWGAqBF/OoynUcyVxZ1/UZRrA7x7hDPBRkpBRt/qjwwX5M6y+QPTulYnUD
         M4ezfrVyemd3gXsPNUNV5SwKTG1rvfP7sMfd87XoT9GDwVqfQRFAC9H6oV/+e7h3aMbT
         CCYA==
X-Forwarded-Encrypted: i=1; AJvYcCUrBEEWb6jO7G0dqzd0vr4O8k8p41AD93JzGsZUYwdFPlj6Eppa1yKAXGjGsAjX0fMD2MvUoa8mGJOV/1OVwS3D8LOoizgHs7gi64Wr
X-Gm-Message-State: AOJu0YwInnB9tEYV7XWBKorEZHtzcmzWeYDd+MqHjdkPVeFQ7KoyzRCc
	TUcE5YdFEtaCXZ/vOUGLrSRPSnfomjAOlyUO7JIKY6NJucP6UEf+UZfoVJsbe9ABLW0M1IpsMgu
	zVwouCDfySlIenYsNbUBUWeae4GYKWVKhE3zz2Hp8551G3//kJW4HUGV2kGU85g==
X-Received: by 2002:a50:a6c3:0:b0:56e:249c:397b with SMTP id f3-20020a50a6c3000000b0056e249c397bmr3161073edc.28.1712818041130;
        Wed, 10 Apr 2024 23:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKs4J/uM57MehjBI+61lKXrwLiEZhGYSLsU1b+KUKxKXHJKqWun01zhOxsd8/TdjYqEwnc2A==
X-Received: by 2002:a50:a6c3:0:b0:56e:249c:397b with SMTP id f3-20020a50a6c3000000b0056e249c397bmr3161056edc.28.1712818040746;
        Wed, 10 Apr 2024 23:47:20 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id s24-20020a056402037800b0056e44b681a6sm397057edw.57.2024.04.10.23.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:47:20 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: improve entries in CODE TAGGING and MEMORY ALLOCATION PROFILING
Date: Thu, 11 Apr 2024 08:47:17 +0200
Message-ID: <20240411064717.51140-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5acf2502db99 ("MAINTAINERS: add entries for code tagging and memory
allocation profiling") adds the two new sections CODE TAGGING and MEMORY
ALLOCATION PROFILING. The files in these sections however do not match
with the files added in the corresponding patch series.

Improve the two entries to refer to all files added with that series and
drop the entries to non-existing files.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2d913c64704..e5431f06ab55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5332,6 +5332,7 @@ CODE TAGGING
 M:	Suren Baghdasaryan <surenb@google.com>
 M:	Kent Overstreet <kent.overstreet@linux.dev>
 S:	Maintained
+F:	include/asm-generic/codetag.lds.h
 F:	include/linux/codetag.h
 F:	lib/codetag.c
 
@@ -14241,10 +14242,10 @@ M:	Suren Baghdasaryan <surenb@google.com>
 M:	Kent Overstreet <kent.overstreet@linux.dev>
 L:	linux-mm@kvack.org
 S:	Maintained
+F:	Documentation/mm/allocation-profiling.rst
 F:	include/linux/alloc_tag.h
-F:	include/linux/codetag_ctx.h
+F:	include/linux/pgalloc_tag.h
 F:	lib/alloc_tag.c
-F:	lib/pgalloc_tag.c
 
 MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
-- 
2.44.0


