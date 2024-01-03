Return-Path: <linux-kernel+bounces-15396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2B5822B71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E727A1C23337
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9618C14;
	Wed,  3 Jan 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pKmf45K6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554218C07;
	Wed,  3 Jan 2024 10:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB253C433C7;
	Wed,  3 Jan 2024 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704278041;
	bh=aWS2YME3848I0ynrLAlho7FFoHCPwzbm0vF7fMYm1is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKmf45K6HdKLWkwCnWBjoCLIEIx8ZjwReE5yynxg3/Qf7jwrID7nt62+qAvqexJUt
	 gugqzkk1v8/V3sDUravrVz6JVtkypqNrKBDyJL+FQhshpEwI5t/3TUUsD5bBHXNctf
	 3BrHPWIFXPlo4HKXHmGFIX4yMCChL7NLj4J45qic=
Date: Wed, 3 Jan 2024 11:33:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	Youngmin Nam <youngmin.nam@samsung.com>,
	linux-kernel@vger.kernel.org, d7271.choe@samsung.com,
	janghyuck.kim@samsung.com, hyesoo.yu@samsung.com,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v1 3/3] PM: sleep: Fix possible deadlocks in core
 system-wide PM code
Message-ID: <2024010322-uneven-nanometer-7d6d@gregkh>
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <5754861.DvuYhMxLoT@kreacher>
 <6019796.lOV4Wx5bFT@kreacher>
 <13435856.uLZWGnKmhe@kreacher>
 <CAPDyKFohQjDzpYpm0QQLM4eTzGOzGfDNKUGHHC-niPBOrtR8BQ@mail.gmail.com>
 <CAJZ5v0jPtYFk=pPE63CGGL0kuc+N_bZqKdgBMC=PMrwqzHBDTg@mail.gmail.com>
 <CAPDyKFp5BGpVX5WZxD+u4QELD9KEKVGE41q8mPxM8Eg4dP7RLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFp5BGpVX5WZxD+u4QELD9KEKVGE41q8mPxM8Eg4dP7RLw@mail.gmail.com>

On Wed, Jan 03, 2024 at 11:17:18AM +0100, Ulf Hansson wrote:
> On Tue, 2 Jan 2024 at 14:54, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jan 2, 2024 at 2:35 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 27 Dec 2023 at 21:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > It is reported that in low-memory situations the system-wide resume core
> > > > code deadlocks, because async_schedule_dev() executes its argument
> > > > function synchronously if it cannot allocate memory (an not only then)
> > > > and that function attempts to acquire a mutex that is already held.
> > > >
> > > > Address this by changing the code in question to use
> > > > async_schedule_dev_nocall() for scheduling the asynchronous
> > > > execution of device suspend and resume functions and to directly
> > > > run them synchronously if async_schedule_dev_nocall() returns false.
> > > >
> > > > Fixes: 09beebd8f93b ("PM: sleep: core: Switch back to async_schedule_dev()")
> > > > Link: https://lore.kernel.org/linux-pm/ZYvjiqX6EsL15moe@perf/
> > > > Reported-by: Youngmin Nam <youngmin.nam@samsung.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > The commit pointed to by the Fixes: tag is the last one that modified
> > > > the code in question, even though the bug had been there already before.
> > > >
> > > > Still, the fix will not apply to the code before that commit.
> > >
> > > An option could be to just do "Cc: stable@vger.kernel.org # v5.7+"
> > > instead of pointing to a commit with a Fixes tag.
> >
> > Right, but one can argue that every commit with a "Cc: stable" tag is
> > a fix, so it should carry a Fixes: tag too anyway.
> 
> Yes, certainly. But in this case it's more questionable as it's not
> really fixing the commit it points out.
> 
> Note that, I have no strong opinion here, but maybe Greg has a preferred way?

Either is fine with me, just to give me a good hint on how far back a
commit should be backported to.

thanks,

greg k-h

