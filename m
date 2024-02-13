Return-Path: <linux-kernel+bounces-63490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F43F85304E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1852328B5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DD83D0BA;
	Tue, 13 Feb 2024 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWEjHyk3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B073A1CA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826385; cv=none; b=j6rpctZdGZPqtSNpGYOF86ffTglsYljXXOPEWLpADyVsW9s6+BX+yTL3CFgzPoWSgGMHeqTLc0oeou59ABvf61xKaYQ9jbeKPlDwYMDGPI73sxphGvKWFmyw3ZnspqbUkFHg1V5+tfk/8udu18yYtwUbjiVePHT6OTltzMbVgBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826385; c=relaxed/simple;
	bh=ocOp3NXy18DTHW7ePcFwHH1PrpIpqsJXfEHnVft2QcM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxPqV8al4rUklYBr3t2bc7b6mLuIuRvZwJNFkw73G9gwrkQcQNV7fY8aYk4rSipIOHoHDeJFzknwk9kK9OWboGyKQ7q7CyHJPImpP1OHhKxKAQG5KPVlKbkVRbSs5CYGM3zExIYclJ7ryFuIjnZbXq9OohqrM89vUBfz+3d1iA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWEjHyk3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707826382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ocOp3NXy18DTHW7ePcFwHH1PrpIpqsJXfEHnVft2QcM=;
	b=HWEjHyk3EDNLCBKQg8nQDPQp4e3wP5Q7Y741H022B44GETrHySg/mtWSv7kft6a6q+Tcn1
	QP3v2lRCJEICsxDDTZNpHUcV0D5QiH58xH4ybdgrtMCq5OVWnKs7cbsyV2eoInPbdJDR89
	1oF2Ofjwy+JED5LSDl19RNkM96EcQEQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-wg42P1BYMYems61wD3uJtg-1; Tue, 13 Feb 2024 07:13:00 -0500
X-MC-Unique: wg42P1BYMYems61wD3uJtg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7871814d5ddso17259685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707826380; x=1708431180;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocOp3NXy18DTHW7ePcFwHH1PrpIpqsJXfEHnVft2QcM=;
        b=VgNDtwj92G9WMJL/c2miDA+6HuNB+lKtL8O1Ni0Vk7QgoR+6HEiR4ViXGM+EdtGbzQ
         OW96efxlXDBCsHzgwZK3awO3dZHZtV/AccFw9/49s2LRlK6qEo+FDkj3dxruXtgqd+T6
         DakwZq1aiB4v3HbnuNfXO5qKM2BR2fJ5DGCbjdQxbr0rXqOLryFGE6iLX1QzIG2H5yCJ
         StAyjum7DaV1NHqVKcGwSsTEfXFLXHMAtu/88nBjfEXI6DDU2/yOn4kHn3mo+Qbga08i
         tm40o8N7WpMmEhkAbwxBZ794FXJ4+OO3l5LphQGIbfUKPmfWVhAIa5nIoJzPk6YLQIFq
         hVuA==
X-Forwarded-Encrypted: i=1; AJvYcCUlvun5eshaWxILKPGHNsadtv2s6Vmgf/pVvDfTgUCJsPNJaSIstLGr3/bUBKn0ijTA/T7tDF8CLEpwvgM4jFR1UuF2i+Ix/SI8vYaf
X-Gm-Message-State: AOJu0Yx19pupeRNJvOmS3BsnbJIFTnLoYtZvpBLZgN9j76P61McwenHF
	2WHHicw7ZhJcEfCcHaKRsj+I0UYrhrx4ArMe0TkphuZsR/yXVUucLVitMqYp/Mxjf8F4P4FmDl0
	3ybgVVF1jKgjRnufAXjgB4WBMN9VqaMzqjjnfkDpqErgrZNKS/10fYL6mZwyohA==
X-Received: by 2002:a05:620a:6845:b0:787:2405:cb36 with SMTP id ru5-20020a05620a684500b007872405cb36mr391303qkn.0.1707826380239;
        Tue, 13 Feb 2024 04:13:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK5iRPl8EaC/3FQaIFcXUc8/fIEH9NrPgvI4hGZnNcTTBOerMkqTmTuwjxdq1hxc3Asa8d3g==
X-Received: by 2002:a05:620a:6845:b0:787:2405:cb36 with SMTP id ru5-20020a05620a684500b007872405cb36mr391278qkn.0.1707826379878;
        Tue, 13 Feb 2024 04:12:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCxXuK8mP2baCfZSfem4loFLSK/tOZJAWtZzBt6LzxG2F7fA1sQlZ1VRsjsg2vJU0vEMJajdOaNHXglqkSeJZeBlrjexIHTAxLoCJaBOzIG1UUfztPiS6mNaAPUqM3MTWEsu2GFebK2C1QB+FkvGJfpJmbllA/yYBFxFCkYceBsG9wGEW3hqj/XyyP0sz+8WmLAiIsIc9h8PEDG0o=
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id da54-20020a05620a363600b007859fbc2e38sm2901913qkb.18.2024.02.13.04.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:12:59 -0800 (PST)
Message-ID: <9c03284dedb5559de0b99fde04bc3e19b5027d6f.camel@redhat.com>
Subject: Re: [PATCH 1/2] phonet: take correct lock to peek at the RX queue
From: Paolo Abeni <pabeni@redhat.com>
To: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>, 
 courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Feb 2024 13:12:57 +0100
In-Reply-To: <20240210125054.71391-1-remi@remlab.net>
References: <20240210125054.71391-1-remi@remlab.net>
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
> Reported-by: Luosili <rootlab@huawei.com>
> Signed-off-by: R=C3=A9mi Denis-Courmont <courmisch@gmail.com>

Looks good, but you need to add a non empty commit message. Even
something quite similar to the one included in patch 2/2.

you can retain Eric's ack when post v2.

Pleas also include the correct fixes tag.

Thanks

Paolo


