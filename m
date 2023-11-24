Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1C27F69EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjKXAqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXAqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:46:09 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7165ED4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:46:15 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf5ceadfd8so246745ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700786775; x=1701391575; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyESJhHP/pA7tKXWx5D4jkhxltBcaPXfc9yFdB3lYZU=;
        b=DBUVo17z86SRMOOBFdHp2cYmFZYNHdOjvB2rZUe66ncJqD+NhueRu2xLfhqStXg6p3
         WzXwV4J1F9Zj4qw5HrhYh1X8+dv6cPemftNkVkPo6eWGzt6tIE+c/5crxOV0PNDLv0aR
         70XVWtbs+FCrpInWFk6sr4YFUymi/anQZzBp61IO0ogo3MeYeiuN75kZ0aTmobav19ad
         uT60zBIfTdVNyH+Y7oU11PwUm01h/b1j+ZR2Mb0JGZsssY4oiXF0xtPS3OEWQc0gQiHp
         ZWUg3g1FzAkPF/XIBseq8baAc5PFvS/A6HRIKS+7n/zCby7gZz0PIdJ63SnvAAKZ6GiD
         KJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700786775; x=1701391575;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyESJhHP/pA7tKXWx5D4jkhxltBcaPXfc9yFdB3lYZU=;
        b=ddYQYJ2OCczob0F+t1EUHAkekr5Na368mq/dGVjnuFkatN0Slq6cFGSPOBxQne1a3/
         YJY/w1pmA5FdDcUAwa2zazbDlXkgvdGNZhnmdhrAYrY6djeNSrcSwvr7ZAgAEl0hYrQi
         NAW0XN/tO9xeqWT3hoYZuoZH4PQjNu1bu+j23RN4U4IxpO2eAPgX3qCzmOREa/tluR7b
         76si46wSNP2gDsPNtYdOVMq2EEmzxiyO6bDu9gITpdxKXNPt/fDlxoGMfRHT4WVgWC9j
         mrqxhSs7rlz9+z0ijHf2Ou1N3O4yVmFtrjrfP+gYqZaevsABtKbatFeaQjm0ayx3zRwX
         McOg==
X-Gm-Message-State: AOJu0YwQfonOFE9FnFb9FEtsWupd+AcfzUwxLw5HyVsxpYY2OU0OWhSG
        0FgjZXf0+GnTyLjDgJEttptm8g==
X-Google-Smtp-Source: AGHT+IG9L5wkvJ9LV55yMZVFmvH9BcaUHyRQbnf/LCI7b+GigUlq7H9pPPL4PRM5AdlOR0f0KUTRiw==
X-Received: by 2002:a17:903:1245:b0:1cf:6573:9fe0 with SMTP id u5-20020a170903124500b001cf65739fe0mr609687plh.16.1700786774750;
        Thu, 23 Nov 2023 16:46:14 -0800 (PST)
Received: from [2620:0:1008:15:ab09:50a5:ec6d:7b5c] ([2620:0:1008:15:ab09:50a5:ec6d:7b5c])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902724100b001bde6fa0a39sm1951963pll.167.2023.11.23.16.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:46:13 -0800 (PST)
Date:   Thu, 23 Nov 2023 16:46:13 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 01/21] mm/slab, docs: switch mm-api docs generation
 from slab.c to slub.c
In-Reply-To: <20231120-slab-remove-slab-v2-1-9c9c70177183@suse.cz>
Message-ID: <ea6d3060-1517-6eac-8939-1f3d004cef1a@google.com>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz> <20231120-slab-remove-slab-v2-1-9c9c70177183@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023, Vlastimil Babka wrote:

> The SLAB implementation is going to be removed, and mm-api.rst currently
> uses mm/slab.c to obtain kerneldocs for some API functions. Switch it to
> mm/slub.c and move the relevant kerneldocs of exported functions from
> one to the other. The rest of kerneldocs in slab.c is for static SLAB
> implementation-specific functions that don't have counterparts in slub.c
> and thus can be simply removed with the implementation.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

This is new to v2 so I didn't technically get to test it.  But no testing 
required on this one :)

Acked-by: David Rientjes <rientjes@google.com>
