Return-Path: <linux-kernel+bounces-67539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6EE856D28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14171C22759
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172001386C5;
	Thu, 15 Feb 2024 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L9/BOqb6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D79131E59
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023311; cv=none; b=YkMpItBoClWZ8/BE7FRZIFSQoyb2/InUu5RwBgohTtXvHcPkOczeAAX6AV7OLEMLHkpOuURtjeBIy6ezvZ94daCPliASC94/da0B4itBoNi70OE4QCJxrtvO4fO2toyTuy/V5h7DelWP/uLvP2QVVyQrotmUZV6X2XbhygY9mvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023311; c=relaxed/simple;
	bh=G1ZYeGSfL5ZXhmvPIxc4v8DItjIbZ3gG8J9on29g6B4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QOsxB3kL+lCSbPHTfNnySJEPock+OzD2q+VpktnRIQTHouH1U2rHMz1Ek/0lF+ht3dc4OzHJGwonLrNrs/INRfJR2a1U4/BuhVepgezyX4paFDK1RZgWJz0EBLflmq1Q9Nyi869NiebBBFa6jsUl3GqjClx2antKLUIkA8ZNAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L9/BOqb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796C0C433F1;
	Thu, 15 Feb 2024 18:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708023310;
	bh=G1ZYeGSfL5ZXhmvPIxc4v8DItjIbZ3gG8J9on29g6B4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L9/BOqb6J7+0oZgcnmt3rIuZy6OJXPX6WK+b/Wlup84VCm4Ctjuu/fqlDY56oFykT
	 5hZNfCo3Wei+rd1W1ZH2Kj9Pes8h0sI4aJ82u39xdTPkUABtMmegYXpASSt4KOsvBm
	 SrlgMR0H75KUn6L6f0sq4LIepwJdCHBlBatj78u4=
Date: Thu, 15 Feb 2024 10:55:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-kernel@vger.kernel.org, fuyuanli <fuyuanli@didiglobal.com>
Subject: Re: [PATCH] kernel/hung_task.c: export
 sysctl_hung_task_timeout_secs
Message-Id: <20240215105509.b7b3c87c24ed35cdfb111f34@linux-foundation.org>
In-Reply-To: <Zc2giqMeZhxuDSU9@infradead.org>
References: <20240209070935.1529844-1-kent.overstreet@linux.dev>
	<Zc2giqMeZhxuDSU9@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 14 Feb 2024 21:26:34 -0800 Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Feb 09, 2024 at 02:09:35AM -0500, Kent Overstreet wrote:
> > needed for thread_with_file; also rare but not unheard of to need this
> > in module code, when blocking on user input.
> > 
> > one workaround used by some code is wait_event_interruptible() - but
> > that can be buggy if the outer context isn't expecting unwinding.
> 
> I don't think just exporting the variable ad thus allowing write
> access is a good idea.  If we want to keep going down the route of
> this hack we should add an accessor function that returns the value.
> 
> The cleaner solution would be a new task state that explicitly
> marks code than can sleep forever without triggerring the hang
> check.  Although this might be a bit invaѕive and take a while.

A new PF_whatever flag would solve that simply?

Which are the potential use sites for such a thing?

