Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736227B9E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjJEOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjJEOHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C22472AA;
        Wed,  4 Oct 2023 23:58:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so982712a12.1;
        Wed, 04 Oct 2023 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696489112; x=1697093912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qhIhfVRhO7/8LjuT+XVehw0XM9wNgGO8XeQLSWd3sR8=;
        b=QPVKj12W3rDLTd8W89XSfHK7kJmdAcMccKXM1bA6i56YD+f15VuCQvcOpEwO5koT2G
         DsHIlBez8brGwxRIdcwtGwJIx9RAgxiwCeBWOJQ651tzq7W07mL/11k/Kef4LX6kv4Fw
         BQD92YbvdOnv9bo2KP6ZpG+eplb15xLhzPy4ew/8s65SV0VIimumvUbHDYPu/oeE9k4T
         ErWQelorbGMbresoOV2kzFDj6nRdhS+5rWCCWRkS11f4mlac99oTJ/1wOy/Koj5Fkkvc
         JQx+PZcFKkO3rBka96IcIDH5UUhJkkp+pSR/CKP5qRi2Ol2wbDWUaVjtTr+xubq0gMZ0
         drKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696489112; x=1697093912;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhIhfVRhO7/8LjuT+XVehw0XM9wNgGO8XeQLSWd3sR8=;
        b=Scj9lVBYyWwzoPq+hwp6e2WhMSAtbZwVkMF8dx03SAAZFDjOSAHEgD6wCAU4IsgK0p
         XC5fJu8OSRjcpp5fXllOkhvTbXZEMAWNIfAX0Lho+Iui3g4pOc2kQXQzbR9BoCdLppYN
         havtI5l+i8iUZ+a/aWVAKbBa6O83rBdxMjFXviDcFTvwVxorrBJp3KsWO4ign+aiKfGd
         pCpWwN96MltTVMEhpJoOsHDfKeNGNPgf28LaUuXe8AR5BTkZuyazxAN5RsFFPw7gwUPz
         MrJftuSQ5GG2l0nPqpKXynLwUnOC0j3YRK8r101qa75DtDsN7dox6Xf8PD61pnibnaR/
         JrhQ==
X-Gm-Message-State: AOJu0YybMbCBZLxQSnUN/tE0Chgosa1dASOkkwo8zgLnyNfVfn9ZdemF
        R+SFslLD0sGNd7PkQpywnBY=
X-Google-Smtp-Source: AGHT+IFDag8FSyE2B+K31f3V8mU1r+Im/wneL5bJ/c1lhJda3wujsL6MBgVIK/501A+y4cjfnqeW3Q==
X-Received: by 2002:a17:906:7382:b0:9ae:284:c93d with SMTP id f2-20020a170906738200b009ae0284c93dmr3305618ejl.5.1696489111677;
        Wed, 04 Oct 2023 23:58:31 -0700 (PDT)
Received: from [147.251.42.107] (laomedon.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906b20800b009adce1c97ccsm647670ejz.53.2023.10.04.23.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 23:58:31 -0700 (PDT)
Message-ID: <59535b4b-9f07-44c5-a7da-e6b2fc1c67bb@gmail.com>
Date:   Thu, 5 Oct 2023 08:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix regression in sed-opal for a saved key.
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc:     jonathan.derrick@linux.dev, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, Ondrej Kozina <okozina@redhat.com>
References: <20231003100209.380037-1-gmazyland@gmail.com>
 <5c4fbafb1daa45f2faf60c7d587cd23c53d9393c.camel@linux.vnet.ibm.com>
Content-Language: en-US
From:   Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <5c4fbafb1daa45f2faf60c7d587cd23c53d9393c.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 22:54, Greg Joyce wrote:
> On Tue, 2023-10-03 at 12:02 +0200, Milan Broz wrote:
>> The commit 3bfeb61256643281ac4be5b8a57e9d9da3db4335
>> introduced the use of keyring for sed-opal.
>>
>> Unfortunately, there is also a possibility to save
>> the Opal key used in opal_lock_unlock().
>>
>> This patch switches the order of operation, so the cached
>> key is used instead of failure for opal_get_key.
>>
>> The problem was found by the cryptsetup Opal test recently
>> added to the cryptsetup tree.
>>
>> Fixes: 3bfeb6125664 ("block: sed-opal: keyring support for SED keys")
>> Tested-by: Ondrej Kozina <okozina@redhat.com>
>> Signed-off-by: Milan Broz <gmazyland@gmail.com>
>> ---
>>   block/sed-opal.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/sed-opal.c b/block/sed-opal.c
>> index 6d7f25d1711b..04f38a3f5d95 100644
>> --- a/block/sed-opal.c
>> +++ b/block/sed-opal.c
>> @@ -2888,12 +2888,11 @@ static int opal_lock_unlock(struct opal_dev
>> *dev,
>>   	if (lk_unlk->session.who > OPAL_USER9)
>>   		return -EINVAL;
>>
>> -	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
>> -	if (ret)
>> -		return ret;
>>   	mutex_lock(&dev->dev_lock);
>>   	opal_lock_check_for_saved_key(dev, lk_unlk);
>> -	ret = __opal_lock_unlock(dev, lk_unlk);
>> +	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
>> +	if (!ret)
>> +		ret = __opal_lock_unlock(dev, lk_unlk);
> 
> This is relying on opal_get_key() returning 0 to decide if
> __opal_lock_unlock() is called. Is this really what you want? It seems
> that you would want to unlock if the key is a LUKS key, even if
> opal_get_key() returns non-zero.

I think it is ok. That was logic introduced in your keyring patch anyway.

I just fixed that if key is cached (stored in OPAL struct), that key is used
and subsequent opal_get_key() does nothing, returning 0.

The story is here that both OPAL lock and unlock need key, while LUKS
logic never required key for lock (deactivation), so we rely on the cached
OPAL key here. We do not need any key stored for unlocking (that is always
decrypted from a keyslot)
(I think requiring key for locking range is a design mistake in OPAL but
that's not relevant for now :-)

Milan

> 
>>   	mutex_unlock(&dev->dev_lock);
>>
>>   	return ret;
> 
