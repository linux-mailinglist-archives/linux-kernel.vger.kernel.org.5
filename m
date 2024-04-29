Return-Path: <linux-kernel+bounces-163140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC3D8B6646
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B785B28378B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3698B194C72;
	Mon, 29 Apr 2024 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2OKjF/k"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B21119069C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433581; cv=none; b=fb3lMVxdTiponjU72jd3omlZUKITnpcgtDwuFRsT+Q2jfhX+nv88nRJwWPPac1lGfPNETX6NB2sFA2e7rNTPAiDILjIa2u3WypJhMS8GMScp7P/cPdAB07qecTy5nyP7SmmykHgGnlw2/suRYSh1sFuc0VHlgJzip4l2gRUZIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433581; c=relaxed/simple;
	bh=zgWwUXellYIj9YhPO7Iqbe7nRkqE92aVuNbUIopfYFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mcu82HqQS0CN0Yb8O5v51jGdjPL+pR1G7py8Rbcu29oiRAzWhZbOhj6uJAQ9KQQLlMRuFSgk6gg4JmBDTj2BtCBX8sUUU+6Z7j8IwpEhRoEsQridHR3aqL9zTVtkP1bSS4ofH7FFBfLYkfykSdabfJokSUt48Bq96GNILqPI9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F2OKjF/k; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41bff91ecdcso14955e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714433578; x=1715038378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S5NKNY0bx9Ur/hRqy93rqf5RS3xWUQOEaoj5G3gGftM=;
        b=F2OKjF/kqa4NaNZufLijiNf8wNfnA+iMt9U+keI5umdc+jGiqiaQ7YgsPvtOqLlBQJ
         Ju0BhmJUuy7vhV73QjMOizWolSiyNx2Kp2JAxy83rDbr84mL8FQGwpdnq/2eMvUKDAxz
         WMyhjrCeyd6dEwL9UjdkKwsi6PuPVsdL9mBu5ifymnQn0gvxc8inwImb/ozR04XaVO2H
         ds9sH6L67R+BEBiLCF7UwJX3b46RpGzfvnqWKiBiOn7S8q+/mzgKvGwaozKfTMefRG+6
         l+yinY+8XjeaT2V8bAeteBofqQ5xEi4DfoQAT45FJTUmIm31RqNmVrsV0LIfl1Cssy4b
         PUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714433578; x=1715038378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5NKNY0bx9Ur/hRqy93rqf5RS3xWUQOEaoj5G3gGftM=;
        b=ofDsbjpVnkK72BOweWqWaaxsm0yTloMK2iQgwWp3A94KHN0eEyZCSehl2/jzcqsULG
         4U/q7Idm3ty6RLUrlMPeuEjOuxcx0gfUJek85IXGoBvck/NVKcGR5ocxxRBw9582IufU
         4NB0RG5wKyqn5qajgFNjmo1b6YIsAmOGhfQBdDQbiAWtBwqFmt0t12/W0RX7gTCsfXbH
         ZfvxeDx6eRaEJLGQazW8eDg9PbjwK6Z43c1U6rTKX+oUxzf2Dw5kaI5qKYYw3urU1VbX
         HD0T7+g3dL7CpfqkAD90dVKAaHLJnF0LiH8m696TmiPA/fmUT//dz6zhKkEWJKtmUZ+Z
         Zlaw==
X-Forwarded-Encrypted: i=1; AJvYcCV4nbCKUVRYxJwY7tmh3uXTusr7CR95Vat75xG3328Zhwni3Ks+TUFLCSlTxRtxdyK8rpfmwxfSlJF+pc+zW6ZhVlofa749jwVYzM5L
X-Gm-Message-State: AOJu0Yxm/28Didi6uDgqBGLfzxte5zWhpRHmtIs29DtLAse8K95jC5p8
	kzDY5UvGX3OYUStriHSHn14pNv8OdN97oTBY5VpD3XBs6zLS3u05QO+Zk+rMyg==
X-Google-Smtp-Source: AGHT+IG1ojaDpWkVD6qowUoKBfHhKjeM2eEMttnF1neGykqH4cg0qTfcxwAA0H46ZLPVzQdhTYK9hA==
X-Received: by 2002:a05:600c:3b95:b0:41b:e416:1073 with SMTP id n21-20020a05600c3b9500b0041be4161073mr96434wms.0.1714433577460;
        Mon, 29 Apr 2024 16:32:57 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c0a4900b0041b43d2d745sm18237233wmq.7.2024.04.29.16.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 16:32:56 -0700 (PDT)
Date: Mon, 29 Apr 2024 23:32:53 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	kernel-team@android.com
Subject: Re: [PATCH] PCI/MSI: Fix UAF in msi_capability_init
Message-ID: <ZjAuJV87RjOu7gSy@google.com>
References: <20240429034112.140594-1-smostafa@google.com>
 <87zftbswwo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zftbswwo.ffs@tglx>

Hi Thomas,

On Mon, Apr 29, 2024 at 11:04:39PM +0200, Thomas Gleixner wrote:
> On Mon, Apr 29 2024 at 03:41, Mostafa Saleh wrote:
> >  err:
> > -	pci_msi_unmask(entry, msi_multi_mask(entry));
> > +	/* Re-read the descriptor as it might have been freed */
> > +	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
> > +	if (entry)
> > +		pci_msi_unmask(entry, msi_multi_mask(entry));
> 
> What unmasks the entry in the NULL case?

Apparently nothing, I missed that. (PCI isn’t really my area, I
prefer dealing with non standardised platform devices :))

> 
> The mask has to be undone. So you need something like the uncompiled
> below.
> 
> Thanks,
> 
>         tglx
> ---
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -349,7 +349,7 @@ static int msi_capability_init(struct pc
>  			       struct irq_affinity *affd)
>  {
>  	struct irq_affinity_desc *masks = NULL;
> -	struct msi_desc *entry;
> +	struct msi_desc *entry, desc;
>  	int ret;
>  
>  	/* Reject multi-MSI early on irq domain enabled architectures */
> @@ -374,6 +374,12 @@ static int msi_capability_init(struct pc
>  	/* All MSIs are unmasked by default; mask them all */
>  	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
>  	pci_msi_mask(entry, msi_multi_mask(entry));
> +	/*
> +	 * Copy the MSI descriptor for the error path because
> +	 * pci_msi_setup_msi_irqs() will free it for the hierarchical
> +	 * interrupt domain case.
> +	 */
> +	memcpy(&desc, entry, sizeof(desc));
>  
>  	/* Configure MSI capability structure */
>  	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
> @@ -393,7 +399,7 @@ static int msi_capability_init(struct pc
>  	goto unlock;
>  
>  err:
> -	pci_msi_unmask(entry, msi_multi_mask(entry));
> +	pci_msi_unmask(&desc, msi_multi_mask(&desc));
>  	pci_free_msi_irqs(dev);
>  fail:
>  	dev->msi_enabled = 0;

I tested it with my stub, but since I didn't write the code, here
is my tag, let me know if you want me to respin.

Tested-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa


