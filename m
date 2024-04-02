Return-Path: <linux-kernel+bounces-128444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 192EF895AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBF91C223CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E751F15A4BA;
	Tue,  2 Apr 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BtgiPMbD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1657414B067;
	Tue,  2 Apr 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079727; cv=none; b=MCxSgo8Bza5DK2iW6RVK1gcx9Rg9xL7U+AATIgbHHI8YO+wUOjB3Ol0sAL2EVd+exmyUPwOTkQShtQRaW/hmCg/Lpm7y+ybgLK3ETF0AlhEu5CECch9NcwDQSILx5ESS2vUxr5/xEodjJkbDqiHjrhfatAX1NKrxMUIKERYe1t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079727; c=relaxed/simple;
	bh=BrDjhKToCvZXQ/w26Dks7chfGTkAyS0yX32TLHZK2tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwJuzz7H0ZWQOIYPxSRovXVbiw3Xq/AVpC0TqriBNWLGMrP2JZ3yg6IOE0OtI0BiemwO3lkRnpe7jeaWSkX5J5JBO7Pc+pyhHjSeMzb9Y0YpCvwOyg8xK5MNJa46BUl32RnOeBKfvTHeyzBnPNTJaqr/MrUp096hCa3hg3EQQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BtgiPMbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A1AC433F1;
	Tue,  2 Apr 2024 17:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712079726;
	bh=BrDjhKToCvZXQ/w26Dks7chfGTkAyS0yX32TLHZK2tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BtgiPMbDy0VIISBkRFQaq0D4WK1FnnThJUzfmJ1miE6fNqFmI3HjqeTo6jcuD5zzW
	 k+D4tu0bMTqpCcaVQnjwfnt2HO5DCqDnsyzfOLYIYMTaIWQnGkv0Rb7XAG/D+9XuRQ
	 uAaC1hbV2ammzAw9z5e7BltKuXLDjNRRL9HTPMQw=
Date: Tue, 2 Apr 2024 19:42:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	will@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
	Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: Re: [PATCH v2] locking/rwsem: Disable preemption while trying for
 rwsem lock
Message-ID: <2024040242-babbling-dreamy-6336@gregkh>
References: <1662661467-24203-1-git-send-email-quic_mojha@quicinc.com>
 <20240305110402.GA72649@darkstar.musicnaut.iki.fi>
 <b92644e5-529b-4403-aba7-d316262cc8ac@redhat.com>
 <20240402173032.GC91663@darkstar.musicnaut.iki.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402173032.GC91663@darkstar.musicnaut.iki.fi>

On Tue, Apr 02, 2024 at 08:30:32PM +0300, Aaro Koskinen wrote:
> Stable team,
> 
> Please cherry-pick this patch into v5.15 stable:
> 
> 	locking/rwsem: Disable preemption while trying for rwsem lock
> 
> 	commit 48dfb5d2560d36fb16c7d430c229d1604ea7d185
> 
> It fixes the following bug present in v5.15:
> 
> > > > From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> > > > We observe RT task is hogging CPU when trying to acquire rwsem lock
> > > > which was acquired by a kworker task but before the rwsem owner was set.
> > > > 
> > > > Here is the scenario:
> > > > 1. CFS task (affined to a particular CPU) takes rwsem lock.
> > > > 
> > > > 2. CFS task gets preempted by a RT task before setting owner.
> > > > 
> > > > 3. RT task (FIFO) is trying to acquire the lock, but spinning until
> > > > RT throttling happens for the lock as the lock was taken by CFS task.
> 
> If the RT throttling is disabled, the RT task will remain looping forever
> in the kernel. If the system is UP, it will lock up completely.
> 
> The issue can be easily reproduced by running RT task and normal task which
> are affined to the same CPU core.

Does this only affect the -rt patchset, or is this an issue with a
"clean" kernel release?

thanks,

greg k-h

