Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F898070C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378476AbjLFNVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378416AbjLFNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:21:22 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25090
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:21:27 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c4f95e27fso5436317a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701868886; x=1702473686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RwQqJumbY5/om6bDdbaAXe1etwBjyfBaS/JPDxfOUVo=;
        b=cfS90Op1KcpjwNwmV+pclQzzd1+JNvKPci3FxhuImaxINNxKtlV5Tx6u4IsxPI2sSG
         a1r7caH5O3TnwbHN2ivlVEjSd3s8ULEo/vh1nOvbLv+Z8OFySMBZ1hzUweuygrP+RYKI
         PoE7gFH5Ub+RFRgqs87lNhqnpi2V3lcBhERj90johk128tvIcvxTTNaKhh2LWboQoaLz
         ECjhsZbZGLxvI9Hb7LkrhZEcnqVFBebCk8OW4wFfkVI5NgnvsL617mbx72CIdgZLcdSl
         Ah0Ct/hu7QbU5toWbhCBKsSHL/uEFoAR3lbRoCCPVPpzucuTzAG8iCuDmlA5y6ODe6hs
         Llog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701868886; x=1702473686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwQqJumbY5/om6bDdbaAXe1etwBjyfBaS/JPDxfOUVo=;
        b=osZGlCkcn7iRJEks4fC5LQQONd8rka1rwwGRxOT4FkoneKAFe+p4A08S6KPUEzp+Ui
         yUKK+XRakxN6/3ChqHTncWjhn9X0xSNLrPFARhIErypBTbeWHOMOZK9WC5D3B7wb9Dlq
         4dRsWCOXLDq1t4P3gxNGow6ylGb5oakGbt5WGHzqg3vIgK3PSy88sSyt7WPg5oeKJSzY
         Qmyq2WdL8utQQ+XBrtzv53uLeZqFgEpKIJ5pgezWpHjMjGh6GxtnW+KVP5aHrpkDKPpi
         ifTJ6Wj5iLiL/9R7kPlKhHeOJOxCH9ZOfTxjWN0I3PXX5Z02ryFX7a4pEXGHyMNPWhIG
         j9iQ==
X-Gm-Message-State: AOJu0YzPllca7n61tVTn2tKzEPBxyzLvs67ze40uNm/MENVBJ4D3x9Vn
        gxauQhhnF5/ra7Nrmt5rBWrG7A==
X-Google-Smtp-Source: AGHT+IFWmP6+Dna4lIHhaMi4c1opjtrWqysH4+kDdPrLq6nqgup7QjLrXkig7tJJExJ5IfeKExUcYg==
X-Received: by 2002:a05:6402:3185:b0:54c:4837:9035 with SMTP id di5-20020a056402318500b0054c48379035mr734306edb.45.1701868885946;
        Wed, 06 Dec 2023 05:21:25 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s7-20020aa7c547000000b0054cb199600fsm2404810edr.67.2023.12.06.05.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:21:25 -0800 (PST)
Date:   Wed, 6 Dec 2023 14:21:24 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florent Revest <revest@chromium.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH] team: Fix use-after-free when an option instance
 allocation fails
Message-ID: <ZXB1VHnrE98H4p9Q@nanopsycho>
References: <20231206123719.1963153-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206123719.1963153-1-revest@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Dec 06, 2023 at 01:37:18PM CET, revest@chromium.org wrote:
>In __team_options_register, team_options are allocated and appended to
>the team's option_list.
>If one option instance allocation fails, the "inst_rollback" cleanup
>path frees the previously allocated options but doesn't remove them from
>the team's option_list.
>This leaves dangling pointers that can be dereferenced later by other
>parts of the team driver that iterate over options.
>
>This patch fixes the cleanup path to remove the dangling pointers from
>the list.
>
>As far as I can tell, this uaf doesn't have much security implications
>since it would be fairly hard to exploit (an attacker would need to make
>the allocation of that specific small object fail) but it's still nice
>to fix.
>
>Fixes: 80f7c6683fe0 ("team: add support for per-port options")
>Signed-off-by: Florent Revest <revest@chromium.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!
