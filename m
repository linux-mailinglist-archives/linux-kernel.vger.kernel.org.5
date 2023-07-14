Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6544753BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjGNN2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjGNN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BC72699
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689341240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9IgKJJNZS/TbDNJUn/7MzKZpZbUXG/7hMfiYQjSmbSw=;
        b=VxqRzXuD12LnOLfxlcltVbe7fEJ8+7pEHNntrPo0B8lXK0A6FFbX0vwnZX22ej8UBVsb07
        TSSD20qfBgltkoXoKNRiB7LPQKOARLa+0nY4FtxDVya+t+5nHsEWnqGsYD2GV2GHoyM3iX
        7hhtNE7JMJh1ueb8I5I4XY3+sEGqMfY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-_fuS5Sn4MiuVYKeGJiMrhA-1; Fri, 14 Jul 2023 09:27:18 -0400
X-MC-Unique: _fuS5Sn4MiuVYKeGJiMrhA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso117341266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689341237; x=1691933237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IgKJJNZS/TbDNJUn/7MzKZpZbUXG/7hMfiYQjSmbSw=;
        b=jmnobZUTiHq6uDJc+xTyG9Ij711Xw3b9X+tspfMeAPHEX/YYfQW4CpmUEM6KbEbIG7
         6C4iXCol6ONdA0hHl0JzcYqxlcAfUEgXjr55/abNML9qikNi5YhQcSg6NivEwdu4GNrV
         qF/Nq+DIv/143N9AgKJGYez3oT03YvDS79k4IjA2S/bBkm8oS3uInDOf6ovPX4WJpPSF
         P7FG5ySSDOG7wSiIOBOHbEKahePOlLe15/7DY1Rhi3NaD+vftnkMy+pwqbRqRRMcU0AF
         pT6foosDneNhMTObqf6aCvnMdY0ZNaL2O1nboZZMFbe5wjSTo/GhC7+0skaJ8wI7Aa1W
         eFtQ==
X-Gm-Message-State: ABy/qLaJZqs2UZ5ZwPWBoG/1bQSHYxP27uyAfKvicZnq9bQxNg3EvBKO
        +gQ87lYDu/jCP+FpQ8tLu+NZXDcuXL0Tzpy3uecrLWoRxeShaB3rnTPJFS9Cjat/AL05J75G5vu
        hgZLwrZYNOvm10xP0odmt3ha9
X-Received: by 2002:a17:906:3497:b0:970:1b2d:45cc with SMTP id g23-20020a170906349700b009701b2d45ccmr3970355ejb.57.1689341237597;
        Fri, 14 Jul 2023 06:27:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZ/14VylTsfFAfhnHMA1XfeuCqWXa+D2USRkhwFQazztUpCpKRZA9cAXIsQP6UXeld4EY29A==
X-Received: by 2002:a17:906:3497:b0:970:1b2d:45cc with SMTP id g23-20020a170906349700b009701b2d45ccmr3970342ejb.57.1689341237291;
        Fri, 14 Jul 2023 06:27:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p18-20020a1709060dd200b00982d0563b11sm5405286eji.197.2023.07.14.06.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 06:27:16 -0700 (PDT)
Message-ID: <8737515b-e5ef-2614-70bf-c296eeda46d5@redhat.com>
Date:   Fri, 14 Jul 2023 15:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/3] TPMI control and debugfs support
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230712225950.171326-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230712225950.171326-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/13/23 00:59, Srinivas Pandruvada wrote:
> The first patch provides interface to read feature status. This is
> generic patch to be used by other feature drivers.
> 
> The second patch add support for debugfs. Debugfs also display
> feature status using the first patch
> 
> Srinivas Pandruvada (3):
>   platform/x86/intel/tpmi: Read feature control status
>   platform/x86/intel/tpmi: Add debugfs interface
>   doc: TPMI: Add debugfs documentation
> 
>  Documentation/ABI/testing/debugfs-tpmi |  31 ++
>  MAINTAINERS                            |   1 +
>  drivers/platform/x86/intel/tpmi.c      | 399 ++++++++++++++++++++++++-
>  include/linux/intel_tpmi.h             |   2 +
>  4 files changed, 426 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-tpmi

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

With Andy's Reviewed-by added.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


