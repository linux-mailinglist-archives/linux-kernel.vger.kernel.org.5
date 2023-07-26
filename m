Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03EE763EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjGZShz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGZShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E44C19BA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690396626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIAg2CLp9xDuIJyXx/zxbXpSOXSxiP7iZoyT0IErBLI=;
        b=frgcLyLF83l4Brb6PiGToei9WF0C33sh0m0jFSWKx7ZAkOz+TZ75727zqF8ptZy4utaTWe
        0mKoLHlYapHwxO01ThzwPLA9MzttdRkEnmgAskPKH79Lo5GSixOS65lkD1RuA25zbN5Qh2
        7NgrN0iDybMpYzEGj2kxMf+HlhrB3Jk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-qqzHvnTSMaW_79tybaXCKQ-1; Wed, 26 Jul 2023 14:37:05 -0400
X-MC-Unique: qqzHvnTSMaW_79tybaXCKQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fc0855dcc5so226765e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690396624; x=1691001424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIAg2CLp9xDuIJyXx/zxbXpSOXSxiP7iZoyT0IErBLI=;
        b=l2MKQvfOkfBwJoY3u1QGBF302KAxNKdQN2KEwBTUTEtY7eIRTVWfQ59nu1511LVLSi
         prYOvNWuTiTDBEmNEw0J1Ef/3CjomOy9/QvuAPtb670XgNwsit0wWd1/pFkEKBEI6UxT
         2gmmjlN8ksCzLHPxBwoGZ4wbVmkwFZx8KVuklbkvISTgSmfdYcb+NGcCGc1m0ASG7d8h
         ViiV8wyBZRNrZJ6w3iqR9LmZiuglq6/hcJ0L0p7EP3t9OkZk/1lcJjHbERFieGYFrjq6
         7aBM8oewdxVmUZSIMTzr3zfOI6M0FRItN164eqRVYeErKQdZP10r5v04uDxvc6dtiO3i
         d/pA==
X-Gm-Message-State: ABy/qLZCrryc1H4ocJA9XDtkRmu3R2Yl560nQbfRNkwai6ZkrRn/b2jk
        HuN0bJxVusQrdEbKeMjUDPM91NPloD7eQntJdFg+LPWv4OegorkiutNEbC4+XXTMRsjGbETb9hk
        0IWp33ThF1GdeAzehEJp5oVXdQBw+Uw8q
X-Received: by 2002:a5d:65d1:0:b0:317:5ed4:d821 with SMTP id e17-20020a5d65d1000000b003175ed4d821mr2198620wrw.55.1690396623962;
        Wed, 26 Jul 2023 11:37:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEkeVse3g7BMmMqZZpW4iVmRF/VxccwoNYoG2x1Cq2HpC5/SgntUwQLeTxvRJYedmVt4ctsxA==
X-Received: by 2002:a5d:65d1:0:b0:317:5ed4:d821 with SMTP id e17-20020a5d65d1000000b003175ed4d821mr2198606wrw.55.1690396623611;
        Wed, 26 Jul 2023 11:37:03 -0700 (PDT)
Received: from redhat.com ([2.52.14.22])
        by smtp.gmail.com with ESMTPSA id s25-20020a056402165900b0052229d203a4sm4971784edx.36.2023.07.26.11.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:37:01 -0700 (PDT)
Date:   Wed, 26 Jul 2023 14:36:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     Lin Ma <linma@zju.edu.cn>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] vdpa: Enable strict validation for netlink ops
Message-ID: <20230726143640-mutt-send-email-mst@kernel.org>
References: <20230726183054.10761-1-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726183054.10761-1-dtatulea@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:30:48PM +0300, Dragos Tatulea wrote:
> The original patch from Lin Ma enables the vdpa driver to use validation
> netlink ops.
> 
> The second patch simply disables the validation skip which is no longer
> neccesary. Patchset started of from this discussion [0].
> 
> [0] https://lore.kernel.org/virtualization/20230726074710-mutt-send-email-mst@kernel.org/T/#t

Cc stable with at least 1/2 ?

> Dragos Tatulea (1):
>   vdpa: Enable strict validation for netlinks ops
> 
> Lin Ma (1):
>   vdpa: Complement vdpa_nl_policy for nlattr length check
> 
>  drivers/vdpa/vdpa.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> -- 
> 2.41.0

