Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D42F7BC031
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjJFUSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjJFUSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB51F109
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696623462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cauyGxPXg9Dqki16H5wczwQOTEld3BMCtuai5OgK+Nw=;
        b=gca0Omboqa6igbj3dhd+rYk54xPtk7a4VuAu8pvDCci6VoeOjJABcS+6PEuM7YT/z396jx
        LgmIXLLRLnMMaaR41lqoDCAZbg9chMl2nt6H/uh/t8bplGwevIRbjCQhMhl1smSPvQ+Mw1
        9NASC6XAxC1CcdZ9XDpG0HxWDklHn5o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-ETlV1m30MDqXFQpNONl9xA-1; Fri, 06 Oct 2023 16:17:36 -0400
X-MC-Unique: ETlV1m30MDqXFQpNONl9xA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-774335cb98cso255995085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623455; x=1697228255;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cauyGxPXg9Dqki16H5wczwQOTEld3BMCtuai5OgK+Nw=;
        b=CsvfKeqMOX11Htwcy8LvqyT9PJ9QqLyEt/EdnT/mYkX1k58gEqfFvENQxCdXEepkcH
         fOm4lgJstgPvf5eLYCH9UHfTQgOVsOVIdpsCbORr6A5vB1WT5UrJNyg92TO6LLamt+Fj
         uDhCmZVBvbLa4jFIHRtIk+GV7zrl9BI3mE+lh2+9C8weXplBzAnLYcfAphHznyHUOysA
         YmrD7ZgIP7zcsSL2J05gMUX1CghtSbyQn1ks9zHqEabquqC41S6lxVeeZ7GfUFsh9rYD
         XtrZe0glEcxJDkVZ9IQK3ik0+3ovwyMlsWj0THQKNRWiUK8VpcGeJr04FBGy07Q4D/ai
         fYFQ==
X-Gm-Message-State: AOJu0Yyh/1XfSS4YbGk/YqJcEHVcEzXR0Mza92sjLGa9MYao8ZkKcwSb
        FuVmmjketY20AH/gzrO4FdBIOVFW5m5Cada3vzoO5dGCqDs1csQLAvWxwCSG5sUlg8vN6+bzVDk
        326FGEKKUgi4mBMXZUebi68/g
X-Received: by 2002:a05:620a:4489:b0:76f:20df:f038 with SMTP id x9-20020a05620a448900b0076f20dff038mr11224083qkp.12.1696623455778;
        Fri, 06 Oct 2023 13:17:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzdJwo4Lu0XqeCt5pKxLkTdXoxw67dKVHpvuq2Ezi/7kUtOb2wNQ5MEHDrEkr1H47Bbgm2Nw==
X-Received: by 2002:a05:620a:4489:b0:76f:20df:f038 with SMTP id x9-20020a05620a448900b0076f20dff038mr11224050qkp.12.1696623455499;
        Fri, 06 Oct 2023 13:17:35 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id ow10-20020a05620a820a00b0076f35d17d06sm1554711qkn.69.2023.10.06.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:34 -0700 (PDT)
Date:   Fri, 6 Oct 2023 16:17:32 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/2] firmware: arm_scmi: Add qcom smc/hvc transport
 support
Message-ID: <ZSBrXOsYayiA97oi@brian-x1>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20231006164206.40710-1-quic_nkela@quicinc.com>
 <20231006164206.40710-3-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006164206.40710-3-quic_nkela@quicinc.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 09:42:06AM -0700, Nikunj Kela wrote:
> This change adds the support for SCMI message exchange on Qualcomm
> virtual platforms.
> 
> The hypervisor associates an object-id also known as capability-id
> with each smc/hvc doorbell object. The capability-id is used to
> identify the doorbell from the VM's capability namespace, similar
> to a file-descriptor.
> 
> The hypervisor, in addition to the function-id, expects the capability-id
> to be passed in x1 register when SMC/HVC call is invoked.
> 
> The capability-id is allocated by the hypervisor on bootup and is stored in
> the shmem region by the firmware before starting Linux.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

