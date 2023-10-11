Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC887C4CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjJKIPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjJKIPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:15:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834FD9B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:15:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40535597f01so61258085e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697012099; x=1697616899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtpagy2FOAC+A5GQkeyxkxyJtI+owSgz6W8MfKmR89U=;
        b=pz4t2y1UiskQpLcGhsbTsrF16V7Kyf1HXEd56nBXlVdKfmGiI06BaByidA1HhhokTV
         r8wxkysmhnyCxIdaEgOJtI9AeTp3kR37I99Iqoze9TENa+L4ldSOsaiV8VX9/awiiWJf
         Ms1NuqqrVK1GKVZ5t/tmOqHTV+MZUbyP6Y6pdvJ4BUJ7nCARXiQM4+Ce9ITD17XDKBTj
         cP2mV9h5KFayo9zKGfyQQbmEkK4w4O0sD4O/V2k/FhWGG2s8YfDq3Ciq2qyTAORv2qxB
         1ebmbjGbWpKczc9+nPmiZIWpy6zCoZJtXkW/y/lEFqEaIE1hp46X1+GwFkZ6d03y9X73
         8QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697012099; x=1697616899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtpagy2FOAC+A5GQkeyxkxyJtI+owSgz6W8MfKmR89U=;
        b=VW/hJOy8iJkNvMV615LSnZWuL12yaOZaAmOdzOMxfMkajHivP0l4Msfa+loGEKM6QB
         V9jgnKJorZrZeM4eg9OsEKSn3dtmas4cQyOlB3rhtlRzEDGAXgLYRJYiY915zC5ei+UQ
         TsdgWQIuApQs0IPW2hE2MMvw1hqNB9cQKf7a599zz57996PoV2/MUL0PQ38TlB/F3MCx
         6dXJ1rftzzcIwUqZ9DweC2KoRpAPkElGgsi/DLi/hSpETZXzZcuA7abrkI+MoD/Sn4xd
         QnF9O0cYMDwiAz2ybRP1ncxGVoU1+5f7L7tryflUcXR/RLYVrGvG7mVzSoe1FZBSOhYj
         LyGg==
X-Gm-Message-State: AOJu0YxOztSg7Q0yQhppSSnDe8iprTESv9okM6FT+hBVD2/XB73F3YYj
        UAVZM1QrOR6j4rOnznuc0EKhLw==
X-Google-Smtp-Source: AGHT+IH+nFbUIrVmTEv6gMfTbmCrdI4fJezaJJy9xkJMds1ntqxtbKt+3p2wLJX84bwnz9RfZSqaUg==
X-Received: by 2002:adf:f641:0:b0:31f:b6ea:af48 with SMTP id x1-20020adff641000000b0031fb6eaaf48mr17486391wrp.49.1697012098954;
        Wed, 11 Oct 2023 01:14:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v6-20020adff686000000b0031980294e9fsm14561839wrp.116.2023.10.11.01.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:14:57 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:14:55 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Xin Tan <tanxin.ctf@gmail.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-XXX] SUNRPC: Add an IS_ERR() check back to where it
 was
Message-ID: <38b1b94c-3ab1-4fb5-ad8c-946756262bdb@kadam.mountain>
References: <356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously net-XXX is not what I intended.  This applies to the nfs tree
I think.

regards,
dan carpenter

