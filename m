Return-Path: <linux-kernel+bounces-166938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605AC8BA24C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913631C224FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B02A194C86;
	Thu,  2 May 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ZFY1pj5W"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5445E18412F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685222; cv=none; b=q7b6JRwqRmZychk3htGkkwBHwNakueaGxuk7yqkMurUvJyDsKUYPTxcWVbWwPcBPBrDqCpRSz1+Jq/P2GV+bI2Ua//DPIDdUnH9ljEOEhs35bZgkc3MWKd1tXLEuotVd7EAZNj3MgyfvNZqLHBl2/uLfYUaLhG4+z+ZBW2TOjoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685222; c=relaxed/simple;
	bh=ai0A+jvOaoWTjJ8XMXQPgpwOrGyUp9q+UPbAaXoatbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5jCpFB7WTHcMcSF6cYKnTjZhW1YJEwWFtzfn/GJWdW6yM5lUX4bzmgq7t/LKYKpf/HBvy+rIZhjTq7wDBo5XmvrvYDPysWfkGSI9gF9BL/18s2dMjx223Se/STzkBTVD+ernFgv7/ohy+rXmzh2IR7ZCyBLbpOJ7z801GdEUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ZFY1pj5W; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a58fc650f8fso699921266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685219; x=1715290019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxfLbDO1iQp9CdZDyWPw+FjwW6do8u7NB+ZNT2vfVBM=;
        b=ZFY1pj5WRXgjUHFgbKM1SJOp2MW9LwfO/toRzjQhsqpRE8SBfAJl7MVdbWevTyDNmQ
         taZeG09m0bis2ifAdEWb2dcJ4YCya6+qpN3Fmn09/pIyoDSP+ktyYi77c20NLTFnZvkG
         AVs76rZubFyJ9P9x/JFm14kkn9TYBwaA0vdeyz6zOuoF+iDlaNNKNiCuYkxqIL8Asq9+
         SlGoqyKWCoFBFOq9WMxPCkFHzLcB/QXKXUxiaXh1tfU0TWn4bDnrLz/It8hnhGjRb3pj
         17mXgreQar344I2+bYaNlfBvbJCKKrzn0sBWkHhhfPhJrVhcv6NW2PVjJRqJ0CE6FDKx
         fFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685219; x=1715290019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxfLbDO1iQp9CdZDyWPw+FjwW6do8u7NB+ZNT2vfVBM=;
        b=is81NtrmZux8AMlsofStQHFItEvP+wE9Y8TxG9EdjexTc4pGh7A6ZhnYv2B9eKooAf
         SFy33NFSFQDxkKMFBHqTyqEwItjcnacTomYP7See06brE2NjhJUjpNKoLoPRxn/W3ntj
         /a2M0J6BjGgH78dr+lmkLoouftZfXY0etn4v26S8jOC7htEN1yFqauYqs/cPcZX7VMQB
         ymlVC9HQ49Bo57dC0QAyHJbcl7TlaAzfYi5ftehK+zcM4F+bNtdbmywzo6fiZcac5xEY
         Cu2riJw/wCNGzVuA2UY3cOXTjhUgDXmGYbFd0rqWWV706pwPuMOLAgans/g8JGsfZNcZ
         V6Og==
X-Forwarded-Encrypted: i=1; AJvYcCVYzUodSP17yMrtoPRfJS8RAg7OJdKXvejMHQvvHaYyuFOqRec3yLMWeio78WHm5qQKEDplonzZzijB/SXSNGO6DpQi7jMVwEsyxaPe
X-Gm-Message-State: AOJu0YxcVNeUn3Hw8pcLisV5O/AmA7hm+S38ig1K0n+DhOhS8Be8OJSu
	1DEg74XarJ5L4+FzGm7LpvFSMtkMp3G/Q2CjG98Joae4JQ+VawehfeGNpWbeNj8=
X-Google-Smtp-Source: AGHT+IErvofVOlcBRqerAxB7KV24lTnlqlYfvQ1PtbkRzl2rNuYMLblHiMHF3fUAnpQqQn7VMD23ZA==
X-Received: by 2002:a17:906:8314:b0:a58:a1e3:a2cd with SMTP id j20-20020a170906831400b00a58a1e3a2cdmr379328ejx.55.1714685218619;
        Thu, 02 May 2024 14:26:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:58 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 2/4] fscache: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:29 +0200
Message-ID: <20240502212631.110175-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502212631.110175-1-thorsten.blum@toblux.com>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/uio.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/netfs/fscache_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 43a651ed8264..7b1ad224956c 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -9,7 +9,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/uio.h>
 #include "internal.h"
 
 /**
-- 
2.44.0


