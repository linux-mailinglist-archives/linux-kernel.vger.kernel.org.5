Return-Path: <linux-kernel+bounces-68764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54561857FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67B01F23380
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9191712F36A;
	Fri, 16 Feb 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6zY6U3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02E912EBF7;
	Fri, 16 Feb 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095139; cv=none; b=m+If3o+7Depk7k6aqPzhK//dBvxeZ846IVACUZvHHjeSy6C93Ue2T6BbDfWBkGuPMYrWhmlgzb4hTDJ/xCmRK8EIvNc/MyEL/jq/FyOPGij/XgpwJA+DlJQR6lyuei8kWNier14iLFIHuUzx2udCGr632oujyiHMbz8nSfeOjac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095139; c=relaxed/simple;
	bh=bUtgLau8oqAzmALl7r4ZTuGib2lzrEo5ddgEED7CwzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKfeEZKokd8epS8oCtiNS/5MlUnFMZNlyP53kyzqfWxLGs+LqUfLgrTmnE5AUMwK8Yq93yMWfTrB4G2uT/pQIP4z4q6kIwvlrxy9UN9dpzPCiR3qgvU8olutoBFoPLsmbikI2vVzE18SUYD/evrzh6B2DCIsEl86OIqbbiH9c5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6zY6U3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C78C433F1;
	Fri, 16 Feb 2024 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708095139;
	bh=bUtgLau8oqAzmALl7r4ZTuGib2lzrEo5ddgEED7CwzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6zY6U3zj3ZrM2WG/PaoBQd+eQ5hktTIkzgZYbyGLxo6cmWVcR4BfE7VcQ2rOe/DL
	 C2pyY3bVx+AT90EmcHAef2orXOZ1CvhjwfbPJTvrC2jO+yCrxe1bco7wkKYNWF+Xfi
	 se2aG2OVaKj1yHeZt1cnRS7DB/i0DrpAvg7d7oH9YHnEGoCmfrLQyGiq+dTyglvyGK
	 ZpdROl37gjLWO1UpEwZ7SDMrHHBP0pYm88e6MWSKs7cWuxq3TTwOqf7826l0yyHNdC
	 shmkIkBKp74w4/p3iqE5doEYJ3HZpMdY8DoDpCHWDsd/t2Ei5afpo4kYU44eBLyFIK
	 yUDHdjiAh03ZQ==
Date: Fri, 16 Feb 2024 15:52:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 1/2] kobject: make uevent_seqnum atomic
Message-ID: <20240216-fluggast-wohnt-17a30f7420d4@brauner>
References: <20240214084829.684541-1-edumazet@google.com>
 <20240214084829.684541-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214084829.684541-2-edumazet@google.com>

On Wed, Feb 14, 2024 at 08:48:28AM +0000, Eric Dumazet wrote:
> We will soon no longer acquire uevent_sock_mutex
> for most kobject_uevent_net_broadcast() calls,
> and also while calling uevent_net_broadcast().
> 
> Make uevent_seqnum an atomic64_t to get its own protection.
> 
> This fixes a race while reading /sys/kernel/uevent_seqnum.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christian Brauner <brauner@kernel.org>
> ---

Nice,
Reviewed-by: Christian Brauner <brauner@kernel.org>

