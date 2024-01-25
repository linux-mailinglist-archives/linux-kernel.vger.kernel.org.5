Return-Path: <linux-kernel+bounces-38170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A68183BBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28A1B27D96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE8D18EB4;
	Thu, 25 Jan 2024 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbW8zQHE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3E18039
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171155; cv=none; b=J+PmdBhB0ZcacDTY1VU+ApXEN4bdtB8NNegQOcb8/vXk8bbmyzZeqpMm35/fZ/8m+xcKdQTS8/G39Vgs/alp60B/+oiRzUaiJl6ezGR7KiBIKcpC0iTkq6MLonhVCKcab4V3rKF5JgVr4TrrsYgQqD1rQZt3iEZY8PXDR6szhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171155; c=relaxed/simple;
	bh=9iZDsOrwFbNhFUiQrCQV8ZvnDuL4DsA+Z6fFe12B2C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gagbWikPmAK2WNFDmbK2iY9MFysuScM6kG+CDcEt4PYZHcozicbhO1cTuoAJjlmt2orQEbwdtnbOeYYgsiz0tmRbPdEAKUqwJVGxveFqp4kc4eUjehevqcIC0S1vwH2uAyTaIniqnt2JJ8Q2xDyms4bnl9H3FUwu8UtD1/wPO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbW8zQHE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706171152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7yorbOu4W949PDf1wJwUQ2ZcnYgGGHn5INiZOwEc64I=;
	b=dbW8zQHErd9/9ZvlSCyGS2exiivYTkOyocRemxnbXngrIO1dvEtX+PT+mtF0MoPwLYvZeJ
	KO6hRtdEhS0Qa+2iGYwhQvVMFl2GH+HelOeEwquP+iS/WCRKR/SxsqY6vwrRCEGqtdczaq
	tK03F97/YdiIhQ8dTX+tKEc74ycA7xo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-vQhf2d2uOdKmf-rS5-uYSQ-1; Thu, 25 Jan 2024 03:25:48 -0500
X-MC-Unique: vQhf2d2uOdKmf-rS5-uYSQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2c653c7b35so350777266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706171147; x=1706775947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yorbOu4W949PDf1wJwUQ2ZcnYgGGHn5INiZOwEc64I=;
        b=s7Dz87LsL9/rnqJyL5gYnyVEaBRGK924uBoUqkhVpam1Vi7o5+szKz6AGdxBp/Fqch
         wTUmR71U0X425SempQq+x5eSrxMz4cjMPE3kRmOzHIQPiXpLV0mEjkATff7ttjV0lj2m
         d7EJr4w6zumk5G2f5v9TxeVuj1tt6pTJeDI4/FafNvBVN3D8qYJSuS9hwHCfy7wQiWZH
         mieAO3RzpsdFeCTbmfEPgLB8KfxkDJ1QF3YW44yZmfA69losayQ+/aPPvO5RszZl54MG
         KeelLRY6OEu0aJchOYJwrTsLKk93wKTxpKrFFtWnAewPWd8fGCraqgEaDWtGTbHEj4mJ
         2iiw==
X-Gm-Message-State: AOJu0YzicRH/GIzSX5yKuitzKn72suGIH7tjNH4H/MbZPaJSrBsiEFx2
	3j1SW5GGbwnNz1HkxI0xxUfC76Ql0GMFSWZZe3pVW/neStqwX9fGw9UDw6WgE2NlI7VxkUegG5H
	8PsFfUujxEI9lCdNg8EQ+vrfvCGMSjVpU8b3qHNpsCX3L8/CFDUuLRY7OuI1qmw==
X-Received: by 2002:a17:906:194a:b0:a23:5672:735 with SMTP id b10-20020a170906194a00b00a2356720735mr200633eje.290.1706171147582;
        Thu, 25 Jan 2024 00:25:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtAmXQ4VLJ33gfVHQUvreFWKCVhdbCgy8sC+T+BXXLfj7avWyKayxGoOmLBlfAtzRcbKl+LA==
X-Received: by 2002:a17:906:194a:b0:a23:5672:735 with SMTP id b10-20020a170906194a00b00a2356720735mr200626eje.290.1706171147221;
        Thu, 25 Jan 2024 00:25:47 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-71.business.telecomitalia.it. [87.12.25.71])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a3177f658afsm411613ejc.206.2024.01.25.00.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:25:45 -0800 (PST)
Date: Thu, 25 Jan 2024 09:25:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v1] vsock/test: print type for SOCK_SEQPACKET
Message-ID: <nsnvxue53rbvtyxwcouebcev6uk7izz62htxyqrngpfvl26qs2@jubx6oacqcck>
References: <20240124193255.3417803-1-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240124193255.3417803-1-avkrasnov@salutedevices.com>

On Wed, Jan 24, 2024 at 10:32:55PM +0300, Arseniy Krasnov wrote:
>SOCK_SEQPACKET is supported for virtio transport, so do not interpret
>such type of socket as unknown.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> tools/testing/vsock/vsock_diag_test.c | 2 ++
> 1 file changed, 2 insertions(+)

Yeah, LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_diag_test.c b/tools/testing/vsock/vsock_diag_test.c
>index 5e6049226b77..17aeba7cbd14 100644
>--- a/tools/testing/vsock/vsock_diag_test.c
>+++ b/tools/testing/vsock/vsock_diag_test.c
>@@ -39,6 +39,8 @@ static const char *sock_type_str(int type)
> 		return "DGRAM";
> 	case SOCK_STREAM:
> 		return "STREAM";
>+	case SOCK_SEQPACKET:
>+		return "SEQPACKET";
> 	default:
> 		return "INVALID TYPE";
> 	}
>-- 
>2.25.1
>


