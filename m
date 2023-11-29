Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD687FD65F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjK2MPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjK2MPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:15:04 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C43D7E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:15:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b427507b7so27603475e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701260109; x=1701864909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCBpwoGJiILtrBeFVDdliZqEf7BsITxGWUPpTBUG2Fg=;
        b=DfRF3iiirLaLQcvlzCjb/HKdfUsRUZ2FnLmbZXlrodQRLzmDzgDkTqRzCRcsCy64qv
         61YKxL7GbzA8o8VZL3vFegtVbCMyhaMVBpLOdkMgap8NMdxd3xCyfQ/beXXsWEPX19+s
         Z2QfFqI6Z7e3++D2eR6QcXBVreC5tTGrjq0K8jdRwiDNBsI8EYWcja5gMfQWUpNIG8OW
         Q9PnkOsaF5l8WAIzTc0RwOPoyjpAQmVcxkoM5OdLBDntHVwy/DztEhrB7NPA20JBiBJG
         szu/HWldfsYpuCxMALbYBe8Nle9LpFBM2gQ9/iekyGJ+U47u2IZpPD+VjQgM3dkBi/tu
         nurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260109; x=1701864909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCBpwoGJiILtrBeFVDdliZqEf7BsITxGWUPpTBUG2Fg=;
        b=o6yaqEizXs2C6TbEPtGYPf2VNegN8SN9gqukFLpfpbUFcOwRm7N2Kfo1zbDBkeVbkS
         qOGOBNichgot+aEBJkPoP39E/ZH3vqZ0G4OFiWghIGLJbwLU9IhOnjTIaB/7Cr0nhZT0
         NEcrX3Bt/EuExiyJYMECurNqpGh4sxN+guo4nlWk9IZ1XeQpBCG09KnN4PBqRjpOQt9h
         wPsXPrBF8iFhu2pz1KLsaptPra5N8J0apfLutauOZccUW2c1q+mwdfOujKfFB/iF4B+M
         zgaIQOpk+feq7HpXzyeoSBOcoELFQeVYXHbSKnqifNn4awt+ksTYaXpGwCYHrR8gRhQs
         dVMw==
X-Gm-Message-State: AOJu0YzWJX5JWqr2sL/C6F6rUB1LjW0qyk2ZMhhG6ixUf86q6nvuo/wl
        1mcbCGNZ3zuEPzVhPF48ZYZvtg==
X-Google-Smtp-Source: AGHT+IHXCZHVhiQsTBCF+dOLPeMR4tIn2HFIvymCl/DwP/ulwlloLviT1YfcyxEG0XVEw2fGIxfBKg==
X-Received: by 2002:a05:600c:19ce:b0:40a:3750:46ff with SMTP id u14-20020a05600c19ce00b0040a375046ffmr13264013wmq.11.1701260108810;
        Wed, 29 Nov 2023 04:15:08 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b00407460234f9sm2014318wmo.21.2023.11.29.04.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:15:08 -0800 (PST)
Date:   Wed, 29 Nov 2023 15:15:04 +0300
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
Message-ID: <c72789ac-9b3b-4857-b50b-a175027cb0bf@suswa.mountain>
References: <CGME20231128123622epcas5p4940679fbbafdf0da802deea3e531f850@epcas5p4.samsung.com>
 <20231128122958.2235-1-nj.shetty@samsung.com>
 <0cd6862e-8037-40b3-9fde-b7f10d66e31c@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cd6862e-8037-40b3-9fde-b7f10d66e31c@suswa.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:26:24PM +0300, Dan Carpenter wrote:
> The ctrl->ops assignment happens in nvme_init_ctrl() and it should have
> been easy to track.  I am not sure what went wrong there.  I'll take a
> look at that and fix it.

I suspect on your system you don't have the cross function DB built so
it's not aware what happens in nvme_init_ctrl() or the other function I
mentioned.

On my system there is too much data so it isn't parsed.
1) When there is too much data it should just mark ctrl->ops as unknown
2) I should try to consolidate the data.  I should just mark all of
   ctrl->ctrl_device as unknown instead of recording any of the struct
   members individually.  There might also be stuff that isn't used like
   ctrl->namespaces_rwsem internals.
3) On my system, I have 2187 bogus entries that say we removed an item
   from a list.

Probably any of these fixes would silence the false positive but it
would be better to do all three.

If you don't have the cross function database though, you're probably
out of luck.  There are always going to be more false positives if you
don't have the cross function information.

regards,
dan carpenter
