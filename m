Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4775E119
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGWKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGWKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D9810FD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 03:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690106543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MDsrxTSy5pdFtexf9LRIFDEmJDg8QkrIZ2QGbjkCzEg=;
        b=RQgEjY65Tl+vU3AIDavcBi8L9yBZxBbQ9OW+cApPy2rPb0GAnglw3+TwiaUyN13wSGdl+V
        7yNHaCnz3OznBW/GeCGWuV8VxmYz9uJ7CMDYrCtdtph8zTvvq7Ydwv5t/PN0/5V1c7bfx0
        BmS2NLpq+qkAWlBGsIu9V0qc6KTGLdk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-fntMUNwZPmqNizA8EJgRfQ-1; Sun, 23 Jul 2023 06:02:22 -0400
X-MC-Unique: fntMUNwZPmqNizA8EJgRfQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-314394a798dso1644080f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 03:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690106540; x=1690711340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDsrxTSy5pdFtexf9LRIFDEmJDg8QkrIZ2QGbjkCzEg=;
        b=exhZHKH6drSfCV7Tp6r1K0dF72iazvjgMUVliDv83SEvc8IEdDajNjRQuEl0T2nD6h
         QsA/a9m2mpNqtY9A76VDHTXewYUfLeGDDj/U+znnHxVnkMTgZZuwJ8bSugo6VNTBl7mT
         6sPQjICmL9sELECmC6vtmPC95IudGozJ+gYupzzUjvx51pwiyX+fAS7OjRD1BDyvr8tk
         ghPZRwxwiQ13ZYsqKwP3PfoKpRq1N3cCwLPHmBZEQnmTCzemxhuofZmFfZP+eGZ8yFSd
         Si4xv53hhXdL61AAQiAiCYcIFdxV+ivQqFEyfs7Ajumb8TdZehC65FQq2gs2hPhUvrlg
         WwwQ==
X-Gm-Message-State: ABy/qLZfgB9uR8BKNpGStPTHQt5yqaahSvp3Qcs6w4EiMPC2xLJw8YdM
        +CLmEirn3CJZn22B6huCwRdU+vDS/A855WgbSPDTteWHx//tQDNNpZopvkFJ1RsN4O4675MMsVV
        p9aStwyzpTLycquagyLb4A+J9aogQ2ExjA8U=
X-Received: by 2002:adf:f586:0:b0:314:1f0:5846 with SMTP id f6-20020adff586000000b0031401f05846mr8129287wro.19.1690106540636;
        Sun, 23 Jul 2023 03:02:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHyAZcTfeQBjC7G73huCAs7jm2K69QvhdMZ2qkoeEG9Sth+ZH3hv0lYt69KLL9FZqfhMrMYew==
X-Received: by 2002:adf:f586:0:b0:314:1f0:5846 with SMTP id f6-20020adff586000000b0031401f05846mr8129277wro.19.1690106540254;
        Sun, 23 Jul 2023 03:02:20 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id m12-20020adff38c000000b003145559a691sm9270907wro.41.2023.07.23.03.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 03:02:19 -0700 (PDT)
Date:   Sun, 23 Jul 2023 06:02:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
        Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
Message-ID: <20230723055820-mutt-send-email-mst@kernel.org>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
 <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 05:48:46PM +0800, Lin Ma wrote:
> 
> > Sure, that is another undergoing task I'm working on. If the nlattr is parsed with
> > NL_VALIDATE_UNSPEC, any forgotten nlattr will be rejected, therefore (which is the default
> > for modern nla_parse). 
> 
> For the general netlink interface, the deciding flag should be genl_ops.validate defined in 
> each ops. The default validate flag is strict, while the developer can overwrite the flag 
> with GENL_DONT_VALIDATE_STRICT to ease the validation. That is to say, safer code should 
> enforce NL_VALIDATE_STRICT by not overwriting the validate flag.
> 
> Regrads
> Lin


Oh I see.

It started here:

commit 33b347503f014ebf76257327cbc7001c6b721956
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 12:32:00 2021 +0200

    vdpa: Define vdpa mgmt device, ops and a netlink interface

which did:

+               .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,


which was most likely just a copy paste from somewhere, right Parav?

and then everyone kept copying this around.

Parav, Eli can we drop these? There's a tiny chance of breaking something
but I feel there aren't that many users outside mlx5 yet, so if you
guys can test on mlx5 and confirm no breakage, I think we are good.

-- 
MST

