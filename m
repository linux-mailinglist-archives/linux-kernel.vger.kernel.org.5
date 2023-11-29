Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0787FDAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjK2PEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjK2PEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:04:00 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB398C9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:04:05 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b8412723c4so4349502b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701270245; x=1701875045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4Ao7lBgcd+ybKERFuAK+nkaWPQkkI/HHB0oBMFxsuY=;
        b=gSS0f7dAo5U6qPxA1nJZhCvK3efZkpX2hHe1X5YJwzEYgO1JPkVVR74+2rL4K89BLn
         O2Oy2+0zz+PYTICB8bkCYCerNH0YnDWaZZdXfZUhScHR/Pet9FXUsyqoFJigyzdOuZpm
         nlN8Pk+4TBBKdq+mkP3ZYilYOIE7XNbdx1z8AlNuTPpdiSALL1VyENFlDySig7htomBJ
         aVpig6LbmyRTnvE3lnpXOSogTLzqmfRGmQBD8rjkUjbX3RyKeZ4Jx6KHRwmA2lGyoEE9
         ZosTbaORpqwBrcDEWOYSSZnUcGAlW1LN7cpy/zGh1c0obLUR4qkPjld8uSxgXjHRffbx
         JY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270245; x=1701875045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4Ao7lBgcd+ybKERFuAK+nkaWPQkkI/HHB0oBMFxsuY=;
        b=sn4ef7eZ1ycri2X4S26Fz9UX5qgwqIikj8KXKADQjsjuO5T/59DP+0ZnYofYq62ORk
         h33RqmiExaSh3nTTySY6m2ehwtS5krvb0I9xloEczlREdRFTDh45VasCDkK2rA3LmZQT
         uX7ZW2ZONKPPBf6nr8vSsr1kAEFbZKsBA0QfvUN3/WgOx6Y8EDgbR5KSEQgtcOGzlnZa
         t2ZK/Kx+NkpHQHrr08hGglA3157nebMSxeQEOvDa+VBEHZ5o5Gu4L3Wqt8AhzP45Gnjf
         tlpMLm+01jnF44aOumuCsnKkq1sRboeufgdeEIcmiFB0OPI35ld65BoYsdOE38a4DlnN
         4alA==
X-Gm-Message-State: AOJu0Yx0xUU5m3nQ1PrAJAvzeryImHJXwCrnfEu52R+0ZBhKjGBOhy7e
        HxNbb8ONIdWcOdebVUJp/Y18/Q==
X-Google-Smtp-Source: AGHT+IHD70IfG8FBZ3xYBo0dZ2qCdJIWjr46lOgat1KTOIvbAN1mbw/QRSgQ4yJcSH/qhXAu2olYow==
X-Received: by 2002:a05:6808:1288:b0:3b5:84b0:6be6 with SMTP id a8-20020a056808128800b003b584b06be6mr28312075oiw.47.1701270245316;
        Wed, 29 Nov 2023 07:04:05 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id r10-20020ad4522a000000b0067a769e2259sm198042qvq.141.2023.11.29.07.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:04:05 -0800 (PST)
Date:   Wed, 29 Nov 2023 10:04:03 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v7 2/6] memcontrol: add a new function to traverse
 online-only memcg hierarchy
Message-ID: <20231129150403.GB135852@cmpxchg.org>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
 <20231127234600.2971029-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127234600.2971029-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:45:56PM -0800, Nhat Pham wrote:
> The new zswap writeback scheme requires an online-only memcg hierarchy
> traversal. Add this functionality via the new mem_cgroup_iter_online()
> function - the old mem_cgroup_iter() is a special case of this new
> function.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
