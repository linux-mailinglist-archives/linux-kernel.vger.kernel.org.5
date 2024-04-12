Return-Path: <linux-kernel+bounces-142893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1FA8A31B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F710282152
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248C147C76;
	Fri, 12 Apr 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3qg+hRz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19511474B7;
	Fri, 12 Apr 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934090; cv=none; b=RuwRVieGOqG1JQhebxk7yOetnUZhutGh8g5iP2PmScxVeqylmOdWgca5h/5CTmXXf7NJIIHczbQzjQoWqHDMo1o2gSyE4kvwO6/hLUAkJkEADnhhxvXKNxxsVTXhwNRKhdTtCvUvspwxRK0z4k/LRCye/EPEUvPEmUK+hIlwfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934090; c=relaxed/simple;
	bh=ToxgLFg2Q1e6fGsBgZIQyTd8OjeYBKLeADeKze6ZKKY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tNkqfjsP96JYgkMdMeTAP5McxqhxVDZIurabG45TZZcpzaNCvFHhAFRMrqPJIWa3g1Pllw0llTwRrFZYZ53ZCti22t9DakX8Z6mCbHchvnYMV2h3/DhOck8n86utX9ylV5CeVUYG6sVEJYaP+GMCqJAFW7U0ie6KSlZ2bXm50O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3qg+hRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD261C113CC;
	Fri, 12 Apr 2024 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934090;
	bh=ToxgLFg2Q1e6fGsBgZIQyTd8OjeYBKLeADeKze6ZKKY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=j3qg+hRzowqgr6GV+Tu8cO3EUABQIgM5Av6iwSQ5y2cnPD6nc45VmudEw2h1Shj0t
	 ptSSPXzAtlL/DouewCW3pbXQ+5dKWkFSxpvVRSCmASFvWHz1k+sGQt0kzgONilF3L1
	 By2IrdsDXdNcpxWiYzvJMrTGKYzLODqI+I04EXdSmBIUItHbHQiFPSd/gp9QU2oc1B
	 +CI8UMIw0vsYRRSLqKF6Tgfn/AJbgyQp+sMmZouWAz21KCMo/LZ7jsZsv8qti3X+s9
	 ckgLwDtDfJ3a8IktS1YrkN3oZldY6BoRjmKq2B2FOwGGKZ0KF/I2YWcICSk+yfDJf7
	 J9wzP4NcrN/EQ==
Date: Fri, 12 Apr 2024 17:01:27 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Max Staudt <max@enpas.org>
cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    Roderick Colenbrander <roderick.colenbrander@sony.com>
Subject: Re: [bug report] HID: playstation: DS4: Don't fail on calibration
 data request
In-Reply-To: <4e486902-9238-48db-b0b2-2abce4f3b812@enpas.org>
Message-ID: <nycvar.YFH.7.76.2404121700540.5680@cbobk.fhfr.pm>
References: <d0e5bb97-3e18-44ac-89b0-503cfe16417f@moroto.mountain> <07848795-14e3-4020-9e60-e3221ff6ef80@enpas.org> <4e486902-9238-48db-b0b2-2abce4f3b812@enpas.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Apr 2024, Max Staudt wrote:

> >> Commit a48a7cd85f55 ("HID: playstation: DS4: Don't fail on 
> >> calibration data request") from Feb 8, 2024 (linux-next), leads to 
> >> the following Smatch static checker warning:
> >>
> >> [...]
> > 
> > 
> > Hi Dan, Jiri,
> > 
> > Thanks for the report!
> > 
> > 
> > Jiri, if you prefer to do so, please feel free to stop/revert this 
> > patch for now, and I'll send a better one soon.
> > 
> > [...]
> 
> Jiri,
> 
> Would you like me to send a patch on top of the existing one, or a completely
> fresh one?

Max,

please send a followup one with proper Fixes: tag. We're generally not 
rebasing the tree.

Thanks,

-- 
Jiri Kosina
SUSE Labs


