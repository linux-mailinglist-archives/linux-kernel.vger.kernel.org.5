Return-Path: <linux-kernel+bounces-108299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B648808E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2583E1F2429F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BD61388;
	Wed, 20 Mar 2024 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dQ8BenM7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD310EB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896971; cv=none; b=ImBS1d46WACIbA4WV5jq/U87oT/ke+OWiG+mzoCHIcHuKz5ltLrupHVOO5UFugB1pzP+4lysTwHRrzjCO6gHG2o3wHx78pMREuw3EmZCAnDtfhRyKZ08Um4G/7qnJvYd2k6WATz70ij5Z1P1I4wV4c2Nzt3AArE3cq7kamIyfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896971; c=relaxed/simple;
	bh=Kc4NGffc6CU0fHR5WvTbN6Ob3VHS4tp46Oi3ApQ+yBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=no2S15INrL+d+EDT9VCOMwFG3oJo2dJPFCitwMRnKBI4z3V2KRjKviOF1RBr1rATyyt8BW1y8gMT7XEkOWBxHHkOBtu97XR1qv+JqC4k1pF0KpiFNYk+td9w5w+wEX/IMg8sGMvafZnaR+pKEKf1VPNzHfDZ28cSidsAhVZJOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=dQ8BenM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B4FC433F1;
	Wed, 20 Mar 2024 01:09:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dQ8BenM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710896966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0vslccHoMCWly3ZURU46sxdUj43F/UH9ebalL/ZrLyE=;
	b=dQ8BenM7n4QQUbeM1wjdCGNzGSH6TFaQ3XM37L904ZiYEBphDBP1IVzdpgk21HkXPo7MDs
	SUCPBwU6iv45YWyk/jJjXtJtDoRGpwil4kua5uo50FKur821+KYRKpavodlQJdqL6qtH8l
	EC6XNoHZW1Iqz4IrdGKAmEXrWYABtKA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c3249e04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Mar 2024 01:09:24 +0000 (UTC)
Date: Wed, 20 Mar 2024 02:09:21 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Guoyong Wang <guoyong.wang@mediatek.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] random: Fix the issue of '_might_sleep' function running
 in an atomic contex
Message-ID: <Zfo3QUFEy4wHkLEB@zx2c4.com>
References: <Zfidal8CEZStp3R7@zx2c4.com>
 <20240319093055.3252-1-guoyong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319093055.3252-1-guoyong.wang@mediatek.com>

On Tue, Mar 19, 2024 at 05:30:55PM +0800, Guoyong Wang wrote:
> On Mon, 18 Mar 2024 21:00:42 +0100, Jason A. Donenfeld wrote:
> > I'm wondering, though, rather than introducing a second function, maybe
> > execute_in_process_context() should just gain a `&& !in_atomic()`.
> > That'd make things a bit simpler.  
> 
> > However, I'm pretty sure in_atomic() isn't actually a reliable way of
> > determining that, depending on config. So maybe this should just call
> > the worker always (if system_wq isn't null).
> 
> > Alternatively, any chance the call to add_input_randomness() could be
> > moved outside the spinlock, or does this not look possible?
> 
> Hi Jason,
> 
> Thanks for your suggestions. 
> 
> I am inclined to accept your second suggestion. My reluctance to accept 
> the first is due to the concern that "&& !in_atomic()" could potentially 
> alter the original meaning of the 'execute_in_process_context' interface. 
> Regarding the third suggestion, modifying the logic associated with 'input' 
> is not recommended.

Doesn't something like the below seem simplest? Just move the call out
of the spinlock and we're done.

diff --git a/drivers/input/input-core-private.h b/drivers/input/input-core-private.h
index 116834cf8868..717f239e28d0 100644
--- a/drivers/input/input-core-private.h
+++ b/drivers/input/input-core-private.h
@@ -10,7 +10,7 @@
 struct input_dev;

 void input_mt_release_slots(struct input_dev *dev);
-void input_handle_event(struct input_dev *dev,
+bool input_handle_event(struct input_dev *dev,
 			unsigned int type, unsigned int code, int value);

 #endif /* _INPUT_CORE_PRIVATE_H */
diff --git a/drivers/input/input.c b/drivers/input/input.c
index f71ea4fb173f..2faf46218c66 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -391,20 +391,22 @@ static void input_event_dispose(struct input_dev *dev, int disposition,
 	}
 }

-void input_handle_event(struct input_dev *dev,
+bool input_handle_event(struct input_dev *dev,
 			unsigned int type, unsigned int code, int value)
 {
 	int disposition;
+	bool should_contribute_to_rng = false;

 	lockdep_assert_held(&dev->event_lock);

 	disposition = input_get_disposition(dev, type, code, &value);
 	if (disposition != INPUT_IGNORE_EVENT) {
 		if (type != EV_SYN)
-			add_input_randomness(type, code, value);
+			should_contribute_to_rng = true;

 		input_event_dispose(dev, disposition, type, code, value);
 	}
+	return should_contribute_to_rng;
 }

 /**
@@ -428,12 +430,15 @@ void input_event(struct input_dev *dev,
 		 unsigned int type, unsigned int code, int value)
 {
 	unsigned long flags;
+	bool should_contribute_to_rng;

 	if (is_event_supported(type, dev->evbit, EV_MAX)) {

 		spin_lock_irqsave(&dev->event_lock, flags);
-		input_handle_event(dev, type, code, value);
+		should_contribute_to_rng = input_handle_event(dev, type, code, value);
 		spin_unlock_irqrestore(&dev->event_lock, flags);
+		if (should_contribute_to_rng)
+			add_input_randomness(type, code, value);
 	}
 }
 EXPORT_SYMBOL(input_event);


