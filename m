Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8B677A661
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 14:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjHMMrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 08:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjHMMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 08:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061EFE6F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691930784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBWpp4WcH1Of4gtytpz7Sy6Dwn85bunNSeompfy5hes=;
        b=dFDJqXhUP9mjEwebVTSpcz0Z/mfM+6U21l2ljMNo1wBcZXi8qI6l5X2N4NkZHZaZZQ3TsU
        B+uR/9woaS6cOlyFLj8f5uYMTwzB8OT4US0qf8bii9NDcmLXR96ezk1lGAkgn5HRX3Qr91
        4Bci++xyIRBPYajE1lJCMxhDQ2eum3g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-FqY52UOlNQe7UTV6CdoJAg-1; Sun, 13 Aug 2023 08:46:22 -0400
X-MC-Unique: FqY52UOlNQe7UTV6CdoJAg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe5e67adc6so3251814e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 05:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691930781; x=1692535581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBWpp4WcH1Of4gtytpz7Sy6Dwn85bunNSeompfy5hes=;
        b=caxiLHzPKz8BgRdyoS1cnEmaCNFXYN2WVr1cSy07qJosI0VKnmn/PRWdBeKiM9d9Kq
         8Ej9pCVsidZOSlV1Py3Lm+MHFxzb/+fklnAOU9YRX6JERH+JBKMZBWr88xZHviQ3rcd1
         LyP2deKsYHE0cV6V691Z2yw0IxkLS3QxxAtJE9qm/xCiMMac8lN2Zv2E65A6GmDJte2Y
         LSClYITEishkz9ReSuuPfeaSXFbdtRbxXfnMp1W2L9+0MvUrap+bQpzTPPe5kx2aPnbK
         EvhrUCkT4dmaweo22IXo0YxyPMBFqow5uHtE7stDyz0a5VfYHrwHRRM7Uy4+w4H+baDY
         QziQ==
X-Gm-Message-State: AOJu0Yz22FPurtfZXf2cMbxBF7AbszKoe875eRGl40TjvCg0OPvM5eYx
        P7EjLhNhJABzrh4yzev7yvZvFmHKHPBcml/T7ADopjwS7JvrLUV+OqGUZQQisM/qTpzycD3t9Mn
        odGh1JWcyK6YfasozDz/2r9N/
X-Received: by 2002:a05:6512:3f1:b0:4fd:f876:d86 with SMTP id n17-20020a05651203f100b004fdf8760d86mr3921750lfq.50.1691930781193;
        Sun, 13 Aug 2023 05:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/aL13iYl7Ki9U+aGv7HE/HV0NfqbZ5GExa67Y7/ib88f5ZVpWWJpIJOaWQTp6VPQRZzBG5g==
X-Received: by 2002:a05:6512:3f1:b0:4fd:f876:d86 with SMTP id n17-20020a05651203f100b004fdf8760d86mr3921745lfq.50.1691930780905;
        Sun, 13 Aug 2023 05:46:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090622cc00b009929d998abcsm4529115eja.209.2023.08.13.05.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 05:46:20 -0700 (PDT)
Message-ID: <74589699-de7f-5d11-6988-b41583b341d4@redhat.com>
Date:   Sun, 13 Aug 2023 14:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] platform: sps: Fix an unsigned comparison that can
 never be negative
Content-Language: en-US, nl
To:     coolrrsh@gmail.com, Shyam-sundar.S-k@amd.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
References: <20230813110841.130206-1-coolrrsh@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230813110841.130206-1-coolrrsh@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/13/23 13:08, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> The variable 'mode' is declared as unsigned int in local function.
> The return value of function amd_pmf_get_pprof_modes(dev) is int and
> it is stored in the 'mode' variable. Also the value of 'mode' variable
> is compared with 0 which is signed int by default. Thus redeclaring the
> variable to signed int.
> 
> This fixes warning such as:
> drivers/platform/x86/amd/pmf/sps.c:128:5-9:
> WARNING: Unsigned expression compared with zero: mode < 0
> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

Thank you your patch.

This has already been fixed by a patch which is pending in the pdx86/fixes branch:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=fixes&id=785c00993dc4c4bb2f7b0f3a3f29c03a6f7aab2e
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Regards,

Hans



