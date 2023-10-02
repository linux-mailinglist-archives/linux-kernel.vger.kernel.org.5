Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5927B5A58
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbjJBSkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjJBSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AC4AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696271952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WYt6bra2fRdXu2dkXwuYoSR3Jxl4VEKHXbPW5NpZljc=;
        b=JzHq0TtQkTWjAKIsDt6j/JaZYaWn2Y/JfF/IsJXcfnnDdTYBvMY5AzK/1G8jSmheIy4Krk
        OfL8fn9H7M+zXyvd9oo/Fw9wpIJ3mOHiUMA2KL4wG4089ubDwSFofd7u7q4DislNiVK3lx
        oELOYpGkkJdCPhtPgH+fwvMGOQs4AOc=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-yXke03orMie9aI9aEUM5tQ-1; Mon, 02 Oct 2023 14:39:11 -0400
X-MC-Unique: yXke03orMie9aI9aEUM5tQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a213b4d0efso1232847b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 11:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696271951; x=1696876751;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYt6bra2fRdXu2dkXwuYoSR3Jxl4VEKHXbPW5NpZljc=;
        b=ifkLn4Mn1rTWR5HueI+GC2tfiMaLqFSlshPXypxrcnVirj0P7XNyTRDIIVsOp5OQrA
         ifxgxJ+nJM37TJp4ezjZhlf3dAG4tEgxKxKKoCYSSWUNdoO3XgAUpkHqRiDD/6m1NQ8S
         xE3I0JHTiOA2Ys6aF8fYejYQeTgMn0qCO6LbAsIw98EY0UFKXUrep6g87lXhH/OZODbx
         d9JXvG4oxwMx3Yn01OowPvcLrUp/HW4BX5MuzKeJ7l3uzH555IK9ig85zT45fRQ5IpmE
         RMCtfvl7FDsyaDqfx+tA/LtDr4+vH/vrNU9WEpOGnBspaSeOF3mi1fCQpKGuMSeyn1BK
         aY4Q==
X-Gm-Message-State: AOJu0YzJZsIhRgdzRc90OPSMwCxRlfIs/oYW3KvmoMrO3iWlLzSuSAmo
        gN8TCjRcchiB4Dnj31DwE3ubMWNBfl/cFQqg5nhFSgCcmCXYlbQ2IryACiUfoGKAXjKZiUZqRwD
        d+isz2sIHu17QKOzgDwP462T2
X-Received: by 2002:a25:8603:0:b0:d32:f2e7:7786 with SMTP id y3-20020a258603000000b00d32f2e77786mr10996417ybk.56.1696271951093;
        Mon, 02 Oct 2023 11:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOWEC4ny8KWu3fUPvQKn4wRh0cjkvr8hu/5wFhvnGe0yZ1IUYjTdLH/xTEiyfLSuO18WFTAQ==
X-Received: by 2002:a25:8603:0:b0:d32:f2e7:7786 with SMTP id y3-20020a258603000000b00d32f2e77786mr10996398ybk.56.1696271950763;
        Mon, 02 Oct 2023 11:39:10 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id n5-20020a5b0485000000b00d911680fd10sm236158ybp.50.2023.10.02.11.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:39:10 -0700 (PDT)
Date:   Mon, 2 Oct 2023 14:39:08 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] firmware: arm_scmi: Add qcom hvc/shmem transport
 support
Message-ID: <ZRsOTH//BZ74mU6P@brian-x1>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <20230911194359.27547-5-quic_nkela@quicinc.com>
 <ZRsNHnuUdGl+vuqz@brian-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRsNHnuUdGl+vuqz@brian-x1>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 02:34:06PM -0400, Brian Masney wrote:
> On Mon, Sep 11, 2023 at 12:43:59PM -0700, Nikunj Kela wrote:
> > +		func_id = readl((void __iomem *)(scmi_info->shmem) + size - 16);
> > +#ifdef CONFIG_ARM64
> > +		cap_id = readq((void __iomem *)(scmi_info->shmem) + size - 8);
> > +#else
> > +		/* capability-id is 32 bit wide on 32bit machines */
> > +		cap_id = readl((void __iomem *)(scmi_info->shmem) + size - 8);
> > +#endif
> 
> The 32 bit case is defined as a u64 in two places above.

Also should the 32 bit case be 'size - 4' instead of 'size - 8'? Sorry
I just noticed that as soon as I pressed send.

Brian

