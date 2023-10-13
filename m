Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B952C7C8832
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjJMO75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjJMO7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B4FBB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697209148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YUSH8CafSPbzOw/nGHPE51+m/9D7hUPeYFksiadbyFk=;
        b=D+eNUQIol6oIBxfQIPtawZjQ4I76OtlqbaNRjOLJm/kJtGBovLS+zJ+O9j9u5pKSEUrWdM
        kv0aClBCJPyP59WYCzbZ0gLBJY1AUEhddlY+JEWe3H4BM4O89sn6o/z6kMSAfm/IhMjsnL
        M4VIQZybYzWLvnHOsVBb8XoIdDRblGY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-HmuQq8nuPx-HljtsTZC_SQ-1; Fri, 13 Oct 2023 10:59:06 -0400
X-MC-Unique: HmuQq8nuPx-HljtsTZC_SQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5a7a6fd18abso34393627b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209146; x=1697813946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUSH8CafSPbzOw/nGHPE51+m/9D7hUPeYFksiadbyFk=;
        b=KZaGWqZEgyE66JBoSBtvi8dR7blw8ddzbCD1cOVgDK1gIQPnfHDtOeS3dIqFHHWSO9
         7abrPigLlof/e/YcgXynJH6wREElv2Q+2SRQhpU+7LDP2ysXDtAO72gxtZj/us/jxAb2
         XrHz37qRP+2+1p87QoplcRDjbJAWR85Fe8nVq7rQnD/53vnVS09yafbugQK67/ES6EnB
         eCgVGRFZdoPqcbWmXwHs56/1+7i2usL8d4DLDAMkMfJM+ozCNAzR1wyS58zpoNiuxNH/
         sFM1DEvZY6YY9CHD4J7t6zzEK4uxj3Jf49uYmPL39AxXaB1cXElCRWVW033BKjlJcm4W
         Yt2w==
X-Gm-Message-State: AOJu0YyKQQgNtuNKM9BzkrX4IugJmNiQO+CL+Hb4EVdr2ggYsW9P+o/m
        ELR8VYeSfdUxMA2FtORdsaGKwRi/ZMH8BsEdYDzO0SYxcVv/9L28f8tg0rUVYbSiQXaIcd1WZyg
        u2JUE71ZEmM0BB31ACBZ9O+1x
X-Received: by 2002:a81:73c1:0:b0:59b:5d6b:5110 with SMTP id o184-20020a8173c1000000b0059b5d6b5110mr29589081ywc.21.1697209146125;
        Fri, 13 Oct 2023 07:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOAY2Ojc8sODi/GaaDPUOuJ94od6+1qOrI8dlEtJE221nSYH7lO6L2TjoeLIX4Mthhi2LgqA==
X-Received: by 2002:a81:73c1:0:b0:59b:5d6b:5110 with SMTP id o184-20020a8173c1000000b0059b5d6b5110mr29589063ywc.21.1697209145870;
        Fri, 13 Oct 2023 07:59:05 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id k12-20020ae9f10c000000b007742c2ad7dfsm684159qkg.73.2023.10.13.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:59:05 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:59:03 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 04/15] firmware: qcom: add a dedicated TrustZone
 buffer allocator
Message-ID: <uvfqkpusd26asckyeeixfntsvqfe2vrk27lcmafrt6r26qil7n@ea5jfns346ix>
References: <20231013114843.63205-1-brgl@bgdev.pl>
 <20231013114843.63205-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013114843.63205-5-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:48:32PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We have several SCM calls that require passing buffers to the TrustZone
> on top of the SMC core which allocates memory for calls that require
> more than 4 arguments.
> 
> Currently every user does their own thing which leads to code
> duplication. Many users call dma_alloc_coherent() for every call which
> is terribly unperformant (speed- and size-wise).
> 
> Provide a set of library functions for creating and managing pool of
> memory which is suitable for sharing with the TrustZone, that is:
> page-aligned, contiguous and non-cachable as well as provides a way of
> mapping of kernel virtual addresses to physical space.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I'm still on the fence about introducing the Kconfig for the "just
in case the hypervisor is bad on some boards", but I spent a
while looking at this and it all looks good to me, so that opinion
aside...

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

