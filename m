Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F6977DB10
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbjHPHWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242379AbjHPHWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:22:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3DC2117
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:22:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso58445215e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1692170547; x=1692775347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3vDeZ9sAL2XfqwLLHhYqTBuGA7XemTxu1Dgf9vMBANY=;
        b=YNwFh/CZl6Y1aAsyLaExSWO4SaEaI/1hZPtdvbGJKXOur3CBIL3mIxhQ1kyR7gNz0/
         dMJh+OztB//yFRThq2cR4xX/m62X8N+ucK9phdVQTUj0ISWbcQuCHm0OW92CiIw/imsf
         5RQyOiRZm3uFJarWzBJ3cCtYL8PNMtRv6XP1thhnytVzAUT5g4j26++Lkqa9mTOI2juo
         yeVfnwOFsu85qJVhEdafUNnRTNPgyRDxiMNpdDW01QVrFlw9W4tPyzlg3dEJYXQ5rfaC
         i/jWfgNb8jEt7yVENyIo60Gjp47wQpLtoHjzs2NdQVL+Sl97Dy2T5CMbDcgqry+tozyt
         GUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692170547; x=1692775347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vDeZ9sAL2XfqwLLHhYqTBuGA7XemTxu1Dgf9vMBANY=;
        b=chkGFtr9Vh7E9ZicbT7yxrn646VSpoRKZRsgkHIwptIJNSHf+DbkKGv8gVHGrSgk1Y
         ZVHewGYwovGiqL9tYVgIOJJih06DT4LdahF6Xzd3RHBh39VFLhcs2bVTlNZA40XWKEcf
         RDUv+7vTK08Sgq2NtAJwH70mddRGQQm7jiyj1QkJ9GpmyaxHqLn8+39urllAPNxIVsU6
         zZY9sWz+YYoWNR5Ae9tKWfehSQBqxfEgPKQMnjz2yAwPwDbdvcyWXyjZmKPKyOBl7HwT
         Zg8Be+c4fUa149+ihGYlLmO3DxLHN7bh1+hmU0PRqGDhPrrB651xfRv3464IRNXiI0Xh
         il+g==
X-Gm-Message-State: AOJu0YwwZYFv32n2bdcTuEE2yu24dZThRYb7w+IhjFYtBcJBZpoXuSD1
        PdA+1TKGUR+xi860StUOfNg1BQ==
X-Google-Smtp-Source: AGHT+IGy6kFbupZaNOki9+UOmwg+uZxOM6PYn7UJ1AdKLKltOEBk8YpBMGzAzKAavALkAC1UmtD3XQ==
X-Received: by 2002:a7b:c5c8:0:b0:3fd:2d42:9392 with SMTP id n8-20020a7bc5c8000000b003fd2d429392mr683551wmk.4.1692170546837;
        Wed, 16 Aug 2023 00:22:26 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id g7-20020a7bc4c7000000b003fbdd5d0758sm20091816wmk.22.2023.08.16.00.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 00:22:26 -0700 (PDT)
Date:   Wed, 16 Aug 2023 09:22:25 +0200
From:   Adam Sindelar <adam@wowsignal.io>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Adam Sindelar <ats@fb.com>,
        David Vernet <void@manifault.com>,
        Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v5] libbpf: Expose API to consume one ring at a
 time
Message-ID: <ZNx5Meh0doxdXs4H@Momo.fritz.box>
References: <20230728093346.673994-1-adam@wowsignal.io>
 <7c792532-4474-b523-08f9-f82fb57f1b09@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c792532-4474-b523-08f9-f82fb57f1b09@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 06:51:25PM +0800, Hou Tao wrote:
> 
Hi, sorry for potentially dumb question, but should I do anything else
after someone acks it? This is a minor patch for a userland component,
but it's really helpful IMO - is anything preventing this getting merged
at this point?

Thanks,
Adam

> On 7/28/2023 5:33 PM, Adam Sindelar wrote:
> > We already provide ring_buffer__epoll_fd to enable use of external
> > polling systems. However, the only API available to consume the ring
> > buffer is ring_buffer__consume, which always checks all rings. When
> > polling for many events, this can be wasteful.
> >
> > Signed-off-by: Adam Sindelar <adam@wowsignal.io>
> 
> Acked-by: Hou Tao <houtao1@huawei.com>
> 
