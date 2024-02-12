Return-Path: <linux-kernel+bounces-61519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A44C985132A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38E2B280C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FB23B2B6;
	Mon, 12 Feb 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klrrKhto"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09763B788
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739628; cv=none; b=J6B1YCgq7rbpOY0IPytFRpzmuA5y89gUuwNyE1u/pdOlHA2MpnNkj8ebyvvvNL6ItxqDOaMzjpHvcVPVTiAJM9z9F6/qJMAqdTUdHd9H6YKAGGDtqhdXo1p7gdKjXiRYWpAiFodxkrbHvjSB+1uEsWfiPCt7eagADF+kHvrAq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739628; c=relaxed/simple;
	bh=LQmJbMxUHHNxmj+wZOcWtcnobJr4RQ8gaDhALegl4ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYV6aDBPi3+I+KZ8xSLepO7hAUaKlUdtuPEtTk2XAnZRPI7E/pIQ9a6MTr0IgLIrvyfdX3D0R/uEJ2XLwo1R9HQoXWqdpfRnQ5j9Ge2trZBg+FYLBl8YE/QvGmJlyh9PKH4pPaKcro/pK8gTD6yxjpaXETZK1rh/i/04fOE2tR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klrrKhto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBD2C433C7;
	Mon, 12 Feb 2024 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707739627;
	bh=LQmJbMxUHHNxmj+wZOcWtcnobJr4RQ8gaDhALegl4ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klrrKhto1pzd+vjY0LmOy///tGlTdcQrKF6R6lHYrADeOHq68a+Jztz1izfQCTctc
	 nox32I+dQ+pmbn01XLNktdzfY3LaMFkD6JVwGas3R0YP9PFIIwCxzclp1yRrCaElWc
	 k69Jx9WMmMH7qxR0Hp4jYRluaHhZz48WeH/8t4uafvlL6icOhodMkiEsd/ONwMhPyg
	 wmMiP9Oym3XkZ+M9DC5YiGr3OncMRW/UFGQES/KayFAcixuyVNXxS3m3Y1KWKbRyfT
	 rEO62yP7mvtUerFR/K0pkFsdThfoEzNJ+7eM6B1ct3zKhGttOc1X0OJ3wx7UG7hCqg
	 NF7fRXdVRRnTw==
Date: Mon, 12 Feb 2024 13:07:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Luca Vizzarro <Luca.Vizzarro@arm.com>, 
	Tom Talpey <tom@talpey.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filelock: ignore 'lock' argument to for_each_file_lock()
Message-ID: <20240212-packpapier-messstation-c5a0c081a0c7@brauner>
References: <20240212112620.1272058-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240212112620.1272058-1-arnd@kernel.org>

On Mon, Feb 12, 2024 at 12:26:11PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_FILE_LOCKING is disabled, ceph causes a warning about
> a variable that is only used insode of the for_each_file_lock()
> loop:
> 
> fs/ceph/locks.c: In function 'ceph_count_locks':
> fs/ceph/locks.c:380:27: error: unused variable 'lock' [-Werror=unused-variable]
>   380 |         struct file_lock *lock;
> 
> Rather than working around this in ceph, change the macro definition
> to still contain a reference to the variable in order to shut up the
> warning.
> 
> Fixes: 75cabec0111b ("filelock: add some new helper functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Yup, seems good to me.

