Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2043B77DA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbjHPGrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242176AbjHPGrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:47:02 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810691FC7;
        Tue, 15 Aug 2023 23:47:00 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5257f2c0773so904944a12.2;
        Tue, 15 Aug 2023 23:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692168419; x=1692773219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flBgap3vzzGdFevXRucCRqflcEL0jD8swhhmKI1hQQY=;
        b=PvQBOMdrxTObEcy5/Lfqs/O7Mk4BhokidWcF6H7reZqDlruAXaMX7w0EI2g6g8WGNp
         MFsJtTAEHYQaFa0U5OZ9N0I2CDHE8gDtoONT3nxFJe2VO7ZGc8MyfFNCg2nmk76q5VgZ
         ct48Lxj6vTv5bjg2zNRjIpKT1GFke+1vFGhzZrrrGeA0dV4QGDZBtFXjo/u2JZasHsKg
         e6TkdyADu3iEHkIADOOkeKv0jxAhDWiIYnrj6cB2P5GiSL7gugpDI5eVocjXsPoH3fRD
         QxUP9W123W6sIDEFTpJaTjG24zfQcH9r/bVUSXrl4rKtF3oQPU/Y/vw2Sl/ZopSXJhP+
         NRWw==
X-Gm-Message-State: AOJu0YzffNnrCqoBfmJzhrbG9Ps03g5XzOEo62Ezq+4w8sqnVHYxroJ3
        LY2fgzDESBjmUfl5MLBUlDc=
X-Google-Smtp-Source: AGHT+IHk1j7bDGF56TgxtNjesYi+XBzxyCQfAzQoy6P3Ibwn2D7+FycXYkdJ0WsN783e3Ch9dRCapw==
X-Received: by 2002:a50:ec8b:0:b0:523:f91:fcce with SMTP id e11-20020a50ec8b000000b005230f91fccemr844810edr.13.1692168418700;
        Tue, 15 Aug 2023 23:46:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402344200b00525658b7d3fsm3749337edc.45.2023.08.15.23.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 23:46:57 -0700 (PDT)
Message-ID: <937e14c1-d884-0b6e-595a-e8aaa3d09025@kernel.org>
Date:   Wed, 16 Aug 2023 08:46:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 34/36] tty: gdm724x: convert counts to size_t
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-35-jirislaby@kernel.org>
 <20230815172247.GA1690054@dev-arch.thelio-3990X>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230815172247.GA1690054@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15. 08. 23, 19:22, Nathan Chancellor wrote:
> On Thu, Aug 10, 2023 at 11:15:08AM +0200, Jiri Slaby (SUSE) wrote:
>> Unify the type of tty_operations::write() counters with the 'count'
>> parameter. I.e. use size_t for them.
>>
>> This includes changing constants to UL to keep min() and avoid min_t().
> 
> This patch appears to cause a warning/error on 32-bit architectures now
> due to this part of the change, as size_t is 'unsigned int' there:

Right, this is my brain fart thinking ulong is the same as size_t 
everywhere. No, size_t is uint on 32bit.

I will fix this -- kernel build bot seems to be slow -- it didn't find 
the issue out in my queue, nor in tty-testing.

thanks,
-- 
js
suse labs

