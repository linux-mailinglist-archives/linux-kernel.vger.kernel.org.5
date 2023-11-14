Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C0C7EA969
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjKNEPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjKNEPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:15:05 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102DDD49
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:15:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc3bc5df96so37691555ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699935300; x=1700540100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUC30dXlQK5fmzms4eR9YZ2PZDBao2AfV4/azmUSi6E=;
        b=CUsWneXIcMotUZhN15TwQakUl4TojQ16Fly7Zo0z1Bnk+y+4D6683M6XAF+U1rpWUj
         H8CSlLmqqegdrg3tety2aNkL8gTPnz+vXFiMoLXMIrrYXyN2XRlE002mM4Szg4B50wRV
         xkLqYuwqrTkBRf5gJPbaODkPbGmU4P53hZx3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699935300; x=1700540100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUC30dXlQK5fmzms4eR9YZ2PZDBao2AfV4/azmUSi6E=;
        b=vUNWJJSpJ3+sjeH6OWj6BCdTBaLsuoRqYDWQS26tS7hQPi1mZkdg/4KeIhHcOTjonG
         hQA3ydbpOxeoifdL4EBgr95gz3FgACuBT0D4nl7qoQmucYvOhXE7aYTbuxPn5zrKchSF
         qDVQUFTn1lxTAes/XhW1NHUXAYf2odTf1BU/1DWZ08B2UcyqT/lD2P7/y9s0CKZ1E1SD
         lO/ez8rNfX/LrMaLjaiBPex5wbyirDg1h6ZeG8ht0s4orOVdi3ycL7TQXBcR1CG7o/t8
         ypWpHEmGJs0AAc7SnR3imWeDnlLokLFBVKGA0spepvUx1pbRE50sT28qMh5Go5NcqKnK
         PWRg==
X-Gm-Message-State: AOJu0YwXyj+r2gqT1CuPgN/18fDkrhSMMx9j5dA1uvoxn69/jh8ilfFY
        6StjjpSQ+hGeg2Qd0xdlZVQhQA==
X-Google-Smtp-Source: AGHT+IEmPIYVtjWrKxgWx/6E037p3LrYP3ZvBjQTSGRoCVVM2HVRsHTaY6qgDIjr5rZO1Nl3XZts5A==
X-Received: by 2002:a17:902:7d8e:b0:1c5:d063:b70e with SMTP id a14-20020a1709027d8e00b001c5d063b70emr1114726plm.53.1699935300585;
        Mon, 13 Nov 2023 20:15:00 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001c9cc44eb60sm4799660plb.201.2023.11.13.20.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:15:00 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:14:59 -0800
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
Subject: Re: [PATCH 04/20] mm/memcontrol: remove CONFIG_SLAB #ifdef guards
Message-ID: <202311132014.F03494F@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-26-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-26-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:45PM +0100, Vlastimil Babka wrote:
> With SLAB removed, these are never true anymore so we can clean up.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
