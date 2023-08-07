Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBDF77216C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjHGLWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjHGLVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:21:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A147E198E;
        Mon,  7 Aug 2023 04:19:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-564ef63a010so753776a12.0;
        Mon, 07 Aug 2023 04:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691407110; x=1692011910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10WRxgCd1Ra/UwnCOO5Le6ouxzvPUSQ7L4DRj9cnhvQ=;
        b=BbMhxrRT3BQWilMzDO0kOG53k1csR55VFCEWxQmgnHXytaruemu6eCXJr3tW4oX8cb
         ps9wcx2EfT2UO4gVdTD1Z35xkQJkbrMjIIJhxGqVksl+fHRl4dVYQj3OSAYRYrv5lgWz
         FQM0OmbqLpQ/JVy8hWw33TuEEsjYrmWj4lqikbkwCS0G9xHgKYPMgtKXGYatRPxSrLlB
         DgvVuIWp+kqP8qE1xHndtrxPi032sCLlXe8vzDzLGCHsJglemI0Tpolog0azU/FOgEgt
         IAPEY5BzdA0bb2y0TUKhhaVrDcPhNVINC7+oUKhl4yGTjwh8p5igAolQb7Stab2Q8k8/
         LCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407110; x=1692011910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10WRxgCd1Ra/UwnCOO5Le6ouxzvPUSQ7L4DRj9cnhvQ=;
        b=l+gvHGLBIapKGvcmMEPnBF6SG/iwp7cY0HDryicuiX2UVDSUg9jhi0zElu6RTiIIuS
         jOwKSSV4eEBp8k/hfMhRe6yzRq0S3I4E88XBVf0B9tBidHH+fTB7wnm3i/Yt+/FRIJoN
         yRrRe3rdYbMn17R70of9helRi9W6RhKhcQkcBI5Jy2VLk5a8C93pPq8f/GcbnMKgUlaH
         JmXiVtC88GEGnAAn7EZ9Tf7+f3WTFBz6rwZA8T7RFA8weCT6KfTHabuxhdkg6XbPFRTF
         4CrxefP+49tqgMbCq9huuGU9Ik2OF5J011hmnYIg9Xkl8/t0boRxBc6XC9cILCR0Kp/h
         QHFg==
X-Gm-Message-State: AOJu0Yzt9niVB7YRlv4y3D8C31gfPfSP4XSDc/PXRx/4utCvqAf93sPI
        CixZ3P/5mgEImfsOzNKS9VU=
X-Google-Smtp-Source: AGHT+IFb1tkA18QJP9FlaWRYGpLo1HYosfByYwLhOuZichV4jLkKO6rer96PRSVBpGX4H+kokZLFPg==
X-Received: by 2002:a17:90b:283:b0:262:e589:678f with SMTP id az3-20020a17090b028300b00262e589678fmr8403115pjb.10.1691407110138;
        Mon, 07 Aug 2023 04:18:30 -0700 (PDT)
Received: from [192.168.0.101] ([49.207.242.210])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a019000b00263cca08d95sm9078876pjc.55.2023.08.07.04.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:18:29 -0700 (PDT)
Message-ID: <80bd4203-471a-4e47-8799-e6c0e70c9c24@gmail.com>
Date:   Mon, 7 Aug 2023 16:48:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] kbuild: modinst: do modules_install step by step
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com,
        linux-kbuild@vger.kernel.org
References: <20230623145358.568971-1-yesshedi@gmail.com>
 <20230623145358.568971-9-yesshedi@gmail.com>
 <2023080434-verbose-value-1200@gregkh>
 <9ff945e6-c963-41d2-9df2-542d83ada519@gmail.com>
 <2023080630-entomb-ogle-3da8@gregkh>
Content-Language: en-US
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <2023080630-entomb-ogle-3da8@gregkh>
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

On 06/08/23 12:15, Greg KH wrote:
> On Sun, Aug 06, 2023 at 12:30:22AM +0530, Shreenidhi Shedi wrote:
>> On 04/08/23 19:36, Greg KH wrote:
>>> On Fri, Jun 23, 2023 at 08:23:58PM +0530, Shreenidhi Shedi wrote:
>>>> Currently Makefile.modinst does three tasks on each module built:
>>>> - Install modules
>>>> - Sign modules
>>>> - Compress modules
>>>>
>>>> All the above tasks happen from a single place.
>>>>
>>>> This patch divides this task further and uses a different makefile for
>>>> each task.
>>>> Signing module logic is completely refactored and everything happens
>>>> from a shell script now.
>>>>
>>>> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
>>>> ---
>>>>    scripts/Makefile.compress |  53 ++++++++++++++++++
>>>>    scripts/Makefile.install  |  66 +++++++++++++++++++++++
>>>>    scripts/Makefile.modinst  | 111 +++-----------------------------------
>>>>    scripts/Makefile.sign     |  37 +++++++++++++
>>>>    scripts/signfile.sh       |  24 +++++++++
>>>>    5 files changed, 186 insertions(+), 105 deletions(-)
>>>>    create mode 100644 scripts/Makefile.compress
>>>>    create mode 100644 scripts/Makefile.install
>>>>    create mode 100644 scripts/Makefile.sign
>>>>    create mode 100755 scripts/signfile.sh
>>>
>>> As you are touching the build process, you should always cc: the proper
>>> mailing list, and the KBUILD maintainer.  Please do so for this series,
>>> as that is the proper tree for this to go through.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Thanks for the inputs Greg.
>>
>> CC-ing linux-kbuild@vger.kernel.org as suggested.
> 
> This doesn't actually do anything, sorry.  Please resend the whole
> patchset again and add the proper people and list.
> 
> thanks,
> 
> greg k-h

Done. Addressed comments from Masahiro Yamada and sent a new patch 
series, hopefully I have added everyone this time :) Thanks.

-- 
Shedi

