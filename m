Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F397982E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbjIHG63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjIHG61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:58:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E0519AE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 23:58:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso17887275e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 23:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694156302; x=1694761102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IS7APAXWLyRKAmVXEey0BMtRb06oUTAybc0N4RvhQnc=;
        b=KFK8tlXXPvW8nsUu32Blic3UJ+2pt2UH5jVJfkBU88QDxKP2v5v86dgzKUXXWHzdow
         q7qk6eJ2ibm3nKUcFdsTCrFMTxsqyWl+5oBqlmug9uL19xxbwOo1fSdYFUYkin+okocp
         4Y3kH2s5KQOgPcGvxVE+VtRUKY/i1HKYfwsPIXvdNOrFzoGtxh7xuF30OZ1qzRjSvtRO
         Q+Sl47pnla576a9pWNmAvGTniOwcUM6ggaKx62+1V6FXXAVHmR1aCw4pVWLqlyEpbKxz
         2/CmS1x9xWmTZdi8GjM6OtQzBXtb8ml4aAqJGVraEy18wDUaqszEPZ15vpNYpXw4vm1p
         +yzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694156302; x=1694761102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS7APAXWLyRKAmVXEey0BMtRb06oUTAybc0N4RvhQnc=;
        b=AHvzG/iMp8Wl1kCPS/xDDWsYjlNZtIQF2ywIHzlRCFwo3jaXZIPxgBj3jbvvYl7xTM
         r9FIbQCpVLRGdy59EgBJfh4fXxLgfzxaKHEy2BQZ0gmjgKHSubXPJ1UDDBsrUIE54FDf
         28DHvdFACuAZZ6rITch0orirHGD7QEpF93DSlKrwLTph2d0X579izftIjJsJFVZWF6YG
         4yCFl9BkAcPlEsK+2a+qXtni92aNAqEjHyn43Kn52jz6kfgleN82x6ZtsHCe0xSU/NMD
         FSqUTVOivVzJdrTuztFfbSxUP7giwae2TrLr8J1nuQ+qI1eiWUEFgFxARIfRorOz13bL
         CygA==
X-Gm-Message-State: AOJu0Yzxl/UThGJBPsrlV1Eg4yA4xZdMvnO5MKSSiid4Rg65s1N0CZnC
        2mWFr+Zp+NFjdWjKE1VW5IQYOw==
X-Google-Smtp-Source: AGHT+IEZV1Q27i9G8hEK5mZxwqpxrF/pwUjpH/zY9fyCoVx23TMN0b8UA/eU3imtpk7CgnINvQq+qw==
X-Received: by 2002:a05:600c:2483:b0:401:d2cb:e6f3 with SMTP id 3-20020a05600c248300b00401d2cbe6f3mr1573418wms.1.1694156302156;
        Thu, 07 Sep 2023 23:58:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l23-20020a1c7917000000b003fe17901fcdsm4361670wme.32.2023.09.07.23.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 23:58:21 -0700 (PDT)
Date:   Fri, 8 Sep 2023 09:58:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix uninitialized
 variable
Message-ID: <8a7f79be-e775-48ce-9eff-afa399e560d7@kadam.mountain>
References: <9918f1ae-5604-4bdc-a654-e0566ca77ad6@moroto.mountain>
 <51d1ae238aecde07b2b4fe02cdab0dc87287cd96.1694099183.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51d1ae238aecde07b2b4fe02cdab0dc87287cd96.1694099183.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:14:20PM +0100, Daniel Golle wrote:
> Variable dma_addr in function mtk_poll_rx can be uninitialized on
> some of the error paths. In practise this doesn't matter, even random
> data present in uninitialized stack memory can safely be used in the
> way it happens in the error path.

KMemsan can detect unintialized memory at runtime as well.  But
presumably no one runs that on production systems.

regards,
dan carpenter

