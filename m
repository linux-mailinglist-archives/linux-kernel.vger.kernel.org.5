Return-Path: <linux-kernel+bounces-58289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B75284E41B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2D4281BF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E7E7A73C;
	Thu,  8 Feb 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOLdUKTB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019A7C6EF;
	Thu,  8 Feb 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406425; cv=none; b=S9OQwekCVLKKCwdaYhfwdZLrnTDpAeDrK1IlwykAQPYgLTFAuLo56MFKUGFZh+fYtJKlrT0AMgO1ywTTC2ILHtixkdE9QnBaU6EI8rpKZmc8OGzJFSX6yhtGlYT0tpUNATchygV4Z6udiZKzf5hwKTQVkCiQ+7XJsy7ktj2mpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406425; c=relaxed/simple;
	bh=1WuTpUCVef7LJMY5BE3Px0Z2qT0aMoQUCFGcGBI2J7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB3S7lqDVzmC7PZ6VwmbAeN00ge+5otZ7XkCWwz3F1S7cbai8685B21Ln+fIYJjSK0RlF3jatKp/g7birA5xibXWJgrqNcrkFaDvQ3sBTzJHAn966Rt0nsAbyTxiCwO0rwXWbi9i0g6rgQObrbPCJbdVjs8OIZ2Aip1NQvRonhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOLdUKTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835C7C433C7;
	Thu,  8 Feb 2024 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707406424;
	bh=1WuTpUCVef7LJMY5BE3Px0Z2qT0aMoQUCFGcGBI2J7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOLdUKTBXYMX+AaErsjgyxBa6UASyCTC9KpgY8M/5SgNWqINISB04ieIJl/ponjjw
	 h1RngJxuipY/GEfZmtKP6kNUa2ckqasyYHrhzsy2RcgFvfbXOdG2xC2IoOtaww5Z18
	 OXYRCjLmwQ6e8JqBkW1PZBqs/ZErIVkacHP09+bx+3u6SUOCVt7Qqg3cBcK29uBXPO
	 Sy6FMd7x7nhDE2AnGtmbU7RFxnwvMtbw3axUqiUbF1+ygJe1iGd2afXpstHXUM/R4Y
	 pH87W+1GbgEwtY+rRQi4BchB4vBWMjMAtABMiODWPYGS3KulJvYtv8f6pyowx5w9+g
	 nugiqQr9mQXzw==
Date: Thu, 8 Feb 2024 16:33:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: change pidfd_send_signal() to respect PIDFD_THREAD
Message-ID: <20240208-klopapier-aushebeln-446ac80a6e9b@brauner>
References: <20240207114549.GA12697@redhat.com>
 <20240208-fragt-prospekt-7866333b15f0@brauner>
 <20240208135344.GD19801@redhat.com>
 <20240208143407.GF19801@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208143407.GF19801@redhat.com>

> Is prepare_kill_siginfo() correct when we send a signal to the child
> pid namespace? si_pid = task_tgid_vnr(current) doesn't look right in
> this case but perhaps I am totally confused.
> 
> And why do we need it at all? Can't sys_kill() and pidfd_send_signal()
> just use SEND_SIG_NOINFO?

Yeah, good point. I don't remember as it's been quite a while ago. My
guess is that it just tried to mirror kill() itself without being aware
of SEND_SIG_NOINFO. If you don't find anything wrong with this then
switch it to SEND_SIG_NOINFO in a preparatory patch we can backport,
please.

