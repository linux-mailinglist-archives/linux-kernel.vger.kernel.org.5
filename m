Return-Path: <linux-kernel+bounces-34542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3D837EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B60C297E88
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808DC612F8;
	Tue, 23 Jan 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eisSFIOg"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE187F7C8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970761; cv=none; b=la9+RPEpxTY3psaQbIMQKTHiA84k6wF5E/qXgiOpYQbmFp9sNswKhUMdFfmPjdGiPKCbpZSLQy950vVBi29YxQChZ/9affwUN1xy5MfhCHTZF26Tlf2ZAh0AZWxDrEiAxQq6okenKSWK3xhZesSg6NS0zGgpaQVFtMlJk7CScoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970761; c=relaxed/simple;
	bh=otrmpo4br5ciuWiM78a/Ceyb2KdAR01tXk9aBpC8wMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ue6Ael8mh12OQgVnNWVQSBR07G3A2rnrpVhPZ9Dhb1/2z2QQXwA/hn3VTbh4RMNy5hUENFfKVpqriyO8Pd285UEe1UwqWpWVc/exRg3FKejfa5mCKKB07uXy/75dE/HG38/vCVdaneC8y6u+HSR+szn2itXwP1OWskO+USCQ/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eisSFIOg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da9c834646so3761176b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970759; x=1706575559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7qeKC064ZzlHJa5msLrHHdCXg1stkKcC4+dJKmdneQ=;
        b=eisSFIOg4fJ3vz+bS/iu3KnkrgcvtlmfD/uWTb7T5vEdGsjqRSMe86hoDv4U/tNV+Y
         4Vj4tG2KD3+v7KuRhIlPs7aYoprJNO0SANxUOoVQPNyca6DmEvSB9eGQvrL3ij81cGQa
         r3jFVmpg6E4I3ga+Km1hyGgbM2j2k2pJdlKr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970759; x=1706575559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7qeKC064ZzlHJa5msLrHHdCXg1stkKcC4+dJKmdneQ=;
        b=b6vGJQHej9AO8uaR0i5vWzS7ngbdOKlwhXGnPGp3BNBhMWWxsBpg+n/R91mwWciJpF
         SODTJbmBrRiymQbd3LZOqJn/12DRVFnVFd1rlgGolC4LeEKnx4UHJheM2xrV8UyZ3r1Q
         adiTScq3ki5sAODIcc2dIEr+jj3eQSq9XYj9r74WJVJRK7DoqMgpvdIYBklvTXXh12Hk
         QjBMCqeLL9ZukC5EXsPnI9mqdYr8s541xb3qcgn/dP+UW1nm4ETfKJNxlpGdKuBXikIo
         646l1jC3VNor8/LlzLrBntyj6uMW3EVx/IguNJqq+Demhp5fOHKS23Xge7ohOszTzS0+
         fBHA==
X-Gm-Message-State: AOJu0Yw9ktbjWF1paXcYkqLDX50iDjkm0ZRfWICQG2kn8jQzeOOf4tnc
	TpCAwuRINfAHztIG9ol2EpTxWXs2ZCU9RIiZJxlmKSjzR6RVOYRa205xrz094w==
X-Google-Smtp-Source: AGHT+IEfPSCAfbNkrsnvfNR/6lrRJTvzZ8aFbU2AhLJiZvXczWMg97ditkNX3fZkM39QiMucgiQfyA==
X-Received: by 2002:a05:6a21:32a2:b0:19c:30a5:5c54 with SMTP id yt34-20020a056a2132a200b0019c30a55c54mr4120604pzb.28.1705970758815;
        Mon, 22 Jan 2024 16:45:58 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id dj11-20020a17090ad2cb00b0029051dad730sm7733772pjb.26.2024.01.22.16.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:57 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Dave Chinner <dchinner@redhat.com>,
	Alexey Gladkov <legion@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Waiman Long <longman@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 82/82] mqueue: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:57 -0800
Message-Id: <20240123002814.1396804-82-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2072; i=keescook@chromium.org;
 h=from:subject; bh=otrmpo4br5ciuWiM78a/Ceyb2KdAR01tXk9aBpC8wMw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgMplzxY/SLj9+bxbGPriiBi7drTq3OXWSJm
 svPwIQ44g2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 JkmCEACY37o5F1LgKmBQ/X+GY7t3DI3LwjJCZxndVTmZbmKfVSOia2DA4d7XI1UV1bLDavheiOD
 ZspAXfK1XmENeXellFyMfyPquNHRcsarUQ1eWVcWnrDOE0opNQOc0QFe+6R8uveX/n9ivxN6Wa1
 hOaIRaYdtaG0pl0/p61larNEe0AnWHy+RtEMHuE39N9gWCpwcPqHoA5mCo1dxrD2K2uh/qlF7ES
 OzWJchorCRsC5GNs9Ui0GFKsf6zpgZU/FyCbyLayRLUF4nfFP2LiO3h9b6WRp0vltQF54wKsTNu
 KqLuPuvIO0elWbihDwdLbI8EutfMxrfBmbbk7MzP7yL8iwl37lrpoXTKwF75rDVE1n9y0I33Z3e
 kbO+/3Rj0fjARWduA04Taqd3iu+/l1YaEl+sm0k+KsXXpau+AtqNR9KyrfyBDpM8DRtqXNx8mvs
 P4VT9g7ZVTJqargqoTFlGh5dcyq+u0cZGRvguOrlRuIGifiAE6HPv46NzI8V4HCRdFKqGQ/5XR3
 guih4Ak2DS4ygw8ba5mwnBdRsQiwDjfWRY9xwAc10W8T4ZikUx8/kDV0HnL2+ZQNa1zKFuQvnaK
 AnAki/aXhT0xQPUk4ZlJRdVZJ1v3xn7aOA4UscmWvvlFVA4Yj7/ScJZKtoGdQI2rcgZYM6BAU97 FairA3wiIkm3Fdw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Alexey Gladkov <legion@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 ipc/mqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5eea4dc0509e..7ef9d325183a 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -366,7 +366,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 			min_t(unsigned int, info->attr.mq_maxmsg, MQ_PRIO_MAX) *
 			sizeof(struct posix_msg_tree_node);
 		mq_bytes = info->attr.mq_maxmsg * info->attr.mq_msgsize;
-		if (mq_bytes + mq_treesize < mq_bytes)
+		if (add_would_overflow(mq_bytes, mq_treesize))
 			goto out_inode;
 		mq_bytes += mq_treesize;
 		info->ucounts = get_ucounts(current_ucounts());
-- 
2.34.1


