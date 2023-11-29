Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDB7FCCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjK2CPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjK2CPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:15:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEC41BC2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701224121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKn2JYUpqV3wbekajb5ZS+im7PxpappcmYXHnPLCMOg=;
        b=gAVfI7eHG1gu12VqbxBXfHIhKnKp9KGuUJbKpVIP4unQUSGeiTeK4LphSuryLLPaRH5yaa
        ROhj0VGdvWki6OuE2LbupQ25L8FRIypfUC2PrEwpGTI2vSXtLhAh1X8H5hC6Em53c0cPxf
        p38GN5oCfyeXwmnotbciKbweFPk2j5U=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-E-yPiy5tMC6WzbiZWoCStA-1; Tue, 28 Nov 2023 21:15:17 -0500
X-MC-Unique: E-yPiy5tMC6WzbiZWoCStA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50bc2046839so648034e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701224115; x=1701828915;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKn2JYUpqV3wbekajb5ZS+im7PxpappcmYXHnPLCMOg=;
        b=t1b9Yfw9CxG7pCssyxx7QVDy0w2V5SPlux5B5vHco4juRl6+XvqKQRG7rvGuozp0pz
         clFNRgWf9iL0uQmrTjiFVaAu87VajNHSDrquRGWT4DyOnUXhDLTE4oOZjFVyUkFbGEsx
         OmYn74XNhgDnm8QBGoYuHBk5RLmwn9VsxyYAV3a1VS9xX938xt2IaWxGGr9nAoj608vu
         WkCI9eMglAdQ6BPguyqSZFDTchavSTfQN8at27Lig2k219igGm5QA9vjOpZlSOwiweVH
         umzHGHsV30YXXYFsymby82K5ouJ8DS1aYNg384eWVq+xwAnCNKEtk8iBk+yOlbaZr2Di
         T6QA==
X-Gm-Message-State: AOJu0YyGYQy1bWstMQYdryua0kZ1RFUsBnUYSHl0Vu4pJ74jRVouRUMP
        3u2jwAQz/Lokm18I+aoYi4PV/ID93fcIVuQg/omPCilyvEDC1T4eNiDz31h4XX3lX87FOAt3l3I
        ZduVnox1c1d2UkwysRm0+ZddlZY/kRE7f
X-Received: by 2002:a05:6512:3196:b0:50b:aa13:a761 with SMTP id i22-20020a056512319600b0050baa13a761mr9265068lfe.46.1701224115753;
        Tue, 28 Nov 2023 18:15:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS+WKRxrSYw288wOgG/cqzoj+euT0xS28Xc6/AGsdA9evhonP2l07Xitf1dqCow9oSCeSsQQ==
X-Received: by 2002:a05:6512:3196:b0:50b:aa13:a761 with SMTP id i22-20020a056512319600b0050baa13a761mr9265061lfe.46.1701224115460;
        Tue, 28 Nov 2023 18:15:15 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090632cd00b009ca522853ecsm7358196ejk.58.2023.11.28.18.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 18:15:14 -0800 (PST)
Message-ID: <81ba79d1-8e7a-41d9-acaf-64f3eee1b97d@redhat.com>
Date:   Wed, 29 Nov 2023 03:15:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Nouveau] [PATCH][next] nouveau/gsp: replace zero-length array
 with flex-array member and use __counted_by
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Timur Tabi <ttabi@nvidia.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>
Cc:     "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ZVZbX7C5suLMiBf+@work> <ZVZxXiXYIzEwUE3N@pollux>
 <6517a6a41eb72d16596c913dc56467e0390287a3.camel@nvidia.com>
 <4b10068c-4285-41df-b4bb-4c61ac70a30b@redhat.com>
 <f0662715-928d-4685-8f88-f2129eddab3c@embeddedor.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <f0662715-928d-4685-8f88-f2129eddab3c@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 02:06, Gustavo A. R. Silva wrote:
> 
> 
> On 11/28/23 19:01, Danilo Krummrich wrote:
>> On 11/16/23 20:55, Timur Tabi wrote:
>>> On Thu, 2023-11-16 at 20:45 +0100, Danilo Krummrich wrote:
>>>> As I already mentioned for Timur's patch [2], I'd prefer to get a fix
>>>> upstream
>>>> (meaning [1] in this case). Of course, that's probably more up to Timur to
>>>> tell
>>>> if this will work out.
>>>
>>> Don't count on it.
>>
>> I see. Well, I think it's fine. Once we implement a decent abstraction we likely
>> don't need those header files in the kernel anymore.
>>
>> @Gustavo, if you agree I will discard the indentation change when applying the
>> patch to keep the diff as small as possible.
> 
> No problem.

Applied to drm-misc-fixes.

> 
> Thanks
> -- 
> Gustavo
> 
> 

