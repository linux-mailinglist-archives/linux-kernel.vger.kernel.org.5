Return-Path: <linux-kernel+bounces-71798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3FC85AA99
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7C21F216DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94F481A6;
	Mon, 19 Feb 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Li6ST8cN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35A446CE;
	Mon, 19 Feb 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366230; cv=none; b=FddyRSJPFZknvKBpZIE3m/ldPzE9s5Z76jasMfK29r7gM14+F9XI5LjsB4n3Az5C171Jo66xtfPSvcMBQWZcIqVnz92w1YjM6c+k11t3Mk8kX5ED5+YgJOMogXLZEuKWyOP9qAjZfvmAca2jbwqVrAOVQtLRnAsCM0oQdVYQwiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366230; c=relaxed/simple;
	bh=EMmfRMzJxnR50bOnH7ujQWXPJcj/zGrGnPdRfBHwmbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBToYrQ0w2NUsl6tAvwolkDDWBngebEzGRbTg0p8AT+OHAYeq89/nJ7lX4eXExIYy+mf6IXRmihBqyPxB8XrvInJ1bpMwbpRMmZeIRPN4otrM2nnSzfk71/uKgX/GmcfwtMOmB49Pcn7A2Je/EetXjqfG6P4jsoaDxNZhRQ6uBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Li6ST8cN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3B8C433F1;
	Mon, 19 Feb 2024 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366230;
	bh=EMmfRMzJxnR50bOnH7ujQWXPJcj/zGrGnPdRfBHwmbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Li6ST8cNKEgI2g/6xKw5eaNtEsgr0s31SHXttB3SkD7EhEQJ54SEHWhwhmibUWIes
	 mXNBTiHkmDjIGm+lm5CeH5KFSVmr+xYjolre95SxGg6wAK/VstxGKvo5IAKhnOwbxg
	 dtqGqNPYwD8r0pKiSIwAw8t9ZRnp8qLxQCxoGZW8=
Date: Mon, 19 Feb 2024 19:10:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [v6.7][PATCH v2 00/23] eventfs: Linus's updates for 6.7
Message-ID: <2024021919-herbs-uninvited-c286@gregkh>
References: <20240206113158.822006147@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206113158.822006147@rostedt.homelinux.com>

On Tue, Feb 06, 2024 at 06:31:58AM -0500, Steven Rostedt wrote:
> 
> This is a backport of all the work that lead up to the work that Linus made
> on eventfs. I trust Linus's version more so than the versions in 6.6 and
> 6.7. There may be plenty of hidden issues due to the design.
> 
> This is the update for 6.7. It includes Linus's updates as well as all the
> patches leading up to them.
> 
> I ran these through my full test suite that I use before sending anyting to
> Linus, althouh I did not run my "bisect" test that walks through the
> patches. The tests were just run on the end result. I'm currently running my
> 6.6 version through my tests.
> 
> This was created with the following command against v6.7.3:
> 
> git log --reverse --no-merges --pretty=oneline v6.7..origin/master fs/tracefs/ | cut -d' ' -f1 |
>    while read a; do if ! git cherry-pick -x $a; then break; fi ; done
> 
> Which adds -x to the cherry pick to add the upstream commit SHAs.

All now picked up, thanks.

greg k-h

