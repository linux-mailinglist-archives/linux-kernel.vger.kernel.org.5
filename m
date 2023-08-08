Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F24773C39
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHHQC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjHHQAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:00:51 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30F46591
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:44:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-585ff234cd1so62808717b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691509481; x=1692114281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gL2omywPOVNbKUeglpeFfHMIDiTEoGuel7UocewbmbM=;
        b=Y5pGSIX8l61nN2OL7dTwr28SKWMTzn7RyyuQyDiha4JhzeBLT9iJp+zsYvddYop045
         YeOfNbwyDDgXHUCzH5VpxI7FbszD6n2av6Uuy4FaIF2xqFVysw/j/ARMlrtHGCLLAyk7
         LyP8v7Xg+x9bpMbF2IdkOBswjKf2n1LsBRKclZiOjjrsB5E4ZM1KbVAaWYHDw/f0yLeN
         rRmXaz+8T/dHwIkLdb1HK6XjLgFQBNC/MRtxLa0pXnhj7Ev5DjRAA4WFgP077drZoLnU
         ewleoiSxw7g3KroLrlfX6tyo4Hb3W0bqw/m6gpbdArFh8lblji2yhPx6y+4HAyHHcKH9
         +GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509481; x=1692114281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL2omywPOVNbKUeglpeFfHMIDiTEoGuel7UocewbmbM=;
        b=fCy2iVJr36u55hLB2oNVkaboLvCmsi7Kr2AgWskNtocv/frm6sOJMehOI+/+ev4sD5
         RfoymiBRNLAPfCxUaf9rbRQ8hKn0YDVjt/3elOGsBbxAQNZ0GEcD8p4Akfmx2nHw6KeW
         pBL1p3bmG6OOVOGY3Fbg7u1VvfwvDi64q2mmpVwr+Kmzm+maK3gXISmGnNGmlMnVzpOz
         vmVnwIwCivVTG9W4TDzfc0h9PtrVxd7jILS9ZWbFxiIxnK5kJ9GAUyLgZ0ps3j4P1US4
         TbmkJL4Oena+WNrHuiRg/Mhh0Tvc/XO8jInthCxJfwGldMr5Xhudlzb9KWPD74nLx07O
         bOcw==
X-Gm-Message-State: AOJu0YxTVYFVjhbJn/880LpnZ6kfbxe2LA5gel5oRU6NJgADwcy0/uSh
        VnXwetmKRV2Mj/v9vWVhEDXWRf5x41kxVsqrfcg=
X-Google-Smtp-Source: AGHT+IHgfILa7agMZ6r8NdDf08gKAYAowHDrZpHWJkfH8WLRw020X3h5zqhAKbPn1XmQpt9bdUdJBA==
X-Received: by 2002:a0c:a9ca:0:b0:62f:f2f0:2af3 with SMTP id c10-20020a0ca9ca000000b0062ff2f02af3mr10760271qvb.41.1691507955581;
        Tue, 08 Aug 2023 08:19:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a13e300b007659935ce64sm3349304qkl.71.2023.08.08.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:19:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qTOUM-004d8H-L0;
        Tue, 08 Aug 2023 12:19:14 -0300
Date:   Tue, 8 Aug 2023 12:19:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <ZNJc8r1eeQZ8GqxY@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-5-tina.zhang@intel.com>
 <ZNJbaiTDG+YTgpDP@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNJbaiTDG+YTgpDP@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 12:12:42PM -0300, Jason Gunthorpe wrote:

> Lets please rework this function into two parts
> 
> The first should be 'iommu_sva_alloc_domain()'
> 
> It should do the list searching and user management. The usual
> 'iommu_domain_free()' should be modified to clean it up.
 
I suppose we can't quite do this fully since the domain allocation
needs to use set_dev_pasid to detect compatability :( This is a
similar problem we had with iommufd too.

Still, the 'alloc and set_dev_pasid' should be in one function and it
should be undone with iommu_detach_device_pasid() and
iommu_domain_free().

The helper bind/unbind functions should wrapper that sequence.

Jason
