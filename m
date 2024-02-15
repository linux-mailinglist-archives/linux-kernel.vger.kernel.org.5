Return-Path: <linux-kernel+bounces-67400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 456F8856AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1011C21F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EBC136999;
	Thu, 15 Feb 2024 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KBtxMHqC"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4CE136661
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017951; cv=none; b=lkbp0zHLGyQC1yvdVIhnupcBMLoze++YSuq/WWTDEymxPxMZ0cbU7IeZATKmmapuPsRBZjvBQ0gVJrOAhBYYvlzUi9SOQsQy827jz5am6fVqCc/vHacE8gJurfNqFWRz/4RPrQ3deHKDu7rvf04yH3Kqwqp7EQg5EuMEd5gP4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017951; c=relaxed/simple;
	bh=v5JNUzQrlc/Ze3O2xGRTThncYAxGfewIlMkjSF3Zios=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQb+xkDYc9WLLy3rIcrHfXADmhxCAqYcf8Q9A3SwGvz1Pbo7yGdBj7nDOoHc6sIt38GziGVhXr8IpEl6AtlTSiKnpgzN+Jg5oF24tYM7iYdpH0HImU6NS5lyKPxmlGT0eRyg+3rLM7qgO0WAEfhvj5BzfAjwjmV8Xuqs3/qiTxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KBtxMHqC; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so15644461fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708017946; x=1708622746; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cuuhvY1knev/MlE0VuD+OUGRlkZI73nAFQGnaq1zL0U=;
        b=KBtxMHqCVMh5xPPcV57Mh1w2jL5TdymJRJhKtgk+r9qRE2j2Ew/E5a6q5yl/+JI1Lm
         c442uJREe0uBvvW6fTWe/XhPPNkHn8lnC8WQvTp9ypWAH83+2NiXN4Vyd41OC978M5fu
         cr+W5XV4wtlj0K4jrUaIlQTqYdbSI3rrVJh+NbCZUN6z1gmjIe0FsO/ANwjJrU4riEMf
         12YuKUkkv88qI5iHrrQKQVbLCOjrYwaqD1Nlbw5mvAZJZM2iQawpR9CnhQGPEQ1GRMwI
         NTjj24IChQLnX91BEQ4elM2ztFQRi5k9OrfCRDY2IOKDndUq56vgduCHoAKtsYZqCcBl
         +mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017946; x=1708622746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuuhvY1knev/MlE0VuD+OUGRlkZI73nAFQGnaq1zL0U=;
        b=e7MbzvrAEvSuIp8A+b2wIc8s7w6uNPo/NS+3yLDX8j1NEz1P07RZza4kXzsq5P5f11
         QoMt2u3ggdxF+E+kAsfvN/OepWYPywHO6QT/jfRkIZk1oPJfAP45bzDwP9DRjovuZfds
         YsmTTbIT6v2Imf352vtuAYFuBJr6a/iy4sa16cIL97lArCKJya2/rgYRZ0kDbq83CVNl
         ryilGWOhAABH2Q3sDEGeuk5rlVR++qDxqJCeEM/ycH8CKWce7xqnbtgGQqADmM0JdZpR
         0Wp4OMDNBmkrH6OrOUIdjWZP0X45QjIZ2NHkQfd67IL39KUD22P/eERAkkd/FuNnKR+7
         ZUjg==
X-Forwarded-Encrypted: i=1; AJvYcCXpyDZjDq4xYWNQLath4uS4ve9lOFXNXlHnyYPt3VI3z34CxqfxykzXFnNJYse7ymAl/dsvab62JDhibMc21QVfR0aJsp2o7A6bSuBk
X-Gm-Message-State: AOJu0Yz/5W18wZysCJBQIlDYkT604Pl4P+elvwwowIQKKKZ4hpvcNXrW
	9zcGeO5bIiaq9N/uTgIdK0yuSGb6DpmOY16WcG+BMU/L+a3+Tb6w93kCsuUyckKpBhYMaPvmTnE
	2
X-Google-Smtp-Source: AGHT+IHzhRx80m5IBOtXuSj/+pQiwLJQtSioIzJZd/nWxl+IXjeO2sK+5VQ6E+UDzeoRGOcklOLO0A==
X-Received: by 2002:a2e:bb85:0:b0:2d1:1e3c:5739 with SMTP id y5-20020a2ebb85000000b002d11e3c5739mr1696957lje.31.1708017945695;
        Thu, 15 Feb 2024 09:25:45 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c231200b00411a0477755sm5667334wmo.9.2024.02.15.09.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:25:44 -0800 (PST)
Date: Thu, 15 Feb 2024 18:25:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llu@fiberby.dk
Subject: Re: [PATCH net-next 2/3] net: sched: cls_api: add filter counter
Message-ID: <Zc5JFhLI_KZtdy5P@nanopsycho>
References: <20240215160458.1727237-1-ast@fiberby.net>
 <20240215160458.1727237-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215160458.1727237-3-ast@fiberby.net>

Thu, Feb 15, 2024 at 05:04:43PM CET, ast@fiberby.net wrote:
>Maintain a count of filters per block.
>
>Counter updates are protected by cb_lock, which is
>also used to protect the offload counters.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>---
> include/net/sch_generic.h |  2 ++
> net/sched/cls_api.c       | 20 ++++++++++++++++++++
> 2 files changed, 22 insertions(+)
>
>diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>index 46a63d1818a0..7af0621db226 100644
>--- a/include/net/sch_generic.h
>+++ b/include/net/sch_generic.h
>@@ -427,6 +427,7 @@ struct tcf_proto {
> 	 */
> 	spinlock_t		lock;
> 	bool			deleting;
>+	bool			counted;
> 	refcount_t		refcnt;
> 	struct rcu_head		rcu;
> 	struct hlist_node	destroy_ht_node;
>@@ -476,6 +477,7 @@ struct tcf_block {
> 	struct flow_block flow_block;
> 	struct list_head owner_list;
> 	bool keep_dst;
>+	atomic_t filtercnt; /* Number of filters */
> 	atomic_t skipswcnt; /* Number of skip_sw filters */
> 	atomic_t offloadcnt; /* Number of oddloaded filters */
> 	unsigned int nooffloaddevcnt; /* Number of devs unable to do offload */
>diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>index 397c3d29659c..c750cb662142 100644
>--- a/net/sched/cls_api.c
>+++ b/net/sched/cls_api.c
>@@ -411,11 +411,13 @@ static void tcf_proto_get(struct tcf_proto *tp)
> }
> 
> static void tcf_chain_put(struct tcf_chain *chain);
>+static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add);
> 
> static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
> 			      bool sig_destroy, struct netlink_ext_ack *extack)
> {
> 	tp->ops->destroy(tp, rtnl_held, extack);
>+	tcf_block_filter_cnt_update(tp->chain->block, &tp->counted, false);
> 	if (sig_destroy)
> 		tcf_proto_signal_destroyed(tp->chain, tp);
> 	tcf_chain_put(tp->chain);
>@@ -2364,6 +2366,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
> 	err = tp->ops->change(net, skb, tp, cl, t->tcm_handle, tca, &fh,
> 			      flags, extack);
> 	if (err == 0) {
>+		tcf_block_filter_cnt_update(block, &tp->counted, true);
> 		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
> 			       RTM_NEWTFILTER, false, rtnl_held, extack);
> 		tfilter_put(tp, fh);
>@@ -3478,6 +3481,23 @@ int tcf_exts_dump_stats(struct sk_buff *skb, struct tcf_exts *exts)
> }
> EXPORT_SYMBOL(tcf_exts_dump_stats);
> 
>+static void tcf_block_filter_cnt_update(struct tcf_block *block, bool *counted, bool add)

Can't you move this up to avoid forward declaration?


>+{
>+	lockdep_assert_not_held(&block->cb_lock);
>+
>+	down_write(&block->cb_lock);
>+	if (*counted != add) {
>+		if (add) {
>+			atomic_inc(&block->filtercnt);
>+			*counted = true;
>+		} else {
>+			atomic_dec(&block->filtercnt);
>+			*counted = false;
>+		}
>+	}
>+	up_write(&block->cb_lock);
>+}
>+
> static void tcf_block_offload_inc(struct tcf_block *block, u32 *flags)
> {
> 	if (*flags & TCA_CLS_FLAGS_IN_HW)
>-- 
>2.43.0
>

