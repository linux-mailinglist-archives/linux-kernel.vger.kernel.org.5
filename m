Return-Path: <linux-kernel+bounces-108115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D78588062F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117B42831A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB57A3BBF0;
	Tue, 19 Mar 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Kq7ykimC"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23C3FB01
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881078; cv=none; b=arHMnLhoinZfRaqFle/vwS9idfk6bctwtZz5feELESVYGF0vwyCCTs/uw1PfX28oma4Ilm+Wrc3rPcw7zL03fWWDcU2h95EGycjkYhqz8Gtc+lLFv7AA9kw1fXGi4hN3o25VgHIV/32Gyw8YJAZchZkSun+yK+LPTKx6k7fP54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881078; c=relaxed/simple;
	bh=oDe0geSLnuuk7SkmacOCsc3JgCu2wt8IttTF3ksVRbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KTpqhvN+ol7CI428uWzkC4sQx/x6UzOrLq/RXUIEunHjHWsP8FAHCy5+lxaEmwOgozvqVPk3v/+FiRJmSll36wPysl5AAd36hCL6g/5jCNk9F+nOsYtRvJsclxfnZeDUFvloqQPfe9tkihjBj54kWaAksHqeUOGlEwsJjpj/hI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Kq7ykimC; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7db36dbd474so2335206241.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710881075; x=1711485875; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CAhSTGhRiyAljzZj3105Ft8eQ+XhumjX9hGBP4lMS0I=;
        b=Kq7ykimCVSVgRZprjjbeAGcbmlICfOrK99qy29rYBetPxdIWMDxLf/rNZ07Vs2dFZ4
         5ua/HKgOtvLuHwMt6KElJ3jqLIK3fD3xwQNBbrfgYh543fhnrxCDL8cqzt3d+5a33Xpd
         xfDiuqACl8ZGyvqzW6GnnWlEUlkf6P+Zf08M6QqQ99z4HZHLaKY3PSxnOo8FY5cB+iy7
         tNt8E/mzBPtmipvnCtNp39E8uejOzKxB9WwVGlhYW/0dAOwviSlpylNPhshdkHPsrHKK
         n3O5lrZ278IH9iqwD9KtLTdKUXG52amhS/F3NQTGyhwc48XKRBdcfTciOQ1lm8zNkZRP
         3rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710881075; x=1711485875;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAhSTGhRiyAljzZj3105Ft8eQ+XhumjX9hGBP4lMS0I=;
        b=UaUApbc0BffPmvxpDscPzaAh/r3eBGrim8IAfZHCOIgFLtw2bTh1CO7PwmqztWt3sW
         nO2kjI1e5FN315qvC/RFXAaQfP7giRSC8TFfK0a0JlyR1uqc5EPbMX0kfA8RbJXDvO9T
         jbeoRZ8y8LxEcNE1Xl8Zcoll9hdpY9bMDQsFz+mTAl4mJ/098wc0xp1CjJtRr8281Qld
         IhtGklOp3dKx+RpbJ4L8/55aiqetWHG1YBGrBagsHWsu52cWMijZDEsM+1upWJzJ6Jy2
         6O1IUIJbVoH+gm15gIfpxpjLymviuT0aNEbgzPRAqNWvV5CJh9Z/fWfYe38nTJD9Upxh
         ccEA==
X-Forwarded-Encrypted: i=1; AJvYcCV4HN8qvDxI7ln+v9fCUcx8P8ofaDeRN9+g6eHTNmHKGjaemJRg0X9N0I41sKE8rr1Piagog3ve1CZfLB5hsC4kFvPpKZuoC3ANJIfg
X-Gm-Message-State: AOJu0Yxjho0GdLJmc18sHs5J0Ac9TcDmtZ/5Owj6C8S7czEAYvDMDQh0
	5/eB2Szp/8+RnnB3cMl0HOqxQL8+akoqlduwtZKtkKwBmdNy+9NbnkX5K6BkKwQ=
X-Google-Smtp-Source: AGHT+IFlFOB52SjxLdszQJJGneeQ+QorWaR6FhjitWP4enqBl+GDAaETy/cEnPLd6J2B8sy5tqEo8g==
X-Received: by 2002:a05:6102:3a48:b0:475:48c5:c4fc with SMTP id c8-20020a0561023a4800b0047548c5c4fcmr12142626vsu.24.1710881074319;
        Tue, 19 Mar 2024 13:44:34 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:1cd2::2df:49])
        by smtp.gmail.com with ESMTPSA id a9-20020a0ce349000000b006916003c53asm6621478qvm.27.2024.03.19.13.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 13:44:33 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:44:30 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5 net 0/3] Report RCU QS for busy network kthreads
Message-ID: <cover.1710877680.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This changeset fixes a common problem for busy networking kthreads.
These threads, e.g. NAPI threads, typically will do:

* polling a batch of packets
* if there are more work, call cond_resched() to allow scheduling
* continue to poll more packets when rx queue is not empty

We observed this being a problem in production, since it can block RCU
tasks from making progress under heavy load. Investigation indicates
that just calling cond_resched() is insufficient for RCU tasks to reach
quiescent states. This also has the side effect of frequently clearing
the TIF_NEED_RESCHED flag on voluntary preempt kernels. As a result,
schedule() will not be called in these circumstances, despite schedule()
in fact provides required quiescent states. This at least affects NAPI
threads, napi_busy_loop, and also cpumap kthread.

By reporting RCU QSes in these kthreads periodically before cond_resched, the
blocked RCU waiters can correctly progress. Instead of just reporting QS for
RCU tasks, these code share the same concern as noted in the commit
d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched and RCU-preempt when safe").
So report a consolidated QS for safety.

It is worth noting that, although this problem is reproducible in
napi_busy_loop, it only shows up when setting the polling interval to as high
as 2ms, which is far larger than recommended 50us-100us in the documentation.
So napi_busy_loop is left untouched.

Lastly, this does not affect RT kernels, which does not enter the scheduler
through cond_resched(). Without the mentioned side effect, schedule() will
be called time by time, and clear the RCU task holdouts.

V4: https://lore.kernel.org/bpf/cover.1710525524.git.yan@cloudflare.com/
V3: https://lore.kernel.org/lkml/20240314145459.7b3aedf1@kernel.org/t/
V2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
V1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t

changes since v4:
 * polished comments and docs for the RCU helper as Paul McKenney suggested

changes since v3:
 * fixed kernel-doc errors

changes since v2:
 * created a helper in rcu header to abstract the behavior
 * fixed cpumap kthread in addition

changes since v1:
 * disable preemption first as Paul McKenney suggested

Yan Zhai (3):
  rcu: add a helper to report consolidated flavor QS
  net: report RCU QS on threaded NAPI repolling
  bpf: report RCU QS in cpumap kthread

 include/linux/rcupdate.h | 31 +++++++++++++++++++++++++++++++
 kernel/bpf/cpumap.c      |  3 +++
 net/core/dev.c           |  3 +++
 3 files changed, 37 insertions(+)

-- 
2.30.2



