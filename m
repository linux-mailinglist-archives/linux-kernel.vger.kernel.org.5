Return-Path: <linux-kernel+bounces-59515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374D284F83F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694101C24D03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5C46DD18;
	Fri,  9 Feb 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3NOP8t3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDF2E3F9;
	Fri,  9 Feb 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491438; cv=none; b=JBi/3rvBNr32Hi5I6uSQ8XcN5EP5sjjsMpeWFBq/zrh7xYyFmzL224Xr+gnJOZl8yL4PDyLMX+JUz47/T/Onnt9v6pexO2JLVrMTxlsisrre6MFZl6UEY3ExfGrHMRfdGQaIoevO7uUo9zxBH7jdhb1CcYa3goIQY0LYSf49HIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491438; c=relaxed/simple;
	bh=jtvQEiSmcdJAs08jFyhzCwqMdwW7UympXpMaOorlvpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPKp3HS32x3KBOK3t8+y+RSOhvJtH5tUGH7u8X9GKUu6lQBeP4YH6C49uLd80U2Yjkwo03VJI7on88mXzT722OR+4dPbEiVMYqWIxNMLKu58lSyFlYXTjNzXoP49iqJkXJrDLRbZN5MLlhMzcgmBepy/ob9kseUO62/md2BW2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3NOP8t3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4CFC433C7;
	Fri,  9 Feb 2024 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707491438;
	bh=jtvQEiSmcdJAs08jFyhzCwqMdwW7UympXpMaOorlvpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3NOP8t3CGrRJnQe2x+5tKwcmnn8kv74kQwowIcfCb68KydK+SJGbPxdATs9a9XYI
	 kZhGdOm3TsELSomtrmGZ8ObQOkcZv4KfBQyAYqEhXmtILL5xsAOsFV218SFyXSHOez
	 AccSIqHmdc3Kml+OqgUxf/Z5YF+mTQU+ePqslRkOJgtRKdVEREANk0Af1i3Uv7RWGq
	 ytSG9GhE2GDUglIqHfNt2p5khlcap8BhykUGULAzjmjgsW82LHCLUyRb+MiVibjlny
	 c4ekm7FY5IIrRw3l6fRCZermAbeecFTcDiiYoWSpP8SWxg6676OCiC7PVEHGKt6ZHi
	 j37BEvRbAFi7w==
Date: Fri, 9 Feb 2024 16:10:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] signal: add the "int si_code" arg to
 prepare_kill_siginfo()
Message-ID: <20240209-praxis-weggehen-6a20e0d02d84@brauner>
References: <20240209130620.GA8039@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209130620.GA8039@redhat.com>

On Fri, Feb 09, 2024 at 02:06:20PM +0100, Oleg Nesterov wrote:
> So that do_tkill() can use this helper too. This also simplifies
> the next patch.
> 
> TODO: perhaps we can kill prepare_kill_siginfo() and change the
> callers to use SEND_SIG_NOINFO,  but this needs some changes in
> __send_signal_locked() and TP_STORE_SIGINFO().
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

