Return-Path: <linux-kernel+bounces-162485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 720088B5BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E138B26CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761968172D;
	Mon, 29 Apr 2024 14:49:44 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D30811F2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402184; cv=none; b=iQl7YGlj8Nzsw3K7s7AdlSXH//0ewDo0vwEHdzRPxKQFchQ7WPIr1o1v/IoclEHQ/bAvwWEB94YwwC9l4m4ZIsdd+NV+Vx//kcYvdfUEqzJQvhYouZQKCyRedBGOccKNN7hJM6AKbgUIQICeVfsUa6IdFnw88q8+9ITuPvqmhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402184; c=relaxed/simple;
	bh=FJs8eokBGMHjIH+cHsG71Fq5VDtHzRLCp+Jo7EBuRfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMDLm+L8eKcaoJRO1+NkeOFaoTjzV2AmAoukE6+DrOdAThNoaT707PBNqEw90W57GSk1Ywqa73ypOgOcZ4U2jrUNb807I0XjWX2kQeZgYV0V7hplWlMQr77T6QvrfkA+sYivapvu9NQkw9QG3jxrR2lr2Gqfv1jHaBlUE9Nbwq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-XjvN4SeQPm-Ibx1LHUbIvQ-1; Mon,
 29 Apr 2024 10:49:31 -0400
X-MC-Unique: XjvN4SeQPm-Ibx1LHUbIvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10FF4380390A;
	Mon, 29 Apr 2024 14:49:29 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AD66D2166B32;
	Mon, 29 Apr 2024 14:49:19 +0000 (UTC)
Date: Mon, 29 Apr 2024 16:49:18 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Joel Granados <j.granados@samsung.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
	Joerg Reuter <jreuter@yaina.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dccp@vger.kernel.org,
	linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
	linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	lvs-devel@vger.kernel.org
Subject: Re: [PATCH v5 1/8] net: Remove the now superfluous sentinel elements
 from ctl_table array
Message-ID: <Zi-zbrq43dnlsQBY@hog>
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
 <20240426-jag-sysctl_remset_net-v5-1-e3b12f6111a6@samsung.com>
 <CGME20240429085414eucas1p11b3790e4687b8dc8ef02fe0f54bc9c55@eucas1p1.samsung.com>
 <Zi9gG82_OKnLlFI2@hog>
 <20240429123315.og27yehofzz6cui3@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429123315.og27yehofzz6cui3@joelS2.panther.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

2024-04-29, 14:33:15 +0200, Joel Granados wrote:
> On Mon, Apr 29, 2024 at 10:53:47AM +0200, Sabrina Dubroca wrote:
> > 2024-04-26, 12:46:53 +0200, Joel Granados via B4 Relay wrote:
> > > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > > index 6973dda3abda..a84690b13bb9 100644
> > > --- a/net/core/sysctl_net_core.c
> > > +++ b/net/core/sysctl_net_core.c
> > [...]
> > > @@ -723,12 +722,11 @@ static __net_init int sysctl_core_net_init(struct net *net)
> > >  		if (tbl == NULL)
> > >  			goto err_dup;
> > >  
> > > -		for (tmp = tbl; tmp->procname; tmp++)
> > > -			tmp->data += (char *)net - (char *)&init_net;
> > 
> > Some coding style nits in case you re-post:
> Thx. I will, so please scream if you see more issues.

I've gone through the whole series and didn't see anything more.

> > > +		for (int i = 0; i < table_size; ++i)
> > 
> > move the declaration of int i out of the for (), it's almost never
> > written this way (at least in networking)
> done
> 
> > 
> > > +			(tbl + i)->data += (char *)net - (char *)&init_net;
> > 
> >                         tbl[i].data = ...
> > 
> > is more in line with other similar functions in the rest of net/
> done
> 
> > 
> > 
> > [...]
> > > diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> > > index 6dab883a08dd..ecc849678e7b 100644
> > > --- a/net/mpls/af_mpls.c
> > > +++ b/net/mpls/af_mpls.c
> > [...]
> > > @@ -2674,6 +2673,7 @@ static const struct ctl_table mpls_table[] = {
> > >  
> > >  static int mpls_net_init(struct net *net)
> > >  {
> > > +	size_t table_size = ARRAY_SIZE(mpls_table);
> > 
> > This table still has a {} as its final element. It should be gone too?
> Now, how did that get away?  I'll run my coccinelle scripts once more to
> make sure that I don't have more of these hiding in the shadows.

I didn't spot any other with a dumb

    sed -n '<line>,^};/p' <file>

(with file/line produced by git grep 'struct ctl_table' -- net)


Thanks.

-- 
Sabrina


