Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73AC79E150
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbjIMH7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbjIMH7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:59:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1155198A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:58:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31f8a05aa24so4306729f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694591937; x=1695196737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkdGZYQrwA4ll/7xTuDvjPfd4MTlNtu+sDVCgPZq2hM=;
        b=fDj6Pg+QybGFCjKOebH0swOZ+enPGTuJmqrxMxg9BozYR2t35AEvdUCMHsIqzGNHma
         Kj53e6YM3/CfYAz/G7lLIGUFDWdZ7h5h7vRaUbbu2vxs6CwLV1h2mB8YjPxiCFSJfnRC
         1kuwY1nwWyw7OHUZrYms+gK6x1Oe8GsTsu+lxmWhLTvZvKbQnH/TTqlTIsBGc7VK8WCd
         BYXIKxQ1tBBBF8B9oZGtjcoPMfRzIIS1d/luKYyKQbsjdk8lEpyHY3KNNrGQ8SVHcVqS
         oIG352Hi9ueyP1KkVwm5WLcYxjEQUulQR71iDxHVTSln/ciuqd6B75e0pgDdpMGie4Yj
         5+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591937; x=1695196737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkdGZYQrwA4ll/7xTuDvjPfd4MTlNtu+sDVCgPZq2hM=;
        b=BdwWqhda6eaMaXRoJhk4Zq2T5Z9jDa4k0Zx36/y2JjHxdc2MH+5EedU+kS4XerSoSK
         NVKcFvHqQu0E7EYSpmZ1nnGHkrf3ECkSVpAbkNBJSRGRqGiT0AVGiPL0iP5a6w7ZJeNw
         q9hre3PHOusDGtWuuCf1CDszi5VG4VLbmP9BtnM9lXgKJxy0vmIF7l6fzOuNeJ036BTW
         86t67DlzC5KLfHmRz8ozX4s7pnUQzOkkFzhO94WndAqryGDORf5tYoVCndKq4sglhRFP
         odsELO9wr36irUanRfd7qxl6zAfatdrY+GvvkPDH3GvYjomTyO9V1gJy3TS31fVN+mXl
         /+pQ==
X-Gm-Message-State: AOJu0YyLt8+bDhofH8h5cJjOr4g2eRcXP1zIMahiqgxFNKCq5Wsjwwq2
        wOIkGKGX8HxGXQiwzy7ioUfnug==
X-Google-Smtp-Source: AGHT+IEXU002BF4gZvckDLmB/m507XPZeHi5Or79qEm1/eb14IbkNOzOzkoHnUocfn03vmeh+czvxg==
X-Received: by 2002:adf:f782:0:b0:31a:d551:c2c9 with SMTP id q2-20020adff782000000b0031ad551c2c9mr1382336wrp.6.1694591937140;
        Wed, 13 Sep 2023 00:58:57 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id y18-20020adfd092000000b003179d5aee67sm14854979wrh.94.2023.09.13.00.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:58:56 -0700 (PDT)
Date:   Wed, 13 Sep 2023 09:58:55 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Roger Quadros <rogerq@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti: icssg-prueth: add PTP dependency
Message-ID: <ZQFrv4W70ijXWTFZ@nanopsycho>
References: <20230912185509.2430563-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912185509.2430563-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Sep 12, 2023 at 08:54:51PM CEST, arnd@kernel.org wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>The driver can now use PTP if enabled but fails to link built-in
>if PTP is a loadable module:
>
>aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_get_ptp_clock_idx':
>icss_iep.c:(.text+0x200): undefined reference to `ptp_clock_index'
>
>Add the usual dependency to avoid this.
>
>Fixes: 186734c158865 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
