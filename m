Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3078396F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjHVFng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjHVFnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A68133;
        Mon, 21 Aug 2023 22:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7DBD61F5D;
        Tue, 22 Aug 2023 05:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC6DC433C9;
        Tue, 22 Aug 2023 05:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692683012;
        bh=MlkDt4lSwRLkNkwyY2fyqOrEpkJm8+YSKKaLzasKkek=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=o5eDhnoYUR6MC0uhXLUEzzr8DYAZ0ei3bSVg57wqinm3UUaeQ0Wdv7X50n0jwp34t
         uV3Mu9SfiKmT+h+UALoxPSDtmrLYoCqpcSIxUkJwh028sjRoca/6mJ+DPr8PFCRCq5
         iLQIEJsAKpzDDSrw60lXU36CyB+NfmKPa7BFLWhjIixXnSRcdFHgVvQc2fX0Lz5k2i
         /JEmZZAyspOrP6ce6fz+JQ1YAR8Y6ZRZhLAC9Pptj9BGkAgv0MWRhg5UHJGBIA90SU
         kXDxdiDxjf2G/G8ZaiDMgi6yWAwSLXmHlInK98qBkSZGUEubqoyXXWJQFgRsbkilJd
         1Nn0sqnuZ7ilw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Wang Ming <machel@vivo.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v3] wifi: ath9k: Remove error checking for
 debugfs_create_dir()
References: <20230726110750.3925-1-machel@vivo.com> <87sf8tbr3a.fsf@toke.dk>
        <87bkf0k1rt.fsf@kernel.org> <87350cbiv9.fsf@toke.dk>
Date:   Tue, 22 Aug 2023 08:44:29 +0300
In-Reply-To: <87350cbiv9.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
        "Mon, 21 Aug 2023 15:55:06 +0200")
Message-ID: <87lee3ws02.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>>
>>> Wang Ming <machel@vivo.com> writes:
>>>
>>>> It is expected that most callers should _ignore_ the errors
>>>> return by debugfs_create_dir() in ath9k_htc_init_debug().
>>>>
>>>> Signed-off-by: Wang Ming <machel@vivo.com>
>>>> ---
>>>>  drivers/net/wireless/ath/ath9k/htc_drv_debug.c | 2 --
>>>>  1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/=
net/wireless/ath/ath9k/htc_drv_debug.c
>>>> index b3ed65e5c4da..85ad45771b44 100644
>>>> --- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
>>>> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
>>>> @@ -491,8 +491,6 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
>>>>=20=20
>>>>  	priv->debug.debugfs_phy =3D debugfs_create_dir(KBUILD_MODNAME,
>>>>  					     priv->hw->wiphy->debugfsdir);
>>>> -	if (!priv->debug.debugfs_phy)
>>>> -		return -ENOMEM;
>>>
>>> Hmm, so it's true that all the debugfs_create* functions deal correctly
>>> with the dir pointer being an error pointer, which means that it's
>>> possible to just ignore the return value of debugfs_create_dir() without
>>> anything breaking.
>>
>> The comment in debugfs_create_dir() states:
>>
>>  * NOTE: it's expected that most callers should _ignore_ the errors retu=
rned
>>  * by this function. Other debugfs functions handle the fact that the "d=
entry"
>>  * passed to them could be an error and they don't crash in that case.
>>  * Drivers should generally work fine even if debugfs fails to init anyw=
ay.
>>
>>> However, it also seems kinda pointless to have all those calls if we
>>> know they're going to fail, so I prefer v1 of this patch that just
>>> fixed the IS_ERR check. No need to resend, we can just apply v1
>>> instead...
>>
>> Because of the comment I'm leaning towards v3.
>
> Well, the comment says "most callers" :)
>
> I think having an early return like this is perfectly valid
> optimisation, even if it doesn't really make any performance difference.
> I don't feel incredibly strongly about it (given that the current check
> is broken I guess the early return has never actually worked), so if you
> feel like overriding your submaintainer on this, feel free ;)

No no, I don't want to override anything :) Just making sure you were
aware of the comment. v1 is in my pending branch right now.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
