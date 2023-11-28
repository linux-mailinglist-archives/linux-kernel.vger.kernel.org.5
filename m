Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61B57FC400
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376280AbjK1TH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjK1THz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:07:55 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF81BC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:08:01 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b83ed78a91so3645653b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701198480; x=1701803280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrWbrfWxo8czEMcF558cfFz5r4JKEFQ49qVLuRdA09E=;
        b=XaDpNOZ+dEXU0wJTEsiqDU8oXMZsFmzldO9a0wCMEFPkEk3qVU6Uf2JOPDU5thihup
         i4Lz+Rpbteb8gjYxoTBQCDQIqyTOd7ft00/gjo7ZW8eBjgKuKNK6WQOi7HR8uGo2b+hl
         WfYBKKPDiB8VE/+p4njSXkCFerZdmMGBOEmkSxypSM8sMFtBvwlJLX1n5FnOwxuIPS51
         09dNE9kMzp/H8AoEHR1AT75107SMSWqmux5UnqsRpQhKoFC8VJlES7WCXVvcoKcXgiOR
         AuZAunv2jGl0pnpeYmZqLWo3qQ/kgA3sHHw2xvD9oS0/XJrj0M06KBD/lSz+bOzM9d23
         8q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198480; x=1701803280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrWbrfWxo8czEMcF558cfFz5r4JKEFQ49qVLuRdA09E=;
        b=t2jUJA0i+HmtkbVpmb7eJv+ucGKSOkKNCx753V8772SR2gatVt/3a4FPtYyvzAJGzf
         dB0zz731CyWJz+fhLSBywzSc+hKGDJoe7oNv+7HiZcjh+WsAOc/UD/mYU2ClDp+5nGWX
         SJ8lwdQT3UzpVRno8NbT6hXKmwtBTfZ7Stwl4+s1tbCy3zumEJooCa0Tkzd8gkT7mIbX
         WjYneTzavkW28sefD29haGGCAZZJYOaiElUU08FZ+AQ5f+ssJCvTJtgIBXy/0dktLlkc
         E3wEzlck0v7R0ixAqDIo4fDTMiJhHloGCKGze7btqJdUXgmGeTLlba0p3tdFzgSzWppx
         +zsA==
X-Gm-Message-State: AOJu0YyZGJ7ZgfH2G8CtuoROfyS11cPa5g2+s4+yPjaLPMbNETVyMOuQ
        nnhHvmwkFicrvHv1Tv8dIgdDLQ==
X-Google-Smtp-Source: AGHT+IHjqKPazolKQbK6TD1pg0+2RORnbGfXybkQUivWQiPhb+ioQ69cBf5pklVEOcm6r+RvrEK1bg==
X-Received: by 2002:a05:6808:1483:b0:3a7:1e3e:7f97 with SMTP id e3-20020a056808148300b003a71e3e7f97mr20364822oiw.4.1701198480752;
        Tue, 28 Nov 2023 11:08:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id bx17-20020a0568081b1100b003ae165739bbsm1918437oib.7.2023.11.28.11.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:07:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r83R8-005YEm-VD;
        Tue, 28 Nov 2023 15:07:58 -0400
Date:   Tue, 28 Nov 2023 15:07:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommufd/selftest: Use a fwnode to distinguish devices
Message-ID: <20231128190758.GA1312390@ziepe.ca>
References: <cover.1701165201.git.robin.murphy@arm.com>
 <e365c08b21a8d0b60e6f5d1411be6701c1a06a53.1701165201.git.robin.murphy@arm.com>
 <20231128144331.GA1191405@ziepe.ca>
 <69db9205-cb9a-425a-a48e-6d68d1f900f1@arm.com>
 <20231128163342.GI432016@ziepe.ca>
 <a9674ad7-e773-495b-abc3-dae1f74a7694@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9674ad7-e773-495b-abc3-dae1f74a7694@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:36:33PM +0000, Robin Murphy wrote:

> You see this is exactly the kind of complexity I *don't* want, since the
> only thing it would foreseeably benefit is the one special case of the
> IOMMUFD selftest, which can far more trivially just adopt the other of the
> two "standard" usage models we have. I've been trying to get *away* from
> having to have boilerplate checks in all the drivers, and this would require
> bringing back a load of the ones I've just removed :(

I don't think we need to bring back the fwspec checks you removed, the
loop just needs to keep the NULL check:

 +	list_for_each_entry(iommu, &iommu_device_list, list) {
 +		if (iommu->ops != ops && !iommu->fwnode) {
 +			ops = iommu->ops;
 +			ret = iommu_init_device(pinf, iommu->ops);
 +			if (ret != -ENODEV)
 +				return ret;
 +		}
 +	}

Iterate over all the global driver ops only. Drivers with a fwnode
will never be called without a fwspec.

Also, does omap have problems now too? omap seems to set fwnode but
does some slightly different open coded non-fwspec parsing that worked
at bus time? Is it still OK? Does fwspec even find ops in omap's FW
description (ie it looks like it make iommu-cells optional or
something)?

> As I said before, I really want to avoid the perf_event_init model of
> calling round every driver saying "hey, do you want this?" since it's also
> error-prone if any of those drivers doesn't get the boilerplate exactly
> right and inadvertently fails to reject something it should have. 

The core missed an API that every driver needs: give me the struct
iommu_driver* the FW has referenced.

Instead every driver open codes something like
arm_smmu_get_by_fwnode(), or much worse.

If we force the drivers to say

 iommu_driver = iommu_fw_give_me_my_driver(dev, ops)

Then we automatically have a place to do all the rejection checks we
need, and driver's can't inadvertently skip this because they really
can't work without the iommu_driver at all.

Anyhow, I completed the series I talked about yesterday. It turned out
really nice I think, especially the driver facing API is much
cleaner. I'm just going through the last bits before I share it.

Jason
