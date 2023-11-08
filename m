Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64C7E5A12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjKHPd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjKHPdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9851BE6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699457589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rf6nrc9vsYtHDq5I7rqs8WEwl7hNFdatKiQNbZDf+3g=;
        b=exOfUtARs3XwfbU5bDp0SX5H1urPXDftm49f8tfoUkBcewP0eHvdk22++/mdHjrgMhWrrt
        BEVp7VmrUOJ9CBYybeT6I7pHPq/DgZpOifzq8E31KnZd5XOBt6CHTPiSWZCBy9TV5EVD83
        faWkkjrmqfhm+A9cJ+CVFf11wXWYSzU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Au1iGisSOyGqDPfQWkTQOg-1; Wed, 08 Nov 2023 10:33:07 -0500
X-MC-Unique: Au1iGisSOyGqDPfQWkTQOg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-779ffb552eeso805559585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 07:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699457586; x=1700062386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rf6nrc9vsYtHDq5I7rqs8WEwl7hNFdatKiQNbZDf+3g=;
        b=R7kNb5I7sIDsEPQsVfHA3nqh3viG3Pu4qLV5YnqziLF4lpvcXvGIJAEP6J4d7Htjzs
         ef1jRQ9lzHnZboW+7A8LSRk74BMMXY2MvB0Ilep+Km0UOoKcGP4K+4nrZkY2nHq3ddP0
         AStYuamfO1UO49pBZQ4VpFCWn4+CPKNyJRXipae/jqvTZ504lfhhXDs2uFaFJ1X+fZxf
         7FnOC3ZSohUb23Wc/cQrXBRWsXy98h1nWo1bNYt11cZ04riMKTHiSoeLcZSeBGnNe9CN
         rSwOhi4KdDjzSTMUha+m3GMTzp9nLkDWCAhuQY664Qd3hyJcs9+hnuoU20XGyzXXrXil
         tapg==
X-Gm-Message-State: AOJu0YwEBCpZpHGIXEoGjnl+RM37Sc6n2Sb0PRJj9EHoTCSudaEV4Rga
        5dqj2Y2KbAFmhyXvlj5vQo/Dy1ExaGWFiCl84ZP8yYI+N5O0w3nd/63EcJ2mgj1lQ8UddrPa7He
        SjGz5ymdvooaKMUUbDpr6Li9f
X-Received: by 2002:a05:620a:8dc5:b0:778:8676:fd4 with SMTP id rd5-20020a05620a8dc500b0077886760fd4mr1699428qkn.73.1699457585781;
        Wed, 08 Nov 2023 07:33:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6+BHcCtTk+c77Z73UHj9SPsJMvP2BWpv0J7CHG6xq4hFwJfpUL1R+bNHPV3nSkAX2/jop9g==
X-Received: by 2002:a05:620a:8dc5:b0:778:8676:fd4 with SMTP id rd5-20020a05620a8dc500b0077886760fd4mr1699410qkn.73.1699457585421;
        Wed, 08 Nov 2023 07:33:05 -0800 (PST)
Received: from [10.16.200.42] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f16-20020ae9ea10000000b0076ee973b9a7sm1152477qkg.27.2023.11.08.07.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 07:33:04 -0800 (PST)
Message-ID: <69d0dc4f-5ff5-4cda-a272-71b890db5bc8@redhat.com>
Date:   Wed, 8 Nov 2023 10:33:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] docs: Update kernel-parameters.txt for signature
 verification enhancement
Content-Language: en-US
To:     "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
        linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230914112739.112729-1-alessandro.carminati@gmail.com>
 <20230914112739.112729-3-alessandro.carminati@gmail.com>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <20230914112739.112729-3-alessandro.carminati@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 07:27, Alessandro Carminati (Red Hat) wrote:
> Update kernel-parameters.txt to reflect new deferred signature
> verification.
> Enhances boot speed by allowing unsigned modules in initrd after
> bootloader check.
> 
> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0c38a8af95ce..beec86f0dd05 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3410,6 +3410,15 @@
>   			Note that if CONFIG_MODULE_SIG_FORCE is set, that
>   			is always true, so this option does nothing.
>   
> +	module_sig_check_wait=
> +			This parameter enables delayed activation of module
> +			signature checks, deferring the process until userspace
> +			triggers it. Once activated, this setting becomes
> +			permanent and cannot be reversed. This feature proves
> +			valuable for incorporating unsigned modules within
> +			initrd, especially after bootloader verification.
> +			By employing this option, boot times can be quicker.
> +

Please keep these in alphabetical order.

Would making the kernel-parameters.txt warning a little bit more 
informative be a good thing?  This should only be used in environments 
where some other signature verification method is employed.

Also, for future reference, it would be good to have hard numbers to 
show the boot time improvement in the changelog.

P.

>   	module_blacklist=  [KNL] Do not load a comma-separated list of
>   			modules.  Useful for debugging problem modules.
>   

