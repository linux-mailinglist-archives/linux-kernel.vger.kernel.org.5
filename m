Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4541802CEC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjLDIPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjLDIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:15:37 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD1EF3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:15:42 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3316d855828so912731f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701677740; x=1702282540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AM/uQA39F13NznlVFfjWutnZLKV4tyiDB9ucxAwvRFVRcGFl2yG+vRXcjRWfUfyHUA
         5Yof96JtYPAfbzOxemVTHCaYN7+Y6DO1YgIYbuS58l1vt2qprB3TW5REHzfGRLGMPc72
         FBeo8Rmgb71OL8U6BTCaodIzUPmwPtV+deEjYXD0Zi9kv7VhDTc/KDMq+tvh16SwbpF+
         zsOnHjo+ISlCtoKBZYn38Op3/GYU61mrJfPWlcCh6hzlTzUmJ/PzcXNwIk7IM+9ILRWr
         tVXArI0VGmg1RLa+PzNAVsLtBZXpQSFHmidAeZhT9QFC6LaINgg0MX1r7L6SkukaS8Av
         VjTA==
X-Gm-Message-State: AOJu0YzOyYaFGTMyyhLOQJHR2c5HFk2bnyM5iqWkw7wgQ1PUd9r3b9He
        SpdSCoRAOz8l5ZZDaBRCaS8O7DACxw8=
X-Google-Smtp-Source: AGHT+IHij3ijkLKy0LAZcWt30FyU97OEdKVCjD4dU7zcW6fwfly/8RWO49RjngtCjri6sMZDTWpBSQ==
X-Received: by 2002:a5d:5f4e:0:b0:333:4d89:b172 with SMTP id cm14-20020a5d5f4e000000b003334d89b172mr610781wrb.2.1701677740265;
        Mon, 04 Dec 2023 00:15:40 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l14-20020a5d6d8e000000b0033343b1ec1asm3362494wrs.26.2023.12.04.00.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:15:39 -0800 (PST)
Message-ID: <d6e33e3b-2b91-489b-b2aa-29ea97101748@grimberg.me>
Date:   Mon, 4 Dec 2023 10:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: fix deadlock between reset and scan
Content-Language: en-US
To:     Bitao Hu <yaoma@linux.alibaba.com>, kbusch@kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, kanie@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
 <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
