Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452607DE1AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbjKANSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjKANSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B468BFC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698844681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s06ZDF7kdX12UrkeieLeIAq7cjcFY81tTAswnpTaseg=;
        b=FWMJjgZtmzc4voGf9QjXcB+ngZdQSbzGfhWGUs6v5eQZl5KAgLaJ1u9KpchXJdhyLEAPd0
        IU/DoT+XBFiTopeq3TfWtxev4NBUNLNMUG7qmf+iwwSJ4h0Rr48x/escixBb1ZKYpvhlI5
        xbYyLlNpt3H0G0fANfsxdl3rx9hEgmE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-vgZcnsVrNnmvkdnFFpJAHA-1; Wed, 01 Nov 2023 09:18:00 -0400
X-MC-Unique: vgZcnsVrNnmvkdnFFpJAHA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77a033cbd96so740107185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 06:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698844680; x=1699449480;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s06ZDF7kdX12UrkeieLeIAq7cjcFY81tTAswnpTaseg=;
        b=sQjNiyr+vh7qDFgVbqvZNwM7uUlUlvv33ceM09YTq4L7R6ZkP3SkG4D/qxvwdQ1uoW
         YtFJjOr73pdcgaXvMTYaPS0AjzlOvqE8uSUmMloYBBl1hpQZXk3vY6eAqv6kq0jVENfR
         ZWlGSvod8i4iG3txgpTQYKjzGsUW4sxB9neNrn8u6JbMwkVhb7LA5yePceU6DNBY5cjd
         yLYK35b6/KOm9VHu3jJ1rtY2Owc8mXNluMfEzIR6VsCpPkCCHwX5S9wXR9RA6kcrm6ae
         2oMhLZTyb4FWGJtr+N95lm3K5z41Wl3CjM4FSTqW7sw1ivltSsje/mY6gBCAkAJN8si2
         XAsA==
X-Gm-Message-State: AOJu0YxuKCjiylUlQ3O1zgUcrY+T0cq3riJNYttJ8ufRrbJCj9It8QNH
        BJofbsF0qNBVC5LFbdxYXRiSC/ZoBekVMxJv5/rucFmrdxyhNdZsysq0vqMOBGs1TAEMfRD7yeF
        CssdbBgnvG/5EF81RVzaibGqR
X-Received: by 2002:a05:620a:f10:b0:77a:50a0:6ed6 with SMTP id v16-20020a05620a0f1000b0077a50a06ed6mr1789474qkl.53.1698844679811;
        Wed, 01 Nov 2023 06:17:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSN4rAJxOYDw11HsIVNkPvlGoyLL/vMzzNEBsNspNkZyo/UkchV2Z7kOFZ4xPRqUii4aQK4w==
X-Received: by 2002:a05:620a:f10:b0:77a:50a0:6ed6 with SMTP id v16-20020a05620a0f1000b0077a50a06ed6mr1789453qkl.53.1698844679505;
        Wed, 01 Nov 2023 06:17:59 -0700 (PDT)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id m11-20020ae9e70b000000b007671b599cf5sm1408271qka.40.2023.11.01.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 06:17:59 -0700 (PDT)
Date:   Wed, 1 Nov 2023 09:17:57 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
Message-ID: <wagl7nc7pkhii3x4sfsrklghijumaitniwxxgplh7rqp3ddhfn@7l4syj422xcy>
References: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
 <65416d9fc1024_bcdbc29418@willemb.c.googlers.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65416d9fc1024_bcdbc29418@willemb.c.googlers.com.notmuch>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:11:59PM -0400, Willem de Bruijn wrote:
> 
> The patch subject mentions UDP GSO, but the patch fixes the udpgro
> scripts.
>
> There are separate udpgso testcases. So you probably want to s/gso/gro.
> 
The patch synchronizes the connection between the two binaries;
udpgso_bench_rx and udpgso_bench_tx, which are launched by the udpgro
tests. I can remove their names and just specify "synchronize udpgro
tests' tx and rx connection." 
> 
> 
> Might a grep be shorter and more readable?
> 
Noted, will change it.

Lucas

