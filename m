Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD4E7E869A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjKJX2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKJX2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:28:34 -0500
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DE1118;
        Fri, 10 Nov 2023 15:28:31 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3574297c79eso9515195ab.1;
        Fri, 10 Nov 2023 15:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699658910; x=1700263710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCAj8D50QhU0Sd2mpWJYIypfLV54gJQXB6a5grPUfMc=;
        b=DqqwkzIURINnn9gHwHCXyQwdp5gy0+EbOiVlEadZWH8X6oMma74UGHYbZfLedp5dVo
         qClj/ljfeX5NEFkc5Qidw2s7TlYveQWp2mctLsCYFhbb/I68fPqY8fuj7kSiWVDiDk1M
         U5D/Hidw5iWT9Edgby5BPQMXmCoWDZrJa6trRltzlm8kLcyzOA97odNwSYL13PCSCp8c
         UP991rocdxGETTNfrSjEMz6VYL4ZGtYUMIVitcWy0AhyYqlNwmBLi2FVegePPWDzfP31
         cGXGlNAOd6tK1+gJENzwl62NcOy9UfiaQLsvyh8UFD8teeTSAPOPPr3K8XOtcvXO9TXL
         gI0w==
X-Gm-Message-State: AOJu0Yz6S+rZy+WtOZIqEtoiVnma/seL+OKeI34TNDlVAJLdAPd7KXtO
        HCBeJy1m67jomH8Okb8rkb4=
X-Google-Smtp-Source: AGHT+IH4aXf25zTCH958ckBntxsHHjlaxNgRFx8xPVGemn1uLjFcxDZR6O6l1Y2pjNkSj4LzU/VzOg==
X-Received: by 2002:a05:6e02:1808:b0:359:4f85:b230 with SMTP id a8-20020a056e02180800b003594f85b230mr1188146ilv.18.1699658910361;
        Fri, 10 Nov 2023 15:28:30 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id v4-20020a62a504000000b0068be348e35fsm244667pfm.166.2023.11.10.15.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 15:28:29 -0800 (PST)
Date:   Fri, 10 Nov 2023 23:28:28 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Ani Sinha <anisinha@redhat.com>, Wei Liu <wei.liu@kernel.org>,
        Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hv/hv_kvp_daemon: Some small fixes for handling NM
 keyfiles
Message-ID: <ZU68nNVSD4QkgVr2@liuwe-devbox-debian-v2>
References: <20231016133122.2419537-1-anisinha@redhat.com>
 <20231023053746.GA11148@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <E44432C5-17B2-47FC-B382-384659B21DCF@redhat.com>
 <5D793B43-B5DB-4BA2-9F1E-B01D5E2487D2@redhat.com>
 <1D09E6F5-9120-40D4-A365-AF04E9AA5587@redhat.com>
 <PH7PR21MB31164A4B84974856943DBBBACAAEA@PH7PR21MB3116.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB31164A4B84974856943DBBBACAAEA@PH7PR21MB3116.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 02:59:14PM +0000, Haiyang Zhang wrote:
> @Wei Liu<mailto:liuwe@microsoft.com>  Could you please add this to the hv tree?
> 

Applied to hyperv-fixes. Sorry for the delay.

Thanks,
Wei.
