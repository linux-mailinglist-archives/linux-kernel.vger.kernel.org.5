Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076177654F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjG0N3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjG0N3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957A1271F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690464519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRXsOUJMOHDEoSqPt6aYSJsJvljvQhH7ysfJpGE7U3I=;
        b=adbxNoddsqfTGc0xL/cyuds7xFatPIP9nuSPSiCLOxXbBBsxS/wO3I36+qebuEhsZJgIlH
        Vr6U/OWLYdke89VJBk2h4S0BPLhN+5z44RstEaLTV1b3jbPt01IHJi84GVBfQkKhUBW/B8
        jKhXDKzkGghEGE/pjlv2ESYts9DxB+8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Xs4m4sY0Ng-dvc6blSU6Aw-1; Thu, 27 Jul 2023 09:28:37 -0400
X-MC-Unique: Xs4m4sY0Ng-dvc6blSU6Aw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-767edbf73cbso21157885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690464517; x=1691069317;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRXsOUJMOHDEoSqPt6aYSJsJvljvQhH7ysfJpGE7U3I=;
        b=Ir0b7LBgClzXUZVPfGkINv6oIc/2BbKmtC85EBClgHiYOYNYqebZyqYqF7mm/qDRkv
         uo9nQIopIYs6tLRwkq72Phos0fNdyV1lKrNuIRGNxchhDDlcADjbY2eovNWOUwoKBSF1
         PjY8hd4TduvBUZuds8+mwFzZhcwYfPoMt8e3vQbShEVCjk5PVIADB5NFS5MN0aHsz+eT
         GL07RkHpQ8uKgVcW6Djn4Nei4fR1vJ6zhuTEhf3sJ2d0gEEZiPtBwoZ53IUMOJtx6+pY
         82g+zzE7vhOAaARvVTcqEy3yKh4YhkMHITFp6st4zPbIPHfAyCpq3igtPIT9yCJ0s2E1
         pQjg==
X-Gm-Message-State: ABy/qLbHk+IcDHNG2YD8ZKKfGsd80uYkqoZnniA1jdfUX4rJ2E/e55NV
        cD66EkMWPGLuEJiCE/IHobacc7Mdy9fURocha8d6XCLAIwgT3shxiFMu93PrBtCSDmazWRD920q
        Ki5dXVG4XPCCCwP7Th5iEsVHZ
X-Received: by 2002:a05:620a:318f:b0:765:a957:f526 with SMTP id bi15-20020a05620a318f00b00765a957f526mr5530685qkb.3.1690464517503;
        Thu, 27 Jul 2023 06:28:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHSS1sj3ooFLxDH7GaJepQJ5naZSQaFVoxc5DBSu1lp42qGgOiczSwad8h1rf/0DMO/8MK1BQ==
X-Received: by 2002:a05:620a:318f:b0:765:a957:f526 with SMTP id bi15-20020a05620a318f00b00765a957f526mr5530665qkb.3.1690464517246;
        Thu, 27 Jul 2023 06:28:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-55.dyn.eolo.it. [146.241.238.55])
        by smtp.gmail.com with ESMTPSA id b4-20020a05620a126400b00767dafbf282sm411683qkl.12.2023.07.27.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:28:36 -0700 (PDT)
Message-ID: <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
From:   Paolo Abeni <pabeni@redhat.com>
To:     Gavin Li <gavinl@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        jiri@nvidia.com, dtatulea@nvidia.com
Cc:     gavi@nvidia.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Heng Qi <hengqi@linux.alibaba.com>
Date:   Thu, 27 Jul 2023 15:28:32 +0200
In-Reply-To: <20230725130709.58207-3-gavinl@nvidia.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
         <20230725130709.58207-3-gavinl@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-25 at 16:07 +0300, Gavin Li wrote:
> Add interrupt_coalesce config in send_queue and receive_queue to cache us=
er
> config.
>=20
> Send per virtqueue interrupt moderation config to underlying device in
> order to have more efficient interrupt moderation and cpu utilization of
> guest VM.
>=20
> Additionally, address all the VQs when updating the global configuration,
> as now the individual VQs configuration can diverge from the global
> configuration.
>=20
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

FTR, this patch is significantly different from the version previously
acked/reviewed, I'm unsure if all the reviewers are ok with the new
one.

[...]

>  static int virtnet_set_coalesce(struct net_device *dev,
>  				struct ethtool_coalesce *ec,
>  				struct kernel_ethtool_coalesce *kernel_coal,
>  				struct netlink_ext_ack *extack)
>  {
>  	struct virtnet_info *vi =3D netdev_priv(dev);
> -	int ret, i, napi_weight;
> +	int ret, queue_number, napi_weight;
>  	bool update_napi =3D false;
> =20
>  	/* Can't change NAPI weight if the link is up */
>  	napi_weight =3D ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> -	if (napi_weight ^ vi->sq[0].napi.weight) {
> -		if (dev->flags & IFF_UP)
> -			return -EBUSY;
> -		else
> -			update_napi =3D true;
> +	for (queue_number =3D 0; queue_number < vi->max_queue_pairs; queue_numb=
er++) {
> +		ret =3D virtnet_should_update_vq_weight(dev->flags, napi_weight,
> +						      vi->sq[queue_number].napi.weight,
> +						      &update_napi);
> +		if (ret)
> +			return ret;
> +
> +		if (update_napi) {
> +			/* All queues that belong to [queue_number, queue_count] will be
> +			 * updated for the sake of simplicity, which might not be necessary

It looks like the comment above still refers to the old code. Should
be:
	[queue_number, vi->max_queue_pairs]
		=09
Otherwise LGTM, thanks!

Paolo

