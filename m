Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0337FCC23
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjK2BB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2BB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:01:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E78C1707
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701219690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSGCciYfFxwIPQRFv+/e0JSlg77OghN2r+cuBAMmVKU=;
        b=Ba3UZdr0ViBX0EW5P1G8waoDJ9p4kFWRF/L5B88n7UIGdshqfhVafTPZVknFwOdIyMONTj
        6cFuflTuS/ys08ix/QtnBcMU0180ashAM3iTNeD88xRsfc7m1Cjcz6Dnuru+Mqs9fC5ukJ
        Zezdb7I7QSGUPLt/cNN9L3yc3GLMYI4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-uKFA-c_qPkmjqU5_hNC6OA-1; Tue, 28 Nov 2023 20:01:28 -0500
X-MC-Unique: uKFA-c_qPkmjqU5_hNC6OA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a01c7b09335so496844266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701219687; x=1701824487;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSGCciYfFxwIPQRFv+/e0JSlg77OghN2r+cuBAMmVKU=;
        b=OazplOfANBDsSRN5PHBd/RwfTq6sMmRFQ8QLVocET0WrD97fXc4HYlAg/AgFBf4BlL
         7kghXqMSHGgFyT6xQ7BUBAP+SB+vg/99kKQBEBlL3GBrydO8XCeS/kQX787psfIYaO31
         Gw1XXIPFbV9+trYl94XKmQxTogon+NVOYjZxtYng7OS1d5HW7A+h87D+lSQJ92dNjmeb
         0m7aGPo7Whf+K5gxzJEsOR6++Pz9O3c6sL3GQdSCeBEM+DX1246Ysw2aidzwThVyKYJH
         zNRivdYaZF+8PVat9ZWwzScz0U4u9z00CqOqB85n4vTOYxGJVkenjYRKG++LrqQ0dudl
         1xkQ==
X-Gm-Message-State: AOJu0Yx6jmzrYziMh2Y9k8aZ8opj8lDBVlUpSxp90Gxeea02icVxWK3X
        VukY8koULMp/pNHaLOo0sB1MhZ9j4HDj5YAbL3C0h6U8ZDiaHLkQUv9+JLrlXvxaoSoQKsTEr48
        BFYyjHMdEA+NW4nXihom5UC82
X-Received: by 2002:a17:906:2886:b0:9fd:1cd7:f68d with SMTP id o6-20020a170906288600b009fd1cd7f68dmr12528230ejd.67.1701219687679;
        Tue, 28 Nov 2023 17:01:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQeFU/7OCm3a5OIDfphx7EB9HRSJKIcJpYxpSBNBkpXwboirjbwJAVpjyUf3WaykM2UmUoVQ==
X-Received: by 2002:a17:906:2886:b0:9fd:1cd7:f68d with SMTP id o6-20020a170906288600b009fd1cd7f68dmr12528216ejd.67.1701219687427;
        Tue, 28 Nov 2023 17:01:27 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id o12-20020a1709064f8c00b00a01892903d6sm7264891eju.47.2023.11.28.17.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 17:01:26 -0800 (PST)
Message-ID: <4b10068c-4285-41df-b4bb-4c61ac70a30b@redhat.com>
Date:   Wed, 29 Nov 2023 02:01:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Nouveau] [PATCH][next] nouveau/gsp: replace zero-length array
 with flex-array member and use __counted_by
Content-Language: en-US
To:     Timur Tabi <ttabi@nvidia.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>
Cc:     "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ZVZbX7C5suLMiBf+@work> <ZVZxXiXYIzEwUE3N@pollux>
 <6517a6a41eb72d16596c913dc56467e0390287a3.camel@nvidia.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <6517a6a41eb72d16596c913dc56467e0390287a3.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 20:55, Timur Tabi wrote:
> On Thu, 2023-11-16 at 20:45 +0100, Danilo Krummrich wrote:
>> As I already mentioned for Timur's patch [2], I'd prefer to get a fix
>> upstream
>> (meaning [1] in this case). Of course, that's probably more up to Timur to
>> tell
>> if this will work out.
> 
> Don't count on it.

I see. Well, I think it's fine. Once we implement a decent abstraction we likely
don't need those header files in the kernel anymore.

@Gustavo, if you agree I will discard the indentation change when applying the
patch to keep the diff as small as possible.

- Danilo

> 
> Even if I did change [0] to [], I'm not going to be able to add the
> "__counted_by(numEntries);" because that's just not something that our build
> system uses.
> 
> And even then, I would need to change all [0] to [].
> 
> You're not going to be able to use RM's header files as-is anyway in the
> long term.  If we changed the layout of PACKED_REGISTRY_TABLE, we're not
> going to create a PACKED_REGISTRY_TABLE2 and keep both around.  We're just
> going to change PACKED_REGISTRY_TABLE and pretend the previous version never
> existed.  You will then have to manually copy the new struct to your header
> files and and maintain two versions yourself.
> 
> 
> 

