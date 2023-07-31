Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FECC768BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGaGZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaGZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87627BE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690784686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kCGfGQpNevEyxQJOi2EpZ/60FOEBzdh7x63Yvc5DA1k=;
        b=OAm5+NZjUGiGBg0/3fKniS5wqzsUKgWDzn/nqZzNxf8zY8sbwtqT13leSkyOBDHNlTbGBU
        sCesSouIIBx7O8KxFvuh0aEj9GZ7+tCTL7kIRjsEWIUFEGv8gI62rooJIrCq42jyjA1UFM
        85sbsotLqHwPZHWsyWcKvNNyz0FgB6I=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-tozEQGmXOF-LHyuHg_o4zA-1; Mon, 31 Jul 2023 02:24:45 -0400
X-MC-Unique: tozEQGmXOF-LHyuHg_o4zA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6871c35ac54so1939940b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690784684; x=1691389484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCGfGQpNevEyxQJOi2EpZ/60FOEBzdh7x63Yvc5DA1k=;
        b=U+rEa22HriicAukB3yil8FPXo8lJs4zSzVXowvSgP5/mhWSu89NbDcdEVTB/Io3MD8
         XmQuxWKiY4KDFNAbZmrqe6sJlXnYEdqNKWucl2CvFBZdVUhk+wqjnF1BFDnZTqFu8oYS
         +8ph9wCvTJrjfZTcHJyN5UHWOcLO9Oa8Uj8qw85AjlvY6fltyiMkQQ+E3nhTbdJu/kYY
         yd9AucD+m39hc0lLcQj7Png+ytvU/0oE9+sx1d/HebKoKwo91lvzVjYefDSjXKJ4KyDa
         2T20IiNlkpiQZ8vb1sVotTS3iF+lq9N+2AdHu9ROjuVH9Ve7KX5fWiGfUT7nYfA4HOlI
         B/Ow==
X-Gm-Message-State: ABy/qLYbne4cvVdhl3DvS2Akq8cE5yxlJNKGTUEuaqMsLrCV4n1CPH7t
        nPFz3YKXxKC5KNdu1fuPnwd0lglHDoRTh97bijUGBfH0fVnVf+/ZZ1XFG8QfLuEKU2WMJslJgMt
        uZUgN/bL25MpxcE658h6Na2MG
X-Received: by 2002:a05:6a00:1902:b0:682:5634:3df1 with SMTP id y2-20020a056a00190200b0068256343df1mr10454910pfi.10.1690784683941;
        Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7hRSrqGoCxMOCQEWdDDgEVMWsydvLGR7y6jP66LSsLJaoK1Qrd924k7OelmyerHuJSUgtvg==
X-Received: by 2002:a05:6a00:1902:b0:682:5634:3df1 with SMTP id y2-20020a056a00190200b0068256343df1mr10454894pfi.10.1690784683710;
        Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
Received: from [10.72.112.185] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e7-20020aa78247000000b0066f37665a63sm1200909pfn.73.2023.07.30.23.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
Message-ID: <bd76081f-e6d3-ee60-a2de-cacd3e40563d@redhat.com>
Date:   Mon, 31 Jul 2023 14:24:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V4 3/3] virtio_net: enable per queue interrupt
 coalesce feature
Content-Language: en-US
To:     Gavin Li <gavinl@nvidia.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
Cc:     gavi@nvidia.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Heng Qi <hengqi@linux.alibaba.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-4-gavinl@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230725130709.58207-4-gavinl@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/7/25 21:07, Gavin Li 写道:
> Enable per queue interrupt coalesce feature bit in driver and validate its
> dependency with control queue.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

