Return-Path: <linux-kernel+bounces-18832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B98263BB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 11:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80854B20DBC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 10:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D6A12B93;
	Sun,  7 Jan 2024 10:14:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9E712B78;
	Sun,  7 Jan 2024 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 71DFD72C8CC;
	Sun,  7 Jan 2024 13:14:12 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 6048736D0170;
	Sun,  7 Jan 2024 13:14:12 +0300 (MSK)
Date: Sun, 7 Jan 2024 13:14:12 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v4] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <20240107101412.av7ypbdstfudoejg@altlinux.org>
References: <20231206200913.16135-1-pchelkin@ispras.ru>
 <1808202.Umia7laAZq@silver>
 <ZXeZevFb1oDvMFns@codewreck.org>
 <2et72smsvglzicqsyvt5m7bx2akyqzi2moq7tjupppygbsme3u@o2sltttok5wy>
 <0e725e7f-00af-4708-8250-f15fb7c7b08e-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <0e725e7f-00af-4708-8250-f15fb7c7b08e-pchelkin@ispras.ru>

Fedor,

On Sun, Jan 07, 2024 at 12:48:11PM +0300, Fedor Pchelkin wrote:
> On 24/01/07 10:56AM, Vitaly Chikunov wrote:
> > 
> > On Tue, Dec 12, 2023 at 08:21:30AM +0900, Dominique Martinet wrote:
> > > Christian Schoenebeck wrote on Thu, Dec 07, 2023 at 01:54:02PM +0100:
> > > > I just checked whether this could create a leak, but it looks clean, so LGTM:
> > > 
> > > Right, either version look good to me.
> > 
> > Also, there was unnoticed bug in v2[1] - `int i` is moved to outer block
> > and `i` counld be used uninitialized inside of `if (errcode) {`.
> 
> Could you elaborate, please? As I can see, `i` could be used
> uninitialized in `if (errcode) {` only when `*wnames` is not NULL. But
> when `*wnames` is not NULL, then `i` is initialized in the `for` loop. It
> is a bit tricky and not obvious from the first glance (and not the best
> decision after all), so with Christian's advice the patch was rewritten
> to v4 which was eventually accepted.
> 
> The bug you've noticed exists in v1 of the patch, not v2.

You are right, it only affects v1. I didn't notice that important difference
in v2. My excuses!

Thanks,

> 
> > Thanks,
> > 
> > [1] https://lore.kernel.org/all/20231205091952.24754-1-pchelkin@ispras.ru/

