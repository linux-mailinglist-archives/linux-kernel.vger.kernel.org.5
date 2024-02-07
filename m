Return-Path: <linux-kernel+bounces-55882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C757E84C2F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676801F2673A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A882FC1E;
	Wed,  7 Feb 2024 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gpeDrLhq"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6EDF9F2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275694; cv=none; b=r9PqBuP07QrfCeYXgSoOlX++u4/RfVrKM2ITVJrxDVBn9G5+FWTaCvqzjRGSmXUnIBGNJrV4V9+FWghVjotKomLaFjVWexiwvase6+paFn9Pto9XMGJaXp7UAn3CloR0wFiOlz/zIoAYjsqXWCs5kWsHVg4UyEkpPX/n5oCu9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275694; c=relaxed/simple;
	bh=TNdvgeLeflGi/I4XYKAieH8rjpy0iNQkOipKMisBkwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yuj7anHVxLPoI1G1rV4Vod6F4pPSihBbcpg4aejd5m7yG9+jLRBAbUbLw+z/wdw9Djl+/HHfr9KWwJBBmpfBQC4knf3RmWbULf9/tvIiqk9ksjcC+Clp80UAgn5aptUQ0ONRK7KgGcsHpuazuMkFFBBfLaCvwr1Uv1roEvSP/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gpeDrLhq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e0354c32c7so106552b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 19:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707275692; x=1707880492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXlY8itXiY71bjg2IGEZWuUS1L2HmO/8NcT4bL9IvGc=;
        b=gpeDrLhqAzX/BPRpohzi2DGDjz1hebHi9QyDPBRdQNbsRNso+LT6cCuPLCrFuNSU+M
         6mvKcS/0IZ7MYoCE34prr3JqIp6lCirFHTTnRG3wqUK0ucnOe006luPhSVhWAL/OkvSn
         hXwqrHQ1iCXw0pLbwuhHEbUX459w+ihhoPFzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707275692; x=1707880492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXlY8itXiY71bjg2IGEZWuUS1L2HmO/8NcT4bL9IvGc=;
        b=tONpT+Hu6Qa7wzQxMU6wevLIvIKsMBgQ0Lco/cd+11dV3aFvN1M1PLaehhvGQppD5W
         62PBTo2hbxBQOvKaxVW1izMjaYmjbi/tPpi2qE9R16hu/8skg3gKNFax7zfdThsnWjh3
         yDzzedQf5dY8/91paJgv3yPDnHbFlEFDxnWgWhhhqlmJvrADrXf43EiS2Z+G64lTBptc
         R6qGsW7vs0E2nT8Hi8aHk9epdcnP3K0E7Bje6jak2FIyxV1oKwGChsEG4nvfI1wSJ04H
         sET31cajv8eRMCmuTmn39Unk+pwWndGv96fhTLncckhtWvJra/dl7t61ZY3h/8dXzT2t
         Pd5w==
X-Forwarded-Encrypted: i=1; AJvYcCXb52YCrRMkvsUniNKS/ySc3u0XPD9XHSpYO390IoIkPbpA2cxB6xuRqlNB0C7kgNMjQdg87uFKQ6S3UyUhFYSTwJk7dWvQox5MCI7P
X-Gm-Message-State: AOJu0YzG0H2dCFZiXLgPwMrfhtAn0jhWOF0VYXiiptQ6iRMGGw5Ueb+C
	h8mcLTZDig4zPDE//4aKigZN4d+wosy0NTBMZ3khympD+OtX98uvaVuH5OXkYQ==
X-Google-Smtp-Source: AGHT+IGV6Nhu1c2V13akH0R7AmLI2tOeWocIMW81OdpsGCeLVVDjI6iXwkifvegLg6xpk+N219Wlug==
X-Received: by 2002:a17:902:d2c9:b0:1d9:9e4f:c0b3 with SMTP id n9-20020a170902d2c900b001d99e4fc0b3mr4407743plc.64.1707275692087;
        Tue, 06 Feb 2024 19:14:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFQTK5oaG3eNcTaR5w4XWmFOMi6YH+R5KnKfMCZdwCbcNfYpaoGMkXhw4ABBcFVjgPSpnsd8ftTu6K2z2O1lVYymEQ9EDCx35csivh0gj3IqLhaTYlckpPxutryy1KSb/363LDWEvql6gvQSKY8Q+zgc1KlJxPTwmsw/bhb5D3juBePVPQHy7k/6/RRnyoWTaG3LC0l/RFFzrrN8iwWNYHz1lxntIhH8NCSdLm0noSVNn4x1aGoXnS4Le11dfDC3x5Lk9Dlhs7d8VP2JoyZBoFUycrxh6RJYzZsQ==
Received: from google.com ([2401:fa00:8f:203:679b:7168:b5c0:a415])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170903430400b001d8fe6cd0f0sm269716plb.150.2024.02.06.19.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 19:14:51 -0800 (PST)
Date: Wed, 7 Feb 2024 12:14:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>, Barry Song <21cnbao@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v2] zram: easy the allocation of zcomp_strm's buffers
 through vmalloc
Message-ID: <20240207031447.GA489524@google.com>
References: <20240206202511.4799-1-21cnbao@gmail.com>
 <20240207014442.GI69174@google.com>
 <41226c84-e780-4408-b7d2-bd105f4834f5@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41226c84-e780-4408-b7d2-bd105f4834f5@kernel.dk>

On (24/02/06 19:40), Jens Axboe wrote:
> On 2/6/24 6:44 PM, Sergey Senozhatsky wrote:
> > On (24/02/07 09:25), Barry Song wrote:
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> Firstly, there is no need to keep zcomp_strm's buffers contiguous
> >> physically.
> >>
> >> Secondly, The recent mTHP project has provided the possibility to
> >> swapout and swapin large folios. Compressing/decompressing large
> >> blocks can hugely decrease CPU consumption and improve compression
> >> ratio. This requires us to make zRAM support the compression and
> >> decompression for large objects.
> >> With the support of large objects in zRAM of our out-of-tree code,
> >> we have observed many allocation failures during CPU hotplug as
> >> large objects need larger buffers. So this change is also more
> >> future-proof once we begin to bring up multiple sizes in zRAM.
> >>
> >> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > 
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > 
> > Note:
> > Taking it in NOT because of the out-of-tree code (we don't really
> > do that), but because this is executed from CPU offline/online
> > paths, which can happen on devices with fragmented memory (a valid
> > concern IMHO).
> > 
> > Minchan, if you have any objections, please chime in.
> 
> Not Minchan, but I do have an issue with the title of the commit, it
> doesn't make any sense. Can the maintainer please re-write that to be
> something that is appropriate and actually describes what the patch
> does?

Thanks Jens. I fully agree, I requested a better commit message in
v1 feedback, we probably still can improve on this.


Something like this?

---

zram: do not allocate physically contiguous strm buffers

Currently zram allocates 2 physically contigous pages per-CPU's
compression stream (we may have up to 3 streams per-CPU). Since
those buffers are per-CPU we allocate them from CPU hotplug path,
which may have higher risks of failed allocations on devices with
fragmented memory.

Switch to virtually contiguos allocations - crypto comp does not
seem impose requirements on compression working buffers to be
physically contiguous.

