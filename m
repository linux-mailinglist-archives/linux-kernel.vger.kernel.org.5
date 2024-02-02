Return-Path: <linux-kernel+bounces-50327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B5847776
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB77E1C249B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3FF14D44E;
	Fri,  2 Feb 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2BjsCRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465CF149012;
	Fri,  2 Feb 2024 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898588; cv=none; b=O3heavjn9hbrBGZw5J84Wndwxj1flDAFe3Hyxon8lZ4AWmPcselLv1JcLoDlQZDUOW6ZR0bRJaTcQl3lWydfSsElQtR0c+JJyM8iXSJV1cy4RinVP7xB7WLOo1L9wAJ2rBtawPF3jKRGs8PuIG4NgtZUrfmc96PS2acxfUshLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898588; c=relaxed/simple;
	bh=tUCobfJJYi8OieBavxShsPnIA/+6GAcMJyEFD3AP3Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxyOAb/0Sb2EaSP8Sr8jTgYnCv9dhbO441D8a+WZRZRYnU6zxi4LYLEtu7ojlzShpumAuPLxmbS+RMKYaiaChLQkMj+5B5ragKyj7OepA5+uiJ/7KPPJeYfVRspAsFOV50jFrTisCJZyoTyGcoJV4d4WBU2nDzZPoR9BjgLj64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2BjsCRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3FBC433C7;
	Fri,  2 Feb 2024 18:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706898587;
	bh=tUCobfJJYi8OieBavxShsPnIA/+6GAcMJyEFD3AP3Kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i2BjsCROBtsIRrs/j6Ug/MslyOhwVvq1VpFPKQptSb7ysOwj/HgcprrwcNbhppf4g
	 oC2BWiyJxBTjrnxtQOtWaGS/c2ft89VzbIZtcmy3VhBf7rWg85Mo8/7G6i+8Mz4Fu3
	 KbNNmzWSLH/0pzKJeahqIZfEmhT7pBAS8iQI2hdNV/zypXUoq+r8rRyYw6Uz8zLBNi
	 Pyo31JrWMN8Rbq3cNQECPNmsnVDELINMVW85DqzqZ8gPo7pvazR0nxLlySaRAQavqr
	 hvPniZdiFJm2AhHrYhEIVPw5z4CByWWhC/72mDSO7Nhxun843WRu4vzV3/Rh7RO6nE
	 2ch7u7WSZMPPA==
Date: Fri, 2 Feb 2024 10:29:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, mcgrof@kernel.org,
 russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 keescook@chromium.org, nathan@kernel.org, nicolas@fjasle.eu,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] Introduce uts_release
Message-ID: <20240202102946.56215f4e@kernel.org>
In-Reply-To: <CAK7LNATDMjzmgpBHZFTOJCkTCqpLPq8jEjdrwzEZ3uu7WMG7jg@mail.gmail.com>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
	<CAK7LNATDMjzmgpBHZFTOJCkTCqpLPq8jEjdrwzEZ3uu7WMG7jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Feb 2024 00:01:26 +0900 Masahiro Yamada wrote:
> I do not see why it is useful.
> As you discussed in 3/4, if UTS_RELEASE is unneeded,
> it is better to get rid of it.

To be clear - the discussion on 3/4 was about the fact that netdev
already prints UTS_RELEASE into the version member of driver info
struct, as a default. So the drivers no longer have to. But there's 
no user-observable change there.

