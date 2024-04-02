Return-Path: <linux-kernel+bounces-127549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA1894D7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2644282CE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC814C601;
	Tue,  2 Apr 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzptfXme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A792EAF7;
	Tue,  2 Apr 2024 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046630; cv=none; b=TEnP9aBZFIHT9q9cLes71jUU754dPTOm5pKrb/ndSaVHNQwT8LeIrzyhzH/7AjLmcH7ZG6GlgtSlC47nVisoA979mlP3hIqxUFfVC1Xj0u6uous4RwGGlm07rAqoYP7aKCEcn3OE0vAZxLq14DpVpFIzyrQdsGgx/BTPYXaSdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046630; c=relaxed/simple;
	bh=Yp6tOq+QIQyi5+nIO0v06Gfl2kI+9Jdp7GY7P6Wta6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHCnWiFaydnzESdkiedPmpkRT425DxVObXK56zYij7GOVrQglQ6+Stmcs4LQbZU2EFbAykKc++0E6TLT2bOI/PlBjpcO7w+MQm1B5tMCocwBrhVJNF3hSWodfJj9g3j/UKK9H3VrYhZpgzUmJoyPPKb6tAoVAIxduggXSBgJfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzptfXme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CDAC433F1;
	Tue,  2 Apr 2024 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046629;
	bh=Yp6tOq+QIQyi5+nIO0v06Gfl2kI+9Jdp7GY7P6Wta6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MzptfXmea8EAAT6BfV+z3zRkEHP/d2OdUwsF67JVWH/gV1/vr9lozyUpzO5m80hTG
	 /YRNMjd1o+7iaWTA2Z+tYXt4v9thJOSsFSgoIbKgG8zc2xKXBeS/mND48HiW8KNQae
	 WI1or/7fD/AJU6p1kf+QI3lk3vJPsmltGj4lnxK47MEKUyWUWOr5Ev18DnAn2NVJPb
	 QeAvE15C5LwEvdSAp27897yvqVc08e4CVhEiDiyJdZcjmPT3XLhM5qqRdIVcDa9DP+
	 9zJ54Nc40khlIExdwrH6X3xaDi7A+yGeLUwuDLcbZR0xe0cRfck/GELT6io6BtFepn
	 EhWdvNWlpoKyQ==
Date: Tue, 2 Apr 2024 09:30:25 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: rkannoth@marvell.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] caif: Use UTILITY_NAME_LENGTH instead of
 hard-coding 16
Message-ID: <20240402083025.GH26556@kernel.org>
References: <8c1160501f69b64bb2d45ce9f26f746eec80ac77.1711787352.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1160501f69b64bb2d45ce9f26f746eec80ac77.1711787352.git.christophe.jaillet@wanadoo.fr>

On Sat, Mar 30, 2024 at 09:32:12AM +0100, Christophe JAILLET wrote:
> UTILITY_NAME_LENGTH is 16. So better use the former when defining the
> 'utility_name' array. This makes the intent clearer when it is used around
> line 260.
> 
> While at it, declare variable in reverse xmas tree style.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>

