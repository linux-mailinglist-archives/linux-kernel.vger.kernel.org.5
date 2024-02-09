Return-Path: <linux-kernel+bounces-59516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594B184F841
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8209C1C2519F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85776E2C1;
	Fri,  9 Feb 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXnBv+Pa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821E6D1CB;
	Fri,  9 Feb 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491474; cv=none; b=iRL7xWLffef9BAzzlPWQJF+i3F8kPD2p6obUT55UOSEAEkP05cM+EuTZzjTa61s2mCprMFI/PJ583q8dCBd3HkcENt333LXL8EddJbcX/2UYCr5hUiG0YLlAv0F5aThpm68WIH2ViewWFZVoZz7EWcdndREOTaY6X2HknXdVR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491474; c=relaxed/simple;
	bh=VwCqQlgMD5ijvTe1CDRtTpyuJtBMBP3AZJbX9C0U4eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVToFPgd3os8xSN2CS9NPPH/iCnqIujeZ9cV64F/vX/xQ+mNFDxpYwvwzzG9ucQ5+7NIbK7bD4DQjYX/z2FNd+BDQie6qlt1LEzw4AZN20jNZE5Ucq/39CBRTNliy1eXWBw9FOHAJFJwb5yxhQWYo1oN9xixpIQQXxeIntjrJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXnBv+Pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CE5C43390;
	Fri,  9 Feb 2024 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707491473;
	bh=VwCqQlgMD5ijvTe1CDRtTpyuJtBMBP3AZJbX9C0U4eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXnBv+PaprGtyM8d1vEJZaPYs8z9ZiMmYRLvBJdHcpmfzTRm/hr6im4QePAIUKTEy
	 Ddhf8E9NuKTx0XAcqCj2daArr6uwjZ2vgA1MRLQ9yjdJbvvq0me0993N9AHRn7+h9p
	 /VbpybhSp8acS4pkGLAoYvsKB65Rc4x7JmCqLjUCtg6BmuYD3i+PtBO54qoCnJntm+
	 +yDl0XaZYeiRc+yyEAsEueh9L4EGrdEQ0I7jcBvOBfY9xerDLGRTQNo6v2lC3BJGD5
	 UCG4OrrnTTqOcxYPoNL7eTN12PoYV9m/DKJaIEGx7KM3rTXW9XBL/1Q9hnAyOmRqXo
	 0ckgim5vRfscA==
Date: Fri, 9 Feb 2024 16:11:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pidfd: change pidfd_send_signal() to respect
 PIDFD_THREAD
Message-ID: <20240209-bockig-essverhalten-9d80946c0bf4@brauner>
References: <20240209130620.GA8039@redhat.com>
 <20240209130650.GA8048@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209130650.GA8048@redhat.com>

On Fri, Feb 09, 2024 at 02:06:50PM +0100, Oleg Nesterov wrote:
> Turn kill_pid_info() into kill_pid_info_type(), this allows to pass any
> pid_type to group_send_sig_info(), despite its name it should work fine
> even if type = PIDTYPE_PID.
> 
> Change pidfd_send_signal() to use PIDTYPE_PID or PIDTYPE_TGID depending
> on PIDFD_THREAD.
> 
> While at it kill another TODO comment in pidfd_show_fdinfo(). As Christian
> expains fdinfo reports f_flags, userspace can already detect PIDFD_THREAD.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

