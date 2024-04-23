Return-Path: <linux-kernel+bounces-155108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F08AE55A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05121F22157
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9980613CF9A;
	Tue, 23 Apr 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="J6wdU5rW"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C11292EC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873181; cv=none; b=QWf+xCiXBwbn2vaRk2bpBTHPxFo4yIyyIlBFUEo0DrayijYm57FxDd7xTVbr1JtpXQ/O29d4KpBWY+dz+WJrUgYEGz1DG0bgFvSXtZrBJNjjo1ko2ay0KjEQQ8dLYYYbAab7xnTUd1GZWlfCVRwNzNNoO309KBl2tQaz9R7DBnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873181; c=relaxed/simple;
	bh=zYeAlMW1SsjV5lzQvuhmib9w9fZnmxBE5X2T4UP4XKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QACXpgW8VS85F5D4bTtqNnF5B+h6xobiabYD46gvEsOcoCw8MCn+UJgwbQofkTJSkv5uMlVRE7iB0/9eC1i6fFh2TWz/zg5qeoAQIwVeHytwqeEVNM3L1mr7nYtQxhTLO8mNEItuRuhXsWTBJ70cf6Ni4jF0NUctap7OKPhtJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=J6wdU5rW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34b3374ae22so1753014f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713873177; x=1714477977; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zYeAlMW1SsjV5lzQvuhmib9w9fZnmxBE5X2T4UP4XKM=;
        b=J6wdU5rWu1sYt7DIjHtoJzMw4dG3bEXwc/OYsQtCrZCkQOxlFhW5UeIELWi/Y3dBzf
         DdXDvgYEQYIj/WgVVgx8zvrf0lpFhG9r1TAGLPaKzjEh/vE7PE79rXWIItWDszAnZc6p
         +eT7/Z9vZr8BCXkQLev5eHdJuKp9ZoIO/EcWaSui7tzF520jZiNXcUaWdP0O0RxiD0oA
         fobYl9b7URaCeoKUBkD9nRXBDI30AYMRvA3eSSqa3ffDaI4M2qahv3pltC8SGdpfAaRE
         XnHzV/iEwQIsRSooB0NIAS0eyrRl4f8El1LJM/lfOPtIeoeABZ6gaWqcl4doIKVW6DRa
         TGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713873177; x=1714477977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYeAlMW1SsjV5lzQvuhmib9w9fZnmxBE5X2T4UP4XKM=;
        b=bwps+WirZ8iHhsDTSVWdOyMa3GcbIuWHb4BjvNQ7hHYX02OQoTxcgQVdXzH+R3MDeu
         MvIhqLajNymSWkxlojlVzaEupKtPSstB8/2sLFg1q1i8G9SIJtVPFr8UDq12h0v/LhC3
         tzfcS9JIrcXd4U8m6wof5D7s70rVaxUaz9qFzHK+cJTNThC7A9UqXlu843tql0F6RODg
         qo/EtQKvjAXkApF9xS2aogkijtNtu2BE2jP5Gq9EeiUvkb7bEG2tizHA0nP2ojT+6LFU
         YaPkGIVpC6XPA2P9atqVIHunFFd5t6qHOwXKfutxwUWA9vRatDqzR8+MeeT6C0SeKIW4
         fJjA==
X-Forwarded-Encrypted: i=1; AJvYcCUmulTnQ4iacCK9omOQoP29elsCmoPblvCTf7HNP/U/8afTgVikLos4CaYUyYH9BWaJDVw2eu/nQbbzxsdaiyjaGVWxc8fCsHuBwuy2
X-Gm-Message-State: AOJu0Yy1BJ3GCDPqYEU/bjvfVfORh1Xng+aBJersk7HeCGY2nHgEeIXm
	ftG0uDTB4owQb06inuyYTy6L6fnPxz5e2enAAV4w1Eos0Fovu0K787iRB6kBQ8U=
X-Google-Smtp-Source: AGHT+IGYdlOXhKrV4Xx20GD8wz7O0dwwwQ+1vqgQ4tP2PJTOPwBLbBIdUDSR3guwA85weBtiPCyLSw==
X-Received: by 2002:a05:6000:905:b0:33e:c528:c900 with SMTP id cw5-20020a056000090500b0033ec528c900mr9913946wrb.55.1713873177417;
        Tue, 23 Apr 2024 04:52:57 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id q4-20020adffec4000000b00347f6b5bb6dsm14382274wrs.30.2024.04.23.04.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:52:56 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:52:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH net-next] net: hns3: flower: validate control flags
Message-ID: <ZiehF8MaL7XYLk2X@nanopsycho>
References: <20240422152717.175659-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422152717.175659-1-ast@fiberby.net>

Mon, Apr 22, 2024 at 05:27:16PM CEST, ast@fiberby.net wrote:
>This driver currently doesn't support any control flags.
>
>Use flow_rule_has_control_flags() to check for control flags,
>such as can be set through `tc flower ... ip_flags frag`.
>
>In case any control flags are masked, flow_rule_has_control_flags()
>sets a NL extended error message, and we return -EOPNOTSUPP.
>
>Also propagate extack to hclge_get_cls_key_ip(), and convert it to
>return error code.
>
>Only compile-tested.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

