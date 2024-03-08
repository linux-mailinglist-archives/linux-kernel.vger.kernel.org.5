Return-Path: <linux-kernel+bounces-97628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4032876CC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999F11F22524
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503E360877;
	Fri,  8 Mar 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/C5gEt+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B93605DB;
	Fri,  8 Mar 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935830; cv=none; b=EtzxQpbOJ7icERF12Dcf++lDJymmGJZjPa0MfO8asddHkzXYi1ZR7plEjxzIKTGivrOA8OBwOLRV88pUljKTGiIvHBKEIFfVhD+/lbTvdm3K3kQels1egu3gfkRMSOw089URH5KpSkkxfR+FMgXsZjVufeEuKAkmEdQIWcpcnz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935830; c=relaxed/simple;
	bh=h2IGNEEl+lBukqb70q3Af7Z6YogeUDNZLXtgJsNvBW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvQzUFv9t5QMaDGgrC7ier4HBtsfEULxM1qqizb7nDYI18INviYoxlppFu9jwtoyvNoRIVuUfvIx858Bh4h5cEVq0pS3xjevi0YjI6HKykeUt4gJxnDbrWKBIREozzqyNYoMoJFYukbTwZhIGEAMmyJI47mkGww/63CKSyKoblQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/C5gEt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4767C433C7;
	Fri,  8 Mar 2024 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935830;
	bh=h2IGNEEl+lBukqb70q3Af7Z6YogeUDNZLXtgJsNvBW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/C5gEt+uB+9gq6IZ3G2/nWmEeCxoUuxbY+vEpY5y4ppcptGzBGAovQRwZJQ0C8Ac
	 1GsuOg7iE+jfT4raua3sEgtBq3oRxE1frFp5jSkGP7z7p7248WKU8IgInYRY6yg3dZ
	 fPiN5YgeYNVDV4egJ2HGtFPlj9JPMLDNR2oc/Q/Gi4nc3cDvMPan3nUxNEAZV7FKb0
	 YExR6MFbfd3Led9fI+bwd9nFmXkuVEZ0SGm8Z1b7skKJqcbpzl+g6aE/mx/J/OXjwP
	 dUMRQDYfNvXaspBm9i3K06fKIhyloLJBZlhRYRdnwc2FE+JAugipmRYg3wOu26zlMB
	 Z5GJCbJGyzb7w==
Date: Fri, 8 Mar 2024 23:10:27 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com, urezki@gmail.com,
	neeraj.iitr10@gmail.com, rcu@vger.kernel.org, rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH] [RFC] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
Message-ID: <ZeuM0wdc61QQNDHU@pavilion.home>
References: <20240307234852.2132637-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307234852.2132637-1-joel@joelfernandes.org>

Le Thu, Mar 07, 2024 at 06:48:51PM -0500, Joel Fernandes (Google) a écrit :
> In the synchronize_rcu() common case, we will have less than
> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> is pointless just to free the last injected wait head since at that point,
> all the users have already been awakened.
> 
> Introduce a new counter to track this and prevent the wakeup in the
> common case.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

