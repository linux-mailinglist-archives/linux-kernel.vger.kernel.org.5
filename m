Return-Path: <linux-kernel+bounces-92030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D58719F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1321F21C20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E1A537E5;
	Tue,  5 Mar 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Np0ib0km"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C1535C7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632306; cv=none; b=pLg9GmEjsEp6auEmNeVjkOGJvnXEubkCnEt8xE+B42icNZzWBq/aOTwuv4/DoRMAbrm+Rq/r2G7rFJ4/CdQN7Qsxg26LE0RnJhEsk4ezfDeMwrduIxeDXkbASKCifh2+onGAS6EBzneDMmvMOllVsuiTHRdF5xEZI2+EF3ns3J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632306; c=relaxed/simple;
	bh=sdaz3up7hOyRJltiuAjQ+owmODJPp8utjvBWVYBhW5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Szrl16t2fP3dtC/x2+fjxPbeVD6+WdICl+Z9szNpmSLqN1M+zZHAnzLY9kIR0qAqYuV//rXQoVIq/hKvKogAyeJQm6/tW/639acYn5yT3KzWXOVPD/1kRRoZLA96yNDaIA2MrCkrD87EzKwhbXjTj09LNZLU9mt3kHNmK3qHBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Np0ib0km; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709632303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sdaz3up7hOyRJltiuAjQ+owmODJPp8utjvBWVYBhW5A=;
	b=Np0ib0kmF+cOpmy91I+ChMEKzvYDU3tV31+9AxG5Jt0VDM2jfC9PZFnHCgViBcXvZ87ZX0
	ejOafSgw/JkrbcYYT0trvBge1SoXm+F/PveE9bOgEevgiWrSrJbpjL2uE87ze8AJcf3hmQ
	M1KIrDZd/aR0fGszvKEUGZnxl+vEy28=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-sxloAqQQPjKonCHl8_8Kmg-1; Tue, 05 Mar 2024 04:51:41 -0500
X-MC-Unique: sxloAqQQPjKonCHl8_8Kmg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33dd1c59918so520010f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709632300; x=1710237100;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdaz3up7hOyRJltiuAjQ+owmODJPp8utjvBWVYBhW5A=;
        b=lHfJVDMoQmPYHw8cG3h50+ggH497f8WlM05UAVEZuPk0/sWFV9WvDIY/VUE/nzS5eL
         l3AVuFk5oGO7EWC4dyTiItXcQwk2XS4xoc/iqMBlreOUSJ/j71l6SFF8KjkZH1MiOtLd
         yMB8YLXCKao5SA+ZAm3EyEYqMqK089uZxzDtV7iDPy7LdIlOMQEq5thyNW41nody9y8W
         I4TDvHHV3mnlIWKwqKAfYg7LEuwDdlDUPolyumXY7fGWrcfkphbetEmzi9k+oNt2NrXc
         8fwJHtllujBbSy148ITwlBqk6fVjH+zc9j5RsH/1/r9XKFn1n4sJinUvVe8GC7DNgCgm
         Rhmw==
X-Forwarded-Encrypted: i=1; AJvYcCWvwLZ4tw44NvYROJrP7AawpxiaFvqcIvJj5vDs8Vy+FGQc4iLJPyqC1h/1ccRlEVXZTeOconiSO7Fkh8aQdfONjNatFZ68qi6XpBd2
X-Gm-Message-State: AOJu0Ywpunfp/WKbso9oE8oRqbUmLa8OA95bZnt/V+IATv8wZyUKySRs
	KXsOCf/44ciuI06/Bug34B6gvr07jC3sqYfTd955Q84SsFeVXNQWDOBu/hEejTahnQ3aW53Cd0Q
	bi0JcwB7OUS+cDhXcTeH8l+cwa1qN8zS6+HC2Meml9fLIdy8ga8Owwus+MeP8CQ==
X-Received: by 2002:adf:d047:0:b0:33d:a6e8:4f7d with SMTP id v7-20020adfd047000000b0033da6e84f7dmr7757853wrh.3.1709630502099;
        Tue, 05 Mar 2024 01:21:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLvls29OMwUY36YbYsmwrHj7PM4I9ffDFEulZv3Bqcta1qZMkkko0NuH2kGJTPQD+NgR69og==
X-Received: by 2002:adf:d047:0:b0:33d:a6e8:4f7d with SMTP id v7-20020adfd047000000b0033da6e84f7dmr7757827wrh.3.1709630501765;
        Tue, 05 Mar 2024 01:21:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id bo16-20020a056000069000b0033e422d0963sm3920276wrb.41.2024.03.05.01.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:21:41 -0800 (PST)
Message-ID: <65c3503409c0e1670bdf06fecfd58ec483a114b9.camel@redhat.com>
Subject: Re: [PATCH net-next v6 5/5] tools: virtio: introduce vhost_net_test
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 virtualization@lists.linux.dev, Yunsheng Lin <linyunsheng@huawei.com>, 
 davem@davemloft.net, kuba@kernel.org
Date: Tue, 05 Mar 2024 10:21:40 +0100
In-Reply-To: <20240228093013.8263-6-linyunsheng@huawei.com>
References: <20240228093013.8263-1-linyunsheng@huawei.com>
	 <20240228093013.8263-6-linyunsheng@huawei.com>
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

On Wed, 2024-02-28 at 17:30 +0800, Yunsheng Lin wrote:
> introduce vhost_net_test for both vhost_net tx and rx basing
> on virtio_test to test vhost_net changing in the kernel.
>=20
> Steps for vhost_net tx testing:
> 1. Prepare a out buf.
> 2. Kick the vhost_net to do tx processing.
> 3. Do the receiving in the tun side.
> 4. verify the data received by tun is correct.
>=20
> Steps for vhost_net rx testing:
> 1. Prepare a in buf.
> 2. Do the sending in the tun side.
> 3. Kick the vhost_net to do rx processing.
> 4. verify the data received by vhost_net is correct.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

@Jason: AFAICS this addresses the points you raised on v5, could you
please have a look?

Thanks!

Paolo


