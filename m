Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0777FC29D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345855AbjK1On1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345831AbjK1On0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:43:26 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53CAA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:43:33 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1fa1c3755afso1503850fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701182613; x=1701787413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r02Q3LT4ApLAWvQfkMOWe99neSPOd4I55ym4hWDwTwM=;
        b=eeptNz/yqLlmZinSJD88UN8c3j8nHbrVLFOletvoc16m7J6YDnY5MeKGXAxA9k+nsV
         CemGXhRcaFXrjkh6DAqVphA3BUrdrR+pqAkKa8ReEXUGM7K8r2oYrcThekW1/FfDGLt6
         6BsKzxKy5RsMctKU66n57Mpy90Rx5XksIwXxjYJkWtZKQFOKZ0Pui9EwrAED3qM4zAI6
         +AYIKFJlmk9QfurLVvQsn6zEa2fFp7MvBOzqkrfTOzJRUn2rtg0efjswQwlewQ49jKoq
         gsRD7/dGsL2A5arkaPyEhdwjYWZ6m8zaAFJc8cIjn6WgfPsPYlzakP1CjlneNn2FK7+R
         mKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182613; x=1701787413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r02Q3LT4ApLAWvQfkMOWe99neSPOd4I55ym4hWDwTwM=;
        b=S5xRmpnlzmw4rL2R2mJCOVYqDNd48W4qfG1q+HhTqfcSpI+MZFTTDt6ym79BnVQTyd
         1ngcCqvAZn9Omi2dTAB2k4M/XkMSzfNMe2CVwZfaiqe4DZUjIFuuObqk+W4DtHvxqhcs
         Vbn7WJVYak8rQ5rW8yUG0L0NH2kicfAi+YrDW4gvj3lfjJTp+pdS9E27nbutucw1kval
         6789FHcu6Ovn+wF65eSSJcgGMANbEzJTlUWVoy8/qgVqf12qDF3j4Ie92/PwkNOzyNgl
         YgDpG2KkOU2Df+6C+x5OFoww/lhC8hYiO4TE81Pr0HRKUw+llghguNbD1lvvTS2i/myK
         nCDQ==
X-Gm-Message-State: AOJu0YxXLVf6hwuvBlMIcgpehc+NIxzDF3LWrlEwnRZpesdPLRzJIgyU
        IwiP+cgkVFvQ60m/PmqKhJIa8A==
X-Google-Smtp-Source: AGHT+IHnS66hwzm6D5SdY1R1ksKrFCGar0o/ls3QzwYp8zGmlj8+lnENkfGjgSJcZzjB2dlgKhp5AA==
X-Received: by 2002:a05:6870:f111:b0:1fa:3d07:89ea with SMTP id k17-20020a056870f11100b001fa3d0789eamr3764684oac.22.1701182612829;
        Tue, 28 Nov 2023 06:43:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id mp24-20020a056871329800b001f9f60859e5sm2339636oac.44.2023.11.28.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:43:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r7zJD-0050Au-DQ;
        Tue, 28 Nov 2023 10:43:31 -0400
Date:   Tue, 28 Nov 2023 10:43:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommufd/selftest: Use a fwnode to distinguish devices
Message-ID: <20231128144331.GA1191405@ziepe.ca>
References: <cover.1701165201.git.robin.murphy@arm.com>
 <e365c08b21a8d0b60e6f5d1411be6701c1a06a53.1701165201.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e365c08b21a8d0b60e6f5d1411be6701c1a06a53.1701165201.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:42:11AM +0000, Robin Murphy wrote:
> With bus ops gone, the trick of registering against a specific bus no
> longer really works, and we start getting given devices from other buses
> to probe,

Make sense

> which leads to spurious groups for devices with no IOMMU on
> arm64, 

I'm not sure I'm fully understanding what this means?

I guess that the mock driver is matching random things once it starts
being called all the time because this is missing:

 static struct iommu_device *mock_probe_device(struct device *dev)
 {
+       if (dev->bus != &iommufd_mock_bus_type)
+               return -ENODEV;
        return &mock_iommu_device;
 }

Is that sufficient to solve the problem?

> but may inadvertently steal devices from the real IOMMU on Intel,
> AMD or S390. 

AMD/Intel/S390 drivers already reject bus's they don't understand.

Intel's device_to_iommu() will fail because
for_each_active_dev_scope() will never match the mock device.

amd fails because check_device() -> get_device_sbdf_id() fails due to
no PCI and not get_acpihid_device_id().

s390 fails because !dev_is_pci(dev).

The fwspec drivers should all fail if they don't have a fwspec, and
they shouldn't for mock bus devices since it doesn't implement
dma_configure.

Jason
