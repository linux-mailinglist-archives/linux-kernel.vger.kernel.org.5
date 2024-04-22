Return-Path: <linux-kernel+bounces-153255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1039D8ACB8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29F2B235CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9740014601A;
	Mon, 22 Apr 2024 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LcQ6utAs"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF4145FFB;
	Mon, 22 Apr 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783606; cv=none; b=BZsw+R4ZEKMX5Q7rt3e2a2mu7/E2JPhVhzK9rn3CJ6vIqGRn2YCJyifdgN4i2VoPfKjFJDSYwhMYGu6/nEzn++38NE2i/qB288D0yq74MigEla/0G4WyuDhf+ErGYXzyI1t8y9Msp1rZdXpe8e4ht7SBS9V47dXTZcwLBoDgcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783606; c=relaxed/simple;
	bh=qSRnUi7ni0XP5sEDQ5rBmHE2gFzxaIROYpvpmqt3gyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIpgn2elTgF2f7a0LBGabXWV4yhNoseNeVo4hNxkeo1EAO7i2R7RTgV+FKxKGTXwC7y0pTDfYXhQNWKUUcs4r9sWOuEO0uuN8+5QP1cFocKLLBXnUw1CluFvb1efbQzkmorMmrAAoo+D/daXcNxN6WXjNhjFfiflFbBfDBkjYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LcQ6utAs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SL/GX8Sx5QSON30XF+OmZlSDqER8tIstjW0PNjNiDlU=; b=LcQ6utAsamTtvcGs3ApyGPeQTc
	0WtRHE/wTd0yD/13liKITw/eSoMideKaAztnHOn+fSuHutxWFErmDbqNXo992sXjqBlJe48+f6I7l
	AJ/tex0SxhhXz/7LIDdMfBpUvuIOmE20T64D1CG+vhllOEy0ka+PkW3uCdpQGFEA7YnbVTIClKJQp
	EMiWraTB/mjvfiTAKTs2ELuxRrEzneKUwjMhG6vFBxLHb9WlRYsQb7pNV+VM91qVe/MiTr1k9gF5R
	366sAAcBL5xSZS+Bc/u+XUydJ7iX5XihwEjAEdttycea1m3FXU81JIBsGtCnZF2OGknocKP3aycn+
	8fK/Jjiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryrOv-0000000E3jS-1XVd;
	Mon, 22 Apr 2024 10:59:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 06E2930046F; Mon, 22 Apr 2024 12:59:57 +0200 (CEST)
Date: Mon, 22 Apr 2024 12:59:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <msnitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] completion: move blk_wait_io to
 kernel/sched/completion.c
Message-ID: <20240422105956.GN30852@noisy.programming.kicks-ass.net>
References: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com>
 <20240417175538.GP40213@noisy.programming.kicks-ass.net>
 <546473fd-ca4b-3c64-349d-cc739088b748@redhat.com>
 <ZiCoIHFLAzCva2lU@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiCoIHFLAzCva2lU@infradead.org>

On Wed, Apr 17, 2024 at 09:57:04PM -0700, Christoph Hellwig wrote:
> On Wed, Apr 17, 2024 at 08:00:22PM +0200, Mikulas Patocka wrote:
> > > > +EXPORT_SYMBOL(wait_for_completion_long_io);
> > > 
> > > Urgh, why is it a sane thing to circumvent the hang check timer? 
> > 
> > The block layer already does it - the bios can have arbitrary size, so 
> > waiting for them takes arbitrary time.
> 
> And as mentioned the last few times around, I think we want a task
> state to say that task can sleep long or even forever and not propagate
> this hack even further.

A bit like TASK_NOLOAD (which is used to make TASK_IDLE work), but
different I suppose.

TASK_NOHUNG would be trivial to add ofc. But is it worth it?

Anyway, as per the other email, anything like this needs to come with a
big fat warning. You get to keep the pieces etc..

---
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..83b25327c233 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -112,7 +112,8 @@ struct user_event_mm;
 #define TASK_FREEZABLE			0x00002000
 #define __TASK_FREEZABLE_UNSAFE	       (0x00004000 * IS_ENABLED(CONFIG_LOCKDEP))
 #define TASK_FROZEN			0x00008000
-#define TASK_STATE_MAX			0x00010000
+#define TASK_NOHUNG			0x00010000
+#define TASK_STATE_MAX			0x00020000
 
 #define TASK_ANY			(TASK_STATE_MAX-1)
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b2fc2727d654..126fac835e5e 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -210,7 +210,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 		state = READ_ONCE(t->__state);
 		if ((state & TASK_UNINTERRUPTIBLE) &&
 		    !(state & TASK_WAKEKILL) &&
-		    !(state & TASK_NOLOAD))
+		    !(state & TASK_NOLOAD) &&
+		    !(state & TASK_NOHUNG))
 			check_hung_task(t, timeout);
 	}
  unlock:

