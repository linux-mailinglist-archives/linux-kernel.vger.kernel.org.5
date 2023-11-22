Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607977F51A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjKVU3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKVU3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:29:07 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2781B9A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dGgYBtPaNkz+NxmhFb7ZvVAiX42aZMlvMkpZ6HlBFVw=; b=Feg7DpwLlnWD3LTpkA08M3Gg0F
        LFRp0VDueKotk4Gcu5iGti02Rgic0ihhonOYctmgp7Q/nIUF6MehpE43BOKeUG23Io4d2G4snp+ng
        gZRSma4BTxueV0gtjkK6BdAuj80fVgNAKqFHwcm85cEmFnraoas7zbvrcBAdkxPCxZDeT2iNLROAU
        Tc+RAyhDz872OuZ2eC+TLRr0HZItiFXx1xb+mf6/ey3W1nAJSuSlOjp+JzewPlG5IeuFYTPQFvyRd
        bxVFc7umgMDjyIwydXTk1ZwhHxGDfhdKaSpTFMOKGxgeG0rXvjkgrIBVMTDUQimpoVcti2ZRvaWTu
        n6VdKdBg==;
Received: from 189-69-166-209.dial-up.telesp.net.br ([189.69.166.209] helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1r5tpw-0065hQ-Ea; Wed, 22 Nov 2023 21:28:40 +0100
Message-ID: <50ff86d4-5ce1-4ae5-aafb-ce3bc0069629@igalia.com>
Date:   Wed, 22 Nov 2023 17:28:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] drm: Add support for atomic async page-flip
Content-Language: en-US
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        intel-gfx@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Pekka Paalanen <ppaalanen@gmail.com>, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        xaver.hugl@gmail.com, linux-kernel@vger.kernel.org
References: <20231122161941.320564-1-andrealmeid@igalia.com>
 <cc10f6b0-e26e-4021-85ca-33cb1e58e937@amd.com>
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <cc10f6b0-e26e-4021-85ca-33cb1e58e937@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hamza,

Em 22/11/2023 17:23, Hamza Mahfooz escreveu:
> Hi André,
> On 11/22/23 11:19, André Almeida wrote:
>> Hi,
>>
>> This work from me and Simon adds support for DRM_MODE_PAGE_FLIP_ASYNC 
>> through
>> the atomic API. This feature is already available via the legacy API. 
>> The use
>> case is to be able to present a new frame immediately (or as soon as
>> possible), even if after missing a vblank. This might result in 
>> tearing, but
>> it's useful when a high framerate is desired, such as for gaming.
>>
>> Differently from earlier versions, this one refuses to flip if any 
>> prop changes
>> for async flips. The idea is that the fast path of immediate page 
>> flips doesn't
>> play well with modeset changes, so only the fb_id can be changed.
>>
>> Tested with:
>>   - Intel TigerLake-LP GT2
>>   - AMD VanGogh
> 
> Have you had a chance to test this with VRR enabled? Since, I suspect
> this series might break that feature.
> 

Someone asked this question in an earlier version of this patch, and the 
result is that VRR still works as expected. You can follow the thread at 
this link:

https://lore.kernel.org/lkml/b48bd1fc-fcb0-481b-8413-9210d44d709b@igalia.com/

I should have included this note at my cover letter, my bad.

Thanks,
	André
