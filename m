Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328A180D2E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjLKQx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjLKQx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:53:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A495F91
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702313643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0TaQIjCMRtqoHv9s+WpKU6yUC9m6qOxRLwTnSkQyVwE=;
        b=HjRrZDTmf17J5nJHNgY8cQDiwxNscZ3A87GUUJ9bYFZTJReLDmKtAwmFk//cT1TWGqfXy2
        und76s7TKF5d1l/CbGi/SwYQWYhByiHGzSA5fEHR07roZCJZdTfQPNFm6bDheCsRXS+xRS
        VVBYyrUZS40Z5qHAAJKknP21wH6g8aI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-cwrTXbyROV-Lz8aSUytsNg-1; Mon, 11 Dec 2023 11:54:01 -0500
X-MC-Unique: cwrTXbyROV-Lz8aSUytsNg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3334e7d1951so4147579f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702313640; x=1702918440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TaQIjCMRtqoHv9s+WpKU6yUC9m6qOxRLwTnSkQyVwE=;
        b=AMtdG3OOSHb4hYfEULTtHSnagm8cSFfixJjr9dNfjBwiMO3f2awc9PQcKr4NyYy0IE
         sMqieyBM1KZn8z48/NK7W2ekVN/Z2/iqho3I9sZGsiCkSyPqA3as+unI2rZ0b2iCCTmZ
         3ds4qrDPRpsGCMRLvK11hPgWOH+eW46qwV0lq0fOciJnHy/SgNuU3XWk8Q13uelcR+Y6
         vWSWSFNo8cdgNCxHlZA3U1PJFdjGlh/l9ySGfpfnM+VF5zGp+nCoicVyqOIMAsxEO5Zh
         OPcjTIewfPCOR2YMEzUiDwzqkaUnbRx+ULRV1nFB8F85CfWqZCg/1r/bAuBc+Jnpvp27
         WIIQ==
X-Gm-Message-State: AOJu0YyRlBWqto3ki+UW4reDHJagXC1EPutSQ8l81XYx0Jqa1/cbOIsf
        50LBKXPxCQj0B/qi70ulLFm5O1s6+2Hxk9XKoboGdP7+cKUVcZZgZhDEAAeEBbE3mFk2DSTA3Io
        Fj5lopYYxe2DTH48Wo2B5ukBXjXAbkbB8
X-Received: by 2002:a05:600c:450e:b0:40b:5f03:b3c8 with SMTP id t14-20020a05600c450e00b0040b5f03b3c8mr1125888wmo.234.1702313640093;
        Mon, 11 Dec 2023 08:54:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtiBxrV84vG/3P94lY/VLzXMvM+oAghyKtAHVVBITjmPRXIgn0MXg5y1PSG2jZcwLid9jfxg==
X-Received: by 2002:a05:600c:450e:b0:40b:5f03:b3c8 with SMTP id t14-20020a05600c450e00b0040b5f03b3c8mr1125883wmo.234.1702313639719;
        Mon, 11 Dec 2023 08:53:59 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ff:4f00:b091:120e:5537:ac67])
        by smtp.gmail.com with ESMTPSA id k17-20020adfe8d1000000b00332fa6cc8acsm8943445wrn.87.2023.12.11.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:53:58 -0800 (PST)
Date:   Mon, 11 Dec 2023 11:53:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Tobias Huschle <huschle@linux.ibm.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231211115329-mutt-send-email-mst@kernel.org>
References: <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org>
 <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:26:46PM +0800, Jason Wang wrote:
> > Try reducing the VHOST_NET_WEIGHT limit and see if that improves things any?
> 
> Or a dirty hack like cond_resched() in translate_desc().

what do you mean, exactly?

-- 
MST

