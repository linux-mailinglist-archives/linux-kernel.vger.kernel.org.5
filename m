Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DEC7AD6A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjIYLHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIYLHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BFBDA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695639984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZQRWTolrc1uePhvYxe9aPNX0v4LbfRDKHKl3Z6tC+kg=;
        b=bfsx1q8VW72Oto2Qb4GHvuFFwzmPPi95euIBdE1w7RIuAFhKhByObrY9Rz05Nnl5SOmOdh
        72K32iMtyge4Q4LCJ1aS+LaogL+8Vtkka5N1CO+h6yRrB6Fd7404oizsFj9vJypb5FWlTf
        BQGwyI9qdhwTJaZND23PE40jxVjfMS4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-nkKiDw68MKuVPYxKDbpvLw-1; Mon, 25 Sep 2023 07:06:22 -0400
X-MC-Unique: nkKiDw68MKuVPYxKDbpvLw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32323283257so1546479f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639981; x=1696244781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQRWTolrc1uePhvYxe9aPNX0v4LbfRDKHKl3Z6tC+kg=;
        b=FGs8jC1PIFPI33abh7O8MgJdwSAuo+y3cjVevrQBXhD+tvcQAFYaWC/8LXAhT+8VNF
         JXM4xf1jFJ59TKlDCfn2MljSB/zR7TMmdsxdMbawbB9BkvMVir3fUtPwDbDrYJ2KMM4I
         yYt6RoAn6tpMIWGEXrHiqQ6K4SltqcAVR0L1Xt6KoUlY0rYEkN5ytMLCDv1LXovzPq1Q
         eRb/utOrfWZn4aDk7G/1vPVfmH8yUBhV4LNgO3m3sn7BbC/AL07ngXuTmBD+dSTUpPqO
         zKw9Ro3BX4waZhOj6WIkdmaSh/7wFSB0UXLFyEi4weeb0k6Bf3kHsN5FwAdxFL5uSVEi
         8u6g==
X-Gm-Message-State: AOJu0YwJv/POXdXzTcuQObC2DiXW7OnUhvhrZ3Bhw4xEUZEwrQhs0lQI
        iXxdXQYBg6FFioFeg518OxZEz64SHEoNT75OJVIKk2rNwg8fJh62nfvdQN6Aq4mw1l3kh9Fdtlh
        sbHl/4EqtQhLky7UlZ9ZT3JhN
X-Received: by 2002:adf:f68d:0:b0:320:16b:167d with SMTP id v13-20020adff68d000000b00320016b167dmr6027677wrp.63.1695639981765;
        Mon, 25 Sep 2023 04:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3lAC4ITmJN1cbZviSsIr7upH20AuX9eMFgek6yDvi8V904h35Q6YFoYgDWz4VY9q0pBgnbA==
X-Received: by 2002:adf:f68d:0:b0:320:16b:167d with SMTP id v13-20020adff68d000000b00320016b167dmr6027663wrp.63.1695639981450;
        Mon, 25 Sep 2023 04:06:21 -0700 (PDT)
Received: from debian (2a01cb058d23d6002541150e39af35f7.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:2541:150e:39af:35f7])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b003fee567235bsm2424660wmj.1.2023.09.25.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:06:20 -0700 (PDT)
Date:   Mon, 25 Sep 2023 13:06:18 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Beniamino Galvani <b.galvani@gmail.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: mark address parameters of
 udp_tunnel6_xmit_skb() as const
Message-ID: <ZRFpquxdCJdTtcHT@debian>
References: <20230924153014.786962-1-b.galvani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924153014.786962-1-b.galvani@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 05:30:14PM +0200, Beniamino Galvani wrote:
> The function doesn't modify the addresses passed as input, mark them
> as 'const' to make that clear.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

