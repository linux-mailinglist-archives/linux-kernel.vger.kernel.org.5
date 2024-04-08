Return-Path: <linux-kernel+bounces-135995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE189CEB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191D9284104
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710B0376E4;
	Mon,  8 Apr 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUnF45v2"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B47A1A5A2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712617561; cv=none; b=bmTAEBXDTPRd56XLlMpxVyfWdfJwunARCoyZsU0s8S9WEtM3DJYQhiz7vxiSzPO8KxZbk3/BwzNQQ2sDK6059Qg+LKfaPfNEjeLEjL1XlEl12gOZncAqNOneGre3VUnNG1WbHpgsQM8iGnN7oe/a5ePOPcZGBfBL0yP2vHUT0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712617561; c=relaxed/simple;
	bh=hkntsIVLSnq06IArFYIAWTKVMmKAQGAtz41uG4WUf3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOOlAB5VeOU3pb2R0t0o0edDpjkQjOec6Uy00J1vd656FkmqzcE3w9Grw10WGU8mRkrfRbuL1OJLo6PSg8xcUkQh7ruk5JI3D1NM1IbxpCN8MUzB/PchTW1T+p169jzGVe/TeYaDMziMF/RnTNYTlPZu94hssL2GNad469+lWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUnF45v2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343e096965bso2544652f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 16:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712617558; x=1713222358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hkntsIVLSnq06IArFYIAWTKVMmKAQGAtz41uG4WUf3A=;
        b=JUnF45v2DkOpd0Zewe5UJbAiVgLyZ9S8BSlQGYf+k0Mn0CChVh/aZGtx7lBhxEmoiy
         TldnE5AehQmZE97l8zeQdo8FlIPLbCQFySSvAxRSoyib3bJclRw+/nGaB409T1JTvfRK
         kTcQRUujWnFZ5/XptODp/4lV8mYNO48P3MlqW9FlcDjkcdHrO5qDyD6hsvgtjS9fgUQy
         IXVoggprnGyG7AekCCRNdxM6GT3qk+CFyj0zIbpDrNFYLbeE1EI/c5ve56H7+zKIZNj3
         6wUNYwSwzfVXaAvaITcwVCwhfdgccn1LNrBDETLiiFk73qbjPCJ3nT4yGVz0FQ6jhXvp
         VOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712617558; x=1713222358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkntsIVLSnq06IArFYIAWTKVMmKAQGAtz41uG4WUf3A=;
        b=XFkwftFPMMwK9UT0I4rcDkqeIYoKtaSQemd5Y34pGEHnAbA1orp4QfJ1yxSup6wJrK
         4ifT4JXq2WxQm0L0Ue+OIXKJjF60B8BAaa1Hp+l3sqThBSU9S0+kaHso7FHmT50a8vqA
         R3q2HDsHJNsYJHLnyPlVtcw1q/TaDbWzwfp/8kUO/JyZYd3Z9Zw/wlCJKpgAg8IAMM95
         aD7wNLKmfU3JEAuw/U+unwxc/l2gRcT5uYiF/bHm3xCp4bdA3xY6v4UqqEY562HK97xn
         E7GstlvR56wlP3NQfXiz5oTL/obhf+E/sU/pWL55F3onBeG/BdDsj1GUTopH1dfvrY6x
         XO7w==
X-Forwarded-Encrypted: i=1; AJvYcCUwh9rPEepNbRc9r0BvB7qF5HpPX/lUxh7o422lwhUXQSZNNUtT5zuHeKufJcLQLMzVogaAUS6t8BKiHyyJCGRS6ORmlxXF4xT99ikp
X-Gm-Message-State: AOJu0YzomPL2hMpZdwGj3mUi1GLn/fPb3ZMgr4UuEjtaf5QPSvAs5VSV
	JfbfqCKaTaqKGAXnNJjfrd2b+pdt4oeWPravygaQq91mn3llgwRLfkvCxgzBPKebhacsPLcHj2g
	VqaSvXBjLvkfIFzup8jd30XSOLl3FzkB3TWXh
X-Google-Smtp-Source: AGHT+IEUa8WcVHFto1R3l6anB/80nRTHBZTKX/MejwEbvI4B4B3HOMp8ZJ48Wg2Y4tNHtAUpBatHBaueD4tqBsUNTrQ=
X-Received: by 2002:a5d:4e88:0:b0:343:ae03:2a02 with SMTP id
 e8-20020a5d4e88000000b00343ae032a02mr7047507wru.40.1712617558251; Mon, 08 Apr
 2024 16:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408215231.3376659-1-dhavale@google.com> <3b3d0b99-f7b5-4dcc-a631-1018f4025acf@linux.alibaba.com>
In-Reply-To: <3b3d0b99-f7b5-4dcc-a631-1018f4025acf@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Mon, 8 Apr 2024 16:05:46 -0700
Message-ID: <CAB=BE-Rk_Rxd6aNP99m=tSMt4-tNH4xKru8f1QeOF5fzd8-Mtg@mail.gmail.com>
Subject: Re: [PATCH v1] erofs: use raw_smp_processor_id() to get buffer from
 global buffer pool
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Chunhai Guo <guochunhai@vivo.com>, 
	linux-erofs@lists.ozlabs.org, 
	syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Thanks for catching this, since the original patch is
> for next upstream cycle, may I fold this fix in the
> original patch?
>
Hi Gao,
Sounds good. As the fix is simple, it makes sense to fold it into the
original one.

Thanks,
Sandeep.

