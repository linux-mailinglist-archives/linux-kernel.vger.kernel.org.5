Return-Path: <linux-kernel+bounces-135073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B45C89BAC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4422C2821B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4098C3FB83;
	Mon,  8 Apr 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuXnVE+H"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442CD53387
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565920; cv=none; b=uIQSgPNqUe6HQygVPNUCwWtlOwj1wqJzk3KGI9zs6yr9FAon7RB9I78/5k8TtmiLxOCV+2ka05wPzDe2RRODatyV/ckmN3N0jLcxCjXXQrUlRkfPqTmt64+mFJyOwTLUFu0C9ZpUXBTt6FKHxMB87DGtG6j8t4ZDkbeuqhUAmLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565920; c=relaxed/simple;
	bh=aGK4zhePW20kLwgx/TX6NVWf/ttEsE0V30HlU+WDQjg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qnWPgk7izlCcQDRQssXjCFnqtPJEopialnh7w/m3Sykv0m5LYTi0Thi1sdYE8LUUv/jOTvMmEAEeF8Tip9ebkWd2bJBtc8jDa+bgWlTSLJHUKRAxMN0NoBzxSzkvtvGnrDCXbrRVWqZRpQagyGh9FUVp3mTSq0ds52jR/mKH54g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuXnVE+H; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e41f984d34so5109775ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712565918; x=1713170718; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKAsQHr+DWmapUhPnpPuusVB9er/x+oNSaWQjeg9mXg=;
        b=HuXnVE+HE1tYXt/f3kwsV0AtcKmilGOu40wJhNnW/KTsphT3y3Xfh4+vSK0PvG7E50
         tFyiJgcl1fmM2ay5jVWIUHXzkwqS3+4TdFq/feyV+hcmNr+Cc9teTSKxEoQ535GktgFo
         nlsnuFvoxVTwicq99V1zAHJAMkkYOheFusOCpQPKzNuHgMXjjNOmENs6RNWL1dsoUge5
         KkO9sdHHOqA4B65Ko3gmUW2sEn7hnfeQDIYEHn4YNQRs/0Vuq3mEcJONnyTiagl4MTFg
         bfF3YatxErqd+zGGlGMDXwg0bBHlxjl5Z02UkG/Y9IBcE+pPkd/r0aZZ8iEvBZ/Ceipk
         z3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565918; x=1713170718;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKAsQHr+DWmapUhPnpPuusVB9er/x+oNSaWQjeg9mXg=;
        b=MzIbQMwKAoG1gM+ddOl5r3pMpZxXBnudN366o+2ZcgqPFwAKIqSR+JDpA4q+xSNmvo
         rBt4n9jXLowzNBzdKoJFXWLMlFUc4PXvMvhMxys4KiUka/HneZwHr9/tLl4QxURI+jPK
         IdC2NA1xDIqxagoO0aKDSLmUkI6HpB0Wa3dt8glqExXisVhYuQ2IFTgeQSVUmZ/1K3XQ
         s/dZ3SeUadNUqKW32rqLyiT7YR6vpjndp3K0IVaFPqdgEoc+hSt4ZCK7kywMyvQVNBoh
         GmFYYx+E6oEJyVqUTnxDRGy9/AMFR1FA+h+Bz/dM18dl2yLvx0NdGvSOASa6rT5tUW0E
         8m2g==
X-Forwarded-Encrypted: i=1; AJvYcCX2r8x22+X6XbLsjzbsJutjStK971+Txwe4AylcbxlQoU6R19p85KKyVmU75ryivrGEBvez/eJ5gTZv9g2LqkUkwn5Dfpfww/HjH4PD
X-Gm-Message-State: AOJu0YwaDQiEwAJ6GWIoac7ozkSjQ6dI6QNp9NtJPrGZYKyMPpX4P9Rc
	6JRS6jOjGHtTSnB+8uaR80CKORM20g8L3F69kIq65daEbIydrxFm
X-Google-Smtp-Source: AGHT+IFghnviN3j//iMfJqIQlbmSC2kF5vTjuvqRbIeXM5wrdow02zE6yq/U33RQy+fd3wMePMOPTA==
X-Received: by 2002:a17:902:c946:b0:1e4:1bff:1f6f with SMTP id i6-20020a170902c94600b001e41bff1f6fmr2006867pla.50.1712565918532;
        Mon, 08 Apr 2024 01:45:18 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902e84300b001e3d8c237a2sm4329466plg.260.2024.04.08.01.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:45:18 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: tj@kernel.org,
	jiangshanlai@gmail.com
Cc: qiang.zhang1211@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Add destroy_work_on_stack() in workqueue_softirq_dead()
Date: Mon,  8 Apr 2024 16:44:04 +0800
Message-Id: <20240408084404.31991-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This commit add missed destroy_work_on_stack() operations for
dead_work.work.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/workqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index db004d2180e8..1edb0b06ae7c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3661,6 +3661,7 @@ void workqueue_softirq_dead(unsigned int cpu)
 			queue_work(system_bh_wq, &dead_work.work);
 
 		wait_for_completion(&dead_work.done);
+		destroy_work_on_stack(&dead_work.work);
 	}
 }
 
-- 
2.17.1


