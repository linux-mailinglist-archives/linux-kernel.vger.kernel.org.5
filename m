Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EE1783B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjHVIDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjHVIBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:01:45 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83174CCD;
        Tue, 22 Aug 2023 01:01:42 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1692691301; bh=9oCDfmDLw5jBELC0tO4ITWMFvzvL2YA0yg2G4v+jawM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tvAVYFiF/9bJ8BnpdYZ9Qg1HEbA3dnakPTjvwzQSFa8GJmrff4Xh6DCa56MC86gje
         +ujfxowfzuxcZGCXZodR3GQ2x1lRMQocCo1zuIUQYrAtw5yPUbles3Yn0fcsBvTQtD
         W2yOcx+JCSGLFYHusnaO49eL3kkMG8gapyYgO8kyAtGCZy87WabDLh/aBYnYc3Kdsf
         C2lNNfEpIPNqFuCe+zPzGv+/7KY2joilGzzw1h79p6BOgjSntadyfBMW+xp1RcqIoO
         GsC4AmGBrWukJACsO44YVhQ3QT0TGaadNtDGQpcwp9fwufoQAaPgKPvrbPClXeVtzY
         Mxr6SkitSj2WA==
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Wang Ming <machel@vivo.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v3] wifi: ath9k: Remove error checking for
 debugfs_create_dir()
In-Reply-To: <87lee3ws02.fsf@kernel.org>
References: <20230726110750.3925-1-machel@vivo.com> <87sf8tbr3a.fsf@toke.dk>
 <87bkf0k1rt.fsf@kernel.org> <87350cbiv9.fsf@toke.dk>
 <87lee3ws02.fsf@kernel.org>
Date:   Tue, 22 Aug 2023 10:01:40 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87zg2ja4kb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>
>> Kalle Valo <kvalo@kernel.org> writes:
>>
>>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>>>
>>>> Wang Ming <machel@vivo.com> writes:
>>>>
>>>>> It is expected that most callers should _ignore_ the errors
>>>>> return by debugfs_create_dir() in ath9k_htc_init_debug().
>>>>>
>>>>> Signed-off-by: Wang Ming <machel@vivo.com>
>>>>> ---
>>>>>  drivers/net/wireless/ath/ath9k/htc_drv_debug.c | 2 --
>>>>>  1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers=
/net/wireless/ath/ath9k/htc_drv_debug.c
>>>>> index b3ed65e5c4da..85ad45771b44 100644
>>>>> --- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
>>>>> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
>>>>> @@ -491,8 +491,6 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
>>>>>=20=20
>>>>>  	priv->debug.debugfs_phy =3D debugfs_create_dir(KBUILD_MODNAME,
>>>>>  					     priv->hw->wiphy->debugfsdir);
>>>>> -	if (!priv->debug.debugfs_phy)
>>>>> -		return -ENOMEM;
>>>>
>>>> Hmm, so it's true that all the debugfs_create* functions deal correctly
>>>> with the dir pointer being an error pointer, which means that it's
>>>> possible to just ignore the return value of debugfs_create_dir() witho=
ut
>>>> anything breaking.
>>>
>>> The comment in debugfs_create_dir() states:
>>>
>>>  * NOTE: it's expected that most callers should _ignore_ the errors ret=
urned
>>>  * by this function. Other debugfs functions handle the fact that the "=
dentry"
>>>  * passed to them could be an error and they don't crash in that case.
>>>  * Drivers should generally work fine even if debugfs fails to init any=
way.
>>>
>>>> However, it also seems kinda pointless to have all those calls if we
>>>> know they're going to fail, so I prefer v1 of this patch that just
>>>> fixed the IS_ERR check. No need to resend, we can just apply v1
>>>> instead...
>>>
>>> Because of the comment I'm leaning towards v3.
>>
>> Well, the comment says "most callers" :)
>>
>> I think having an early return like this is perfectly valid
>> optimisation, even if it doesn't really make any performance difference.
>> I don't feel incredibly strongly about it (given that the current check
>> is broken I guess the early return has never actually worked), so if you
>> feel like overriding your submaintainer on this, feel free ;)
>
> No no, I don't want to override anything :) Just making sure you were
> aware of the comment. v1 is in my pending branch right now.

Alright, cool :)

-Toke
