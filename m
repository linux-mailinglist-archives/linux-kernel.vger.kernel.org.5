Return-Path: <linux-kernel+bounces-66992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF94C85648C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A623728D33A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF22130AFC;
	Thu, 15 Feb 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYD+Vn6f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB8130AEF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004164; cv=none; b=JpKk+AsLHQ/7BJU81LUM75kI1Y4vrtJhmIv+bbjQNQ6/aYeckK/ZV8iulSZabPMo43pTOdcok/iX5XoSd2Yjrc5Wp2X3/Hy9YB4S/5ztiklN2TtXRMNqENdRG3eiKPhMK7TxrPlhGzF8vGvFIBW2J6cZQy4Le2O6WUEq3daOIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004164; c=relaxed/simple;
	bh=a3l5AVYV4A2H6bqECMhlO1rAdI3K3fXbopdYny86144=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+fDkS7Q3JuSUNDjM+gHV+LCwO7m1acesbVAkhJQa5R9G6Uw1hzZk8hlz4x5iw2XiggKeJn3PFrgzvBfKtwPUF2W8d/ZpZs24AenSvHwA8BUexFrltMHogn47qjNk+o2U74izrhWtTT6XJwYxxfxHFnZ9ZqEZ9ApveWF5w+UNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYD+Vn6f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708004161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kPHa3eTqzxC/WkYdFvOjdhOTmbvuGHmnFpgQxouq2s=;
	b=EYD+Vn6fKmGaBad2Oy+m3MfWo6mttguurFgHf2ZJWzXKrVRCbruXPonS/+Hy+zrHMbMIWd
	UmvHq3rdtKa7BC7P1cR6SsUZkI9MrV94sHctzJvqNvGLqgFr4k+huKgorxzxk4StOMqjbC
	gnYIGep1XD0vYB+nNql+e9lWnP+pGok=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-bh5COv3zOlW8kZkFBjR_xQ-1; Thu, 15 Feb 2024 08:36:00 -0500
X-MC-Unique: bh5COv3zOlW8kZkFBjR_xQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68f00966e27so7107026d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708004160; x=1708608960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kPHa3eTqzxC/WkYdFvOjdhOTmbvuGHmnFpgQxouq2s=;
        b=fdLRbY9Z04qoTeYhkKt5k/aBH7edwf2Q1dZs/A4699yanpEvKwZskgMqoHqPe5DWxL
         5DT92ZQgh7c/jC73fjnm3iXkjD5LikRFe375zAxiyyvr0+KiRZvXjmg4tKHqQtAzENvi
         RfcLK0wwYKN5JHqmA+uJeaSGEPjaPk+Sx1B90XahJg1DdUc4+NzcPpY5Vw2Z5BzBN/h+
         2SE5LHFVAdOJToYXcRiVfrjaZwgCY+w7t6tVK8+T7bnATNTmDD7jVgKb6K1SZqQEYXEW
         BklB6vGG4nzl6mS7dx9ZqQhdcWrZKpAXB1jpXp0phpjnzFXYyguQH79BQfixeX3OpLK8
         s4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVieDjcOPlDwMWacyjmdn5Ea+XftvKXSIfNSl3x5emSI8BgVYb/NiV4oGL4S6ugN5DKy5NIxu12uJDpcUcHMnRMr/gpCxRq9dodj2ax
X-Gm-Message-State: AOJu0Yw1VaPIRJBKvXZGYQ+FmO1Lf/PvBbZKoPTV3FEW7j/pOKJSlitI
	r542ohO3Wxf4xxNXoUMrhKDiT3XS+qY/e77t97jEoAEMae95FEGT4EJrVwl9nRJ5F7xMiFLwOUj
	J4fSQTuIRR5KZu2ZiyPu1ISrFCTqdJpb7EWrTEfravdRb4DjfVm2TImCw+tyoLQ==
X-Received: by 2002:a0c:aa5d:0:b0:68e:e9af:b5cd with SMTP id e29-20020a0caa5d000000b0068ee9afb5cdmr1524218qvb.23.1708004159877;
        Thu, 15 Feb 2024 05:35:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELJn6nDqy3rGV0OUx3SQIUtk6caCUWTq2dQf16nnwPm0wLSmDu/s/NDEDgzFQ1bmY42Q/rDw==
X-Received: by 2002:a0c:aa5d:0:b0:68e:e9af:b5cd with SMTP id e29-20020a0caa5d000000b0068ee9afb5cdmr1524204qvb.23.1708004159565;
        Thu, 15 Feb 2024 05:35:59 -0800 (PST)
Received: from debian (2a01cb058d23d60012146f54f8167b72.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1214:6f54:f816:7b72])
        by smtp.gmail.com with ESMTPSA id ld13-20020a056214418d00b0068f1237f904sm655637qvb.77.2024.02.15.05.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:35:59 -0800 (PST)
Date: Thu, 15 Feb 2024 14:35:55 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: Michal Ostrowski <mostrows@earthlink.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com" <syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] pppoe: Fix memory leak in pppoe_sendmsg()
Message-ID: <Zc4TOy4FPn1YaKb/@debian>
References: <20240214085814.3894917-1-Ilia.Gavrilov@infotecs.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214085814.3894917-1-Ilia.Gavrilov@infotecs.ru>

On Wed, Feb 14, 2024 at 09:01:50AM +0000, Gavrilov Ilia wrote:
> syzbot reports a memory leak in pppoe_sendmsg [1].
> 
> The problem is in the pppoe_recvmsg() function that handles errors
> in the wrong order. For the skb_recv_datagram() function, check
> the pointer to skb for NULL first, and then check the 'error' variable,
> because the skb_recv_datagram() function can set 'error'
> to -EAGAIN in a loop but return a correct pointer to socket buffer
> after a number of attempts, though 'error' remains set to -EAGAIN.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


