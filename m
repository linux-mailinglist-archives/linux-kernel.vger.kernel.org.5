Return-Path: <linux-kernel+bounces-18811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A367826352
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E0E28296B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 08:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04A412B74;
	Sun,  7 Jan 2024 08:06:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245D5125BF;
	Sun,  7 Jan 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 14EE372C8CC;
	Sun,  7 Jan 2024 10:56:23 +0300 (MSK)
Received: from pony.office.basealt.ru (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id D1A1836D0170;
	Sun,  7 Jan 2024 10:56:23 +0300 (MSK)
Received: by pony.office.basealt.ru (Postfix, from userid 500)
	id AE40C360AC7D; Sun,  7 Jan 2024 10:56:23 +0300 (MSK)
Date: Sun, 7 Jan 2024 10:56:23 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Fedor Pchelkin <pchelkin@ispras.ru>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v4] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <2et72smsvglzicqsyvt5m7bx2akyqzi2moq7tjupppygbsme3u@o2sltttok5wy>
References: <20231206200913.16135-1-pchelkin@ispras.ru>
 <1808202.Umia7laAZq@silver>
 <ZXeZevFb1oDvMFns@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXeZevFb1oDvMFns@codewreck.org>

Dominique,

On Tue, Dec 12, 2023 at 08:21:30AM +0900, Dominique Martinet wrote:
> Christian Schoenebeck wrote on Thu, Dec 07, 2023 at 01:54:02PM +0100:
> > I just checked whether this could create a leak, but it looks clean, so LGTM:
> 
> Right, either version look good to me.

Also, there was unnoticed bug in v2[1] - `int i` is moved to outer block
and `i` counld be used uninitialized inside of `if (errcode) {`.

Thanks,

[1] https://lore.kernel.org/all/20231205091952.24754-1-pchelkin@ispras.ru/

> I don't have a hard preference here, I've finished testing and just
> updated the patch -- thanks for your comments & review
> (and thanks Simon as well!)
> 
> -- 
> Dominique Martinet | Asmadeus

