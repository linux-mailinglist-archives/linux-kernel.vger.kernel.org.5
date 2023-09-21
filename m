Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B139A7A9B34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjIUSzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIUSzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0C79239D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695318852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4DhnAZiF0wr2DyC1BVNbdftxhtvdS4hZnADLGNEsyns=;
        b=C6oMlSj9vOvxLSKftHLwlmBqSH9mfnbibIKCcRyuWq2kMSl3perHsIEMANlP4OAB9q02l0
        U53EhspPJEKKdXzbdSlCb0U4SErqTh5yX+RtWwa6uckLUVgfXBlWIK6uiw6z0+0FhBPn1f
        Kzu07Di+u2uf6Q1adbaf88UtcUqO4BI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-I6tKz-3LONKqeHIperPg6w-1; Thu, 21 Sep 2023 04:25:19 -0400
X-MC-Unique: I6tKz-3LONKqeHIperPg6w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40474e7323dso5407435e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 01:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695284718; x=1695889518;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DhnAZiF0wr2DyC1BVNbdftxhtvdS4hZnADLGNEsyns=;
        b=tWLxW9v6r7UcBv7ujHDWuD3TpuzU8e2n2WjlMKjo8oFWAJdT4pFj/zGEAiZP/sVaIb
         mUOfwYb5TjP+2EN/qpdIS915/bC21DTE1nqWytKzE/+J7AlBg+HE52BR5Ub270zVDE0F
         KRILP0vmzq7yYFD9bLfwcbC2TJmin0Q2N26vFSvJQ7CWNt2aBIeGKzTkanUKUm/csuqT
         yd/zXydJgRgnSwufe5xdXuYKrKXrXt66uPa8SAq6V/Uda6PMhIO8GJ7gjDdf2iat57kv
         v+1n2rF3Gwb3eBgTNgwgh6wLvTkbasRx28ieN+WAw4jcmFcDEc1HMjz1QcNew/NgzadA
         6fQw==
X-Gm-Message-State: AOJu0YxCWgJGurpjcjE3tWGyuvLoTwR4p8LGH2tiJAJQWdPUU7RAKYbS
        TkfTlL9abOE+4vJfcA5Fcm9wZBX2jS0Fi4R/tz4QmH2mJtPT1MNkU3Qw/xoL6MwBstU0Nyjlhn4
        /UWl30GzqiLuZod3spcn+Im5t
X-Received: by 2002:a05:600c:2058:b0:3fe:207c:1aea with SMTP id p24-20020a05600c205800b003fe207c1aeamr4169771wmg.23.1695284718639;
        Thu, 21 Sep 2023 01:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMlLW9jOSs0MCkR9x1s1+0fp5+Yk4QxI0G/9XOImPxYltcXjOlbzST6Z0ZyPnmg3ZZkvlI6Q==
X-Received: by 2002:a05:600c:2058:b0:3fe:207c:1aea with SMTP id p24-20020a05600c205800b003fe207c1aeamr4169758wmg.23.1695284718288;
        Thu, 21 Sep 2023 01:25:18 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c444e00b0040535648639sm797911wmn.36.2023.09.21.01.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:25:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Drop _helper prefix from struct
 drm_*_helper_funcs callbacks
In-Reply-To: <2p53aei56tlr7k6w5oawlwpmv2k7agpbb6wfwpxcg3rqyueyrx@2as7tijrgnh4>
References: <20230914195138.1518065-1-javierm@redhat.com>
 <f5620d32-2705-498b-a65c-7dc663340a6d@suse.de>
 <87wmwo3q50.fsf@minerva.mail-host-address-is-not-set>
 <552hpgr7qzbjxuyei3n5m7rsn7ekwbdgzv25oe5vy6qb35gf23@q4etussk5jwl>
 <CAMuHMdUGVgj6V+N865QZaAusqD7O2f1askE544Z4MF0h4zBERg@mail.gmail.com>
 <2p53aei56tlr7k6w5oawlwpmv2k7agpbb6wfwpxcg3rqyueyrx@2as7tijrgnh4>
Date:   Thu, 21 Sep 2023 10:25:17 +0200
Message-ID: <875y44kk5u.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

> On Thu, Sep 21, 2023 at 09:57:22AM +0200, Geert Uytterhoeven wrote:

[...]

>> Anything else confuses the casual reader. Perhaps the real question is whether
>> the structures should have "helper" in their name in the first place?
>
> Those structures are meant for functions used by the helpers, they are not
> helper functions.
>

Ah, that makes more sense. I wasn't aware of that.

If that's the case, then the split makes more sense to me now.

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

