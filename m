Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65875772D5D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjHGR5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjHGR5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20515170B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691431010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=erccyO3QKy2zFm77CvV1z/W49Rh1dRbioVF76XNszQQ=;
        b=aFJuJD5Swr1tpJEG7nt0DHimrSTyqZGgb5PzF01IpfoIQFryIyTOokx97TzNfUKEPOjIC+
        rywOgv9Vq9QwpG5pKkbP0lfbt7i423TNIU3o56bvqs+1WZhitHaap8BTgHgDdeKyX9+UVn
        ARnpaAJivKrBwDBgkl+LFEmkQl6YEkY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-yJUpBaXXP5yFmk3ysa-3BQ-1; Mon, 07 Aug 2023 13:56:36 -0400
X-MC-Unique: yJUpBaXXP5yFmk3ysa-3BQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bebfada8cso300985966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691430992; x=1692035792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erccyO3QKy2zFm77CvV1z/W49Rh1dRbioVF76XNszQQ=;
        b=edycUXg4rzbsRu+jk7Nx5PkyKKgaPIRkmsB0Iz7EGcUUcvE0JBMQar305+vOjpppoc
         5eyB4ttK1SzvlUHjLEQejxIKOUfeiFSKQ2zB6cbFplNZU9JpEI/druQzCIZ/gMJXELbQ
         tnSHPh6p/WmgnBvbeqsCN0CelkzDkMm7cnOXp+67spTTfApvGnI3P7kfIwNf3f5pTLNY
         x/bU+e2RiTFF/vaoEifKHaBl2vTKYtp+bn93F25tSf7Lciv2bZhheOUMXt3J1oCeRLTZ
         c6ipU3MoN8M19INjsydqn+e9cP53C415wc+oLwCwJ15OQvrdy5FHU6S4tIA3y7y6SEJq
         chvA==
X-Gm-Message-State: AOJu0YzpQ0zB8x8kGxVMNEnAKF4QNdaRLLJlWfTq4jDS89liBvu+gkbH
        Y6JnKYLyOReouz3tPepdzqGNIKMFEzZJIsSeJGQEwDmhvOhvhrlrMWFqM1Nqu+HxIPHnQakSNdO
        +3n1N6v5TdpaqQC4JG9KuC2yd
X-Received: by 2002:a17:906:1ba9:b0:99c:ae06:ffe4 with SMTP id r9-20020a1709061ba900b0099cae06ffe4mr6491017ejg.32.1691430991991;
        Mon, 07 Aug 2023 10:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfuUFo20Lv+j5knb/LsIjGj8TveA2891c0c/kOPERwO3//+FapBzWdXiglzCRBZcRM7N8ZCQ==
X-Received: by 2002:a17:906:1ba9:b0:99c:ae06:ffe4 with SMTP id r9-20020a1709061ba900b0099cae06ffe4mr6491004ejg.32.1691430991728;
        Mon, 07 Aug 2023 10:56:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gs10-20020a170906f18a00b0099caf5bed64sm4340334ejb.57.2023.08.07.10.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 10:56:31 -0700 (PDT)
Message-ID: <d07bdfec-df86-5216-4b9a-533da25fec42@redhat.com>
Date:   Mon, 7 Aug 2023 19:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] x86/cpu: Cleanup of INTEL_FAM6_foo
Content-Language: en-US, nl
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, Tony Luck <tony.luck@intel.com>, luto@kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        jacob.jun.pan@linux.intel.com, lenb@kernel.org,
        irenic.rajneesh@gmail.com, david.e.box@intel.com,
        markgross@kernel.org, srinivas.pandruvada@linux.intel.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20230807123806.700370534@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230807123806.700370534@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/7/23 14:38, Peter Zijlstra wrote:
> Hi,
> 
> I seem to have missed 'spring' but here goes...

Thanks, series looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

For the few small drivers/platform/x86 changes.

Feel free to merge this through whatever tree is convenient.

Regards,

Hans



