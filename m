Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13FB7FE97F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbjK3HHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbjK3HHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:07:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223541AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:07:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3331974c2ceso421409f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701328033; x=1701932833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b40oxQ+wmHnSlp41pNqOqa3g1K/uTJG2aa8xGLZb6s0=;
        b=rygvXX1YaV06cYQeIEHJ0VukGKKA0jGnDC3T46L1ZixnlitJs38nnRA/sJ7nGwOTBW
         gA9QZP8wSRYKCrWndsEaWwSTAmmxj/tZiHis+38EDhAEAFJv37TJeIxTqvePx41Dtgo3
         W2LvUaiNBpX+TX5NN1oWxzew3HSiFnEInhOneNyHGSDfoVWdT1cWfjl0ZotmQtAjm8Uv
         mpyFgAK1ZN4RvAlL88C6y3oVC404QxaFChLYKDSL4ChOjXywpELaAKLGIPs8KiACNFEw
         4Fw7c1qV8SNSLMsxRbLrYRYUtzLjCXYf4dO9Ke1/DBxL159Go9y7fQg4ozQt54o8X2mO
         0l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701328033; x=1701932833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b40oxQ+wmHnSlp41pNqOqa3g1K/uTJG2aa8xGLZb6s0=;
        b=VrZJreMWcEFmrRK3ETmBCFWGkBH+QFehCfcI2uxbwcmgaC7hhLQXV4oLt1ahbh7ahC
         Z3uQ3xHT/KcrpCYUxpoBbtmt12rSM6atfIhRLTF5hfMvQ+IjqF2qFwLXzBXOEZ2X+IJf
         bSfBSLTbHUauBmoH05Lz0ylPwxwvm2p6Fd3T9O6X93peGLKZWm9MaWzLeJXxuMZhwHKj
         2Fnql+7pnSasB7R1L+zcMEFdTeFv2zuM1BFza/DQVlYUvo8ss9hy+9K3s75aW3eNwpFS
         eKfoYsfXDX/FnZCdT7/gnZvKsPbjqUG5p/eT5y4Wggn7AdluNUk1qZy6VHoIZXdbnrnF
         esGA==
X-Gm-Message-State: AOJu0YzJkzAAW/BU2vfJjlUtIXLqWlSz9/CtHclW2Hz6V3V/WFbkljbW
        SUOTkhNkeDVFZ77c2/oEi9Qc4Q==
X-Google-Smtp-Source: AGHT+IFMC/oISgA6XE2T/E0Kbo4/fdoMZnlzwwiV0IXTByHlCrphi5wYAZzs7gYuX7enrHIzViEzBg==
X-Received: by 2002:a5d:480b:0:b0:332:f83b:e5e with SMTP id l11-20020a5d480b000000b00332f83b0e5emr11415160wrq.9.1701328033317;
        Wed, 29 Nov 2023 23:07:13 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d4751000000b00332f82265b7sm649576wrs.20.2023.11.29.23.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:07:12 -0800 (PST)
Date:   Thu, 30 Nov 2023 10:07:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
        gost.dev@samsung.com, nitheshshetty@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: Update type from size_t to u16 for
 opts->queue_size
Message-ID: <74306015-9e99-4703-b578-1d235dc725d5@suswa.mountain>
References: <CGME20231128123622epcas5p4940679fbbafdf0da802deea3e531f850@epcas5p4.samsung.com>
 <20231128122958.2235-1-nj.shetty@samsung.com>
 <0cd6862e-8037-40b3-9fde-b7f10d66e31c@suswa.mountain>
 <20231129104837.arls2gn3wttiqiff@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129104837.arls2gn3wttiqiff@green245>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:18:37PM +0530, Nitesh Shetty wrote:
> Thank you for this insight.
> I ran smatch on complete kernel using smatch's test_kernel.sh
> I was unaware of this smbd.py option. I will explore this.

The ./smatch_scripts/build_kernel_data.sh command creates the cross
function db.  It takes a while though.  And it's probably better to
run it a few times because every time you run it the call tree chains
get one call longer.  I run it every night against the latest
linux-next.

> Meanwhile I feel this patch is still relevant, as it aligns opts
> queue_size with size of ctrl queue_size.

I don't have an opinion on this.

regards,
dan carpenter


