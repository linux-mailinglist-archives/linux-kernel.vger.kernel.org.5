Return-Path: <linux-kernel+bounces-96758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F875876111
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E8A1C229BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268DE53801;
	Fri,  8 Mar 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVECx4yQ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173BE537FB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890838; cv=none; b=Ix/woTAeI3hDCBgteNtdagBYDX3DGa7VhZQkSzNOk1mx81HL/FhHE4diG9QOTqxk4BYrXqe0D5VnI5kQ8hUkFYAsh4ltYrMLr/nrPX4M9ocWxpoqKp6YoDdrLWaSQ8cDc0AILkcCTFA2UFwi8Nt4YKXxsJo/h5PdAgNZhGUEVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890838; c=relaxed/simple;
	bh=TfCEx/cMmnXx0f0SqmccleKorZLVMxlT9yGrsWUUDf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZQewFKkymE7e1ISGI4uuIWWBJ7ZTmdHZ9inKcd5bdtiLW/H3mbtjTGGR2bu7DqpBkRDlXaTCGgA0BTC2fVCauz2cmcGzWjTluxul36TVJSeY6ac4aj4q+9Vq+5Q5qk2MTIkq2z5IoYbOz+UV/Td2DSPIGHjAx1KLr0Y1lHRXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVECx4yQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e622b46f45so563336b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709890836; x=1710495636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkA8EskXvnyqySxL+sveNVRb40uEpQ//fvo+W4nBex0=;
        b=DVECx4yQXzEqAWorFenBelyTfvTJzZljzeH5x4RZ7QChE/wWRsCI1rzzu0OqfGBy3W
         Mbv18UIY/QhbmxtgEci/GTOpkwvs5qna9Pg0Jka/xSdKhUcwFJ8jJ2IkuCyfh3zRPYm/
         VwsAKuBdCh5dEtHd3HDJUKqfexgYePkxOBlLwL91iMnu6QY8aYPhh62kJRRo0FVJUg34
         ej6pSwdi4qVDAE0Q3is4AkG0cb7AzsyM5+ppxYLlMxTYnZUn3Sd75WToToMDzfngdrh0
         LAoKp2soV/GURt39VkaG97lNqPOiSAKZuw0abO/ixc3CgdlOj+BO5C1OkqDosE50138F
         b+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890836; x=1710495636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkA8EskXvnyqySxL+sveNVRb40uEpQ//fvo+W4nBex0=;
        b=IMjObbURYytOq+IslBmMGXqmMZ6Vb8CaCHEf2gP+dBoiAztjqsOE9MGIbF4rmlPxQH
         z1GiGcEKTzCUeMA4D6XjzBqfzarkMJCOn1y9EJAYMItqmkfDm5Ps+bvndgx3kZMwNEge
         WzdojHaiv9JU/i55MB4uyxqnt/Lk2KW83p8VNZG+6LqJy7vR1bJD1kU39P9tiPc+xd11
         Efu1iousr9rHnjDGBLHDyd6Zxh0oxyoynteTMWRUUp4B8KurI7fjN8iPR7RI55F6CtpL
         V3saK98gDW7XlBE602KVMBCTLQqxc8s54KVuzKlJt7iRnNJHKX56xmIlJfic4xFQVFnp
         OrcQ==
X-Gm-Message-State: AOJu0YwkZMCphhjxbDjT88tVhbE24vI22LCGyAaeDAhVJtQdRruy6VQM
	Wst1pA5aO6JNgrvvY6PdFGyI4uPDSN2VHd0jBjyOdz6ax+nscHxYeh365AVS
X-Google-Smtp-Source: AGHT+IEqkjZiSb72PsFoGZxfC81G5oaveugRna0h3wD9+TQwhAooRu4zZ/8MhptrNrNsIlZefynzqQ==
X-Received: by 2002:a05:6a20:e107:b0:1a1:5000:225a with SMTP id kr7-20020a056a20e10700b001a15000225amr11634158pzb.9.1709890835949;
        Fri, 08 Mar 2024 01:40:35 -0800 (PST)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id s59-20020a17090a69c100b0029981c0d5c5sm3109403pjj.19.2024.03.08.01.40.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2024 01:40:35 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/4] workqueue: Use INIT_WORK_ONSTACK in workqueue_softirq_dead()
Date: Fri,  8 Mar 2024 17:42:50 +0800
Message-Id: <20240308094253.2104-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240308094253.2104-1-jiangshanlai@gmail.com>
References: <20240308094253.2104-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

dead_work is a stack variable.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a60eb65955e7..3ff91243322d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3687,7 +3687,7 @@ void workqueue_softirq_dead(unsigned int cpu)
 		if (!need_more_worker(pool))
 			continue;
 
-		INIT_WORK(&dead_work.work, drain_dead_softirq_workfn);
+		INIT_WORK_ONSTACK(&dead_work.work, drain_dead_softirq_workfn);
 		dead_work.pool = pool;
 		init_completion(&dead_work.done);
 
-- 
2.19.1.6.gb485710b


