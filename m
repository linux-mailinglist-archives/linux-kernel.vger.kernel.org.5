Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B96876B7DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjHAOmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjHAOmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:42:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7299C;
        Tue,  1 Aug 2023 07:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C70615CD;
        Tue,  1 Aug 2023 14:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2D3C433C9;
        Tue,  1 Aug 2023 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690900936;
        bh=Ifsf+UP7DfBl5X+t2F3PvEQ8d2CvFMBSWmOAi1tejUI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IcqNTVC6OSw7u6y45OyD6q0oSZbVww1OfHa16ef3QjXxi4t3sbgXv9Gy36BJo3Kvt
         +SH5//cL604sQpPGKG+sAA7Oimky30stV9x9dt97vs1RAn3UgLnYv8694AczWkSejZ
         OCmM+oQ2xo4U+Vc3Bq8N4mvAcT8Nx3t7iaPt3B/ExnCzJFa/wiLv/Cc7aSIOf4Nohr
         mC7gyAlJMvoDYAGur+YFJKiwZInZEaTOsGMRJcVwwIzs48byCeUiNwRRUBKWAG9t3H
         955/FdBg9Haq/zVYNCeTTTsL+1dBWyIu1OxzwLQPhkJdU/kB3llakGCOkGdzCwmA/J
         59OMW5p46zgrw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Atul Raut <rauji.raut@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath6kl: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
References: <20230731012941.21875-1-rauji.raut@gmail.com>
        <2023073103-basket-ranking-b6e6@gregkh>
Date:   Tue, 01 Aug 2023 17:42:13 +0300
In-Reply-To: <2023073103-basket-ranking-b6e6@gregkh> (Greg KH's message of
        "Mon, 31 Jul 2023 08:05:52 +0200")
Message-ID: <877cqeygca.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Sun, Jul 30, 2023 at 06:29:41PM -0700, Atul Raut wrote:
>
>> Because zero-length arrays are obsolete, replacing them with
>> C99 flexible-array members.
>> Instead of defining a zero-length array, use the new
>> DECLARE_FLEX_ARRAY() auxiliary macro.
>> 
>> This fixes warnings such as:
>> ./drivers/net/wireless/ath/ath6kl/usb.c:109:8-12: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
>> 
>> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
>> ---
>>  drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
>> index 5220809841a6..bb3771a3897c 100644
>> --- a/drivers/net/wireless/ath/ath6kl/usb.c
>> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
>> @@ -106,7 +106,7 @@ struct ath6kl_usb_ctrl_diag_cmd_write {
>>  	__le32 cmd;
>>  	__le32 address;
>>  	__le32 value;
>> -	__le32 _pad[1];
>> +	DECLARE_FLEX_ARRAY(__le32, _pad);
>
> This is not a 0 length array, or a variable array.  Look at the work
> done on the hardening mailing list for more details, I think this is
> wrong.

I agree with Greg, this is just padding and _pad is not even used
anywhere in ath6kl. Though use of [1] is strange here, '__le32 _pad;'
would be enough.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
