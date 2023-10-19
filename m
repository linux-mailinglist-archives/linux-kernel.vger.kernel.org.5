Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF47CFDDC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346277AbjJSPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345450AbjJSPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:30:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F86A121;
        Thu, 19 Oct 2023 08:30:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507962561adso10081935e87.0;
        Thu, 19 Oct 2023 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697729454; x=1698334254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FWVeU9IigKcVsNnwc6AFvvF7vK4/01UmH97KV2uxsw=;
        b=IVrvJlgO2v4myj+dkNpwFhW3vJ3xYsBb6CbrokhO6QOIvNYx8EMmZLd8b/5LRDvIyj
         au8eC73E7ebWlEekOejUFJhf43DvKxM0fE5H1OiHYyJupmxSSUg07p8gpwQTwxrccfIX
         wobQlsZXDfL6UE4gv4oye8+y8Ku8KPL1nk6WN10vSnAYjztcK158JZD5ESXKu7+SIELb
         DW0twGkgVrH+Oni+15BnX7UvO0vo9PIcrKJeLvV7mm1dgSaugzony8pFYcLTv2+8+Efa
         g7zv/4Kuxmc4pKe8GViNkab7528ZW+KKy7BaC2JtEJi0p7hx+BQoRlORsG+urmADbmAo
         WpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729454; x=1698334254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FWVeU9IigKcVsNnwc6AFvvF7vK4/01UmH97KV2uxsw=;
        b=Lm5wz2jSZHZV8mEUn27tufZ8OBAySIhLQ8KY+DjABURG13jyIMoUHhqbMWEq7HkE1W
         XKYHB5rlHnkDeRav/hkTUPpUhWPVjvKRFdr8mJi2UZ9x/e/zuy2JnT7Hjpkg+SyS5Uup
         fzyp3ZVtKSN3hxGRu8VcXQhojyuitUNCsFQiwTx+mvLj8y/FOCPtnUzQh4S6VYxioA4X
         vGjjzC5ZeN3GD+Oh63uJpfGKPO2BWaP59u0qGUBakHQb6sSaxhifiLFYjZNsCZ51QoVB
         TcKRW+Sc8gjZNA66cYC1xeWrKBP14d0Doa7Pa/KTaZDNZkNZ6iWKCB1yW2rmz2m0RI/L
         E68A==
X-Gm-Message-State: AOJu0Yy8aNVRvYD3AyI1ByBx1ku0ZykzG48VzPRuN1Dbg4eEzNbaGnqy
        dVF5Q2StKycoKMzjr3PuDiY=
X-Google-Smtp-Source: AGHT+IGypHTslM4jzHKGC5Rcxh8As846X2fCX1u0jn27VNqfaCCTCqDXLPG4/BVtbxed1W+TEDszdg==
X-Received: by 2002:a19:e007:0:b0:500:adbd:43e9 with SMTP id x7-20020a19e007000000b00500adbd43e9mr1973084lfg.15.1697729453971;
        Thu, 19 Oct 2023 08:30:53 -0700 (PDT)
Received: from f (cst-prg-84-171.cust.vodafone.cz. [46.135.84.171])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d4524000000b00317a04131c5sm4753323wra.57.2023.10.19.08.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:30:53 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:30:40 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <20231019153040.lj3anuescvdprcq7@f>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 11:28:38AM +0200, Christian Brauner wrote:
> On Tue, 09 May 2023 12:56:47 -0400, Kent Overstreet wrote:
> > Because scalability of the global inode_hash_lock really, really
> > sucks.
> > 
> > 32-way concurrent create on a couple of different filesystems
> > before:
> > 
> > -   52.13%     0.04%  [kernel]            [k] ext4_create
> >    - 52.09% ext4_create
> >       - 41.03% __ext4_new_inode
> >          - 29.92% insert_inode_locked
> >             - 25.35% _raw_spin_lock
> >                - do_raw_spin_lock
> >                   - 24.97% __pv_queued_spin_lock_slowpath
> > 
> > [...]
> 
> This is interesting completely independent of bcachefs so we should give
> it some testing.
> 
> I updated a few places that had outdated comments.
> 
> ---
> 
> Applied to the vfs.unstable.inode-hash branch of the vfs/vfs.git tree.
> Patches in the vfs.unstable.inode-hash branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.unstable.inode-hash
> 
> [22/32] vfs: inode cache conversion to hash-bl
>         https://git.kernel.org/vfs/vfs/c/e3e92d47e6b1

What, if anything, is blocking this? It is over 5 months now, I don't
see it in master nor -next.

To be clear there is no urgency as far as I'm concerned, but I did run
into something which is primarily bottlenecked by inode hash lock and
looks like the above should sort it out.

Looks like the patch was simply forgotten.

tl;dr can this land in -next please
