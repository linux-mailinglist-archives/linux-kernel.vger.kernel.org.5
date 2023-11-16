Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE97EE16A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345194AbjKPNUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjKPNUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:20:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9828F1A5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700140801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GPkDPAa9DjBPZECLFiqpzdyylbq5Vs56hlKHGZVc4Zg=;
        b=Tmrk87ruF11yQKlVjx4W8CyCw5x1v44M04G0Dt6+f2NCY5HQNs9Mf54TvYO5piraup+VQf
        nm5g1wAc0vjcMByso6MqD7M6SAcmFtc6/buffzTugmZouNVtnmn8maCYs2v5e4r6TPTD2T
        LH8/C73/WedVuwTuB27fGiPJcXPjO/c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-7eREEjJ2Md-PE368AY0R1w-1; Thu, 16 Nov 2023 08:19:57 -0500
X-MC-Unique: 7eREEjJ2Md-PE368AY0R1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15356932D2C;
        Thu, 16 Nov 2023 13:19:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id 629EF1121309;
        Thu, 16 Nov 2023 13:19:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 16 Nov 2023 14:18:53 +0100 (CET)
Date:   Thu, 16 Nov 2023 14:18:49 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231116131849.GA27763@redhat.com>
References: <20231027095842.GA30868@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027095842.GA30868@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David, Al,

So do you agree that

	- the usage of read_seqbegin_or_lock/need_seqretry in
	  this code makes no sense because read_seqlock_excl()
	  is not possible

	- this patch doesn't change the current behaviour but
	  simplifies the code and makes it more clear

?

On 10/27, Oleg Nesterov wrote:
>
> read_seqbegin_or_lock() makes no sense unless you make "seq" odd
> after the lockless access failed. See thread_group_cputime() as
> an example, note that it does nextseq = 1 for the 2nd round.
> 
> So this code can use read_seqbegin() without changing the current
> behaviour.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  net/rxrpc/conn_service.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/net/rxrpc/conn_service.c b/net/rxrpc/conn_service.c
> index 89ac05a711a4..bfafe58681d9 100644
> --- a/net/rxrpc/conn_service.c
> +++ b/net/rxrpc/conn_service.c
> @@ -25,7 +25,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
>  	struct rxrpc_conn_proto k;
>  	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
>  	struct rb_node *p;
> -	unsigned int seq = 0;
> +	unsigned int seq;
>  
>  	k.epoch	= sp->hdr.epoch;
>  	k.cid	= sp->hdr.cid & RXRPC_CIDMASK;
> @@ -35,7 +35,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
>  		 * under just the RCU read lock, so we have to check for
>  		 * changes.
>  		 */
> -		read_seqbegin_or_lock(&peer->service_conn_lock, &seq);
> +		seq = read_seqbegin(&peer->service_conn_lock);
>  
>  		p = rcu_dereference_raw(peer->service_conns.rb_node);
>  		while (p) {
> @@ -49,9 +49,8 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
>  				break;
>  			conn = NULL;
>  		}
> -	} while (need_seqretry(&peer->service_conn_lock, seq));
> +	} while (read_seqretry(&peer->service_conn_lock, seq));
>  
> -	done_seqretry(&peer->service_conn_lock, seq);
>  	_leave(" = %d", conn ? conn->debug_id : -1);
>  	return conn;
>  }
> -- 
> 2.25.1.362.g51ebf55
> 

