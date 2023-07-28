Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FD47663C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjG1Fr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjG1Frj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE23AAF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690523192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sMwD0drsqajj2gsdvqQy67JhYI7KDBbsBKbn31rEdKA=;
        b=Tgc/vJzgNfU6leae3smGMMCbM0ZG4bzCDe+7Hk2fy3LAtn/XUXAG5F+8W+0E3pvBe/vMbM
        KKVgffbjwzH2yqU3U4sRMzx9FvugNSYqQEYB7zoWGqKmGU4bN+hCXBHajAJ+DA+QadDb+2
        idxlNBbdTlghYuHr/p6jneVu4OzLmt0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-A-K89dZaNheq-qUnWNODXA-1; Fri, 28 Jul 2023 01:46:29 -0400
X-MC-Unique: A-K89dZaNheq-qUnWNODXA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-52291e49dbcso1038736a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690523189; x=1691127989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMwD0drsqajj2gsdvqQy67JhYI7KDBbsBKbn31rEdKA=;
        b=Y3QlUDh1QAF9pU0xzJNanKod+yYgX0DQvFQ0NPQ7Fd1W5Ydgp8fQViJ9bd5xFfsTfM
         ggwOmcD5qKl48dhBeMlCCuMAci8cGkHZEj2S81nsQZ/DqIbC76dshTAhUsFR2m60yXE+
         fVI0Kz29mqdS9X+IZZGaqdDQntf/si61TvX/KjhDvRvXEnlQ8YRUOz3AVDhcE5/cA7nK
         AjqUyzcwKrig5kG7CDoeCm7hph86rdFi3mS1nOGS1kSDW2yG6AQLqLrhO7YvI8StM2/D
         sa2y+nwF9OURa5Fl2MKzLeW1RTZsjRdr8UoFECdfB0tG0vwpmJWmt9ag092VI5SflRU0
         /Nvw==
X-Gm-Message-State: ABy/qLYJxek5EY7Qs8uqYL2qzI2++9eFv01EOwWtQw/Y/hLcgh+DY+a4
        bJKqX/9UsRSe4JRJi4kXlnlfFPpTkIltbvY/LKRlEOcBaQhX11Y6HMj4VhLNqvZzxADGo3EskF6
        bm7688hkagg+7P7Bn+ejoztUm
X-Received: by 2002:a05:6402:64a:b0:522:38f9:e653 with SMTP id u10-20020a056402064a00b0052238f9e653mr925606edx.30.1690523188869;
        Thu, 27 Jul 2023 22:46:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFwNX2G2yaLNlyBnSQngMGgFCKafl26b6p6i9OLIBTwmvo9JWC9mtmTi/aUFyCJtgfKzLDHvA==
X-Received: by 2002:a05:6402:64a:b0:522:38f9:e653 with SMTP id u10-20020a056402064a00b0052238f9e653mr925594edx.30.1690523188591;
        Thu, 27 Jul 2023 22:46:28 -0700 (PDT)
Received: from redhat.com ([2.52.14.22])
        by smtp.gmail.com with ESMTPSA id h2-20020aa7c602000000b00522536c2e6esm1419837edq.38.2023.07.27.22.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:46:27 -0700 (PDT)
Date:   Fri, 28 Jul 2023 01:46:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Gavin Li <gavinl@nvidia.com>, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        jiri@nvidia.com, dtatulea@nvidia.com, gavi@nvidia.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
Message-ID: <20230728014601-mutt-send-email-mst@kernel.org>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
 <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 03:28:32PM +0200, Paolo Abeni wrote:
> On Tue, 2023-07-25 at 16:07 +0300, Gavin Li wrote:
> > Add interrupt_coalesce config in send_queue and receive_queue to cache user
> > config.
> > 
> > Send per virtqueue interrupt moderation config to underlying device in
> > order to have more efficient interrupt moderation and cpu utilization of
> > guest VM.
> > 
> > Additionally, address all the VQs when updating the global configuration,
> > as now the individual VQs configuration can diverge from the global
> > configuration.
> > 
> > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> FTR, this patch is significantly different from the version previously
> acked/reviewed, I'm unsure if all the reviewers are ok with the new
> one.
> 
> [...]

still ok by me

Acked-by: Michael S. Tsirkin <mst@redhat.com>

let's wait for Jason too.

> >  static int virtnet_set_coalesce(struct net_device *dev,
> >  				struct ethtool_coalesce *ec,
> >  				struct kernel_ethtool_coalesce *kernel_coal,
> >  				struct netlink_ext_ack *extack)
> >  {
> >  	struct virtnet_info *vi = netdev_priv(dev);
> > -	int ret, i, napi_weight;
> > +	int ret, queue_number, napi_weight;
> >  	bool update_napi = false;
> >  
> >  	/* Can't change NAPI weight if the link is up */
> >  	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> > -	if (napi_weight ^ vi->sq[0].napi.weight) {
> > -		if (dev->flags & IFF_UP)
> > -			return -EBUSY;
> > -		else
> > -			update_napi = true;
> > +	for (queue_number = 0; queue_number < vi->max_queue_pairs; queue_number++) {
> > +		ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
> > +						      vi->sq[queue_number].napi.weight,
> > +						      &update_napi);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (update_napi) {
> > +			/* All queues that belong to [queue_number, queue_count] will be
> > +			 * updated for the sake of simplicity, which might not be necessary
> 
> It looks like the comment above still refers to the old code. Should
> be:
> 	[queue_number, vi->max_queue_pairs]
> 			
> Otherwise LGTM, thanks!
> 
> Paolo

