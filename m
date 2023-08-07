Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E147728CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjHGPKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHGPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6CE1BC9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691420935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSkCa7A9TXUS3VXQ5McnNNZT+8+UROTnmjHayz9OLCM=;
        b=JyUWdC1+dQMg1jkeNv4Ru7IOgiSahDx8iSTkjbffzuQdrVAhBywgrkPitr+GgxMpu7tKM+
        E1eUljOY6kJ1Is5nKXGX8qho48Q+eaxa82mOU7JLiUuOm1ioRHaElxc0YZvR1JzJVZDMQr
        juaRCPk1Dkg+/ySlNBD9DbgUDcDSGEY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-x6x7S_D1OEKZ-2lQEdSVOw-1; Mon, 07 Aug 2023 11:08:53 -0400
X-MC-Unique: x6x7S_D1OEKZ-2lQEdSVOw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-d27ac992539so4863413276.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691420933; x=1692025733;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSkCa7A9TXUS3VXQ5McnNNZT+8+UROTnmjHayz9OLCM=;
        b=RbPOPbjsyVVngu6oLPEtoMeTqwMggULZbTlbYCHJYdSFzKcOrvAJGFQxpezsEG/yIv
         RBnjpzUOhWhW5pcIfpPUbVMRatj/6cZcAnh4IBH24L9uOB7vhfIHmxiiPsjwjoMSQJ/0
         m8kxNJg/ScmVTAe88UtuqWdkdM0V0tE4fEeBO3UuBP97eO0Njsc3FyTx3IaQSDitlnpG
         vMMqO5ZXNZtqE2kMgf885HjSgDa0FJWufPcNjfUHvlF2FbN1DalvO83+q0luC4SGEuwk
         e9KjJebA7RmTJL+ktnC7gxEQSRUjzXWhmfJ1g2AOsG9TkZzMcudUUa5ZUxbr7pKzjc25
         yZxA==
X-Gm-Message-State: AOJu0YyHPnbvLQqmfYXePdxcusFrJc9sPEw9yeUlfy1/7m66TirS+YgF
        lcllqYV1Y8ck0t+ZDGMLVBUqVYWGDKgarQuno2QGXfQZFGkWCRzBIldLOu2DpViFUzF7xeUW0MY
        l41Fhm0MIWw3n6LKOaFIgRCKC
X-Received: by 2002:a25:29c2:0:b0:c62:2320:2598 with SMTP id p185-20020a2529c2000000b00c6223202598mr8059907ybp.62.1691420933320;
        Mon, 07 Aug 2023 08:08:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFwHp4dDJnIOl2S3nXfBjqj/u/Iz50+0PkY1Lm8o+KMODDnct/IB/u4h0wbSKzpgdvXF7AeQ==
X-Received: by 2002:a25:29c2:0:b0:c62:2320:2598 with SMTP id p185-20020a2529c2000000b00c6223202598mr8059891ybp.62.1691420933058;
        Mon, 07 Aug 2023 08:08:53 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id a10-20020a5b0aca000000b00d1dffdd7a97sm2250323ybr.57.2023.08.07.08.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 08:08:52 -0700 (PDT)
Date:   Mon, 7 Aug 2023 11:08:50 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: Feedback on Qualcomm's minidump (debug) solution for end user
 device crash
Message-ID: <ZNEJAh0in/fjq6s9@brian-x1>
References: <0199db00-1b1d-0c63-58ff-03efae02cb21@quicinc.com>
 <ZL6t/sZTZBfvSYOm@brian-x1>
 <15caeb52-b670-9000-fa2b-b8d1b8485016@kernel.org>
 <81b15738-615d-a039-7bc3-22aa5b3a54bd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b15738-615d-a039-7bc3-22aa5b3a54bd@quicinc.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 06:01:27PM +0530, Mukesh Ojha wrote:
> On 7/30/2023 5:14 PM, Krzysztof Kozlowski wrote:
> > On 24/07/2023 18:59, Brian Masney wrote:
> > > + linux-arm-kernel list
> > > 
> > > On Thu, Jul 20, 2023 at 08:32:24PM +0530, Mukesh Ojha wrote:
> > > > Hi Samsung/MTK/Any other SOC vendors,
> > > > 
> > > > This is to bring to your notice that, we (Qualcomm) are working on
> > > > upstreaming our minidump solution which is to address the problem of
> > > > debugging on field device crashes where collecting entire ddr dump
> > > > would not be feasible and collecting minimal data from the ddr would
> > > > help in debug direction or even help in root causing issue.
> > > > 
> > > > We have recently posted v4 version here [1]
> > > > 
> > > > Based on comments[2], community is more worried about, if each SOC
> > > > vendor come up with their own dumping method today or in future and
> > > > whether it can have a common solution to a similar problem faced by
> > > > other SOC vendor.
> > > > 
> > > > We wanted to take your feedback if you also encounter a similar problem
> > > > or maintain something similar solution in downstream which can be
> > > > upstreamed. This will help us in a way to have a common solution in
> > > > upstream.
> > > > 
> > > > [1]
> > > > https://lore.kernel.org/lkml/10dd2ead-758a-89f0-cda4-70ae927269eb@quicinc.com/
> > > > 
> > > > [2]
> > > > https://lore.kernel.org/lkml/CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com/
> > > 
> > > Adding the main ARM list to solicit feedback from other silicon
> > > manufacturers.
> > > 
> > > The cover sheet on the v4 patch set is available at:
> > > https://lore.kernel.org/lkml/1687955688-20809-1-git-send-email-quic_mojha@quicinc.com/
> > 
> > I doubt anyone follows the lists, so at least Cc some maintainers.
> > 
> > +Cc Alim, Kukjin, Vignesh, Nishanth, Matthias.
> 
> Thanks @Krzysztof/@Brian for extending the list.

Hi Mukesh,

Since no one has responded yet: I suspect your best bet to land the
minidump functionality upstream is to refactor it to use the pstore
functionality that Rob suggested:

https://lore.kernel.org/lkml/CAL_JsqK7MHR09U5h01=Gf1ZLeDVCgZdN-W1hQRH3AX+E94_uUg@mail.gmail.com/

Brian

