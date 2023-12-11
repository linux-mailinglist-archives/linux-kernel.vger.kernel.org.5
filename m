Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B180C5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjLKKIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjLKKIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D69511D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702289291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DYAEO6RTuUgtGwPcSA7dzuL0mDsMuuXUhbDs6Puc/4=;
        b=bnd8uzWlNNW1sbnohJGsrO32ORBd+Re+3ZMtRU0N1fQM/VbyO2EAVesntTGIwjMyS/QSwn
        /9/eV5W/ToSGxJehXpFCtCdFiqWTqOYzszNccxx5vhL9gYLizY8UXBhn+2+0Yl96kXj95j
        nxsXBoL69SYHiGoWd1mxhn9Z7b4Wfx4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Nc2jRJNBPdq6yUYVWW7x2Q-1; Mon, 11 Dec 2023 05:08:08 -0500
X-MC-Unique: Nc2jRJNBPdq6yUYVWW7x2Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54cb8899c20so2097811a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289288; x=1702894088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DYAEO6RTuUgtGwPcSA7dzuL0mDsMuuXUhbDs6Puc/4=;
        b=bAktwphE+cPVX3bGzjsacoFn9W7F2ZWUCXjVkfEwsNlhfCRz3FTst4lUXZ32/6xs1H
         0V9qko3rRtbI/CdIjN2S44LpJpCT+an7K+SsCFwZ7YcNyeXqrxoUfxap/3hv4m1/zvxp
         bsCXaO2f/u/x5gyacAhvijqODFmqgLkklaWGF7FXDgKikX2uCrJ2yY9sBRYDCPzp98Qr
         3GjB6FW++8YB3Une5nWOW4GUMaRMDUwAeLnYOvhmCRClUMK2b2P9tu6sfxL8VBWOr6V3
         jRCRshWrwtebIBXwg9bDUY7UNnnEV1kdf6UlBI+sN6WUsVlO5TBM+7+Ni7bsNPf3vah5
         J6Rg==
X-Gm-Message-State: AOJu0YwAQzxzTwGI6ebOBlBBII7Dez7FS6N2enWDblJgBWwg5CQlzeJh
        vVtVdaygrunZDQSASrF7mo96ANfGuZNNxKinKb9DCQgt2K7duHC17c0EL01WeTtz60Fvi8j2Xn3
        VJW1vM4COy1DiKjC0IT2VVzmK
X-Received: by 2002:a05:6402:1399:b0:54d:a654:3109 with SMTP id b25-20020a056402139900b0054da6543109mr2329872edv.67.1702289287844;
        Mon, 11 Dec 2023 02:08:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOCxT8W97sjg8fbX6Cf42Fs3FFCdIiOP/iPB43TGX504dLSj4CGKf10WUJGwDvy51t2mktbA==
X-Received: by 2002:a05:6402:1399:b0:54d:a654:3109 with SMTP id b25-20020a056402139900b0054da6543109mr2329866edv.67.1702289287577;
        Mon, 11 Dec 2023 02:08:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bd18-20020a056402207200b00542db304680sm3469878edb.63.2023.12.11.02.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 02:08:07 -0800 (PST)
Message-ID: <c8d05509-2c53-4db4-a330-b2084e59c10b@redhat.com>
Date:   Mon, 11 Dec 2023 11:08:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] TPMI update for permissions
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231204221740.3645130-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231204221740.3645130-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/23 23:17, Srinivas Pandruvada wrote:
> Process read/write and enabled state for feature drivers. When a feature
> is disabled, don't create a device to load a feature driver. When a read
> is blocked then don't load feature drivers. When write is blocked continue
> to function in read only mode.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans







> v3:
> 	No code change. Rebased on top of 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 review-hans
> 
> v2:
> 	Dropped patch platform/x86/intel/tpmi: Add additional TPMI header fields
> 	Addressed other review comments, details are in each patch
> 
> Srinivas Pandruvada (5):
>   platform/x86/intel/tpmi: Don't create devices for disabled features
>   platform/x86/intel/tpmi: Modify external interface to get read/write
>     state
>   platform/x86/intel/tpmi: Move TPMI ID definition
>   platform/x86: ISST: Process read/write blocked feature status
>   platform/x86/intel-uncore-freq: Process read/write blocked feature
>     status
> 
>  .../intel/speed_select_if/isst_tpmi_core.c    | 25 +++++++++++++
>  drivers/platform/x86/intel/tpmi.c             | 35 +++++++++----------
>  .../uncore-frequency/uncore-frequency-tpmi.c  | 15 ++++++++
>  include/linux/intel_tpmi.h                    | 18 ++++++++--
>  4 files changed, 72 insertions(+), 21 deletions(-)
> 

