Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7C802D17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343492AbjLDIY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDIY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:24:26 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6F8CB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:24:31 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3332e285ebcso762344f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701678270; x=1702283070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=R4I8vgD9+Za09laTZZYWbtvQQ3phm86Ia/yjl4Wnkg5mC9eaRWCIc3BAGgLPQeKlg6
         yrQMPp73h6La3B0x9fRDoPmgFG5cNZkWzBFrro3PCst3K3ROvrTtJpPziAkTLsafEwDM
         i0HUuI5CQJ7/F2bSSZ6jedDPxZJK3dm+pSwKAcuEs3/vdOxZmC4ZCS0oS18es66t2X+x
         OcNxRpEQ071wjKoJsT2UrmvadqawXjj+Q8iSsX/+13xIAWlQ7PgZt1zj6PMiZw4wcf3F
         An30GZUlXoj3TfG5Ap5SxQoDGHwrXOfq7ZgPf4Ql1GW5NbGnubgV6SQsg5LKsffEVEix
         QqLQ==
X-Gm-Message-State: AOJu0YxReoNsjcxkl6C8NjmN7wLFJ1dGah+f+AcA+/NeoF1unTRkYSu6
        BCL0irTxwLMpSwrs39MEGB1G9HY+i/c=
X-Google-Smtp-Source: AGHT+IFPoap0FiqL77fdMQ+O4HNnQ3ztzw/OXEzUwLPLWtEDkhKxNwOVAI/+Lf2UJS1p8fRlS92/HA==
X-Received: by 2002:a5d:6d8c:0:b0:333:4ba7:bcca with SMTP id l12-20020a5d6d8c000000b003334ba7bccamr915823wrs.5.1701678269542;
        Mon, 04 Dec 2023 00:24:29 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b003334675634bsm3060326wrf.29.2023.12.04.00.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:24:28 -0800 (PST)
Message-ID: <dcf08a56-3df4-4f9c-85b3-6f1328293180@grimberg.me>
Date:   Mon, 4 Dec 2023 10:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/3] nvme: lookup ctrl from request instead from
 namespace
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231201092735.28592-1-dwagner@suse.de>
 <20231201092735.28592-2-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231201092735.28592-2-dwagner@suse.de>
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
