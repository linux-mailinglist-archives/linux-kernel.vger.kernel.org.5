Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84E7A8AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjITRzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjITRzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94490DC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695232500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5xYFinNZipHsHGmHUqZFR1epFlz8wPv/8ryGu1Ybe8=;
        b=TkI/3/86NJCEXVvamz1vLwb8rTym/0BNZ4FtOe9aeTUstWOXdALWFchDfJ4H0VakgC8CHk
        oRB3T1dU0cI5LUDBn31m85q5GOsbSjDqo4f6HAjVHjuRTRkxxD+e2lexI3qCEPrha/o0V8
        ncb2RnUPI7mtI6QhPNj2oG2CetFwBjQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-u-cN4DzaM1SPE-Bgrqn_Sw-1; Wed, 20 Sep 2023 13:54:59 -0400
X-MC-Unique: u-cN4DzaM1SPE-Bgrqn_Sw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40525249280so642295e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695232498; x=1695837298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5xYFinNZipHsHGmHUqZFR1epFlz8wPv/8ryGu1Ybe8=;
        b=Z6A+C+/riHR6FS2s5/mo1tYD2iY1kuLGZ9aGF6hRfEZtItoClRWoMznjDVcLPbwmxE
         wPog5tpkFyHrAGziftwneI8Qyp/wvR/k1mND9GTrzrzBnEUaorwSUgAGdkCsisfUfVJg
         wpGnZihSIabJUmbibK2Yapc2dw3MInEIDMcwmS42Aqzwf6HQgz8bzEO7hzRkEMLoAtdk
         8Ew6NZm4uyxfb2wnVZ+sdySzbDRE8SxWpgH1Tb7EHkUBh7deZbTznP5qk4nqkZ5lh5BQ
         0H+LDZSU4SC7Mnk9KUa85j4VGkWgAEe8YDytZAV07euuR0/ecPR4pJZiBo29OTskGC+k
         aqEQ==
X-Gm-Message-State: AOJu0YxcmMXVLRx8wPKCvtaqJ34oqqTzqNIDMOD3wg/Heo2I/AA/oRje
        jkvVeZSoY8mK9ue0PPXJ8mJsnp2xvbRoPU1N9IOdkbVU/s8n0yKuOVyFrYJ81bfjyUn1+3jeOne
        z6/ZXXyFg52Znih2Yet4oRP+w
X-Received: by 2002:a7b:ce88:0:b0:400:57d1:4910 with SMTP id q8-20020a7bce88000000b0040057d14910mr3302437wmj.17.1695232497848;
        Wed, 20 Sep 2023 10:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnadv5Rrllbv+1DebvWmStjUdr36msQ4bItIjpfqmG73HPxauN1Zj4NCrq5iVMGFuoky2thA==
X-Received: by 2002:a7b:ce88:0:b0:400:57d1:4910 with SMTP id q8-20020a7bce88000000b0040057d14910mr3302418wmj.17.1695232497523;
        Wed, 20 Sep 2023 10:54:57 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id g7-20020a05600c310700b003fe15ac0934sm1501378wmo.1.2023.09.20.10.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:54:54 -0700 (PDT)
Message-ID: <facdf62c-d0b4-597d-a85d-5772ecaa2b86@redhat.com>
Date:   Wed, 20 Sep 2023 19:54:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 33/38] x86/entry: Add fred_entry_from_kvm() for VMX to
 handle IRQ/NMI
To:     Xin Li <xin3.li@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, seanjc@google.com, peterz@infradead.org,
        jgross@suse.com, ravi.v.shankar@intel.com, mhiramat@kernel.org,
        andrew.cooper3@citrix.com, jiangshanlai@gmail.com
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-34-xin3.li@intel.com>
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230914044805.301390-34-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 06:48, Xin Li wrote:
> +	/*
> +	 * Don't check the FRED stack level, the call stack leading to this
> +	 * helper is effectively constant and shallow (relatively speaking).

It's more that we don't need to protect from reentrancy.  The external 
interrupt uses stack level 0 so no adjustment would be needed anyway, 
and NMI does not use an IST even in the non-FRED case.

> +	 * Emulate the FRED-defined redzone and stack alignment.
> +	 */
> +	sub $(FRED_CONFIG_REDZONE_AMOUNT << 6), %rsp
> +	and $FRED_STACK_FRAME_RSP_MASK, %rsp

