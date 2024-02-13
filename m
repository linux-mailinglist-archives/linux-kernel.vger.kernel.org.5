Return-Path: <linux-kernel+bounces-63491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A6853051
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527F91F29EED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BD93B19E;
	Tue, 13 Feb 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdS4mjio"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D037706
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826483; cv=none; b=P1ByKlip27jR4qMiqMsypMepdz57AM7NG5LO41RJsDtkO+bEQW6/XSsedwJYXG1WWv9T3hR727zlL/r12VAZOSAlikbrdFmOo7Ud8dQI7jOpbVxPOZTNjJY4iKCDNtuFKbuhGSjlAevQmzZPOriX+YMpmGV0vgLRh0dM9u0Wa94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826483; c=relaxed/simple;
	bh=PV/2CH8eMrpfZzKtcV9grh3JUO5lmB/8PaohWZVhuG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmaSkhYDNSaOM007mWSuY+1xncaq+gPPLJ6B50FbI0eV6PTm+Ib8e2Q8XwVph1185bSHuYVy1HMdTYBaMq6i0OkSRzS9LQUMR/3G0+EaM93GeBTsDVJmMnRznSnZqSboxxFs3y08HvHwQcDdF01b8Qima2MkOdZM9/+Clnqy4tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdS4mjio; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707826480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PV/2CH8eMrpfZzKtcV9grh3JUO5lmB/8PaohWZVhuG0=;
	b=ZdS4mjiotGAIUK6KiA7Zv6/2F6qboPg+vp3RJ0On11AFfBUvozEZYXRt5BPa6dAGxOBiQ2
	VW8EUC5JAOVaZ6Ar9EZIKY+zLDpK42jQSnwgm59kQm2lQo9ZSdscxIJ1/Zjx3n3Z0d7Hba
	3X4c03/z2BXeQbTr+P9d26H2dbhytGI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-XZwEKrBUNfaZFQM2VLgJeA-1; Tue, 13 Feb 2024 07:14:39 -0500
X-MC-Unique: XZwEKrBUNfaZFQM2VLgJeA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6818b8cb840so16923086d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707826479; x=1708431279;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PV/2CH8eMrpfZzKtcV9grh3JUO5lmB/8PaohWZVhuG0=;
        b=xO7ZJqOOsrm/beGsg1ZK112bjX3xCPWTkJbSmvUfXaBBa3v1FP9eE7SAD2Gl2bRVoQ
         StSbzGEhL6kaPe54iF33uNMN2o5UUWe3W1TAEdp7hee76IY1Rrd0GbPu5o8Y79WQuIpK
         POe4Ng8NALezyAfuRZ5pOYQ1QU6BKif8BXh8POD2UlJwuBhohTuOs91j69aE4DREhhrN
         OhvAtCXhxj3QInx2bstlIInZj4HsAUHdZ52AX3lCmqyzPp7MDF74z2q1ebFvXrfB4yeU
         7SASehzAtEuxqh5PnPff4HXucT/0cCD3xYvLtyFD7FciF3O6OS1DS0X2kjl//dVBQ+sq
         CJrA==
X-Forwarded-Encrypted: i=1; AJvYcCUThULblh1R7YtS4zV3/N1lwRLjbreUyPl9bKRTjuwZIHYHRyAIBT//Twjxb8I9a7z+xwJDH85HNbAanv3022+t0RtWoAmS8ow224hi
X-Gm-Message-State: AOJu0YzScTObmhobJ8w2rATxaK+wu8jJ4a74nuHEKp1E4uugFwByeicf
	QVVIbf22WK1OPaZNDb5LPy7KvwfU+6sCq2vdu725/SN05p3y7aZd77tXT4QpsU/vyzyua+27/d/
	z2KSMNkZ2s5S5VhssR6SVopFMgHLv2zJr6l9sssJpcmKlpxt2VwzjTy+CGRvofQ==
X-Received: by 2002:ad4:4ea4:0:b0:68e:f8b6:1e2a with SMTP id ed4-20020ad44ea4000000b0068ef8b61e2amr203089qvb.2.1707826479191;
        Tue, 13 Feb 2024 04:14:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGswwHbb1rCwPJLSk4gzJYYn9PIlHqXcuRECFHVi6AMtML9HJBPAxRWT9wp3UvywjHx97czLw==
X-Received: by 2002:ad4:4ea4:0:b0:68e:f8b6:1e2a with SMTP id ed4-20020ad44ea4000000b0068ef8b61e2amr203068qvb.2.1707826478860;
        Tue, 13 Feb 2024 04:14:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9mfZbvt3+FfOAGT/M7JqCNSdHF2CynGGfILKrq2b7nPXx9N/eDrWWrtOMP7TdG6LxPgnwTCjHjckqdcvBthh/f6k1ujGqgw848LfyKDWsKJZFL/MdHcwdzA3x1uJLngC+DNV3XWRtd2AzBURsSXNulLcZA3kzB/DKeRWfT9lC1lKKIknbMWAE3GQD35cBoMps7ZAhlBDb6y3Fo6o=
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id bt8-20020ad455c8000000b0068cc1bba1d6sm1182606qvb.145.2024.02.13.04.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:14:38 -0800 (PST)
Message-ID: <d64c2e241688f77a7a063b3f871f375ebc02be57.camel@redhat.com>
Subject: Re: [PATCH 2/2] phonet/pep: fix racy skb_queue_empty() use
From: Paolo Abeni <pabeni@redhat.com>
To: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>, 
 courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Feb 2024 13:14:36 +0100
In-Reply-To: <20240210125054.71391-2-remi@remlab.net>
References: <20240210125054.71391-1-remi@remlab.net>
	 <20240210125054.71391-2-remi@remlab.net>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-10 at 14:50 +0200, R=C3=A9mi Denis-Courmont wrote:
> From: R=C3=A9mi Denis-Courmont <courmisch@gmail.com>
>=20
> The receive queues are protected by their respective spin-lock, not
> the socket lock. This could lead to skb_peek() unexpectedly
> returning NULL or a pointer to an already dequeued socket buffer.
>=20
> Signed-off-by: R=C3=A9mi Denis-Courmont <courmisch@gmail.com>

Please provide a suitable fixes tag here.

Also include the target tree into the subj prefix when you post the v2.

Thank,

Paolo


