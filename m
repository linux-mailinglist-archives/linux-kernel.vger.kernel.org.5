Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9365680AC2C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574623AbjLHSiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjLHSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:38:14 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4D110C4;
        Fri,  8 Dec 2023 10:38:21 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-58ceab7daddso1090331eaf.3;
        Fri, 08 Dec 2023 10:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702060701; x=1702665501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hgx7yYZh3wkKhLdlPRLYhW3TuyCT7B7DTgn0GhgaUA=;
        b=cMlBjeNgNNFxtJDChgOU1XAKJ/mhkZntgNc4/OZsY7RQ8Wfp5yVmq523gVPKHwuNts
         T0JMqSjwbY3W//NAoJaYOQ++R4Ju4LvvAkRLUeuiAOu0iBhMd/YMg8ZPxYgVG/Qr5VNj
         Jn4FHhcRpHjIaSRJzGOOIX2GsecdUNg+md9nLn/A31wA7BE6F0AC5JRX1X5D7zN0+iaL
         9Se0E7e4H6t7yo1OHht0FHiWpi1iAIKqGn7mE6nZXBSuFLnnOUwvy+koy070h0F+kdxz
         3GREau1h4qUJJnEGFlLgOWyYDXm7k8YjNQUN4t++/FgoFnmh6UVGZHPzOWLcvcll+nuK
         D9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060701; x=1702665501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Hgx7yYZh3wkKhLdlPRLYhW3TuyCT7B7DTgn0GhgaUA=;
        b=dTyROPGSBv0cE6XKilBcu0f/fHHqUyLO+yQt0bxXALTGlTcDpBW6ZXlqAinK89vX3C
         XxNsvTH/VRjxHlg2EhfDJa+MgLAhAFv8POy85Qqi7nHTJV9Ukw0B/X/cp2Zo8lXTxdpI
         0kwzKrn/YUqvdvIb3d2luZQLnin0AiPvJj+rH+Px3c9zjFClwU4dDcju1L4MTVqMOnDf
         CwV+PXxUtcBWrXmobMNfbcCHdKNmpmGT2GS+yo1v30m+kVQnqZRmoOtCa8UJua6roPO9
         toLvxspEbtdlPB+n7gp63DQhVNXrCpR7M9klfgAXVtEgPLnWKOX73IdjJYVtkzR8XuEj
         +4nw==
X-Gm-Message-State: AOJu0YwolI718WnK3oIiPrYhXMU65M6wrBydBa5xjc/ru1M5OBICRk8M
        MrfL7AuPbWW4Kt/WmEUR6oQ=
X-Google-Smtp-Source: AGHT+IG+xBBqA5n2zgcfZoSDwIoC1P8bg1H4GGQuvr8GWYFF8OtTP0dvkLQoNns+8q9sQ3ptbais6w==
X-Received: by 2002:a05:6820:1b83:b0:58e:30f0:9bd0 with SMTP id cb3-20020a0568201b8300b0058e30f09bd0mr608404oob.5.1702060700460;
        Fri, 08 Dec 2023 10:38:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o14-20020a4a384e000000b0058dc4a5de5bsm391037oof.14.2023.12.08.10.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:38:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Dec 2023 10:38:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     wilken.gottwalt@posteo.net, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (corsair-psu) Fix probe when built-in
Message-ID: <65b2126d-7b50-41aa-8a3e-87b409d25561@roeck-us.net>
References: <20231207210723.222552-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207210723.222552-1-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 10:07:23PM +0100, Armin Wolf wrote:
> It seems that when the driver is built-in, the HID bus is
> initialized after the driver is loaded, which whould cause
> module_hid_driver() to fail.
> Fix this by registering the driver after the HID bus using
> late_initcall() in accordance with other hwmon HID drivers.
> 
> Compile-tested only.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied. I dropped the "Compile-tested only" comment and added a note
that the patch was tested but the tested did not provide a Tested-by: tag.

Thanks,
Guenter
