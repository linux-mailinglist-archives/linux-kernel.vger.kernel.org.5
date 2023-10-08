Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5EC7BCE94
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbjJHNcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjJHNcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:32:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648F4E9;
        Sun,  8 Oct 2023 06:32:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso2740182b3a.2;
        Sun, 08 Oct 2023 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696771936; x=1697376736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZBj+B979HdDyKfkshEcmks00XEzwyel5fMwn75NiNE=;
        b=WQv3Q6zpsRnhnk8KGn78HsUgJCOQo5YHkDXFUZp90oj8pb3ig69wj0qtRS/DP1x1w+
         CrnbWdYK/0dHQGNkPOnB0aOl8ZJAZvgHyL3rs4kLYq8iff/Ljud/Y6Lm7p2KRAOIgbjJ
         qjseSv+1LQsnfcKd6EVBiBhG54N5RBlbmcyd5ZPo6xQEZQJgP7xxQEgy1bBYOfkPvnp2
         KG280YilMcb8WtQ26m9aejdS7nzcX8iAleQ1DI/aupguHvzy4j18PW7Jw3Vv5/PHL4iD
         3P1miunMT0OIIr/qeCXg56iahD7DmwMcY4NKf+Uoxi8Wnxt84ocMHuZ6cLX4/SDJHYsC
         phVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696771936; x=1697376736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZBj+B979HdDyKfkshEcmks00XEzwyel5fMwn75NiNE=;
        b=D2s6kkR5SNysD0PnX2Xm7k2nRU6G1HvdMjjSJxLMFHpYqSGB7ayYXyjHIMmUacGpny
         hD5GnZUU6/aEf3yJfdJomGKvrWPUL4+oh/K3mKX5anTthYoRwXTkNHxCkEJwuwZqy43c
         9jzlwreJRBnBEzFOnyTu5vW3Am1UOrzX5hn/0rEvLBlgGr0+HgUoevQ1OejRIjQkiJ2A
         jDNB3eme2e0YB2RHhL2V6hhgxRkppYkM8d3bTXkshWmlxAlNQ954TiImds6d0SDJqXav
         i/mFkt1FeGEuCsA0I3XDfiVfn0kLeE6SEZ7Y1cDvOJIxKYaEkdTVHd2/ac23B3vvmuQy
         VnOA==
X-Gm-Message-State: AOJu0Yw6pj59KFurpRK22H7fyFF1sPAH6K+PoxUamZBieks8EmqecBA/
        Rc8J/7YK15KvkDi74NaWzTM=
X-Google-Smtp-Source: AGHT+IFOY85UgOWHfFqcatDIpuXYdwSCgCRsDAXC6oyPhco895b49KzpqTAKLux8KbcVO+GGktDe2Q==
X-Received: by 2002:a17:903:1ca:b0:1c6:1a26:ef56 with SMTP id e10-20020a17090301ca00b001c61a26ef56mr14477074plh.48.1696771935691;
        Sun, 08 Oct 2023 06:32:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902da9100b001b8943b37a5sm7471896plx.24.2023.10.08.06.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 06:32:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 8 Oct 2023 06:32:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Zev Weiss <zev@bewilderbeest.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Use i2c_get_match_data()
Message-ID: <e8f1d2ae-71a6-43e5-b9a7-cb9c601a566c@roeck-us.net>
References: <20231006224452.443154-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006224452.443154-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 05:44:52PM -0500, Rob Herring wrote:
> Use preferred i2c_get_match_data() instead of of_match_device() and
> i2c_match_id() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/hwmon/max6650.c       |  8 +++-----
>  drivers/hwmon/nct6775-i2c.c   | 14 ++------------
>  drivers/hwmon/nct6775.h       |  2 +-
>  drivers/hwmon/pmbus/lm25066.c | 14 +++-----------

I would very much prefer one patch per driver.

[ ... ]

> +enum kinds { nct6106 = 1, nct6116, nct6775, nct6776, nct6779, nct6791, nct6792,
>  	     nct6793, nct6795, nct6796, nct6797, nct6798, nct6799 };

Each of those instances needs to include a comment exlaining why the first
id now needs to start with 1.

Guenter
