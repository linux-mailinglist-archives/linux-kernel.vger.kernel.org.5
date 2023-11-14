Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419AC7EA9BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjKNEoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKNEoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:44:15 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD52FE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:44:12 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so4043700b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699937052; x=1700541852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ONkBbb+HnFKyr5bwkUFFQAkj5jFzRIolELIrPxQNcw=;
        b=G2/1J18VoeNINnJJxXdPWwRQev9MzvoAyKfB5ahpNtbzkSu3gKkNMgOh/UmNYlxkMj
         LEFi7aE5u/qG2NRFsHcMt/bwWbVLrPCnpstIUAFvUDiarg7ieA5z9y+kPB06CfjacuS/
         UI0PHLnMTRu4X/DEEH8g7wAB97Kk9Pimhjxi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937052; x=1700541852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ONkBbb+HnFKyr5bwkUFFQAkj5jFzRIolELIrPxQNcw=;
        b=GMwFDGd/uLaOqV4T0VKVGdhWUHfUVihzw5ww33FKuqF6goyTUTdQCyTf2jvhF3ze/+
         AAACUUlL0YFG6ENzuKOvzy4jTOxb9Ne6ogzC6N0EgcEVb653I2xgRsFEXuR5gKqWgu1q
         NEKfSRUXrrcm3aHl7tGtekH+raQF33SFWkoZ8qtp06O54YkvB5LKvSvqe3/EnFQ7WASx
         crq6ZQ24qiEyFGNfGwOfmzPPgcq1xFEiVlm9yY3dPd7cH98SyDAa4Fg7A2D2pUHbAokt
         4ShzdnV1WJj3SAi2Il1riQaoJr8JtHf0Cd1a8Ncdyr6Ou4IxuaYNyrE8nhGxRsibFz8N
         hb/g==
X-Gm-Message-State: AOJu0YzUdLjZYEbWNJ54GsGtD1Ca2sSM3HQcHaCfIIxnIFbuhObCKUuu
        aMFZV97DwGUF06/vhBD6MORw9w==
X-Google-Smtp-Source: AGHT+IEvf5pYK6DfVdWq7oR/LeTR2EzKGTFOoIWwPF4qXeh10Ft7VrEO5A5ARaNGpev0/vRNIRBDhw==
X-Received: by 2002:a05:6a00:3a1f:b0:6c6:9b11:f718 with SMTP id fj31-20020a056a003a1f00b006c69b11f718mr6590354pfb.4.1699937052092;
        Mon, 13 Nov 2023 20:44:12 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b22-20020aa78116000000b006be5e537b6csm389373pfi.63.2023.11.13.20.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:44:11 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:44:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 13/20] mm/slab: move memcg related functions from slab.h
 to slub.c
Message-ID: <202311132044.C7D682723@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-35-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-35-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:54PM +0100, Vlastimil Babka wrote:
> We don't share those between SLAB and SLUB anymore, so most memcg
> related functions can be moved to slub.c proper.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
