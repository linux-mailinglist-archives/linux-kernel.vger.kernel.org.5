Return-Path: <linux-kernel+bounces-120627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5488DA75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D161E1F28E06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134014597D;
	Wed, 27 Mar 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cBzl93XH"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B84503B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532707; cv=none; b=TkYtmn6MI+2hqUs+3t25oFiepnqXkRhgNYnr0An8hA6Ar3xq5NhKj03VdTFwNhl7k4kJGtlGiJ4yxUTjehhd9afi60GWzzYR9kjDEW73H0IYdBkH6jqrS+RbRcnWnYz6ww0FKOvNH1AhKl4GkTg9WXbAr4Au6nhyoY29ipA8T1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532707; c=relaxed/simple;
	bh=W5jnX+bgKVpgCXJLnqW/MWwdx7iLA8EDehVPIN+x1PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qayE/5VS/d+JdlQ7+t0gUfDYBkzO33nvDUL/X93BEEx4UkDrbr1gMXa0/Nc8bWlKjUawO6skYsROWkwkGHp104oxD0uLbBAzFFXJlQFgL/sxfIITxWHUXZc2cryWZq9bjtjU0lPuTZncz4UgsYUSeWyvBYnmqMbtVd1i5YOx5HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cBzl93XH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6eac64f2205so663051b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711532705; x=1712137505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2bZO0fGsdGUR3z5kE6H/Hbx7vevj24u/qPVhihb39I=;
        b=cBzl93XH/QxELGmXA8vmdQKygZ12iA1wdLgmfP6vQmBaBXbYD6w/ywJM+by5P9BPSx
         4krkHI57EJcer3z8qDRLCenxrDzr4WgSPz8LeH7oD3ZZDzvvvrZNvIznHRYeuXP1r6lD
         vayUQ8hslgTBgp63AbqPBAZfj9sVDyN55x6GNc/MiYuM6yBrt8OaU8cw8rQJULBbwcqA
         Ni4lGHCqosaUkqpsxE9lOdrX5Ejm5FHK5xupjsFaLdHIDorCtmEglmELoBaiy5Ctfzlj
         3enIuV5SUsGvS2Kg0bqDVKZ1kefLozeEoHQAUzB2fClD8UL/ZBqFiAgqWWwL986NPjk3
         xkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711532705; x=1712137505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2bZO0fGsdGUR3z5kE6H/Hbx7vevj24u/qPVhihb39I=;
        b=qIlurNqJQM7bKq/dSC6ewJ5jS+D22oTbKvoJEMO56kb+byUJhfJtDi0KKA8wXY9qxQ
         Vlu/bk6yj8PRizOC4O3ok1T0cbVgV25i2y9OEx+4VgrtpwWjWEc0ldCTNMI21ktnuyy/
         vgwZufXTkzAg3rWC0QFcY6wt15y12bave4Z/syuvhofwdemfm2VVrNAT0tijnaPIqO9o
         GfBIWwOnwOCxxbRTdGbRtoA0TB6tGMQnIKFPn/3l1jIfp0PFlaTL/ua9FbAVMpFxwRxJ
         dIBZFqH/kxxZjdOFv0dFfpiGLDiqo86ToD5gizg0/nl5hTQf+8SrE8TOxVB4KvgMgTQA
         kCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5jmxHf+/WNSHDgMgXeDUkyt+oMdpcINwq2xgIkO/994OJQ62UdC0JY4bACvnjB26aONyNbXwwPA7uDz/mQa6CLJS1PLwupi+X5ulq
X-Gm-Message-State: AOJu0Ywyrsyq1eUgRLNAmlfkzOikALq7FHlh6YsJKjAVyowMHgua5xzr
	p47h3Mjevmv1rGfczJDveP2xJ/mbKCKGN4b8bsgLpLkRIyNx5728nhx4Du7WAN8=
X-Google-Smtp-Source: AGHT+IHgVLKDAxGZr69s/xspP4noB5Fo07zqXj9hvlT9c36fM5bvGpHkLdulbs7nzpU1fsapH5tmXw==
X-Received: by 2002:a05:6a20:d492:b0:1a0:f096:502d with SMTP id im18-20020a056a20d49200b001a0f096502dmr771519pzb.22.1711532705336;
        Wed, 27 Mar 2024 02:45:05 -0700 (PDT)
Received: from C02CV19DML87.bytedance.net ([2001:c10:ff04:0:1000:0:1:7])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902e30300b001e002673fddsm8500474plc.194.2024.03.27.02.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 02:45:04 -0700 (PDT)
From: Rui Qi <qirui.001@bytedance.com>
To: bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	peterz@infradead.org,
	mbenes@suse.cz,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alexandre.chartre@oracle.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	sashal@kernel.org,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH V3 RESEND 1/3] objtool: is_fentry_call() crashes if call has no destination
Date: Wed, 27 Mar 2024 17:44:45 +0800
Message-Id: <20240327094447.47375-2-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240327094447.47375-1-qirui.001@bytedance.com>
References: <20240327094447.47375-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandre Chartre <alexandre.chartre@oracle.com>

commit 87cf61fe848ca8ddf091548671e168f52e8a718e upstream.

Fix is_fentry_call() so that it works if a call has no destination
set (call_dest). This needs to be done in order to support intra-
function calls.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200414103618.12657-2-alexandre.chartre@oracle.com
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index dfd67243faac..71a24fd46dbd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1367,7 +1367,7 @@ static int decode_sections(struct objtool_file *file)
 
 static bool is_fentry_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL &&
+	if (insn->type == INSN_CALL && insn->call_dest &&
 	    insn->call_dest->type == STT_NOTYPE &&
 	    !strcmp(insn->call_dest->name, "__fentry__"))
 		return true;
-- 
2.20.1


