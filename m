Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690507EA966
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjKNEOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKNEOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:14:43 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B343D51
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:14:40 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c4884521f6so4371172b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699935280; x=1700540080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2Esu3+YQCIX73TjWrtGheLocNwWakeCmjYailfwoZQ=;
        b=MCQioEW6V+eCI/33aqtY9Xe2THUUbr5HS3sieh7gOarPyZ02Qw/J2PvtMGq8WiA5JX
         9SzWrqyNNtFReBa4z3YQ3JlBMl6to2BfG701cf2wnwrYY10518kFpjtQpg2Au4Tl+A3s
         uZe4obsE2x1BKhpaaEcCXI2SC1Dv5w7uhsp3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699935280; x=1700540080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2Esu3+YQCIX73TjWrtGheLocNwWakeCmjYailfwoZQ=;
        b=ZJxcwAy/lbjuG/tzT76H/tDa5ZolQfnaSVXuiP3Xj13CmzDGYW/3wNX6sIjdnwT48T
         tWMOVxzjE7DDRIbpBcJBMydCq+MV6bRXcJfJ0Emd509fIsOtYuuAZIatbdNH+lOe+NsN
         MR6HyeSB5v9UZlq88VWJumP5t/CNZoarhQmHOIDF6HuH8pyJp+rL/NfiLcsGCJZ/JrkO
         OAu8vs44Dzi5DU0sOcbFFHkysCBBRP3vfEgDT9t+ZBwZ/sf8ISGrc2wIMY0RIrLu8Khf
         c2PXHFJuKQ/YkXepGSmARnePVZdI1u3PdPEh2VWDFYZFD2+ZIj0XaTKzRiLeR6ERQ1S1
         zP+g==
X-Gm-Message-State: AOJu0YxVh9opD3+7aabr8mh+EtKr1ivKr1LXP7/caWVOYVppqt4yM1Ri
        0Nl0RF6IeYaqj6zl66XYd0cRxA==
X-Google-Smtp-Source: AGHT+IGCneV7PtQMzCmZ88wslaQb+x3DXpaYJcES4QpU4Zi4tRF8aU2Wpu3C/XhsasN/dPCLeWXBbQ==
X-Received: by 2002:a05:6a21:a598:b0:186:7842:ad0f with SMTP id gd24-20020a056a21a59800b001867842ad0fmr5685978pzc.31.1699935279698;
        Mon, 13 Nov 2023 20:14:39 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902778900b001ccb81e851bsm4739949pll.103.2023.11.13.20.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:14:38 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:14:38 -0800
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
Subject: Re: [PATCH 03/20] KFENCE: cleanup kfence_guarded_alloc() after
 CONFIG_SLAB removal
Message-ID: <202311132014.809B164D@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-25-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-25-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:44PM +0100, Vlastimil Babka wrote:
> Some struct slab fields are initialized differently for SLAB and SLUB so
> we can simplify with SLUB being the only remaining allocator.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
