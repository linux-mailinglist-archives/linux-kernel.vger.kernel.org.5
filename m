Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147AD75FCD5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjGXRBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjGXRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF5219AB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690217987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4nkZEjGqKMSg9XiMs6wuEiyuXPT5uFzTR3xSKZPtXrE=;
        b=fnIBd060+/Griu41sHg37jVodQGCq0zKfoUnkG2DLNWx1UW++BLFcSlGE78Fn+h2nAdEZ7
        +jk/3VM2gON4t87lHLx2cTIfdcH4R0Vtai1xfw1QKbK9j0lx4c2qSJQYYDmCL5zMUR1fnN
        Ji/RVmoif6qCCTwJKdBNZqg6Ci0vE8s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-s_nU_LoDOiWwOboMfEiTaQ-1; Mon, 24 Jul 2023 12:59:44 -0400
X-MC-Unique: s_nU_LoDOiWwOboMfEiTaQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63cd05c0415so61271706d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690217984; x=1690822784;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nkZEjGqKMSg9XiMs6wuEiyuXPT5uFzTR3xSKZPtXrE=;
        b=AXPCbc0+mro+rqw5fQBb68UngegT2CkQdLOAQUuF7RWCYvJCV5D/IXkc3QJr4zPQBk
         0YzHWnQ/AGDBH/OlCe+cXyWNQd1HKlP5rBtrekm5UWYSfrnkMdECzVscKQOgPn1wTmox
         O5WSdR4bQvlUX22K8AM81i4DTB9UwmDOCJhz7OgzUPoY6pGHkmFNZmsPxVtu7X41luZE
         tM4PD2/y57uYUXHvWrfLDTBmp5l46TwOLxAYeh0rWyJv0yUE9zr7DKmV08bpv0u7fNNL
         1TqTfoCe0Xu+qaC3Y0uRbl+tnex/sD1vDiJ3QwOrD2dQsfnVNnkgCfLNZSgteYkpWAvH
         GdmA==
X-Gm-Message-State: ABy/qLYDoOa/HeH8/f5zLwAlMU9VdjeE9Zqd54MsUKG6YxF3/pCQ4UBS
        9ieh+7WRDJfRFrfuFxsUYNkJLh1K+QDMljMkMWMeYFiM5INqIIv638pH9Y+nVN7RSgDnoJURTA0
        h1nioINuosCMG3kguMu2s+JMm
X-Received: by 2002:a05:6214:4a4d:b0:63c:8afd:7273 with SMTP id ph13-20020a0562144a4d00b0063c8afd7273mr349404qvb.12.1690217984342;
        Mon, 24 Jul 2023 09:59:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFO7x4sJQe6yNcwbJzHDwKetm24F7RG9qQSBeAxMG+DYnqfAzn8WMDsH6icpFD+s4FFI4gTGA==
X-Received: by 2002:a05:6214:4a4d:b0:63c:8afd:7273 with SMTP id ph13-20020a0562144a4d00b0063c8afd7273mr349393qvb.12.1690217984140;
        Mon, 24 Jul 2023 09:59:44 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id v14-20020a0cdd8e000000b0062ffcda34c6sm3670040qvk.137.2023.07.24.09.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:59:43 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:59:42 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Feedback on Qualcomm's minidump (debug) solution for end user
 device crash
Message-ID: <ZL6t/sZTZBfvSYOm@brian-x1>
References: <0199db00-1b1d-0c63-58ff-03efae02cb21@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0199db00-1b1d-0c63-58ff-03efae02cb21@quicinc.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-arm-kernel list

On Thu, Jul 20, 2023 at 08:32:24PM +0530, Mukesh Ojha wrote:
> Hi Samsung/MTK/Any other SOC vendors,
> 
> This is to bring to your notice that, we (Qualcomm) are working on
> upstreaming our minidump solution which is to address the problem of
> debugging on field device crashes where collecting entire ddr dump
> would not be feasible and collecting minimal data from the ddr would
> help in debug direction or even help in root causing issue.
> 
> We have recently posted v4 version here [1]
> 
> Based on comments[2], community is more worried about, if each SOC
> vendor come up with their own dumping method today or in future and
> whether it can have a common solution to a similar problem faced by
> other SOC vendor.
> 
> We wanted to take your feedback if you also encounter a similar problem
> or maintain something similar solution in downstream which can be
> upstreamed. This will help us in a way to have a common solution in
> upstream.
> 
> [1]
> https://lore.kernel.org/lkml/10dd2ead-758a-89f0-cda4-70ae927269eb@quicinc.com/
> 
> [2]
> https://lore.kernel.org/lkml/CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com/

Adding the main ARM list to solicit feedback from other silicon
manufacturers.

The cover sheet on the v4 patch set is available at:
https://lore.kernel.org/lkml/1687955688-20809-1-git-send-email-quic_mojha@quicinc.com/

Brian

