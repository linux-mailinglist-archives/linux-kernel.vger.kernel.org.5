Return-Path: <linux-kernel+bounces-101726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3669487AB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16401F22A18
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7983487A9;
	Wed, 13 Mar 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b02lJKGC"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC9482C6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347152; cv=none; b=Uc5zddytq5evoFmNW76P3iEr3RIg6DpxPgL2nsoMHHA2h4A7Zz3lK+v1fVL+6vxG7YFROrIGeFzduXSvW3htGFWFv79E0nldN5FlrxgirTruBJ7fs1ZrKm/pVVWfThlhfuxGCQziye0JttnBgKJALkE29Dc7Tx0CmUsQlIwo4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347152; c=relaxed/simple;
	bh=yb4jRK9TMInttE6q+PR3jZu8SJZDS3zxRBM0iXRZdaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lkvq84UCBrfPvlfYg92UNANlCw82rw4BJVOOb0mBr/xF0VaxsCVvDMnr59L1kZcAOpvkdd0f6isFYSvr4uwv6oMj6vpJqVFMpX2jz0IY7LbInA6ODf0ZnovwC9LUaQ614JIll1tcq3qS60E8pxLzRT9HD22BkJWmGJoWK24EMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b02lJKGC; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69107859bedso470346d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710347149; x=1710951949; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DadrGgosL3YryhdTAvt8AZb2nS0kYApS+oQ0568RY2w=;
        b=b02lJKGCL9bKyu9gXYrKcPdORweFkR4RW2SgxJhzAMUzbipKJuwyqvkW4kXHLuTtnC
         PLPYRzl4uGjKwOLbajBA6r8UqRMP4gmMLqfqQBGYT68RfT4PGLj8Z2rqyKFemrermI5H
         2XvaS3n6dXacjAMO1FmNIcTvM8v+dPpl8EbYveHh+0d/UilYE1PYaRBzDdSIBvYgb4W+
         iPM0XL9OmQOBwueO/p6LmF4kKht7v36B3qE8Y8XwPv2L/7efZuL8ofECxM2kY1uuefDP
         VQxJloBUsvjkkLABC5wFmchllkmucv7G0/23SdRWEV4KsGwFDCKHdqvcJd/szBeYVruB
         2pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710347149; x=1710951949;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DadrGgosL3YryhdTAvt8AZb2nS0kYApS+oQ0568RY2w=;
        b=wJRUMJcBk2fwq0QkvS/fIn8VLDzcJ+hZ3Mglaxzp1Pt7EtM68fK+MVZLLyb8Ub+QOM
         GB1JZC1F7ukNPCDtnn7CSaReEZaP4h/Ji7Iccr8h6VTXOZ2TLOtQIJ1FAnlxnhm1m/AE
         mM+5os7sflAk0pLMN45sWGL0avyr0gcDppYoV38pSH0ni5SEZ6dpRmjHcmiwKpLjTEFC
         JN8puP3iN808+dARGSPt6RYubkXRa8mo6pZLUU0f2bDU878inlRP3aSPm4KfFidXkDWt
         hCRRkBjnkTg2JbPQhgd0gROFS9os3IW5ZkYzJUDMdNqI88lt/Shdnu2YltV9Ry86dlUI
         GdgA==
X-Forwarded-Encrypted: i=1; AJvYcCUPIf3U+IKfTnIE1hg/sjWrWhr4+hxNDdfPrq5Q89Mo2p6/5RaSDJdhb8sA3OQepzJNzR/gd8x5KdAZBhamUsXaoBoFa85Q6zGFG+Pg
X-Gm-Message-State: AOJu0Yy9ighAajfBuNvi3QgoiG7IPIYwgKGpkuQLddNz0GjwLm79zOqy
	UbBpFp6iyAxtCpYgqrKkgSHfEaNuU/AA3oDcBC6juJnYmLDP9KW3IV2YH0Qfme0=
X-Google-Smtp-Source: AGHT+IEyo5tKDcSWoxixlYGVqG9bZ4LNG2VjJrGAN13tcTVJ4L3ooYeXW/5GADQ+vNBaR4uTwySDrw==
X-Received: by 2002:a05:6214:9c7:b0:690:def9:18d9 with SMTP id dp7-20020a05621409c700b00690def918d9mr339944qvb.27.1710347149560;
        Wed, 13 Mar 2024 09:25:49 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f91::18d:37])
        by smtp.gmail.com with ESMTPSA id s6-20020ad44386000000b00690c5cc0ff6sm4238154qvr.124.2024.03.13.09.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 09:25:49 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:25:46 -0700
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
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [PATCH v3 net 0/3] Report RCU QS for busy network kthreads
Message-ID: <cover.1710346410.git.yan@cloudflare.com>
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
* if there are more work, call cond_resched to allow scheduling
* continue to poll more packets when rx queue is not empty

We observed this being a problem in production, since it can block RCU
tasks from making progress under heavy load. Investigation indicates
that just calling cond_resched is insufficient for RCU tasks to reach
quiescent states. This at least affects NAPI threads, napi_busy_loop, and
also cpumap kthread for now.

By reporting RCU QSes in these kthreads periodically before
cond_resched, the blocked RCU waiters can correctly progress. Instead of
just reporting QS for RCU tasks, these code share the same concern as
noted in the commit d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched
and RCU-preempt when safe"). So report a consolidated QS for safety.

It is worth noting that, although this problem is reproducible in
napi_busy_loop, it only shows up when setting the polling interval to as
high as 2ms, which is far larger than recommended 50us-100us in the
documentation. So napi_busy_loop is left untouched.

V2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
V1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t

changes since v2:
 * created a helper in rcu header to abstract the behavior
 * fixed cpumap kthread in addition

changes since v1:
 * disable preemption first as Paul McKenney suggested

Yan Zhai (3):
  rcu: add a helper to report consolidated flavor QS
  net: report RCU QS on threaded NAPI repolling
  bpf: report RCU QS in cpumap kthread

 include/linux/rcupdate.h | 23 +++++++++++++++++++++++
 kernel/bpf/cpumap.c      |  2 ++
 net/core/dev.c           |  3 +++
 3 files changed, 28 insertions(+)

-- 
2.30.2



