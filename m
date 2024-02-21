Return-Path: <linux-kernel+bounces-75613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6398085EBF6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0304AB23FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409571292C8;
	Wed, 21 Feb 2024 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtT8f8Z4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5483BB37
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555622; cv=none; b=FN580v/WIl1OMm+aVtW5hDU1YlRDQofgKJoOfKwmIzlKPb4cmnqFhp01t3IDIUCD9U8AKKyleMUpIupl5xMF5nGpod/X6XyEnMTWbxZxHSiDjlMJ3QpkfBbzkw4M4FktotVTT+iPGcNd8UYtbOciOp2WUm+/mKXTr2488wx8Lsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555622; c=relaxed/simple;
	bh=WSYlQwNY6BvckhB15s16dm7Ejui3Cc/sQPxYkkFqS7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX8hpNjvUQtb7qT5dzbNbmtEVVcVS9Ye2XxvIQqlXhqKl8lV0G65iGk83tQTocbqm1GPlVS0xYW0Lcj9NxERa3pME2b7FouU8QYfSvDDnIA8yY6nptMVNicb8hmj1UWgH6BQSuNyy3i5t2BeSoqHGKnPAibsZ5bnkafflVgEuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtT8f8Z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8603DC433C7;
	Wed, 21 Feb 2024 22:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708555619;
	bh=WSYlQwNY6BvckhB15s16dm7Ejui3Cc/sQPxYkkFqS7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtT8f8Z410Mijd+4YBwf1E8c6sSpWug79PbVObQ9LAnPnYTT2pWwbUDImDaFl2cx4
	 bgSZf7p60uVG7NED2G6ZT38HCM6tCSAvchQDEydFWggQGIXU5L9EaWSwdoZ9y3cN0f
	 mXwfBdO8YOPPsZPQV9Pu0F248MOyDRSw7Y9rvXntZrSBeqHWDhFPYVV0KqTGXAqHRI
	 LPVJBGXsrlHjLuDvy91anXlkizMqiTGkRkY6EAZyCbbMIbZXA5qKnezbpLlqe7VyK0
	 REHVwoBk+CY+DwuI/KV2aG4jSdRL+pUjnCdaC4g2QKEDQGaPT7tNHDaPlE68OiEA9D
	 Zkn/DjIjukgfA==
Date: Wed, 21 Feb 2024 23:46:56 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v11 19/20] timer_migration: Add tracepoints
Message-ID: <ZdZ9YI3vUaHPOni4@pavilion.home>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
 <20240221090548.36600-20-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221090548.36600-20-anna-maria@linutronix.de>

Le Wed, Feb 21, 2024 at 10:05:47AM +0100, Anna-Maria Behnsen a écrit :
> The timer pull logic needs proper debugging aids. Add tracepoints so the
> hierarchical idle machinery can be diagnosed.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

