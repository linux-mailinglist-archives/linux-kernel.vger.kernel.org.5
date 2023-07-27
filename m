Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0BF765041
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjG0Jsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjG0Jrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58331F2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690451212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9OkPmAayPDeHyXcIMrmOokqY8foYhEAqmOlnJq34vJA=;
        b=YRPRoDTCtwCBtgscYwKZLIKnueEXAMdhIisvEZFEnfAJpClJ6+BAafAloGnsE1Ds5CfxXG
        3Xxv3tpD1ugl4byMtEw2LRe3hlcEczbnR6Freyflah3Fvlq56FoPzT04EB0h7WUhFxUnZf
        TYrs7qZ8Twe7VJGjQbYUf0VS52w5iYg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-veIZmlGNPMKwmPchtccD_g-1; Thu, 27 Jul 2023 05:46:51 -0400
X-MC-Unique: veIZmlGNPMKwmPchtccD_g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5226eaba9e9so450233a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690451210; x=1691056010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OkPmAayPDeHyXcIMrmOokqY8foYhEAqmOlnJq34vJA=;
        b=gkiqTuqCoO1F1QpU4lCT8eZsoXGbK81OFqTwUCC3N/G64Wy+KS5Q7E+rTUwSvMC3y9
         QcAIpM8vtwrTMpfRR+RmUr3rS1fo8lQ9ubtgc9Q1ze8Lha/s7Q8pS3K/sy7W7uvsQwgW
         1tNMtC7Ldey1cun3V4ezBxHka7V7YPAYF73/qHCTSjr+styiRS7PFzlvnqiZpxSGCxxu
         pA4QocP+Lm2XCX52vnnDWKVU34w2VDIFFjoYYwZ8ijn8jpMWbTTyGPaCakdcE4oPiP3I
         w1LhES54ENP6SnK4jh02Wiky4GDl7aXY7zL9i+i+dNbsg+Xjz7iCKoGdtddTMENQ3ZzU
         I49Q==
X-Gm-Message-State: ABy/qLYjUncAXb2vXoXNPlKceCwjIekBIvh4dYqqEdG+T1aPUTuHqnQU
        8tJPEBLB1SxD1mVqIZI+JRMXz0OTvaEOZhNvANkN+GceXWfhivQAZ8cdzdo92tU7EGlSebjKDMw
        73gfmS9FqHs+OlWEF1/mkt2lI
X-Received: by 2002:a05:6402:1489:b0:522:3b94:c6f8 with SMTP id e9-20020a056402148900b005223b94c6f8mr1250127edv.37.1690451210321;
        Thu, 27 Jul 2023 02:46:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHpfTNLuZLnTtrO8TWZKOIkB4YOY++DfnrAeL6F4rjv9p1h9W8it7NG7YKv6G2vviq2+n3zxQ==
X-Received: by 2002:a05:6402:1489:b0:522:3b94:c6f8 with SMTP id e9-20020a056402148900b005223b94c6f8mr1250106edv.37.1690451210017;
        Thu, 27 Jul 2023 02:46:50 -0700 (PDT)
Received: from redhat.com ([2.52.14.22])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7db4a000000b00522584bb58esm436315edt.24.2023.07.27.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 02:46:49 -0700 (PDT)
Date:   Thu, 27 Jul 2023 05:46:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230727054300-mutt-send-email-mst@kernel.org>
References: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
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

On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > They really shouldn't - any NIC that takes forever to
> > program will create issues in the networking stack.
> 
> Unfortunately, it's not rare as the device/cvq could be implemented
> via firmware or software.

Currently that mean one either has sane firmware with a scheduler that
can meet deadlines, or loses ability to report errors back.

> > But if they do they can always set this flag too.
> 
> This may have false negatives and may confuse the management.
> 
> Maybe we can extend the networking core to allow some device specific
> configurations to be done with device specific lock without rtnl. For
> example, split the set_channels to
> 
> pre_set_channels
> set_channels
> post_set_channels
> 
> The device specific part could be done in pre and post without a rtnl lock?
> 
> Thanks


Would the benefit be that errors can be reported to userspace then?
Then maybe.  I think you will have to show how this works for at least
one card besides virtio.


-- 
MST

