Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC67FC148
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346278AbjK1O4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346591AbjK1O4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:56:15 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3C11FCC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:56:10 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1fa37df6da8so1471492fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701183369; x=1701788169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8g+e5uKh1QlVf3RdM68AyRGdG7AIgZT4PZpe3XzaAo=;
        b=PgynI+16rG6d3zJSCFSUg786J3y1o57sR/obMX4kufudsZXyDlRILgAWN27Thoi9sH
         5o+xNxHPho8eqlIk/EiizMVHVXee+h09gsATF7cX9XVGhfbxYFS1BNYfUe5RnvORkind
         tDDRc3auaZjv0FBXReRn4JJl6IU5MuMOjWgSTcn1ZlLx7JkMpc4fDnRCDc963h4RoMn0
         gEMavwMcq5IBc8sstUd/O7ynf9ASbiZ1yxv+R8DXL1anY5t8p7pnkPgiBC/UGJ3PEZa+
         RFk1x1EWd1AzZj44xMokT0DFz6EygbOKdkKOVrBYicVYlr2TQ7Jza+InFeQJNR9QOYY5
         9Qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183369; x=1701788169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8g+e5uKh1QlVf3RdM68AyRGdG7AIgZT4PZpe3XzaAo=;
        b=aUSX6bRE6d4ze7AiBYRb1tfTCm3QHSuRWNYlyxnRSZ3caBY5x5nSXXcpmZXOfL7NIq
         Am7BwzMAnPnXghr3RqA+yGEMCMQ4n/amYq4Qd7iTkInGv4wdV1piiOzeGZMnFanBmHjt
         BSH071bsrkAXqbmofe4ethpWYlVdXlVtyd00xZgdQI+9mXQc1+7UJZ29H9P4gSVRFxaH
         skIr+CTp7fhQ50wFCUNAK+rvedp+kvAqHRsCeJQI2O1uNZ3leXxpwRcf3+klUu7hDAFu
         P3B4avIMOkz3c/fVAFjZJoxhK5j08KJQUAjWactpOrCwTackEKpB7knwtomZpsw+Zh5z
         l20w==
X-Gm-Message-State: AOJu0YzYp2i/0VhaM1tDqFAz+p607DgXz+m3zwmTbFSsScMXfl9JztWd
        BPaIKRql4PjzK83UxDBXBAtJx8cWSzJJ1s48S6A=
X-Google-Smtp-Source: AGHT+IFw0ivBF8qAq++MP+hGfozxXMvilmwyBK70bhJoAMuG4+AHbtB5wUTCGVpIEXUm2qt59N+Zqg==
X-Received: by 2002:a05:6870:f626:b0:1f5:cd12:260f with SMTP id ek38-20020a056870f62600b001f5cd12260fmr18094295oab.26.1701183369637;
        Tue, 28 Nov 2023 06:56:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id so7-20020a056871818700b001fa8b2d3212sm175886oab.1.2023.11.28.06.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:56:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r7zVQ-0050HI-C9;
        Tue, 28 Nov 2023 10:56:08 -0400
Date:   Tue, 28 Nov 2023 10:56:08 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
Message-ID: <20231128145608.GH432016@ziepe.ca>
References: <cover.1701165201.git.robin.murphy@arm.com>
 <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
 <20231128143508.GG432016@ziepe.ca>
 <3a8d7ea4-c5f9-421e-84fa-2e4934cd6c92@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8d7ea4-c5f9-421e-84fa-2e4934cd6c92@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 02:53:03PM +0000, Robin Murphy wrote:

> Dynamic bus registration in general would be a neat thing to explore at some
> point, since the static iommu_buses array isn't my most favourite part of
> the whole business, but I guess we leave this as-is for now.

I have an idea for that :) For later!

Jason
