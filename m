Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D500754273
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbjGNSSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjGNSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384AB109
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689358637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hk6SCuBB1VWMrgz6HbTiscgnqy5TrgcBcKbev/PC7PQ=;
        b=Y+XMxaFZbrg6WWbUD9gZdTMcGyDKqgLTauibT4xpiVlNt7s9AM5lEqkRguK9VrFRy4MzMU
        iaWKANtSIuJ0br+oL53paZFu7MikycgOxfIZmMLpvJaP7THFYljtx8x2V2BsQ3QP0MHJm4
        6VKoVzv2n7rpwBa+zEuaebkfPySi2LI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-gWIR6kE6PzGpKslMoK-u0Q-1; Fri, 14 Jul 2023 14:17:16 -0400
X-MC-Unique: gWIR6kE6PzGpKslMoK-u0Q-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-403c1294d95so24486861cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689358635; x=1691950635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hk6SCuBB1VWMrgz6HbTiscgnqy5TrgcBcKbev/PC7PQ=;
        b=mEdJjv2lXCECry1C31dLkT1Mi0PK/Bj6S7Tt7BT+Oxsdde3READALJBTl51aDEY3i2
         KlGoAl0JaGipok4OD1jbvcGZQuIQ5CKmlLRs/c+uXXhOklZctIwW1GSYEc5XUDxdiHyh
         0WJSRl09D0qcdWEad8i5GY4880WJYwLWG6AfYel564cfAIyolXqE97ZHuR7OtlqWVnjp
         wujN5kh6UVlIcsNKER9w0NerPJrUTw151xl5gZUhkw0hPZJYeT1C7M6vtlJOnDIt3eVs
         Kt11KU+bZW42Crfb+EhI1rGgLnEFdafRe68Hexjh0V6m6PL5UDoPBg6pi1V2KsRjywuT
         PG3A==
X-Gm-Message-State: ABy/qLaFQwAOBC1oLi/yXhnhmTxUl/gmsKKsuVTVkM4h3KBxS65dLTMm
        lgnv0nSFrP/WUAHtHmHAC4o64RIF0lzK+OzdVZD1Cec2oH6y/EVns4pOgWcOfMjS7FnnLlmPhLH
        2UAk0+IA8ISHXoLz626CvgfO8rpMyr/Pk
X-Received: by 2002:ac8:598b:0:b0:403:b969:a80c with SMTP id e11-20020ac8598b000000b00403b969a80cmr8280840qte.23.1689358635436;
        Fri, 14 Jul 2023 11:17:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE0Z++4VssRRjhM9Urv92cMb5fKLeaRS4Y79rMc+mqJqlStyBpQdoJ89Vie/9RF3194St3JCQ==
X-Received: by 2002:ac8:598b:0:b0:403:b969:a80c with SMTP id e11-20020ac8598b000000b00403b969a80cmr8280820qte.23.1689358635128;
        Fri, 14 Jul 2023 11:17:15 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::17])
        by smtp.gmail.com with ESMTPSA id a21-20020aed2795000000b004039e9199cesm4144405qtd.60.2023.07.14.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:17:14 -0700 (PDT)
Date:   Fri, 14 Jul 2023 13:17:12 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Ninad Naik <quic_ninanaik@quicinc.com>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppareek@quicinc.com,
        psodagud@quicinc.com, quic_kprasan@quicinc.com
Subject: Re: [PATCH] pinctrl: qcom: Add intr_target_width to define
 intr_target_bit field width
Message-ID: <p5vyji2weclwgshyxbf2evzpzefckzyecjnoada7dvzbuenxsb@55abp36rrbub>
References: <20230714061010.15817-1-quic_ninanaik@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714061010.15817-1-quic_ninanaik@quicinc.com>
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

On Fri, Jul 14, 2023 at 11:40:09AM +0530, Ninad Naik wrote:
> SA8775 and newer target have added support for an increased number of
> interrupt targets. To implement this change, the intr_target field, which
> is used to configure the interrupt target in the interrupt configuration
> register is increased from 3 bits to 4 bits.
> 
> In accordance to these updates, a new intr_target_width member is
> introduced in msm_pingroup structure. This member stores the value of
> width of intr_target field in the interrupt configuration register. This
> value is used to dynamically calculate and generate mask for setting the
> intr_target field. By default, this mask is set to 3 bit wide, to ensure
> backward compatibility with the older targets.
> 
> Signed-off-by: Ninad Naik <quic_ninanaik@quicinc.com>

Thanks for the patch. Naive question (without really reading the code),
but what practical affect does this have?

i.e. does this change behavior of how IRQs were handled before this
patch vs after on this platform?

To shed some light on the question, there's a GPIO IRQ for the ethernet
phy on this platform that is purposely _not_ described because it didn't
ever trigger, resulting in the interface staying down. Things work
fine without the IRQ (the driver goes into polling mode).
The explanation I got was very brief and attributed it to a "hardware issue".

I'm wondering if I should re-evaluate that, and if this was the
"hardware issue".

Thanks,
Andrew

