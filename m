Return-Path: <linux-kernel+bounces-110028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B734C88590E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4E11C218CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33877604E;
	Thu, 21 Mar 2024 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJNkMPoy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637E57603F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023976; cv=none; b=q9vDt/P8VeVYcywhTUwGduEOSqZ0EbLJ5DO2nNiT1jOw2qLVihXDiSSyqN4zmA2jcqAn0pBJ9IWrWyeQ6894n8xbvNBtzCP3e3ebZd2Qaf8wK1XL/FAjGTMcmmCjGHEKgMmgaYh3GYIqgByiUDx0eoxOBkuncrqIq5ywk0pcXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023976; c=relaxed/simple;
	bh=asNxUABtcbFsSQGHR2XvI5++jNl/Wy6Tq921v8Lu2V4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=paxonIZuA9iPQez7Ms7JV1f4wmq0c0pH+b3qqdPf9Dh2QW+zDg/AXuNN12WVyrrFThgDX6KB8XByOmRqYJx6r65xNzE8x43BvbtpT0StMDBobqvH3gEJxELmFJcsC+Y4VZZuRdSXkd5dHZ/CIS9bIIuktZJ0BAHphv5Bq4tqphQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJNkMPoy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711023974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=asNxUABtcbFsSQGHR2XvI5++jNl/Wy6Tq921v8Lu2V4=;
	b=dJNkMPoy2wq7DqQnbUHLKl+vbeE2SbKedGBw7kkVoalyxwTx4w6pQFO5TjkYyoXAj1Y6g/
	wMZm1xM7yc0AMaDHxoF8Vhvni1/dJlV4zZqDgoQH6GQ3HL2aQtYYrRJqc7RajkYi0rwvsQ
	YjShggqgFhn5P/OmTbw94IrnjHgJyvU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-tGLL4fJ5PXipi1VitwFcUQ-1; Thu, 21 Mar 2024 08:26:12 -0400
X-MC-Unique: tGLL4fJ5PXipi1VitwFcUQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41472b798a2so1809585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711023971; x=1711628771;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asNxUABtcbFsSQGHR2XvI5++jNl/Wy6Tq921v8Lu2V4=;
        b=YX2xDjXa63MCGECvbjW8o8NQkdHaftEnbC3M1qy5vxD6BimIXy3d8M4M9q4KkuT5D2
         cfzrfvzqFX87FtIkhXp+x/cPlCTZP6vbLZf0v7qC4HOFGXs4ESemkA44Sfos686zJufI
         9pCnUu3NbPzhoWo12WcXIedemdYoNlzp3qdO62BNWTeZwHX3PYZCTVw7uz6OzS9Nolnb
         vrxJAOARH0bDqNtjKMwmXrzOay5T8aBv0ADyMY7pzkIad+IDglzWQZdpXb9Y+vhxAiDJ
         j3mBNn7SP+vH8LwAF3K7NY1rZ+GkjK8QeyDubFbnRKa55SYrdNYiRji82PlkObIubzf7
         I1Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUfA3Ydpz81EF1XUsq6LOnRxDU6keQGSLLJGe8cJ4qlLHw5n6F20x/Xty/4vxV5icIHMGy33ZlB2dRkyEPb8c7SWV7IRjGaf9wFAKbN
X-Gm-Message-State: AOJu0YxumxaNXS1qK/qE9BctDcAAV5TXq1ZNZHj4rQaL46j9vGu004j1
	Y+v3qCDCY7VkIT9j2Y/uR1CQ0H+g5xw/+nRVrNoVOplQ/hwS5jFqBWWQh+oAQDp7JE6nMm4zvmq
	NzbwclLnRt6pcJP/8C2Hh+6HSQTh4Tt8JsJpR60xtLTR0Rd3QPW15sWs5yEwNsw==
X-Received: by 2002:a05:600c:1c9b:b0:414:2894:d446 with SMTP id k27-20020a05600c1c9b00b004142894d446mr7311192wms.4.1711023971578;
        Thu, 21 Mar 2024 05:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhW9N0wGR4j4LK7zUT4IVCd+OqZVL12rVrnpPybi9dFVPkppnj+DbNdmr3/iz5olOs5kyeyQ==
X-Received: by 2002:a05:600c:1c9b:b0:414:2894:d446 with SMTP id k27-20020a05600c1c9b00b004142894d446mr7311170wms.4.1711023971209;
        Thu, 21 Mar 2024 05:26:11 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-130.dyn.eolo.it. [146.241.249.130])
        by smtp.gmail.com with ESMTPSA id fs7-20020a05600c3f8700b00414038162e1sm5334655wmb.23.2024.03.21.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 05:26:10 -0700 (PDT)
Message-ID: <8edda7aa8ff27cee1b3fa60421734e508d319481.camel@redhat.com>
Subject: Re: [PATCH net v3] dpaa_eth: fix XDP queue index
From: Paolo Abeni <pabeni@redhat.com>
To: David Gouarin <dgouarin@gmail.com>
Cc: david.gouarin@thalesgroup.com, Madalin Bucur <madalin.bucur@nxp.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Camelia Groza <camelia.groza@nxp.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Thu, 21 Mar 2024 13:26:09 +0100
In-Reply-To: <20240320112519.5311-1-dgouarin@gmail.com>
References: <ZenidKFF/gQefijz@boxer>
	 <20240320112519.5311-1-dgouarin@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-20 at 12:25 +0100, David Gouarin wrote:
> Make it possible to bind a XDP socket to a queue id.
> The DPAA FQ Id was passed to the XDP program in the
> xdp_rxq_info->queue_index instead of the Ethernet device queue number,
> which made it unusable with bpf_map_redirect.
> Instead of the DPAA FQ Id, initialise the XDP rx queue with the queue num=
ber.
>=20
> Fixes: d57e57d0cd04 ("dpaa_eth: add XDP_TX support")
>=20
> Signed-off-by: David Gouarin <dgouarin@gmail.com>

The patch LGTM, but you must avoid empty lines in after the 'Fixes'
tag.

Please have an accurate reading of the process documentation.

Thanks,

Paolo


