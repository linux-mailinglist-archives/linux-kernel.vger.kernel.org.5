Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E57763F93
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGZT3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjGZT24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F482D49
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690399693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBYGyYK0iPA4MuO4cjNy8AeihMzqvoyBhSpsNQnELVQ=;
        b=VPzFiWGNNx4E9VADiHk2tcll/njAlJLYNdlaRbhozBPMN+k+00CUemjKBVcL2gtXemWdsB
        xRIpfsz+hAoc7/DmjPKbHUEnEeRPOe7XBZxK8cvDt5+fL2pIjCXLHmuNbClvcD6HLbf27/
        NqsTi2KURYn2S2OO0eU/3HYYFcTXhbM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-8ezfWk8QN-i168DoqqdJbw-1; Wed, 26 Jul 2023 15:28:12 -0400
X-MC-Unique: 8ezfWk8QN-i168DoqqdJbw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993c2d9e496so3263066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690399691; x=1691004491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBYGyYK0iPA4MuO4cjNy8AeihMzqvoyBhSpsNQnELVQ=;
        b=UdzSD/0glEIrFpaJjWRe27etC/MpcEvXmPu+TwB1CBJu7SN3idYaXvWmLXbQETKhlk
         WmL1VGJDB/oO3rB59koYJusadZTIuaQsJcEUOFBjoW/iL/chf2OytumZF+uqoFG2tPWO
         2N+hGRtxagCOqA+0dW39JEbrlhUTO2xQC79nYHpydIbQ7ZJKd35Xd34fQVF8pNVlcgnz
         VKNNvajLA1HWSOBv2jpCxbRNllVbb0eCQl7RIhcFHMjdJIdXdw+BurQKSDPC2Vh7Ic88
         xDj217Ts5AJgjVzd1Ym3rAMGknVLptvdZgTTXGr7/HrHrie8xjN6jTCybhI0mtJyOyxg
         QerA==
X-Gm-Message-State: ABy/qLbeDaNp4KDgY19De7zNVFTJYs5tAzywTIxR6zjdOoJzE5poq/B4
        z/eHxwoD0M6ovMJSQPzgx5vQsTrUotCdZQ1bS3pjizmLPxS2F6kM1JD4Pd/rDR+nd2VKok7ZMug
        TucLSTc1WzzPkJ9CvSo2ReJI9TdlAL2IN
X-Received: by 2002:a17:906:73d2:b0:977:4b64:f5e8 with SMTP id n18-20020a17090673d200b009774b64f5e8mr77237ejl.57.1690399691107;
        Wed, 26 Jul 2023 12:28:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEB3K6JMck1ac1f464TqyfWgTHbDN5xtNZOdH/v6uERGyDJNp7Z+YZYwiz0Y8OJmkArTNaWxg==
X-Received: by 2002:a17:906:73d2:b0:977:4b64:f5e8 with SMTP id n18-20020a17090673d200b009774b64f5e8mr77230ejl.57.1690399690832;
        Wed, 26 Jul 2023 12:28:10 -0700 (PDT)
Received: from redhat.com ([2.52.14.22])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906049500b0099364d9f0e9sm9932603eja.102.2023.07.26.12.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:28:08 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:28:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>,
        "linma@zju.edu.cn" <linma@zju.edu.cn>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 0/2] vdpa: Enable strict validation for netlink ops
Message-ID: <20230726152719-mutt-send-email-mst@kernel.org>
References: <20230726183054.10761-1-dtatulea@nvidia.com>
 <20230726143640-mutt-send-email-mst@kernel.org>
 <8a97e0d439d74373605b00dcaef91108ced9e5ee.camel@nvidia.com>
 <22afb03057250ab8d37ab977cd210719ecf0bcd1.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22afb03057250ab8d37ab977cd210719ecf0bcd1.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:23:50PM +0000, Dragos Tatulea wrote:
> On Wed, 2023-07-26 at 20:56 +0200, Dragos Tatulea wrote:
> > On Wed, 2023-07-26 at 14:36 -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jul 26, 2023 at 09:30:48PM +0300, Dragos Tatulea wrote:
> > > > The original patch from Lin Ma enables the vdpa driver to use validation
> > > > netlink ops.
> > > > 
> > > > The second patch simply disables the validation skip which is no longer
> > > > neccesary. Patchset started of from this discussion [0].
> > > > 
> > > > [0]
> > > > https://lore.kernel.org/virtualization/20230726074710-mutt-send-email-mst@kernel.org/T/#t
> > > 
> > > Cc stable with at least 1/2 ?
> > > 
> > Sent a v2 with stable in cc. But looks like 1/2 breaks the "fix one thing
> > only"
> > rule due to the many Fixes tags I guess...

I think it's ok.

> Or my lack of understanding: I only now realize that "Cc: stable" is a tag in
> the patch. My bad. Will re-send.

you also need v2 on subject of each patch.

> > > > Dragos Tatulea (1):
> > > >   vdpa: Enable strict validation for netlinks ops
> > > > 
> > > > Lin Ma (1):
> > > >   vdpa: Complement vdpa_nl_policy for nlattr length check
> > > > 
> > > >  drivers/vdpa/vdpa.c | 9 +++------
> > > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > > 
> > > > -- 
> > > > 2.41.0
> > > 
> > 
> 

