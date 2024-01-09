Return-Path: <linux-kernel+bounces-20324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39518827D58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA7EB221DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7976FA9;
	Tue,  9 Jan 2024 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GXR7boh0"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B884612E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28be52a85b9so1559110a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 19:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704770869; x=1705375669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXL4Ps3qf8k5Z/Ui1IqX2W2Ns+rNuQpEvgdkOPDwzLU=;
        b=GXR7boh0iZBGxwgnd//NnkSNimTCzv2aMx9n3eRuvMufloVy6ayrFXua80W2rRuhd7
         0c279U17OBlpz8UONaVojKk+kL+WaJlkJSTuwlGrQ+7vWn6oh5TMUKJlAkKJlD4QoALv
         TFTMPAc5Tjdu6STHNKnnO9VLrnCGtGZqpNkkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704770869; x=1705375669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXL4Ps3qf8k5Z/Ui1IqX2W2Ns+rNuQpEvgdkOPDwzLU=;
        b=JJ0mjvKbGa4HYA3pqGyrde0cHy4BcYcQ8yrmChVMupx0SqUFFE0EXjlouSW53jCRXa
         +5sLcFTZDij/7zNiR/DD3Mm/ZBvbAffOhmwDvinvIi10ySnBqglq6qu7SQgi+oNX+NHZ
         1DHgSOm0r7r0C9CmW0jkseLdWrfMSpt+opPjyjdG83v3nS6yCTf2BZU7IpkISCNy8IA8
         Klcqk7N/JudZg0mqU22o6244mSeXytFT4nm9UzGILtEJjONvZqMa/KMvgc5HW9fTtVxc
         jWPiQibKdVBNjlKgmfmv/xmLKPVCNPwp9Jg2mDDRQqUy5wWMjux5nWfMKtmzAquUqyuK
         4noQ==
X-Gm-Message-State: AOJu0YzTtV/nvyGPXhLlqPMWSsB8ZLmMmiJtFKst4yhd4cfsK2TkEHlm
	CaTEEFePeWXM48v2o4+dpDQP6YJSmB6r4Q2/7H/OHS3jww==
X-Google-Smtp-Source: AGHT+IGq0vxegoITtf8sqwZEvUiMPQ2IoL2L4oArtuldYRvg12mALaxEVlIjwvqFKKtDMEPLanKrjQ==
X-Received: by 2002:a17:90a:b38c:b0:28c:f509:ed14 with SMTP id e12-20020a17090ab38c00b0028cf509ed14mr1813274pjr.15.1704770869495;
        Mon, 08 Jan 2024 19:27:49 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:7b29:709a:867f:fec5])
        by smtp.gmail.com with ESMTPSA id nd12-20020a17090b4ccc00b0028ce9c709e4sm7238276pjb.26.2024.01.08.19.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 19:27:49 -0800 (PST)
Date: Tue, 9 Jan 2024 12:27:47 +0900
From: Hidenori Kobayashi <hidenorik@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: ipu3-imgu: Set fields before
 media_entity_pads_init()
Message-ID: <20240109032747.64nnee5qo5qyuply@google.com>
References: <20231228093926.748001-1-hidenorik@chromium.org>
 <27f1c487-78cc-4e56-ba79-1434aba131fd@moroto.mountain>
 <20240105021856.wpzmwtyzxzqfznrp@google.com>
 <a6f9ff72-421a-42c6-b24a-3dbf5a55e631@moroto.mountain>
 <ZZu5ech4h2SSyZ1D@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZu5ech4h2SSyZ1D@kekkonen.localdomain>

Hi Dan, Sakari,

On Mon, Jan 08, 2024 at 08:59:37AM +0000, Sakari Ailus wrote:
> Hi Dan, Hidenori,
> 
> On Fri, Jan 05, 2024 at 10:34:20AM +0300, Dan Carpenter wrote:
> > Hm...  I don't know either.  Wait for a day and see if anyone else has
> > an opinion then listen to your gut and resend with whatever your gut
> > says?
> 
> The suggested commit message seems good to me, the Fixes: line is
> important. Thanks for digging this up! The patch should go to v6.7, too, so
> please add Cc: stable (for v6.7).

Thanks for the comments! I'll send v2 with the revised commit message,
with Cc: stable.

Hidenori

