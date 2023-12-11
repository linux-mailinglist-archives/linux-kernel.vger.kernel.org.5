Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4988480D41D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbjLKRiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344762AbjLKRiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:38:22 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60A8C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:38:28 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77f3183f012so264503085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702316308; x=1702921108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx0kCWw6AOe/lnc+LPzU2mQddJvJBaAwvlRTrYIYzPQ=;
        b=pQdXciewmsgtALyJk0HPSa2sulwZcqaIVAMWqCWVNEoUnUiBhzdA7+QbQSxj7kCoKX
         T3vsa9O7n6fLGIQGAYazqwXtHt+UU+1zhzcWahozx3PzheIITZAroHgHsFLVKc8KYtvG
         HwojHl5R0Sg/6FYXY5nEXf17FwNsnVhR8OVlmKAEJdPnuJil938PxpIwR4vRzZgTMhHX
         1uOIhBmqfgNcgU8djBfpWFQkSkVCf3x7UHtqiDhESx4/xfa/b0ZRT7lr9b7eNyRZ+Q1D
         nK+liXd/nMFqn+AHaE/zqHpp8yobOx6wJdNi3hlI4jVWspRczzSIitQ8ydwdmBBRCUuj
         1s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316308; x=1702921108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx0kCWw6AOe/lnc+LPzU2mQddJvJBaAwvlRTrYIYzPQ=;
        b=T/L9bMZx2VQhKPUNu5PBuCvTlk1plHHl0gzHB/+0poWs6vShLLA60ylH8Bu8frL7qL
         uO34DrfGQs7BU15jD1YHXyonj3lOdNTlThPhLpj/2oeYyETxDQxph9EzThIMZa2/PADa
         KoiqxuI8O33hGkERIG4AfmHRspDtWqVFsf2/9TwnYDVqt8OKRGBawvxOdJ6ycC95dUE3
         odX00OVX5Gfj3zGr28UG9T3gmqOGVYkbwvKiRvKakzdzZRJyaR1eRiaR5DOH1yuf02r+
         nUC4dEyNSDrQH8/zWk8jeOOSAlFqMtWh08PNjdPozimdcMggYPnOtSNEbNOG9HlwqySS
         dfsg==
X-Gm-Message-State: AOJu0YxngFUpRBpb9zjINC7tI1rWG4Liyu5KwFCvGdOQg4BAGnLYmJxl
        hpzQR4/4+WeoHvDcAhgNhhY1Dg==
X-Google-Smtp-Source: AGHT+IFfc5Hv1E6FHOf1r8yAaQaGx0V3DuKRi/AlGBDjSOBNiyD2/IhGz/2tIGlgla1T0f8Y1D++jA==
X-Received: by 2002:a05:620a:95b:b0:77f:37b2:21e4 with SMTP id w27-20020a05620a095b00b0077f37b221e4mr5503877qkw.38.1702316308081;
        Mon, 11 Dec 2023 09:38:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a04cb00b0077f529e7d23sm1624685qks.29.2023.12.11.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:38:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rCkEc-00CdZD-R2;
        Mon, 11 Dec 2023 13:38:26 -0400
Date:   Mon, 11 Dec 2023 13:38:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iommu/vt-d: Setup scalable mode context entry in
 probe path
Message-ID: <20231211173826.GE1489931@ziepe.ca>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205012203.244584-2-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:21:58AM +0800, Lu Baolu wrote:
> +/*
> + * Get the PASID directory size for scalable mode context entry.
> + * Value of X in the PDTS field of a scalable mode context entry
> + * indicates PASID directory with 2^(X + 7) entries.
> + */
> +static unsigned long context_get_sm_pds(struct pasid_table *table)
> +{
> +	unsigned long pds, max_pde;
> +
> +	max_pde = table->max_pasid >> PASID_PDE_SHIFT;
> +	pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
> +	if (pds < 7)
> +		return 0;
> +
> +	return pds - 7;

This seems like a convoluted way to write 
  max(ilog2(table-max_pasid) - 7,0)

?

Jason
