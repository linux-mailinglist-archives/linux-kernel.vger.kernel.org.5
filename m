Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826387EA956
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjKNEHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKNEHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:07:33 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98172135
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:07:30 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so4028704b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699934850; x=1700539650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGZDmoEeCuoU4ORpnmk9KfAQBb9nHs+S5VafgrXpLog=;
        b=OfNKxU322KZVjePI1loy34wSlGlIKMBmDmy99ZOFtq4ztAVQq4NX54XXXzwcAsbI9G
         FbNPsBy+4IXbY9XPuyIc/HyafVB5Il5Xh94msMqXDmOuca4YNNJjP03kUCSWksg5GaV6
         P7vIjnV0EiZE9e0iruk+nA7B2LHuo1R10Uhmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699934850; x=1700539650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGZDmoEeCuoU4ORpnmk9KfAQBb9nHs+S5VafgrXpLog=;
        b=cZVgZZhbkiPXqeoV2NVMrKMo5kL9uVtvU7VnPqZC7l7hrc6s/OhxkAOHIgAkb8UOFt
         tHT4IR9dESEeHcm3SbIAhPkRJ/kpNy7i2O4Ok3FImPoIp08MMKKbcrQ/IPzSnm07Igen
         qSLKujnVkHg2rXS5iNlmOa2+q6nTH31svZKFtk9sN1q0x/PkctOFjqeo/asuT4nJ0xIO
         Kkp7Suz4hEyOYsSVPYOJvoBNjemVo4qaG/u7I6jExagKBtKZnMDCwcTGir6Xl3UCMKEK
         D4CFJPW1omhr2z72Tw/8tcvHlARF8lI2QvmIdk1DGDr1Q1WpFdvMVl0IdOVFL8XZXptR
         7prw==
X-Gm-Message-State: AOJu0YwU+bQvFqP8zFtCQEDwH5wseyxQOj3fPrDzmsrgAbfu4B5fchml
        XoAb14VyThR2HXapO9ofrhP35g==
X-Google-Smtp-Source: AGHT+IFyU2MADg9EleoYCMTUi5z42Da4Qrzy3K4tyZn3glXnx25v+sXlqweMXpTqFAPp362Amxy4Qg==
X-Received: by 2002:a05:6a20:6a04:b0:186:7988:c747 with SMTP id p4-20020a056a206a0400b001867988c747mr4329657pzk.19.1699934850013;
        Mon, 13 Nov 2023 20:07:30 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903024f00b001c62b9a51a4sm4782100plh.239.2023.11.13.20.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:07:29 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:07:28 -0800
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
Subject: Re: [PATCH 16/20] mm/slab: move kmalloc_slab() to mm/slab.h
Message-ID: <202311132006.51222C473@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-38-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-38-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:57PM +0100, Vlastimil Babka wrote:
> In preparation for the next patch, move the kmalloc_slab() function to
> the header, as it will have callers from two files, and make it inline.
> To avoid unnecessary bloat, remove all size checks/warnings from
> kmalloc_slab() as they just duplicate those in callers, especially after
> recent changes to kmalloc_size_roundup(). We just need to adjust handling
> of zero size in __do_kmalloc_node(). Also we can stop handling NULL
> result from kmalloc_slab() there as that now cannot happen (unless
> called too early during boot).
> 
> The size_index array becomes visible so rename it to a more specific
> kmalloc_size_index.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Yeah, removing the redundant size checks does make this nicer to look at. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
