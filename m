Return-Path: <linux-kernel+bounces-9405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F9281C513
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F49286BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8513C8CF;
	Fri, 22 Dec 2023 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thedillows.org header.i=@thedillows.org header.b="dXH9kDqj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from voodoobox.net (matrix.voodoobox.net [172.105.149.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76FCBA3F;
	Fri, 22 Dec 2023 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thedillows.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thedillows.org
Received: from [192.168.0.103] ([76.133.22.181])
	(authenticated bits=0)
	by voodoobox.net (8.14.4/8.14.4) with ESMTP id 3BM5c2xW028689
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 22 Dec 2023 00:38:03 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 voodoobox.net 3BM5c2xW028689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thedillows.org;
	s=default; t=1703223485;
	bh=BIetNQN2KFwX2v/ecFDd6ZNUmdmAnY6xrpyCv7uD/10=;
	h=Subject:From:To:Cc:Date:In-Reply-To:From;
	b=dXH9kDqj/fJSNJGOFk6gsap67jxZdBObFWaMs4O/ltqiCfC4npBIDg3Gbz9+oCa5s
	 tU5jSIYwT01Tu/OjaLWDv3TFIURpaAh1jkPPuzbp7IlQF9RKW78Zc9qCPubgq+WmZQ
	 Iqt34FhRxIABWunyyVGh/pOYzdNaewaOX3qq3UwuplOrxiaKm5yY8vzNAIdtFGwM1O
	 Z2TCwHH7/c73jk0kUPn0tj4SF0xv4iXgTAhhR4rvOwNUlZCgYCWQcjB8YtkGOthJaV
	 p3piDiZTwQS6yj03wCmjOYgNdw3Z/9eN7jmH3vqqe7YP8owKSxJtTZ5jaMqho6fUy2
	 h2f3YWF6IQfwA==
Message-ID: <aaa613cf32a940eb26e6713650555a1efe181ea9.camel@thedillows.org>
Subject: Re: [PATCH next] bonding: Extending LACP MUX State Machine to
 include a Collecting State.
From: David Dillow <dave@thedillows.org>
To: jay.vosburgh@canonical.com
Cc: aahila@google.com, andy@greyhouse.net, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au,
        kuba@kernel.org, linux-kernel@vger.kernel.org, maheshb@google.com,
        martin.lau@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Date: Thu, 21 Dec 2023 21:38:01 -0800
In-Reply-To: <21529.1703184528@famine>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> I haven't read the patch in detail yet, but my overall question
> is: why do we need this?  This adds significant complexity to the
> state machine logic.  What real problem is this solving, i.e., what
> examples do you have of systems where a port is "in a state where
> it can receive incoming packets while not still distributing"?

Any time we add a new link to an aggregator, or the bond selects a new
aggegrator based on the selection policy, there is currently a race
where we start distributing traffic before our partner (usually a
switch) is ready to start collecting it, leading to dropped packets if
we're running traffic over the bond. We reliably hit this window,
making what should be a non-issue into a customer-visible packet-loss
event. Implementing the full state machine closes the window and makes
these maintenance events lossless.


