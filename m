Return-Path: <linux-kernel+bounces-107150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 762D387F828
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17EA1B21C10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43C51C5F;
	Tue, 19 Mar 2024 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="vfeXqGem"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C951C36;
	Tue, 19 Mar 2024 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832072; cv=none; b=QW6jGpkhoXpmKChhFXeFhbyy3Vdhvke/ZMVEx68V7gxLSR30RMfkDa0pnA4mNkebbzf2FXjLcsZD9bdKeAV3LOTIJ+4zvcxc/aZ29TQYNuOdGM5MDcXf03MncWZYCQ2tUzoVqR4zeVKzlZ2VcxJaCNtxlYVLINpp9BtTlQWUX4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832072; c=relaxed/simple;
	bh=iPZ2Dnlib6/HoDBFi0g9Pl+JvcOySaOgkfjoXi33KD8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By1wv/MyXSUVqbLUMibTJ14saA7L6jmKsMug2TBixnB114Grs+lH6zGGQiyK/dKFYMdFtF5/Oh5C46n+xdc+hknd+E5qOxrjJkRWrYm5y3GdLWL0Ct1K7TbMQTAFdCb4q43nYX29O4v8BmZ5JjVIjSVee3dnb4MT3N8rrNCUbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=vfeXqGem; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2A45E20799;
	Tue, 19 Mar 2024 08:07:41 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1JCDnKlMO-Kk; Tue, 19 Mar 2024 08:07:40 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4024120764;
	Tue, 19 Mar 2024 08:07:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4024120764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710832060;
	bh=OuUhCp/3VgwJ59EoYl+BnsNytBwFvjtncVtl8l0G2gs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=vfeXqGemFYmWfTuFMHsz+8vw/HrgzkztJB4eiHCZ9NBSF74oFZXJ2Vq28qmuloQk7
	 Ov3iTw5+xb2xYAJXwOGungG92qbvdPMNYZ2Nho69P4sWCYSUo7XwHUvHwj/V+/rRNl
	 PRzSOkcA7fvuSj7JLn0Z/7eIJYtCy+lpZlWrMPe3W8kVI2whWjoPmC4g6sp2I8R8J0
	 UiYoCJmVJVY3of5AAvcNE5Lx1AlmQ/Vzs/rT2BZLGzznaucKGU6pcTGjYZC/npS2eu
	 xZGFB77SoZ2EANfwiMy35p7NFAKs+6UrR7QRtOzW8ow5V6hOCor4ZANXcy/oMIb9mG
	 S/+xXa9DBpwcw==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 3106080004A;
	Tue, 19 Mar 2024 08:07:40 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 08:07:39 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 08:07:39 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 69083318038E; Tue, 19 Mar 2024 08:07:39 +0100 (CET)
Date: Tue, 19 Mar 2024 08:07:39 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
CC: <almasrymina@google.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Matteo Croce
	<mcroce@microsoft.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	<leonro@nvidia.com>, <gal@nvidia.com>, <stable@vger.kernel.org>, "Anatoli N .
 Chechelnickiy" <Anatoli.Chechelnickiy@m.interpipe.biz>, Ian Kumlien
	<ian.kumlien@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net v3] net: esp: fix bad handling of pages from page_pool
Message-ID: <Zfk5uxupr5ntQui9@gauss3.secunet.de>
References: <20240308152723.831620-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240308152723.831620-1-dtatulea@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 08, 2024 at 05:26:00PM +0200, Dragos Tatulea wrote:
> When the skb is reorganized during esp_output (!esp->inline), the pages
> coming from the original skb fragments are supposed to be released back
> to the system through put_page. But if the skb fragment pages are
> originating from a page_pool, calling put_page on them will trigger a
> page_pool leak which will eventually result in a crash.
> 
> This leak can be easily observed when using CONFIG_DEBUG_VM and doing
> ipsec + gre (non offloaded) forwarding:

..

> The suggested fix is to introduce a new wrapper (skb_page_unref) that
> covers page refcounting for page_pool pages as well.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling")
> Reported-and-tested-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.interpipe.biz>
> Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
> Link: https://lore.kernel.org/netdev/CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Applied to the ipsec tree, thanks a lot!

