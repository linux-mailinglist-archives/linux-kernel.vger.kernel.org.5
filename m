Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1C777E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbjHJQgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjHJQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:36:39 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D4E0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:36:38 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-56530cfee38so759623a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691685398; x=1692290198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAmLYynJNs/JRcQ7yD4Mxp1X2smKrNsOj/BixVS0HCg=;
        b=EwzA123zqRuBCUp3mBzJZO/MCbDuhKtsKqOmqiiUSIPF7GW4sIzA1kmam5Sv9EbhcS
         sujDPRcIz2RJpmGrkkH41TanVkT4nF3kNCZC5LEj7uB+aqXFFzMX3lS3dXxmR5NtirD5
         i7/iErfrBWWOuvMuPIvvjBEe6UsaQgkB483TPaJBcCWdehU6xkcI96tyODjzX2kZHt3Y
         RBgqE4idU6N1zrS1q/QCqELnR4jSLrrUCXBsPiixpRfgS7zDR7LGo1bKpnfUN/pwS8ve
         XFHtPPLxsjGxol0TuAREGFDa2+V5moEylhvLtnBs055TnHHCED8pKxZBwg3NOw4sqYzb
         Q9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685398; x=1692290198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAmLYynJNs/JRcQ7yD4Mxp1X2smKrNsOj/BixVS0HCg=;
        b=APpoRf2iqlha8ij0TMTFeFns6QkH05PjiAAXIv9BnMEd+NPXqrt38IxJmtBIVY1bL+
         ezXyduDRPisxi+UNfYKuN4ASy+ttBgxmoRpsRoABTaSw3RzycuDLEzcy4ncTMcnTJ2dI
         GXtin1yv15ygYJXYpiRH8HRMTpszGCM2fHuTbaq10sCEbmYdeqKy1pKjxO+7KjEBkkGe
         EKW6GTkm+mlkIgkRRe5mTXzQXs+e3BIcIIoT4eOrXZ7PuTj9qPTkOd7BurTP0ousRj/D
         i8EcPiv4R63js88gnPcV1js0M6AgKLMJcOzsy6DzBRhdB5T6y4/z9Qk5L7KLY5bY+PBu
         zExA==
X-Gm-Message-State: AOJu0YxOtqBlW7G5Il1uwMNNm8gRsNUi4Ace71x68cWS1BdDH1CDuliO
        /AJvBLgkGbrR0akvaEp2Z9w2ouXDejfbaFR5s1w=
X-Google-Smtp-Source: AGHT+IFqbDsbenFQiKdalqSq7WrY8AerqUj0j1LAUzLPJBk15OoizZx4GyWgXgpjeCFbG5P0N/3hNg==
X-Received: by 2002:a17:90a:a50a:b0:268:5fd8:d8ff with SMTP id a10-20020a17090aa50a00b002685fd8d8ffmr2324584pjq.0.1691685398017;
        Thu, 10 Aug 2023 09:36:38 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a190900b00268032f6a64sm3828826pjg.25.2023.08.10.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:36:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qU8eI-005H23-NJ;
        Thu, 10 Aug 2023 13:36:34 -0300
Date:   Thu, 10 Aug 2023 13:36:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Zhang, Tina" <tina.zhang@intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Message-ID: <ZNUSEiXTYbV7ML6x@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZNOH9lPdTnltb9JZ@ziepe.ca>
 <BN9PR11MB5276A5E619DF6638677DFFA58C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A5E619DF6638677DFFA58C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 07:52:52AM +0000, Tian, Kevin wrote:

> > The driver should rely on there being exactly one iommu_domain for SVA
> > per mm so it can hang the mm_notifier off the iommu_domain
> 
> I'm confused. Isn't this series trying to allow multiple domains per mm?

It is doing both.

The main objective is to allow de-duplicating the SVA domains in the
core code. The driver should be able to assume one SVA domain per
instance, or even one SVA domain per compatible instance. The driver
should not do any de-duplication.

But we can't just store a single iommu_domain in the mm_struct - we
have the same problem as iommufd and we need to create more domains if
the domains we already have are incompatible with the device.

Arguably this should not happen, and in any sane configuration we
should have only 1 type of IOMMU driver that needs only 1 SVA domain.

But right now things like SMMUv3 have problems crossing domains across
instances, so we could have one SVA domain per IOMMU instance until
that is fixed.

Jason
