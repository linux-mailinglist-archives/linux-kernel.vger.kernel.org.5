Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF1F755EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGQJAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGQJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D650E4F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689584376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mtXqYduDJ86sNZXpe5ttRI8c8039/7D0ISMz4WewRhY=;
        b=MVrQsFalgLwc3NLUWoS/bQJfKUOVjlJEFoKjS8p5dkql6Qo7+yM2L8nsqtz6zj/A+1ddi0
        5TkddpjGvxUEhH8sUlyu2DCKkOErPuJT/h97JcsJFd6pHlqs20h71uS5soa0FJTZNsSJzg
        qz8ZhboXgZC+pMT20m6kkGXQniAd6Gc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-QtxIEI8PNv-26fvFZN0ugQ-1; Mon, 17 Jul 2023 04:59:35 -0400
X-MC-Unique: QtxIEI8PNv-26fvFZN0ugQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-402fa256023so7772191cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689584374; x=1692176374;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtXqYduDJ86sNZXpe5ttRI8c8039/7D0ISMz4WewRhY=;
        b=OM/DN4fkTmqHFYfc3VzTAOaVN8caFpBVIWYC4i2Dby2AhxEg0pDClbJ72+MFk4PXCw
         WZWexdwXXG4vpsK/45Kvb6ACC+6Wm2SqPmcv4ymFY+AyWy6YYEwzyi+GdwQecpXleZlM
         TwrDPzbOmj4Ad3+TKqiFrzB9+QYIKo20WDQTaHkll20wEmqpdV4NC9reWz8+1/KNFfIG
         2c03NhkhHxrc3Ga+CvrDiOoFffbUJupCzTZ1dP/dSOD7R35hpU1jf3d94CubxzBf8sVV
         QWhRKmf9oVpmTgU78hfxMey1O3iynUo0l6nf0rVvnA5DTnoM367qH+1WRHot/kIr8amu
         iYQQ==
X-Gm-Message-State: ABy/qLZ/Zz3CQJMmw88U6Dk1C9TSsVk6G9NWbjoLjsyFhHfYw4+2X96+
        O5X5GZcr/Z8mIDVoauxa6S8s3O75MMKqOyVvYkkDKIHFGs3K4+G4vqqeGljPIHMRvFM6E1qFq4y
        A/ypI1LhFIyFll2+zupGU0LZ6
X-Received: by 2002:a05:622a:145:b0:403:b11f:29f0 with SMTP id v5-20020a05622a014500b00403b11f29f0mr9560773qtw.0.1689584374620;
        Mon, 17 Jul 2023 01:59:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEDBzCxE5MGWmDlOD8i0RgweseOMuYExAuoSDqWkFypJ05Y1jgY243cM02BDogGd3KnGyycaw==
X-Received: by 2002:a05:622a:145:b0:403:b11f:29f0 with SMTP id v5-20020a05622a014500b00403b11f29f0mr9560771qtw.0.1689584374425;
        Mon, 17 Jul 2023 01:59:34 -0700 (PDT)
Received: from dhcp-64-61.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id n11-20020a0cdc8b000000b0062dfdafa0b7sm6245359qvk.136.2023.07.17.01.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 01:59:34 -0700 (PDT)
Message-ID: <aae2f4c3dcd878adb30e8324ca8938de91b79241.camel@redhat.com>
Subject: Re: [PATCH 1/1] xarray: Document necessary flag in alloc-functions
From:   Philipp Stanner <pstanner@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jul 2023 10:59:32 +0200
In-Reply-To: <ZLDZnHY0af4bQqBw@casper.infradead.org>
References: <20230713161712.3163-1-pstanner@redhat.com>
         <ZLDZnHY0af4bQqBw@casper.infradead.org>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 06:14 +0100, Matthew Wilcox wrote:
> On Thu, Jul 13, 2023 at 06:17:11PM +0200, Philipp Stanner wrote:
> > I would pick up the other places where this information has to be
> > added if someone can provide me with a list :)
> 
> I'd suggest every wrapper function that calls __xa_alloc() or
> __xa_alloc_cyclic() needs this same information (I think you caught
> one of the six in the header file?).

Alright, got them. I'll send a follow-up.

But what do you think about __xa_alloc() and __xa_alloc_cyclic()
themselves? They are part of the advanced user API afaik.

P.

