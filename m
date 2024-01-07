Return-Path: <linux-kernel+bounces-18824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDAA82639F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 10:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F471F21C3F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A8512B80;
	Sun,  7 Jan 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="G05DGoO0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696812B60;
	Sun,  7 Jan 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [46.242.8.170])
	by mail.ispras.ru (Postfix) with ESMTPSA id 577A040F1DDC;
	Sun,  7 Jan 2024 09:48:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 577A040F1DDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1704620892;
	bh=nSwVIYsyGEAHAk7Jdk8Kvbtt6T8ksFe0fmlfwjsnNpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G05DGoO0spAWfn4u4wUPmftj1IkLpD4EaeF5cTZt0lRp6WKrgpK54N3SBwoKEqNo8
	 RmQi6Dv37waC4A6S7kVjAvcoCXrSo5D89g8YYaYyF9hYJ7dz9oL64NcqDs4TPdhKDS
	 oUSBaO3IhWThSxQ/7vL1FdN7l0PebhpnV26jFPxM=
Date: Sun, 7 Jan 2024 12:48:11 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org
Subject: Re: Re: [PATCH v4] net: 9p: avoid freeing uninit memory in
 p9pdu_vreadf
Message-ID: <0e725e7f-00af-4708-8250-f15fb7c7b08e-pchelkin@ispras.ru>
References: <20231206200913.16135-1-pchelkin@ispras.ru>
 <1808202.Umia7laAZq@silver>
 <ZXeZevFb1oDvMFns@codewreck.org>
 <2et72smsvglzicqsyvt5m7bx2akyqzi2moq7tjupppygbsme3u@o2sltttok5wy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2et72smsvglzicqsyvt5m7bx2akyqzi2moq7tjupppygbsme3u@o2sltttok5wy>

On 24/01/07 10:56AM, Vitaly Chikunov wrote:
> Dominique,
> 
> On Tue, Dec 12, 2023 at 08:21:30AM +0900, Dominique Martinet wrote:
> > Christian Schoenebeck wrote on Thu, Dec 07, 2023 at 01:54:02PM +0100:
> > > I just checked whether this could create a leak, but it looks clean, so LGTM:
> > 
> > Right, either version look good to me.
> 
> Also, there was unnoticed bug in v2[1] - `int i` is moved to outer block
> and `i` counld be used uninitialized inside of `if (errcode) {`.

Could you elaborate, please? As I can see, `i` could be used
uninitialized in `if (errcode) {` only when `*wnames` is not NULL. But
when `*wnames` is not NULL, then `i` is initialized in the `for` loop. It
is a bit tricky and not obvious from the first glance (and not the best
decision after all), so with Christian's advice the patch was rewritten
to v4 which was eventually accepted.

The bug you've noticed exists in v1 of the patch, not v2.

> Thanks,
> 
> [1] https://lore.kernel.org/all/20231205091952.24754-1-pchelkin@ispras.ru/

