Return-Path: <linux-kernel+bounces-82107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809F0867F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15DD1C21860
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623112E1F3;
	Mon, 26 Feb 2024 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQt090mt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648612DDAB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970058; cv=none; b=jcLJCltNmO2ETdBz9IikD52tWVwK6UPIR1ycCUxxWn6MPRiEYxd67Kw8ZoeECXV5LD3IpqH+yhi+GXtAWR/Bqomg2nnk00dm/vHhtavZlUiawg517KymKK40T0O1SGYYBLIc8a6ukz/d/BsYdd4tYV+oRVkK3w5HWyceBA5Bqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970058; c=relaxed/simple;
	bh=nCBprRl7elMDgsu3Q+VfUSyqkYGuj7H5ht+7Gk7lqw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf6JYOzhWl31bUT+EgflOzZl81WaNJMm7SBbZ/4Q1MH9kHhIshJGnRciMBFERbF+wCKd/L45mHatnH2cyo+6tFFGPEKZ/u2HkSZZD/+3rgk3cR9rAaOKAhFQZfPc2a/dpt3vZLomCrhV7URFJdO9OX8kvJsQyyonW0IwgZBMeN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qQt090mt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc929e5d99so2575ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708970056; x=1709574856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsVc7UlGcxsksaiQoEbRw4jQmn28hv1EysTPYoFH4v0=;
        b=qQt090mthgDxxIg7cca73kASeyRqpKdPYVQHaSPC9ZwzTR7xsPnXbaZXqiBh8cHJNR
         dNym9qdAt0EKdEVOb6otlicinuqr2meOdof1Zzs7Mr4O7CPqR82GNNq7fnn1zDsz/oTc
         13f31pcOO7ldbtkoS/8K1CN4WWCJCHisWFmOL5pKqdrvN1KfAPchWPD9VRJvHOqY948d
         HoAiVQx4XLvYvQjnckHY2pHA68lDigbPzsI+bHwY/7gPcBZIvd2xt0YDmKn70bSF3lCr
         VKQ9MxmvQdULWBR4QtKaBJd54OabHf360d2Uo2cpwjWlkCLTs/8eWuhpRYVzXY+/xXdy
         tAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708970056; x=1709574856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsVc7UlGcxsksaiQoEbRw4jQmn28hv1EysTPYoFH4v0=;
        b=WqOVOHZ38Zn9R50Vk+0IFgjdI/T9PJhcw5d8hdFHONQ18jqyRL1eZGT9TvkKhSP8wD
         QFsO3OZCfAKPRa1Dvg1lOxQeNiC5Pkavngaz2SWZ7r2hBpl3xFuylGdeHZxrsxQiLa48
         oNJzvORqtIp9yKuI+otjMBuYoiLrHHBjjz23K+8LWKpNAuVsFMMisgqXmvwXsr2qh6sF
         TvMMiHj1DoNUZ7qxjEi7/AjYfdwM2io4RrNFX+Wc38U7XvPvSvAeN+Pi5eS8MSrg0JWI
         tH3wN0Rb8or46NFS7mhDBTWOtiGmr35m3t6ZSfPy1jvoFPDKIbcgCKM1H04r9h3e4P3Y
         HCpg==
X-Gm-Message-State: AOJu0YwXYp8bjeNHwZTyo1Ui0u0Fc/23XA5Qr4CclyFjn8R5XkLcqoG2
	4LNVTYEAWuLHg3AFLS6bpNT9hCubDAwbMz1BLxlBp0b16QRVEi1Nvh19vspo+g==
X-Google-Smtp-Source: AGHT+IEKS+AHrTe6LkZiDSjgsfP6iF+EINahMbkhYCIk/j6xzJ+g+VP+sDOgg3c5X7EajAMHMBrYYA==
X-Received: by 2002:a17:902:788a:b0:1db:4f08:4b10 with SMTP id q10-20020a170902788a00b001db4f084b10mr418657pll.21.1708970055598;
        Mon, 26 Feb 2024 09:54:15 -0800 (PST)
Received: from google.com (96.41.145.34.bc.googleusercontent.com. [34.145.41.96])
        by smtp.gmail.com with ESMTPSA id a25-20020a62e219000000b006e48e0499dfsm4312212pfi.39.2024.02.26.09.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:54:14 -0800 (PST)
Date: Mon, 26 Feb 2024 09:54:11 -0800
From: William McVicker <willmcvicker@google.com>
To: "Duffin, Cooper" <cooper.duffin@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	Ajay Agarwal <ajayagarwal@google.com>
Subject: Re: Kernal patch Add support for 64-bit MSI target address
Message-ID: <ZdzQQyAZtaxlr6sS@google.com>
References: <SN7PR11MB8281C67DF5E5B9EE8A1B9FFBF3572@SN7PR11MB8281.namprd11.prod.outlook.com>
 <SN7PR11MB82814D44B70D213918566050F35A2@SN7PR11MB8281.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR11MB82814D44B70D213918566050F35A2@SN7PR11MB8281.namprd11.prod.outlook.com>

On 02/26/2024, Duffin, Cooper wrote:
> Hello,
> 
> I was looking at [v5,2/2] PCI: dwc: Add support for 64-bit MSI target address - Patchwork (ozlabs.org)<https://patchwork.ozlabs.org/project/linux-pci/patch/20220825185026.3816331-3-willmcvicker@google.com/> and I was curious if there was a plan to have it merged with the main Linux kernel branch? It seems like it would be a great addition.
> 
> Regards,
> 
> -Cooper Duffin

Hi,

This patch has gone through a number of revisions in the past few weeks. You
can find the latest revision here:

  https://lore.kernel.org/all/20240221153840.1789979-1-ajayagarwal@google.com/

Based on the reviews it seems like it will get picked up, but I'm not sure if
it will make it into v6.9 though.

Regards,
Will

