Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB276983B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjGaNwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjGaNwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:52:12 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99735199F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:51:45 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fe1f70a139so3256765e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690811504; x=1691416304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WPWLuMIszgw3T2kSEBOMUokiP9XQArQVVmtBCA6wgq25fKv1rMb6J5Gj+t3SeWa5k6
         SRFDyQRPDPdlbAmZNJnu6Y8+dBU4Vyczr7y4x0sQ9yITnfA7L/KBHujjILsVhqH99o5Z
         G6CjajzTi6YthNVqQsf1m8IE17/h6Yy9tv9KjyMBVjYnpGM0Shs9P0l7rF0Fhyc+Uf60
         2O8odD33BhJJwuZlOfejIBI4c26d1/T44lUKj/PoR6PwE6D17iVXGdktrtaIN3z5NcAi
         dGUGN7VFEkUz3RmL6j2cTjgDwBEVVXyLxhdc9kxOJie0iGdfqK/bBAVXyvmSO3ABZ1K2
         yjNQ==
X-Gm-Message-State: ABy/qLYFyFj5Cj3ytHQi8RBbbSsuzS/P/fMTX9PGLHBIgmbj1B3s5XBb
        F7f6JPwPe0wxvorRuM5R/2Q=
X-Google-Smtp-Source: APBJJlGMmPciRbX3khPzZG/zec5Sjkb0lpADKxI2keeJewtrWCPvpr8swI6z98Dz1ALgtpozwwhZpQ==
X-Received: by 2002:a05:600c:8807:b0:3f7:e7c9:4039 with SMTP id gy7-20020a05600c880700b003f7e7c94039mr6429093wmb.4.1690811503545;
        Mon, 31 Jul 2023 06:51:43 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003fbdbd0a7desm14129553wme.27.2023.07.31.06.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 06:51:42 -0700 (PDT)
Message-ID: <220e814d-84de-afa2-5bd1-da20e11fdf8f@grimberg.me>
Date:   Mon, 31 Jul 2023 16:51:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] nvme-auth: unlock mutex in one place only
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
        kbusch@kernel.org, hare@suse.de
References: <20230727134748.4163796-1-shiftee@posteo.net>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230727134748.4163796-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
