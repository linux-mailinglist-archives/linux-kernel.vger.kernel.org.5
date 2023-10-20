Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA737D0C03
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376625AbjJTJhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376594AbjJTJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:37:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA0CE8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:37:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507973f3b65so840631e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697794619; x=1698399419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIbmQF99/s2rYcy59JTD7+ck4BLqW2/5RTskyAaS6+Q=;
        b=lLDvsKe0RoJALNlk6MaMz1OVHLjDWMgKMZW5qHD4wn34TfoYRzTOFDZPDyxDo2iCIA
         5RO6H0kQ469cPVam6anPih0LxhKIBdxKBOUIZmNEwQX7oW1exgFaYnE2a3rXExS4JV9z
         5D/2Acvx9ZffXber3I0r0m3WDB4amn3bRoyE9xscFRkioZ+Fy5S+1tZmSwWwTR9uUfo4
         C5jfXALE4l9QRjQKmjfdS13PrwKQPWYmahA+Pf+r+8Alddz3VFzDl7TRKU5RDUUYySGU
         pUYK6u8KpgEwWcKPuSrI0Bmjw1od5VFCtNKBkmvGTb4g+MSthwzf2YfGa23IzKRa7QB/
         y9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697794619; x=1698399419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIbmQF99/s2rYcy59JTD7+ck4BLqW2/5RTskyAaS6+Q=;
        b=KJWjlM3+kgUqRgFwsX3BgnFQ3YnU3C2swLg+Bx17vVAFPIWRZfFstCpZQLXrjiRou5
         bbtojoVfrtHG9cSnFR7Z9kt/0r8LnWu6KbgJRwAaJL5CrV5uloLj250MuPDYU6rljBPx
         CLRbtTqukkGWqDThnlPMJkmkLLQuozoBDOa7lWasrePC/bwtd2Klu2mBPGuoJ90XtmK1
         wQp/U6D32CBjVIcy/OkScgHZ7VDnQd+t2x1u/WNy+Afa+AEQ3mcz0At2ilLCRjky9e5l
         thmET5Zz9WN1+tvH+fMwU1Q+klZrAXOuqVHL+Aq0/vwQotcPwBT0WS2PtiqXS21SkTTt
         Cx3w==
X-Gm-Message-State: AOJu0YxEhuj1cEA534IHgeeopaoPGob8ads+g5xaYJdhZZITQzK97xj9
        Oc8vFhzNudMfsO6iat6K/YKqLw==
X-Google-Smtp-Source: AGHT+IHR/b7ATwBp5soJ9wvY5qg6ujRkegWs+70SRKqdamkVtFyzNY8c4VOHd0vFvMxxkVX6p9EZiA==
X-Received: by 2002:a05:6512:2094:b0:507:9fa0:e244 with SMTP id t20-20020a056512209400b005079fa0e244mr906541lfr.65.1697794618973;
        Fri, 20 Oct 2023 02:36:58 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e24-20020a50a698000000b0052febc781bfsm1119785edc.36.2023.10.20.02.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:36:58 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:36:57 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>, Simon Horman <horms@kernel.org>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 00/11] devlink: retain error in struct
 devlink_fmsg
Message-ID: <ZTJKOf5tr8dawQiO@nanopsycho>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <ZTEyzpat4we6f4kE@nanopsycho>
 <80d1bdb9-f037-24b4-647b-df982fa0c981@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d1bdb9-f037-24b4-647b-df982fa0c981@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Oct 19, 2023 at 11:50:03PM CEST, przemyslaw.kitszel@intel.com wrote:
>On 10/19/23 15:44, Jiri Pirko wrote:
>> Wed, Oct 18, 2023 at 10:26:36PM CEST, przemyslaw.kitszel@intel.com wrote:
>> > Extend devlink fmsg to retain error (patch 1),
>> > so drivers could omit error checks after devlink_fmsg_*() (patches 2-10),
>> > and finally enforce future uses to follow this practice by change to
>> > return void (patch 11)
>> > 
>> > Note that it was compile tested only.
>> > 
>> > bloat-o-meter for whole series:
>> > add/remove: 8/18 grow/shrink: 23/40 up/down: 2017/-5833 (-3816)
>> > 
>> > changelog:
>> > v3: set err to correct value, thanks to Simon and smatch
>> >     (mlx5 patch, final patch);
>> 
>> 2 nits:
>> - always better to have per-patch changelog so it is clear for the
>>    reviewers what exactly did you change and where.
>
>agree that adding changelog also to patches would be better
>
>> - if you do any change in a patch, you should drop the
>>    acked/reviewed/signedoff tags and get them again from people.
>
>Here opinions differ widely, and my understanding was "it depends".
>Noted to always drop yours.
>
>On one side you have just rebased patches (different context of review),
>then with trivial conflict fixed, then with minor change (as here,
>0-init to retval, those are things that I believe most reviewers don't
>want to look again at.
>Then patches with some improvement that somebody suggested (as reviewer,
>I want to see what could have been done better and I didn't notice).
>
>In the above cases there is both time to react and no much harm keeping
>RB. Things I think that most reviewers and maintainers would like to
>drop RB start at "significant changes such as 'business' logic change",
>which is of course a fuzzy line.
>
>Always dropping is an easy solution, perhaps too easy ;)

Quoting Documentation/process/submitting-patches.rst:
"
Both Tested-by and Reviewed-by tags, once received on mailing list from tester
or reviewer, should be added by author to the applicable patches when sending
next versions.  However if the patch has changed substantially in following
version, these tags might not be applicable anymore and thus should be removed.
Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
in the patch changelog (after the '---' separator).
"

I guess that in this case you are right, it the change is not likely
"substantial".

Thanks!



>
>> 
>> that being said:
>> set-
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> 
>
>Thank you!
