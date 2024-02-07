Return-Path: <linux-kernel+bounces-56173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA384C6F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A0D285A37
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B5320B0F;
	Wed,  7 Feb 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUB+w8e3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B222309;
	Wed,  7 Feb 2024 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297119; cv=none; b=XEvlYKem7ce+OaTNvUrJ+gCC5xID79XnSCsD3IJDlQu6YKQLBDUpQjWXDe1h99dS6RoGLvfsqO37vEoFDlvc+7aeIdgt/5B2ToFMkV/urDWi+nGDGQvTUnKJYg0Fl1Ms8CZWTC/dADr7QmSJZVeamXtz3nxnFuOE9SAVdq9efKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297119; c=relaxed/simple;
	bh=AtP/ME1PRkShWXVScAvx8Ke49p5JUPPwqDslrQGzmWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNkSLhIq7NkOLwO/7OZMkAwwz9ickBt5lR41OHF2lihV0wgWLxaewKcBDMZN+tb9YIXpfjbSBuk8bOkqiYsZHfQi391smBzk6f7ECQokU0cgtJ0fErE3+5Brr8zIirIjL0fZya1xS3o2TdeG2vkV23F5Fiz/sDBkUpGFv800AC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUB+w8e3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC8EC433F1;
	Wed,  7 Feb 2024 09:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707297118;
	bh=AtP/ME1PRkShWXVScAvx8Ke49p5JUPPwqDslrQGzmWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KUB+w8e3puRxYM/RkwNkBixv705NA9RWHe7NYPpnteoFJfGgFMP75wCiVEDq/IfL6
	 RAw0ZzNbgTJLFSdmlvAiQuO0WuNGbihyrJu5YsPN8DitSVZqW/Bf54p4ZKKiAmBz/W
	 nqvSHBH4jn/v9TU3FOO1A/HUaI6O6TSu9+UwIxJWTinIQ6ZaFtsYiEtizYB12O9PRI
	 +BHHfGpBOd76esgclmFBN6nYENqzDdym8Bn4JZEVi/VIianPjdWAFajlzeOyNuM4ca
	 aq/ka5XTIAJ/LeiD3rDigO3n7K7lO63dvkM3p2ZoWC4rWEm/dYn9xWKRtpXu6emCdK
	 3ofaA11qUzOzw==
Date: Wed, 7 Feb 2024 10:11:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240207-beseitigen-ausfliegen-b2b95de67c4f@brauner>
References: <20240206164308.62620-1-tycho@tycho.pizza>
 <20240206173722.GA3593@redhat.com>
 <20240206180607.GB3593@redhat.com>
 <ZcJ13uLxD6rTqqZZ@tycho.pizza>
 <20240206192553.GC3593@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206192553.GC3593@redhat.com>

On Tue, Feb 06, 2024 at 08:25:54PM +0100, Oleg Nesterov wrote:
> On 02/06, Tycho Andersen wrote:
> 
> > On Tue, Feb 06, 2024 at 07:06:07PM +0100, Oleg Nesterov wrote:
> > > Or we can check task->files != NULL rather than PF_EXITING.
> > >
> > > To me this looks even better, but looks more confusing without a comment.
> > > OTOH, imo this needs a comment anyway ;)
> >
> > I thought about this, but I didn't really understand the null check in
> > exit_files();
> 
> I guess task->files can be NULL at least if it was cloned with
> kernel_clone_args->no_files == T

Won't this give false positives for vhost workers which do set
->no_files but are user workers? IOW, return -ESRCH even though -EBADF
would be correct in this scenario?

