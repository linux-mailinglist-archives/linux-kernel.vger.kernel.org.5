Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE77AF8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjI0Drk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjI0Dph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161114EC8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 17:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695773916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZfUoRGmtmsURMuZ/ZaWqNBwx4yTWCRZeeYiles99YKA=;
        b=Kp6uqSi5E1bRz0EDYx2q4hoM0RJKjz+RmeyG2B2l2yuV/pA+FIh+qVfjpInyculMhMq6dl
        EwhZK5Npsn/YCp0mZKMk2BMxi8DZvvPfcHLiWqmV2QNm/jyrXc32LWY+U4D8L4dl7A2sHo
        rYgzCw1CcPca78lMqJGWeEjVCchPtlo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-rMRX_rV-PxGwCdgn41hamw-1; Tue, 26 Sep 2023 20:18:34 -0400
X-MC-Unique: rMRX_rV-PxGwCdgn41hamw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a681c3470fso803831266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 17:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773913; x=1696378713;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfUoRGmtmsURMuZ/ZaWqNBwx4yTWCRZeeYiles99YKA=;
        b=NcUDz/TuOv+XutJLtCDQr0GufJZOZdSK3+T3ru3nnpFB4EIqEpVpOhrTNJlAWNRlei
         KOAskCANDVV9Oc2BkRl8X55DItpDxR4pQAEJDESwIPE7GK+8S2EDQREaYZoqg5LEHq7h
         t3efmldo6rYuNsLRSwmURWnhWI8Lp/PtntrUk653gBceu+uE2dO1HMX3wtmb4ZtgItYy
         21QKXzBCfTBsMHniyQ6ZC1scBU8AaBYB7tqyLBkW7BJi+EdInueW94lwevYlLx3HrGiF
         zdeqH9f+k+0Ru+vTZmvnNWJKGPpPo0vYujwxJhei39t4/kzkbVOiTerO/nzG1IwUKN37
         88Kw==
X-Gm-Message-State: AOJu0Ywfhg9mx5+IilPAL0PDK5/NEHliH1C60dCDBDlt6YcPtw/BUesx
        HjyFcnvnoE4rI/LZ4WuCDoz3Qpm8JppgDnNyfkQrHabgYcV7MdJrNOePZVP2pfsmrBLm5Ktj+HZ
        HHxQE4qizORi5YoG03eMjBXBl
X-Received: by 2002:a17:906:18aa:b0:9a1:e758:fc73 with SMTP id c10-20020a17090618aa00b009a1e758fc73mr198553ejf.67.1695773913372;
        Tue, 26 Sep 2023 17:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+wIMu+OJK6/VompfluO9KYwsYp0o7+KpOhz1siwgDos3xBjAIZ2dWHdrm0YJEKFaJIu47TA==
X-Received: by 2002:a17:906:18aa:b0:9a1:e758:fc73 with SMTP id c10-20020a17090618aa00b009a1e758fc73mr198539ejf.67.1695773913005;
        Tue, 26 Sep 2023 17:18:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090671d600b0099bcdfff7cbsm8369150ejk.160.2023.09.26.17.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 17:18:32 -0700 (PDT)
Message-ID: <2b062434-fcbd-de2b-decd-5000b63c2e6f@redhat.com>
Date:   Wed, 27 Sep 2023 02:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next 1/3] drm/sched: implement dynamic job flow
 control
Content-Language: en-US
To:     Luben Tuikov <luben.tuikov@amd.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com,
        boris.brezillon@collabora.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230924224555.15595-1-dakr@redhat.com>
 <312983ee-ba4c-477e-8846-072c815df862@amd.com>
 <f6294659-042d-46eb-ae6e-716a6c51872d@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <f6294659-042d-46eb-ae6e-716a6c51872d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/27/23 01:48, Luben Tuikov wrote:
> Hi,
> 
> Please also CC me to the whole set, as opposed to just one patch of the set.
> And so in the future.

There is no series. I created a series in the first place, but finally decided to
send this one and a few driver patches separately. However, I just accidentally
sent out the wrong one still containing the "1/3" addition.

- Danilo

> 
> Thanks!

