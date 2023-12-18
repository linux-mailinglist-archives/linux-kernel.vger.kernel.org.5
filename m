Return-Path: <linux-kernel+bounces-3428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF29816C23
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3DE1F2373A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD095199C1;
	Mon, 18 Dec 2023 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XS4eL7mR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE001A59F;
	Mon, 18 Dec 2023 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CE10B206DF;
	Mon, 18 Dec 2023 12:19:09 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hQbiMYi0iXkN; Mon, 18 Dec 2023 12:19:09 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 430B1201D5;
	Mon, 18 Dec 2023 12:19:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 430B1201D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1702898349;
	bh=PfMb0onkMIAbXO1c9wwoJqI8g2yhCCtHs2P/GUyDOfo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=XS4eL7mRPdHNTET2O6GIs87G50M4+FhQ6VSBnKQlyht9m58beToltcO9HHgbiOTyP
	 bZkcGSv1TtYxPSeX3zbpZclEM9zmI4aQhANGiv/BL0P1GVFydhJYQBklksZzEX26ng
	 GSdoI1aWhgVvCwoabyehqlVSIoHdNEIn7jYeFGlmazuHmuJMgv1NOppB57DWcKNmX0
	 A+TwsmlOQCEJVEinFMiXNwOCRnBdA8KxbIKLLZNKdrGllvOYWXiJi/YsQKAldYBT5s
	 W4DShLt30II/87KynaPhGpdoHe/6U7Clf6C1yHCvR02OUqHpHye/NlmeeYP8VTRRnh
	 3FpFJ5neDFckQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 3CC9180004A;
	Mon, 18 Dec 2023 12:19:09 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 18 Dec 2023 12:19:09 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 12:19:08 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 719583180C41; Mon, 18 Dec 2023 12:19:08 +0100 (CET)
Date: Mon, 18 Dec 2023 12:19:08 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: Zhang Yiqun <zhangyiqun@phytium.com.cn>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: Use spin_lock_bh() in xfrm_input()
Message-ID: <ZYAqrDSp6QuKv5I0@gauss3.secunet.de>
References: <20231218084252.7644-1-zhangyiqun@phytium.com.cn>
 <CANn89i+t9t5ca=r6ZKw7s-HrxzgJjCB6hmWLccKmmxg8H=HUUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+t9t5ca=r6ZKw7s-HrxzgJjCB6hmWLccKmmxg8H=HUUA@mail.gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Dec 18, 2023 at 12:07:50PM +0100, Eric Dumazet wrote:
> On Mon, Dec 18, 2023 at 9:43 AM Zhang Yiqun <zhangyiqun@phytium.com.cn> wrote:
> >
> > This patch is to change spin_lock() into spin_lock_bh(), which can
> > disable bottem half in calling. If we leave this as spin_lock(),
> > it may stuck in a deadlock, because the callback in bottem half in
> > crypto driver will also call xfrm_input() again.
> >
> > Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
> 
> When was the bug added ?
> We need a FIxes: tag.

This looks more like a 'crypto driver' bug. xfrm_input() runs in
the RX path and therefore expects to run with BHs off.


