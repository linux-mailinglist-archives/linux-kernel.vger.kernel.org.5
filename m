Return-Path: <linux-kernel+bounces-81543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4586774F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2581F2B6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C771292DE;
	Mon, 26 Feb 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLZHVksw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53E7E570;
	Mon, 26 Feb 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955769; cv=none; b=rbSKhmjIUAge9QtiWVRT2oiKl0gK3DUv6xCR5JW/JJUukDJWG43tKJKr7PZGPQGCk0rV6b+1KfFUKiyg4y6LSwDCMPTepqEU7WslklakS662k1pfuhj3US9AXLTuaGUlw6F/RnSqiO0X+1/2ukT58aLgkR3/MnMV8Mur5+sTZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955769; c=relaxed/simple;
	bh=Z+YufZLQTF3twHN8Tt45XHdmDYZSZIos7wJ19PJBXBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIHh6v/cj3RxcavyYmRw20HVZP1Isr3/EbRMNlvRybS9eUMT7rdcOFTqhpPSTkSlt+Uve85hJLDLZBqWpNFUJnFIQHV4m96yVT989qRa3TpAV1Rm7pI7oB1XZlbgq8wmAqH4bJg2JTJa0T5wh6KmX30FoGIRJSk/7u4kVpndA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLZHVksw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E989EC433F1;
	Mon, 26 Feb 2024 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708955769;
	bh=Z+YufZLQTF3twHN8Tt45XHdmDYZSZIos7wJ19PJBXBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLZHVkswvcvglQyfMOc3PRrvH2+yMEJzPecFowmBPlXbnHCpy8Jp4R10HCX2Gsf1t
	 ppcZl86Gz7YnWCDdJkX2ZM2ONHtxeQMjD+krgIrMfYSAqUdcl6/Pr4fE5h4D/cpcdS
	 gUuRZLjYcg0LYPmWNqe32YCUS97v8/QxFzbWAwswJel9gvfeVG+r31BqJ+INrN7+d8
	 AhrcILGsnTCH3sqZhZAS9xfo8AHl4yTv6EFbYx89nqppq/7b6of5fwD3brVDHNUnfE
	 AF4PxhPWMxykPYuFbmTRIjYIv85KeN/thbklOKvLjkP4fOzbsQBC5LfQWKk+Qg0vr/
	 jey/s8zz7Dg+g==
Date: Mon, 26 Feb 2024 14:56:06 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v2 0/6] RCU tasks fixes for v6.9
Message-ID: <ZdyYdhZtNuJp3h-a@localhost.localdomain>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <Zdd7x4Rmy_-WDqfl@localhost.localdomain>
 <cf84fb44-9620-40bc-a68d-051edf6823b8@paulmck-laptop>
 <ZdiOot2RJm1VuzSJ@lothringen>
 <8f992601-153e-4cc1-8e7e-6684823cd590@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f992601-153e-4cc1-8e7e-6684823cd590@paulmck-laptop>

Le Fri, Feb 23, 2024 at 04:43:04PM -0800, Paul E. McKenney a écrit :
> I do indeed mean doing cond_resched() mid-stream.
> 
> One way to make this happen would be to do something like this:
> 
> struct task_struct_anchor {
> 	struct list_head tsa_list;
> 	struct list_head tsa_adjust_list;
> 	atomic_t tsa_ref;  // Or use an appropriate API.
> 	bool tsa_is_anchor;
> }
> 
> Each task structure would contain one of these, though there are a
> number of ways to conserve space if needed.
> 
> These anchors would be placed perhaps every 1,000 tasks or so.  When a
> traversal encountered one, it could atomic_inc_not_zero() the reference
> count, and if that succeeded, exit the RCU read-side critical section and
> do a cond_resched().  It could then enter a new RCU read-side critical
> section, drop the reference, and continue.
> 
> A traveral might container_of() its way from ->tsa_list to the
> task_struct_anchor structure, then if ->tsa_is_anchor is false,
> container_of() its way to the enclosing task structure.
> 
> How to maintain proper spacing of the anchors?
> 
> One way is to make the traversals do the checking.  If the space between a
> pair of anchors was to large or too small, it could add the first of the
> pair to a list to be adjusted.  This list could periodically be processed,
> perhaps with more urgency if a huge gap had opened up.
> 
> Freeing an anchor requires decrementing the reference count, waiting for
> it to go to zero, removing the anchor, waiting for a grace period (perhaps
> asynchronously), and only then freeing the anchor.
> 
> Anchors cannot be moved, only added or removed.
> 
> So it is possible.  But is it reasonable?  ;-)

Wow! And this will need to be done both for process leaders (p->tasks)
and for threads (p->thread_node) :-)

