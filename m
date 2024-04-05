Return-Path: <linux-kernel+bounces-132471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E46899566
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945B1B23259
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AC61BF27;
	Fri,  5 Apr 2024 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SrA1e7hd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0E71370;
	Fri,  5 Apr 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298758; cv=none; b=DllL9FY0KaxJsRy7cQwT5CV3cAHGuQFiqiPYp1EdzACxTUlTFI2bIU5EUpSWd/E0x1e7YLjcFTmn2UlZIuRDiV4yp/21cu8S+9mtgF0k55NmJYymSzc/bCZtTijK2A/9CZPs6o6ShuNU8owMVoYprSLpj05g97owOT+0PQUa5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298758; c=relaxed/simple;
	bh=yrYj/fn0Es5aNmP/WwiDYBJAbAsdwC7f18uD7wJoyz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1r0mO8gDZdis3tZJ02nLqnCvpgAox6XAI9ErjNubnkGIm6nV5XRfrYbSwGSh/N3Zxvcun+zGmayCANKWVMaio5BHotctB/iHHd2tam/AuXRNd2IrhXyOM/w4tog7Vr8kyFSY/Z4zZ5bsAuU6W1DLh/RmkPmoy3UJF/RGUYGJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SrA1e7hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D799C433F1;
	Fri,  5 Apr 2024 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298757;
	bh=yrYj/fn0Es5aNmP/WwiDYBJAbAsdwC7f18uD7wJoyz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrA1e7hdU6jDlvPeaJ3+Tq2YiTOMH1PdQ2NqunpMiWAQTfd+B+EAYwHe4rGDzQ/TZ
	 N8rZJQv0JgUkz3mCs7nEuiGkCYXA0cdt496cafcUO8IDiJidNiELtJEqVOf90YDgSy
	 eIRny3aH6IAGz3OHrcAnisfx2vLinzdS+sb5Pskw=
Date: Fri, 5 Apr 2024 08:32:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	will@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
	Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: Re: [PATCH v2] locking/rwsem: Disable preemption while trying for
 rwsem lock
Message-ID: <2024040524-skier-snippet-74eb@gregkh>
References: <1662661467-24203-1-git-send-email-quic_mojha@quicinc.com>
 <20240305110402.GA72649@darkstar.musicnaut.iki.fi>
 <b92644e5-529b-4403-aba7-d316262cc8ac@redhat.com>
 <20240402173032.GC91663@darkstar.musicnaut.iki.fi>
 <2024040242-babbling-dreamy-6336@gregkh>
 <20240402182511.GD91663@darkstar.musicnaut.iki.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402182511.GD91663@darkstar.musicnaut.iki.fi>

On Tue, Apr 02, 2024 at 09:25:11PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, Apr 02, 2024 at 07:42:03PM +0200, Greg KH wrote:
> > On Tue, Apr 02, 2024 at 08:30:32PM +0300, Aaro Koskinen wrote:
> > > Stable team,
> > > 
> > > Please cherry-pick this patch into v5.15 stable:
> > > 
> > > 	locking/rwsem: Disable preemption while trying for rwsem lock
> > > 
> > > 	commit 48dfb5d2560d36fb16c7d430c229d1604ea7d185
> > > 
> > > It fixes the following bug present in v5.15:
> > > 
> > > > > > From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> > > > > > We observe RT task is hogging CPU when trying to acquire rwsem lock
> > > > > > which was acquired by a kworker task but before the rwsem owner was set.
> > > > > > 
> > > > > > Here is the scenario:
> > > > > > 1. CFS task (affined to a particular CPU) takes rwsem lock.
> > > > > > 
> > > > > > 2. CFS task gets preempted by a RT task before setting owner.
> > > > > > 
> > > > > > 3. RT task (FIFO) is trying to acquire the lock, but spinning until
> > > > > > RT throttling happens for the lock as the lock was taken by CFS task.
> > > 
> > > If the RT throttling is disabled, the RT task will remain looping forever
> > > in the kernel. If the system is UP, it will lock up completely.
> > > 
> > > The issue can be easily reproduced by running RT task and normal task which
> > > are affined to the same CPU core.
> > 
> > Does this only affect the -rt patchset, or is this an issue with a
> > "clean" kernel release?
> 
> It's with a normal "clean" kernel.

Fair enough, now queued up, thanks.

greg k-h

