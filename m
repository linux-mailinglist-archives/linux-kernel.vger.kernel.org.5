Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED977B687
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjHNKVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjHNKV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:21:28 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A073BA;
        Mon, 14 Aug 2023 03:21:27 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9936b3d0286so587293766b.0;
        Mon, 14 Aug 2023 03:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692008485; x=1692613285;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+x+N4SGGQ/ymNRHM55jnGBAqGhG9LuHEySZN/nPsAA=;
        b=k+JEXLPTupKFu4NZ0YMBH9488xTFdnpv873IwP46GnR5G4ZoZrarMaE2YRtw+UntPl
         cG1KWItkAa26LFT5GCUVeHC9BqmCOdnNZvt36WiP4hatjjnLufV0kFTW9qW5sRl+u4B6
         EdQZhCKBWGhnKzsnL/gLJn5VHQlTjrRqrMxXY1q3DSa+C7m5V1zoiVnjmShtjrC6x+jG
         H5BqPW3WHqewuxAX/2HsM40dhCmvdGDJ/bBARgl7Wide9Zn51QD6DP4LWQinfQLp4xbA
         YGo1lzE+M6KwmUMDx71eZWcONlAcUuxOmq0pyD/2vrhqgTKmelcJ7nM+GjeN5Lys4DUg
         Ijbw==
X-Gm-Message-State: AOJu0YwrYDSwC941WWiGbj64vcG4r57z0WcWSRIy+OaLoC4RRoI6ke58
        2VRR89Nx/NlT8rBHTuTk0Hw=
X-Google-Smtp-Source: AGHT+IF39Lq1gFcrUWZk1jysSKcaS1v+NZEqDsr9JU/ySnEScMgddYR7P8uvGW6mbwAJ5s/YH1GpPg==
X-Received: by 2002:a17:906:2252:b0:991:fef4:bb9 with SMTP id 18-20020a170906225200b00991fef40bb9mr7940491ejr.58.1692008485435;
        Mon, 14 Aug 2023 03:21:25 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906660c00b009828e26e519sm5514426ejp.122.2023.08.14.03.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 03:21:24 -0700 (PDT)
Message-ID: <154dfc10-76fa-b054-54a8-faa22ad52158@kernel.org>
Date:   Mon, 14 Aug 2023 12:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230811064340.13400-1-jirislaby@kernel.org>
 <878rae175n.fsf@jogness.linutronix.de>
 <7d8ae4f8-8900-5a06-5b7b-d4a3aea0673e@kernel.org>
 <87bkfa6nvx.fsf@jogness.linutronix.de> <ZNn7KHY3iMRarqAZ@alley>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: 8250: drop lockdep annotation from
 serial8250_clear_IER()
In-Reply-To: <ZNn7KHY3iMRarqAZ@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 08. 23, 12:00, Petr Mladek wrote:
> I personally vote to keep it as is unless people see this warning
> on daily basis. After all, the lockdep splat is correct. The serial
> console might not work correctly in panic() when there is the race.

Sorry, but no, the warning is not correct at all. The code path 
deliberately does NOT take the lock and calls a function which is 
currently annotated that the lock is _always_ taken. Therefore, the 
warning is clearly a false positive and I see no reason in keeping it.

Hopefully this is fixed as John described earlier. Until then, I see no 
point bothering people with false alarms.

thanks,
-- 
js
suse labs

