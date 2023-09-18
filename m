Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3187A4B87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjIRPSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjIRPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B07182
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695050221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34rQIte300nczPmzdZIQ1NSonzmNPTyp0RtMBm5cR0Y=;
        b=A072Q1to21bzGYX1A0ClcP09kQBiceNw18AkG5CE6ptoPz4H1hiGL/LdbcclHAq+ApCiZ7
        W8qJe+2e0bAJU+Iz+7qMXoitfi78Xvwksja4snJsXx0YOl3YDATc9XYFG1CknApRWqrHxA
        Tpf/zsvxBuEZXjLOn6jivdm/DyAaBLc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-_L2NL0VLO0SOTsbTrxVPnA-1; Mon, 18 Sep 2023 09:15:50 -0400
X-MC-Unique: _L2NL0VLO0SOTsbTrxVPnA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a348facbbso346752766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 06:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695042949; x=1695647749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34rQIte300nczPmzdZIQ1NSonzmNPTyp0RtMBm5cR0Y=;
        b=TJDGrylWjOredtOT5zvjM2pNmUES/GyOo1nWcCIIX1NHpKm/bovaXGyhGbe0WAuzWD
         MY0A7Jy5zp8j2nyMZC0I/F/fFRnqHyrAqxuxZv7FftCdOW4bWUowFZyIJ8HfWuDLCRu/
         BkoA3TCxaIpBVE1OK/wOCbCAP8mZ+UIAyvSM3x9s1vlRQp8LM6i6aj0d3yyCoUQXwTrW
         l9PPT5/hrIryvDGPYMF9bzbk+S/bKAAV9KGu51eUkipWWbJA7F5QMMCKa1qSJLCIRt3f
         AxOfYvq0doubsqbymws/blGKGU0vswGj5MEOjTTrXL+AkBW8TWMLZZcbEsV/6urH1MuS
         BuIg==
X-Gm-Message-State: AOJu0YzPxGQKEx/tzNcMOOq2NRtQ8Cjdn0IXuMt6lZ+qpDpDllqxE2KG
        aqJ05cqeO04bP25mnEgEc4izifvJQGFHQMOVX91rtasDeAIjuGw9j0CzsGwy7bCDQf/3El1tfYQ
        g4lyTjNK558Pg0TIQjY+7eUMo
X-Received: by 2002:a17:906:11e:b0:9a9:f042:dec0 with SMTP id 30-20020a170906011e00b009a9f042dec0mr8788677eje.38.1695042948962;
        Mon, 18 Sep 2023 06:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPRndgc3ZfM7OHhQ220xzzsbF85k8TbGlrnVPHutsbogvIjs7mfg2ynOLLFRsRtA/PNsyMnA==
X-Received: by 2002:a17:906:11e:b0:9a9:f042:dec0 with SMTP id 30-20020a170906011e00b009a9f042dec0mr8788664eje.38.1695042948698;
        Mon, 18 Sep 2023 06:15:48 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id cw17-20020a170906c79100b009a1a5a7ebacsm6386554ejb.201.2023.09.18.06.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 06:15:48 -0700 (PDT)
Message-ID: <25f3c9e1-0b67-5a83-e69b-9a7e0225c267@redhat.com>
Date:   Mon, 18 Sep 2023 15:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/4] platform/x86: intel_scu_ipc: Timeout fixes
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
References: <20230913212723.3055315-1-swboyd@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230913212723.3055315-1-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/13/23 23:27, Stephen Boyd wrote:
> I recently looked at some crash reports on ChromeOS devices that call
> into this intel_scu_ipc driver. They were hitting timeouts, and it
> certainly looks possible for those timeouts to be triggering because of
> scheduling issues. Once things started going south, the timeouts kept
> coming. Maybe that's because the other side got seriously confused? I
> don't know.
> 
> I added some sleeps to these paths to trigger the timeout behavior to
> make sure the code works. Simply sleeping for a long time in busy_loop()
> hits the timeout, which could happen if the system is scheduling lots of
> other things at the time.
> 
> I couldn't really test the last patch because forcing a timeout or
> returning immediately wasn't fast enough to trigger the second
> transaction to run into the first one being processed.

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> Changes from v3 (https://lore.kernel.org/r/20230911193937.302552-1-swboyd@chromium.org):
>  * Use readx_poll_timeout() to shorten a line
> 
> Changes from v2 (https://lore.kernel.org/r/20230906180944.2197111-1-swboyd@chromium.org):
>  * Use read_poll_timeout() helper in patch #1 (again)
>  * New patch #3 to fix bug pointed out by Andy
>  * Consolidate more code into busy check in patch #4
> 
> Changes from v1 (https://lore.kernel.org/r/20230831011405.3246849-1-swboyd@chromium.org):
>  * Don't use read_poll_timeout() helper in patch 1, just add code
>  * Rewrite patch 2 to be simpler
>  * Make intel_scu_ipc_busy() return -EBUSY when busy
>  * Downgrade dev_err() to dev_dbg() in intel_scu_ipc_busy()
> 
> Stephen Boyd (4):
>   platform/x86: intel_scu_ipc: Check status after timeout in busy_loop()
>   platform/x86: intel_scu_ipc: Check status upon timeout in
>     ipc_wait_for_interrupt()
>   platform/x86: intel_scu_ipc: Don't override scu in
>     intel_scu_ipc_dev_simple_command()
>   platform/x86: intel_scu_ipc: Fail IPC send if still busy
> 
>  drivers/platform/x86/intel_scu_ipc.c | 66 +++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 26 deletions(-)
> 
> Cc: Prashant Malani <pmalani@chromium.org>
> 
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c

