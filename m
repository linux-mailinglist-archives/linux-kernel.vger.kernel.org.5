Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D20A78EEF0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbjHaNqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjHaNqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:46:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31536CEB;
        Thu, 31 Aug 2023 06:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE2EA631A5;
        Thu, 31 Aug 2023 13:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A289FC433C7;
        Thu, 31 Aug 2023 13:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693489610;
        bh=xn/Mj2gBv64WVvBC6jpiD9eAcJ5g1bnlmQ/5B7GK/J4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KkbYvqBJ8ixQFWkG9OzDbY30MyWE2KmTw7xYsoMo4U6KeWqNcGsmQtwpJtD5NU77h
         9v1X2+KFA98Nq1ekGndOF6cgVbDQwbxJi3yvM5ixXeCEAg96zDl3axO9pDjLEAF8KN
         JZVQbkaKD6QrbyQ63cJlt0tmjYf3qI0twFyRjR8C5xcVtgO5zHewy9d8kDEzL5S2u5
         Q6tpYRoYxjBmA76wzv803ckXC0DiXdqsTBMKlJ1HF7/sHqlTYqQA/EHSVoNN/lV5o5
         SFz/Kifb2LQoDgwpEm/2TIaYRpfcqZuYr2IcHuMJ9z8p2Fy691v65ATCQn62AERxPY
         f+mHbRNRM9EWQ==
Message-ID: <49ef6d93-eebd-7200-cd1b-ecd4d6fedeba@kernel.org>
Date:   Thu, 31 Aug 2023 15:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
Content-Language: en-US
To:     =?UTF-8?B?0KDQsNC90LQg0JTQtdC10LE=?= <deeb.rand@confident.ru>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lvc-project@linuxtesting.org,
        =?UTF-8?B?0JLQvtGB0LrRgNC10YHQtdC90YHQutC40Lkg0KHRgtCw0L3QuNGB0LvQsNCyINCY?=
         =?UTF-8?B?0LPQvtGA0LXQstC40Yc=?= 
        <voskresenski.stanislav@confident.ru>
References: <20230830082759.23336-1-deeb.rand@confident.ru>
 <4c6d01bf-1a0f-27de-54e1-4afdcf4bc8d5@lwfinger.net>
 <531722477.1139813.1693465653233.JavaMail.zimbra@confident.ru>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <531722477.1139813.1693465653233.JavaMail.zimbra@confident.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2023 09:07, Ранд Дееб wrote:
> Dear Larry, 
> 
> 1- Yes, I agree that your solution is simpler, and I thought about it, but 
> I thought that the one who set the value zero put it for some reason, so I 
> did not want to change it.

Don't top -pots.

> 2- It's first time to send using this mailer, but we tested it by sending 
> the patch to our personal emails (gmail, etc..) and it works perfectly! I 

Really? No, it does not work perfectly. Look at your email - you send it
non-standard way.

> don't know why this encryption appears only when we get a response from 
> you, but we're still investigating. We will fix it, and follow all the 
> recommendations in the future.

What encryption? You mean encoding? Encryption is something entirely
else and if you enable PGP or whatever, you must disable it. It's public
work.

Best regards,
Krzysztof

