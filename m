Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E878807A75
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442961AbjLFVbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379773AbjLFVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:31:06 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5CCD4B;
        Wed,  6 Dec 2023 13:31:13 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d7e56f6845so172152a34.0;
        Wed, 06 Dec 2023 13:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898272; x=1702503072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXOKcwNylDDzpj359uSheKfusXLn+oML8Kk/hPty+vk=;
        b=trLYAjApi+4jVlwzW0SLWoeRfikk/L2itL6GTuBd6q6c82gAHTMLCFvv6DNqLted6w
         QhlHnk2QHWvsk9bzfZ5+7J6kkL5uMdgXmNeLJyqVL05ZWAagjxShl95gs1bZeD4KjfX9
         amp8ODwkC0NMkkSP+QA3qFRIFAo3dFZ6oT9Z45ILSptS5CULQUjAF0EleiuX2VLhPxDK
         XOR411cl0vsBARPIvLxRp+DxGe69YPGXn4LFCrr48KvNwhvsjEjYeEkZwC2Nieesimr1
         YVKqcm3xVo5vBL7/6o76x3z9WPz56Xc3UQiOhY2wdq/r8PwpmZmmtUataLg/saxk625m
         TmMA==
X-Gm-Message-State: AOJu0Yw8ebGlZMqyzP96ZqIFL3r/wYjYj3AJk0djkgHGaBJPCXthJb9C
        2y3vMey+jcJXgYnXOzqa1Q==
X-Google-Smtp-Source: AGHT+IFtumfUIKo6aBSB0vh1CEIuF8AUYhrVdYrLyd/wuCnXSl+flurWmeZTod8cYMx1talrMVK7jA==
X-Received: by 2002:a9d:7dd5:0:b0:6d8:585b:410b with SMTP id k21-20020a9d7dd5000000b006d8585b410bmr1698733otn.8.1701898272290;
        Wed, 06 Dec 2023 13:31:12 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n16-20020a9d7410000000b006d94fa88156sm114804otk.14.2023.12.06.13.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:31:11 -0800 (PST)
Received: (nullmailer pid 3358370 invoked by uid 1000);
        Wed, 06 Dec 2023 21:31:10 -0000
Date:   Wed, 6 Dec 2023 15:31:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, frowand.list@gmail.com,
        dinguyen@kernel.org, chenhuacai@kernel.org,
        tsbogend@alpha.franken.de, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        mpe@ellerman.id.au, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        chris@zankel.net, jcmvbkbc@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com
Subject: Re: [RFC PATCH v2 2/6] of: reserved_mem: Swicth call to
 unflatten_device_tree() to after paging_init()
Message-ID: <20231206213110.GA3345785-robh@kernel.org>
References: <20231204185409.19615-1-quic_obabatun@quicinc.com>
 <20231204185409.19615-3-quic_obabatun@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204185409.19615-3-quic_obabatun@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:54:05AM -0800, Oreoluwa Babatunde wrote:
> Switch call to unflatten_device_tree() to after paging_init() on other
> archs to follow new order in which the reserved_mem regions are
> processed.

You did this so that you could allocate memory for the reserved regions. 
But unflatten_device_tree() can already do allocations using memblock. 
So the same thing should work for you.

I suspect that moving this will break any arch that called an of_* API 
between the original call and the new call location.

Rob
