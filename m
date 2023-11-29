Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE937FDAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjK2PDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjK2PC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:02:58 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAF4DD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:03:03 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4239f5c1ec2so27101761cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701270182; x=1701874982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2wsVpYCu/TCERAyV7xfQRsKsQF4XxordQuNYbkUm7A=;
        b=lR2QXSeyGT5u4GTVYZfZxg2iG6AejM9Ph6SIbN/jgglTsbTqFyyEj1A0wmuT2klFiR
         9WGsBbaEgsq1RMpCBN0deZVdSn1zXmq4NIkJyPpPIy83+v9jBdHsOhyNC0vUO/NQt4JR
         gZRz3CgBFmFF+ZVACuabXxTKJk5y4NIRql82g3V+gBPp/G8M6J57TJ89CTKampvTyjzK
         FtLBzxIk5yeeAVpq9cpM6sxhftbHuMKc/oASLG11grxJ/WtyHlFunaX9g6EVBCdT7M7F
         osOWCloTiMT4LUxi1FN2U6nJ+6fvwjnU91AGzp/o7k7GKaKg9p0JCdd6ROwPGeLyV4l7
         7B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270182; x=1701874982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2wsVpYCu/TCERAyV7xfQRsKsQF4XxordQuNYbkUm7A=;
        b=ZjMZFPKTLPWOIJICzC1Ght1xfrwjI3CzMz0HVXZTkwbN6RDo1yxf0B0TJSfxACvdVm
         R5nwIlg93Gz7Dyu4pyFJS/1GYoBux/LFdFu0ykiu7u7eHXkebSGy6D2qIg5pu3pYr/Hk
         VeJPf6ATCwoSUuK+bXqfigKGFhLTYFWsRNNPaMve6N9Rv0zG4ASLbJL9MjmVpKLTGIl+
         qVyrB4XbxugxfRJdCz2EW5iwOrxTUm/1XqOFS5HdIVDE3ROz5HIWhcEpDbgOfYxx3yqA
         5JpsZSNhRGdGRo0g2rAwbGYCcponbHAowYRnV3Mqke57wTOMmmLXizDwVmqvVRRsH5E4
         nv6A==
X-Gm-Message-State: AOJu0YxslB8/uk6He3SdR9ro3GHJ6M5RDo9RGHkBKkU9FP7w5LSI3I9T
        cYP9WgGRI5ymJfKnp0itXODSew==
X-Google-Smtp-Source: AGHT+IFhbxa568oWRmeUGcBeIbWIWKZfp+eJgBPEkoaJAKk9/smfQhel6cgM7NgfceIz+TM9Gd82+g==
X-Received: by 2002:a05:622a:a14:b0:423:f0aa:a82c with SMTP id bv20-20020a05622a0a1400b00423f0aaa82cmr1468250qtb.32.1701270182230;
        Wed, 29 Nov 2023 07:03:02 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id fx10-20020a05622a4aca00b00423de58d3d8sm1366432qtb.40.2023.11.29.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:03:01 -0800 (PST)
Date:   Wed, 29 Nov 2023 10:02:59 -0500
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
Subject: Re: [PATCH v7 1/6] list_lru: allows explicit memcg and NUMA node
 selection
Message-ID: <20231129150259.GA135852@cmpxchg.org>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
 <20231127234600.2971029-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127234600.2971029-2-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:45:55PM -0800, Nhat Pham wrote:
> The interface of list_lru is based on the assumption that the list node
> and the data it represents belong to the same allocated on the correct
> node/memcg. While this assumption is valid for existing slab objects LRU
> such as dentries and inodes, it is undocumented, and rather inflexible
> for certain potential list_lru users (such as the upcoming zswap
> shrinker and the THP shrinker). It has caused us a lot of issues during
> our development.
> 
> This patch changes list_lru interface so that the caller must explicitly
> specify numa node and memcg when adding and removing objects. The old
> list_lru_add() and list_lru_del() are renamed to list_lru_add_obj() and
> list_lru_del_obj(), respectively.
> 
> It also extends the list_lru API with a new function, list_lru_putback,
> which undoes a previous list_lru_isolate call. Unlike list_lru_add, it
> does not increment the LRU node count (as list_lru_isolate does not
> decrement the node count). list_lru_putback also allows for explicit
> memcg and NUMA node selection.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
