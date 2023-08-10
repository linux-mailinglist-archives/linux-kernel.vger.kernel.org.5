Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FCF777E40
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbjHJQ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbjHJQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:27:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297E32136
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:27:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26b0b92e190so560884a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691684870; x=1692289670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAgbHdZulKU3K7f/EuuxZjoKn0orosVfhysoCXSx/kw=;
        b=VETPhGi5BV7BlEyy7+mq0clcaexkXyPfE/T7R9lKifXJANcQ8YQR+OwtYkB78MSCGY
         riYUOfDwL8P9pxAiAH1UDDXvpEpOjzhNdz7p0NssnLsgElUGHw89TJTKs1z/eL/ajwNb
         YKxZIoSeRaZ51OK6CXDHb37hFZI0h5I5U097EhQ3U9lwOKPzDbMst5jYMrEt8GsELr8E
         1dT4gCGqJJRM7wA4X0KNfgsmUwmY5XK0Bf4TNwtnAN9Y5sL7R2XbmMRHTt/VLYqeHD+T
         NLZiLV1kWkL9jsdAzi+220bYNPJQQFhNwDzHwGeKmx3K4e6ZZdr0kMr7O3G/SaPAnSpc
         evyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684870; x=1692289670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAgbHdZulKU3K7f/EuuxZjoKn0orosVfhysoCXSx/kw=;
        b=SdKPa1jOgGxBsTyvFkKK6B/OpRfugAD1lWBhIVnDrRQo4+eleMEXtAufmOFIFobMYl
         5UkZipgy9TL/7NLn/D4zeo5QTNioSe3fV4k5YmjOecrOSqd5G/4mTW5F6EO9M6xyz9Tb
         Yd8Fc8DETqI0cTcvyt9R7ITOnJQg+0NnAQMMOp8b1YQHurDmvEGMopp3fvYmHfromzpf
         68XUBjZINDpkfo0PAD5peAOr8coFeDLEL+lOkDAL+NjB0zlZlzP8bryPsnPxreLM1moR
         apdBzIAojvzpE7D6IP/zTJob36OOWw8opDAdljYFs5Vn+t2hvUdoEBy1EIl90BjrvORU
         85Wg==
X-Gm-Message-State: AOJu0YwzKn8HdF3E5F1eUL+1eb6QyTR4csWIBvJ/sg+ohWUyS5kd6IpI
        UoLy0PI/BBxjwULP2s9MphY78w==
X-Google-Smtp-Source: AGHT+IFEs/RbOmudBLNlZwwMnUwrAZ6P4wUhRR5aS/6xOIECTRYvRvsH3viY7uFMHdO8sahwKzr5jA==
X-Received: by 2002:a17:90b:1010:b0:268:f8c8:bd5c with SMTP id gm16-20020a17090b101000b00268f8c8bd5cmr3496252pjb.17.1691684870420;
        Thu, 10 Aug 2023 09:27:50 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c4-20020a17090ab28400b00256a4d59bfasm3535713pjr.23.2023.08.10.09.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:27:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qU8Vn-005Gwz-QD;
        Thu, 10 Aug 2023 13:27:47 -0300
Date:   Thu, 10 Aug 2023 13:27:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Zhang, Tina" <tina.zhang@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] Share sva domains with all devices bound to a mm
Message-ID: <ZNUQA01c8zIvHBQn@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <BN9PR11MB527638E7361714F8AA5FD4448C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bfc2eb22-54af-dab8-72e3-a142470590c3@intel.com>
 <BN9PR11MB52760CE856F69A3FFD7EE2C88C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760CE856F69A3FFD7EE2C88C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 07:49:11AM +0000, Tian, Kevin wrote:
> > From: Zhang, Tina <tina.zhang@intel.com>
> > Sent: Thursday, August 10, 2023 9:32 AM
> > 
> > Hi,
> > 
> > On 8/9/23 17:41, Tian, Kevin wrote:
> > >> From: Zhang, Tina <tina.zhang@intel.com>
> > >> Sent: Tuesday, August 8, 2023 3:50 PM
> > >>
> > >> A sva domain's lifetime begins with binding a device to a mm and ends
> > >> by releasing all the bound devices from that sva domain. Technically,
> > >> there could be more than one sva domain identified by the mm PASID for
> > >> the use of bound devices issuing DMA transactions.
> > >
> > > Could you elaborate it with some concrete examples which motivate
> > > this change?
> > The motivation is to remove the superfluous IOTLB invalidation in
> > current VT-d driver.
> > 
> > Currently, in VT-d driver, due to lacking shared sva domain info, in
> > intel_flush_svm_range(), both iotlb and dev-tlb invalidation operations
> > are performed per-device. However, difference devices could be behind
> > one IOMMU (e.g., four devices are behind one IOMMU) and invoking iotlb
> > per-device gives us more iotlb invalidation than necessary (4 iotlb
> > invalidation instead of 1). This issue may give more performance impact
> > when in a virtual machine guest, as currently we have one virtual VT-d
> > for in front of those virtual devices.
> > 
> > 
> > This patch fixes this issue by attaching shared sva domain information
> > to mm, so that it can be utilized in the mm_notifier_ops callbacks.
> > 
> 
> that is one of the motivations. e.g. another one as Jason suggested
> is to cleanup to decouple the common sva logic from enqcmd. Both
> should be mentioned in next version cover letter.

I also want to purge all the de-duplication and refcounting code
around mm's and sva_binds from the drivers. Eg see the mess this makes
of SMMUv3.

Core code provides a single iommu_domain per-mm for SVA. Driver can
rely on this optimization and does not need to de-duplicate.

Single domain tracks all attachments. Driver can optimize using that
information by de-duplicating (eg ASID invalidation vs ATC
invalidation)

After this we need to fix the domain allocation op to add a
'alloc_domain_sva(dev, mm_struct)' op so that the drivers can setup
their SVA domains fully in a nice lock-safe environment.

Jason
