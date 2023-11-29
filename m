Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E037FCB32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 01:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376661AbjK2AB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 19:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345005AbjK2AB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 19:01:28 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6605198D;
        Tue, 28 Nov 2023 16:01:34 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cd97c135e8so2157231b3a.0;
        Tue, 28 Nov 2023 16:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701216094; x=1701820894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfAthndQOUsLyhwyhNqOrHqgkV99kYZqSodLMH4soJY=;
        b=KNwv7jRIBMeJwXwqBci1Cp4o7U7OUFu/p4BEXtpdJmLb48H1/JefDmoBdWJA8P1As6
         cw2FnVlFtovtbbJQt4npVbQ9N2mCi3PV/FElIfFNXJOG4WAnnWDpxq7mHF40TPn6Hn+I
         VjzoRMnpBghNFSRxx3uG3FfVXzW3QlvFpxBCOC1FHjqDBtMsT3fTpZdorDLsn86zuXT8
         KK3Ip02p8Wlw1KPOmJtBRFoacnX+0hVqON2m8Y/zMy5ILYXEIRWgZamqCQE8HCK+yyqN
         S3VfrWhK7egRegvMmx1I7LNPVwbp+EubKzGAyM7/S//2nmv6URRiALn3OfYuN6ZVh7ZP
         bIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701216094; x=1701820894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfAthndQOUsLyhwyhNqOrHqgkV99kYZqSodLMH4soJY=;
        b=YZGUVYgE9rul7BcTUD+KYslnswM7GxlR6ANyjcX08tuPJVaBtXPmUPYoJXKtqKc3vX
         4iBDOAgby2eiM/8pIWg94Cj+CuNdYiNPN0dG4T2YCAtENtgULUOf4b8vvYVCyeW2sQ8n
         Fn++6l7Fls0XvjUHgGFSZ+dNwFXmcMPaZplVHGm/Yh9gkgcSpmfhTmkBNN2ciJSEd6zZ
         DGFV152rz72Kt3L5XgjaWMv/He7L21Eix9BMr0g1DxoKD6Hv9an/ORHjXOrPFuygaqKw
         cOfUIJvMGhg8xFW7no0vlB3sqJJIpVyD9ENkI4Lf0ViPwlnchUTw+p4S5gJ+MVhPJLyc
         7Odg==
X-Gm-Message-State: AOJu0Yy7Rm6mYZwo8G1fyq23gTR8bpCUeB/WJUrtmXCRRCr1LZo7xyqH
        pG1ZXHr6zqD0EYXluphh3dU=
X-Google-Smtp-Source: AGHT+IG/dFzo3MqKKbmx14o+jvcSHc2Qq74jjY1Ok5XP+dY64ErqjX9OqfHPkqBlzUh6ePnOuyJevA==
X-Received: by 2002:a05:6a20:428b:b0:18c:ae67:c202 with SMTP id o11-20020a056a20428b00b0018cae67c202mr8744798pzj.37.1701216094154;
        Tue, 28 Nov 2023 16:01:34 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:8fd0:78d2:c604:3ac8])
        by smtp.gmail.com with ESMTPSA id t8-20020a1709027fc800b001cfca7b8ee7sm5047038plb.99.2023.11.28.16.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:01:33 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 28 Nov 2023 16:01:31 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: Use kmap_local_page()
Message-ID: <ZWZ_W3tkw9tBqdvE@google.com>
References: <20231128083845.848008-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083845.848008-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:22:07PM +0900, Sergey Senozhatsky wrote:
> Use kmap_local_page() instead of kmap_atomic() which has been
> deprecated.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>

I didn't know that the kmap_atomic was deprecated.

Thanks.
