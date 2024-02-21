Return-Path: <linux-kernel+bounces-75623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58D985EC17
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02098285E50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6B69DE5;
	Wed, 21 Feb 2024 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir6RjjpD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64D10953
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556256; cv=none; b=n93YwLvGyZFTyJmg2xmSopS3mbLRGDHayTll6ReUtm8mdD8FNRlC/st9I85UFUxJBnBMXkwjtFnzyLRsVgKm6wePMTjCTkwTMPcYWneGwMxkw0BDV8kPMZ1k913GHCaKd/nHZoYvG0neufZyZMxrrKrEnF7U7altYla9DuRNECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556256; c=relaxed/simple;
	bh=X1FkUIvCLYMNMFXbH86xBrQrJDNMfIXGTIyj0dRSxcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhpoVVHS5tzLkmgEOm0+0V/htC06TzEVAdwCChxVHZ5HB3EAdgLxj+MRDMRvyCSoPk+ICPjYfhmRbyse9I+5ka5265f36MkaIAXfl3iC+BHHCpUmYxgNe7NCMSEBdFNWtoTSGg5jWDF21aufZPpzpi2fupUyBPVsP2a3LbNq+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir6RjjpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E94C433C7;
	Wed, 21 Feb 2024 22:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708556255;
	bh=X1FkUIvCLYMNMFXbH86xBrQrJDNMfIXGTIyj0dRSxcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ir6RjjpDqUuV4/VQ7Ow8wy2J0F7m/y3DxAfWz97qgMGKYr7CcroNshA0DjLJLBGbb
	 I+Uwi4RewSWhWR6ml7cbqRaNG0yXcdkBEAeiCm77qlIDptBV39wbzDXkJfu26Qwyvh
	 FqYDuE/HwXWzY5E8xp4OehjPRknBByNen6cohhE9CAPXKGwg7/XLi9938v+I52Jb+L
	 79dq1+6Oo2ibdk7bTPb119K5VMqsABKcoNefH2ojE9PXFO4+DGV3fLecaliqQ34KtD
	 OZ+FrgdOwPCKLMeOV8hJPl4RXmd8flxn2uUDpIiAM6A7CKp5AhjkE2CwU10TBPz5ZX
	 BPxVVqvV39lWQ==
Date: Wed, 21 Feb 2024 23:57:32 +0100
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
	Christian Loehle <christian.loehle@arm.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v11 20/20] timers: Always queue timers on the local CPU
Message-ID: <ZdZ_3CLIGCOXdUNx@pavilion.home>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
 <20240221090548.36600-21-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221090548.36600-21-anna-maria@linutronix.de>

Le Wed, Feb 21, 2024 at 10:05:48AM +0100, Anna-Maria Behnsen a écrit :
> The timer pull model is in place so we can remove the heuristics which try
> to guess the best target CPU at enqueue/modification time.
> 
> All non pinned timers are queued on the local CPU in the separate storage
> and eventually pulled at expiry time to a remote CPU.
> 
> Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

