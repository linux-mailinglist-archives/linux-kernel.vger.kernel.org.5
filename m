Return-Path: <linux-kernel+bounces-27631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E3182F352
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D51C1C23775
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75301CD10;
	Tue, 16 Jan 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LONa54tU"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C181CD04
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426860; cv=none; b=cBiddDdTnVNxfqchfKx4pEBYRDVirJz4gk+sScdd2t2/fZvbfxBQiTyF72WMz4lleJQ73QJ7XVyueidDPL2R7xexh4Unkcgci4hGVBByVHWaHGQmfKGStz0NkXcmKfNIp/4hjnfcWDDNPybzogg6cuPe7r+2T+GrSioXZ8z+7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426860; c=relaxed/simple;
	bh=XvvcYoCr4zpjWC2RHZe0h/ouCH5Zo/Y79WhWx6k5mnY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PWGpBbDgqYFO/S5wUuzJGimfmPGBpgB+iXYrL7tUhhD44wY62NS0mnuCxf/e4DWbXXPPrPx5wXMZR3RgYqzN8r/zGXlzLPDrSFOLYeGLyzupMDj56OhpSPowMn7ojvigGTOMQvkChlq86vmiXcYn2jg1c+75EFSIIPytIS07X00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LONa54tU; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6daf9d5f111so8168660b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705426858; x=1706031658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOlwdSwaFY4qZZ/MF2sX5IosH4JrIbBPd9daBrZxqLw=;
        b=LONa54tU+UohsI6nM3JZsf8nCtb/DhRm80it7rHbZFtXiO3PbDAz3MQeM6HDW8ewiI
         5wl9NEQtEUKvYemIXcLmZVtI8hAJcoVEfmcxoTp/tz0HilNPY2GNcYfEo1HZy2sC+r0K
         /nMLNdjoqmM/sW7GkHhUzdqZv5ZyYvpQi/8s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705426858; x=1706031658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOlwdSwaFY4qZZ/MF2sX5IosH4JrIbBPd9daBrZxqLw=;
        b=dZpHhbLYb6d8dILjknRljOAIdf8f9dH25/J81uYiWKiIe4dyUH4v3OJ7I7ysjhkbJ0
         uwjaGtt+4JubNYqeKvKX3GFOcPk/q8WO6XyhfY319mTHjOpIzqf9SIzXrA8CmocMDU43
         lDGUkn1wVKHDJWHKhSk4kuYMdjEXSG2mDm6nHLrVjvurxNsxUutwRB7c9Ram8bi5nBjr
         O87gr6yDjM4ShFmoKsogqCLDfgWy95vFIlJSTVWmtBcLHfpevoC8Fk1658q7Zid3Z4pP
         sRiHDQyKDijUy07S/g2SrSyOSE2L62fQJjYHA4wS01qHzuo9FQuWuAJn6moi8nxRgu0p
         ZvQQ==
X-Gm-Message-State: AOJu0YwzTFHrmDa/K8S7okLWlzZ55hrNwCDsUWRN2lM35n0v0ItvrNxA
	VxK1WhajLJvzXiR1bOdRebIo+Ocpc49l
X-Google-Smtp-Source: AGHT+IGSq12YfeBII3I7eyQkB4trJr8EZhJyUqknHpzHjJNorjltxMMcubYS6hhtjlOeab7iuZAREg==
X-Received: by 2002:a05:6a00:4604:b0:6db:7038:fc0f with SMTP id ko4-20020a056a00460400b006db7038fc0fmr7290950pfb.63.1705426858263;
        Tue, 16 Jan 2024 09:40:58 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:88f1:3bea:43ea:b8b8])
        by smtp.gmail.com with UTF8SMTPSA id x16-20020a056a000bd000b006d9b2694b0csm9640397pfu.200.2024.01.16.09.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 09:40:57 -0800 (PST)
Date: Tue, 16 Jan 2024 09:40:55 -0800
From: Brian Norris <briannorris@chromium.org>
To: kernel test robot <lkp@intel.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] firmware: google: cbmem: Add to module device table
Message-ID: <Zaa_pwuPOMCQV4GD@google.com>
References: <20240111151226.842603-4-nfraprado@collabora.com>
 <202401151013.Xioj5wZo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401151013.Xioj5wZo-lkp@intel.com>

Hi Nicolas,

On Mon, Jan 15, 2024 at 10:53:48AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
> >> drivers/firmware/google/cbmem.c:118:40: warning: unused variable 'cbmem_ids' [-Wunused-const-variable]
>      118 | static const struct coreboot_device_id cbmem_ids[] = {
>          |                                        ^~~~~~~~~
>    1 warning generated.
> 
> 
> vim +/cbmem_ids +118 drivers/firmware/google/cbmem.c
> 
>    117	
>  > 118	static const struct coreboot_device_id cbmem_ids[] = {
>    119		{ .tag = LB_TAG_CBMEM_ENTRY },
>    120		{ /* sentinel */ }
>    121	};
>    122	MODULE_DEVICE_TABLE(coreboot, cbmem_ids);
>    123	

I was wondering why we have a seemingly unique "unused variable" failure
mode in comparison to other similarly-structured device/bus drivers, and
I realized that's because we're not relying on the same structure for
both MODULE_DEVICE_TABLE (struct coreboot_device_id) and for the driver
definition (struct coreboot_driver -> 'u32 tag'). Thus, this structure
is only used for #define MODULE builds, and otherwise not used.

Rather than wrapping these definitions in "#ifdef MODULE", perhaps we
can settle on a single field, and replace `struct coreboot_driver::tag`
with an instance of `struct coreboot_device_id`? That would normally be
a breaking change that would require changing all drivers at the same
time as the bus (or else some kind of intermediate transition state),
but considering there are only 4 driver implementations and they all
live under the same maintainer tree, that seems like it should still be
OK (IMO).

If it makes the series more readable/incremental, perhaps the switchover
can be the last patch in the series, and there can remain some
duplication (and potential -Wunused-const-variable issues) for the
middle of the series.

Brian

