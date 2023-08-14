Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A5477B191
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjHNG3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjHNG2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:28:40 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF68114;
        Sun, 13 Aug 2023 23:28:39 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5234f46c6f9so5234181a12.3;
        Sun, 13 Aug 2023 23:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691994518; x=1692599318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjpc/e9PmjESWz3kUI8iPKeMgf5aaA3E8QCr//sMUlk=;
        b=C8UPqIX9i6Qm5bzgZK6gKYfEr0Jf35P/t1T8Pp17Gvhaiw5d9gXKph9pwYHCxU5xiS
         9fPokopBF788HX3wdSoHf0TOFMabB5pfsVXYRskDlKbmySxHpIh0njpBGmOc+dRXTmaQ
         S3qu6YqkF8FjGGc4nSoFiN62n9spfmW4qlWdNT34ejQO8dpglKzYUKBNuQTbIibyVP8H
         3h913G2Pk0JnaeRWvPfNwrlUv96n8/yoYRBPfOfr9BVXVact6Hu0y+KDSv/cS1SFc3Kn
         67T3nYBlFgPNOXcLof8ghunyaaxVDuemLNlRmUeDiNV9UD+lM3FXqYPV5SXJ3py6OHyR
         K6Aw==
X-Gm-Message-State: AOJu0Ywm9aYi6SRx5fSIU7sLz0bb0czRyWbZ4wFEVXJI6g26sq/hi+2n
        rcs3BSikJPl5yXDg9nqt4x0tdMGEbJ/jiA==
X-Google-Smtp-Source: AGHT+IG2Q3rVQTEdjjWCXzKItx4iVlFyV3NJOuF50WOqEwbdyMonLArHmT25BMjYRk8bgz5C7Flx2A==
X-Received: by 2002:a05:6402:12d0:b0:522:3ef1:b10 with SMTP id k16-20020a05640212d000b005223ef10b10mr6191785edx.6.1691994517543;
        Sun, 13 Aug 2023 23:28:37 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id y18-20020aa7ccd2000000b005227e53cec2sm5219628edt.50.2023.08.13.23.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 23:28:37 -0700 (PDT)
Message-ID: <7d8ae4f8-8900-5a06-5b7b-d4a3aea0673e@kernel.org>
Date:   Mon, 14 Aug 2023 08:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] serial: 8250: drop lockdep annotation from
 serial8250_clear_IER()
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
References: <20230811064340.13400-1-jirislaby@kernel.org>
 <878rae175n.fsf@jogness.linutronix.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <878rae175n.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 08. 23, 8:15, John Ogness wrote:
> On 2023-08-11, "Jiri Slaby (SUSE)" <jirislaby@kernel.org> wrote:
>> The port lock is not always held when calling serial8250_clear_IER().
>> When an oops is in progress, the lock is tried to be taken and when it
>> is not, a warning is issued:
> 
> Yes, and that is a potential deadlock. The warning is correct.

Could you elaborate on how can not-taking a lock be a potential deadlock?

>> Therefore, remove the annotation as it doesn't hold for all invocations.
> 
> ... because those invocations are broken by design.

Perhaps. But the system is crashing. Better to emit something without 
the lock rather than nothing (and wait for the lock infinitely).

>> The other option would be to make the lockdep test conditional on
>> 'oops_in_progress' or pass 'locked' from serial8250_console_write(). I
>> don't think, that is worth it.
> 
> The proper thing to do is to fix the invocation. The upcoming atomic
> console implementation for the 8250 does exactly that.

So what does it do?

> If this patch gets accepted (which it appears it will be), I will revert
> it in my series implementing the 8250 atomic console.

That's fine as soon as the warning is not a problem.

thanks,
-- 
js
suse labs

