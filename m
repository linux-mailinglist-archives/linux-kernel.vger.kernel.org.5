Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2551478C39A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjH2LtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjH2Ls5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:48:57 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36789CD1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:48:44 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fef244772bso10830785e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693309722; x=1693914522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6ONHVJq1guYQr4QsQ40LpMl6alYrT+WKUbUjt1YYvM=;
        b=Mdsaic7KCqnUuFikYXwbTUdzcGCtqQeBShBLXze0h+fUoiX3ImEbP4kwJiUbC9wQvU
         d+CC5FvP0wDDg8e4ufCQoM7tBl38kVneZsq2t0OSx1N8v8jYQHCFh0YPUor2CGF4tIAc
         I63lLYTGJaDhyy/Vi0M8tLyMoEAZ8LSDzEdGPSmAmKFr55lBw1yZqADMpNmgewT/yiao
         4wlRoXvRwF2eor1+tZt8CVnhT5gZQZh4sLHfUbiZDUbk/icdP/U63GPlTNW1og2p+nNJ
         lGKJWw0xa9cR1b2LsgWbQL50IRVS/hLJEK9ZB7Dr6B8XZeUcvx5ARVz8cmhTCvQe2WVr
         CZng==
X-Gm-Message-State: AOJu0Yxro/F1G1dPfBGwzeNidSSPg0gZT3K6t1wNrQEeg/7iIv1W5K9Q
        zjR1T4yxpRCVijrscKBIE54=
X-Google-Smtp-Source: AGHT+IE4tuqa9SpwxzOSWSpU0gJbWYHlxMRc0N4CGlZkFNkQy5Qw74qnQEAmKDC+KvQc9nkSzI3gew==
X-Received: by 2002:adf:f892:0:b0:317:5f08:32a3 with SMTP id u18-20020adff892000000b003175f0832a3mr19853713wrp.6.1693309722571;
        Tue, 29 Aug 2023 04:48:42 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c4-20020a056000104400b00317a29af4b2sm13545101wrx.68.2023.08.29.04.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 04:48:42 -0700 (PDT)
Message-ID: <f96856ae-4842-8a50-dca1-2786153e491f@grimberg.me>
Date:   Tue, 29 Aug 2023 14:48:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] nvme-tcp: always set valid seq_num in dhchap reply
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
        kbusch@kernel.org, hare@suse.de
References: <20230828212033.3244512-1-shiftee@posteo.net>
 <20230828212033.3244512-2-shiftee@posteo.net>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230828212033.3244512-2-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/23 00:20, Mark O'Donovan wrote:
> Currently a seqnum of zero is sent during uni-directional
> authentication. The zero value is reserved for the secure channel
> feature which is not yet implemented.

Hannes?
