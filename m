Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63DE7EA9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjKNEow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKNEou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:44:50 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A8124
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:44:47 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5844bc378feso3004609eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699937086; x=1700541886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dTW82VIg1zc6gWMgLEgKtR0yngdsI70qEuPsuyspTwo=;
        b=NyU7RZ+ObqZ3uQJelOG3FXRelZUwirl4yNnoKxS4uJcr/Nv+yeP3kSkVKbOntiW9kI
         GOGnPH61PvKnF9q2fNzbMiOPa8PenGcx6QY6yaLmSZpIFeAmRpFXyWTHgIBWHJxttofQ
         0C0lU/YjG1cXGoKO7QadaPHxuKWKGtcBLddF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937086; x=1700541886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTW82VIg1zc6gWMgLEgKtR0yngdsI70qEuPsuyspTwo=;
        b=UT/7aiJzZqxtb0Q6PILnxC/9/y8Rk3aPRD/ezn0ROTghzh98HNAJRgAVAwdTgvlH54
         ad54MGuAn8MEL5zZ9FJakWkfHOGLeaZY1+nIHh/uVi+W8q9dyKj3H2GOu/0C6lYL6W1k
         L3ug32kT8+XmGSq3LW+GlxVPah7zvBcThS5APBOOHaZJ9Z8fJlfxvKtmHoVLvcECq/IU
         rDksEbrza/SdpK+KNJEc0i7JbZLzsE8p9K6UokcJzF3Mv/nXPUQInr6l7Avr3aVF06pj
         HWbEmieToM60IfsM3+9A9+kMoJHxBWhx8L2MbFcVGWfOUpgglOG493OW7crrRKvtZXgX
         42iA==
X-Gm-Message-State: AOJu0YzZEAYFlTZWMxw5YxINYecXl7f7HxgZo0dA74GbR6TtpDiTaIfS
        H+6bm2dOP7eInBObB2tEpcSkyw==
X-Google-Smtp-Source: AGHT+IEHSCi3qmm+CEYh5S+KHw/ma3E20e49n+ffxfRFPgJdN9lczSQRNAtSX+4ACW6uKlNfJe1Emg==
X-Received: by 2002:a05:6358:3411:b0:168:e614:ace9 with SMTP id h17-20020a056358341100b00168e614ace9mr1513512rwd.11.1699937086576;
        Mon, 13 Nov 2023 20:44:46 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s16-20020a656910000000b005bd3d6e270dsm4044377pgq.68.2023.11.13.20.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:44:46 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:44:45 -0800
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
Subject: Re: [PATCH 14/20] mm/slab: move struct kmem_cache_node from slab.h
 to slub.c
Message-ID: <202311132044.6DE1B717@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-36-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-36-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:55PM +0100, Vlastimil Babka wrote:
> The declaration and associated helpers are not used anywhere else
> anymore.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
