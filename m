Return-Path: <linux-kernel+bounces-32317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98FA8359FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080C21C213A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990E45240;
	Mon, 22 Jan 2024 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ealvJ81/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3445221
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896790; cv=none; b=VnAjEIMra0QszEsK/QpHucKbhD3fe5fOmTAEsNSiUIe8/gc9XHMXr4EootHuwCIrAN8Yi4aBX9EpsblTGOJ5E8VrdF/mtVSTytFijRlrOqHJOppmHy03b41G3WczvENv8njWDZaISfhA0ij9+2pVS5S9De7Qs9QS6b6f3y+pWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896790; c=relaxed/simple;
	bh=od+8DOkUnVAgYBK9LoM9tr2QwuVYSslesQSRWHme8E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ME4V0TBmvy972oekkE9H7mS5gBRpRzB3jYB0RLXOfjJ99AjqrU/YEhgk3bbZYRPMm+yKu8Qj0nypP0v29YR0nZhjkZ4Q5pB3j7hWi4SH+t4KYfzTlogxIV7sm3gsrHWXCZL6TVMF2yBTImPAmvKK/H4+/LsDb0anSihLNPk2aFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ealvJ81/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705896788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFYZB1OK0jELPTabxPuV0ZEWUgH0u/k7Ra6Xc9f/czc=;
	b=ealvJ81/IM6XUWpBAyPaEP/E25aRvREZad+Ewghap7ghZrj/8/KmrH0h8IBhmnqsysFBZp
	s3sSif/8eBfbOGwQkEuNvb/lW/OzTqzwtZ4FUxruIhVlBjDMI61/0FcBcvjLdIAdRDDRYq
	3Qp8NYbK1s8swqo24Pnm/c+kOnywlOc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-znO1VQpgMN6GfJ8D8hTFOA-1; Sun, 21 Jan 2024 23:13:06 -0500
X-MC-Unique: znO1VQpgMN6GfJ8D8hTFOA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6da0d1d6674so4267750b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705896785; x=1706501585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFYZB1OK0jELPTabxPuV0ZEWUgH0u/k7Ra6Xc9f/czc=;
        b=D7cTk6fHK2a3qX2UDgGzuj7ZxmOc7SqWIDHWCP6hKIk7qp0ZX7J8drl7Y90EXmlftP
         pG2fK6KKIxEP3ISfDBlN4RUbzVCer+L9XKT/RVIHZYzxVpYc6AlHKdBKO9+BiWJ4tbIp
         t5s33zyZUFhtxCB2mqtNpxo57dzrX0t724Rb6vnrTvy1DsasDIjuqQSO9JzNmb5MjuiH
         gcU5D9kHq25Hr56ZKECO1mzNfic3VW2CvgqoFnP+qUnAQlM4O97MuPqYrQd+dx+8oR/F
         ZAuosMEOo0inIdl/xK79L6CE0IToBsGkLBE8bpetUXT9xchDB22Dr8ahLVh4tTg5zOz6
         zbnA==
X-Gm-Message-State: AOJu0YwLa+MRDuwVhzjuKBKtq+4PUN/rXSEIg4sl6r3/TYMwKqzOn3Eg
	Q0M9VxnSEz07VkFEUlQCQjIRiDZbhOjWDfJebPkPt1o3h9qKLqfkUqxbBSs1rB+ANBChmKGURGs
	u4DK+2CUSsKJv+zr4reH8jNEFwHETsNX3gyqa7HZjNDM3J5I29KfDadADpXGZNeRQJ47MF66I/N
	mMQ5H81KaTfxDCZAUO8VM0FRzaenk2wfWP0xr6
X-Received: by 2002:a05:6a00:cca:b0:6db:dd0e:8d6c with SMTP id b10-20020a056a000cca00b006dbdd0e8d6cmr2338372pfv.50.1705896785533;
        Sun, 21 Jan 2024 20:13:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw6L7G8t4oEO9wMWCBYZqdoa5n5KMgma3CQ7su1LP6qvgNWE1mvqDtNGJ2VEeIUfZzPuoLjHMkocgktDrNNwA=
X-Received: by 2002:a05:6a00:cca:b0:6db:dd0e:8d6c with SMTP id
 b10-20020a056a000cca00b006dbdd0e8d6cmr2338366pfv.50.1705896785313; Sun, 21
 Jan 2024 20:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:12:54 +0800
Message-ID: <CACGkMEsSjtkYk3++aqmPxrivrDzyGxNumiancRxAfY=7D3SsiA@mail.gmail.com>
Subject: Re: [PATCH V1] vdpa_sim: reset must not run
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:23=E2=80=AFAM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> vdpasim_do_reset sets running to true, which is wrong, as it allows
> vdpasim_kick_vq to post work requests before the device has been
> configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_OK
> is set.
>
> Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


