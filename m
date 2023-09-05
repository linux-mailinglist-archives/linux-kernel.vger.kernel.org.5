Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25513792A71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbjIEQhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244934AbjIEBhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:37:51 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12117CC8;
        Mon,  4 Sep 2023 18:37:47 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5122:7a94:e7cc:c027:4d89] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3851awA0021528-3851awA1021528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 5 Sep 2023 09:37:00 +0800
Message-ID: <3cec1ac9-5cbf-648c-69ca-12e757bb7617@hust.edu.cn>
Date:   Tue, 5 Sep 2023 09:36:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ath9k: unify error handling code in ath9k_hif_usb_resume
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230903123230.2116129-1-dzm91@hust.edu.cn>
 <87v8cqs165.fsf@toke.dk>
Content-Language: en-US
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87v8cqs165.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/23 18:06, Toke Høiland-Jørgensen wrote:
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> In ath9k_hif_usb_resume, the error handling code calls
>> ath9k_hif_usb_dealloc_urbs twice in different paths.
>>
>> To unify the error handling code, we replace one error handling path
>> with a goto statement.
>>
>> Note that this patch does not incur any functionability change.
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> Hmm, if you're cleaning up that function, how about changing that else
> to an early error return? I.e. change the if at the top to:
>
> 	if (!(hif_dev->flags & HIF_USB_READY)) {
> 		ret = -EIO;
> 		goto fail_resume;
> 	}
>
> and drop one level of indentation from what is currently in the top
> branch of the if statement.

Yeah, this is more elegant. I've sent a patch v2.

Dongliang Mu

>
> Also, while you're at it, please reorder the variable declarations at
> the top of the function to be reverse x-mas tree order (moving the 'int
> ret' declaration to the bottom).
>
> -Toke
