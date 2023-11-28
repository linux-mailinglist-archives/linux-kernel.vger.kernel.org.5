Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E947FC568
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345818AbjK1U3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345786AbjK1U3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:29:20 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D0C19A7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:29:26 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b8929269a0so272985b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701203365; x=1701808165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvt+0jiHGDPEXGWp4ZUeTSZX/GfEE6mq7HiGkqqcPN0=;
        b=YN9dStQQR9PxRz3pqydJDqEn5TQMF+BJd0ZZdbhYrA0VIUPZ2FuQFNtOROFUiLL6No
         NiKm3FgdlRNYeHBDQkhxmV9Yg3XxZkhkCH/4ac+91ncD1z0PCcnh2Skc0iX4H/gMdxyO
         aXwzs+vbkM63CaWwGs1NS/Ns3OlBpOEXl4WyBrLBLeWhyvF41sy5YlG2JBIJ3mSfwalk
         vpiH97AlZPNHaFlBHjNRYAOmplv2XuA3d+TvhEQXLFfQjrZ5HxV1AFGy3add8hcc32ty
         bFuA+c+Y9vZzhIN9CflBuSL4xuYe/d9ElxWBhJswhB4pmjncow3sifx5vu2alSiSvXaE
         0JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701203365; x=1701808165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvt+0jiHGDPEXGWp4ZUeTSZX/GfEE6mq7HiGkqqcPN0=;
        b=MCT2dCTuu25yMpRalbR7soIvqKZ9uCTD+MWrYhnKeoAE1Bo+mnEqvQPkh3T6kN65Vm
         Ox+xdE8aKCCfNOaLDhlGRH5k+3aoUeBAwIRVCLCy7cE5ofPqK2M9UCsKAJB2nG9Sf09/
         d35sh49dG/2hY7WK+lVvAiB/LGbCA418k7yoF1XdFWEZ1DRu3eOQ4ns8ah5jGvRBicHg
         2E8Dy1Vh8hby3PtFySNJvpE48ubeP5k1j4cAmR34Uax4U0DsG3U02HSTClt3ORWe6Wwf
         ipOvilkOh0XXO3SlnQCm4ESuxXQV5n2ks4QN+6uBFE+AyfZZkYKsQo3EKh8iQXqR+OE2
         BLqg==
X-Gm-Message-State: AOJu0YzWdo3+6CJyi4XnEFxqyIJWW62pURp2S4Nf0W1Q0RELFx9iaP3m
        fslvhWukHJV46alGxTjk12wOrQ==
X-Google-Smtp-Source: AGHT+IH1AMb0wvmjly+Gb2M1jv/sGk5FjXtFf3fxlEgnnu+/RlL7wn+A3EsF3kPCAgb5HqebLh2sRA==
X-Received: by 2002:a05:6808:398e:b0:3b8:5bae:83ad with SMTP id gq14-20020a056808398e00b003b85bae83admr17915369oib.17.1701203365354;
        Tue, 28 Nov 2023 12:29:25 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i7-20020a056808030700b003b8347de3c2sm1933081oie.19.2023.11.28.12.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:29:24 -0800 (PST)
Date:   Tue, 28 Nov 2023 12:29:22 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "kito.cheng@sifive.com" <kito.cheng@sifive.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Shadow stack enabling from dynamic loader v/s kernel on exec
Message-ID: <ZWZNothlvzQKStOc@debug.ba.rivosinc.com>
References: <CAKC1njRkpaqbAFWrZpz75u4M-T8mniY2QHVZEENameqnHOOGPg@mail.gmail.com>
 <d36b02fc0da364ea0d660e5e5ecac9df7e327f79.camel@intel.com>
 <ZWXiYCs45Ryb6UMf@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZWXiYCs45Ryb6UMf@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:51:44PM +0000, Mark Brown wrote:
>On Mon, Nov 27, 2023 at 05:41:16PM +0000, Edgecombe, Rick P wrote:
>> On Wed, 2023-11-22 at 16:19 -0800, Deepak Gupta wrote:
>
>> Thanks. As we look at adding some final glibc support, I've wondered if
>> there might be enough topics to warrant an occasional meeting to
>> discuss stuff like this. I'd also like to discuss the shadow stack life
>> cycle issues (uncontext, etc), alt shadow stacks and all of the
>> compatibility last mile problems. Towards the goal of avoiding
>> unnecessary divergence on app developer expectations.
>
>It'd definitely be good to ensure we're coordinating well, I'd be
>willing to give it a go.

Same here.
